local E = require("ejoysdk_lua.ejoysdk")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local SC = require("ejoysdk_lua.user_center.system_config")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local AL = require("ejoysdk_lua.account.service.account_login")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
local AGST = require("ejoysdk_lua.vendors.agst_account")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EQL = require("ejoysdk_lua.ejoysdk_qualitylog")
local LOGIN_HISTORY = require("ejoysdk_lua.account.official_history")
local ANT = require("ejoysdk_lua.vendors.ant")
local TAOBAO = require("ejoysdk_lua.vendors.taobao")
local PHONE_AUTH = require("ejoysdk_lua.vendors.ali_datapkg")
local TAPTAP = require("ejoysdk_lua.vendors.taptap")
local WEIXIN = require("ejoysdk_lua.vendors.weixin")
local DOUYIN = require("ejoysdk_lua.vendors.douyin")
local APPLE = require("ejoysdk_lua.vendors.apple")
local OPPO = require("ejoysdk_lua.vendors.oppo")
local XIAOMI = require("ejoysdk_lua.vendors.xiaomi")
local TAG = "LOGIN_API#"
local OFFICIAL_VENDOR_NAME = "OFFICIAL"
local ST_VENDOR_NAME = "ST_LOGIN"
local OFFICIAL_HISTORY = E.LazyKeyStore:New("QOOKKA_GAME_LOGIN_HISTORY", false, true, false)
local LAST_LOGIN_SUCC_VENDOR = E.SPKeyStore:New("com.ejoy.sdk.lua", "LAST_LOGIN_SUCC_VENDOR")
local M = {}
local LOGIN_RESULT_CACHE = {}

local function is_overseas()
  do return E.CONFIG.get_config end
  return E.CONFIG.get_config, E.CONFIG.KEY.MULTI_REGIONS_ENABLED
end

local inner_login

function M.login(login_type, ext, cb)
  local AGST_VENDOR_NAME = "AGST"
  login_type = string.upper(login_type)
  if AGST_VENDOR_NAME == login_type and AGST.has_marked_agst_official() then
    function M.create_new_guest(new_guest_cb)
      AGST.clear_agst_official_sign()
      
      M.login(AGST_VENDOR_NAME, nil, new_guest_cb)
    end
    
    PROTOCOL.fail_callback(cb, CONSTANTS.OFFICIAL_ERR_CODES.CODE_AGST_HAS_BOUND, "Old guest already bind a Account")
  else
    inner_login(login_type, ext, function(result, callback)
      if not result then
        PROTOCOL.fail_callback(callback or cb, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_ACCOUNT_RESULT_EMPTY, "Login failed, Account result is empty")
        return
      end
      if result:is_succ() then
        LOGIN_RESULT_CACHE[result.token] = result
        PROTOCOL.succ_callback(callback or cb, {
          token = result.token
        })
      else
        local pass_data = result.ext.account_data or result.ext.channel_data or {}
        PROTOCOL.fail_callback(callback or cb, result.code, result.msg, pass_data)
      end
    end)
  end
  EQL.commit_action_main("al_login_invoke", login_type)
end

local inner_available_login_list, available_login_list_airline_v2

function M.get_login_items(cb)
  E.LOG.debug(TAG, "get login items")
  local available_login_list
  if is_overseas() then
    available_login_list = inner_available_login_list()
  else
    available_login_list = available_login_list_airline_v2()
  end
  E.LOG.debug(TAG, available_login_list)
  if available_login_list then
    PROTOCOL.succ_callback(cb, available_login_list)
  else
    PROTOCOL.fail_callback(cb, CONSTANTS.OFFICIAL_ERR_CODES.CODE_NOT_REQUEST_CONFIG, "available_login_list is empty")
  end
  return available_login_list
end

function M.get_login_history(cb)
  E.LOG.debug(TAG, "get login history")
  local history = LOGIN_HISTORY.get_list()
  if cb then
    PROTOCOL.succ_callback(cb, history)
  end
  return history
end

function M.delete_history(account_id)
  E.LOG.debug(TAG, "delete login history, account_id >> " .. tostring(account_id))
  LOGIN_HISTORY.delete(account_id)
end

