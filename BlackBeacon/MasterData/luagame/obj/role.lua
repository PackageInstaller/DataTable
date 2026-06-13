local Base = require("obj.char")
local Vec3 = require("base.vec3")
local BehaviorMgr = require("manager.fight.behaviormgr")
local CAl_MONSTER_TYPE = require("cs_share.common_define").CALC_KILL_CNT_NPC
local Layer = require("utils.layer")
local CommDefine = require("cs_share.common_define")
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local MOVE_ATTR_TYPE = ATTR_TYPE.CHAR_SPEED
local STATE_NAME = Config.STATE_NAME
local MAGIC_DEF = require("cs_share.magic_def")
local SHIELD_MAGIC_TYPE = MAGIC_DEF.MAGIC_TYPE.HpShield
local TypeAttachPoint = typeof(CS.AttachPoint)
local TypeCharacterUtil = typeof(CS.Game.CharacterUtil)
local CHARACTER_STATE_TYPE = Config.CHARACTER_STATE_TYPE
local ROOT_BONE_SHAKE_NAME = Config.ROOT_BONE_SHAKE_NAME
local CAMERA_NAME = "Camera"
local _cos = math.cos
local _sin = math.sin
local _deg2rad = math.rad(1)
local _get_angle2A = require("base.mathx").get_angle2A
local _tinsert = table.insert
local TypeCharacterAlpha = typeof(CS.CharacterAlpha)
local TypeUnityBoxCollider = typeof(UnityEngine.BoxCollider)
local TypeUnityCollider = typeof(UnityEngine.Collider)
local TypeCapsuleCollider = typeof(UnityEngine.CapsuleCollider)
local TypeUnityRigidbody = typeof(UnityEngine.Rigidbody)
local TypeRagdollHitReaction = typeof(CS.Game.RagdollHitReaction)
local TypeRVOController = typeof(CS.Pathfinding.RVO.RVOController)
local HURT_EFFECT_CD = 0.2
local BREAK_SP_EFFECT = ShareRes.get_comm_string_value("BreakSuperArmorEffect")
local DEFAULT_HIT_EFFECT = "Fx_Common_BeHit"
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
  self.v_last_attack_hero_time = -1
  self.v_last_attacked_by_hero_time = nil
  self.v_level = 1
  self.v_shield_value_dirty = true
  self.v_input_codes = {}
  self.v_target = nil
  self.v_is_die = false
  self.v_is_after_behitfly_die = false
  self.v_atk_group_cd = {}
  self.v_atk_group_counts = {}
  self.v_element_cd_timer = 0
  self.v_dark_abnormal_total_hurt = 0
  self.effect_owner = nil
  self.v_is_show_hit_effect = true
end

function M:init_attached_colliders()
  if not self.attach_point then
    Log.Error("获取 AttachPoint组件失败，请检查 Npc ", self.id, "对应的模型是否有挂载 AttachPoint组件", debug.traceback())
    return
  end
  local colliders = self.attach_point.Colliders
  if nil == colliders then
    return
  end
  self.v_colliders_cid = {}
  local count = colliders.Length
  if count <= 0 then
    Log.Error("单位:", self.id, "没有添加碰撞盒或没有刷新碰撞盒列表，将无法识别碰撞！请检查预制！")
    return
  end
  for i = 0, count - 1 do
    local cid = colliders[i].gameObject:GetInstanceID()
    self.v_colliders_cid[cid] = colliders[i]
    SceneMgr:add_client_obj(cid, self)
  end
end

function M:clear_attached_colliders()
  if self.v_colliders_cid then
    for cid, _ in pairs(self.v_colliders_cid) do
      SceneMgr:remove_client_obj(cid)
    end
  end
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
  self:create_setting_point_pool()
  self.v_character_util = self.gameobj:TryAddComponent(TypeCharacterUtil)
  if not Config.IgnoreAllRootMotionMap[self.character_cfg.ModelId] then
    self.v_character_util:OverrideRootMotion()
  end
  self.capsule = self.gameobj:GetComponent(TypeCapsuleCollider)
  self.box_collider = self.gameobj:GetComponent(TypeUnityBoxCollider)
  self.v_rigid = self.gameobj:GetComponent(TypeUnityRigidbody)
  self.v_ragdoll_hit_reaction = self.gameobj:GetComponent(TypeRagdollHitReaction)
  self.radius = self.capsule.radius * self.model_scale
  if self:is_monster() and (self.v_kind == CommDefine.NPC_KIND.MONSTER or self.v_kind == CommDefine.NPC_KIND.ELITE or self.v_kind == CommDefine.NPC_KIND.BOSS) then
    self.rvo_controller = self.gameobj:TryAddComponent(TypeRVOController)
    self.rvo_controller.radius = self.radius + 0.25
    self.rvo_controller_enabled = true
  end
  self.v_collider_offset = Vec3.New()
  self.v_collider_offset:SetA(self.capsule.center)
  self.id = self.character_cfg.NpcId
  self.navigator_ctrl:init_gameobj(self.gameobj)
  self:init_attached_colliders()
  self:_init_state()
  self.act_ctrl:clear()
  self.v_real_pos = Vec3.New()
  self.v_is_can_searched = true
  local move_ratio = self.attr_mgr:get_attr(MOVE_ATTR_TYPE)
  self:set_speed_ratio(move_ratio)
  self:init_part()
  self.v_charcater_alpha = ShareRes.get_comm_value("CharacterAlphaVal") or 0.6
  if self:is_hero() or self:is_npc() then
    local transparent = self.gameobj:TryAddComponent(TypeCharacterAlpha)
    self.v_enable_transparent = true
    self.v_transparent = transparent
    self.v_transparent:AlphaExit()
  end
  if self.v_character_util then
    function self.v_character_util.StepEventEff(param)
      self:on_step(param)
    end
  end
  if self:has_ragdoll() then
    if self.character_cfg.Kind == CommDefine.NPC_KIND.ELITE or self.character_cfg.Kind == CommDefine.NPC_KIND.BOSS then
      self:init_ragdoll_setting()
      self:set_ragdoll_scale(self.model_scale)
    else
      self.v_ragdoll_hit_reaction:EnableRagdollAnimator(false)
      self.v_ragdoll_hit_reaction.enabled = false
      self.v_ragdoll_hit_reaction = nil
    end
  end
end

local Extrapolate = UnityEngine.RigidbodyInterpolation.Extrapolate

function M:set_rigid_extrapolate()
  if self.v_rigid and not self.v_has_set_rigid then
    self.v_rigid.interpolation = Extrapolate
    self.v_has_set_rigid = true
  end
end

function M:presetup(...)
  Base.presetup(self, ...)
end

