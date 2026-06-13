local Base = require("ui.model_rt_view.signboard_rt_view_new")
local M = Util.create_child_mt(Base)
local CSShadow = CS.Game.Shadow
local CSUnityEngine = UnityEngine
local Gyro = CSUnityEngine.Input.gyro
local UnityFind = _ENV.UnityFind
local SceneIlluminationInfo = CS.SceneIlluminationInfo
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local TypePlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
local Math = require("base.mathx")
local _lerp = Math.lerp_number
local _abs = math.abs
local _slower = string.lower
local Model_Rotate_Anim_Time = 0.5
local Vec3 = require("base.vec3")
local DESIGN_RATIO = 1.7777777777777777
local SignBoardGirlMgr = _ENV.SignBoardGirlMgr

local function almost_zero_angle(a, b)
  local diff = _abs(a - b)
  return diff < 0.01 or diff > 359.99
end

local UI_WORLD_CONNNECT = {
  {
    ui_name = "BtnMainLine",
    scene_obj_name = "MainLinePos"
  },
  {
    ui_name = "BtnActMain",
    scene_obj_name = "MainLinePos"
  },
  {ui_name = "BtnNovice", scene_obj_name = "NovicePos"},
  {
    ui_name = "ActBanner",
    scene_obj_name = "ActBannerPos"
  },
  {
    ui_name = "BtnChouka",
    scene_obj_name = "DrawCardPos"
  },
  {
    ui_name = "BtnBuilding",
    scene_obj_name = "BuildingPos"
  },
  {
    ui_name = "BtnMonthTask",
    scene_obj_name = "NoticePos"
  }
}
local UI_REVERSE_LIGHT = {uimain_close = 1, char_archive = 1}

function M:_init(...)
  self.v_gyro_speed = ShareRes.get_comm_value("MainSceneGyroParam1")
  self.v_gyro_range = ShareRes.get_comm_value("MainSceneGyroParam2")
  self.v_gyro_cold = ShareRes.get_comm_value("MainSceneGyroParam3")
  self.v_gyro_threshold = ShareRes.get_comm_value("MainSceneGyroParam4")
  self.v_gyro_reset_speed = ShareRes.get_comm_value("MainSceneGyroParam5")
  self.v_clock_hand_speed = ShareRes.get_comm_value("MainSceneClockSpeed")
  Base._init(self, ...)
  self:init_container()
  self.v_vcamera_brain = self.v_camera:GetComponent(TypeCinemachineBrain)
  if self.v_vcamera_brain then
    self.v_vcamera_brain.enabled = false
  end
end

function M:update()
  if not SignBoardGirlMgr:is_can_update() then
    return
  end
  if not self.v_is_visible then
    return
  end
  for key, npc in pairs(self.v_npc_loaded_map) do
    npc.act_ctrl:update()
  end
  self:camera_update()
  self:_play_anim()
  self:_play_effect()
  self:lie_anim_update()
  self:model_update()
  local list = self.v_npc_loaded_map
  local cur_ui = UIMgr:get_cur_show_ui_name()
  local count = 0
  for index, npc in pairs(list) do
    local npc_id = npc.character_cfg.NpcId
    if npc_id == PlayerMgr:get_signboard_girl_id() then
      local trans = npc.transform
      local _, angle_y = trans:GetEulerAnglesA3()
      self:_update_light(angle_y)
      if UI_REVERSE_LIGHT[cur_ui] then
        CSShadow.RenderShadowMap(trans, true, -1)
      else
        local shadow_size = 1
        if self.v_cur_inui == "KB1" or self.v_cur_inui == "uimain" then
          shadow_size = 3
        end
        CSShadow.RenderShadowMap(trans, true, 1, true, shadow_size)
      end
      local shadow_cfg = ShareRes.get_role_shadow_cfg(npc.model_cfg.ModelId)
      if shadow_cfg then
        CSShadow.RenderShadowMap2(trans, true, 1, true, shadow_cfg.CameraHeight, shadow_cfg.LookAtHeight)
      else
        CSShadow.RenderShadowMap2(trans, true)
      end
    end
    count = count + 1
  end
  if UI_REVERSE_LIGHT[cur_ui] then
    self:open_self_shadow(true)
  elseif count ~= self.v_length_of_set_shadow then
  end
  self:_gyro_update()
  self:update_clock()
  self:update_uimain_btn_pos()
  self:bloom_update()
