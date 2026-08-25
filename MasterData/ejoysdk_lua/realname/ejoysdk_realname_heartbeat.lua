local API = require("ejoysdk_lua.user_center.usercenter_api")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local realname_info = require("ejoysdk_lua.realname.realname_info")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local POP = require("ejoysdk_lua.realname.popup_handler")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local TAG = EM.MODULE.REALNAME .. "heartbeat"
local M = {}
local global_ptoken
local global_check_time_gap = 120
local global_check_time_gap_adult = 1200
local loop_time_gap = global_check_time_gap
local expired_time_gap = 1800
local is_excuting = false
local is_need_stop = false

local function exchange_ptoken_HTTP_Request()
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local userInfo = EG.user_info()
  local params = {
    token = global_ptoken or userInfo.ptoken or ""
  }
  API.user_center_replace_ptoken(params, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "user_center_replace_ptoken success -----")
      local data = (...)
      E.LOG.debug(TAG, data)
      if data and data.token then
        global_ptoken = data.token
      end
    else
      E.LOG.debug(TAG, "user_center_replace_ptoken failed -----")
      local code, msg = ...
      E.LOG.debug(TAG, "code = " .. tostring(code) .. ", msg = " .. tostring(msg))
    end
  end)
end

local CONFIG = require("ejoysdk_lua.airline_v2.airline_v2_config")

local function message_handler(msg)
  E.LOG.debug(TAG, "message handler")
  E.log(msg)
  if type(msg) ~= "table" then
    E.LOG.debug(TAG, "msg type wrong, return")
    return
  end
  local templateId = msg.templateId
  if templateId and 902001 == templateId then
    local content = msg.content
    local decodeContent = _ejoysdk_crypt.base64decode(content)
    E.LOG.debug(TAG, "base64 decode content >> " .. tostring(decodeContent))
    local formatContent = JSON.decode(decodeContent)
    if type(formatContent) ~= "table" then
      E.LOG.error(TAG, "formatContent is not table, return")
      return
    end
    E.log(formatContent)
    local noneExit = formatContent.noneExit
    local url = formatContent.url
    url = POP.append_sdk_query_params(url, true)
    local start_up_data = {}
    CONFIG.fill_start_up_data(start_up_data)
    start_up_data.client_info = POP.get_cas_client_info()
    local wv_option = {
      hide_close_btn = noneExit,
      close_event_data = "close_event_data_heartbeat",
      disable_backkey_press = true
    }
    E.log(wv_option)
    POP.show_webview(url, wv_option, {}, function(value)
      E.LOG.debug(TAG, "on_js_callback >>")
      E.log(value)
      local args = value.args or {}
      if type(args.type) == "string" and args.type == "msg_exit_login" then
        local web_manager = require("ejoysdk_lua.ejoysdk_webview_manager")
        web_manager.hide_all_web()
        local EG = require("ejoysdk_lua.ejoysdk_gangplank")
        EG.logout()
      end
    end)
  else
    E.LOG.debug(TAG, "msg templateId is nil or not 902001, do nothing")
  end
end

