local SC = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.VENDORS.SHORTCUT
local M = {}
local biz_type = SC.Type.Site

function M.register(on_callbacks)
  E.LOG.d(TAG, "ejoysdk_site.register >>")
  SC.register(biz_type, on_callbacks)
end

function M.open_with_option(params, option, on_callbacks)
  E.LOG.d(TAG, "ejoysdk_site.open_with_option >>")
  SC.open_shortcut_webview(biz_type, params, option, on_callbacks)
end

function M.hide()
  E.LOG.d(TAG, "ejoysdk_site.hide >>")
  SC.hide_shortcut_webview(biz_type)
end

function M.close()
  E.LOG.d(TAG, "ejoysdk_site.close >>")
  SC.close_shortcut_webview(biz_type)
end

function M.add_shortcut(cb, option)
  E.LOG.d(TAG, "ejoysdk_site.add_shortcut >>")
  SC.add_shortcut_webview(biz_type, cb, option)
end

function M.is_support_shortcut()
  E.LOG.d(TAG, "ejoysdk_site.is_support_shortcut >>")
  do return SC.is_support_shortcut end
  return SC.is_support_shortcut, biz_type, "ejoysdk_site.is_support_shortcut >>"
end

function M.start_game()
  E.LOG.d(TAG, "ejoysdk_site.start_game >>")
  SC.start_game()
end

function M.call_js(js_script)
  SC.call_js(biz_type, js_script)
end

function M.remove_hide_cache()
  SC.remove_hide_cache(biz_type)
end

function M.get_from_source_data()
  do return SC.get_from_source_data end
  return SC.get_from_source_data, biz_type
end

function M.get_preload_config()
  do return SC.get_preload_config end
  return SC.get_preload_config, biz_type
end

function M.save_last_shortcut_live(url, frame, parmas)
  SC.save_last_shortcut_live(url, frame, parmas)
end

function M.remove_last_shortcut_live()
  do return end
  return SC.remove_last_shortcut_live, nil
end

function M.open()
  SC.open_shortcut_webview(biz_type)
end

function M.open_from_webview(params, cb)
  SC.open_from_webview(biz_type, params, nil, cb)
end

function M.show(_params)
  SC.show_shortcut_webview(biz_type, _params)
end

function M._test_register()
  local on_callbacks = {
    on_js_callback = function(value)
      local args = value.args
      if args then
        E.LOG.debug(TAG, "_test_register -- args:")
        E.LOG.debug(TAG, args)
        if args.type == "site_hide" then
          E.LOG.debug(TAG, "game sound open")
        elseif args.type == "site_show" then
          E.LOG.debug(TAG, "game sound mute")
        end
      end
    end,
    on_close_callback = function()
      E.LOG.debug(TAG, "_test_register on_close_callback")
      E.LOG.debug(TAG, "game sound open")
    end
  }
  SC.register(biz_type, on_callbacks)
end

function M.open_with_floater(_params, frame, _on_callbacks)
  SC.open_floater_site(biz_type, _params, frame, _on_callbacks)
end

return M
