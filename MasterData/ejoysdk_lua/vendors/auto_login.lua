local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local AL = require("ejoysdk_lua.account.service.account_login")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local LANG = require("ejoysdk_lua.lang.util")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EC = require("ejoysdk_lua.user_center.system_config")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local VENDOR_NAME = "AUTO_LOGIN"
local TAG = VENDOR_NAME .. "#"
local M = Vendor:Inherit(VENDOR_NAME)
local auto_login_mark = E.LazyKeyStore:New("QOOKKA_GAME_AUTO_LOGIN_MARK", false, false, false)
local LAST_OFFICIAL_LOGIN_VENDOR = E.LazyKeyStore:New("LAST_OFFICIAL_LOGIN_VENDOR", false, false, false)

function M.get_last_login_status()
  local last_vendor = LAST_OFFICIAL_LOGIN_VENDOR:get()
  E.LOG.debug(TAG, "last_vendor is " .. tostring(last_vendor))
  local vendor_name = last_vendor
  if not E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    vendor_name = USER.get_vendor_by_third_party_type(last_vendor) or vendor_name
    E.LOG.debug(TAG, "convert vendor name >> " .. tostring(vendor_name))
  end
  local vendor = EV.get(vendor_name)
  local vendor_can_auto_login = true
  if vendor and vendor.can_auto_login then
    vendor_can_auto_login = vendor.can_auto_login()
  end
  E.LOG.debug(TAG, "vendor is " .. tostring(vendor))
  vendor_can_auto_login = last_vendor and string.len(last_vendor) > 0 and true == vendor_can_auto_login
  local vendor_need_sdk_login = false
  if vendor and vendor.need_sdk_login then
    vendor_need_sdk_login = vendor.need_sdk_login()
  end
  return vendor_name, vendor_can_auto_login, vendor_need_sdk_login
end

local function need_channel_login()
  local init_args = E.CONFIG.get_config(E.CONFIG.KEY.INIT_ARGS)
  if type(init_args) == "table" and next(init_args) and type(init_args.channel) == "string" then
    local channel = string.upper(init_args.channel)
    if EV.get(channel) then
      return true, channel
    end
  end
  return false
end

local function can_channel_login()
  local succ, channel = need_channel_login()
  if true == succ then
    local init_args = E.CONFIG.get_config(E.CONFIG.KEY.INIT_ARGS)
    local channel_vendor = EV.get(channel)
    if channel_vendor and channel_vendor.check_args then
      do return channel_vendor.check_args end
      return channel_vendor.check_args, init_args
    end
  end
  return false
end

local function channel_login(cb)
  local need_login, channel = need_channel_login()
  E.LOG.debug(TAG, "channel_login, need_login = " .. tostring(need_login))
  if need_login then
    E.LOG.debug(TAG, "need channel login:" .. channel)
    local params = can_channel_login()
    local tips = "登录失败，请使用DMM GAME PLAYER重新启动游戏"
    if "DMM_LOGIN" == channel then
      tips = LANG.getString("dmm_login_err_msg", tips)
    end
    if params then
      E.LOG.debug(TAG, "can channel login")
      params.autologin = true
      params.login_from = "local"
      AL.login(channel, params, function(result)
        if result and result:is_succ() then
          E.LOG.debug(TAG, "channel login succ")
          cb(result)
        else
          E.LOG.debug(TAG, "channel login fail")
          local err_code = ""
          if result and result.code then
            err_code = [[

code: ]] .. tostring(result.code)
          end
          E.Modal.open("", {
            type = "simple",
            message = tips .. err_code
          }, function()
            cb(PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_DMM_FAILED_NOT_SUPPORT, tips))
          end)
        end
      end)
    else
      E.LOG.debug(TAG, "channel login fail, missing params")
      E.Modal.open("", {type = "simple", message = tips}, function()
        cb(PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_DMM_FAILED_NOT_SUPPORT, "Missing Login Parameters: " .. channel))
      end)
    end
    return true
  end
  cb(nil)
  return false
end

