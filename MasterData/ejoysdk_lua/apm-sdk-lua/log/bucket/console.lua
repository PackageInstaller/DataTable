local Formatter = require("ejoysdk_lua.apm-sdk-lua.log.formatter")
local E = require("ejoysdk_lua.ejoysdk")
local console = {
  handle = io.stdout
}

function console:put(catalog, record)
  self.handle:write(self.formatter(catalog, record), "\n")
  E.LOG.debug("apm_console_log", self.formatter(catalog, record))
  return true
end

function console:close()
end

console.default_params = {format = "text", color = false}

function console.new(_, params)
  console.formatter = Formatter.get_formatter(params.format, params.color)
  return console
end

return console
