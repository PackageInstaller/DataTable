local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local TimelineHelper = typeof(CS.Game.TimelineHelper)
local OverrideRootMotion = typeof(CS.OverrideRootMotion)
local EffectParam = Util.create_class()
local SkillTimeLineHelper = typeof(CS.Game.SkillTimeLineHelper)
local EFFECT_PARAM_KEY = {
  "prefab_name",
  "go",
  "parent",
  "effect_id",
  "need_restart",
  "follow_time",
  "is_world",
  "callback",
  "callback_params",
  "not_time_scale",
  "scale",
  "time_scale",
  "triple_sound",
  "dir",
  "load_callback",
  "world_pos",
  "effect_bind_type",
  "attach_point",
  "effect_length",
  "is_weapon_bone",
  "is_weapon_attach",
  "effect_gameobj",
  "effect_source",
  "position_offset"
}
local EFFECT_PARAM_INDEX = {}
for index = 1, #EFFECT_PARAM_KEY do
  EFFECT_PARAM_INDEX[EFFECT_PARAM_KEY[index]] = index
end
EFFECT_PARAM_INDEX.___destroy_in_pool = true
local param_count = #EFFECT_PARAM_KEY

function EffectParam.__newindex(tb, k, v)
  if not EFFECT_PARAM_INDEX[k] then
    Log.Error("不能对EffectParam对象的任意字段赋值，你尝试去赋值", k, "请先在param_key与param_index中定义字段名", debug.traceback())
  end
  rawset(tb, k, v)
end

function EffectParam:_init()
end

function EffectParam:on_destroy()
  for i = 1, param_count do
    self[EFFECT_PARAM_KEY[i]] = nil
  end
end

local EFFECT_IDX_GO = 1
local EFFECT_TIME = 2
local EFFECT_LENGTH = 3
local EFFECT_IDX_STATUS = 4
local EFFECT_IDX_IS_WORLD = 5
local EFFECT_END_CB = 6
local EFFECT_END_CB_PARAMS = 7
local EFFECT_FLOOWTIME = 8
local EFFECT_NOT_TIME_SCALE = 9
local EFFECT_SCALE = 10
local EFFECT_TIME_SCALE = 11
local EFFECT_IDX_STAGE = 12
local EFFECT_END_LENGTH = 13
local EFFECT_NAME = 14
local EFFECT_BIND_TYPE = 15
local EFFECT_PARENT = 16
local EFFECT_WORLD_POS = 17
local EFFECT_PRIORITY = 18
local DESTROY_TIMER = 19
local POSITION_OFFSET = 20
local IdxParam = Util.create_class()

function IdxParam:_init()
end

function IdxParam:on_destroy()
  for i = 1, POSITION_OFFSET do
    self[i] = nil
  end
end

local PARAM_POOL = LuaObjPoolMgr.get_pool("act_effect_ctl_param") or LuaObjPoolMgr.register("act_effect_ctl_param", 100, EffectParam)
local IDX_PARAM_POOL = LuaObjPoolMgr.get_pool("act_effect_ctl_idx_param") or LuaObjPoolMgr.register("act_effect_ctl_idx_param", 100, IdxParam)
local SkipList = require("utils.util_skip_list")
local Base = require("obj.base_component")
local Math = require("base.mathx")
local MagicDef = require("cs_share.magic_def")
local BIND_TYPE = MagicDef.EFFECT_BIND_TYPE
local EFFECT_LOOP_TIME = -1
local M = Util.create_child_mt(Base)
local _random = math.random
local EFFECT_STAGE = {
  START = 0,
  LOOP = 1,
  END = 2
}
local EFFECT_SOUND_TYPE = {
  START = 1,
  LOOP = 2,
  END = 3,
  ANIM = 4
}
local LOADING_TAG = -1
local CANCLE_TAG = -2
local TABLE_TYPE = "table"
local BIND_TYPE_UPDATE_FUN = {
  [BIND_TYPE.ONLY_ROTATION] = function(magic_info, char)
    local go = magic_info[EFFECT_IDX_GO]
    local dir = char:get_dir()
    go.transform:SetEulerY2(dir)
  end
}
local USE_EFFECT_ID = 0

local function get_effect_id()
  USE_EFFECT_ID = USE_EFFECT_ID + 1
  return USE_EFFECT_ID
end

local function _set_effect_scale_on_create(transform, effect_status, scale)
  local scale_x, scale_y, scale_z
  local random_scale_multi = 1
  if effect_status.IsRandomScale then
    random_scale_multi = Math.lerp_number(effect_status.RandomScaleMin, effect_status.RandomScaleMax, _random())
  end
  if type(scale) == TABLE_TYPE then
    scale_x, scale_y, scale_z = scale[1] or 1, scale[2] or 1, scale[3] or 1
    scale_x, scale_y, scale_z = scale_x * random_scale_multi, scale_y * random_scale_multi, scale_z * random_scale_multi
  else
    scale = scale * random_scale_multi
    scale_x, scale_y, scale_z = scale, scale, scale
  end
  transform:SetLocalScaleA(scale_x, scale_y, scale_z)
