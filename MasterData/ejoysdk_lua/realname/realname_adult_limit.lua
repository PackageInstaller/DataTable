local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.REALNAME .. "adult_limit"
local ADULT_STATUS = {
  UNKNOWN = 0,
  ADULT = 1,
  CHILD = 2
}
local ENV = {
  RELEASE = "RELEASE",
  PRE = "PRE",
  TEST = "TEST"
}
local CHILD_LIMIT_PAGE = {
  [ENV.RELEASE] = "https://act.lingxigames.com/anti-addiction/#/nonage_tips",
  [ENV.PRE] = "https://act-pre.lingxigames.com/anti-addiction/#/nonage_tips",
  [ENV.TEST] = "http://render-test.aligames.com/common/anti_nonage_tips/index.html"
}
local current_env = ENV.RELEASE
local child_limit_page_url = CHILD_LIMIT_PAGE[current_env]
local current_realname_info
local M = {}

local function handle_child_acquire_succ(_user_info)
  local params = {realNameInfo = current_realname_info}
  
  local function on_js_callback(value)
    E.LOG.debug(TAG, "on_js_callback >>")
    E.LOG.debug(TAG, value)
  end
  
  local function on_close_callback(value)
    E.LOG.debug(TAG, "on_close_callback >>")
    E.LOG.debug(TAG, value)
  end
  
  E.open_webview(child_limit_page_url, {}, params, nil, on_js_callback, on_close_callback)
end

local function reset_child_check_status()
  current_realname_info = nil
  ET.unsubscribe(ET.gangplank.ACQUIRE, handle_child_acquire_succ)
  E.LOG.debug(TAG, "cancel listen acquire succ")
end

function M.check_child_limit(realname_info, is_enter_game_tips)
  reset_child_check_status()
  if not realname_info or next(realname_info) == nil then
    E.LOG.debug(TAG, "check_adult_limit skip, realname info is nil")
    return
  end
  local adult_status = realname_info.adult
  local needShowChildDialog = adult_status == ADULT_STATUS.CHILD
  E.LOG.debug(TAG, "check_adult_limit needShowChildDialog:" .. tostring(needShowChildDialog))
  current_realname_info = realname_info
  if is_enter_game_tips and needShowChildDialog then
    ET.subscribe(ET.gangplank.ACQUIRE, handle_child_acquire_succ)
    E.LOG.debug(TAG, "begin listen acquire succ")
  end
end

return M
