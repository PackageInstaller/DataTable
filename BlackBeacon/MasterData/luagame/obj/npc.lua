local Base = require("obj.role")
local Layer = require("utils.layer")
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local SHADOW_PATH = "Fx_Common_Shadow"
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local CommDefine = require("cs_share.common_define")
local NPC_KIND = CommDefine.NPC_KIND
local BEHIT_TYEP = Config.BEHIT_TYEP
local DAMAGE_TYPE = Config.DAMAGE_TYPE
local HIT_EFFECT_TABLE = {
  [BEHIT_TYEP.LEFT_SMALL] = 1,
  [BEHIT_TYEP.LEFT_LARGE] = 1,
  [BEHIT_TYEP.COMBO_HIT_LEFT_START] = 1,
  [BEHIT_TYEP.RIGHT_SMALL] = 2,
  [BEHIT_TYEP.RIGHT_LARGE] = 2,
  [BEHIT_TYEP.COMBO_HIT_RIGHT_START] = 2,
  [BEHIT_TYEP.HIT_FLY] = 3,
  [BEHIT_TYEP.ROLL_HIT_FLY] = 3
}
local HIT_TYPE_ADDEND = {
  [DAMAGE_TYPE.SHARP] = 0,
  [DAMAGE_TYPE.BLUNT] = 1
}
local CSUnityEngine = UnityEngine
local CSUnityUI = CSUnityEngine.UI
local TOUGH_CONFIG_INDEX = Config.TOUGH_CONFIG_INDEX
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local UnityScreen = UnityEngine.Screen
local ATTR_GROUP_TYPE = Config.ATTR_GROUP_TYPE
local STATE_NAME = Global.config.STATE_NAME
local UI_POINT_NAME = "attachpoint"
local DIVISION_KEY = "DIVISION_KEY"
local ResMgr = Global.res_mgr
local _tinsert = table.insert
local _ceil = math.ceil
local HP_TXT_SHOW_TIME = 5
local CSDebug = UnityEngine.Debug
local Color = UnityEngine.Color
local atan = math.atan
local deg = math.deg
local Math = require("base.mathx")
local Quat = require("base.quat")
local _clamp = Math.Clamp
local deg_val = deg(1)
local _lerp = Math.lerp_number
local lerp_val = ShareRes.get_comm_value("NpcLookAtLerpVal")
local QualityCfg = require("manager.render.quality_cfg")
local QualityShadow = QualityCfg.SHADOW
local MAX_HP_ITEM_MASK_NUM = 10
local BOSS_BREAK_MAGIC = ShareRes.get_comm_string_value("BossToughBreakMagic")
local ELITE_BREAK_MAGIC = ShareRes.get_comm_string_value("EliteToughBreakMagic")
local DEAD_ROTATION_TYPE = {NPC_DIR = 0, BEHIT_DIR = 1}
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
  self.v_division_obj_list = {}
  self.v_buff_item = {}
  self.v_shadow_enabled = true
  self.v_is_set_dead = false
  self.v_is_end_action = false
  self.v_is_max_wave = false
  self.v_event_key = nil
  self.v_force_remove_timer = nil
  self.v_stun_animation_group_id = 1
end

function M:presetup(...)
  Base.presetup(self)
  self:add_component("state_manager", require("obj.state.manager.npc_state_manager"):new(self))
  self:add_component("time_revert", require("manager.time.time_revert"):new(self))
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
  if self.character_cfg.Kind == CommDefine.NPC_KIND.OBSTRUCT then
    self:set_layer_except(Layer.Layer.NPC, Layer.Layer.SceneBlock)
  else
    self:set_layer(Layer.Layer.NPC)
  end
  self.time_revert:init_gameobj(self.gameobj)
  if not self.v_toughness_info then
    self.v_toughness_cfg_dict = {}
    if 1 == ShareRes.get_comm_value("ToughSystemTrigger") and self.character_cfg.ToughnessInfo then
      self:init_toughness_info()
    end
  end
  self:bind_events()
  if not self.v_ui_hp and self:need_ui_hp() then
    self:create_ui_hp()
  end
  local _, show_elite_bar = Util.check_show_hp_bar_type(self.v_hp_bar_type)
  if show_elite_bar then
    self:create_elite_hp_bar()
  end
  self.v_hp_visible = true
  if self.gameobj ~= nil then
    CSHelper.ForceLODGroup(self.gameobj.transform, -1)
  end
end

function M:bind_events()
  Util.bind_msg(self, Const.MSG_ON_TRIGGER_DAMAGE, self.trigger_damage, self)
end

function M:create_ui_hp()
  local dynamic_ui = Global.ui_dynamic_canvas
  if not dynamic_ui then
    return
  end
  self.v_ui_hp = dynamic_ui:get_hp_item()
  Global.ui_dynamic_canvas:add_ui_hp_to_update_list(self.v_ui_hp)
  self.v_ui_hp:init_char_info(self)
end

function M:release_hp_item()
  if Global.ui_dynamic_canvas and self.v_ui_hp then
    Global.ui_dynamic_canvas:remove_ui_hp_at_update_list(self.v_ui_hp)
    Global.ui_dynamic_canvas:release_hp_item(self.v_ui_hp)
  end
  self.v_ui_hp = nil
end

function M:init_toughness_info(init_param)
  local param = init_param or self.character_cfg.ToughnessInfo
  self.v_toughness_info = {}
  self.v_toughness_cfg_dict = {}
  local info = self.v_toughness_info
  info.max_tough_value = 0
  info.lv_down_values = {
    [0] = 0
  }
  info.lv_up_values = {}
  for index = #param, 1, -1 do
    local cfg = param[index]
    table.insert(self.v_toughness_cfg_dict, cfg)
    info.max_tough_value = cfg[TOUGH_CONFIG_INDEX.MAX_VALUE] + info.max_tough_value
  end
  for i = 1, #self.v_toughness_cfg_dict do
    for index = 1, i do
      local cfg = self.v_toughness_cfg_dict[index]
      local cur_lv_max_value = cfg[TOUGH_CONFIG_INDEX.MAX_VALUE]
      info.lv_down_values[i] = (info.lv_down_values[i] or 0) + cur_lv_max_value
    end
    local cfg = self.v_toughness_cfg_dict[i]
    local cur_lv_max_value = cfg[TOUGH_CONFIG_INDEX.MAX_VALUE]
    info.lv_up_values[i] = math.max(info.lv_down_values[i] - cur_lv_max_value, 0)
  end
  self:reset_toughness_info(nil, nil == init_param)
  local msg = MsgGame:mq_publish2(Const.MSG_TOUGHNESS_CHANGE)
  msg.mm_x = self.uuid
  msg.mm_y = Config.TOUGH_CHANGE_TYPE.RESET_TOUGH_PARAM