end

local function _init_effect_position(self, effect_id)
  local effect_info = self.v_effect_list[effect_id]
  local offset_x, offset_y, offset_z
  local go = effect_info[EFFECT_IDX_GO]
  if effect_info[POSITION_OFFSET] then
    offset_x, offset_y, offset_z = effect_info[POSITION_OFFSET]:Get()
  end
  if effect_info[EFFECT_IDX_IS_WORLD] then
    local tx, ty, tz
    if effect_info[EFFECT_WORLD_POS] then
      tx, ty, tz = effect_info[EFFECT_WORLD_POS]:Get()
    else
      tx, ty, tz = effect_info[EFFECT_PARENT]:GetPositionA()
    end
    if offset_x then
      tx = tx + offset_x
      ty = ty + offset_y
      tz = tz + offset_z
    end
    go.transform:SetPositionA(tx, ty, tz)
  elseif effect_info[EFFECT_BIND_TYPE] == BIND_TYPE.ONLY_POS then
    self.v_only_pos_data_list[effect_id] = true
  else
    local transform = go.transform
    if effect_info[EFFECT_PARENT] then
      transform:SetParent(effect_info[EFFECT_PARENT])
    else
      transform:SetNullParent()
    end
    go:ResetAttr()
    if offset_x then
      transform:SetLocalPositionA(offset_x, offset_y, offset_z)
    end
  end
  if effect_info[EFFECT_BIND_TYPE] == BIND_TYPE.ONLY_ROTATION then
    local tx, ty, tz = self.v_char:get_pos()
    if offset_x then
      tx = tx + offset_x
      ty = ty + offset_y
      tz = tz + offset_z
    end
    go.transform:SetPositionA(tx, ty, tz)
  end
end

function M:_init(char)
  Base._init(self, char)
  self.v_char = char
  self.v_effect_list = {}
  self.force_set_missile_speed_list = {}
  self.v_only_pos_data_list = {}
  self.v_effect_end_timer_map = {}
  self.v_cur_effect_priority = 1
  self.v_effect_priority_map = {}
end

function M:on_before_destroy()
  self.v_char = nil
end

function M:on_destroy_gameobj()
  self:stop_all()
end

function M:late_update()
  self:update_effect_only_pos()
end

function M:update_effect_only_pos()
  for effect_id, _ in pairs(self.v_only_pos_data_list) do
    local effect_info = self.v_effect_list[effect_id]
    if not effect_info then
      self.v_only_pos_data_list[effect_id] = nil
    else
      local parent = effect_info[EFFECT_PARENT]
      if not parent or parent:IsNull() then
        self.v_only_pos_data_list[effect_id] = nil
      else
        local tx, ty, tz = parent.transform:GetPositionA()
        local go = effect_info[EFFECT_IDX_GO]
        local ox, oy, oz
        if effect_info[POSITION_OFFSET] then
          ox, oy, oz = effect_info[POSITION_OFFSET]:Get()
          tx, ty, tz = tx + ox, ty + oy, tz + oz
        end
        go.transform:SetPositionA(tx, ty, tz)
      end
    end
  end
end

function M:low_update()
  local dt = self.v_char:get_low_dt()
  for effect_id, effect_info in pairs(self.v_effect_list) do
    if effect_info == LOADING_TAG or effect_info == CANCLE_TAG then
      if effect_info == CANCLE_TAG then
        self.v_effect_list[effect_id] = nil
      end
    elseif effect_info[DESTROY_TIMER] then
      effect_info[DESTROY_TIMER] = effect_info[DESTROY_TIMER] - dt
      if effect_info[DESTROY_TIMER] <= 0 then
        self:release_effect(effect_id)
      else
      end
    else
      local time = effect_info[EFFECT_TIME]
      if effect_info[EFFECT_TIME_SCALE] then
        time = time + dt * effect_info[EFFECT_TIME_SCALE]
      else
        time = time + dt
      end
      effect_info[EFFECT_TIME] = time
      local follow_time = effect_info[EFFECT_FLOOWTIME]
      local go = effect_info[EFFECT_IDX_GO]
      if go:IsNull() then
        self.v_effect_list[effect_id] = nil
        self.force_set_missile_speed_list[effect_id] = nil
        self.v_only_pos_data_list[effect_id] = nil
        IDX_PARAM_POOL:destroy_obj(effect_info)
      else
        if go:CheckParent() and follow_time and time > follow_time then
          go:SetNullParent()
          if not effect_info[EFFECT_NOT_TIME_SCALE] then
            effect_info[EFFECT_IDX_STATUS]:SetSpeed(1)
          end
        end
        local effect_bind_type = effect_info[EFFECT_BIND_TYPE]
        if effect_bind_type then
          local fun = BIND_TYPE_UPDATE_FUN[effect_bind_type]
          if fun then
            fun(effect_info, self.v_char)
          end
        end
        if time > effect_info[EFFECT_LENGTH] and effect_info[EFFECT_LENGTH] ~= EFFECT_LOOP_TIME then
          self:_stop_effect(effect_info, effect_id)
        else
          self:play_effect_triple_sound(effect_info, EFFECT_SOUND_TYPE.LOOP)
        end
      end
    end
  end
