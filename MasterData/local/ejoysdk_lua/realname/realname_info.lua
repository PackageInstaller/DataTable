local E = require("ejoysdk_lua.ejoysdk")
local RL = require("ejoysdk_lua.realname.realname_adult_limit")
local EM = require("ejoysdk_lua.ejoysdk_module")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local M = {}
local TAG = EM.MODULE.REALNAME .. "info"
M.ERR_CODE_QRCODE_NEED_REALNAME_ADULT = -2007
local is_realname_open = false
local is_enter_game_tips = false
M.REALNAME_RESULT = {
  STATUS_COMPLETE_WITH_REALNAME_SUCC = 1,
  STATUS_COMPLETE_WITH_REALNAME_FAILED = 2,
  STATUS_UNCOMPLETE = 3,
  STATUS_COMPLETE_BIND_PHONE = 4
}
M.LX_REALNAME_STATUS = {
  UNKNOWN = 0,
  SUCCESS = 1,
  FAILED = 2
}
M.REALNAME_STATUS = {
  UNKNOWN = M.LX_REALNAME_STATUS.UNKNOWN,
  SUCCESS = M.LX_REALNAME_STATUS.SUCCESS,
  FAILED = M.LX_REALNAME_STATUS.FAILED
}
M.REALNAME_AGE_STATUS = {
  UNKNOWN = 0,
  ADULT = 1,
  CHILD = 2
}
local current_realname_info = {
  realNameStatus = M.REALNAME_STATUS.UNKNOWN,
  adult = M.REALNAME_AGE_STATUS.UNKNOWN
}
local current_realname_ex

function M.set_realname_info(realname_info)
  E.LOG.debug(TAG, "set_realname_info >>")
  E.LOG.debug(TAG, realname_info)
  current_realname_info = realname_info
  E.LOG.debug(TAG, "set_realname_info with is_enter_game_tips true, init check child limit")
  RL.check_child_limit(realname_info, is_enter_game_tips)
  if realname_info and realname_info.ex then
    current_realname_ex = realname_info.ex
    E.LOG.debug(TAG, "realname ex >>")
    E.LOG.debug(TAG, current_realname_ex)
  end
end

function M.update_realname_status(status)
  E.LOG.debug(TAG, "update_realname_status:" .. (status or "nil"))
  current_realname_info.realNameStatus = status
end

function M.get_realname_status()
  E.LOG.debug(TAG, "获取realname状态：" .. (current_realname_info.realNameStatus or "nil"))
  return current_realname_info.realNameStatus
end

function M.is_realname_open()
  if is_realname_open then
    E.LOG.debug(TAG, "获取realname 是否开启状态: 已开启")
  else
    E.LOG.debug(TAG, "获取realname 是否开启状态: 未开启")
  end
  return is_realname_open
end

function M.get_adult_status()
  E.LOG.debug(TAG, "获取realname 成年状态：" .. (current_realname_info.adult or "nil"))
  return current_realname_info.adult
end

function M.handle_body_realname_info(body)
  if not body or not body.pinfo then
    E.LOG.debug(TAG, "handle_body_realname_info skip, body pinfo is nil")
    return
  end
  E.LOG.debug(TAG, "handle_body_realname_info body.pinfo not empty, start check body.pinfo.attach_info and realnameinfo >>")
  E.LOG.debug(TAG, body.pinfo)
  local attach_info = body.pinfo.attach_info
  if attach_info then
    local switch_value = attach_info.enterGameTipsSwitch
    if nil == switch_value then
      switch_value = false
    end
    is_enter_game_tips = switch_value
    E.LOG.debug(TAG, "handle_body_realname_info is_enter_game_tips:" .. tostring(is_enter_game_tips))
  end
  if attach_info and attach_info.realNameInfo then
    is_realname_open = true
    M.set_realname_info(attach_info.realNameInfo)
    E.LOG.debug(TAG, "handle_body_realname_info, has realname info, now cache realname status:" .. (current_realname_info.realNameStatus or "nil"))
  else
    is_realname_open = false
    E.LOG.warn(TAG, "handle_body_realname_info, realname info is nil, so not cache realname info")
  end
end

function M.get_realname_ex()
  return current_realname_ex or {}
end

function M.check_realname()
  local function qr_realname_stat(_is_realname_open, realname_status, adult_status, is_qrcode_start)
    local params = {
      is_realname_open = _is_realname_open,
      
      realname_status = realname_status,
      adult_status = adult_status,
      is_qrcode_start = is_qrcode_start
    }
    QL.commit_event(QL.EVENT_NAMES.SDK_REALNAME_QRSCAN, params)
  end
  
  local _is_realname_open = M.is_realname_open()
  if _is_realname_open then
    E.LOG.debug(TAG, "realname is open, so check realname and adult status")
    local realname_status = M.get_realname_status()
    E.LOG.debug(TAG, "qrcode_scan realname_status:" .. realname_status)
    if realname_status ~= M.REALNAME_STATUS.SUCCESS then
      E.LOG.warn(TAG, "qrcode_scan user has not realname success, should not scan for windows login")
      qr_realname_stat(true, M.REALNAME_STATUS.UNKNOWN, M.REALNAME_AGE_STATUS.UNKNOWN, false)
      return false, M.ERR_CODE_QRCODE_NEED_REALNAME_ADULT, "用户未实名"
    else
      local adult_status = M.get_adult_status()
      E.LOG.debug(TAG, "qrcode_scan adult status:" .. adult_status)
      if adult_status ~= M.REALNAME_AGE_STATUS.ADULT then
        E.LOG.warn(TAG, "qrcode_scan user is not adult, should not scan for windows login")
        qr_realname_stat(true, M.REALNAME_STATUS.SUCCESS, adult_status, false)
        return false, M.ERR_CODE_QRCODE_NEED_REALNAME_ADULT, "用户未成年"
      end
    end
  else
    E.LOG.debug(TAG, "realname not open, skip and start scan")
  end
  qr_realname_stat(_is_realname_open, M.get_realname_status(), M.get_adult_status(), true)
  E.LOG.debug(TAG, "qrcode_scan now start qrcode scan")
  return true
end

return M