end

function M:_update_buff_list(msg)
  if not self.v_ui_hp or not self.v_ui_hp:is_have_buff_list_obj() then
    return
  end
  if msg.mm_obj and msg.mm_obj.is_visible then
    local target = msg.mm_x
    if not target or target:is_destroy() then
      return
    end
    if self.uuid == target.uuid then
      self:update_buff_list()
    end
  end
end

function M:_remove_buff(msg)
  if not self.v_ui_hp or not self.v_ui_hp:is_have_buff_list_obj() then
    return
  end
  if msg.mm_obj and msg.mm_obj.is_visible then
    local target = msg.mm_x
    if not target or target:is_destroy() then
      return
    end
    if self.uuid == target.uuid then
      self.v_buff_item[msg.mm_obj.uuid] = nil
      self:update_buff_list()
    end
  end
end

function M:update_buff_duration()
  for uuid, item_info in pairs(self.v_buff_item) do
    item_info.item.fill.fillAmount = item_info.magic.remain_duration / item_info.magic.duration
  end
end

function M:update_buff_list()
  local list = self.magic_mgr:get_visible_magic_list()
  self.v_ui_hp:hide_all_buff_obj()
  local index = 1
  for rtid, magic_cfg in pairs(list) do
    local magic_map = self.magic_mgr:get_magic_map_by_magic_id(magic_cfg.Id)
    for key, magic in pairs(magic_map) do
      local item = self.v_ui_hp:get_buff_obj(index)
      item.text.text = magic.magic_level
      item.text.gameObject:SetActive(magic.magic_level > 1)
      if magic.duration > 0 and magic.left_duration > 0 then
        item.fill.fillAmount = magic.left_duration / magic.duration
        item.fill:SetActive(true)
      else
        item.fill:SetActive(false)
      end
      ResMgr:load_set_icon(item.img, magic_cfg.Icon)
      item.obj:SetActive(true)
      self.v_buff_item[rtid] = {
        item = item,
        magic = magic,
        target = self
      }
      index = index + 1
    end
  end
end

function M:enable_shadow(param)
  local obj = self.v_simple_shadow
  self.v_shadow_enabled = param
  if obj and not obj:IsNull() then
    obj:SetActive(param or false)
  end
end

function M:update()
  Base.update(self)
  if self:is_destroy() or self:is_die() then
    return
  end
  if self:is_real_finish_init() then
    self:update_attch_point_move()
  end
  local shadow = self.v_simple_shadow
  if shadow and not shadow:IsNull() then
    local x, _, z = self.v_simple_shadow_transform:GetPositionA()
    self.v_simple_shadow_transform:SetPositionA(x, self.v_land_height, z)
  end
  self:update_force_remove_timer()
end

function M:low_update()
  Base.low_update(self)
  if self.v_toughness_info then
    self:update_tough_timer()
  end
  if self:is_real_finish_init() then
    self.element_abnormal_mgr:low_update()
  end
  self:low_update_ui_hp()
end

function M:late_update()
  self.late_update_start = true
  Base.late_update(self)
  self:update_attach_lookat()
  self.late_update_start = false
end

function M:update_tough_timer()
  local info = self.v_toughness_info
  local dt = self.time_mgr:get_low_dt_time()
  local last_on_recover = info.on_recover
  if info.force_recover_on then
    info.force_recover_timer = info.force_recover_timer + dt
    local is_done
    if info.force_recover_timer < info.force_recover_time then
      info.on_recover = true
      if info.cur_lv_tough_val_limit > info.record_tough_change + info.cur_tough_value then
        local value = info.force_recover_speed * dt
        is_done = self:recover_tough(value)
      else
        is_done = true
      end
    else
      local value = info.force_recover_speed * dt
      self:recover_tough(value)
      is_done = true
    end
    if is_done then
      info.on_recover = false
      self:on_force_recover_done()
    end
  elseif 0 ~= info.force_recover_timer then
    info.force_recover_timer = 0
  end
  if info.out_fight_recover_on then
    info.out_fight_recover_timer = info.out_fight_recover_timer + dt
    if info.out_fight_recover_timer >= info.out_figh_recover_time then
      info.on_recover = true
      local value = info.out_figh_recover_speed * dt
      local is_done = self:recover_tough(value)
      if is_done then
        info.on_recover = false
        info.out_fight_recover_on = false
        info.out_fight_recover_timer = 0
      end
    end
  elseif 0 ~= info.out_fight_recover_timer then
    info.out_fight_recover_timer = 0
  end
  if last_on_recover ~= info.on_recover then
    local msg = MsgGame:mq_publish2(Const.MSG_TOUGHNESS_CHANGE)
    msg.mm_x = self.uuid
    msg.mm_y = Config.TOUGH_CHANGE_TYPE.TOUGH_RECOVER_START
  end
end

function M:get_camp()
  assert(self.camp, "camp not inited")
  return self.camp
end

local ENEMY = Config.CAMPS.ENEMY

function M:is_monster()
  return self.camp == ENEMY
end

function M:is_monster_with_kind()
  if not self.character_cfg or not self.character_cfg.Kind then
    return
  end
  local is_monster = false
  if self.character_cfg.Kind == CommDefine.NPC_KIND.MONSTER or self.character_cfg.Kind == CommDefine.NPC_KIND.ELITE or self.character_cfg.Kind == CommDefine.NPC_KIND.BOSS then
    is_monster = true
  end
  return is_monster
end

function M:is_com_monster()
  return CommDefine.MONSTER_TYPE[self.character_cfg.Kind]
end

function M:set_camp(camp)
  if camp then
    self.camp = camp
  end
end

function M:set_params(params)
  if not params or "" == params then
    return nil
  end
  local tb = {}
  string.gsub(params, "[^,^|]+", function(p)
    local number = tonumber(p)
    table.insert(tb, nil == number and p or number)
  end)
  self.v_params = tb
end

function M:set_auto_level(auto_level)
  self.v_auto_level = auto_level
end

function M:get_params()
  return self.v_params
end

function M:is_npc()
  return true
end

function M:set_group_id(group_id)
  self.v_group_id = group_id
end

function M:get_group_id()
  return self.v_group_id
end

function M:get_base_attrs()
  local monster_base_attr = ShareRes.create("monster.monster_base_attr")
  local monster_upgrade_attr = ShareRes.create("monster.monster_upgrade_attr")
  local id = self.character_cfg.AttribId
  local attrs = FightDefine.get_monster_attrs(id, self.v_level, monster_base_attr, monster_upgrade_attr)
  attrs[ATTR_TYPE.CHAR_SP_MAX].FIXED = self.character_cfg.powerMax
  if self.v_cur_hp then
    attrs[ATTR_TYPE.CHAR_HP].FIXED = self.v_cur_hp
  end
  return attrs