end

function M:_play_destroy_effect(effect_id, effect_info, force_stop)
  local effect_stage = effect_info[EFFECT_IDX_STAGE]
  local left_time
  if Util.is_nil(effect_info[EFFECT_IDX_GO]) then
    Log.Error("_play_destroy_effect", effect_info[EFFECT_NAME], self.v_char:get_npc_id(), self.v_char.id, debug.traceback())
  end
  if effect_stage then
    if 0 == effect_stage:GetPlayStage() then
      return
    end
    left_time = effect_info[EFFECT_IDX_STAGE]:GetPlayTime(EFFECT_STAGE.END)
    if left_time > 0 then
      effect_stage:PlayEffectStage(EFFECT_STAGE.END)
    end
  else
    left_time = effect_info[EFFECT_END_LENGTH]
    if left_time > 0 then
      effect_info[EFFECT_IDX_STATUS]:PlayEndEffect()
    end
  end
  local go = effect_info[EFFECT_IDX_GO]
  if not effect_info[EFFECT_IDX_STATUS].FollowTransformOnEnd then
    go:SetNullParent()
  end
  local play_destroy = left_time > 0 and not force_stop and not effect_info[DESTROY_TIMER] and not SceneMgr:be_cleaning_up_scene_data() and not Global.gamemode:gmode_is_leaving() and not Util.is_in_loading()
  if play_destroy then
    effect_info[DESTROY_TIMER] = left_time
    return true
  else
    self:release_effect(effect_id)
    return false
  end
end

function M:release_effect(effect_id)
  local effect_info = self.v_effect_list[effect_id]
  if effect_info then
    local go = effect_info[EFFECT_IDX_GO]
    if go then
      if self.v_char.effect_sound_mgr then
        self.v_char.effect_sound_mgr:remove_effect_obj(go)
      end
      ResPoolMgr:release(go)
    end
  end
  self:clear_effect_info(effect_id)
end

function M:play_attach_effect(effect_param, owner)
  effect_param.effect_id = get_effect_id()
  local is_weapon_attach = effect_param.is_weapon_attach
  local attach_transform, is_camera_effect
  if is_weapon_attach and owner.weapon_mgr then
    attach_transform = owner.weapon_mgr:get_attach_point_obj(effect_param.attach_point)
  else
    attach_transform, is_camera_effect = Util.get_effect_joint_pos(effect_param.attach_point, owner)
    if is_camera_effect then
      Global.camera:add_role_effect_sign(self.v_char.uuid, effect_param.effect_id)
    end
  end
  if not attach_transform then
    if is_weapon_attach then
      Log.Error("武器无挂点", effect_param.attach_point, "信息，请检查武器挂载的Attach_Point脚本")
    else
      Log.Error("人物无挂点", effect_param.attach_point, "信息，请检查人物挂载的Attach_Point脚本")
    end
  end
  effect_param.parent = attach_transform or owner.transform
  if self.v_char:is_role() then
    effect_param.prefab_name = ShareRes.get_effect_map_by_fashion_id(effect_param.prefab_name, self.v_char:get_fashion_id())
  end
  ResPoolMgr:get_spell_effect_async(effect_param.prefab_name, self.v_char, function(go, _, need_restart)
    effect_param.need_restart = need_restart
    effect_param.go = go
    if effect_param.prefab_name and self.v_char then
      local suc_get, skill_timeline_com = go:TryGetComponent(SkillTimeLineHelper)
      if suc_get then
        skill_timeline_com:ReSetWeapon()
        local hero_weapon_mgr = self.v_char.weapon_mgr
        local weapon_obj = hero_weapon_mgr:get_load_weapon_obj()
        local weapon_attach_point = hero_weapon_mgr:get_weapon_attch_name()
        local weapon_name = hero_weapon_mgr:get_weapon_prefab_name()
        for idx, obj in pairs(weapon_obj) do
          skill_timeline_com:SetWeapon(obj.gameObject, self.v_char.model_cfg.ModelPath, weapon_name[idx], weapon_attach_point[idx])
        end
      end
      local has_component, timeline_helper = go:TryGetComponent(TimelineHelper)
      if has_component and not timeline_helper.BindingFinished then
        local res_list, bind_target_name_list, active_state_list = timeline_helper:GetBindingResName(self.v_char.model_cfg.ModelPath)
        local role_go
        local raw_obj_list = {}
        local effect_status_com_list = {}
        local effect_owner_list = {}
        local effect_active_state = {}
        for i = 0, res_list.Length - 1 do
          local model_go = ResPoolMgr:get_model(res_list[i])
          model_go.gameObject:TryRemoveComponent(OverrideRootMotion)
          table.insert(raw_obj_list, model_go.gameObject)
          if res_list[i] == self.v_char.model_cfg.ModelPath then
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
        if not role_go then
          Log.Error("role_go为空:" .. effect_param.prefab_name)
        end
        timeline_helper:BindingRes(self.v_char.model_cfg.ModelPath, role_go.gameObject, raw_obj_list)
        local attach_point_com = role_go:GetComponent(typeof(CS.AttachPoint))
        local hero_weapon_mgr = self.v_char.weapon_mgr
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
    end
    self:_on_create_effect(effect_param)
  end)
  self.v_effect_list[effect_param.effect_id] = LOADING_TAG
  return effect_param.effect_id
