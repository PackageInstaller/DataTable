local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local util = require("ejoysdk_lua.ejoysdk_utils")
local OFFICIAL_ACCOUNT_HISTORY = E.LazyKeyStore:New("EJOYSDK_OFFICIAL_ACCOUNT_HISTORY", false, true, false)
local account_histories = {}
local TAG = EM.MODULE.ACCOUNT .. "OFFICIAL_HISTORY"
local M = {}
local _change_callback
M.EVENT = {
  ADD = 1,
  DELETE = 2,
  UPDATE = 3
}

local function is_empty(str)
  return not str or "" == str or type(str) ~= "string"
end

function M.init(_history_change_listener)
  account_histories = OFFICIAL_ACCOUNT_HISTORY:get() or {}
  _change_callback = _history_change_listener
end

function M.update(user_info, thirdparty_info)
  E.LOG.debug(TAG, "update user info")
  E.LOG.debug(TAG, user_info)
  E.LOG.debug(TAG, "thirdparty_info ===")
  E.LOG.debug(TAG, thirdparty_info)
  if not user_info or is_empty(user_info.ptoken) or is_empty(user_info.uid) then
    return
  end
  local saveKey = user_info.uid
  local default_info = {
    login_type = user_info.platform or "",
    uid = user_info.uid or ""
  }
  util.merge_table(default_info, user_info)
  local is_new_history = nil == account_histories[saveKey]
  local history = account_histories[saveKey] or default_info
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  local upper_platform = string.upper(user_info.platform or "")
  if is_overseas and "ST_LOGIN" ~= upper_platform then
    history.login_type = user_info.platform
    E.LOG.debug(TAG, "login_type from platform")
  elseif not util.STR.is_empty(user_info.thirdparty_type) then
    history.login_type = user_info.thirdparty_type
    history.thirdparty_type = user_info.thirdparty_type
    E.LOG.debug(TAG, "login_type  from thirdparty_type")
  elseif not is_overseas and not util.STR.is_empty(user_info.thirdPartyType) and "ST_LOGIN" ~= string.upper(user_info.thirdPartyType) then
    history.login_type = user_info.thirdPartyType
    history.thirdparty_type = user_info.thirdPartyType
    E.LOG.debug(TAG, "login_type  from thirdPartyType")
  end
  if ("AIRLINE" == upper_platform or "ST_LOGIN" == upper_platform) and user_info.ext and not util.STR.is_empty(user_info.ext.thirdparty_type) then
    history.login_type = user_info.ext.thirdparty_type
    history.thirdparty_type = user_info.ext.thirdparty_type
    E.LOG.debug(TAG, "login_type from thirdparty_type 2222")
  end
  if not is_empty(user_info.account) then
    history.account = user_info.account
  elseif user_info.ext and user_info.ext.channel_info and user_info.ext.channel_info.nickName then
    history.account = user_info.ext.channel_info.nickName
  end
  if not is_empty(user_info.account_os) then
    history.account_os = user_info.account_os
  end
  history.ptoken = user_info.ptoken or ""
  if not is_empty(user_info.st) then
    history.ptoken = user_info.st
    history.st = user_info.st
  end
  local thirdPartyInfo = thirdparty_info
  if type(thirdPartyInfo) == "table" and util.tablelength(thirdPartyInfo) > 0 then
    E.LOG.debug(TAG, "save third party info to history")
    history.thirdPartyInfo = thirdPartyInfo
  else
    E.LOG.debug(TAG, "user info do not contain third party info")
  end
  history.login_time = tostring(E.time())
  E.LOG.debug(TAG, "account_histories set >>")
  E.LOG.debug(TAG, history)
  account_histories[saveKey] = history
  E.LOG.debug(TAG, {history_list = account_histories})
  OFFICIAL_ACCOUNT_HISTORY:set(account_histories)
  if _change_callback then
    local event = true == is_new_history and M.EVENT.ADD or M.EVENT.UPDATE
    _change_callback(event, saveKey)
  end
end

function M.fill_lingxi_history(histories)
  E.LOG.debug(TAG, "merge lingxi history")
  for _, history in pairs(histories) do
    E.LOG.debug(TAG, "history ucid >> " .. tostring(history.ucid))
    E.LOG.debug(TAG, history)
    local uid = history.uid
    account_histories[uid] = history
  end
  E.LOG.debug(TAG, "after merge lingxi history")
  E.LOG.debug(TAG, {history_list = account_histories})
  OFFICIAL_ACCOUNT_HISTORY:set(account_histories)
end

function M.delete(account_id)
  E.LOG.debug(TAG, "delete login history, account_id >> " .. tostring(account_id))
  if is_empty(account_id) then
    return
  end
  account_histories[account_id] = nil
  OFFICIAL_ACCOUNT_HISTORY:set(account_histories)
  if _change_callback then
    _change_callback(M.EVENT.DELETE, account_id)
  end
end

function M.clear_history()
  account_histories = {}
  OFFICIAL_ACCOUNT_HISTORY:set({})
end

function M.get_list()
  E.LOG.debug(TAG, "get login history")
  local list = {}
  for _, value in pairs(account_histories) do
    table.insert(list, value)
  end
  E.LOG.debug(TAG, list)
  return list
end

function M.get_last_login_account()
  local last_user_info
  for _, value in pairs(account_histories) do
    if tonumber((last_user_info or {}).login_time or 0) < tonumber((value or {}).login_time or 0) then
      last_user_info = value
    end
  end
  return last_user_info and util.deepcopy(last_user_info)
end

function M.get_last_login_account_with_init_check()
  E.LOG.debug(TAG, "get_last_login_account_with_init_check --called")
  local utils = require("ejoysdk_lua.ejoysdk_utils")
  if 0 == utils.tablelength(account_histories) then
    account_histories = OFFICIAL_ACCOUNT_HISTORY:get() or {}
  end
  do return end
  return M.get_last_login_account, OFFICIAL_ACCOUNT_HISTORY
end

return M