end

function M:set_gyro_param_by_config(camera_state)
  local path = "signboard_girl.signboard_girl_gyro_param"
  local cfg = ShareRes.create(path, camera_state % 100)
  self.v_gyro_speed = cfg.Speed
  self.v_gyro_range = cfg.AngleLimit
  self.v_gyro_cold = cfg.CoolDownTime
  self.v_gyro_threshold = cfg.Threshold
  self.v_gyro_reset_speed = cfg.ResetSpeed
end

function M:init_container()
  self.v_main_scene_init_done = true
  if not SceneMgr:check_main_scene_loaded() then
    self.v_main_scene_init_done = false
    return
  end
  local root_gameobj = UnityFind("Root")
  if self:check_assert(root_gameobj) then
    return
  end
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  if self:check_assert(self.v_container) then
    return
  end
  local minute_hand = self.v_container:Get("MinuteHand")
  local hour_hand = self.v_container:Get("HourHand")
  if self:check_assert(minute_hand and hour_hand) then
    return
  end
  self.v_minute_hand = minute_hand.transform
  self.v_hour_hand = hour_hand.transform
end

function M:check_assert(condition)
  if not condition then
    self.v_main_scene_init_done = false
    return true
  end
end

function M:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function M:open_self_shadow(is_on, force)
  if is_on == self.v_self_shadow and not force then
    return
  end
  local list = self.v_npc_loaded_map
  local count = 0
  for _, npc in pairs(list) do
    local trans = npc.transform
    Util.set_all_mat(trans, function(mat)
      local name = _slower(mat.name)
      local not_need_shadow = string.match(name, "eye")
      mat:SetKeyword("_SHADOW_RECEIVE", not not_need_shadow and is_on)
    end)
    count = count + 1
  end
  self.v_length_of_set_shadow = count
  self.v_self_shadow = is_on
end

function M:change_npc_rotate_param(x, y, z, anim_name)
  self:clear_sequence()
  local sequence = Util.create_sequence()
  local euler = Vec3.New(x, y, z)
  for _, npc in pairs(self.v_npc_loaded_map) do
    local go = npc.gameobj
    if go and not go:IsNull() then
      sequence:Join(go.transform:DORotate(euler, Model_Rotate_Anim_Time))
    end
  end
  self.v_sequence = sequence
  if anim_name then
    sequence:OnComplete(function()
      self:play_npc_anim(anim_name, true)
    end)
  end
end

function M:world_to_screen_pos(canvas, x, y, z)
  return UtilUI.world_to_screen_pos(self.v_camera, canvas, x, y, z)
end

function M:screen_point_to_ray(vec2_pos)
  return self.v_camera:ScreenPointToRay(vec2_pos)
end

function M:bind_uimain(uimain)
  if not SceneMgr:check_main_scene_loaded() then
    self.v_main_scene_init_done = false
    return
  end
  if not self.v_main_scene_init_done then
    self:init_container()
    return
  end
  local uimain = uimain
  local uimain_uiobj = uimain.v_uiobjects
  self.v_uimain_canvas = uimain:get_canvas(nil, uimain.v_object)
  self.v_ui_world_connect = {}
  for i, value in pairs(UI_WORLD_CONNNECT) do
    local ui_btn_obj = uimain_uiobj[value.ui_name]
    local ui_btn_rect_trans = Util.get_rect_transform(nil, ui_btn_obj)
    local world_attach_trans = self.v_container:Get(value.scene_obj_name).transform
    self.v_ui_world_connect[i] = {ui_btn_rect_trans = ui_btn_rect_trans, world_attach_trans = world_attach_trans}
    local scale = 1
    if Global.screen_ratio < DESIGN_RATIO then
      if Global.screen_ratio <= 1.5 then
        scale = 1.56 / Global.screen_ratio
      else
        scale = DESIGN_RATIO / Global.screen_ratio
      end
    end
    ui_btn_rect_trans:SetLocalScaleA(scale, scale, 1)
  end
  self:update_uimain_btn_pos()
end