function M.cache_login_history(type)
  local cache_lh = OFFICIAL_HISTORY:get() or {}
  local lh = {type}
  for i = 0, #cache_lh do
    if type ~= cache_lh[i] then
      table.insert(lh, cache_lh[i])
    end
  end
  OFFICIAL_HISTORY:set(lh)
end

function M.get_uid_adapter_ejoyId(user_data)
  local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  local uid = user_data.openId or ""
  if not is_oversea and user_data.ejoyId then
    uid = user_data.ejoyId
  end
  return uid
end

local function is_sandbox_user(taglist)
  if type(taglist) == "table" then
    for _, value in ipairs(taglist) do
      if 3 == value then
        return true
      end
    end
  end
  return false
end

function M.notify_login(succ, ...)
  E.LOG.debug(TAG, "api.login notify_login, succ >> " .. tostring(succ))
  E.LOG.debug(TAG, {
    ...
  })
  local resp
  if succ then
    local token, login_type, h5_result = ...
    local login_result
    if type(h5_result) == "table" then
      local user_data = h5_result
      USER.usercenter_login_succ(user_data)
      local uid = M.get_uid_adapter_ejoyId(user_data)
      login_result = PROTOCOL.LoginResult.succ(login_type or ST_VENDOR_NAME, {
        token = user_data.token or "",
        uid = uid
      }, {
        account_data = user_data,
        token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT,
        channel_result = PROTOCOL.LoginResult.succ(ST_VENDOR_NAME, {
          token = user_data.token or "",
          uid = user_data.openId or ""
        }, {
          thirdparty_type = login_type,
          is_sandbox_user = is_sandbox_user(user_data.tagList) or nil
        })
      })
    else
      login_result = LOGIN_RESULT_CACHE[token]
      LOGIN_RESULT_CACHE[token] = nil
    end
    resp = PROTOCOL.make_succ_resp({token = token, login_result = login_result})
  else
    local code, msg = ...
    resp = PROTOCOL.make_fail_resp(code, msg)
  end
  ET.publish("webview_jsargs", {
    args = {
      type = "notify_login",
      body = resp
    }
  })
end

function M.get_agst_token(cb)
  local AGST_TOKEN = require("ejoysdk_lua.user_center.agst_token_manager")
  AGST_TOKEN.get_token(function(token)
    PROTOCOL.succ_callback(cb, {agst_token = token})
  end)
end

local function need_sort_login_list()
  local sdk_infos = UNI.get_sdk_infos()
  local vendor_info = sdk_infos[OFFICIAL_VENDOR_NAME]
  if vendor_info and vendor_info.meta and vendor_info.meta.sort_login_list ~= nil then
    return vendor_info.meta.sort_login_list
  end
  return true
end

function available_login_list_airline_v2()
  E.LOG.debug(TAG, "get_login_items start")
  local login_config = UTILS.deepcopy(SC.get("login"))
  local loginItems = {}
  if login_config then
    E.LOG.debug(TAG, {login_config = login_config})
    local switch = {
      TAOBAO_AUTH = TAOBAO.isTaobaoInstalled,
      ANT_AUTH = ANT.isAntInstalled,
      PHONE_AUTH = function()
        local carrier_name = PHONE_AUTH.get_current_carrier_name()
        if carrier_name and "unknown" ~= carrier_name and "UNKNOW" ~= carrier_name then
          return true
        end
        return false
      end,
      HUAWEI_AUTH = function()
        return _ejoysdk.os() == "harmonyos"
      end,
      QR_LOGIN = function()
        return true
      end,
      TAP_LOGIN = TAPTAP.supportAuth,
      WEIXIN = WEIXIN.supportAuth,
      DOUYIN = DOUYIN.supportAuth,
      MOBILE = function()
        return true
      end,
      APPLE = APPLE.supportAuth,
      OPPO = OPPO.supportAuth,
      XIAOMI = XIAOMI.supportAuth
    }
    
    local function switch_default()
      return false
    end
    
    for _, item in ipairs(login_config) do
      if item and item.type then
        local process = switch[string.upper(item.type or "")] or switch_default
        if true == process() then
          table.insert(loginItems, item)
        end
      end
    end
  end
  if not next(loginItems) then
    E.LOG.debug(TAG, "login items is empty, add mobile")
    table.insert(loginItems, {type = "mobile"})
  end
  E.LOG.debug(TAG, {loginItems = loginItems})
  return loginItems