local function auto_login_support(type)
  if not type or "" == type then
    return false
  end
  local THIRDPARTY_APP = {
    ANDROID = {
      GOOGLE_PLAY = "com.google.android.play.games"
    },
    IOS = {}
  }
  local flag
  if _ejoysdk.os() == "android" then
    if "GOOGLE" == type then
      local is_support = UNI.sync_call(type, "SYNC_IS_SUPPORT_PLAY_SERVICE", {})
      return is_support and is_support.supported == true or false
    end
    flag = THIRDPARTY_APP.ANDROID[type]
  elseif _ejoysdk.os() == "ios" then
    flag = THIRDPARTY_APP.IOS[type]
  end
  if flag then
    do return E.Sysinfo.is_app_install end
    return E.Sysinfo.is_app_install, flag, "SYNC_IS_SUPPORT_PLAY_SERVICE", {}
  else
    return true
  end
end

local function try_auto_login_with_config(cb)
  E.LOG.debug(TAG, "try_auto_login_with_config --called")
  local auto_login_config = UTILS.deepcopy(EC.get("autoLogin"))
  E.LOG.debug(TAG, {auto_login_config = auto_login_config})
  if auto_login_config and next(auto_login_config) then
    local login_vendors = EV.get_native_vendors(EV.ABILITY.ACCOUNT)
    E.LOG.debug(TAG, {login_vendors = login_vendors})
    UTILS.filter_table(auto_login_config, login_vendors, function(auto_item, login_item)
      return auto_item.type == login_item and auto_item.type ~= "AIRLINE" and auto_item.type ~= "TWITTER_LOGIN"
    end)
    E.LOG.debug(TAG, {after_auto_login_config = auto_login_config})
    if auto_login_config and next(auto_login_config) then
      for _, login_config in ipairs(auto_login_config) do
        local login_type = login_config.type
        E.LOG.debug(TAG, {login_type = login_type})
        if auto_login_support(login_type) then
          E.LOG.debug(TAG, "login with auto config >> " .. tostring(login_type))
          if "PGA_LOGIN" == login_type and EV.has_vendor(login_type) and not need_channel_login() then
            E.LOG.debug(TAG, "go to PGA_LOGIN")
            local pga_login = EV.get(login_type) or {}
            if pga_login.get_auth_code then
              pga_login.get_auth_code(function(succ, ...)
                if succ then
                  AL.login(login_type, {login_from = "local"}, cb)
                else
                  cb(nil)
                end
              end)
              return
            else
              E.LOG.error(TAG, "go wrong steps, pga_login not implement get_auth_code function")
            end
          else
            E.LOG.debug(TAG, "go to auto config login, login_type = " .. tostring(login_type))
            AL.login(login_type, {login_from = "local"}, cb)
          end
          return
        end
      end
    end
  end
  cb(nil)
end

local function try_auto_login(cb)
  E.LOG.debug(TAG, "try auto login ")
  if not auto_login_mark:get() then
    auto_login_mark:set(1)
    try_auto_login_with_config(cb)
  else
    E.LOG.debug(TAG, "try auto login, auto_login_mark true ")
    cb(nil)
  end
end

function M.need_auto_login_with_vendor_name(vendor_name)
  if _ejoysdk.os() ~= "windows" then
    return false
  end
  local vendor = EV.get(vendor_name)
  if vendor and vendor.is_support_channel_sdk then
    local is_support_channel = vendor.is_support_channel_sdk()
    if not is_support_channel then
      E.LOG.debug(TAG, "do not support channel sdk")
      return false
    end
  end
  local need = false
  local auto_login_config = UTILS.deepcopy(EC.get("autoLogin"))
  local login_config_item = UTILS.deepcopy(EC.get("login"))
  E.LOG.debug(TAG, {autoLogin = auto_login_config})
  E.LOG.debug(TAG, {login = login_config_item})
  if auto_login_config and next(auto_login_config) then
    for _, login_config in ipairs(auto_login_config) do
      local login_type = login_config.type
      if login_type == vendor_name and login_config_item and next(login_config_item) and 1 == #login_config_item then
        local login_item_type = login_config_item[1].type
        need = login_item_type == vendor_name
        return need
      end
    end
  end
  return need