function M:setup(...)
  self.v_is_ui_model = false
  Base.setup(self, ...)
  if self.v_has_setup then
    Log.Error("multi setup")
    return
  end
  self:add_component("fight_hud_mgr", require("uimodule.fight.fight_hud_mgr"):new(self))
  self:add_component("navigator_ctrl", require("manager.role_mgr.role_move_navigator"):new(self))
  local role_move_ctrl = require("manager.role_mgr.role_move_ctrl"):new(self)
  self:add_component("role_move_ctrl", role_move_ctrl)
  self:add_component("time_mgr", require("manager.time.time"):new(self))
  self:add_component("act_effect_ctrl", require("obj.act.act_effect_ctl_new"):new(self))
  self:add_component("magic_mgr", require("manager.magic.magic_mgr"):new(self))
  self:add_component("attr_mgr", require("manager.attr_mgr.attr_mgr"):new(self))
  self:add_component("skill_mgr", require("manager.fight.skillmgr"):new(self))
  self:add_component("effect_sound_mgr", require("manager.sound.effect_sound_mgr"):new(self))
  local character_cfg = self.character_cfg
  if self:is_npc() then
    self:add_component("element_abnormal_mgr", require("manager.fight.element_abnormal_mgr"):new(self))
    self.v_hp_bar_type = character_cfg.ShowSmallHpType
  end
  local motion_path = self.model_cfg and self.model_cfg.MotionPath or character_cfg.ModelId
  local motion_cfg = ShareRes.create("character.motion." .. motion_path)
  assert(motion_cfg, "can't find motion config: " .. motion_path)
  self.motion_cfg = motion_cfg
  local transition_cfg = ShareRes.create("character.transition." .. motion_path)
  assert(transition_cfg, "can't find transition config: " .. motion_path)
  self.transition_cfg = transition_cfg
  local act_ctrl = require("obj.act.act_controller_new"):new(self, self.motion_cfg, self.transition_cfg)
  self:add_component("act_ctrl", act_ctrl, true)
  self:add_component("weapon_mgr", require("manager.weapon_mgr.weapon_mgr"):new(self))
  self:add_component("char_renderers", require("manager.render.char_renderers"):new(self))
  self.v_kind = character_cfg.Kind
  self.is_cal_monster = CAl_MONSTER_TYPE[self.v_kind]
end

function M:setup_born_behavior()
  if self.is_load_behavior then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  if not self.gameobj then
    return
  end
  self:add_privilege_magic()
  self:add_hero_advance_magic()
  self:add_hero_talent_magic()
  self:add_weapon_skill_magic()
  self:add_hero_puzzle_magic()
  self:add_monster_born_magic()
  local born_magics = self.character_cfg.BornMagic
  if #born_magics <= 0 then
    return
  end
  self.is_load_behavior = true
  local born_magic = born_magics[1]
  if born_magic then
    BehaviorMgr:load(born_magic, self, self._on_load_file_finish)
  end
  self.char_renderers:check_hero_shadow()
end

function M:_on_load_file_finish(behavior)
  if self:is_destroy() then
    return
  end
  self.v_behavior = behavior
  if self:is_hero() then
    self.v_behavior.is_role_behavior = true
  end
  if self.magic_mgr then
    local born_magics = self.character_cfg.BornMagic
    for i = 2, #born_magics do
      self.magic_mgr:add_magic(self, born_magics[i])
    end
  end
  BehaviorMgr:call_behavior_fun(self, BehaviorMgr.EVENTS.ON_BORN_BEHAVIOR)
end

function M:add_monster_born_magic()
  if self:is_monster() and self:is_npc() then
    self:add_weak_born_magic()
    local tower = TowerMgr and TowerMgr:get_tower()
    local born_magics = tower and tower:get_born_magics(self.v_auto_level)
    if born_magics then
      for _, magic_id in pairs(born_magics) do
        self.magic_mgr:add_magic(self, magic_id)
      end
    end
    local born_magic_list = FightDataMgr:get_monster_born_magic_list(self.character_cfg.Kind)
    if born_magic_list then
      for magic_id, level in pairs(born_magic_list) do
        self.magic_mgr:add_magic(self, magic_id, nil, nil, level)
      end
    end
  end
end

function M:add_weak_born_magic()
  local ELEMENT_TYPE = FightDefine.ELEMENT_TYPE
  local element_to_config_name = {
    [ELEMENT_TYPE.BASE] = "MonsterPhysicsWeaknessBornMagic",
    [ELEMENT_TYPE.WATER] = "MonsterWaterWeaknessBornMagic",
    [ELEMENT_TYPE.FIRE] = "MonsterFireWeaknessBornMagic",
    [ELEMENT_TYPE.THUNDER] = "MonsterThunderWeaknessBornMagic",
    [ELEMENT_TYPE.LIGHT] = "MonsterLightWeaknessBornMagic",
    [ELEMENT_TYPE.DARK] = "MonsterDarkWeaknessBornMagic"
  }
  local config_name, cfg_magic_id, magic_table
  local element_weak_list = self.character_cfg and self.character_cfg.ElementWeakList
  if element_weak_list then
    for _, element_id in pairs(element_weak_list) do
      config_name = element_to_config_name[element_id]
      if not Util.is_empty(config_name) then
        magic_table = ShareRes.get_comm_string_value(config_name)
        cfg_magic_id = ShareRes.get_comm_value(config_name)
        if magic_table then
          for _, magic_id in pairs(magic_table) do
            self.magic_mgr:add_magic(self, magic_id)
          end
        end
        if Util.is_more_than_zero(cfg_magic_id) then
          self.magic_mgr:add_magic(self, cfg_magic_id)
        end
      end
    end
  end
end

function M:add_tower_drop_magic()
  local progress = TowerMgr and TowerMgr:get_tower_progress()
  if not progress then
    return
  end
  local tower_id = progress.tower_id
  local tower_drop_cfgs = tower_id and ShareRes.get_tower_drop_cfg(tower_id)
  if tower_drop_cfgs then
    local length = #tower_drop_cfgs
    local tower_drop_cfg
    for index = 1, length do
      tower_drop_cfg = tower_drop_cfgs[index]
      if progress.floor_id >= tower_drop_cfg.FloorNum then
        break
      end
    end
    if tower_drop_cfg and tower_drop_cfg.BornMagicList then
      local born_magics = tower_drop_cfg.BornMagicList
      for i = 1, #born_magics do
        self.magic_mgr:add_magic(self, born_magics[i])
      end
    end
  end
end

function M:add_privilege_magic()
  if not ChapterMgr then
    return
  end
  if self:is_hero() then
    local hero_magic_list = ChapterMgr:get_hero_magic_list()
    if hero_magic_list and next(hero_magic_list) then
      for _, magic_id in pairs(hero_magic_list) do
        self.magic_mgr:add_magic(self, magic_id)
      end
    end
  elseif self:is_god() then
    local god_magic_list = ChapterMgr:get_god_magic_list()
    if god_magic_list and next(god_magic_list) then
      for _, magic_id in pairs(god_magic_list) do
        self.magic_mgr:add_magic(self, magic_id)
      end
    end
  end
end

function M:add_hero_advance_magic()
  if not self:is_hero() then
    return
  end
  local advance_lv = self:get_advance()
  if not advance_lv then
    return
  end
  local buddy_advance_cfg = ShareRes.create("buddy.buddy_advance", self.character_cfg.NpcId)
  for _, cfg in ipairs(buddy_advance_cfg) do
    local born_magic_id = cfg.BornMagicId
    if advance_lv >= cfg.Lv and born_magic_id and 0 ~= born_magic_id then
      self.magic_mgr:add_magic(self, born_magic_id)
    end
  end
end

function M:add_hero_talent_magic()
  if not self:is_hero() then
    return
  end
  local buddy_info = self:get_buddy_data()
  if not buddy_info or not buddy_info.talent_lv then
    return
  end
  local talent_lv = buddy_info.talent_lv
  local talent_lv_cfg = ShareRes.get_buddy_talent_lv_cfg_list(self.character_cfg.NpcId)
  if talent_lv and talent_lv > 0 then
    for _, cfg in pairs(talent_lv_cfg) do
      local born_magic_id = cfg.Magic
      if talent_lv >= cfg.Lv and born_magic_id and 0 ~= born_magic_id then
        self.magic_mgr:add_magic(self, born_magic_id)
      end
    end
  end
end