end

function M:enable_rim(enable)
  self.char_renderers:enable_effect(Config.CHAR_EFFECT.RIM, true == enable)
end

function M:create_ball_on_dead()
  local ball_count_list = self.v_dead_ball_count or self.character_cfg.CreateBallAfterDead
  if ball_count_list then
    if Util.is_more_than_zero(ball_count_list[1]) then
      NextFrameMgr:add(self.create_flyer, self, ball_count_list[1], Config.SAMLL_ENERGY_BALL_MAGIC_LEVEL)
    end
    if Util.is_more_than_zero(ball_count_list[2]) then
      NextFrameMgr:add(self.create_flyer, self, ball_count_list[2], Config.BIG_ENERGY_BALL_MAGIC_LEVEL)
    end
  end
end

function M:on_dead(...)
  Base.on_dead(self, ...)
  self:release_hp_item()
end

function M:set_dead(dead_action, action_remove, dead_cb)
  self:play_dead_effect()
  self:create_ball_on_dead()
  self.v_is_set_dead = true
  if TowerMgr and self.v_event_key then
    TowerMgr:remove_end_action_map(self.uuid, self.v_event_key, false)
  end
  if self.element_abnormal_mgr then
    self.element_abnormal_mgr:stop_all()
    self.element_abnormal_mgr:on_role_dead()
  end
  Base.set_dead(self, dead_action, action_remove, dead_cb)
end

function M:on_destroy_gameobj()
  if self.v_simple_shadow and not self.v_simple_shadow:IsNull() then
    ResPoolMgr:release(self.v_simple_shadow)
  end
  self.v_simple_shadow_go = nil
  self.v_simple_shadow = nil
  self.v_simple_shadow_transform = nil
  self:clear_attach_point_move_info()
  Base.on_destroy_gameobj(self)
end

function M:on_destroy()
  Base.on_destroy(self)
  self.v_toughness_info = nil
  self:clear_follower_list()
  self:remove_elite_hp_bar()
  self.v_force_remove_timer = nil
  self.v_last_lv_down_count = nil
  if TowerMgr and self.v_event_key then
    TowerMgr:remove_end_action_map(self.uuid, self.v_event_key, true)
  end
  self:release_hp_item()
end

function M:on_release()
  self.v_is_destroy = true
  self.v_is_pre_destroy = false
  self.is_load_behavior = false
  if self.v_behavior then
    BehaviorMgr:remove(self.v_behavior.file_id, self)
    self.v_behavior = nil
  end
  self:set_pos(0, 0, 0)
  self:set_enable(false)
  self.v_toughness_info = nil
  self:release_hp_item()
  self:clear_follower_list()
  self:clear_joint()
  self:clear_transparent()
  if Global.sound_mgr then
    Global.sound_mgr:clear_sound_obj(self)
  end
  if self.act_effect_ctrl then
    self.act_effect_ctrl:stop_all()
  end
  if self.is_in_puppet_mode then
    self:disable_grab_mode()
  end
  self:set_target()
  if self.v_cid2part_info then
    for cid, _ in pairs(self.v_cid2part_info) do
      SceneMgr:remove_client_obj(cid)
    end
    self.v_cid2part_info = nil
  end
  self:clear_dynamic_bone_shake_list()
  self:clear_attached_colliders()
  Util.unbind_all_msg(self)
  local _, show_elite_bar = Util.check_show_hp_bar_type(self.v_hp_bar_type)
  if show_elite_bar then
    self:remove_elite_hp_bar()
  end
  BehaviorMgr:call_event_fun("on_destroy_obj", self)
  self.v_force_remove_timer = nil
end

function M:create_elite_hp_bar()
  local fight = UIMgr:try_get_visible_ui("fight")
  if fight then
    local enemy_bar = fight:get_panel("enemy_bar")
    enemy_bar:create_elite_hp_bar(self)
    self.v_create_fixed_frame111111 = true
  end
end

function M:remove_elite_hp_bar()
  local fight = UIMgr:try_get_visible_ui("fight")
  if fight then
    local enemy_bar = fight:get_panel("enemy_bar")
    enemy_bar:remove_elite_hp_bar(self)
  end
end

function M:on_pool_init_npc()
  for _, comp in pairs(self.components) do
    comp:_init(self)
  end
  self:refresh_enable()
  self:on_init_gameobj()
  for cb, _ in pairs(self.v_loaded_cb) do
    cb()
  end
  UtilTable.clear_map(self.v_loaded_cb)
  self:born_ok()
  self:bind_events()
  if not self.v_ui_hp and self:need_ui_hp() then
    self:create_ui_hp()
  end
end

function M:born_ok()
  Base.born_ok(self)
  self:setup_born_behavior()
  if (not self.v_simple_shadow or self.v_simple_shadow:IsNull()) and self:need_simple_shadow() then
    ResPoolMgr:get_spell_effect_async(SHADOW_PATH, self, function(go)
      self.v_simple_shadow = go
      self:init_simple_shadow()
    end)
  end
  self:init_simple_shadow()
end

function M:_on_load_file_finish(behavior)
  Base._on_load_file_finish(self, behavior)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_BORN, self)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_NPC_BIRTH)
  msg.mm_obj = self
end

function M:became_part(role, attach_point_name, part_id)
  if self.v_part_id then
    return
  end
  local attach_point = role:get_setting_point(attach_point_name) or role.transform
  if part_id then
    role:set_npc_on_part(self.uuid, part_id)
    local part_info = role:get_part_info_by_id(part_id)
    if part_info then
      self.v_part_type = part_info.part_type
      SceneMgr:add_client_obj(part_info.cid, self)
    end
  end
  self:set_parent_tans(attach_point, false)
  self:set_mesh_enable(false)
  local collider = self:get_collider()
  if collider then
    collider.enabled = false
  end
  self.v_part_id = part_id
  self.v_main_npc_uuid = role.uuid
  self.transform:SetLocalPositionA(0, 0, 0)
end

function M:set_hp_visible(is_visible)
  self:set_big_hp_visible(is_visible)
  self:set_elite_hp_visible(is_visible)
  self:set_small_hp_visible(is_visible)
end

function M:get_hp_visible()
  return self.v_hp_visible
end

function M:set_small_hp_visible(is_visible)
  if self.v_ui_hp then
    self.v_ui_hp:set_visible(is_visible)
  end
  self.v_hp_visible = is_visible
end

function M:set_big_hp_visible(is_visible)
  local fight = UIMgr:try_get_ui("fight")
  if fight then
    local enemy_bar = fight:get_panel("enemy_bar")
    enemy_bar:set_big_enemy_item_visible(self.uuid, is_visible)
  end
