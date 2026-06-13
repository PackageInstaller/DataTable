local LocalStorage = require("utils.localstorage")
local CSSDKManager = CS.Game.SDKManager
local Account = require("gamelogic.account.account")
local UnitySystemInfo = UnityEngine.SystemInfo
local M = {}
local PLATFORM = Config.PLATFORM

local function _log(log, ...)
  if GAME_DEBUG then
    Log.Info("[Lua_SDK_Track] " .. log, ...)
  end
end

local function is_true(value)
  return true == value or 1 == value
end

function M:_init()
  self.v_finished_guide_steps = {}
end

function M:is_use_sdk()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    return false
  end
  return SDKManager:is_use_sdk()
end

function M:enable_td_analytics_log(is_enable)
  CSSDKManager.EnableTDAnalyticsLog(is_enable)
end

function M:_check_valid()
  return self:is_use_sdk()
end

function M:_inner_track(evt_name, param, need_override_super_prop, is_tsi_track_only)
  if not self:_check_valid() then
    return
  end
  _log("call track:", evt_name, param)
  if need_override_super_prop then
    self:_set_super_properties()
  end
  is_tsi_track_only = is_tsi_track_only or false
  CSSDKManager.Track(evt_name, param, is_tsi_track_only)
end

function M:_inner_track_with_arr(evt_name, param, arr_param, need_override_super_prop, is_tsi_track_only)
  if not self:_check_valid() then
    return
  end
  _log("call track_with_arr", evt_name, param)
  if need_override_super_prop then
    self:_set_super_properties()
  end
  is_tsi_track_only = is_tsi_track_only or false
  CSSDKManager.TrackWithArray(evt_name, param, arr_param, is_tsi_track_only)
end

function M:_inner_track_super_properties(param)
  if not self:_check_valid() then
    return
  end
  _log("call track_super_properties", param)
  CSSDKManager.SetSuperProperties(param)
end

function M:trace_guide_step_finish(tutorial_id, duration)
  assert(tutorial_id)
  assert(duration)
  local pre_finish_frame = self.v_finished_guide_steps[tutorial_id]
  if pre_finish_frame and pre_finish_frame == Global.frame_id then
    return
  end
  self.v_finished_guide_steps[tutorial_id] = Global.frame_id
  self:_inner_track("tutorial", {tutorial_id = tutorial_id, duration = duration})
end

local properties_param = {}

function M:_get_ta_super_properties()
  UtilTable.clear_map(properties_param)
  properties_param.client_version = Util.get_version_str()
  properties_param.uuid = tostring(Global.player_uuid)
  if PlayerMgr then
    local base_info = PlayerMgr:get_player_base_info()
    properties_param.level = base_info.lv
    properties_param.exp = base_info.exp
    properties_param.name = base_info.name
  end
  if BagMgr then
    properties_param.keystone_piece = BagMgr:get_item_num(Config.DIAMOND_ITEMID)
    properties_param.keystone = BagMgr:get_item_num(Config.GILTGOLD_ITEMID)
    properties_param.aure = BagMgr:get_item_num(Config.COIN_ITEMID)
    properties_param.roll = {
      [tostring(Config.NORMAL_ROLL_ITEMID)] = tostring(BagMgr:get_item_num(Config.NORMAL_ROLL_ITEMID)),
      [tostring(Config.SPECIAL_ROLL_ITEMID)] = tostring(BagMgr:get_item_num(Config.SPECIAL_ROLL_ITEMID))
    }
  end
  return properties_param
end

function M:_get_tsi_super_propertues()
  UtilTable.clear_map(properties_param)
  properties_param.server = Global.connect_info and Global.connect_info.name
  properties_param.uuid = tostring(Global.player_uuid)
  properties_param.level = PlayerMgr:get_role_lv()
  properties_param.name = PlayerMgr:get_player_name()
  return properties_param
end

function M:_set_super_properties()
  if ENABLE_TA_TRACK then
    self:_inner_track_super_properties(self:_get_ta_super_properties())
  end
  if ENABLE_TSI_TRACK then
    self:_inner_track_super_properties(self:_get_tsi_super_propertues())
  end
end

function M:get_preset_properties(prop_name)
  if not self:_check_valid() or not ENABLE_TA_TRACK then
    return
  end
  return CSSDKManager.GetPresetProperties(prop_name)
end

function M:user_set(param)
  if not self:_check_valid() or not ENABLE_TA_TRACK then
    return
  end
  CSSDKManager.UserSet(param)
end

function M:user_set_once(param)
  if not self:_check_valid() or not ENABLE_TA_TRACK then
    return
  end
  CSSDKManager.UserSetOnce(param)
end

function M:set_shushu_user_datas()
  if not self:_check_valid() or not ENABLE_TA_TRACK then
    return
  end
  local user_set_once_data = {}
  user_set_once_data.channel = SDKManager:get_sub_channel_id() or ""
  self:user_set_once(user_set_once_data)
  local user_set_data = {}
  user_set_data.client_version = Util.get_version_str()
  user_set_data.network_type = self:get_preset_properties("network_type")
  user_set_data.platform = self:get_preset_properties("os")
  user_set_data.ip = self:get_preset_properties("ip")
  self:user_set(user_set_data)
  self:track_device_data()
end

function M:set_account_id()
  if not self:_check_valid() then
    return
  end
  if ENABLE_TA_TRACK and Account:is_new_register_account() then
    self:_inner_track("new_uid", {})
    local param = {
      register_time = Date.server_time(),
      device_id = self:get_preset_properties("device_id")
    }
    self:user_set_once(param)
  end
  CSSDKManager.SetAccountId(tostring(Global.player_uuid))
end

function M:get_distinct_id()
  return CSSDKManager.GetDistinctId()
end

function M:track_event(evt_name, param)
  if not self:_check_valid() then
    return
  end
  self:_inner_track(evt_name, param)
end

function M:trace_change_room(data)
  assert(data)
end

function M:trace_fight_state_change(data)
  assert(data)
end

function M:trace_pick_item(data)
  assert(data)
end

function M:trace_story(data, arr_data)
  assert(data)
  assert(arr_data)
  self:_inner_track_with_arr("plot", data, arr_data, false, SDKManager:is_enable_ta_story_track())
end

function M:trace_teaching_battle(data)
  assert(data)
end

function M:track_loading(loading_name, loading_id)
  if not self:_check_valid() then
    return
  end
  CSSDKManager.TrackLoading(loading_name, loading_id)
end

function M:trace_guid_data(data)
  assert(data)
  self:_inner_track("tutorial", data, false, SDKManager:is_enable_ta_guide_track())
end

function M:trace_login()
  if ENABLE_TSI_TRACK then
    self:_set_super_properties()
    CS.Game.TSISDKManager.LoginEvent()
  end
end

function M:trace_logout()
end

function M:trace_upgrade(trace_data)
  assert(trace_data)
  if ENABLE_TSI_TRACK then
    self:_set_super_properties()
    CS.Game.TSISDKManager.UpgradeRoleEvent()
  end
end

function M:trace_create_role()
  if ENABLE_TSI_TRACK then
    self:_set_super_properties()
    CS.Game.TSISDKManager.RegisterEvent()
  end
end

function M:track_device_data()
  local default_quality_level = Global.render_mgr:try_get_quality_level_from_config()
  self:_inner_track("device_info", {
    gpu_name = UnitySystemInfo.graphicsDeviceName,
    default_quality = default_quality_level
  })
end

return M
