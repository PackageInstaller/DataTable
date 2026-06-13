local CommonDef = require("cs_share.common_define")
local MagicDef = require("cs_share.magic_def")
local TIME_SCELE_TYPE = MagicDef.TIME_SCELE_TYPE
local _uuid = 0

local function _next_uuid()
  _uuid = _uuid + 1
  return _uuid
end

local function _get_owner_auto_scale(owner)
  local model_cfg = owner.model_cfg
  if not model_cfg then
    return
  end
  return model_cfg.EffectScale
end

local M = Util.create_class()

function M:_init(owner, magic_info)
  self.owner = owner
  self.magic_info = magic_info
  self.magic_id = magic_info.magic_id
  self.magic_level = magic_info.magic_level
  self.owner_missile = magic_info.owner_missile
  self.owner_skill_id = magic_info.owner_skill_id
  self.effect_id_list = nil
  self.cfg = magic_info.logic_cfg
  self.effect_cfg = magic_info.effect_cfg
  self.update_type = self.cfg.UpdateType
  self.magic_kind_list = self.cfg.Kind
  self.magic_type = self.cfg.type
  self.left_duration = self.cfg.Duration
  self.duration = self.cfg.Duration
  self.remain_duration = 0
  self.timescale_type = self.cfg.IsTimeScale
  self.is_mark_remove = false
  self.magic_arg = magic_info.args
  self.uuid = _next_uuid()
  self:owner_add_effect()
end

function M:on_release()
  self.owner = nil
  self.magic_info = nil
  self.magic_id = nil
  self.magic_level = nil
  self.owner_missile = nil
  self.owner_skill_id = nil
  self.effect_id_list = nil
  self.cfg = nil
  self.effect_cfg = nil
  self.update_type = nil
  self.magic_kind_list = nil
  self.magic_type = nil
  self.left_duration = nil
  self.duration = nil
  self.remain_duration = nil
  self.timescale_type = nil
  self.magic_arg = nil
  self.uuid = nil
end

function M:reset_time()
  self.left_duration = self.duration
end

function M:on_effect(magic_list)
end

function M:on_effect_after(magic_list)
end

function M:owner_add_effect()
  if not self.effect_cfg then
    return nil
  end
  if self.effect_cfg.OneLayerEffect and not self.owner.magic_mgr:check_once_effect_play(self.magic_id) then
    return
  end
  if self.owner then
    self.effect_id_list = self.effect_id_list or {}
    local owner = self.owner
    local effect = self.effect_cfg.Effect
    local bone = self.effect_cfg.EffectJoint
    local effect_world = self.effect_cfg.EffectWorld
    local is_world = effect_world == MagicDef.EFFECT_BIND_TYPE.ONLY_ROTATION or effect_world == MagicDef.EFFECT_BIND_TYPE.SCENE_MAGIC
    local effect_scale = self.effect_cfg.EffectScale
    local effect_time_scale = self.effect_cfg.EffectTimeScale
    local is_auto_scaling = self.effect_cfg.AutoScaling
    local use_target_dir = self.effect_cfg.UseTargetDir
    local use_target_posy = self.effect_cfg.UseTargetPosY
    local dir = use_target_dir and owner:get_dir()
    local not_time_scale
    if self.timescale_type == TIME_SCELE_TYPE.NONE or self.timescale_type == TIME_SCELE_TYPE.EXCEPT_EFFECT or self.timescale_type == TIME_SCELE_TYPE.UNSCALE then
      not_time_scale = true
    end
    local scale_ratio = 1
    if is_auto_scaling then
      scale_ratio = _get_owner_auto_scale(owner)
    end
    if type(effect_scale) == "table" then
      local temp = {}
      local len = #effect_scale
      for index = 1, len do
        temp[index] = effect_scale[index] * scale_ratio
      end
      effect_scale = temp
    else
      effect_scale = effect_scale * scale_ratio
    end
    if owner:is_hero() and self.cfg.type == MagicDef.MAGIC_TYPE.HpShield then
      local hero_list = SceneMgr:get_hero_list()
      for key, hero in pairs(hero_list) do
        if not Util.is_destroy(hero) and not hero:is_die() then
          self:_add_effect(hero, effect, bone, effect_scale, effect_time_scale, effect_world, is_world, not_time_scale, dir, use_target_posy)
        end
      end
    else
      self:_add_effect(self.owner, effect, bone, effect_scale, effect_time_scale, effect_world, is_world, not_time_scale, dir, use_target_posy)
    end
    if self.effect_cfg.OneLayerEffect then
      if not UtilTable.is_empty(self.effect_id_list) then
        self.owner.magic_mgr:record_play_once_effect_info(self.magic_id, self.effect_id_list)
      end
      self.effect_id_list = nil
    end
  end
end

function M:_add_effect(target, effect, bone, effect_scale, effect_time_scale, effect_world, is_world, not_time_scale, dir, use_target_posy)
  local effect_data = target.act_effect_ctrl.create_effect_param()
  effect_data.prefab_name = effect
  effect_data.attach_point = bone
  effect_data.scale = effect_scale
  effect_data.time_scale = effect_time_scale
  effect_data.effect_bind_type = effect_world
  effect_data.is_world = is_world
  effect_data.not_time_scale = not_time_scale
  effect_data.is_weapon_attach = self.effect_cfg.IsWeaponAttach
  effect_data.effect_source = Config.EFFECT_SOURCE.MAGIC_PLAY
  effect_data.dir = dir
  if use_target_posy and is_world then
    local x, y, z
    if not Util.is_empty(effect_data.attach_point) then
      local parent = Util.get_effect_joint_pos(bone, target)
      if parent then
        x, y, z = parent:GetPositionA()
      end
    end
    if not x then
      x, y, z = target:get_pos()
    end
    local attacker = self.magic_info.attacker
    y = attacker:get_pos_height() or y
    local world_pos = Util.VEC3_TEMP.New(x, y, z)
    effect_data.world_pos = world_pos
  end
  local effect_id
  if is_world or target:is_loaded() then
    effect_id = target.act_effect_ctrl:play_attach_effect(effect_data, target)
    self.effect_id_list[target.uuid] = effect_id
  else
    target:add_loaded_cb(function()
      if not self.is_mark_remove then
        effect_id = target.act_effect_ctrl:play_attach_effect(effect_data, target)
        self.effect_id_list[target.uuid] = effect_id
      end
    end)
  end
end

function M:on_mark_remove()
  self.is_mark_remove = true
  if self.effect_cfg and self.effect_cfg.IsRemoveSelfOnCompleted then
    self:clear_effect()
  end
end

function M:clear_effect()
  if self.effect_id_list then
    local owner
    for uuid, effect_id in pairs(self.effect_id_list) do
      owner = SceneMgr:pick_by_uuid(uuid)
      if not Util.is_destroy(owner) then
        owner.act_effect_ctrl:stop_effect(effect_id)
      end
      self.effect_id_list[uuid] = nil
    end
  end
end

function M:on_remove(magic_list)
end

function M:get_timescale_type()
  return self.timescale_type
end

function M.remove_magic_on_effect(magic_mgr, magic_map)
  local is_building = MagicReporter:is_building_report()
  MagicReporter:push_action_start(is_building, CommonDef.MAGIC_ACTION_TYPE.remove_magic_on_effect)
  for _, magic in pairs(magic_map) do
    magic_mgr:remove_magic_by_id(magic.magic_id)
  end
  MagicReporter:push_action_end(is_building, CommonDef.MAGIC_ACTION_TYPE.remove_magic_on_effect)
end

function M:get_magic_arg()
  return self.magic_arg
end

function M:on_effect_before()
end

return M
