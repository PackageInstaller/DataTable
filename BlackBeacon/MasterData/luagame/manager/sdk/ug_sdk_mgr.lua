local Base = require("manager.sdk.base_sdk_mgr")
local M = Util.create_child_mt(Base)
local Json = require("utils.json")
local Account = require("gamelogic.account.account")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local LocalStorage = require("utils.localstorage")
local CSUnityEngine = UnityEngine
local UnityTime = CSUnityEngine.Time
local CSSDKManager = CS.Game.UGSDKManager
local SDKConst = CS.Game.SDKConst
local CSHelper = CS.Game.CSHelper
local Handler = Util.create_class()
local CODE = {SUCCESS = 1, TIME_OUT = 10000}
local UPDATE_INTERVAL = 1
local PLATFORM = Config.PLATFORM

function M:_init()
  Base._Init(self)
  self.v_handler_dic = {}
  CSSDKManager.RegisterLuCallback(function(type, param)
    self:_on_sdk_callback(type, param)
  end)
  self:_init_default_products()
end

local function _log(log, ...)
  if GAME_DEBUG then
    Log.Info("[Lua_SDK] " .. log, ...)
  else
    Log.Info("[Lua_SDK] " .. log)
  end
end

local function _is_success(code)
  return code == CODE.SUCCESS
end

local function _key(module, func)
  return module .. func
end

local PROCESS_TYPE = {AUTO = 1, CUSTOM = 2}
local PROCCESS_FUNC = {
  [SDKConst.Login] = {
    type = PROCESS_TYPE.AUTO,
    timeout = math.huge,
    custom_cb = function(mgr, response)
      mgr:on_sdk_login_success(response)
    end
  },
  [SDKConst.Pay] = {
    type = PROCESS_TYPE.AUTO,
    timeout = math.huge,
    custom_cb = function(mgr, response)
      mgr:on_sdk_logout_success(response)
    end
  }
}

function Handler:_init(mgr, type, cb)
  self.v_mgr = mgr
  self.v_type = type
  self.v_config = PROCCESS_FUNC[type]
  self.v_cb = cb
  self.v_start_time = UnityTime.realtimeSinceStartup
  self.v_time_out = self.v_config and self.v_config.timeout or 60
end

local TIME_OUT_RESPONSE = {
  code = CODE.TIME_OUT,
  msg = "time out"
}

function Handler:_call_time_out()
  self:process(TIME_OUT_RESPONSE)
end

function Handler:process(response)
  if self.v_config == nil or self.v_config.type == PROCESS_TYPE.AUTO then
    if self.v_cb then
      self.v_cb(response)
    end
  else
    local custom_cb = self.v_config and self.v_config.custom_cb
    if custom_cb then
      custom_cb(self.v_mgr, response)
    end
  end
  local event = self.v_config and self.v_config.event
  if event then
    local msg = MsgGame:mq_publish2(event)
    msg.mm_obj = response
  end
end

function Handler:update_time_out(real_time)
  if real_time > self.v_start_time + self.v_time_out then
    self:_call_time_out()
    return true
  end
  return false
end

function Handler:on_destroy()
  self.v_type = nil
  self.v_mgr = nil
  self.v_config = nil
  self.v_cb = nil
end

function M:_on_sdk_callback(type, response)
  _log("on_sdk_callback ", type)
  local config = PROCCESS_FUNC[type]
  local handler = self.v_handler_dic[type]
  if config and handler then
    handler:process(response)
    handler:on_destroy()
    self.v_handler_dic[type] = nil
  elseif config and config.event then
    local msg = MsgGame:mq_publish2(config.event)
    msg.mm_obj = response
  end
end

local _last_update_time = 0

function M:update()
  local real_time = UnityTime.realtimeSinceStartup
  if real_time - _last_update_time < UPDATE_INTERVAL then
    return
  end
  _last_update_time = real_time
  local is_time_out
  for type, handler in pairs(self.v_handler_dic) do
    is_time_out = handler:update_time_out(real_time)
    if is_time_out then
      handler:on_destroy()
      self.v_handler_dic[type] = nil
    end
  end
end

function M:_do_call_sdk_with_cb(type, param, cb)
  CSSDKManager.Call(type, param)
  local config = PROCCESS_FUNC[type]
  if config then
    local handler = Handler:new(self, type, cb)
    self.v_handler_dic[type] = handler
  end
end

function M:logout(is_account_deleted, on_sdk_logout_success)
  if not self:_check_valid() then
    Util.show_notify_popup_message(function()
      if on_sdk_logout_success then
        on_sdk_logout_success()
      end
    end, "退出登录", "登出", "确定", "取消", nil, false)
    return
  end
  CSSDKManager.Call(SDKConst.Logout)
  if on_sdk_logout_success then
    on_sdk_logout_success()
  end