function M:update_uimain_btn_pos()
  if not self.v_ui_world_connect or not self.v_uimain_canvas then
    return
  end
  for _, value in ipairs(self.v_ui_world_connect) do
    local x, y, z = value.world_attach_trans:GetPositionA()
    local screen_pos_x, screen_pos_y = UtilUI.world_to_screen_pos(self.v_camera, self.v_uimain_canvas, x, y, z)
    value.ui_btn_rect_trans:SetAnchoredPositionA(screen_pos_x, screen_pos_y)
  end
end

function M:play_npc_anim(anim_name, do_swithc_model_anim)
  if not (self.v_cur_npc and self.v_cur_npc_luaobj) or not anim_name then
    return
  end
  local cur_action = self.v_cur_npc_luaobj.act_ctrl:get_cur_action()
  if cur_action == anim_name then
    return
  end
  self.v_cur_npc_luaobj.act_ctrl:try_action(anim_name, 0, nil, nil, false)
  if not do_swithc_model_anim then
    return
  end
  local anim_time = self.v_cur_npc_luaobj.act_ctrl:get_cur_anim_len()
  self:clear_timer()
  self.v_timer = Timer:add_timer("uimain_swithc_model_anim", anim_time, function()
    local normal_action_name = SignBoardGirlMgr:get_cur_view_stand_by_act()
    self.v_cur_npc_luaobj.act_ctrl:try_action(normal_action_name, 0, nil, nil, true)
  end)
end

function M:clear_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

function M:_update_light(char_dir)
  self.v_tar_light_dir = (char_dir - 180) % 360
  local dir = self.v_light_info.GlobalCharacterLightDir
  local new_dir = _lerp(dir, self.v_tar_light_dir, 0.1)
  if self.v_cache_light_dir and _abs(self.v_cache_light_dir - new_dir) > 0.1 then
    self.v_light_info.GlobalCharacterLightDir = new_dir
    SceneIlluminationInfo.Apply(self.v_light_info)
  end
  self.v_cache_light_dir = new_dir
end

function M:set_visible(is_on)
  Base.set_visible(self, is_on)
  self.v_need_reset_gyro_cache = true
  self:open_self_shadow(true, true)
end

function M:on_signboard_param_type_change(type)
  self.v_need_reset_gyro_cache = true
  self.v_signboard_use_gyro = 1 == Config.SIGNBOARD_PARAM_USE_GYRO[type]
end

function M:_gyro_update()
  if GuideMgr:get_cur_guider() then
    return
  end
  if not self.v_use_gyro or self.v_gyro_pause then
    return
  end
  if not self.v_camera_change_end then
    self.v_need_reset_gyro_cache = true
    return
  end
  local att_x, att_y, att_z, att_w = CSHelper.GetGyroAttitudeA()
  if not (not self.v_need_reset_gyro_cache and self.v_main_view_gyro_cache_x) or not self.v_main_view_gyro_cache_x then
    self.v_main_view_gyro_cache_y = att_y
    self.v_main_view_gyro_cache_x = att_x
    self.v_need_reset_gyro_cache = false
  end
  local now_gyro_cache_y = att_y
  local now_gyro_cache_x = att_x
  local gyro_diff_y = now_gyro_cache_y - self.v_main_view_gyro_cache_y
  local gyro_diff_x = now_gyro_cache_x - self.v_main_view_gyro_cache_x
  self.v_main_view_gyro_cache_y = now_gyro_cache_y
  self.v_main_view_gyro_cache_x = now_gyro_cache_x
  if _abs(gyro_diff_x) > 0.5 or _abs(gyro_diff_y) > 0.5 then
    return
  end
  local do_shake = _abs(gyro_diff_x) > self.v_gyro_threshold or _abs(gyro_diff_y) > self.v_gyro_threshold
  if do_shake then
    self:_shake_camera(gyro_diff_x, gyro_diff_y)
    self.v_cold_down_timer = self.v_gyro_cold
  elseif self.v_cold_down_timer then
    if self.v_cold_down_timer > 0 then
      local dt_time = self:get_dt()
      self.v_cold_down_timer = self.v_cold_down_timer - dt_time
    else
      self:_recenter_camera()
      self.v_cold_down_timer = 0
    end
  end
end