end

function M:set_elite_hp_visible(is_visible)
  local fight = UIMgr:try_get_ui("fight")
  if fight then
    local hp = self.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_HP)
    local enemy_bar = fight:get_panel("enemy_bar")
    if hp > 0 then
      enemy_bar:set_elite_enemy_item_visible(self.uuid, is_visible)
    end
  end
end

function M:update_part_hp_val(attr)
  if not self.v_ui_hp then
    return
  end
  self.v_ui_hp:update_part_hp_val(attr)
end

function M:update_hp_val()
  self:update_part_npc_hp_val()
  if not self.v_ui_hp then
    return
  end
  self.v_ui_hp:update_hp_val()
end

function M:update_part_npc_hp_val()
  if self.v_part_id_map then
    local part_uuid
    for _, part_info in pairs(self.v_part_id_map) do
      part_uuid = part_info.part_uuid
      if part_uuid then
        local part_npc = SceneMgr:get_npc_by_id(part_uuid)
        if not Util.is_destroy(part_npc) then
          part_npc:update_part_hp_val(part_info.attrs)
        end
      end
    end
  end
end

function M:low_update_ui_hp()
  if self.v_ui_hp then
    local ct_info = Cinemachine:get_ct_info()
    if ct_info then
      self.v_ui_hp:set_visible(false)
      return
    end
    self.v_ui_hp:set_visible(self.v_hp_visible)
    if self.v_hp_visible then
      self.v_ui_hp:low_update()
    end
    if self.v_ui_hp:is_have_buff_list_obj() then
      self:update_buff_duration()
    end
    if self.v_toughness_info and self.v_toughness_info.on_recover and self.v_ui_hp:is_have_enery_obj() then
      self.v_ui_hp:update_tough_bar()
    end
  end
end

function M:on_collide_wall(dx, dz)
  if self.state_manager:is_in_state(STATE_NAME.behitfly) then
    local state = self.state_manager:get_cur_state(STATE_NAME.behitfly)
    if not state.can_hit_wall then
      return
    end
    state.can_hit_wall = false
    local missile_config = state:get_missile_cfg()
    local hit_wall_id = missile_config.HitWallId
    if not hit_wall_id or -1 == hit_wall_id then
      return
    end
    local caster = state.hitfly_caster
    local hit_wall_cfg = ShareRes.create("hitfly.hitfly_missileand_magic", hit_wall_id)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_BEATTACK_COLLIDER, self, Global.hero, nil, hit_wall_cfg)
    local dir_pos = Vec2.Normalize(Vec2.New(dx, dz)) * self.radius
    local cur_pos = self.v_position
    local target_pos = Vec3.New(cur_pos.x + dir_pos.x, cur_pos.y + self.v_collider_offset.y, cur_pos.z + dir_pos.y)
    local effect_name = ShareRes.get_comm_string_value("HitWallFx")
    SceneMgr:get_scene_effect_mgr():create_effect(effect_name, target_pos)
    if not hit_wall_cfg then
      return
    end
    local missiles = hit_wall_cfg.HitWallMissileList
    if missiles then
      for _, missile_id in pairs(missiles) do
        SceneMgr:create_missile(caster, nil, missile_id, self, nil, 1, math.floor(missile_id / 100), target_pos, target_pos)
      end
    end
    local magics = hit_wall_cfg.HitWallMagicList
    if magics then
      for _, magic_id in pairs(magics) do
        self.magic_mgr:add_magic(caster, magic_id)
      end
    end
  end
end

function M:on_collide_npc()
  if not self.v_collided_npc then
    return
  end
  if self.state_manager:is_in_state(STATE_NAME.behitfly) then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_BEATTACK_COLLIDER, self, Global.hero, self.v_collided_npc)
  end
end

function M:lookat_by_npc_attach(npc, attach_name, target_pos, max_x, min_x, max_z, min_z)
  local attach_point = self:get_setting_point(attach_name)
  if not attach_point then
    self.v_is_attach_lookat = false
    return
  end
  self.v_is_attach_lookat = true
  self.v_attach_lookat_data = {
    attach_point = attach_point,
    target_pos = target_pos,
    max_x = max_x,
    min_x = min_x,
    max_z = max_z,
    min_z = min_z
  }
end

function M:close_npc_attach_lookat()
  self.v_is_attach_lookat = false
  local attach_point = self.v_attach_lookat_data.attach_point
  if not attach_point then
    return
  end
end

function M:update_lookat_pos(target_pos)
  if not self.v_is_attach_lookat then
    return
  end
  self.v_attach_lookat_data.target_pos = target_pos
end

function M:update_attach_lookat()
  if not self.v_attach_lookat_data then
    return
  end
  local attach_point = self.v_attach_lookat_data.attach_point
  if not attach_point then
    return
  end
  local cur_euler_x, cur_euler_y, cur_euler_z = attach_point:GetEulerAnglesA3()
  if not self.v_is_attach_lookat then
    self.v_cur_euler_x, self.v_cur_euler_y, self.v_cur_euler_z = cur_euler_x, cur_euler_y, cur_euler_z
    return
  end
  local x, y, z = attach_point:GetPositionA()
  local target_pos = self.v_attach_lookat_data.target_pos
  if UNITY_EDITOR and Global.debug then
    CSDebug.DrawLine(Vec3.New(x, y, z), target_pos, Color.red, 0.3)
  end
  local degz = atan(target_pos.y - y, Math.dist_vec2A(x, z, target_pos.x, target_pos.z)) * deg_val
  local degx = Math.get_lookat_dir(target_pos.x, target_pos.z, x, z)
  degx = degx + 90
  degz = degz + 90
  degx = _clamp(degx, self.v_attach_lookat_data.min_x, self.v_attach_lookat_data.max_x)
  degz = _clamp(degz, self.v_attach_lookat_data.min_z, self.v_attach_lookat_data.max_z)
  if not self.v_cur_euler_x then
    self.v_cur_euler_x, self.v_cur_euler_y, self.v_cur_euler_z = Vec3.LerpC(cur_euler_x, cur_euler_y, cur_euler_z, degx, cur_euler_y, degz, lerp_val)
  end
  attach_point:SetEuler(self.v_cur_euler_x, self.v_cur_euler_y, self.v_cur_euler_z)
end

function M:get_main_part()
  return self.v_main_npc_uuid
end

function M:get_part_id()
  return self.v_part_id
end

function M:became_follower(leader)
  leader:set_npc_on_follower(self)
  self.v_leader_uuid = leader.uuid
end

function M:set_npc_on_follower(follower)
  if not follower or follower:is_destroy() then
    return
  end
  self.v_follower_list = self.v_follower_list or {}
  local uuid = follower.uuid
  self.v_follower_list[uuid] = follower
