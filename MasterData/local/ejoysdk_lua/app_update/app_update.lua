local E = require("ejoysdk_lua.ejoysdk")
local ELU = require("ejoysdk_lua.lang.util")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local M = {}
M.KEY = {
  MSG = "msg",
  UPDATE_URL = "updateUrl",
  IS_NEED_UPDATE = "is_need_update",
  FORCE_UPDATE = "force_update"
}
M.CONFIG_KEY = {
  KEY_UPDATE_INFO_DOWN_URL = "LauncherDownloadUrl",
  KEY_UPDATE_INFO_VER_CODE = "LauncherVersionCode",
  KEY_UPDATE_INFO_FORCE = "forceUpdate",
  KEY_UPDATE_MESSAGE = "LauncherUpdateMessage"
}
local TAG = EM.MODULE.APP_UPDATE .. "app_update"
local windows_alert_cb, pc_param
local has_checked = false

local function suit_android_channel_bind_account_url(url)
  local bind_domain = "changeworld.lingxigames.com"
  local startPos = string.find(url, bind_domain)
  local endPos
  if _ejoysdk.os() == "android" and startPos then
    E.LOG.debug(TAG, "当前下发的URL包含特殊域名，需要解析出实际的URL做特殊跳转处理")
    local match_str = "redirectUrl="
    startPos, endPos = string.find(url, match_str)
    if startPos and endPos then
      local result = string.sub(url, endPos + 1)
      E.LOG.debug(TAG, "匹配到的内容: " .. result)
      local LOGIN_HISTORY = require("ejoysdk_lua.account.official_history")
      local last_login_acount = LOGIN_HISTORY.get_last_login_account_with_init_check()
      E.LOG.debug(TAG, {
        last_login_acount = last_login_acount or {}
      })
      if last_login_acount then
        result = result .. "&account_id=" .. last_login_acount.uid
      end
      url = result
      E.LOG.debug(TAG, "拼接好后用来跳转的url = " .. tostring(url))
    else
      E.LOG.error(TAG, "下发的URL出错了，不包含跳转的字符串redirectUrl，无法匹配")
      E.LOG.error(TAG, {url = url})
    end
  end
  return url
end

local function openURLUpdateApp(url)
  if _ejoysdk.os() == "harmonyos" then
    E.Timer.once(1, function()
      E.Sysinfo.go_to_app_market()
    end)
    return
  end
  local tap_update = require("ejoysdk_lua.vendors.taptap")
  if tap_update.check_if_tap_update() then
    E.LOG.debug(TAG, "launch tap update")
    tap_update.launch_tap_update()
  else
    E.LOG.debug(TAG, "openURLUpdateApp url:" .. tostring(url))
    url = suit_android_channel_bind_account_url(url)
    E.Sysinfo.open_url(url)
  end
end

local function forceOpenModalView(title, param, url)
  param.closeable = false
  E.Modal.open(title, param, function(_answer)
    forceOpenModalView(title, param, url)
    openURLUpdateApp(url)
  end)
end

