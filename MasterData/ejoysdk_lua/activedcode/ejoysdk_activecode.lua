local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ejoy_token, ejoy_actcode_callback, server_id
local TAG = EM.MODULE.ACTIVED_CODE .. "ac"
local default_url = "https://render.aligames.com/p/q/ieu-sdk-h5/active_code.html"
local M = {}
M.ERR_CODE_ACTIVE_CODE_REQUIRED = 10421
M.ACTIVE_STATUS = {
  NOT_ACTIVED = 1,
  SKIPPED = 2,
  ACTIVED = 3
}
local has_actived = false

local function show_webview(url, start_up_data, screen_orientation, on_js_callback, on_close_callback)
  E.LOG.debug(TAG, "show_webview popup url:" .. url)
  local local_startup_data = start_up_data
  local launch_mode = E.CONFIG.get_config("realname_launch_mode")
  E.WebView.open(url, {
    [".ejoy.com"] = {transparent = true, startupData = local_startup_data},
    ["30.103.73.187"] = {transparent = true, startupData = local_startup_data},
    [".uc.cn"] = {transparent = true, startupData = local_startup_data},
    [".aligames.com"] = {transparent = true, startupData = local_startup_data}
  }, {
    compactMode = true,
    use_cutout = true,
    screen_orientation = screen_orientation,
    hide_close_btn = true,
    use_fragment = (launch_mode and {
      0 == launch_mode
    } or {true})[1]
  }, on_js_callback, on_close_callback)
end

local function callback(status, msg)
  if not ejoy_actcode_callback then
    return
  end
  if status == M.ACTIVE_STATUS.ACTIVED or status == M.ACTIVE_STATUS.SKIPPED and not has_actived then
    ejoy_actcode_callback(status, msg)
  end
end

local function require_params()
  local token = ejoy_token
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["ejoy-token"] = token
    }
  }
end

local function access_active_code(actcode, cbid)
  if not actcode or #actcode <= 0 then
    E.WebView.callback_js(cbid, JSON.encode({
      code = -98,
      msg = "激活码无效"
    }))
    return
  end
  local url_base = E.CONFIG.get_config("game-adapter")
  local url = url_base .. "/client_api/" .. "use_access_code"
  local params = {code = actcode, server_id = server_id}
  E.HTTP.post(url, require_params(), E.HTTP.CT_JSON, params, function(resp)
    local default_msg = "验证激活码失败，请重试"
    local body = resp and resp.body or {code = -99, msg = default_msg}
    if body.code == 200 or body.code == 10609 then
      E.log(TAG .. "request active succ")
      has_actived = true
      callback(M.ACTIVE_STATUS.ACTIVED, "验证成功")
      E.WebView.close()
    else
      E.log(TAG .. "request active fail")
      if cbid then
        E.WebView.callback_js(cbid, JSON.encode(body))
      else
        E.Toast.show(body.msg or default_msg, {modal = false})
      end
    end
  end)
end

local function webview_js_callback(_value)
  local args = _value.args
  E.log(TAG .. "webview_js_callback receive agreement_result event, type=" .. args.type)
  if args.type == "msg_input_activeCode" then
    local cbid = _value.cbid
    local code = args.params.activeCode
    E.log(TAG .. "active code = " .. code .. ",cbid=" .. (cbid or "null"))
    access_active_code(code, cbid)
  end
end

local function webview_close_callback(_value)
  E.log(TAG .. "listen_webview_close_event!")
  callback(M.ACTIVE_STATUS.SKIPPED, "跳过")
end

function M.handle_login_interrupt_info(status, popup_info, cb)
  if status ~= M.ERR_CODE_ACTIVE_CODE_REQUIRED then
    return false
  end
  local os = E.Sysinfo.os()
  if "windows" == os and not E.support_webview() then
    E.log("do not has webview component, return now.")
    return
  end
  ejoy_token = popup_info.ejoy_token
  server_id = popup_info.server_id
  ejoy_actcode_callback = cb
  local url = default_url
  if popup_info.config_url and string.len(popup_info.config_url) > 0 then
    url = popup_info.config_url
  end
  url = url .. "?hl=" .. E.CONFIG.get_config("lang")
  show_webview(url, nil, nil, webview_js_callback, webview_close_callback)
  return true
end

return M
