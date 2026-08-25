local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local UIM = require("ejoysdk_lua.user_info_manager")
local LAST_PUSH_TICKET_ID = E.LazyKeyStore:New("LAST_PUSH_TICKET_ID", false, false, false)
local TAG = "tiktok_one_key_entergame"
local M = {}
M.TICKET_TIMING = {ON_INIT = "on_init", IN_GAME = "in_game"}
M.STAT_EVENT = {
  EVENT_PUSH_TICKET = "sdk.douyin.ticket.push",
  EVENT_CHECK_TICKET = "sdk.douyin.ticket.check",
  EVENT_CHECK_RESULT = "sdk.douyin.ticket.result"
}
local is_setup = false

local function is_cloud_env()
  local pkg_info = UIM.get_pkg_info()
  return pkg_info[UIM.PKG_INFO_KEY.KEY_CHANNEL_CLOUD_GAME_TAG] or false
end

local function parse_ticket(url)
  if type(url) ~= "string" then
    E.LOG.debug(TAG, "url is wrong")
    return nil
  end
  local url_obj = E.HTTP.parse(url)
  E.LOG.debug(TAG, {url_obj = url_obj})
  if url_obj and url_obj.query_ori_str then
    local queryString = url_obj.query_ori_str
    _ejoysdk.log(TAG .. "#queryString >> " .. tostring(queryString))
    local base64_decode_data = _ejoysdk_crypt.base64decode(queryString)
    local params = {}
    for key, value in base64_decode_data:gmatch("([^=&]+)=([^=&]+)") do
      params[key] = value
    end
    if params.ticket_id then
      local ticket = params.ticket_id
      local user_type = params.user_type
      _ejoysdk.log(TAG .. "#parse ticket id >> " .. tostring(ticket) .. " user type >> " .. tostring(user_type))
      return ticket, user_type
    end
  else
    _ejoysdk.log(TAG .. "#url parse fail")
  end
  return nil
end

local function push_ticket(ticket)
  local last_push_ticket = LAST_PUSH_TICKET_ID:get()
  if ticket == last_push_ticket then
    _ejoysdk.log(TAG .. "#The ticket has already been used, do not push again")
    return
  end
  ET.publish(ET.tiktok.TICKET_PUSH, ticket)
  LAST_PUSH_TICKET_ID:set(ticket)
end

local function on_url(url_type, url_data)
  _ejoysdk.log(TAG .. "#receive url open v2 >> " .. tostring(url_type))
  local data = url_data or {}
  E.LOG.debug(TAG, {data = data})
  local url
  if data.type and data.type == "handleOpenUrl" and data.url then
    url = data.url
  end
  if type(url) == "string" then
    local ok, ticket, user_type = pcall(parse_ticket, url)
    if ok and type(ticket) == "string" then
      push_ticket(ticket)
      local stat_params = {
        ticket = ticket,
        type = M.TICKET_TIMING.IN_GAME,
        is_cloud = is_cloud_env(),
        user_type = user_type
      }
      QL.commit_event(M.STAT_EVENT.EVENT_PUSH_TICKET, stat_params, true)
    else
      E.LOG.debug(TAG, "parse ticket fail, url >> " .. tostring(url))
      local stat_params = {url = url}
      stat_params[ESTAT.STAT_KEY.IS_UPLOAD_NOW] = true
      ESTAT.stat_action("parse_ticket_fail", "", false, stat_params)
    end
  end
end