end

function M:play_effect(effect_param)
  effect_param.effect_id = get_effect_id()
  if self.v_char:is_role() then
    effect_param.prefab_name = ShareRes.get_effect_map_by_fashion_id(effect_param.prefab_name, self.v_char:get_fashion_id())
  end
  ResPoolMgr:get_spell_effect_async(effect_param.prefab_name, self.v_char, function(go, _, need_restart)
    effect_param.need_restart = need_restart
    effect_param.go = go
    self:_on_create_effect(effect_param)
  end)
  self.v_effect_list[effect_param.effect_id] = LOADING_TAG
  return effect_param.effect_id
end

function M:update_speed(speed, pause)
  for _, effect_info in pairs(self.v_effect_list) do
    if type(effect_info) == TABLE_TYPE then
      local new_speed
      if effect_info[EFFECT_NOT_TIME_SCALE] then
        if true == pause then
          new_speed = 0
        elseif false == pause then
          new_speed = 0 ~= effect_info[EFFECT_TIME_SCALE] and effect_info[EFFECT_TIME_SCALE] or 1
        end
      else
        new_speed = speed * effect_info[EFFECT_TIME_SCALE]
      end
      if new_speed then
        if effect_info[EFFECT_IDX_STATUS] then
          if effect_info[EFFECT_IDX_STATUS]:IsNull() then
            Log.Error("update_speed nil", effect_info[EFFECT_NAME], self.v_char.id, debug.traceback())
          else
            effect_info[EFFECT_IDX_STATUS]:SetSpeed(new_speed)
          end
        end
        if effect_info[EFFECT_IDX_STAGE] then
          effect_info[EFFECT_IDX_STAGE]:SetSpeed(new_speed)
        end
      end
    end
  end
end

function M:stop_all(is_world)
  for effect_id, effect_info in pairs(self.v_effect_list) do
    if type(effect_info) ~= TABLE_TYPE then
    elseif is_world and not effect_info[EFFECT_IDX_IS_WORLD] then
    else
      self:_stop_effect(effect_info, effect_id, true)
    end
  end
  if not is_world then
    for effect_id, effect_info in pairs(self.v_effect_list) do
      if not effect_info or type(effect_info) ~= TABLE_TYPE then
      else
        IDX_PARAM_POOL:destroy_obj(effect_info)
      end
    end
    self.v_effect_list = {}
    self.force_set_missile_speed_list = {}
    self.v_only_pos_data_list = {}
  end
end

function M:get_play_end_effect_time(effect_id)
  local effect_info = self.v_effect_list[effect_id]
  if not effect_info or type(effect_info) ~= TABLE_TYPE then
    return nil
  end
  local left_time = effect_info[EFFECT_END_LENGTH]
  return left_time
end

function M:set_effect_out_of_char(effect_id, end_follow_pos)
  local effect_info = self.v_effect_list[effect_id]
  if not effect_info or type(effect_info) ~= TABLE_TYPE or effect_info[DESTROY_TIMER] then
    return
  end
  local go = effect_info[EFFECT_IDX_GO]
  if Util.is_nil(go) then
    return
  end
  go:SetNullParent()
  if not effect_info[EFFECT_NOT_TIME_SCALE] then
    effect_info[EFFECT_IDX_STATUS]:SetSpeed(1)
  end
  local effect_time, effect_length = effect_info[EFFECT_TIME], effect_info[EFFECT_LENGTH]
  if end_follow_pos then
    local ex, ey, ez = go.transform:GetPositionA()
    local hx, hy, hz = Global.hero:get_pos()
    local ox, oy, oz = ex - hx, ey - hy, ez - hz
    effect_info[POSITION_OFFSET] = Util.VEC3_TEMP.New(ox, oy, oz)
    self.v_only_pos_data_list[effect_id] = true
  end
  self:play_end_effect(effect_id)
  return effect_length < 0 and effect_length or effect_length - effect_time