local function open_modal_with_data(data, cb)
  local title = ELU.getStringSuitCNOverseas("tips", "")
  local message = data.msg or "发现新的版本"
  local url = data.updateUrl
  local is_need_update = data.is_need_update
  local force_update = data.force_update
  local string = string.format("open_modal_with_data, is need updte = %s, forceupdate = %s", tostring(data.is_need_update), tostring(data.force_update))
  E.LOG.debug(TAG, string)
  local update_now_str = ELU.getStringSuitCNOverseas("update_now", "")
  local cancel_str = ELU.getStringSuitCNOverseas("cancel", "")
  if force_update then
    local param
    if E.Sysinfo.os() == "windows" then
      param = {
        message = message,
        buttons = {update_now_str}
      }
    elseif E.Sysinfo.os() == "harmonyos" then
      param = {
        message = message,
        style = "harmonyos",
        buttons = {update_now_str}
      }
    else
      param = {
        message = message,
        buttons = {update_now_str}
      }
    end
    if E.Sysinfo.os() == "windows" and windows_alert_cb then
      E.LOG.debug(TAG, "windows_alert_cb >> callback")
      windows_alert_cb(data, function(succ, ...)
        if succ then
          E.LOG.debug(TAG, "windows_alert_cb succ")
        else
          local code, msg = ...
          E.LOG.warn(TAG, "windows_alert_cb failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
        if cb then
          cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_FORCE_UPDATE, "force update close")
        end
      end)
    elseif E.Sysinfo.os() == "harmonyos" then
      local LIGHTBOAT = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
      local AIRLINE_V2 = require("ejoysdk_lua.vendors.airline_v2")
      local login_url = AIRLINE_V2.get_login_url()
      local local_url = LIGHTBOAT.get_url_from_cache(login_url)
      E.WebView.remove_cache(login_url)
      E.WebView.remove_cache(local_url)
      E.Timer.once(1, function()
        forceOpenModalView(title, param, url)
      end)
    else
      E.LOG.debug(TAG, "forceOpenModalView >> " .. tostring(title))
      forceOpenModalView(title, param, url)
    end
  elseif is_need_update then
    local param
    if E.Sysinfo.os() == "windows" then
      param = {
        message = message,
        buttons = {cancel_str, update_now_str}
      }
    else
      param = {
        message = message,
        buttons = {cancel_str, update_now_str}
      }
    end
    if E.Sysinfo.os() == "windows" and windows_alert_cb then
      windows_alert_cb(data, function(_succ, ...)
        if cb then
          cb(true)
        end
      end)
    else
      E.Modal.open(title, param, function(answer)
        E.LOG.debug(TAG, "confirm dialog closed, user answer: " .. tostring(answer))
        local value = tostring(answer)
        if "1" == value then
          openURLUpdateApp(url)
        end
        if cb then
          cb(true)
        end
      end)
    end
  elseif cb then
    cb(true)
  end
end

function M.check_update_info(update_info, cb)
  local app_ver_code = E.Sysinfo.app_version_code()
  local new_app_ver_code = update_info[M.CONFIG_KEY.KEY_UPDATE_INFO_VER_CODE] or 0
  local update_url = update_info[M.CONFIG_KEY.KEY_UPDATE_INFO_DOWN_URL] or nil
  local update_msg = update_info[M.CONFIG_KEY.KEY_UPDATE_MESSAGE]
  local has_update = nil ~= update_url and "" ~= update_url and app_ver_code < new_app_ver_code
  local force_update = update_info[M.CONFIG_KEY.KEY_UPDATE_INFO_FORCE] or false
  if has_update then
    E.LOG.debug(TAG, "check_app_update has update, now begin update")
    
    local function update_cb(succ, ...)
      E.LOG.debug(TAG, "open_app_update_modal result:" .. tostring(succ))
      cb(succ, ...)
    end
    
    local update_params = {
      [M.KEY.FORCE_UPDATE] = force_update,
      [M.KEY.IS_NEED_UPDATE] = true,
      [M.KEY.MSG] = update_msg,
      [M.KEY.UPDATE_URL] = update_url
    }
    M.open_app_update_modal(update_params, update_cb)
  else
    E.LOG.debug(TAG, "check_app_update skip, no update")
    cb(true)
  end
end

function M.open_app_update_modal(params, cb)
  open_modal_with_data(params, cb)
end