end

function M:login(cb)
  if not self:_check_valid() then
    if cb then
      cb(false)
    end
    return
  end
  self:_do_call_sdk_with_cb(SDKConst.Login, nil, cb)
end

function M:on_sdk_login_success(sdk_response)
  Base.on_sdk_login_success(self, sdk_response)
  self.v_sdk_user_id = sdk_response.userID
  self.v_sdk_token = sdk_response.token
  self.v_is_new_account = sdk_response.newAccount and sdk_response.newAccount == "1"
end

function M:on_sdk_logout_success(sdk_response)
  Base.on_sdk_logout_success(self, sdk_response)
  self.v_sdk_user_id = nil
  self.v_sdk_token = nil
  self.v_is_new_account = nil
end

function M:_submit_role_data(type)
  if not self:_check_valid() then
    return
  end
  local connect_info = Global.connect_info
  local base_info = PlayerMgr:get_player_base_info()
  local role_id = Global.player_uuid
  local role_name = base_info.name
  local role_level = base_info.lv
  local vip_grade = 0
  local server_id = 0
  local server_name = connect_info.name
  local create_role_time = base_info.create_time
  local last_level_up_time = base_info.create_time
  local param = {
    [SDKConst.type] = tostring(type),
    [SDKConst.roleID] = role_id,
    [SDKConst.roleName] = role_name,
    [SDKConst.roleLevel] = role_level,
    [SDKConst.serverID] = server_id,
    [SDKConst.serverName] = server_name,
    [SDKConst.vip] = vip_grade,
    [SDKConst.createTime] = create_role_time,
    [SDKConst.lastLevelUpTime] = last_level_up_time
  }
  _log("call SubmitRoleData", param)
  CSSDKManager.Call(SDKConst.SubmitRoleData, param)
end

function M:enter_game()
  self:_submit_role_data(SDKConst.TYPE_ENTER_GAME)
end

function M:exit_game()
  self:_submit_role_data(SDKConst.TYPE_EXIT_GAME)
end

function M:create_role()
  self:_submit_role_data(SDKConst.TYPE_CREATE_ROLE)
end

function M:level_up()
  self:_submit_role_data(SDKConst.TYPE_LEVEL_UP)
end

function M:has_user_center()
  _log("call has_user_center")
  return self:_check_valid()
end

function M:open_user_center()
  if not self:_check_valid() then
    return
  end
  _log("call open_user_center")
  CSSDKManager.Call(SDKConst.ShowUserCenter)
end

do
  local DEF_URL = "https://playhub.wjx.cn/vm/OlGicbS.aspx# "
  local UnityApplication = UnityEngine.Application
  
  function M:open_web_view(url)
    if url and "" ~= url then
      UnityApplication.OpenURL(url)
    end
  end
  
  function M:open_help_center()
  end
  
  function M:open_notice(is_before_login, is_force)
  end
  
  function M:close_notice()
  end
  
  function M:qq_join_group()
  end
  
  function M:add_login_request_params(body)
    if not self:_check_valid() then
      return
    end
    Base.add_login_request_params(self, body)
    if ENABLE_TA_TRACK then
      body.channel = SDKTrack:get_distinct_id()
      body.device_id = SDKTrack:get_preset_properties("device_id")
      body.os_version = SDKTrack:get_preset_properties("os_version")
      body.app_version = SDKTrack:get_preset_properties("app_version")
      body.system_language = SDKTrack:get_preset_properties("system_language")
      body.device_model = SDKTrack:get_preset_properties("device_model")
      body.network_type = SDKTrack:get_preset_properties("network_type")
      body.ip = SDKTrack:get_preset_properties("ip")
    end
  end
end

function M:get_sub_channel_id()
end

function M:get_login_game_server_url(host)
  local device_type = Account:get_device_type()
  local account = Account:get_account()
  local mac_address = UnityEngine.SystemInfo.deviceUniqueIdentifier
  local host_content = host .. "platform=%s&device_type=%s&account_id=%s&mac_address=%s&version=%s&auth_token=A9Cz4sv0O8"
  local url
  host_content = host_content .. "&sdk_token=%s"
  url = string.format(host_content, self.v_platform, device_type, account, mac_address, Util.get_version_str(), self.v_sdk_token)
  return url
end

function M:get_server_list_json_url()
  local url = "https://fxcdn.mingzhougame.com/server-list/server_list.json?time=" .. Date.server_time()
  return url
end

function M:get_notice_url(picture)
  local file = picture or "maintenance_notice.json"
  local url = "https://fxcdn.mingzhougame.com/notice/%s/%s?time=" .. Date.server_time()
  if GAME_DEBUG then
    url = string.format(url, "debug", file)
  else
    url = string.format(url, "release", file)
  end
  return url
end

return M