function M:_shake_camera(diff_x, diff_y)
  local dt_time = self:get_dt()
  local trans = self.v_camera_transform
  local angle_x, angle_y, angle_z = trans:GetLocalEulerAnglesA3()
  local target_x = self:_clamp_angle(angle_x, diff_x * 10, self.v_cache_angle.x)
  local target_y = self:_clamp_angle(angle_y, diff_y * 10, self.v_cache_angle.y)
  local rot_x = Math.lerp_angle(angle_x, target_x, dt_time * self.v_gyro_speed)
  local rot_y = Math.lerp_angle(angle_y, target_y, dt_time * self.v_gyro_speed)
  local rot_z = angle_z
  trans:SetEuler(rot_x, rot_y, rot_z)
end

function M:_clamp_angle(value, diff, pivot)
  local max = pivot + self.v_gyro_range
  if value > max then
    value = value - 360
  end
  local result = value + diff
  local min = pivot - self.v_gyro_range
  if diff < 0 then
    if result < min then
      result = min or result
    end
  else
    result = max < result and max or result
  end
  result = result < 0 and 360 + result or result
  result = result > 360 and result - 360 or result
  return result
end

function M:_recenter_camera()
  local trans = self.v_camera_transform
  local angle_x, angle_y, angle_z = trans:GetLocalEulerAnglesA3()
  local target_x = self.v_cache_angle.x
  local target_y = self.v_cache_angle.y
  local do_recenter_x = _abs(angle_x - target_x) > 0.01
  local do_recenter_y = _abs(angle_y - target_y) > 0.01
  if not do_recenter_x and not do_recenter_y then
    return
  end
  local dt_time = self:get_dt()
  local rot_x = Math.lerp_angle(angle_x, target_x, dt_time * self.v_gyro_reset_speed)
  local rot_y = Math.lerp_angle(angle_y, target_y, dt_time * self.v_gyro_reset_speed)
  local rot_z = angle_z
  trans:SetEuler(rot_x, rot_y, rot_z)
end

function M:on_destroy()
  self.v_main_scene_init_done = false
  Base.on_destroy(self)
  self.v_ui_world_connect = nil
  CSShadow.CloseRenderShadowMap2()
  self.v_light_info = nil
end

function M:update_clock()
  if not SignBoardGirlMgr:is_clock_can_update() then
    self.v_cur_min = -1
    return
  end
  if not self.v_main_scene_init_done or not self.v_hour_hand then
    return
  end
  local server_time = Date.get_server_time_date()
  local min = server_time.min
  local hour = server_time.hour
  if min ~= self.v_cur_min then
    if not self.v_cur_min then
      self.v_cur_min = -1
    end
    if _abs(min - self.v_cur_min) > 1 then
      self.v_cur_min = 0 == min and 59 or min - 1
      local min_target_angle = self.v_cur_min * 6
      local hour_target_angle = hour % 12 * 30
      self.v_minute_hand:SetEuler(0, 0, min_target_angle)
      self.v_hour_hand:SetEuler(0, 0, hour_target_angle)
      return
    end
    local hour_angle_x, hour_angle_y, hour_angle_z = self.v_hour_hand:GetLocalEulerAnglesA3()
    local min_angle_x, min_angle_y, min_angle_z = self.v_minute_hand:GetLocalEulerAnglesA3()
    local min_target_angle = min * 6
    local hour_target_angle = hour % 12 * 30 + min * 0.5
    local dt_time = self:get_dt()
    local min_angle = Math.lerp_angle(min_angle_z, min_target_angle, dt_time * self.v_clock_hand_speed)
    local hour_angle = Math.lerp_angle(hour_angle_z, hour_target_angle, dt_time * self.v_clock_hand_speed)
    self.v_minute_hand:SetEuler(0, 0, min_angle)
    self.v_hour_hand:SetEuler(0, 0, hour_angle)
    if almost_zero_angle(hour_angle_z, hour_target_angle) and almost_zero_angle(min_angle_z, min_target_angle) then
      self.v_cur_min = min
    end
  end
end

function M:set_vcamera_brain_enabled(enabled)
  if self.v_vcamera_brain then
    self.v_vcamera_brain.enabled = enabled
  end
end

function M:get_is_signboard()
  return true
end

return M