function M:add_weapon_skill_magic()
  if not self:is_hero() then
    return
  end
  local buddy_info = self:get_buddy_data()
  if not buddy_info or not buddy_info.equip_data then
    return
  end
  local equip_data = buddy_info.equip_data
  local equip_advance_lv = equip_data.advance_lv
  if not equip_advance_lv then
    return
  end
  local equip_magic_id = ShareRes.get_weapon_magic(equip_data.id, equip_advance_lv)
  if not equip_magic_id or 0 == equip_magic_id then
    return
  end
  self.magic_mgr:add_magic(self, equip_magic_id, nil, nil, 1)
end

function M:add_hero_puzzle_magic()
  if not self:is_hero() then
    return
  end
  local buddy_info = self:get_buddy_data()
  local puzzle_graph = buddy_info.puzzle_graph
  if not puzzle_graph or not puzzle_graph.puzzle_place_infos then
    return
  end
  local entry_map = {}
  for _, puzzle_place_info in ipairs(puzzle_graph.puzzle_place_infos) do
    local puzzle_id = puzzle_place_info.id
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(puzzle_id)
    local entry_id = puzzle_cfg.EntryId
    if entry_id and (not entry_map[entry_id] or entry_map[entry_id] < puzzle_place_info.quality) then
      entry_map[entry_id] = puzzle_place_info.quality
    end
  end
  for entry_id, quality in pairs(entry_map) do
    local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(entry_id, quality)
    self.magic_mgr:add_magic(self, entry_cfg.MagicId, nil, nil, quality - 2)
  end
end

function M:get_weapon_advance_lv()
  if not self:is_hero() then
    return
  end
  local buddy_info = self:get_buddy_data()
  if not buddy_info or not buddy_info.equip_data then
    return
  end
  return buddy_info.equip_data.advance_lv
end

local TERRAIN_LAYER = Layer.LayerMask.Water
local gen_pos = Vec3.New()

function M:on_step()
  local hit, height, cid = Util.raycast(self.v_position.x, self.v_position.z, TERRAIN_LAYER, self.v_position.y + 1, 3)
  if hit then
    local terrain_cfg = SceneMgr:get_special_terrain_cfg(cid)
    gen_pos:Set(self.transform:GetPositionA())
    gen_pos.y = height
    if terrain_cfg then
      local scale = self.character_cfg.StepEffectScale
      SceneMgr:create_scene_effect(terrain_cfg.effect, gen_pos, nil, nil, nil, nil, scale)
    end
  end
end

function M:add_scene_skill_magic()
  if not self:is_god() then
    return
  end
  local skill_data, _ = TowerMgr:get_scene_skill_data()
  local skill_lv = skill_data.lv
  local skill_id = skill_data.id
  local skill_lv_cfg = ShareRes.get_scene_skill_lv_cfg(skill_id)
  assert(skill_lv_cfg, "ERROR NO SCENE SKILL Cfg" .. skill_id)
  for _, cfg in ipairs(skill_lv_cfg) do
    local cfg_lv = cfg.Lv
    if 0 ~= cfg.Magic then
      if skill_lv == cfg_lv then
        self.magic_mgr:add_magic(self, cfg.Magic, nil, nil, 1)
      else
        self.magic_mgr:remove_magic_by_id(cfg.Magic)
      end
    end
  end
end

function M:get_collider_posA()
  return self.v_position.x + self.v_collider_offset.x, self.v_position.y + self.v_collider_offset.y, self.v_position.z + self.v_collider_offset.z
end

function M:get_collider_offset_y()
  return self.v_collider_offset.y
end

function M:on_enable()
  Base.on_enable(self)
  self.state_manager:to_idle_state(true)
end

function M:update(dt)
  self.update_start = true
  if self:is_real_finish_init() then
    self.skill_mgr:update()
    self.state_manager:update()
    if self:is_npc() and self.element_abnormal_mgr then
      self.element_abnormal_mgr:update()
    end
    self.magic_mgr:update()
    self.act_ctrl:update()
  end
  self.time_mgr:update()
  if not self:is_hero() or not self:check_background() then
    self.navigator_ctrl:update()
    self.role_move_ctrl:update()
    self.fight_hud_mgr:update()
  end
  Base.update(self)
  self.update_start = false
end

function M:low_update()
  Base.low_update(self)
  if self:is_real_finish_init() then
    self.act_effect_ctrl:low_update()
    self.skill_mgr:low_update()
    self.attr_mgr:low_update()
    self.effect_sound_mgr:low_update()
  elseif self:is_god() then
    self.skill_mgr:low_update()
  end
  self:update_attack_cd_group()
  self:update_effect_timer()
  if self.update_remove_npc then
    self.update_remove_npc = false
    SceneMgr:remove_npc(self)
  end
end

function M:on_destroy_luaobj()
  Base.on_destroy_luaobj(self)
  FightDataMgr:clear_fight_data()
  self:clear_dynamic_bone_shake_list()
  self:clear_attached_colliders()
  if self.v_cid2part_info then
    for cid, _ in pairs(self.v_cid2part_info) do
      SceneMgr:remove_client_obj(cid)
    end
    self.v_cid2part_info = nil
  end
  self:set_target()
  if self.v_behavior then
    BehaviorMgr:remove(self.v_behavior.file_id, self)
    self.v_behavior = nil
  end
  self:set_record_hurt_flag_state(false)
  self.v_attacker_id = nil
  self.v_element_abnormal_caster_uuid = nil
  self.v_attacker_uuid = nil
  self.v_hurt_skill_id = nil
end

function M:can_slipout()
  local attack_state = self.state_manager:get_cur_state(STATE_NAME.attack)
  local is_attack = attack_state and attack_state:is_cast_time()
  local skill_can_slipout = self.skill_mgr and self.skill_mgr:can_slipout()
  local move_ctrl_can_slipout = self.role_move_ctrl and self.role_move_ctrl:can_slipout()
  return (is_attack and skill_can_slipout or not is_attack) and move_ctrl_can_slipout
end

function M:get_cur_energy()
end

function M:get_turnpos()
  return self.v_turnpos
end

function M:set_turnpos(pos)
  self.v_turnpos = pos
end

function M:mark_transparent()
  if self.v_character_util and not self.v_has_mark_transparent then
    MsgGame:mq_publish2(Const.MSG_ADD_TRANSPARENT_OBJ)
    self.v_character_util:ChangeRenderQueue(2000, true)
    self.v_has_mark_transparent = true
  end
end

function M:clear_transparent()
  if self.v_has_mark_transparent then
    self.v_has_mark_transparent = nil
    MsgGame:mq_publish2(Const.MSG_DEL_TRANSPARENT_OBJ)
  end
  if not Util.is_nil(self.v_character_util) then
    self.v_character_util:ChangeRenderQueue(-1, true)
    self.v_character_util.StepEvent = nil
  end
  if not Util.is_nil(self.v_transparent) then
    self.v_transparent:ClearRenderers()
  end
  self.v_transparent = nil
end

function M:get_character_util()
  return self.v_character_util or self.gameobj:TryAddComponent(TypeCharacterUtil)
end

function M:get_status()
  if self:is_destroy() then
    return CHARACTER_STATE_TYPE.DIE
  end
  local state_manager = self.state_manager
  local state_list = state_manager:get_all_state()
  local min_sort_val = 99999
  local min_state_id
  for state_name, _ in pairs(state_list) do
    local data = Config.STATE_NAME_TO_ID[state_name]
    if data then
      local sort_val = data.sort_val
      if min_sort_val > sort_val then
        min_sort_val = sort_val
        min_state_id = data.id
      end
    end
  end
  if not min_state_id then
    return CHARACTER_STATE_TYPE.IDLE
  else
    return min_state_id
  end
end

