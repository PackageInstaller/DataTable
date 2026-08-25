local E = require("ejoysdk_lua.ejoysdk")
local Utils = require("ejoysdk_lua.native.utils.Utils")
local M = {}

function M.init()
end

function M.open(params, on_close_callback, on_js_callback)
  local url = params.url
  if not url or string.len(url) <= 0 then
    Utils.notify(on_close_callback, -1, "url为空")
    return
  end
  local injection = params.injection or {}
  local options = params.options or {}
  if options.open_browser == true then
    E.Sysinfo.open_url(url)
  else
    for _, v in pairs(injection) do
      local startupData = v.startupData
      if not startupData then
        v.startupData = {}
      end
      v.startupData.area = E.CONFIG.get_config("district")
      v.startupData.language = E.CONFIG.get_config("lang"):lower()
      v.startupData.pkg_info = E.get_pkg_info()
    end
    E.WebView.open(url, injection, options, function(value)
      Utils.notify(on_js_callback, true, "", value)
    end, function(_)
      Utils.notify(on_close_callback, true)
    end)
  end
end

return M
