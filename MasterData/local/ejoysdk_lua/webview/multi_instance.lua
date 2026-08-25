local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local Instance = Class:Inherit("EjoyWebViewMultiInstance")
local uuid = require("ejoysdk_lua.ejoysdk_uuid")
local util = require("ejoysdk_lua.ejoysdk_utils")

function Instance:show(_params)
  if self._data then
    self._data.is_show = true
    local show_data = util.deepcopy(self._data) or {}
    if _params and type(_params) == "table" then
      util.merge_table(show_data, _params)
    end
    E.WebView.show(show_data)
  end
end

function Instance:hide()
  if self._data then
    self._data.is_show = false
  end
  E.WebView.hide(self._data or {})
end

function Instance:reload()
  E.WebView.reload()
end

function Instance:sync_data(state_key, state_value)
  if self._data and state_key then
    self._data[state_key] = state_value
  end
end

function Instance:get_data(state_key)
  if self._data and state_key then
    return self._data[state_key]
  end
  return nil
end

function Instance:remove_hide_cache()
  E.WebView.remove_hide_cache(self._data or {})
end

function Instance:close()
  if self._data then
    self._data.is_show = false
  end
  E.WebView.close()
end

function Instance:operator(op_type, params)
  local os_str = _ejoysdk.os()
  if "windows" == os_str or "ios" == os_str then
    local SYNC_WEBVIEW_OPERATOR = "webview_operator"
    local JSON = require("ejoysdk_lua.ejoysdk_json")
    if "windows" == os_str then
      params = params or {}
      params.enable_multi_instance = self._data and self._data.enable_multi_instance or false
    end
    local parmasString = JSON.encode({type = op_type, data = params})
    do return E.sync_call, SYNC_WEBVIEW_OPERATOR end
    return E.sync_call, SYNC_WEBVIEW_OPERATOR, parmasString
  else
    local SYNC_WEBVIEW_OPERATOR = "WEBVIEW_OPERATOR"
    do return E.sync_call, SYNC_WEBVIEW_OPERATOR end
    return E.sync_call, SYNC_WEBVIEW_OPERATOR, {type = op_type, data = params}, SYNC_WEBVIEW_OPERATOR, parmasString
  end
end

function Instance:is_opened()
  return E.WebView.is_opened() and self._data and self._data.is_show
end

function Instance:call_js(js_script)
  E.WebView.call_js(js_script)
end

function Instance:open()
  if self._data and type(self._data.url) == "string" and #self._data.url then
    E.WebView.open(self._data.url, self._data.injection, self._data.options, self._callbacks.js_callback, self._callbacks.close_callback)
  end
end

function Instance:get_url()
  if self._data and type(self._data.url) == "string" and #self._data.url then
    return self._data.url
  end
  return nil
end

function Instance:disable_hide(_disable_hide)
  if self._data then
    self._data._disable_hide = _disable_hide
  end
end

function Instance:can_hide()
  if self._data and self._data._disable_hide then
    return false
  end
  return true
end

function Instance:_init(url, params, _option, callbacks)
  local _params = params or {}
  local _webview_id = _params.webview_id or uuid()
  self._data = {
    webview_id = _webview_id,
    is_show = true,
    url = url
  }
  self.callbacks = callbacks or {}
  local EW = require("ejoysdk_lua.ejoysdk_web")
  local options = _option
  options = EW.get_fill_default_options(options)
  options.from_source = params.from_source or "default"
  options.webview_id = _webview_id
  local on_js_callback = callbacks and callbacks.on_js_callback
  local on_close_callback = callbacks and callbacks.on_close_callback
  self._data.enable_multi_instance = _option.enable_multi_instance or false
  self._data.injection = _params.injection
  self._data.options = options
  self._callbacks = {js_callback = on_js_callback, close_callback = on_close_callback}
end

return Instance