function M:is_in_state(status)
  local state_manager = self.state_manager
  if not state_manager then
    return false
  end
  if status == Config.CHARACTER_STATE_TYPE.TURN_OVER_FORBIT or status == Config.CHARACTER_STATE_TYPE.TURN_OVER then
    if not state_manager:is_in_state(STATE_NAME.turnover) then
      return false
    end
    local turn_over_state = state_manager:get_turnover_state()
    local is_forbid_now = turn_over_state:in_forbid_time()
    if status == Config.CHARACTER_STATE_TYPE.TURN_OVER_FORBIT then
      return is_forbid_now
    else
      return not is_forbid_now
    end
  end
  local state_name_list = Config.STATE_ID_TO_NAME[status]
  assert(state_name_list, "STATE NO ID OR NAME = " .. status)
  for _, state_name in pairs(state_name_list) do
    if state_manager:is_in_state(state_name) then
      return true
    end
  end
  return false
end

function M:late_update()
  Base.late_update(self)
  for k, _ in pairs(self.v_input_codes) do
    self.v_input_codes[k] = nil
  end
  if self.act_effect_ctrl then
    self.act_effect_ctrl:late_update()
  end
end

function M:on_time_scale(time_scale, pause, impact_sound_type, impact_sound_volume)
  if not self:is_real_finish_init() then
    return
  end
  if self.animator then
    self.animator.speed = time_scale
  end
  if self.weapon_mgr then
    self.weapon_mgr:set_weapon_animator_speed(time_scale)
  end
  self.act_effect_ctrl:update_speed(time_scale, pause)
  if Global.sound_mgr and self:is_hero() then
    Global.sound_mgr:change_sound_speed(time_scale, impact_sound_type, impact_sound_volume)
  end
  if self.time_mgr:get_is_ignoral_missile() then
    local missile_list = SceneMgr:get_missile_by_char(self)
    for _, missile in pairs(missile_list) do
      local effect_id = missile:get_missile_effect()
      self.act_effect_ctrl:update_missile_effect_speed(effect_id)
    end
  end
end

function M:create_setting_point_pool()
  if not self.v_is_empty_obj then
    self.attach_point = self.transform:GetComponent(TypeAttachPoint)
    if not self.attach_point then
      Log.Error("获取 AttachPoint组件失败，请检查 Npc ", self.id, "对应的模型是否有挂载 AttachPoint组件", debug.traceback())
    end
    self.attach_point_caches = {}
    self.attach_shake_bone_caches = {}
  else
    self.attach_point = nil
    self.attach_point_caches = nil
    self.attach_shake_bone_caches = nil
  end
end

function M:get_setting_point(point_name)
  if Util.is_empty(point_name) or not self.attach_point then
    return
  end
  if self.attach_point then
    if self.attach_point_caches[point_name] ~= nil then
      return self.attach_point_caches[point_name]
    else
      local point
      if point_name == CAMERA_NAME then
        point = Global.camera.transform
      else
        point = self.attach_point:GetPoint(point_name)
        point = point and point.transform
      end
      self.attach_point_caches[point_name] = point
      return point
    end
  end
end

function M:get_setting_shake_bone(bone_name)
  if not bone_name or "" == bone_name or not self.attach_point then
    return
  end
  if self.attach_point then
    if self.attach_shake_bone_caches[bone_name] ~= nil then
      return self.attach_shake_bone_caches[bone_name]
    else
      local bone = self.attach_point:GetShakeBone()
      self.attach_shake_bone_caches[bone_name] = bone
      return bone
    end
  end
end

function M:has_ragdoll()
  return self.v_ragdoll_hit_reaction ~= nil
end

function M:get_ragdoll()
  return self.v_ragdoll_hit_reaction
end

function M:initialize_weaponattach_setting(type)
  if self.v_ragdoll_hit_reaction then
    self.v_ragdoll_hit_reaction:InitializeWeaponAttachSetting(type)
  end
end

function M:enable_ragdoll_animator(enable)
  if self.v_ragdoll_hit_reaction then
    self.v_ragdoll_hit_reaction:EnableRagdollAnimator(enable)
  end
end

function M:set_enable_rvo(is_enable)
  if self.rvo_controller then
    self.rvo_controller.enabled = is_enable
    self.rvo_controller_enabled = is_enable
  end
end

function M:get_bone_shake_ratio()
  return self.character_cfg.BoneShakeRatio
end

function M:on_input(input_code)
  self.v_input_codes[input_code] = true
end

function M:has_input(input_code)
  return self.v_input_codes[input_code]
end

function M:can_update()
  if self.v_is_destroy then
    return false
  end
  return self.v_finish_init_gameobj and self.v_enable_count > 0
end

function M:set_max_hp(max_hp)
  self.attr_mgr.max_hp = max_hp
end

function M:set_max_mp(max_mp)
  self.attr_mgr.max_mp = max_mp
end

function M:get_select_obj_uuid()
  return self.v_target_scene_uuid
end

function M:get_select_obj()
  if self.v_target_scene_uuid then
    return Global.scene_mgr:pick_by_uuid(self.v_target_scene_uuid)
  end
end

function M:is_die()
  return self.v_is_die
end

function M:set_target_dir(dir, force)
  if self.v_is_die then
    return
  end
  Base.set_target_dir(self, dir, force)
end

function M:on_dead(...)
  Base.on_dead(self, ...)
  self.v_battle_status = false
  self.v_dead_time = Global.real_time
  self.v_is_can_searched = false
  self.v_is_die = true
  self:set_record_hurt_flag_state(false)
  self.state_manager:to_die_state(...)
  self.magic_mgr:on_role_dead()
  local msg = MsgGame:mq_publish2(Const.MSG_ROLE_DEAD)
  msg.mm_obj = self
  if 0 == SceneMgr:get_alive_ai_count() and self:is_npc() and self:get_ai_group_id() then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ALL_AI_DEAD)
  end
end

function M:set_dead(dead_action, action_remove, dead_cb)
  self.state_manager:report_set_die_state()
  if dead_cb then
    self.state_manager:check_die_action()
    self:on_dead(dead_action, action_remove, dead_cb)
    dead_cb(self:get_behavior())
  else
    self:on_dead(dead_action, action_remove, dead_cb)
  end
end

function M:get_uuid(...)
  return self.uuid
end

function M:on_attack_hero()
  self.v_last_attack_hero_time = Date.real_time()
  if self:is_monster() then
    Global.scene_mgr:get_monster_mgr():on_attack_hero(self)
  elseif self:is_player() then
    Global.scene_mgr:get_player_mgr():on_attack_hero(self)
  end
end

function M:on_destroy_gameobj()
  Base.on_destroy_gameobj(self)
  self:clear_transparent()
  if self.v_ragdoll_hit_reaction then
    self.v_ragdoll_hit_reaction = nil
  end
end

function M:is_female()
  return self.attr_mgr.sex == Config.FEMALE
end

function M:is_male()
  return self.attr_mgr.sex == Config.MALE
end

function M:is_in_battle()
  return self.v_battle_status
end

function M:is_server_in_battle()
  return self.v_server_battle_status
end

function M:is_auto_leave_battle()
  local in_battle = self.v_battle_status
  local leave_time = self.v_leave_battle_time
  local will_leave = nil ~= leave_time
  return in_battle and will_leave
end

function M:_need_update()
end

function M:is_role()
  return true
end

function M:get_distance_without_radius(another_obj)
  local distance = self:get_distance(another_obj)
  local radius = self:get_real_radius()
  local another_radius = another_obj:get_real_radius()
  return math.max(0, distance - radius - another_radius)
end

function M:get_role_gameobj()
  return self.gameobj
end

function M:_clear_gameobj()
  self.v_finish_init_gameobj = nil
  self.gameobj = nil
  self.transform = nil
  self.cid = nil
end

function M:_init_state()
  self.state_manager:to_idle_state(true)
