local CSResLoader = CS.ResLoader
local TypeCSPlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
local CinemachineBlenderSettings = CS.Cinemachine.CinemachineBlenderSettings
local SkillTimeLineHelper = typeof(CS.Game.SkillTimeLineHelper)
local TimelineHelper = typeof(CS.Game.TimelineHelper)
local OverrideRootMotion = typeof(CS.OverrideRootMotion)
local HOLD_MODE_ENUM = UnityEngine.Playables.DirectorWrapMode.Hold
local SettingPath = "VCameraSettings"
local BlendFromAnyCameraLabel = CinemachineBlenderSettings.kBlendFromAnyCameraLabel
local CSUpdateVCameraSettings = CSHelper.UpdateVcameraSettings
local CSUpdateVCameraSettings2 = CSHelper.UpdateVcameraSettings2
local Layer = require("utils.layer")
local LAND_LAYER = Layer.LayerMask.Terrain
local M = Util.create_class()
local LOCATION_TYPE = {WORLD = 0, LOCAL = 1}
local ATTACH_POINT = "Bip001"
local Fog

local function temp_show_fog(show)
  if not Fog or Fog:IsNull() then
    Fog = UnityFind("Fog")
  end
  if Fog then
    Fog:SetActive(show)
  end
end

function M:_init()
  self.v_ct_tbl = {}
  self.v_now_ct = nil
  self.v_scale_time = 0
  self.v_duration_time = 0
  self:_load_vcamera_settings()
  self.v_play_idx = 0
end

function M:update()
  if self.v_now_ct == nil or self.v_play_mode == HOLD_MODE_ENUM and self.v_scale_time >= self.v_duration_time then
    return
  end
  self.v_scale_time = math.min(self.v_scale_time + GlobalTimeMgr:get_dt_time(), self.v_duration_time)
  self.v_now_ct.playable.time = self.v_scale_time
  self.v_now_ct.playable:Evaluate()
end

function M:preload_ct(name)
  if self.v_ct_tbl[name] then
    return
  end
  local full_path = CSResLoader.GetFullPath(name)
  local obj = ResMgr:load_gameobj(full_path, TypeUnityGameObject, true)
  local playable = obj:GetComponent(TypeCSPlayableDirector)
  local vcamera = obj:GetComponentInChildren(TypeCinemaVirtalCamera)
  self.v_ct_tbl[name] = {
    playable = playable,
    vcamera = vcamera,
    transform = vcamera.transform,
    name = name,
    ct_obj = obj
  }
end

function M:play(name, blendin, blendout, location_type, char)
  local ct = self.v_ct_tbl[name]
  if not ct then
    self:preload_ct(name)
    ct = self.v_ct_tbl[name]
  end
  if self.v_now_ct then
    self.v_now_ct.playable:Stop()
    self.v_now_ct.vcamera.Priority = 10
  end
  local suc_get, skill_timeline_com = ct.ct_obj:TryGetComponent(SkillTimeLineHelper)
  if suc_get then
    skill_timeline_com:ReSetWeapon()
    local hero_weapon_mgr = char.weapon_mgr
    local weapon_obj = hero_weapon_mgr:get_load_weapon_obj()
    local weapon_attach_point = hero_weapon_mgr:get_weapon_attch_name()
    local weapon_name = hero_weapon_mgr:get_weapon_prefab_name()
    for idx, obj in pairs(weapon_obj) do
      skill_timeline_com:SetWeapon(obj.gameObject, char.model_cfg.ModelPath, weapon_name[idx], weapon_attach_point[idx])
    end
  end
  local has_component, timeline_helper = ct.ct_obj:TryGetComponent(TimelineHelper)
  if has_component and not timeline_helper.BindingFinished then
    local res_list, bind_target_name_list, active_state_list = timeline_helper:GetBindingResName(char.model_cfg.ModelPath)
    local role_go
    local raw_obj_list = {}
    local effect_status_com_list = {}
    local effect_owner_list = {}
    local effect_active_state = {}
    for i = 0, res_list.Length - 1 do
      local model_go = ResPoolMgr:get_model(res_list[i])
      model_go.gameObject:TryRemoveComponent(OverrideRootMotion)
      table.insert(raw_obj_list, model_go.gameObject)
      if res_list[i] == char.model_cfg.ModelPath then
        role_go = model_go
      end
      local effect_status_com
      has_component, effect_status_com = model_go:TryGetComponent(TypeEffectStatus)
      if has_component then
        table.insert(effect_status_com_list, effect_status_com)
        table.insert(effect_owner_list, bind_target_name_list[i])
        table.insert(effect_active_state, active_state_list[i])
      end
    end
    timeline_helper:BindingRes(char.model_cfg.ModelPath, role_go.gameObject, raw_obj_list)
    local attach_point_com = role_go:GetComponent(typeof(CS.AttachPoint))
    local hero_weapon_mgr = char.weapon_mgr
    local weapon_name_list = hero_weapon_mgr:get_weapon_prefab_name()
    local weapon_attach_point = hero_weapon_mgr:get_weapon_attch_name()
    for idx, weapon_name in pairs(weapon_name_list) do
      if ShareRes.get_character_model_extra_preload_effect_list(weapon_name) then
        local attach_node = attach_point_com:GetPoint(weapon_attach_point[idx])
        local weapon_go = ResPoolMgr:get_model(weapon_name)
        weapon_go.transform:SetParent(attach_node)
        weapon_go:ResetAttr()
        timeline_helper:BindWeaponResTimelineTrack(weapon_name, weapon_go.gameObject)
        res_list, bind_target_name_list, active_state_list = timeline_helper:GetBindingResName(weapon_name)
        if res_list then
          UtilTable.clear_list(raw_obj_list)
          for i = 0, res_list.Length - 1 do
            local binding_go = ResPoolMgr:get_model(res_list[i])
            table.insert(raw_obj_list, binding_go.gameObject)
            local effect_status_com
            has_component, effect_status_com = binding_go:TryGetComponent(TypeEffectStatus)
            if has_component then
              table.insert(effect_status_com_list, effect_status_com)
              table.insert(effect_owner_list, bind_target_name_list[i])
              table.insert(effect_active_state, active_state_list[i])
            end
          end
          timeline_helper:BindingRes(weapon_name, weapon_go.gameObject, raw_obj_list)
        end
      end
    end
    local timeline_model_go = timeline_helper.CharacterModelTrans.gameObject
    for index, effect_status_com in ipairs(effect_status_com_list) do
      if "" == effect_owner_list[index] then
        effect_status_com:SetupOwner(timeline_model_go, true)
      else
        effect_status_com:SetupOwner(timeline_helper:GetCharacterTargetObj(effect_owner_list[index]), true)
      end
      effect_status_com.gameObject:SetActive(not effect_active_state[index])
    end
    timeline_helper:SetTimelineRendererHelperTarget()
    timeline_helper.BindingFinished = true
  end
  self.v_blend_out = blendout
  self:update_settings(blendin, blendout)
  self:_set_location(ct, location_type, char)
  ct.vcamera.Priority = 100
  self.v_scale_time = 0
  ct.playable.time = 0
  ct.playable.timeUpdateMode = UnityEngine.Playables.DirectorUpdateMode.Manual
  self.v_now_ct = ct
  self.v_duration_time = ct.playable.duration
  self.v_play_mode = ct.playable.extrapolationMode
  self.v_play_idx = self.v_play_idx + 1
  temp_show_fog(false)
  return self.v_play_idx