end

local function need_steam_auto_login()
  do return M.need_auto_login_with_vendor_name end
  return M.need_auto_login_with_vendor_name, "STEAM"
end

local function need_epic_auto_login()
  do return M.need_auto_login_with_vendor_name end
  return M.need_auto_login_with_vendor_name, "EPIC"
end

local function need_dmm_auto_login()
  local init_args = E.CONFIG.get_config(E.CONFIG.KEY.INIT_ARGS)
  if type(init_args) == "table" and next(init_args) and type(init_args.channel) == "string" then
    local channel = string.upper(init_args.channel)
    if "DMM_LOGIN" == channel and EV.get(channel) then
      return true
    end
  end
  return false
end

local silent_login_vendor

function M.get_silent_login_vendor()
  if silent_login_vendor then
    return silent_login_vendor
  end
  local ejoysdk_config = require("ejoysdk_lua.ejoysdk_config")
  if ejoysdk_config.has_vendor_config("WEGAME") then
    silent_login_vendor = "WEGAME"
    return silent_login_vendor
  end
  if need_steam_auto_login() then
    silent_login_vendor = "STEAM"
    return silent_login_vendor
  end
  if need_epic_auto_login() then
    silent_login_vendor = "EPIC"
    return silent_login_vendor
  end
  if need_dmm_auto_login() then
    silent_login_vendor = "DMM_LOGIN"
    return silent_login_vendor
  end
  if _ejoysdk.os() == "douyin" then
    silent_login_vendor = "DOUYIN_MINI"
    return silent_login_vendor
  end
  if _ejoysdk.os() == "weixin" then
    silent_login_vendor = "WEIXIN_MINI"
    return silent_login_vendor
  end
  if _ejoysdk.os() == "android" then
    if ejoysdk_config.has_vendor_config("WXMINICLOUDGAME") then
      silent_login_vendor = "WXMINICLOUDGAME"
      return silent_login_vendor
    elseif ejoysdk_config.has_vendor_config("DYMINICLOUDGAME") then
      silent_login_vendor = "DYMINICLOUDGAME"
      return silent_login_vendor
    end
  end
  return nil
end

local function silent_login(callback)
  E.LOG.debug(TAG, "silent login begin, vendor = " .. tostring(silent_login_vendor))
  local params = {}
  params.silent_login = true
  AL.login(silent_login_vendor, params, function(login_result)
    login_result.silent_login = true
    if login_result and login_result:is_succ() then
      E.LOG.debug(TAG, "silent login success, login_result = ")
      E.LOG.debug(TAG, login_result)
      callback(login_result)
    else
      E.LOG.debug(TAG, "auto_login fail, login_result = ")
      E.LOG.debug(TAG, login_result)
      callback(login_result)
    end
  end)
end

function M.is_silent_login()
  return M.get_silent_login_vendor() ~= nil
end

function M.show_retry_login_tips(error_code, ensure_cb)
  if M.get_silent_login_vendor() == "DMM_LOGIN" then
    E.LOG.debug(TAG, "show dmm silent login fail tips")
    local title = LANG.getStringSuitCNOverseas("tips", "登录失败")
    local ensure_btn_str = LANG.getStringSuitCNOverseas("confirm", "确认")
    local tips = "登录失败，请使用DMM GAME PLAYER重新启动游戏"
    tips = LANG.getString("dmm_login_err_msg", tips)
    tips = tips .. "{" .. tostring(error_code) .. "}"
    local param = {
      message = tips,
      buttons = {ensure_btn_str}
    }
    E.Modal.open(title, param, function()
      if ensure_cb then
        ensure_cb()
      end
    end)
  else
    local code_str = error_code or "unknown"
    local title = LANG.getStringSuitCNOverseas("tips", "提示")
    local ensure_btn_str = LANG.getStringSuitCNOverseas("confirm", "确认")
    local tip_msg = LANG.getStringSuitCNOverseas("login_fail_alert_message", "登录失败，请稍后重试")
    if tonumber(code_str) == 5000010 then
      tip_msg = LANG.getStringSuitCNOverseas("login_fail_unpublished", "未在当前区域发行。")
    end
    tip_msg = tip_msg .. "{" .. tostring(code_str) .. "}"
    local param = {
      message = tip_msg,
      buttons = {ensure_btn_str}
    }
    E.Modal.open(title, param, function(answer)
      E.LOG.debug(TAG, "on exit callback >> " .. tostring(answer))
      if ensure_cb then
        ensure_cb()
      end
    end)
  end