local function _check_update_app_version(cb)
  local API = require("ejoysdk_lua.user_center.usercenter_api")
  local callBackAlready = false
  E.Timer.once(5, function()
    if callBackAlready then
      return
    end
    callBackAlready = true
    if cb then
      E.LOG.warn(TAG, "request app update timeout")
      ESTAT.stat_action_fail("sdk_app_update_failed", nil, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_REQUEST_TIMEOUT, "request app update timeout")
      cb(true)
    end
  end)
  local params = {
    versionCode = E.Sysinfo.app_version_code(),
    versionName = E.Sysinfo.app_version_name() or "0",
    packageName = E.Sysinfo.package_name()
  }
  if E.Sysinfo.os() == "windows" then
    pc_param = pc_param or {}
    params.versionCode = pc_param.app_version_code or E.Sysinfo.app_version_code()
    params.versionName = pc_param.app_version_name or E.Sysinfo.app_version_name() or "0"
    params.packageName = pc_param.package_name or E.Sysinfo.package_name()
  end
  if E.Sysinfo.os() == "android" then
    local aligames = require("ejoysdk_lua.vendors.aligames")
    if aligames.is_delete_app_update() then
      E.log("aligames is delete app update")
      params.update_apply_for_aligames = 1
    end
  end
  E.LOG.debug(TAG, "start check version update")
  API.usercenter_check_version_update(params, function(succ, ...)
    E.LOG.debug(TAG, "check_version_update callback finish, succ=" .. tostring(succ))
    if callBackAlready then
      return
    end
    callBackAlready = true
    if succ then
      local data = (...)
      if data then
        E.LOG.debug(TAG, data)
        if 1 == data.isNeedUpdate then
          data.is_need_update = true
        end
        if 0 == data.updateType then
          data.force_update = true
        end
      end
      open_modal_with_data(data, cb)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "code = " .. tostring(code) .. ", msg = " .. msg)
      if cb then
        E.LOG.warn(TAG, "request app update failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        ESTAT.stat_action_fail("sdk_app_update_failed", nil, code, msg)
        cb(true)
      end
    end
  end)
end

function M.check_update_app_version(cb)
  has_checked = true
  if EGC.is_gangplank_config_enabled() and EGC.get_current_cdn_config() == nil then
    E.LOG.warn(TAG, "check_update_app_version begin with cdn config is nil, now init again")
    EGC.init_config(function(succ, ...)
      if succ then
        _check_update_app_version(cb)
      else
        local code, msg = ...
        E.LOG.warn(TAG, "check_update_app_version init cdn config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if cb then
          cb(false, code, msg)
        end
      end
    end)
  else
    E.LOG.debug(TAG, "check_update_app_version again")
    _check_update_app_version(cb)
  end
end

function M.is_app_update_checked()
  local UNI = require("ejoysdk_lua.vendors.unisdk")
  local display_sdk_infos = UNI.get_sdk_infos() or {}
  if display_sdk_infos.OTHERS ~= nil then
    local app_update_switch_on = E.CONFIG.get_config(E.CONFIG.KEY.APP_VERSION_UPDATE_CHECK) or false
    E.LOG.debug(TAG, "app_update_switch_on:" .. tostring(app_update_switch_on) .. ", has_checked:" .. tostring(has_checked))
    if not app_update_switch_on then
      return true
    end
  end
  return has_checked
end

function M.set_windows_alert_callback(param, cb)
  E.LOG.debug(TAG, "set set_windows_alert_callback")
  pc_param = param
  windows_alert_cb = cb
  if E.Sysinfo.os() == "windows" then
    if not pc_param.app_version_code then
      E.LOG.debug(TAG, "PC 需要传入app_version_code !!!")
    else
      E.CONFIG.set_config("app_version_code", pc_param.app_version_code)
    end
    if not pc_param.app_version_name then
      E.LOG.debug(TAG, "PC 需要传入app_version_name !!!")
    else
      E.CONFIG.set_config("app_version_name", pc_param.app_version_name)
    end
    if not pc_param.package_name then
      E.LOG.debug(TAG, "PC 需要传入package_namee !!!")
    else
      E.CONFIG.set_config("package_name", pc_param.package_name)
    end
  end
end

function M.skip_app_update()
  if _ejoysdk.os() == "weixin" or _ejoysdk.os() == "douyin" then
    E.LOG.debug(TAG, "wx or dy mini game do not check app update")
    return true
  end
  return false
end

function M._test_reset_has_checked_update()
  has_checked = false
end

return M