end

function M:clear_follower_list()
  self.v_follower_list = nil
end

function M:get_leader()
  return self.v_leader_uuid
end

function M:get_follower_list()
  return self.v_follower_list
end

function M:play_behit_effect(hit_type, damage_type, attacker_dir)
  if self:is_monster() then
    local is_have_damage_type = false
    for key, type in pairs(DAMAGE_TYPE) do
      if damage_type == type then
        is_have_damage_type = true
        break
      end
    end
    if not is_have_damage_type then
      return
    end
    local hit_pos_name = self.character_cfg.HitPos
    local hit_effect_list = self.character_cfg.HitEffect
    if hit_effect_list then
      local point_trans = Util.is_empty(hit_pos_name) and self.transform or self:get_setting_point(hit_pos_name)
      if point_trans then
        local index = (HIT_EFFECT_TABLE[hit_type] or 1) + (HIT_TYPE_ADDEND[damage_type] or 0) * 3
        self:_play_effect(hit_effect_list[index], hit_type, point_trans, attacker_dir)
      end
    end
  end
end

function M:_play_effect(effect_data, hit_type, point_trans, attacker_dir)
  effect_data = effect_data or self.character_cfg.HitEffect[1]
  local effect_name = effect_data[1]
  local effect_param = self.act_effect_ctrl.create_effect_param()
  effect_param.prefab_name = effect_name
  effect_param.parent = point_trans
  effect_param.time_scale = 1
  effect_param.not_time_scale = true
  effect_param.dir = attacker_dir + (effect_data[2] or 0)
  self.act_effect_ctrl:play_effect(effect_param)
end

function M:cache_behit_dir(missile)
  local collider = missile:get_collider_component()
  local missile_pos = missile:get_pos_vec3()
  local behit_pos = self:get_pos_vec3()
  local collide_pos = collider:ClosestPoint(missile_pos)
  local dir_x = behit_pos.x - collide_pos.x
  local dir_z = behit_pos.z - collide_pos.z
  local angle = Math.get_angle2A(dir_x, dir_z)
  local quat_euler = Quat.Euler(0, angle, 0)
  local quat_x = quat_euler.x
  local quat_y = quat_euler.y
  local quat_z = quat_euler.z
  local quat_w = quat_euler.w
  quat_euler:Set(quat_x, -quat_y, -quat_z, quat_w)
  local result_angle = quat_euler:ToEulerAngles()
  local result_y = (result_angle.y + 270) % 360
  local normal_angle = self:cal_dead_dir()
  if normal_angle then
    if result_y >= normal_angle - 60 and result_y <= normal_angle + 60 then
      self.v_behit_angle = result_y
    else
      self.v_behit_angle = normal_angle
    end
  end
end

function M:play_dead_effect()
  if self:is_monster() then
    local dead_effect = self.character_cfg.DeadEffect
    local dead_dir_type = self.character_cfg.DeadEffectRotation
    if dead_effect and next(dead_effect) and dead_dir_type then
      local point_trans = self:get_setting_point("Bip001 Chest")
      if not Util.is_nil(point_trans) then
        local point_pos = Vec3.New(point_trans:GetPositionA())
        local dead_effect_name = dead_effect[1]
        local dir = self.gameobj.transform:GetEulerY()
        if dead_dir_type == DEAD_ROTATION_TYPE.BEHIT_DIR then
          dir = self:cal_dead_dir()
        end
        local effect_mgr = SceneMgr:get_scene_effect_mgr()
        effect_mgr:create_effect(dead_effect_name, point_pos, nil, nil, nil, nil, dir)
      else
        Log.Error("获取挂点Bip001 Chest失败，将不播放死亡特效, NpcId：", self.character_cfg.NpcId)
      end
    end
  end
end

function M:cal_dead_dir()
  local hero = Global.hero
  if hero then
    local npc_pos = self:get_pos_vec3()
    local hero_pos = hero:get_pos_vec3()
    local dir_x = npc_pos.x - hero_pos.x
    local dir_z = npc_pos.z - hero_pos.z
    local angle = Math.get_angle2A(dir_x, dir_z)
    local quat_euler = Quat.Euler(0, angle, 0)
    local quat_x = quat_euler.x
    local quat_y = quat_euler.y
    local quat_z = quat_euler.z
    local quat_w = quat_euler.w
    quat_euler:Set(quat_x, -quat_y, -quat_z, quat_w)
    local result_angle = quat_euler:ToEulerAngles()
    local dead_effect_dir = (result_angle.y + 270) % 360
    return dead_effect_dir
  end
end

function M:set_effect_bar_length(length)
  if not self.v_ui_hp then
    return
  end
  self.v_ui_hp:set_effect_bar_length(length)
end

function M:set_effect_bar_show(is_show)
  if not self.v_ui_hp then
    return
  end
  self.v_ui_hp:set_effect_bar_show(is_show)
end

function M:is_have_effect_bar()
  if not self.v_ui_hp then
    return false
  end
  return self.v_ui_hp:is_have_effect_bar()
end

function M:set_last_hurt_info(attacker, total_hurt)
  Base.set_last_hurt_info(self, attacker, total_hurt)
  self:on_out_fight()
end

function M:is_have_tough()
  return self.v_toughness_info ~= nil
end

function M:recover_tough(value)
  local info = self.v_toughness_info
  local cur_level = info.cur_tough_level
  local tough_val_limit = info.cur_lv_tough_val_limit
  local recover_max_lv = info.can_recover_tough_max_lv
  local has_change_level = false
  info.cur_tough_value = info.cur_tough_value + value
  for index = 1, #info.lv_up_values do
    if info.lv_up_values[index] <= info.cur_tough_value and index > cur_level and (not recover_max_lv or index <= recover_max_lv) then
      info.cur_tough_level = index
      has_change_level = true
    end
  end
  if has_change_level then
    local msg = MsgGame:mq_publish2(Const.MSG_TOUGHNESS_CHANGE)
    msg.mm_x = self.uuid
    msg.mm_y = Config.TOUGH_CHANGE_TYPE.TOUGH_LV_UP
    msg.mm_obj = info.cur_tough_level
    self:update_tough_break_magic(self.v_toughness_info.cur_tough_level)
  end
  local is_done = false
  if tough_val_limit <= info.cur_tough_value then
    info.cur_tough_value = tough_val_limit
    is_done = true
    self:_on_tough_recovered()
  end
  return is_done
end