function M.setup()
  _ejoysdk.log(TAG .. "#setup invoke")
  if is_setup then
    E.LOG.debug(TAG, "is setup, return")
    return
  end
  is_setup = true
  if _ejoysdk.os() == "windows" or _ejoysdk.os() == "harmonyos" then
    E.LOG.debug(TAG, "windows or harmonyos not support, return")
    return
  end
  local url_open_datas = E.get_url_open_datas()
  _ejoysdk.log(TAG .. "#url_open_datas")
  E.LOG.debug(TAG, {url_open_datas = url_open_datas})
  local size = UTILS.tablelength(url_open_datas)
  _ejoysdk.log(TAG .. "#url_open_datas, size >> " .. tostring(size))
  if size > 0 then
    for _, data in ipairs(url_open_datas) do
      E.LOG.debug(TAG, {data = data})
      if data.type and data.url and data.type == "handleOpenUrl" then
        local ok, ticket, user_type = pcall(parse_ticket, data.url)
        if ok and type(ticket) == "string" then
          _ejoysdk.log(TAG .. "#push ticket >> " .. tostring(ticket))
          push_ticket(ticket)
          local stat_params = {
            ticket = ticket,
            type = M.TICKET_TIMING.ON_INIT,
            is_cloud = is_cloud_env(),
            user_type = user_type
          }
          QL.commit_event(M.STAT_EVENT.EVENT_PUSH_TICKET, stat_params, true)
        else
          E.LOG.debug(TAG, "parse ticket fail, url >> " .. tostring(data.url))
          local stat_params = {
            url = data.url
          }
          stat_params[ESTAT.STAT_KEY.IS_UPLOAD_NOW] = true
          ESTAT.stat_action("parse_ticket_fail", "", false, stat_params)
        end
      end
    end
  else
    _ejoysdk.log(TAG .. "#url_open_datas is empty")
  end
  ET.subscribe("urlopen_v2", on_url)
end

local function stat_check_ticket_result(succ, params, code, fail_reason)
  local stat_params = params
  stat_params.code = code
  stat_params.message = fail_reason
  stat_params.result = succ
  QL.commit_event(M.STAT_EVENT.EVENT_CHECK_RESULT, stat_params, true)
end

function M.check_ticket(ticket, role_info, app_id, cb)
  local function cb_wrapper(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end
  
  _ejoysdk.log(TAG .. "#check ticket >> " .. tostring(ticket) .. " and app_id >> " .. tostring(app_id))
  E.LOG.debug(TAG, {role = role_info})
  local stat_params = {
    ticket = ticket,
    appid = app_id,
    role_info = JSON.safe_encode(role_info),
    is_cloud = is_cloud_env()
  }
  if ticket and app_id then
    local teamPlayToken = {ticketId = ticket, appId = app_id}
    local request_data = {
      token = GDP.USER_INFO.get("ptoken"),
      teamPlayToken = JSON.safe_encode(teamPlayToken),
      teamPlayType = "douyin",
      roleInfo = JSON.safe_encode(role_info)
    }
    QL.commit_event(M.STAT_EVENT.EVENT_CHECK_TICKET, stat_params, true)
    DSP.post(DSP.SERVICE.TEAM_PLAY_TICKET, request_data, function(succ, ...)
      _ejoysdk.log(TAG .. "#team play ticket, succ >> " .. tostring(succ))
      E.LOG.debug(TAG, {
        ...
      })
      if succ then
        stat_check_ticket_result(true, stat_params)
        cb_wrapper(true, ...)
      else
        local code, message = ...
        local error_msg = "[" .. tostring(code) .. "]" .. tostring(message)
        _ejoysdk.log(TAG .. "#team play ticket, fail >> " .. tostring(error_msg))
        cb_wrapper(false, EC.ONE_KEY_ENTER_GAME_CODE.SERVER_VERIFY_FAIL, error_msg)
        stat_check_ticket_result(false, stat_params, EC.ONE_KEY_ENTER_GAME_CODE.SERVER_VERIFY_FAIL, error_msg)
      end
    end)
  else
    cb_wrapper(false, EC.ONE_KEY_ENTER_GAME_CODE.INVALID_PARAMS, "ticket or app_id is nil")
    stat_check_ticket_result(false, stat_params, EC.ONE_KEY_ENTER_GAME_CODE.INVALID_PARAMS, "ticket or app_id is nil")
  end
end

return M
