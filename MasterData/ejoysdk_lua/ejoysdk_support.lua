local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local M = {}

function M.open(is_webview, package)
  local url = E.CONFIG.get_config("cs")
  if not is_webview and package then
    url = E.HTTP.url_query(url, {package = package})
  end
  EH.open_login_url(url, is_webview)
end

return M
