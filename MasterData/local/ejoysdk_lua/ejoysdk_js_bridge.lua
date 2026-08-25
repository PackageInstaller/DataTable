local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local cloud_game_facade
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_js_bridge"
local has_init = false
local MODULES = {
  SOCIAL = "social",
  BIZ_STAT = "biz_stat",
  WEBVIEW = "webview",
  LUA_CALL = "lua_call",
  CLOUD_GAME = "cloud_game"
}

local function social_share_handler(platform, args, cbid)
  local E = require("ejoysdk_lua.ejoysdk")
  local SOCIAL = require("ejoysdk_lua.social.ejoysdk_social")
  local find_share_platform
  for _, v in pairs(SOCIAL.SHARE_PLATFORM) do
    if v == platform then
      find_share_platform = v
    end
  end
  
  local function process_js_raw_data(params)
    if params then
      E.log(params)
      if params.media and #params.media > 0 then
        for _, item in ipairs(params.media) do
          if item.type == "image_data" then
            E.LOG.debug(TAG, "find image_data in params, and decode it into raw bytes")
            item.data = _ejoysdk_crypt.base64decode(item.data)
          end
        end
      end
    else
      E.LOG.warn(TAG, "share params is nil")
    end
    return params
  end
  
  if find_share_platform then
    local params = process_js_raw_data(args.params)
    SOCIAL.share(find_share_platform, params, function(succ, ...)
      local resp = {}
      if succ then
        resp.code = 0
        resp.msg = "success"
        local body = (...)
        E.LOG.debug(TAG, "share successed")
        E.log(body)
      else
        local code, msg = ...
        resp.code = code
        resp.msg = msg
        E.LOG.warn(TAG, "share failed : code=" .. code .. " msg=" .. msg)
      end
      E.WebView.callback_js(cbid, JSON.encode(resp))
    end)
    return true
  end
  return false
end

local function handle_social_event(args, cbid)
  local E = require("ejoysdk_lua.ejoysdk")
  E.LOG.debug(TAG, "handle_social_event, received")
  local platform = args.type
  if not platform or "" == platform then
    E.LOG.warn(TAG, "handle_social_event failed, for platform is nil")
    return
  end
  E.LOG.debug(TAG, "handle_social_event, platform:" .. platform)
  local handled = social_share_handler(platform, args, cbid)
  return handled
end

local function handle_biz_stat_event(args, _cbid)
  _ejoysdk.log(TAG .. " handle_biz_stat_event")
  local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
  if args.bizid then
    ESTAT.stat_bizid(args.bizid, args.type, args.result, args.params)
  elseif args.action then
    ESTAT.stat_action(args.action, args.type, args.result, args.params)
  else
    _ejoysdk.log(TAG .. " handle_biz_stat_event Invalid")
  end
end

local function handle_webview_event(args, cbid)
  local E = require("ejoysdk_lua.ejoysdk")
  local action = args.action
  if "capture" == action then
    E.capture_webview(function(...)
      local resp = (...)
      local code = resp.code
      local body = resp.body
      if 0 == code then
        local img_uri = body.img_uri
        E.LOG.debug(TAG, "capture succ, uri " .. img_uri)
      else
        local err_msg = body.err_msg
        E.LOG.debug(TAG, "capture fail, msg" .. err_msg)
      end
      E.WebView.callback_js(cbid, JSON.encode(resp))
    end)
  end
end

local function get_cloud_game_facade()
  if not cloud_game_facade then
    cloud_game_facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  end
  return cloud_game_facade
end