end

function M.login(callback)
  if M.get_silent_login_vendor() then
    E.LOG.debug(TAG, "do silent login")
    silent_login(callback)
    return
  end
  local HISTORY = require("ejoysdk_lua.account.official_history")
  local last_vendor, vendor_can_auto_login, vendor_need_sdk_login = M.get_last_login_status()
  E.LOG.debug(TAG, "last login vendor >> " .. tostring(last_vendor) .. " and can auto login >> " .. tostring(vendor_can_auto_login))
  E.LOG.debug(TAG, "vendor_need_sdk_login >> " .. tostring(vendor_need_sdk_login))
  
  local function cb(result)
    if not result or not result:is_succ() then
      M.clear_last_login()
    end
    callback(result)
  end
  
  if true == vendor_can_auto_login then
    E.LOG.debug(TAG, "开始进行last_vendor的自动登录流程---")
    if not E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
      E.LOG.debug(TAG, "国内才需要重新获取login_type")
      last_vendor = LAST_OFFICIAL_LOGIN_VENDOR:get()
      last_vendor = last_vendor and "ST_LOGIN" ~= last_vendor and USER.get_third_party_type_by_vendor(last_vendor) or last_vendor
    end
    E.LOG.debug(TAG, "after convert last vendor is " .. tostring(last_vendor))
    local last_user_info = HISTORY.get_last_login_account()
    local ST_LOGIN = "ST_LOGIN"
    if true == (ST_LOGIN ~= last_vendor) and (last_user_info or {}).login_type == last_vendor then
      last_user_info.st = last_user_info.st or last_user_info.ptoken
      last_user_info.login_from = "local"
      last_vendor = ST_LOGIN
      E.LOG.debug(TAG, "尝试使用ST登录")
    end
    E.LOG.debug(TAG, "last_user_info ===")
    E.LOG.debug(TAG, last_user_info)
    AL.login(last_vendor, last_user_info, cb)
  elseif true == vendor_need_sdk_login then
    E.LOG.debug(TAG, "开始进行last_vendor的sdk登录流程---")
    AL.login(last_vendor, {}, cb)
  else
    try_auto_login(function(result)
      E.LOG.debug(TAG, "try_auto_login, result = ")
      E.LOG.debug(TAG, result)
      if result and result:is_succ() then
        cb(result)
      elseif result and result.code == 4008017 then
        cb(result)
      else
        E.LOG.debug(TAG, "尝试渠道登录-----")
        channel_login(cb)
      end
    end)
  end
end

function M.logout()
  M.opt.logout_listener({})
end

function M.init(opt, cb)
  M.opt = opt
  cb(true)
end

function M.get_last_login()
  do return LAST_OFFICIAL_LOGIN_VENDOR.get end
  return LAST_OFFICIAL_LOGIN_VENDOR.get, LAST_OFFICIAL_LOGIN_VENDOR
end

function M.set_last_login(vendor)
  E.LOG.debug(TAG, "set last login >> " .. tostring(vendor))
  if vendor then
    LAST_OFFICIAL_LOGIN_VENDOR:set(vendor)
  end
end

function M.clear_last_login()
  E.LOG.debug(TAG, "clear_last_login >> ")
  LAST_OFFICIAL_LOGIN_VENDOR:set("")
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.check_token(_outsource, _info)
  M.login()
end

M:is_implemented({
  Vendor.ABILITY.ACCOUNT
})
return M