end

function M:get_default_skill_list()
  return ShareRes.get_default_skill_list(self.character_cfg.NpcId)
end

function M:get_max_skill_ex_energy()
  return self.character_cfg.ExSkillEnergyMax
end

function M:get_character_cfg()
  return self.character_cfg
end

function M:is_hit_on_collide_pos()
  return Util.is_true(self.character_cfg.IsHitOnCollidePos)
end

function M:get_element_id()
  local role_cfg = ShareRes.get_buddy_cfg(self.character_cfg.NpcId)
  if role_cfg then
    return role_cfg.Element
  end
end

function M:set_can_searched(is_can_searched)
  self.v_is_can_searched = is_can_searched
end

function M:is_can_searched()
  return self.v_is_can_searched
end

function M:set_cant_be_hit(cant_be_hit)
  self.v_is_cant_be_hit = cant_be_hit
end

function M:is_cant_be_hit()
  return self.v_is_cant_be_hit
end

function M:get_ignore_lock()
  return self.v_ignore_lock
end

function M:set_ignore_lock(ignore_lock)
  self.v_ignore_lock = ignore_lock
end

function M:get_config_id()
  return self.character_cfg.NpcId
end

function M:get_base_attrs()
end

function M:get_module_attrs()
end

function M:update_module_attrs(module_type, attrs, sync)
end

function M:sync_module_attrs()
end

function M:set_level(level)
  if not level then
    return
  end
  self.v_level = level
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ROLE_LEVEL_CHANGE, self, level)
end

function M:set_buddy_data(buddy_data)
  if not buddy_data then
    return
  end
  self.v_buddy_data = buddy_data
end

function M:set_cur_hp(hp)
  if not hp then
    return
  end
  self.v_cur_hp = hp
end

function M:get_level()
  if self.character_cfg.MasterNpcId then
    local master = SceneMgr:get_hero_by_id(self.character_cfg.MasterNpcId)
    if master then
      return master:get_level()
    end
  end
  return self.v_level
end

function M:get_break_level()
  if self.character_cfg.MasterNpcId then
    local master = SceneMgr:get_hero_by_id(self.character_cfg.MasterNpcId)
    if master then
      return master:get_break_level()
    end
  end
  return self.v_buddy_data and self.v_buddy_data.break_lv or 0
end

function M:is_summons()
  return self.character_cfg.MasterNpcId ~= nil
end

function M:get_summoner()
  if self.character_cfg.MasterNpcId then
    return SceneMgr:get_hero_by_id(self.character_cfg.MasterNpcId)
  end
end

function M:get_advance()
  return self.v_buddy_data and self.v_buddy_data.advance or 0
end

function M:get_buddy_data()
  return self.v_buddy_data
end

function M:get_weapon_id()
  return self.v_buddy_data and self.v_buddy_data.equip_data and self.v_buddy_data.equip_data.id
end

function M:get_weapon_fashion()
  return self.v_buddy_data and self.v_buddy_data.equip_fashion
end

function M:get_fashion_id()
  return self.v_buddy_data and self.v_buddy_data.fashion
end

function M:set_target(target)
  if target and not target:is_destroy() then
    if target:is_hero() and self:is_monster() then
      local msg = MsgGame:mq_publish2(Const.MSG_HERO_BEING_LOCK)
      msg.mm_obj = self
    end
    target:on_be_targeted(self.uuid, true)
    self.v_target = target
  else
    if self.v_target and not self.v_target:is_destroy() then
      self.v_target:on_cancel_targetd(self.uuid)
    end
    if self:is_npc() and Global.hero and self.v_target ~= Global.hero then
      Global.hero:on_cancel_targetd(self.uuid)
    end
    self.v_target = nil
  end
end

function M:on_be_targeted()
end

function M:on_cancel_targetd()
end

function M:cal_char_shield()
  local shield_magics = self.magic_mgr:get_magics_by_type(SHIELD_MAGIC_TYPE)
  local shield_num = 0
  if shield_magics then
    for _, magic in pairs(shield_magics) do
      shield_num = shield_num + magic.v_shield_value
    end
  end
  return shield_num
end

function M:set_shield_num_dirty()
  self.v_shield_value_dirty = true
end

function M:get_shield_num()
  if self:is_hero() then
    local god = SceneMgr:get_god_npc()
    return god and god:get_overall_shield_value() or 0
  else
    if self.v_shield_value_dirty then
      self.v_shield_num = self:cal_char_shield()
    end
    return self.v_shield_num
  end
end

function M:cal_char_temp_blue()
  local temp_blue_magics = self.magic_mgr:get_magics_by_type(MAGIC_DEF.MAGIC_TYPE.TempBlue)
  local temp_blue_val = 0
  if temp_blue_magics then
    for _, magic in pairs(temp_blue_magics) do
      temp_blue_val = temp_blue_val + magic.v_temp_value
    end
  end
  return temp_blue_val
end

function M:set_temp_blue_dirty()
  self.v_temp_blue_dirty = true
end

function M:get_temp_blue_val()
  if self.v_temp_blue_dirty then
    self.v_temp_blue_val = self:cal_char_temp_blue()
  end
  return self.v_temp_blue_val
end

function M:get_target()
  return self.v_target
end

function M:get_name()
  if not self.character_cfg then
    return ""
  end
  return self.character_cfg.name
end

function M:get_npc_id()
  return self.character_cfg.NpcId
end

function M:get_dt()
  return self.time_mgr and self.time_mgr:get_dt_time() or Global.delta_time
end

function M:get_low_dt()
  return self.time_mgr and self.time_mgr:get_low_dt_time() or Global.low_delta_time
end

function M:get_missile_dt()
  if self.time_mgr then
    if self.time_mgr:get_is_ignoral_missile() or self:is_die() or self:is_destroy() then
      return Global.delta_time
    end
    return self.time_mgr:get_dt_time()
  end
  return Global.delta_time
end

function M:get_missile_low_dt()
  if self.time_mgr then
    if self.time_mgr:get_is_ignoral_missile() or self:is_die() or self:is_destroy() then
      return Global.low_delta_time
    end
    return self.time_mgr:get_low_dt_time()
  end
  return Global.low_delta_time
end

function M:get_missile_fixed_dt()
  if self.time_mgr then
    if self.time_mgr:get_is_ignoral_missile() or self:is_die() or self:is_destroy() then
      return Global.fixed_delta_time
    end
    return self.time_mgr:get_fixed_dt_time()
  end
  return Global.fixed_delta_time
end

function M:get_born_magics()
  local born_magics = self.character_cfg.BornMagic
  return born_magics[1]
end

function M:on_bone_shake(time, strength, interval, x, z, angle)
  local shake_bone = self:get_setting_shake_bone(ROOT_BONE_SHAKE_NAME)
  if shake_bone then
    angle = angle or 0
    shake_bone:SetBoneShake(time, strength, interval, x, 0, z, 0 == angle)
  end
end

function M:hit_ragdoll(x, z, hit_pos_vec3, type)
  if self.v_ragdoll_hit_reaction then
    self.v_ragdoll_hit_reaction:Hit(x, 0, z, hit_pos_vec3.x, hit_pos_vec3.y, hit_pos_vec3.z, type > 2)
  end
end

function M:replace_ragdoll_power_profile(index)
  if self.v_ragdoll_hit_reaction then
    self.v_ragdoll_hit_reaction:ReplaceRagdollPowerProfile(index)
  end
end

function M:init_ragdoll_setting()
  self.v_ragdoll_hit_reaction:InitRagdollSetting()
end

function M:set_ragdoll_scale(scale)
  self.v_ragdoll_hit_reaction:SetRagdollScale(scale)