local function handle_cloud_event(args, cbid)
  _ejoysdk.log("handle cloud event")
  local E = require("ejoysdk_lua.ejoysdk")
  local type = args.type
  _ejoysdk.log(type)
  local cs = get_cloud_game_facade()
  if "get_cloud_state" == type or "get_cloud_config" == type then
    local result = cs.get_download_info_for_ui()
    _ejoysdk.log("_test_set_progress_notify_listener h5 handle_cloud_event:" .. tostring(result.downloadProgress) .. ", recvBytes:" .. tostring(result.recvBytes) .. ", totalBytes:" .. tostring(result.totalBytes))
    E.WebView.callback_js(cbid, JSON.encode(result))
  elseif "get_quality_info" == type then
    local result = cs.get_quality_info()
    E.WebView.callback_js(cbid, JSON.encode(result))
  elseif "change_quality_level" == type then
    E.LOG.debug(TAG, "change_quality_level type >> ")
    cs.change_quality_level(args.params, function(succ, current_level)
      E.LOG.debug(TAG, "change_quality_level result >> " .. tostring(succ) .. ", current level >> " .. tostring(current_level))
      local result = {is_succ = succ, quality_level = current_level}
      E.WebView.callback_js(cbid, JSON.encode(result))
    end)
  elseif "start_game_activity" == type then
    cs.start_game_activity()
    local ui_stat = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_ui_stat")
    ui_stat.stat_open_button_click(ui_stat.PAGE_KEY.FLOAT_PANEL)
    local cstat = require("ejoysdk_lua.cloud_game.cloud_stat")
    cstat.stat_cloud_exit("pannel_complete_start")
  elseif "exit_cloud_game" == type then
    cs.js_close_cloud_game_view(args.params)
    local cstat = require("ejoysdk_lua.cloud_game.cloud_stat")
    cstat.stat_cloud_exit("pannel_exit")
  elseif "show_network_state" == type then
    cs.show_network_state(args.params)
  elseif "start_download" == type then
    _ejoysdk.log("receive js start download ")
    local ui_stat = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_ui_stat")
    ui_stat.stat_download_button_click()
    cs.start_download(args.params)
  end
end

local function handle_lua_call_event(args, cbid)
  local E = require("ejoysdk_lua.ejoysdk")
  local lua_handler = require("ejoysdk_lua.ejoysdk_js_bridge_adapter")
  
  function lua_handler.output(func_id, callback_params)
    E.WebView.callback_js(func_id, JSON.encode(callback_params))
  end
  
  local params = args.params
  local call_params = params.params or {}
  if type(call_params) == "table" then
    table.insert(call_params, {
      _func_id = tostring(cbid)
    })
  elseif _ejoysdk.os() == "harmonyos" then
    call_params = lunate.deepcopy(call_params)
    table.insert(call_params, {
      _func_id = tostring(cbid)
    })
  end
  local body = {
    syncCall = args.syncCall or false,
    module = params.module,
    ["function"] = params.func,
    params = call_params
  }
  lua_handler.input(body)
end

local function webview_js_callback(_value)
  local E = require("ejoysdk_lua.ejoysdk")
  _ejoysdk.log("webview_js_callback >>> " .. tostring(_value.args.chl))
  E.log(_value)
  local args = _value.args
  local module_name
  if args and args.chl then
    module_name = args.chl
    E.LOG.debug(TAG, "webview_js_callback received>>")
    E.log(args)
  end
  if not module_name then
    E.LOG.warn(TAG, "webview_js_callback not handled, module is nil")
    return
  end
  E.LOG.debug(TAG, "webview_js_callback module_name=" .. module_name)
  local cbid = _value.cbid
  if module_name == MODULES.SOCIAL then
    handle_social_event(args, cbid)
  elseif module_name == MODULES.BIZ_STAT then
    handle_biz_stat_event(args, cbid)
  elseif module_name == MODULES.WEBVIEW then
    handle_webview_event(args, cbid)
  elseif module_name == MODULES.LUA_CALL then
    handle_lua_call_event(args, cbid)
  elseif module_name == MODULES.CLOUD_GAME then
    handle_cloud_event(args, cbid)
  else
    E.LOG.debug(TAG, "webview_js_callback not implemented")
  end
end

function M.init()
  local E = require("ejoysdk_lua.ejoysdk")
  if not has_init then
    has_init = true
    E.LOG.debug(TAG, "subscribe_js_event begin")
    local ET = require("ejoysdk_lua.ejoysdk_topic")
    ET.subscribe("webview_jsargs", webview_js_callback)
  else
    E.LOG.debug(TAG, "subscribe_js_event already init and just return")
  end
end

return M