end

function M:play_end_effect(effect_id)
  local effect_info = self.v_effect_list[effect_id]
  if not effect_info or type(effect_info) ~= TABLE_TYPE or effect_info[DESTROY_TIMER] then
    return
  end
  local left_time = effect_info[EFFECT_END_LENGTH]
  if left_time > 0 then
    effect_info[EFFECT_IDX_STATUS]:PlayEndEffect()
  end
end

function M:stop_effect(effect_id, force_stop)
  local effect_info = self.v_effect_list[effect_id]
  self:_stop_effect(effect_info, effect_id, force_stop)
end

function M:_stop_effect(effect_info, effect_id, force_stop)
  if not effect_info then
    return
  end
  if effect_info == LOADING_TAG then
    self.v_effect_list[effect_id] = CANCLE_TAG
  end
  if type(effect_info) ~= TABLE_TYPE then
    return
  end
  if effect_info[DESTROY_TIMER] then
    self:release_effect(effect_id)
    return
  end
  local priority = effect_info[EFFECT_PRIORITY]
  if not effect_info[EFFECT_NOT_TIME_SCALE] and not effect_info[EFFECT_IDX_STATUS]:IsNull() then
    effect_info[EFFECT_IDX_STATUS]:SetSpeed(1)
  end
  if effect_info[EFFECT_END_CB] then
    effect_info[EFFECT_END_CB](effect_info[EFFECT_END_CB_PARAMS], effect_info)
  end
  self:play_effect_triple_sound(effect_info, EFFECT_SOUND_TYPE.END)
  local is_delay_destroy = self:_play_destroy_effect(effect_id, effect_info, force_stop)
  if not is_delay_destroy then
    self:clear_effect_info(effect_id)
  end
  self:remove_at_priority_map(effect_id, priority)
end

function M:clear_effect_info(effect_id)
  local effect_info = self.v_effect_list[effect_id]
  self.v_effect_list[effect_id] = nil
  self.force_set_missile_speed_list[effect_id] = nil
  self.v_only_pos_data_list[effect_id] = nil
  if Global.camera then
    Global.camera:remove_role_effect_sign(self.v_char.uuid, effect_id)
  end
  if effect_info then
    IDX_PARAM_POOL:destroy_obj(effect_info)
  end
end