local function headrtbeat_HTTP_Request()
  if is_need_stop then
    E.log("已暂停心跳--")
    return
  end
  if is_excuting then
    E.log("同时只执行一次心跳就好，避免多次调用导致心跳多次")
    return
  end
  is_excuting = true
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local tempRoleId = ""
  local tempServerId = ""
  local tempPToken = ""
  local tempPlatform = ""
  local userInfo = EG.user_info()
  local playerInfo = EG.player_info()
  if playerInfo then
    tempRoleId = playerInfo.player_id or ""
    tempServerId = playerInfo.server_id or ""
  end
  if userInfo then
    tempPToken = global_ptoken or userInfo.ptoken or ""
  end
  if userInfo and userInfo.pinfo and userInfo.pinfo.platform then
    tempPlatform = userInfo.pinfo.platform
  end
  local params = {
    token = tempPToken,
    serverId = tempServerId,
    roleId = tempRoleId,
    platform = tempPlatform,
    scene = 201
  }
  API.user_center_heartbeat(params, function(succ, ...)
    if succ then
      E.log("heartbeat success -----")
      local data = (...)
      if data then
        if data.checkPeriod then
          local tempValue = tonumber(data.checkPeriod)
          if tempValue and tempValue > 0 then
            loop_time_gap = tempValue
          end
        else
          loop_time_gap = M.get_default_loop_time_gap()
        end
        if data.serverTime and data.tokenExpiredTime then
          local validTime = (tonumber(data.tokenExpiredTime) - tonumber(data.serverTime)) / 1000
          E.log("validTime = " .. tostring(validTime))
          E.log("expired_time_gap = " .. tostring(expired_time_gap))
          if validTime <= expired_time_gap then
            exchange_ptoken_HTTP_Request()
          end
        end
        E.LOG.debug(TAG, "handle message ")
        local msgs = data.msgs or {}
        if utils.tablelength(msgs) > 0 then
          for _, msg in ipairs(msgs) do
            message_handler(msg)
          end
        else
          E.LOG.debug(TAG, "msgs length = " .. tostring(#msgs))
        end
      end
    else
      E.log("heartbeat failed -----")
      local code, msg = ...
      E.log("code = " .. tostring(code) .. ", msg = " .. msg)
      if 4001003 == code then
        E.log("此错误码表示ptoken过期了，需要停止轮询")
        M.heartbeat_stop()
      end
    end
    E.Timer.once(loop_time_gap, function()
      is_excuting = false
      headrtbeat_HTTP_Request()
    end)
  end)
end

local function check_if_support_vendor(vendor_name)
  if not vendor_name then
    return false
  end
  local UNI = require("ejoysdk_lua.vendors.unisdk")
  local sdk_infos = UNI.get_sdk_infos()
  for sdk_name, sdk_info in pairs(sdk_infos) do
    if sdk_name == vendor_name then
      return true, sdk_info
    end
  end
  return false
end

local function use_lua_heartbeat()
  local CG = require("ejoysdk_lua.cloud_game.cloud_config")
  local pkgInfo = E.get_pkg_info()
  if pkgInfo.cloud_game_mode and pkgInfo.cloud_game_mode == CG.CLOUD_MODE.CLOUD then
    E.log("云微端不需要心跳，直接返回")
    return false
  end
  if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    E.log("PC海外地区不需要心跳，直接返回")
    return false
  end
  if E.Sysinfo.os() == "weixin" or E.Sysinfo.os() == "douyin" then
    return false
  end
  if E.Sysinfo.os() == "harmonyos" then
    return true
  end
  if E.Sysinfo.os() == "ios" and check_if_support_vendor("AIRLINE_V2") then
    E.log("iOS and login type is airline v2")
    return true
  end
  if E.Sysinfo.os() ~= "windows" then
    local aligames = require("ejoysdk_lua.vendors.aligames")
    if aligames.is_delete_msg_check() then
      E.log("aligames is delete msg check")
      return true
    end
    if not E.is_scan_pkg() then
      E.log("当前设备不是Windows/Android扫码包, 不用走心跳的逻辑，直接返回")
      return false
    end
  end
  return true
end

function M.heartbeat_start()
  E.LOG.debug(TAG, "call heart beat start")
  if not use_lua_heartbeat() then
    return
  end
  is_need_stop = false
  E.LOG.debug(TAG, "heart beat start, realname status >> " .. tostring(realname_info.get_realname_status()) .. ", and adult status >> " .. tostring(realname_info.get_adult_status()))
  loop_time_gap = M.get_default_loop_time_gap()
  pcall(headrtbeat_HTTP_Request)
end

function M.get_default_loop_time_gap()
  if realname_info.get_adult_status() == realname_info.REALNAME_AGE_STATUS.ADULT then
    E.LOG.debug(TAG, "user is adult, modify loop gap to 20 min")
    return global_check_time_gap_adult
  end
  return global_check_time_gap
end

function M.heartbeat_stop()
  E.LOG.debug(TAG, "call heart beat stop")
  is_need_stop = true
end

return M