end

function M:stop(name, play_idx)
  if not self.v_now_ct or self.v_now_ct.name ~= name or self.v_play_idx ~= play_idx then
    return
  end
  self.v_duration_time = 0
  self.v_play_mode = nil
  self:clear_ct()
end

function M:pause()
  if not self.v_now_ct then
    return
  end
  self.v_now_ct.playable:Pause()
end

function M:resume()
  if not self.v_now_ct then
    return
  end
  self.v_now_ct.playable:Resume()
end

function M:clear_ct()
  if not self.v_now_ct then
    return
  end
  self.v_now_ct.playable:Stop()
  self.v_now_ct.vcamera.Priority = 10
  local name = self.v_now_ct.name
  local ct_obj = self.v_now_ct.ct_obj
  if ct_obj then
    if self.v_blend_out and self.v_blend_out > 0 then
      Timer:add_timer("destroy_cnimechine_timeline", self.v_blend_out, function()
        ResMgr:destroy_gameobj(ct_obj)
      end)
    else
      ResMgr:destroy_gameobj(ct_obj)
    end
  end
  self.v_now_ct = nil
  self.v_ct_tbl[name] = nil
  temp_show_fog(true)
  if Global.camera and Global.camera:get_view_type() == Config.CAMERA_VIEW_TYPE.SHOULDER then
    Global.camera:set_camera_to_default_pos_in_shouldermode()
  end
end

function M:get_ct_info()
  return self.v_now_ct
end

function M:get_settings()
  return self.v_settings
end

function M:_load_vcamera_settings()
  local path = Path.get_asset_path(SettingPath)
  local settings = ResMgr:load_res(path, CinemachineBlenderSettings)
  settings.m_CustomBlends[0].m_From = BlendFromAnyCameraLabel
  settings.m_CustomBlends[0].m_To = "VirtualCamera"
  settings.m_CustomBlends[1].m_From = "VirtualCamera"
  settings.m_CustomBlends[1].m_To = BlendFromAnyCameraLabel
  self.v_settings = settings
  self:update_settings(0, 0)
end

function M:update_settings(blendin, blendout)
  local settings = self.v_settings
  blendin = blendin or 0
  blendout = blendout or 0
  CSUpdateVCameraSettings(settings, blendin, blendout)
end

function M:update_timelinestep_blending_duration(blendout)
  local settings = self.v_settings
  CSUpdateVCameraSettings2(settings, blendout)
end

function M:_set_location(ct, location_type, char)
  local ct_transform = ct.playable.transform
  if location_type == LOCATION_TYPE.LOCAL then
    local parent = char.transform
    ct_transform:SetParent(parent, false)
    ct_transform:ResetAttr()
  else
    local pos = char:get_pos_vec3()
    ct_transform:SetPositionA(pos.x, pos.y, pos.z)
  end
  ct_transform:SetEulerY(char:get_dir())
end

function M:decrease_closeup_camera_priority()
  if self.v_now_ct and self.v_now_ct.vcamera then
    self.v_now_ct.vcamera.Priority = 50
  end
end

return M