function M:_on_create_effect(creat_effect_data)
  local go = creat_effect_data.go
  local parent = creat_effect_data.parent
  local effect_id = creat_effect_data.effect_id
  local need_restart = creat_effect_data.need_restart
  local follow_time = creat_effect_data.follow_time
  local is_world = creat_effect_data.is_world
  local callback = creat_effect_data.callback
  local callback_params = creat_effect_data.callback_params
  local scale = creat_effect_data.scale or 1
  local time_scale, not_time_scale
  if self.force_set_missile_speed_list[effect_id] then
    time_scale = self.force_set_missile_speed_list[effect_id]
    not_time_scale = false
  else
    not_time_scale = creat_effect_data.not_time_scale
    time_scale = creat_effect_data.time_scale or 1
  end
  local effect_length = creat_effect_data.effect_length
  local world_pos = creat_effect_data.world_pos
  local dir = creat_effect_data.dir
  local transform = go.transform
  local effect_bind_type = creat_effect_data.effect_bind_type
  local position_offset = creat_effect_data.position_offset
  local effect_list_element = self.v_effect_list[effect_id]
  if not effect_list_element or effect_list_element ~= LOADING_TAG or Util.is_destroy(self.v_char) or not is_world and Util.is_nil(parent) then
    local effect_info = self.v_effect_list[effect_id]
    if type(effect_info) == TABLE_TYPE then
      IDX_PARAM_POOL:destroy_obj(effect_info)
    end
    PARAM_POOL:destroy_obj(creat_effect_data)
    self.v_effect_list[effect_id] = nil
    self.force_set_missile_speed_list[effect_id] = nil
    self.v_only_pos_data_list[effect_id] = nil
    ResPoolMgr:release(go)
    return
  end
  local idx_param = IDX_PARAM_POOL:new_obj()
  idx_param[EFFECT_IDX_GO] = go
  idx_param[EFFECT_TIME] = 0
  idx_param[EFFECT_IDX_IS_WORLD] = is_world
  idx_param[EFFECT_END_CB] = callback
  idx_param[EFFECT_END_CB_PARAMS] = callback_params
  idx_param[EFFECT_FLOOWTIME] = follow_time
  idx_param[EFFECT_SCALE] = scale
  idx_param[EFFECT_NAME] = creat_effect_data.prefab_name
  idx_param[EFFECT_PARENT] = parent
  idx_param[EFFECT_BIND_TYPE] = effect_bind_type
  idx_param[EFFECT_WORLD_POS] = world_pos
  idx_param[POSITION_OFFSET] = position_offset
  self.v_effect_list[effect_id] = idx_param
  _init_effect_position(self, effect_id)
  if creat_effect_data.load_callback then
    creat_effect_data.load_callback(go)
  end
  local cid = go:GetInstanceID()
  local length, effect_status, effect_stage = ResPoolMgr:get_effect_data(cid)
  local priority
  if effect_stage then
    length = effect_stage:GetPlayStartLoopTime()
  elseif effect_status then
    length = effect_status.LifeTime
  end
  if effect_length and 0 ~= effect_length then
    length = effect_length
  end
  local effect_quality = BattleSettingMgr:get_effect_quality()
  effect_status:CheckQuality(effect_quality)
  local animator = Util.get_animator(nil, go)
  local end_effect_time = animator and effect_status:GetEndLength() or -1
  _set_effect_scale_on_create(transform, effect_status, scale)
  effect_status:CheckRandomRotate(transform)
  if dir then
    transform:SetEulerY2(dir)
  end
  if need_restart then
    go:SetActive(true)
  end
  local effect_time_scale = time_scale
  if self.v_char.time_mgr then
    local new_speed
    if not not_time_scale then
      local change_speed
      if self.force_set_missile_speed_list[effect_id] then
        change_speed = false
      elseif creat_effect_data.effect_source == Config.EFFECT_SOURCE.MISSILE_PLAY then
        change_speed = not self.v_char.time_mgr:get_is_ignoral_missile()
      elseif creat_effect_data.effect_source then
        change_speed = true
      end
      if change_speed then
        new_speed = time_scale * self.v_char.time_mgr:get_time_scale()
      elseif self.v_char:get_in_global_scale() then
        new_speed = time_scale * GlobalTimeMgr:get_time_scale()
      end
      if new_speed then
        effect_time_scale = new_speed
      end
    end
  end
  local get, playable_director = go:TryGetComponent(TypePlayableDirector)
  if get then
    playable_director:Evaluate()
  end
  effect_status:SetSpeed(effect_time_scale)
  if effect_stage then
    effect_stage:SetSpeed(effect_time_scale)
    effect_stage:PlayEffectStage(EFFECT_STAGE.START)
  end
  idx_param[EFFECT_NOT_TIME_SCALE] = not_time_scale
  idx_param[EFFECT_TIME_SCALE] = time_scale
  idx_param[EFFECT_PRIORITY] = priority
  idx_param[EFFECT_LENGTH] = length
  idx_param[EFFECT_IDX_STATUS] = effect_status
  idx_param[EFFECT_IDX_STAGE] = effect_stage
  idx_param[EFFECT_END_LENGTH] = end_effect_time
  local owner_obj = self.v_char.effect_owner
  owner_obj = owner_obj or self.v_char.gameobj
  local effect_go = creat_effect_data.effect_gameobj
  if effect_go and not effect_go:IsNull() then
    owner_obj = effect_go.gameObject
  end
  if not Util.is_nil(owner_obj) then
    effect_status:SetupOwner(owner_obj.gameObject)
  end
  self:play_effect_triple_sound(self.v_effect_list[effect_id], EFFECT_SOUND_TYPE.START)
  PARAM_POOL:destroy_obj(creat_effect_data)
  if Global.debug_hide_effect then
    go:SetActive(false)
  end
  self:insert_to_priority_map(effect_id, priority)
end

function M:play_effect_triple_sound(effect_data, play_type)
  local effect_sound_mgr = self.v_char.effect_sound_mgr
  if not effect_sound_mgr then
    return
  end
  effect_sound_mgr:play_effect_triple_sound(effect_data, play_type)
end

function M:set_effect_end_anim_idx(effect_name, idx)
  for effect_id, info in pairs(self.v_effect_list) do
    if info == LOADING_TAG or type(info) ~= TABLE_TYPE then
    elseif info[EFFECT_NAME] == effect_name then
      self:set_end_anim_idx_by_effect_id(effect_id, idx)
    end
  end
end

function M:set_end_anim_idx_by_effect_id(effect_id, idx)
  local effect_info = self.v_effect_list[effect_id]
  if effect_info and type(effect_info) == TABLE_TYPE then
    local status = effect_info[EFFECT_IDX_STATUS]
    if not Util.is_nil(status) then
      status:SetCustomEndNameIdx(idx)
    end
  end
