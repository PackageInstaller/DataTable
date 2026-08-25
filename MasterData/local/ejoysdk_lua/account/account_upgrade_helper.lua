local EM = require("ejoysdk_lua.ejoysdk_module")
local E = require("ejoysdk_lua.ejoysdk")
local TAG = EM.MODULE.ACCOUNT .. "OFFICIAL_HISTORY"
local M = {}
local ACCOUNT_TYPE_V1 = {
  UC = 0,
  MOBILE = 3,
  GUEST = 4,
  ALIPAY = 504,
  GAME_CENTER = 703,
  TAOBAO = 704,
  OFFLINE = 720,
  ONE_KEY = 750
}
local ACCOUNT_TYPE_V2 = {
  SIM_LOGIN = "sim_login",
  ALIPAY = "alipay",
  MOBILE = "mobile",
  TAOBAO = "taobao"
}

local function common_upgrade(history, account)
  account.platform = "998233"
  account.uid = tostring(history.ucid)
  local thirdPartyInfo
  local os = _ejoysdk.os()
  if "ios" == os then
    account.account_os = history.accountOS
    account.account = history.loginName or history.accountThroughMobile
    account.st = history.serviceTicket
    account.login_time = tonumber(history.loginDate)
    thirdPartyInfo = {
      nickname = history.nickName or M.mask_phone_number(history.loginName)
    }
    account.ptoken = history.token
  else
    account.account_os = history.accountOs
    account.account = history.phone
    account.st = history.st
    account.login_time = history.lastLoginTime / 1000
    local nick
    if history.nickName and tostring(history.nickName) ~= "" then
      nick = history.nickName
    elseif history.phone and tostring(history.phone) ~= "" then
      nick = M.mask_phone_number(history.phone)
    end
    thirdPartyInfo = {nickname = nick}
    account.ptoken = history.st
  end
  account.thirdPartyInfo = thirdPartyInfo
  return account
end

function M.mask_phone_number(phone_number)
  if not phone_number then
    return nil
  end
  if phone_number:sub(1, 3) == "86-" then
    phone_number = phone_number:sub(4)
  end
  if 11 == #phone_number and tonumber(phone_number) ~= nil then
    local masked_number = phone_number:sub(1, 3) .. "****" .. phone_number:sub(8, 11)
    return masked_number
  else
    return phone_number
  end
end

local function mobile_upgrade(history)
  local account = {}
  account.login_type = ACCOUNT_TYPE_V2.MOBILE
  account.thirdparty_type = ACCOUNT_TYPE_V2.MOBILE
  do return common_upgrade, history end
  return common_upgrade, history, account
end

local function alipay_upgrade(history)
  local account = {}
  account.login_type = ACCOUNT_TYPE_V2.ALIPAY
  account.thirdparty_type = ACCOUNT_TYPE_V2.ALIPAY
  do return common_upgrade, history end
  return common_upgrade, history, account
end

local function one_key_upgrade(history)
  local account = {}
  account.login_type = ACCOUNT_TYPE_V2.SIM_LOGIN
  account.thirdparty_type = ACCOUNT_TYPE_V2.SIM_LOGIN
  do return common_upgrade, history end
  return common_upgrade, history, account
end

local function taobao_upgrade(history)
  local account = {}
  account.login_type = ACCOUNT_TYPE_V2.TAOBAO
  account.thirdparty_type = ACCOUNT_TYPE_V2.TAOBAO
  do return common_upgrade, history end
  return common_upgrade, history, account
end

M.upgrade_map = {
  [ACCOUNT_TYPE_V1.MOBILE] = mobile_upgrade,
  account_sms = mobile_upgrade,
  [ACCOUNT_TYPE_V1.ALIPAY] = alipay_upgrade,
  account_alizfb = alipay_upgrade,
  [ACCOUNT_TYPE_V1.ONE_KEY] = one_key_upgrade,
  account_oneclick = one_key_upgrade,
  [ACCOUNT_TYPE_V1.TAOBAO] = taobao_upgrade,
  account_taobao = taobao_upgrade
}

function M.upgrade_account(history)
  E.LOG.debug(TAG, "upgrade_account history")
  local type_v1 = history.accountType or history.loginType
  if type_v1 == ACCOUNT_TYPE_V1.GUEST and _ejoysdk.os() == "android" then
    E.LOG.error(TAG, "当前是游客类型的登录历史，安卓要直接丢弃掉，避免native代码带来的一个不能登录的游客登录历史")
    return nil
  end
  local upgrade_data = M.upgrade_map[type_v1] or mobile_upgrade
  if upgrade_data and type(upgrade_data) == "function" then
    local account = upgrade_data(history)
    E.LOG.debug(TAG, "after upgrade_account history")
    E.LOG.debug(TAG, {account = account})
    return account
  end
  return nil
end

function M.upgrade_accounts(histories)
  E.LOG.debug(TAG, "upgrade_accounts history")
  E.LOG.debug(TAG, {histories = histories})
  local v2_accounts = {}
  
  local function insert_v2(account)
    local uid = account.uid
    if not v2_accounts[uid] then
      v2_accounts[uid] = account
    else
      E.LOG.error(TAG, "uid:" .. tostring(uid) .. " has a same account")
    end
  end
  
  for _, history in pairs(histories) do
    local type_v1 = history.accountType or history.loginType
    if type_v1 == ACCOUNT_TYPE_V1.GUEST and _ejoysdk.os() == "android" then
      E.LOG.error(TAG, "当前是游客类型的登录历史，安卓要直接丢弃掉，避免native代码带来的一个不能登录的游客登录历史")
      break
    end
    local upgrade_data = M.upgrade_map[type_v1] or mobile_upgrade
    if upgrade_data and type(upgrade_data) == "function" then
      local account = upgrade_data(history)
      insert_v2(account)
    end
  end
  E.LOG.debug(TAG, "after upgrade_account history")
  E.LOG.debug(TAG, v2_accounts)
  return v2_accounts
end

return M