end

function inner_available_login_list()
  local available_login_list = {}
  local login_vendors = EV.get_native_vendors(EV.ABILITY.ACCOUNT)
  E.LOG.debug(TAG, {login_vendors = login_vendors} or {})
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local pure_lua_vendors = EG.get_pure_lua_account_vendors()
  for _, name in ipairs(pure_lua_vendors) do
    local has_contain = false
    for _, item in ipairs(login_vendors) do
      if item and item == name then
        has_contain = true
      end
    end
    if not has_contain then
      table.insert(login_vendors, name)
    end
  end
  local lh = UTILS.deepcopy(OFFICIAL_HISTORY:get()) or {}
  E.LOG.debug(TAG, {OFFICIAL_HISTORY = lh} or {})
  local login_config = UTILS.deepcopy(SC.get("login"))
  E.LOG.debug(TAG, {login_items_config = login_config} or {})
  if login_config and next(login_config) then
    if true == need_sort_login_list() then
      for j = 1, #lh do
        for i = #login_config, 1, -1 do
          local tab = login_config[i]
          if lh[j] == tab.type then
            table.insert(available_login_list, tab)
            table.remove(login_config, i)
            break
          end
        end
      end
    end
    for i = 1, #login_config do
      table.insert(available_login_list, login_config[i])
    end
    UTILS.filter_table(available_login_list, login_vendors, function(available_item, login_item)
      return available_item.type == login_item
    end)
    local last_vendor = LAST_LOGIN_SUCC_VENDOR:get()
    if last_vendor and string.len(last_vendor) > 0 then
      for _, login_item in pairs(available_login_list) do
        if login_item.type == last_vendor then
          login_item.last_login = true
          break
        end
      end
    end
    local pga_login_type = "PGA_LOGIN"
    if EV.has_vendor(pga_login_type) then
      for _, login_item in pairs(available_login_list) do
        if login_item.type == pga_login_type then
          local pga_login = EV.get(pga_login_type)
          local pga_can_continue_login = pga_login.can_pga_autologin() or pga_login.show_continue_login()
          login_item.can_continue_login = pga_can_continue_login
          break
        end
      end
    end
    E.LOG.debug(TAG, {available_login_list = available_login_list})
    return available_login_list
  else
    return available_login_list
  end
end

function inner_login(login_type, ext, cb)
  E.LOG.debug(TAG, " login type=" .. tostring(login_type))
  E.LOG.debug(TAG, "h5给的pass_ext = ")
  E.LOG.debug(TAG, ext)
  M.cache_login_history(login_type)
  ext = ext or {}
  local login_callback
  AL.login(login_type, ext, function(result)
    E.LOG.debug(TAG, "inner_login.login callback, result ==")
    E.LOG.debug(TAG, result)
    if not result then
      cb(PROTOCOL.LoginResult.fail(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_ACCOUNT_RESULT_EMPTY, "Login failed, Account result is empty"))
      return
    end
    if result:is_succ() then
      M.ignore_bind_agst = nil
      M.bind_agst = nil
      M.login_with_challenge_info = nil
    else
      AUTO_LOGIN.clear_last_login()
      if result.code == USER.USER_CENTER_ERROR_CODES.ERR_AGST_ROLE_BIND_CONFLICT then
        function M.ignore_bind_agst(ignore_cb)
          E.LOG.debug(TAG, "ignore_bind_agst called----")
          
          login_callback = ignore_cb
          result.ext.create_new_account()
        end
        
        function M.bind_agst(bind_cb)
          E.LOG.debug(TAG, "bind_agst called----")
          login_callback = bind_cb
          result.ext.bind_agst()
        end
      elseif result.code == USER.USER_CENTER_ERROR_CODES.ERR_NEED_CHALLENGE then
        E.LOG.debug(TAG, "触发风控挑战，设置H5挑战完成的执行函数---")
        
        function M.login_with_challenge_info(challenge_info, challenge_callback)
          E.LOG.debug(TAG, "H5执行完挑战，可以继续后续的登录流程啦")
          login_callback = challenge_callback
          E.LOG.debug(TAG, " result ===")
          E.LOG.debug(TAG, result)
          result.ext.login_with_challenge(challenge_info)
        end
      end
    end
    cb(result, login_callback)
  end)
end

return M