end

function M:effect_play_anim(effect_name, animstate_name)
  for effect_id, info in pairs(self.v_effect_list) do
    if info == LOADING_TAG or type(info) ~= TABLE_TYPE then
    elseif info[EFFECT_NAME] == effect_name then
      self:assign_effect_play_anim(effect_id, animstate_name)
    end
  end
end

function M:assign_effect_play_anim(effect_id, animstate_name)
  local effect_info = self.v_effect_list[effect_id]
  if effect_info and type(effect_info) == TABLE_TYPE and not Util.is_nil(effect_info[EFFECT_IDX_GO]) then
    local animator = Util.get_animator(nil, effect_info[EFFECT_IDX_GO])
    if animator then
      animator.component:Play(animstate_name)
    end
  end
end

function M:get_effect_gameobject_by_name(effect_name)
  for _, info in pairs(self.v_effect_list) do
    if info == LOADING_TAG or type(info) ~= TABLE_TYPE then
    elseif info[EFFECT_NAME] == effect_name then
      return info[EFFECT_IDX_GO]
    end
  end
end

function M:get_effect_gameobject(effect_id)
  local effect_info = self.v_effect_list[effect_id]
  if effect_info == LOADING_TAG then
    return
  end
  if type(effect_info) ~= TABLE_TYPE then
    return
  end
  return effect_info[EFFECT_IDX_GO]
end

function M:update_missile_effect_speed(effect_id)
  local effect_info = self.v_effect_list[effect_id]
  if effect_info == LOADING_TAG then
    return
  end
  if type(effect_info) == TABLE_TYPE and not self.force_set_missile_speed_list[effect_id] then
    local new_speed = effect_info[EFFECT_TIME_SCALE]
    effect_info[EFFECT_IDX_STATUS]:SetSpeed(new_speed)
    if effect_info[EFFECT_IDX_STAGE] then
      effect_info[EFFECT_IDX_STAGE]:SetSpeed(new_speed)
    end
  end
end

function M:set_missile_effect_speed(effect_id, new_speed)
  local effect_info = self.v_effect_list[effect_id]
  if effect_info == LOADING_TAG then
    self.force_set_missile_speed_list[effect_id] = new_speed
    return
  end
  if type(effect_info) == TABLE_TYPE and not effect_info[EFFECT_NOT_TIME_SCALE] then
    self.force_set_missile_speed_list[effect_id] = new_speed
    effect_info[EFFECT_IDX_STATUS]:SetSpeed(new_speed)
    effect_info[EFFECT_TIME_SCALE] = new_speed
    if effect_info[EFFECT_IDX_STAGE] then
      effect_info[EFFECT_IDX_STAGE]:SetSpeed(new_speed)
    end
  end
end

function M:update_global_speed()
  local time_scale = self.v_char.time_mgr and self.v_char.time_mgr:get_time_scale() or GlobalTimeMgr:get_time_scale()
  for _, effect_info in pairs(self.v_effect_list) do
    if type(effect_info) == TABLE_TYPE and not effect_info[EFFECT_NOT_TIME_SCALE] then
      local speed = time_scale * effect_info[EFFECT_TIME_SCALE]
      effect_info[EFFECT_IDX_STATUS]:SetSpeed(speed)
      if effect_info[EFFECT_IDX_STAGE] then
        effect_info[EFFECT_IDX_STAGE]:SetSpeed(speed)
      end
    end
  end
end

function M:set_new_effect_owner_go(owner_go)
  local transform
  for effect_id, effect_info in pairs(self.v_effect_list) do
    if type(effect_info) == TABLE_TYPE then
      transform = effect_info[EFFECT_IDX_GO].transform
      local attach_point = owner_go:GetComponent(typeof(CS.AttachPoint))
      local owner_parent = effect_info[EFFECT_PARENT]
      local new_parent
      if owner_parent and not owner_parent:IsNull() then
        new_parent = Util.get_child(owner_parent.name, owner_go) or attach_point:GetPoint(owner_parent.name)
      end
      new_parent = new_parent or owner_go
      effect_info[EFFECT_PARENT] = new_parent.transform
      if effect_info[EFFECT_IDX_IS_WORLD] then
        local x, y, z
        if effect_info[EFFECT_WORLD_POS] then
          x, y, z = effect_info[EFFECT_WORLD_POS]:Get()
        else
          x, y, z = new_parent:GetPositionA()
        end
        transform:SetPositionA(x, y, z)
      elseif effect_info[EFFECT_BIND_TYPE] ~= BIND_TYPE.ONLY_POS then
        transform:SetParent(new_parent.transform)
        transform.gameObject:ResetAttr()
      end
      if effect_info.effect_gameobj and not effect_info.effect_gameobj:IsNull() then
        local point = attach_point:GetPoint(effect_info.effect_gameobj.name)
        if point and not point:IsNull() then
          effect_info[EFFECT_IDX_STATUS]:SetupOwner(point.gameObject)
        else
          effect_info[EFFECT_IDX_STATUS]:SetupOwner(owner_go.gameObject)
        end
      else
        effect_info[EFFECT_IDX_STATUS]:SetupOwner(owner_go.gameObject)
      end
    end
  end