end

function M:destroy()
  Global.scene_mgr:remove_npc(self)
end

function M:report_create()
  if Util.is_client_only() or not StateReport then
    return
  end
  if 1 == self.uuid % 10 then
    return
  end
  local pos = {}
  pos.x, pos.y, pos.z = self.v_position.x, self.v_position.y, self.v_position.z
  local request = {
    id = self.character_cfg.NpcId,
    pos = pos,
    level = self.v_level,
    uuid = self.uuid,
    camp = self.camp,
    npc_name = self.v_npc_local_name
  }
  StateReport:creat_npc(request)
end

function M:init_ui_model_gameobj(gameobj, transform, parent, params)
  local hide_weapon, fixed_char_id, use_attach_model, use_weapon_id, use_weapon_res, ignore_fashion, is_out_battle
  if params then
    hide_weapon = params.hide_weapon
    fixed_char_id = params.fixed_char_id
    use_attach_model = params.use_attach_model
    use_weapon_id = params.use_weapon_id
    use_weapon_res = params.use_weapon_res
    is_out_battle = params.is_out_battle
    ignore_fashion = params.ignore_fashion
  end
  self.v_is_ui_model = true
  transform.parent = parent
  self.gameobj = gameobj
  self.transform = transform
  self:init_animator()
  self:set_finish_init_gameobj(true)
  self.v_loading_gameobj = false
  self.v_need_loading_obj = false
  self:update_scale()
  self:update_pos()
  self:create_setting_point_pool()
  self:set_layer(Layer.Layer.Character)
  local character_cfg = self.character_cfg
  local motion_path
  if self.model_cfg and not Util.is_empty(self.model_cfg.MotionPath) then
    motion_path = self.model_cfg.MotionPath
  else
    motion_path = character_cfg.ModelId
  end
  local motion_cfg = ShareRes.create("character.motion." .. motion_path)
  self.motion_cfg = motion_cfg
  local transition_cfg = ShareRes.create("character.transition." .. motion_path)
  self.transition_cfg = transition_cfg
  self:add_component("orienter", require("obj.behavior.orienter"):new(self))
  self:add_component("time_mgr", require("manager.time.time"):new(self))
  local act_ctrl = require("obj.act.act_controller_new"):new(self, self.motion_cfg, self.transition_cfg)
  self:add_component("act_ctrl", act_ctrl, true)
  if self:is_hero() then
    self:add_component("weapon_mgr", require("manager.weapon_mgr.weapon_mgr"):new(self))
  end
  self:add_component("char_renderers", require("manager.render.char_renderers"):new(self))
  self:add_component("act_effect_ctrl", require("obj.act.act_effect_ctl_new"):new(self))
  self:add_component("effect_sound_mgr", require("manager.sound.effect_sound_mgr"):new(self))
  self.transform:SetLocalPositionA(self.v_position.x, self.v_position.y, self.v_position.z)
  if not hide_weapon then
    if use_weapon_res then
      self.weapon_mgr:ui_model_init_weapon_by_res(use_weapon_res)
    else
      self.weapon_mgr:ui_model_init_weapon(fixed_char_id, use_weapon_id, ignore_fashion)
    end
  end
  self:broadcast("on_char_gameobj_loaded")
  if use_attach_model then
    self:add_component("attach_model_mgr", require("manager.weapon_mgr.attach_model_mgr"):new(self))
  end
end

function M:try_load_attach_model_by_act(act_name, done_cb)
  if self.attach_model_mgr and act_name then
    self.attach_model_mgr:try_load_attach_model_by_act(act_name, done_cb)
  elseif done_cb then
    done_cb()
  end
end

function M:set_enable_transparent(is_enable)
  self.v_enable_transparent = is_enable
end

function M:check_transparent(is_enter)
  if Util.is_nil(self.v_transparent) then
    return
  end
  if not self.v_enable_transparent then
    return
  end
  if is_enter then
    self.v_transparent:AlphaEnter(self.v_charcater_alpha)
  else
    self.v_transparent:AlphaExit()
  end
end

function M:enable_part_damage(part_id, enable)
  local part = self:get_part_info_by_id(part_id)
  if part then
    part.go:SetActive(enable)
  end
end

function M:get_collider()
  return self.capsule
end

function M:hide_invalid_collider()
  if not Util.is_nil(self.box_collider) then
    self.box_collider.enabled = false
  end
end

function M:init_part()
  if not self.character_cfg.RegionID then
    return
  end
  self.v_cid2part_info = {}
  self.v_part_id_map = {}
  local monster_base_attr = ShareRes.create("monster.monster_base_attr")
  local be_hit_effect = self.character_cfg.AreaBeHitEffect
  for k, region_data in ipairs(self.character_cfg.RegionID) do
    local name = region_data[1]
    local part_npc_res_id = region_data[2]
    local transform = self:get_setting_point(name)
    if transform then
      local go = transform.gameObject
      local cid = go:GetInstanceID()
      local area = self.character_cfg.RegionArea[k]
      local point_name = be_hit_effect and be_hit_effect[k]
      local info = {
        cid = cid,
        transform = transform,
        go = go,
        attach_point = name,
        part_id = tonumber(area[1]),
        attr_id = tonumber(area[2]),
        start_degree = tonumber(area[3]),
        end_degree = tonumber(area[4]),
        fix_dmg = tonumber(area[5]),
        all_part_cd_on_beattack = Util.is_more_than_zero(area[6]),
        part_type = tonumber(area[7]),
        collider = transform:GetComponent(TypeUnityCollider)
      }
      if not Util.is_empty(point_name) and "null" ~= point_name then
        local tf = self:get_setting_point(point_name)
        if tf then
          info.effect_go = tf.gameObject
        else
          Log.Error("需要挂特效的部位不存在, 检查怪物是否有RegionArea第六个参数有对应的挂点， 挂点名：", point_name, "怪物id：", self.character_cfg.NpcId)
        end
      end
      self.v_cid2part_info[cid] = info
      self.v_part_id_map[info.part_id] = info
      if part_npc_res_id then
        SceneMgr:create_part_npc(tonumber(part_npc_res_id), self, name, info.part_id, self:get_camp())
      else
        info.attrs = FightDefine.get_monster_kv_attrs(info.attr_id, 0, monster_base_attr, {})
        SceneMgr:add_client_obj(cid, self)
      end
    else
      Log.Error(string.format("获取部位失败，character_id：%s, 部位名：%s", self.character_cfg.NpcId, name))
    end
  end
  if UNITY_EDITOR then
    self:draw_test_part_area()
  end
end

function M:get_part(cid)
  local part_info = self.v_cid2part_info and self.v_cid2part_info[cid]
  if part_info and part_info.part_uuid then
    return
  end
  return part_info
end

function M:get_all_part_info()
  return self.v_part_id_map
end

function M:get_part_info_by_id(part_id)
  if not self.v_part_id_map then
    return
  end
  local info = self.v_part_id_map[part_id]
  if not info then
    return
  end
  return info
end

function M:change_part_attr(part_id, type, value)
  local info = self.v_part_id_map[part_id]
  if not info then
    return
  end
  value = info.attrs[type] + value
  info.attrs[type] = value
  return value
end

function M:set_npc_on_part(part_uuid, part_id)
  local part_info = self.v_part_id_map[part_id]
  if part_info then
    part_info.part_uuid = part_uuid
  end
end

function M:set_part_attr(part_id, type, value)
  local info = self.v_part_id_map[part_id]
  if not info then
    return
  end
  info.attrs[type] = value
  SceneMgr:c2gs_call_scene("set_npc_part_attr", self.uuid, part_id, type, value)
end

