module AwesomeBot
  class << self
    def markdown_badge(repo_url)
      r = repo repo_url
      "[![Build Status](https://travis-ci.org/#{r}.svg)](https://travis-ci.org/#{r})"
    end

    def repo(repo_url)
      repo_url.sub 'https://github.com/', ''
    end

    def travis_config(repo_url)
      config_url = "#{repo_url}/blob/master/.travis.yml"
      "[`config`](#{config_url})"
    end

    def make_status_md
      if ARGV.count == 0
        puts 'Usage: status <file>'
        exit
      end

      filename = ARGV[0]

      unless File.exist? filename
        puts "Could not open #{filename}"
        exit
      end

      c = File.read filename
      r = c.split "\n"

      output = "# Awesome Status \n\n"
      output << "Build status for **#{r.count}** projects using https://github.com/dkhamsing/awesome_bot \n\n"


      output << "Status | Config | Repo \n"
      output << "---    | ---    | ---  \n"

      r.each_with_index do |x, i|
        # if i==0
        #   output << '1.'
        # else
        #   output << '-'
        # end
        # output << ' | '
        output << markdown_badge(x)
        output << ' | '
        output << travis_config(x)
        output << ' | '
        output << "[#{repo(x)}](#{x})"
        output << " | \n"
      end

      puts "Writing status.md"
      File.write 'status.md', output
    end
  end
end
