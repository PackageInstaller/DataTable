local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ACCOUNT_HISTORY = E.LazyKeyStore:New("EJOYSDK_AIRLINE_V2_ACCOUNT_HISTORY", false, true, false)
local AUTH_INFO = E.LazyKeyStore:New("AIRLINE_V2_AUTH_INFO", false, true, false)
local account_histories = {}
local TAG = EM.MODULE.AIRLINE_V2 .. "history"
local M = {}

local function is_empty(str)
  return not str or "" == str or type(str) ~= "string"
end

function M.init()
  account_histories = ACCOUNT_HISTORY:get() or {}
end

function M.update(user_info)
  if not user_info or is_empty(user_info.uid) then
    E.log(TAG .. " update function return now....")
    return
  end
  M.check_if_need_clear_history_account(user_info)
  local accountOs = user_info.accountOs
  local saveKey = accountOs .. tostring(user_info.uid)
  local oldKey, oldData
  if not is_empty(accountOs) then
    for key, accountData in pairs(account_histories) do
      if accountData.accountOs == user_info.accountOs and accountData.uid == user_info.uid then
        oldKey = key
        oldData = accountData
        E.LOG.debug(TAG, "历史账号里有命中------")
        E.LOG.debug(TAG, "key = " .. key)
        E.LOG.debug(TAG, "accountData = ")
        E.LOG.debug(TAG, accountData)
        break
      end
    end
  end
  if oldKey and oldData then
    account_histories[oldKey] = nil
    account_histories[saveKey] = oldData
  end
  local history = account_histories[saveKey] or user_info
  history.airlineToken = user_info.airlineToken or ""
  history.serviceTicket = user_info.serviceTicket or ""
  history.airlineTokenTimeout = user_info.airlineTokenTimeout or E.system_clock()
  history.login_time = E.time()
  history.loginType = user_info.loginType
  account_histories[saveKey] = history
  E.LOG.debug(TAG, "account_histories set >>")
  E.LOG.debug(TAG, account_histories)
  ACCOUNT_HISTORY:set(account_histories)
  M.update_auth_info(user_info)
end

function M.check_if_need_clear_history_account(user_info)
  if _ejoysdk.os() ~= "windows" then
    E.LOG.debug(TAG, "check_if_need_clear_history_account, now windows, return now >>")
    return
  end
  local util = require("ejoysdk_lua.ejoysdk_utils")
  local nowData = user_info.accountDiffInfo
  local nowHasDiffOs = false
  if nowData and type(nowData) == "table" and util.tablelength(nowData) > 0 then
    nowHasDiffOs = true
  end
  local historyHasDiffOs = false
  local historyHasSameOs = false
  for _key, accountData in pairs(account_histories) do
    local accountDiffInfo = accountData.accountDiffInfo
    if accountDiffInfo and type(accountDiffInfo) == "table" and util.tablelength(accountDiffInfo) > 0 then
      historyHasDiffOs = true
    else
      historyHasSameOs = true
    end
  end
  if false == nowHasDiffOs and true == historyHasDiffOs or true == nowHasDiffOs and true == historyHasSameOs then
    E.LOG.debug(TAG, "check_if_need_clear_history_account, nowDiffOs not equal historyDiffOs, clear all history account data.")
    account_histories = {}
  end
end

function M.delete(account_id)
  if is_empty(account_id) then
    return
  end
  account_histories[account_id] = nil
  ACCOUNT_HISTORY:set(account_histories)
end

function M.get_list()
  local list = {}
  for _, value in pairs(account_histories) do
    table.insert(list, value)
  end
  E.LOG.debug(TAG, "get account_histories >>")
  E.LOG.debug(TAG, list)
  return list
end

function M.update_auth_info(auth_info)
  AUTH_INFO:set(auth_info)
end

function M.get_auth_info()
  local auth_info = AUTH_INFO:get()
  return auth_info
end

function M.delete_auth_info()
  AUTH_INFO:delete()
end

return M