function M:get_part_attr(part_id, type)
  local info = self.v_part_id_map[part_id]
  if not info then
    return
  end
  return info.attrs[type]
end

function M:get_part_pos(part_cid)
  local info = self.v_cid2part_info[part_cid]
  if not info then
    return
  end
  return info.transform:GetPositionA()
end

function M:check_has_part()
  return self.v_part_id_map and next(self.v_part_id_map) ~= nil
end

function M:part_hit_precheck(missile, part_cid)
  if not self.v_cid2part_info or not self.v_cid2part_info[part_cid] then
    return
  end
  local part_info = self.v_cid2part_info[part_cid]
  local x, z = self:get_pos2()
  local px, pz = missile:get_owner():get_pos2()
  local degree = (_get_angle2A(px - x, pz - z) or 0) % 360
  local self_dir = self:get_dir()
  if not self_dir then
    return false
  end
  local st_deg = (part_info.start_degree + self_dir) % 360
  local ed_deg = (part_info.end_degree + self_dir) % 360
  local res
  if st_deg < ed_deg then
    res = degree > st_deg and degree < ed_deg
  else
    res = degree > st_deg or degree < ed_deg
  end
  return res
end

function M:get_part_id_by_cid(cid)
  local part_info = self.v_cid2part_info[cid]
  if not part_info then
    return
  end
  return part_info.part_id
end

function M:draw_test_part_area()
  local radius = 2
  local check_vec = Vec3.New()
  local Color = UnityEngine.Color
  local Debug = UnityEngine.Debug
  local y = self:get_dir()
  if not self.v_cid2part_info then
    return
  end
  for _, v in pairs(self.v_cid2part_info) do
    local st_deg = y + v.start_degree
    check_vec.x = _cos(_deg2rad * st_deg)
    check_vec.z = _sin(_deg2rad * st_deg)
    Debug.DrawLine(self.v_position, self.v_position + check_vec * radius, Color.green, 0.1)
    local ed_deg = y + v.end_degree
    check_vec.x = _cos(_deg2rad * ed_deg)
    check_vec.z = _sin(_deg2rad * ed_deg)
    Debug.DrawLine(self.v_position, self.v_position + check_vec * radius, Color.red, 0.1)
  end
end

function M:pack_msg_data()
  local msg_data = {
    uuid = self.uuid,
    attr_data = self.attr_mgr:pack_attrs_data(),
    magic_list = self.magic_mgr:pack_msg_magic_data()
  }
  local part_data = {}
  for part_id, v in pairs(self.v_part_id_map or {}) do
    local data = {
      part_id = part_id,
      attr_list = v.attrs
    }
    _tinsert(part_data, data)
  end
  msg_data.part_attr = part_data
  return msg_data
end

function M:get_in_global_scale()
  return self.time_mgr and self.time_mgr:get_is_global_scale() or false
end

function M:get_time_scale()
  return self.time_mgr and self.time_mgr:get_time_scale() or 1
end

function M:update_global_speed(is_global)
  self.act_effect_ctrl:update_global_speed(is_global)
end

function M:get_behavior()
  return self.v_behavior
end

function M:set_dynamic_bone_shake_list(bone_type, bone_name_list)
  self.v_dynamic_bone_shake_list = {}
  self.v_dynamic_bone_shake_list[bone_type] = bone_name_list
end

function M:clear_dynamic_bone_shake_list()
  self.v_dynamic_bone_shake_list = nil
end

function M:check_attrs(module)
  SceneMgr:c2gs_call_scene("check_attrs", self.uuid, module, self.attr_mgr.attrs)
end

function M:set_before_hurt_info(attacker, skill_id)
  self.v_attacker_id = attacker.id
  self.v_attacker_uuid = attacker.uuid
  self.v_hurt_skill_id = skill_id
end

function M:set_last_hurt_info(attacker, total_hurt)
  self:damage_trigger_sound(attacker, total_hurt)
  if self.v_record_hurt_flag then
    self:record_dark_abnormal_total_hurt(total_hurt)
  end
end

function M:damage_trigger_sound(attacker, total_hurt)
  if attacker:is_monster() then
    self.v_start_time = self.v_start_time or Global.real_time
    self.v_max_hp = self.v_max_hp or self.attr_mgr:get_max_hp()
    self.v_total_hp = self.v_total_hp or 0
    self.v_cur_time = Global.real_time
    local hurt_interval = ShareRes.get_comm_value("HurtTime")
    local hurt_percent = ShareRes.get_comm_value("HurtPercent") / 100
    if hurt_interval >= self.v_cur_time - self.v_start_time then
      if self.v_max_hp <= 0 then
        self.v_max_hp = 1
      end
      self.v_total_hp = self.v_total_hp - total_hurt
      if hurt_percent <= self.v_total_hp / self.v_max_hp then
        if Global.state_sound_mgr then
          Global.state_sound_mgr:trigger_char_state_by_id(self, CHARACTER_STATE_TYPE.PERCENT_DAMAGE_ON_SEC)
        end
        self.v_start_time = nil
        self.v_total_hp = nil
      end
    elseif hurt_percent <= -total_hurt / self.v_max_hp then
      if Global.state_sound_mgr then
        Global.state_sound_mgr:trigger_char_state_by_id(self, CHARACTER_STATE_TYPE.PERCENT_DAMAGE_ON_SEC)
      end
      self.v_start_time = nil
      self.v_total_hp = nil
    else
      self.v_start_time = self.v_cur_time
      self.v_total_hp = -total_hurt
    end
  end
end

function M:record_dark_abnormal_total_hurt(total_hurt)
  self.v_dark_abnormal_total_hurt = self.v_dark_abnormal_total_hurt + total_hurt
end

function M:get_dark_abnormal_total_hurt()
  return self.v_dark_abnormal_total_hurt
end

function M:reset_dark_abnormal_total_hurt()
  self.v_dark_abnormal_total_hurt = 0
end

function M:get_last_hurt_attacker_id()
  return self.v_attacker_id, self.v_attacker_uuid, self.v_hurt_skill_id
end

function M:trigger_hurt(attacker)
  if not self:is_hero() then
    return
  end
  if attacker == self then
    return
  end
  if not TowerMgr then
    return
  end
  if not BuffMgr then
    return
  end
  local room = TowerMgr:get_cur_room()
  if not room then
    return
  end
  if room:is_fight_end() then
    return
  end
  BuffMgr:check_forbid_switch_hero_buff()
end

function M:special_tag(tag)
  if nil ~= tag then
    if 1 ~= tag and 0 ~= tag % 2 then
      Log.Error("单位的tag设置错误，只能设置2的幂次方数值！！")
      return
    end
    self.v_sp_tag = tag
  else
    return self.v_sp_tag
  end
end

function M:remove_special_tag()
  self.v_sp_tag = nil
end

function M:get_role_kind()
  return self.v_kind
end

function M:get_role_job()
  local role_cfg = ShareRes.get_buddy_cfg(self.character_cfg.NpcId)
  return role_cfg and role_cfg.Job or nil
end

function M:update_attack_cd_group()
  for group, atk_cd_list in pairs(self.v_atk_group_cd) do
    for id, timer in pairs(atk_cd_list) do
      if timer ~= Config.MISSILE_ONCE_ATKCD then
        local cd = timer - self.time_mgr:get_low_dt_time()
        if cd <= 0 then
          atk_cd_list[id] = nil
          self.v_atk_group_counts[group] = self.v_atk_group_counts[group] - 1
        else
          atk_cd_list[id] = cd
        end
      end
    end
    if self.v_atk_group_counts[group] <= 0 then
      self.v_atk_group_cd[group] = nil
      self.v_atk_group_counts[group] = nil
    end
  end