function M:reset_toughness_info(reset_lv, reset_timer)
  local info = self.v_toughness_info
  info.max_tough_level = #self.v_toughness_cfg_dict
  reset_lv = reset_lv or info.can_recover_tough_max_lv or info.max_tough_level
  info.cur_lv_tough_val_limit = info.lv_down_values[reset_lv] or info.max_tough_value
  info.force_recover_time = info.force_recover_time or self.character_cfg.ForceRecoverToughTime
  info.force_recover_speed = info.force_recover_speed or info.max_tough_value / info.force_recover_time
  info.out_figh_recover_time = self.character_cfg.OutFightRecoverToughTime
  info.out_figh_recover_speed = self.character_cfg.OutFightRecoverToughSpeed
  info.record_tough_change = info.record_tough_change or 0
  info.cur_tough_level = reset_lv
  info.cur_tough_value = info.cur_lv_tough_val_limit
  if reset_timer then
    info.force_recover_on = false
    info.force_recover_timer = 0
    info.record_tough_change = 0
    info.out_fight_recover_on = false
    info.out_fight_recover_timer = 0
  end
end

function M:change_tough_value(value)
  if not self.v_toughness_info then
    return
  end
  local info = self.v_toughness_info
  local force_recover_on = info.force_recover_on
  if force_recover_on then
    return
  end
  local cur_value = info.cur_tough_value
  local before_level = info.cur_tough_level
  local after_level = info.cur_tough_level
  local lv_down_values = info.lv_down_values
  local after_value = math.max(cur_value - value, 0)
  if not force_recover_on and lv_down_values[before_level - 1] then
    local fix_value
    if after_value <= lv_down_values[after_level - 1] then
      fix_value = lv_down_values[after_level - 1]
      after_level = math.max(after_level - 1, 1)
      if after_level <= 1 and fix_value <= 0 then
        after_level = 0
        self:_on_tough_level_become_lowest()
      end
    end
    after_value = fix_value or after_value
  end
  local send_camp, send_after_level
  if after_level ~= before_level or after_level <= 1 and after_value <= 0 then
    local enter_stun = self:_on_change_tough_level(before_level, after_level, after_value)
    send_camp, send_after_level = self:get_camp(), after_level
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_TOUGHNESS_CHANGE, self, send_camp, send_after_level, enter_stun)
  end
  info.cur_tough_level = after_level
  info.cur_tough_value = after_value
  local msg = MsgGame:mq_publish2(Const.MSG_TOUGHNESS_CHANGE)
  msg.mm_x = self.uuid
  msg.mm_y = Config.TOUGH_CHANGE_TYPE.TOUGH_VALUE_CHANGE
  if after_level ~= before_level then
    msg = MsgGame:mq_publish2(Const.MSG_TOUGHNESS_CHANGE)
    msg.mm_x = self.uuid
    msg.mm_y = Config.TOUGH_CHANGE_TYPE.TOUGH_LV_DOWN
    msg.mm_obj = before_level
  end
  return send_camp, send_after_level
end

function M:_on_tough_level_become_lowest()
  if self.v_toughness_info then
    self.v_toughness_info.force_recover_on = true
    self.v_toughness_info.force_recover_timer = 0
    self.v_toughness_info.out_fight_recover_on = false
    self.v_toughness_info.out_fight_recover_timer = 0
    local msg = MsgGame:mq_publish2(Const.MSG_TOUGHNESS_CHANGE)
    msg.mm_x = self.uuid
    msg.mm_y = Config.TOUGH_CHANGE_TYPE.TOUGH_CLEAR
  end
end

function M:on_force_recover_done()
  self.v_toughness_info.force_recover_on = false
  self.v_toughness_info.force_recover_timer = 0
  self.v_toughness_info.record_tough_change = 0
  self:on_out_fight()
  local msg = MsgGame:mq_publish2(Const.MSG_TOUGHNESS_CHANGE)
  msg.mm_x = self.uuid
  msg.mm_y = Config.TOUGH_CHANGE_TYPE.TOUGH_RECOVER_DONE
end

function M:on_out_fight()
  if self.v_toughness_info and not self.v_toughness_info.force_recover_on then
    self.v_toughness_info.out_fight_recover_on = true
    self.v_toughness_info.out_fight_recover_timer = 0
  end
end

function M:_on_tough_recovered()
  self:clear_tough_break_magic()
end

function M:_on_change_tough_level(before_lv, after_lv, after_value)
  local is_lowest = after_lv <= 0
  local enter_stun = self:enter_stun_state(before_lv, is_lowest)
  local start_index = 1
  local big_flyer_count, small_flyer_count = 0
  if before_lv ~= after_lv then
    start_index = after_lv + 1
  elseif before_lv == after_lv and 1 == after_lv then
    start_index = after_lv
  end
  for index = start_index, before_lv do
    local cfg = self.v_toughness_cfg_dict[index]
    if cfg then
      small_flyer_count = cfg[TOUGH_CONFIG_INDEX.FLYER_COUNT1] or 0 + small_flyer_count
      big_flyer_count = cfg[TOUGH_CONFIG_INDEX.FLYER_COUNT2] or 0 + big_flyer_count
    end
  end
  if small_flyer_count and small_flyer_count > 0 then
    NextFrameMgr:add(self.create_flyer, self, small_flyer_count, Config.SAMLL_ENERGY_BALL_MAGIC_LEVEL)
  end
  if big_flyer_count and big_flyer_count > 0 then
    NextFrameMgr:add(self.create_flyer, self, big_flyer_count, Config.BIG_ENERGY_BALL_MAGIC_LEVEL)
  end
  self:update_tough_break_magic(after_lv)
  return enter_stun
end

function M:update_tough_break_magic(after_lv)
  local lv_down_count = self.v_toughness_info.max_tough_level - after_lv
  local force_recover_on = self.v_toughness_info.force_recover_on
  if force_recover_on then
    lv_down_count = self.v_toughness_info.max_tough_level
  end
  if self.v_kind ~= CommDefine.NPC_KIND.BOSS and self.v_kind ~= CommDefine.NPC_KIND.ELITE then
    self.v_last_lv_down_count = lv_down_count
    return
  end
  local break_magics = self.v_kind == CommDefine.NPC_KIND.BOSS and BOSS_BREAK_MAGIC or ELITE_BREAK_MAGIC
  local last_lv_down_count = self.v_last_lv_down_count
  if last_lv_down_count ~= lv_down_count then
    local remove_magic = break_magics[last_lv_down_count]
    if remove_magic then
      if Util.is_table(remove_magic) then
        for _, magic_id in pairs(remove_magic) do
          self.magic_mgr:remove_magic_by_id(magic_id)
        end
      elseif Util.is_number(remove_magic) then
        self.magic_mgr:remove_magic_by_id(remove_magic)
      end
    end
    local add_magic = break_magics[lv_down_count]
    if add_magic then
      if Util.is_table(add_magic) then
        for _, magic_id in pairs(add_magic) do
          self.magic_mgr:add_magic(self, magic_id)
        end
      elseif Util.is_number(add_magic) then
        self.magic_mgr:add_magic(self, add_magic)
      end
    end
  end
  self.v_last_lv_down_count = lv_down_count