end

function M:clear_effect_on_change_go()
  for effect_id, effect_info in pairs(self.v_effect_list) do
    if type(effect_info) == TABLE_TYPE and not effect_info[EFFECT_IDX_IS_WORLD] then
      self:_stop_effect(effect_info, effect_id)
    end
  end
end

function M.create_effect_param()
  return PARAM_POOL:new_obj()
end

function M:get_effect_data(effect_id)
  return self.v_effect_list[effect_id]
end

function M:set_effect_active(effect_id, active)
  local effect_data = self:get_effect_data(effect_id)
  if effect_data and effect_data ~= CANCLE_TAG and not Util.is_nil(effect_data[EFFECT_IDX_GO]) then
    effect_data[EFFECT_IDX_GO]:SetActive(active)
  end
end

function M:insert_to_priority_map(effect_id, priority)
  if not Util.is_more_than_zero(priority) then
    return
  end
  local skip_list
  if not self.v_effect_priority_map[priority] then
    self.v_effect_priority_map[priority] = SkipList:new(5)
  end
  skip_list = self.v_effect_priority_map[priority]
  local last_effect_id = skip_list:get_last_inserted()
  if last_effect_id then
    self:set_effect_active(effect_id, false)
  end
  skip_list:insert(effect_id, effect_id)
  if priority > self.v_cur_effect_priority then
    local cancle_effect_id
    for i = self.v_cur_effect_priority, priority - 1 do
      if self.v_effect_priority_map[i] then
        cancle_effect_id = self.v_effect_priority_map[i]:get_last_inserted()
        if cancle_effect_id then
          self:set_effect_active(cancle_effect_id, false)
        end
      end
    end
    self.v_cur_effect_priority = priority
  elseif priority < self.v_cur_effect_priority then
    self:set_effect_active(effect_id, false)
  end
end

function M:remove_at_priority_map(effect_id, priority)
  if not Util.is_more_than_zero(priority) or not self.v_effect_priority_map[priority] then
    return
  end
  local skip_list = self.v_effect_priority_map[priority]
  skip_list:delete(effect_id)
  if priority < self.v_cur_effect_priority then
    return
  end
  for i = priority, 1, -1 do
    if self:try_show_useable_priority_effect(i) then
      self.v_cur_effect_priority = i
      return
    end
  end
  self.v_cur_effect_priority = 1
end

function M:try_show_useable_priority_effect(priority)
  local skip_list = self.v_effect_priority_map[priority]
  if not skip_list then
    return false
  end
  local last_effect_id, last_effect_data
  if skip_list.length <= 0 then
    return false
  end
  local count = math.min(skip_list.length, 5)
  for _ = 1, count do
    last_effect_id = skip_list:get_last_inserted()
    last_effect_data = self:get_effect_data(last_effect_id)
    if not (not last_effect_data or last_effect_data == CANCLE_TAG or Util.is_nil(last_effect_data[EFFECT_IDX_GO])) then
      break
    end
    skip_list:delete(last_effect_id)
  end
  if last_effect_data then
    last_effect_data[EFFECT_IDX_GO]:SetActive(true)
    return true
  else
    Log.Error("优先级", priority, "获取可激活特效失败，请检查逻辑代码", debug.traceback())
  end
  return false
end

function M:effect_break_away_old_owner(effect_id)
  if not self.v_effect_list[effect_id] then
    return
  end
  local effect_info = self.v_effect_list[effect_id]
  if effect_info[EFFECT_BIND_TYPE] == BIND_TYPE.ONLY_POS then
    self.v_only_pos_data_list[effect_id] = nil
  end
  self.v_effect_list[effect_id] = nil
  self.force_set_missile_speed_list[effect_id] = nil
  self.v_only_pos_data_list[effect_id] = nil
  return effect_info
end

function M:become_effect_new_owner(effect_id, effect_info, new_parent)
  self.v_effect_list[effect_id] = effect_info
  if self:is_destroy() or Util.is_nil(effect_info[EFFECT_IDX_GO]) then
    self:release_effect(effect_id)
    return
  end
  effect_info[EFFECT_PARENT] = new_parent
  _init_effect_position(self, effect_id)
end

return M