end

function M:update_effect_timer()
  local dt = GlobalTimeMgr:get_dt_time()
  if self.v_element_cd_timer <= 0 then
    self.v_element_cd_timer = 0
  else
    self.v_element_cd_timer = self.v_element_cd_timer - dt
  end
end

function M:trigger_damage(damage_data)
  if 0 ~= self.v_element_cd_timer then
    return
  end
  self.v_element_cd_timer = HURT_EFFECT_CD
  if not damage_data then
    return
  end
  local element_type = damage_data.element_type
  local sp_change_val = damage_data.sp_armor_hurt
  local target_part_id = damage_data.target_part_id
  element_type = 0 == element_type and 1 or element_type
  local element_cfg = ShareRes.create("buddy.buddy_element", element_type)
  local effect_name = element_cfg.BeHitEffect
  if Util.is_empty(effect_name) then
    effect_name = DEFAULT_HIT_EFFECT
  end
  if effect_name == DEFAULT_HIT_EFFECT and self.character_cfg.PlayCommonBeHit and self.character_cfg.PlayCommonBeHit <= 0 then
    return
  end
  self:_play_hit_effect(effect_name, target_part_id)
end

function M:_play_hit_effect(effect_name, target_part_id)
  local hit_pos_name = self.character_cfg.HitPos
  local point_trans
  if hit_pos_name and "" ~= hit_pos_name then
    point_trans = self.attach_point:GetPoint(hit_pos_name)
  else
    point_trans = self.transform
  end
  local effect_param = self.act_effect_ctrl.create_effect_param()
  effect_param.prefab_name = effect_name
  effect_param.parent = point_trans
  effect_param.time_scale = 1
  effect_param.not_time_scale = true
  if effect_name == DEFAULT_HIT_EFFECT and target_part_id and self.v_part_id_map[target_part_id] then
    local part_info = self.v_part_id_map[target_part_id]
    local effect_go = part_info.effect_go
    if effect_go and not effect_go.gameObject:IsNull() then
      effect_param.effect_gameobj = effect_go.gameObject
    end
  end
  self.act_effect_ctrl:play_effect(effect_param)
end

function M:set_show_hit_effect_state(is_show_hit_effect)
  self.v_is_show_hit_effect = is_show_hit_effect
end

function M:is_show_hit_effect()
  return self.v_is_show_hit_effect
end

function M:set_floating_text_hud_visible(is_show)
  if nil == is_show then
    self.is_show_floating_text_hud = false
    return
  end
  self.is_show_floating_text_hud = is_show
end

function M:get_floating_text_hud_visible()
  if self.is_show_floating_text_hud == nil then
    self.is_show_floating_text_hud = true
  end
  return self.is_show_floating_text_hud
end

function M:refresh_atk_cd_group(group, uuid, cd)
  if cd ~= Config.MISSILE_ONCE_ATKCD and not Util.is_more_than_zero(cd) then
    return
  end
  if not self.v_atk_group_cd[group] then
    self.v_atk_group_cd[group] = self.v_atk_group_cd[group] or {}
    self.v_atk_group_counts[group] = self.v_atk_group_counts[group] or 0
  end
  self.v_atk_group_cd[group][uuid] = cd
  self.v_atk_group_counts[group] = self.v_atk_group_counts[group] + 1
end

function M:get_atk_cd_group_cd(group, uuid)
  return self.v_atk_group_cd[group] and self.v_atk_group_cd[group][uuid] or nil
end

function M:remove_atk_cd_group(group)
  if self.v_atk_group_counts[group] then
    self.v_atk_group_counts[group] = self.v_atk_group_counts[group] - 1
    if self.v_atk_group_counts[group] <= 0 then
      self.v_atk_group_cd[group] = nil
      self.v_atk_group_counts[group] = nil
    end
  end
end

function M:add_duration_damage(magic_id, magic_uuid, element_id)
  self.element_abnormal_mgr:add_duration_damage(magic_id, magic_uuid, element_id)
end

function M:get_element_parameter(index)
  return self.element_abnormal_mgr:get_element_parameter(index)
end

function M:check_additional_damage()
  if self.element_abnormal_mgr then
    self.element_abnormal_mgr:check_additional_damage()
  end
end

function M:set_record_hurt_flag_state(is_open)
  self.v_record_hurt_flag = is_open
end

function M:get_attr_value(attr_id)
  return self.attr_mgr:get_attr(attr_id)
end

function M:is_in_auto_move_state()
  return self.state_manager:is_in_state(Config.STATE_NAME.auto_forward_move)
end

function M:is_scene_npc()
  return false
end

function M:is_after_behitfly_die()
  return self.v_is_after_behitfly_die
end

function M:on_controller_change(animator_info, animator_name)
  local cfg_name = string.gsub(animator_name, ".overrideController", "")
  local animator = self.animator or self.gameobj:GetComponent(TypeUnityAnimator)
  if not animator then
    ResPoolMgr:release_res(animator_info)
    return
  end
  if self.animator_info then
    ResPoolMgr:release_res(self.animator_info)
    self.animator_info = nil
  end
  animator.runtimeAnimatorController = animator_info.res
  self.animator_info = animator_info
  local motion_cfg = ShareRes.create("character.motion." .. cfg_name)
  assert(motion_cfg, "can't find motion config: " .. cfg_name)
  local transition_cfg = ShareRes.create("character.transition." .. cfg_name)
  assert(transition_cfg, "can't find transition config: " .. cfg_name)
  self.act_ctrl:set_motion_cfg(motion_cfg)
  self.act_ctrl:set_transition_cfg(transition_cfg)
  self.motion_cfg = motion_cfg
  self.transition_cfg = transition_cfg
  BehaviorMgr:call_behavior_fun(self, BehaviorMgr.EVENTS.ON_CONTROLLER_CHANGE, animator_name)
end

function M:set_hit_stop_timer(timer)
  if self.v_hit_stop_timer then
    Timer:remove_timer(self.v_hit_stop_timer)
    self.v_hit_stop_timer = nil
  end
  self.v_hit_stop_timer = timer
end

function M:_add_hit_stop(logic_cfg)
  local scale = logic_cfg[1]
  local duration = Util.frame2realtime(logic_cfg[2], 0)
  local ease_in = Util.frame2realtime(logic_cfg[3], 0)
  local ease_out = Util.frame2realtime(logic_cfg[4], 0)
  local ignoral_missile = logic_cfg[6]
  if not Util.is_destroy(self) then
    local scale_data = {
      ease_in = ease_in,
      ease_out = ease_out,
      magic_id = Config.MISSILE_HIT_STOP_ID,
      ignoral_missile = ignoral_missile
    }
    self.time_mgr:add_time_scale(scale, duration, scale_data)
  end
  self:set_hit_stop_timer(nil)
end

function M:add_hit_stop(logic_cfg, is_hit_fly)
  local delay_frame_param_idx = 5
  if is_hit_fly then
    delay_frame_param_idx = 7
  end
  local delayed_frame = logic_cfg[delay_frame_param_idx] and Util.frame2realtime(logic_cfg[delay_frame_param_idx], 0) or 0
  self.time_mgr:remove_time_scale(Config.MISSILE_HIT_STOP_ID)
  if delayed_frame and delayed_frame > 0 then
    local timer = Timer:add_timer(nil, delayed_frame, self._add_hit_stop, self, logic_cfg)
    self:set_hit_stop_timer(timer)
  else
    self:_add_hit_stop(logic_cfg)
  end
end

function M:clear_hit_stop()
  self.time_mgr:remove_time_scale(Config.MISSILE_HIT_STOP_ID)
  self:set_hit_stop_timer(nil)
end

return M