end

function M:clear_tough_break_magic()
  local break_magic = self.v_kind == CommDefine.NPC_KIND.BOSS and BOSS_BREAK_MAGIC or ELITE_BREAK_MAGIC
  for _, remove_magic in pairs(break_magic) do
    if Util.is_table(remove_magic) then
      for _, magic_id in pairs(remove_magic) do
        self.magic_mgr:remove_magic_by_id(magic_id)
      end
    elseif Util.is_number(remove_magic) then
      self.magic_mgr:remove_magic_by_id(remove_magic)
    end
  end
  self.v_last_lv_down_count = nil
end

function M:create_flyer(flyer_count, magic_level)
  if self:is_destroy() then
    return
  end
  local scene_item_mgr = SceneMgr:get_scene_item_mgr()
  scene_item_mgr:create_energy_ball(flyer_count, Global.hero, self, magic_level)
end

function M:set_stun_animation_group_id(group_id)
  self.v_stun_animation_group_id = group_id
end

function M:get_stun_animation_group_id()
  return self.v_stun_animation_group_id
end

function M:enter_stun_state(before_lv, clear_tough)
  local cur_tough_lv_cfg = self.v_toughness_cfg_dict[before_lv]
  if not cur_tough_lv_cfg then
    Log.Error("enter_stun_state error, cur_tough_lv_cfg is nil", before_lv, self.id, debug.traceback())
    return
  end
  local can_stun = 1 == cur_tough_lv_cfg[TOUGH_CONFIG_INDEX.CAN_STUN]
  if not self.v_toughness_info or not can_stun and not clear_tough then
    return
  end
  local enter_stun = false
  self.skill_mgr:abort()
  
  local function enter_cb()
    local info = self.v_toughness_info
    local stun_time = clear_tough and info.force_recover_time or self.character_cfg.TimeOfStunState
    if stun_time >= 0 then
      self.state_manager:enter_stun(stun_time, false)
      enter_stun = true
    end
  end
  
  self:check_motion_config(Config.ACT_DEFINE.Stun, enter_cb)
  return enter_stun
end

function M:get_toughness_info()
  return self.v_toughness_info
end

function M:get_cur_tough_down_lv()
  return self.v_toughness_info.max_tough_level - self.v_toughness_info.cur_tough_level
end

function M:get_cur_tough_level()
  return self.v_toughness_info.cur_tough_level
end

function M:get_out_fight_recover_count_down()
  return self.v_toughness_info.out_figh_recover_time
end

function M:get_cur_touch_value()
  return self.v_toughness_info.cur_tough_value
end

function M:set_out_fight_recover_count_down(time)
  self.v_toughness_info.out_figh_recover_time = time
end

function M:set_can_recover_tough_max_lv(max_lv)
  if max_lv < 0 or max_lv > self.v_toughness_info.max_tough_level then
    Log.Error("恢复韧性最大等级小于0或大于最大韧性等级， 请检查配置")
    return
  elseif 0 == max_lv then
    self:reset_toughness_info(nil, false)
  end
  local info = self.v_toughness_info
  info.can_recover_tough_max_lv = max_lv
  info.cur_lv_tough_val_limit = info.lv_down_values[max_lv] or info.max_tough_value
end

function M:clear_can_recover_tough_max_lv(is_remove)
  local info = self.v_toughness_info
  self.v_toughness_info.can_recover_tough_max_lv = nil
  info.cur_lv_tough_val_limit = info.max_tough_value
  if is_remove then
    self:on_out_fight()
  end
end

function M:change_tough_lv(lv_count)
  local info = self.v_toughness_info
  local after_level = Math.Clamp(lv_count + info.cur_tough_level, 0, info.max_tough_level)
  local need_change_value = 0
  if after_level <= 0 then
    need_change_value = info.cur_tough_value
    self:change_tough_value(need_change_value)
  elseif after_level > info.cur_tough_level then
    need_change_value = info.lv_down_values[after_level] - info.cur_tough_value
    self:recover_tough(need_change_value)
  elseif after_level == info.cur_tough_level then
    self:recover_tough(info.lv_down_values[after_level])
  else
    for index = info.cur_tough_level - 1, after_level, -1 do
      need_change_value = need_change_value + self.v_toughness_cfg_dict[index][TOUGH_CONFIG_INDEX.MAX_VALUE]
    end
    self:change_tough_value(need_change_value)
  end
end

function M:set_cur_tough_lv(lv)
  if lv <= 0 or lv > self.v_toughness_info.max_tough_level then
    Log.Error("预设韧性等级小等于0或大于最大韧性等级， 请检查配置")
    return
  end
  self:reset_toughness_info(lv, false)
end

function M:reset_toughness_param(param)
  self:init_toughness_info(param)
end

function M:set_tough_force_recover_time(force_recover_time)
  local info = self.v_toughness_info
  info.force_recover_time = force_recover_time
  info.force_recover_speed = info.max_tough_value / info.force_recover_time
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

function M:set_dead_ball_count(count)
  if not self.v_dead_ball_count then
    self.v_dead_ball_count = {count, 0}
  end
end

function M:need_ui_hp()
  local hp_bar_type = self:get_hp_bar_type()
  local show_ui_hp = Util.check_show_hp_bar_type(hp_bar_type)
  return show_ui_hp
end

function M:need_simple_shadow()
  local shadow_quality = BattleSettingMgr:get_shadow_quality()
  return shadow_quality > QualityShadow.CLOSE and self.v_shadow_enabled
end

function M:get_ai_group()
  return self.v_ai_group
end

function M:get_ai_group_id()
  return self.v_ai_group_id
end

function M:set_ai_group(id)
  self.v_ai_group = id
end

function M:set_ai_group_id(id)
  self.v_ai_group_id = id
end

function M:get_difficulty_tag()
  return self.v_difficulty_tag
end

function M:set_difficulty_tag(difficulty_tag)
  self.v_difficulty_tag = difficulty_tag
end

function M:add_force_remove_timer()
  if not Util.is_more_than_zero(self.character_cfg.ForceRemoveTime) or self.character_cfg.Kind ~= NPC_KIND.MONSTER and self.character_cfg.Kind ~= NPC_KIND.ELITE and self.character_cfg.Kind ~= NPC_KIND.BOSS then
    return
  end
  self.v_force_remove_timer = self.character_cfg.ForceRemoveTime
end

