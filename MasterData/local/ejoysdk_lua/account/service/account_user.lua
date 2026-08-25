local E = require("ejoysdk_lua.ejoysdk")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local LANG = require("ejoysdk_lua.lang.util")
local M = {}
local TAG = "account_user#"

local function is_overseas()
  do return E.CONFIG.get_config end
  return E.CONFIG.get_config, E.CONFIG.KEY.MULTI_REGIONS_ENABLED
end

local function get_frontpage_url()
  local page_url
  if is_overseas() then
    local OFFICIAL = require("ejoysdk_lua.vendors.official")
    page_url = OFFICIAL.get_api_url("login_intercept")
  else
    local AIRLINE_V2 = require("ejoysdk_lua.vendors.airline_v2")
    page_url = AIRLINE_V2.get_api_url("login_intercept")
  end
  return page_url
end

function M.handle_frontpage(frontParams, cb)
  cb = cb or function()
  end
  local realname_handler = require("ejoysdk_lua.realname.ejoysdk_login_intercept")
  local REALNAME_INFO = require("ejoysdk_lua.realname.realname_info")
  local faceverify = require("ejoysdk_lua.vendors.faceverify")
  local support_face = faceverify.is_support_face_verify()
  local should_jump = frontParams and frontParams.susNonage and not support_face
  if should_jump then
    cb(true, realname_handler.USERCENTER_REALNAME_STATUS.STATUS_SUCCESS)
    return
  end
  local user_cancel = frontParams and frontParams.userCancel
  local is_mini_game_os = _ejoysdk.os() == "weixin" or _ejoysdk.os() == "douyin"
  if user_cancel and is_mini_game_os then
    E.LOG.debug(TAG, "account in user cancel, cb fail")
    local title = LANG.getStringSuitCNOverseas("account_in_delete_title", "账号已进入注销流程")
    local ensure_btn_str = LANG.getStringSuitCNOverseas("confirm", "确认")
    local tip_msg = LANG.getStringSuitCNOverseas("account_in_delete_tips", "您正在注销账号，请注意注销期间无法进入游戏。如您需要取消注销流程，请联系客服或在app端重新激活。")
    local param = {
      message = tip_msg,
      buttons = {ensure_btn_str}
    }
    E.Modal.open(title, param, function(answer)
      E.LOG.debug(TAG, "on exit callback >> " .. tostring(answer))
      cb(false, CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_USER_CANCEL_IN_MINI_GAME)
    end)
    return
  end
  if frontParams then
    local scene = realname_handler.SCENE_TYPE.SCENE_AFTER_LOGIN
    local can_close = true
    for _, value in pairs(frontParams) do
      can_close = (value or {}).forceVerify ~= true
    end
    E.LOG.d(TAG, {front_params = frontParams})
    local page_url = get_frontpage_url()
    E.LOG.debug(TAG, "handle overseas realname page, url >> " .. tostring(page_url))
    if E.WebView.is_opened() then
      E.WebView.close()
    end
    ESTAT.sdk_account_pfcomm({
      biz_mod = "intercept",
      biz_func = "sdk.intercept",
      biz_act = "enter",
      biz_params = {page_url = page_url, frontParams = frontParams}
    })
    realname_handler.handle_realname(page_url, scene, can_close, {frontParam = frontParams}, function(status)
      local status_num = tonumber(status)
      local is_success = tostring(status) == realname_handler.USERCENTER_REALNAME_STATUS.STATUS_SUCCESS or status_num == REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_SUCC or status_num == REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_FAILED
      cb(is_success, status)
      ESTAT.sdk_account_pfcomm({
        biz_mod = "intercept",
        biz_func = "sdk.intercept",
        biz_act = "finish",
        biz_st = is_success and "succ" or "fail",
        biz_params = {page_url = page_url, status = status}
      })
    end)
  else
    cb(true, realname_handler.USERCENTER_REALNAME_STATUS.STATUS_SUCCESS)
  end
end

return M