function M:update_force_remove_timer()
  if not self.v_force_remove_timer then
    return
  end
  if self:is_destroy() then
    self.v_force_remove_timer = nil
    return
  end
  self.v_force_remove_timer = self.v_force_remove_timer - GlobalTimeMgr:get_dt_time()
  if self.v_force_remove_timer <= 0 then
    self.v_force_remove_timer = nil
    local character_cfg = self.character_cfg
    local behitfly = self.state_manager:get_behitfly_state()
    local cur_action = self.act_ctrl:get_cur_action()
    local info = self.v_behavior.dead_remove_timeout_output and self.v_behavior:dead_remove_timeout_output()
    local str = string.format("血量为0已超过%s秒，强制将未死亡怪物设置死亡并移除npc, uuid:%s, npcid:%s\n 是否调用set_npc_dead:%s \n 是否击飞后死亡:%s \n 是否有未启用的死亡回调:%s\n 是否处于击飞状态机: %s\n 状态机当前动画:%s\n 实际动画:%s\n 策划脚本打印信息：%s", character_cfg.ForceRemoveTime, self.uuid, character_cfg.NpcId, self.v_is_set_dead, self.v_is_after_behitfly_die, behitfly:check_have_die_callback(), behitfly.in_state, behitfly.v_action, cur_action, info)
    Log.Error(str)
    if GAME_RELEASE then
      self:set_dead()
      SceneMgr:remove_npc2(self)
    end
  end
end

function M:set_end_action(is_end_action)
  if self.v_event_key and is_end_action and TowerMgr then
    TowerMgr:add_end_action_map(self.uuid, self.v_is_max_wave, self.v_event_key)
  end
  self.v_is_end_action = is_end_action
end

function M:is_end_action()
  return self.v_is_end_action
end

function M:set_max_wave(is_max_wave)
  self.v_is_max_wave = is_max_wave
end

function M:is_max_wave()
  return self.v_is_max_wave
end

function M:set_event_key(event_key)
  self.v_event_key = event_key
end

function M:init_simple_shadow()
  local r = self.v_body_radius or 1
  if not Util.is_nil(self.v_simple_shadow) then
    self.v_simple_shadow_transform = self.v_simple_shadow.transform
    self.v_simple_shadow_transform:SetParent(self.transform, false)
    self.v_simple_shadow:SetActive(self.v_shadow_enabled)
    self.v_simple_shadow_transform:SetLocalScaleA(r, 1, r)
  end
end

function M:set_hp_bar_type(bar_type)
  if self.v_hp_bar_type ~= bar_type then
    self.v_hp_bar_type = bar_type
    local show_ui_hp, show_elite_bar = Util.check_show_hp_bar_type(bar_type)
    if show_ui_hp then
      if not self.v_ui_hp then
        self:create_ui_hp()
      end
    elseif self.v_ui_hp then
      self:release_hp_item()
    end
    if show_elite_bar then
      self:create_elite_hp_bar()
    else
      self:remove_elite_hp_bar()
    end
  end
end

function M:get_hp_bar_type()
  return self.v_hp_bar_type
end

function M:change_attach_point_parent(attach_point, parent_attach_point, move_time)
  local target_transform = self:get_setting_point(attach_point)
  if not target_transform then
    Log.Error("change_attach_point_parent error   can not find target point", attach_point, debug.traceback())
    return
  end
  self.v_attach_init_parent_map = self.v_attach_init_parent_map or {}
  if not self.v_attach_init_parent_map[attach_point] then
    self.v_attach_init_parent_map[attach_point] = target_transform.parent
  end
  if not Util.is_empty(parent_attach_point) then
    local parent_transform = self:get_setting_point(parent_attach_point)
    if not parent_transform then
      Log.Error("change_attach_point_parent error   can not find target parent point", parent_attach_point, debug.traceback())
      return
    end
    if Util.is_more_than_zero(move_time) then
      self:put_in_attach_point_move_info_map(attach_point, parent_attach_point, move_time)
    else
      target_transform:SetParent(parent_transform)
      target_transform:ResetAttr()
    end
  else
    target_transform.transform:SetParent(nil, true)
  end
end

function M:put_in_attach_point_move_info_map(attach_point, parent_attach_point, move_time)
  self.v_attach_point_move_info_map = self.v_attach_point_move_info_map or {}
  if not self.v_attach_point_move_info_map[attach_point] then
    self.v_attach_point_move_info_map[attach_point] = {}
  end
  self.v_attach_point_move_info_map[attach_point].attach_point = attach_point
  self.v_attach_point_move_info_map[attach_point].parent_attach_point = parent_attach_point
  self.v_attach_point_move_info_map[attach_point].move_time = move_time
  self.v_attach_point_move_info_map[attach_point].elapsed_time = 0
end

function M:clear_attach_point_move_info()
  self.v_attach_point_move_info_map = nil
  if not self.v_attach_init_parent_map then
    return
  end
  for attach_point, parent in pairs(self.v_attach_init_parent_map) do
    if not Util.is_nil(parent) then
      local target_transform = self:get_setting_point(attach_point)
      target_transform:SetParent(parent)
    end
  end
  self.v_attach_init_parent_map = nil
end

function M:update_attch_point_move()
  if self:is_destroy() then
    return
  end
  if not self.v_attach_point_move_info_map then
    return
  end
  local dt = self.time_mgr:get_dt_time()
  local sx, sy, sz, ex, ey, ez, dx, dy, dz, remain_time, move_time, attach_point, parent_attach_point, target_transform, parent_transform
  for key, move_info in pairs(self.v_attach_point_move_info_map) do
    move_time = move_info.move_time
    move_info.elapsed_time = math.min(move_info.elapsed_time + dt, move_info.move_time)
    remain_time = move_time - move_info.elapsed_time
    attach_point = move_info.attach_point
    parent_attach_point = move_info.parent_attach_point
    target_transform = self:get_setting_point(attach_point)
    parent_transform = self:get_setting_point(parent_attach_point)
    sx, sy, sz = target_transform:GetPositionA()
    ex, ey, ez = parent_transform:GetPositionA()
    if remain_time > 0 then
      dx, dy, dz = (ex - sx) / remain_time * dt + sx, (ey - sy) / remain_time * dt + sy, (ez - sz) / remain_time * dt + sz
      target_transform:SetPositionA(dx, dy, dz)
    else
      target_transform:SetParent(parent_transform)
      target_transform:ResetAttr()
      self.v_attach_point_move_info_map[key] = nil
    end
  end
  if not next(self.v_attach_point_move_info_map) then
    self.v_attach_point_move_info_map = nil
  end
end

function M:get_part_type()
  return self.v_part_type
end

function M:get_tough_record_state()
  return self.v_toughness_info and self.v_toughness_info.force_recover_on
end

return M
