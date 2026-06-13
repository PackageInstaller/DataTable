local Math = require("base.mathx")
local Base = require("obj.char")
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local CommonDefine = require("cs_share.common_define")
local rad2Deg = require("base.mathx").Rad2Deg
local Magic = require("manager.magic.magic_event.magic_event")
local Time = require("manager.time.time")
local SceneObstacle = require("manager.scene.scene_obstacle")
local TypeUnityBoxCollider = typeof(UnityEngine.BoxCollider)
local TypeUnityCapsuleCollider = typeof(UnityEngine.CapsuleCollider)
local TypeUnitySphereCollider = typeof(UnityEngine.SphereCollider)
local TypeMeshCollider = typeof(UnityEngine.MeshCollider)
local TypeSkillArea = typeof(CS.SkillArea)
local TypeCharacterUtil = typeof(CS.Game.CharacterUtil)
local Layer = require("utils.layer")
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local BindLauncherMovement = require("manager.fight.movement.missile_bindlauncher")
local _rotate_vec2 = Math.rotate_vec2
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local FightDefine = require("cs_share.fight_define")
local ELEMENT_DAMAGE_TYPE = FightDefine.ELEMENT_DAMAGE_TYPE
local ATTR_TYPE = FightDefine.ATTR_TYPE
local DAMAGE_CALCU_USED_ATTRS = FightDefine.DAMAGE_CALCU_USED_ATTRS
local MagicDef = require("cs_share.magic_def")
local MAX_HIT_SOUND_COUNT = 3
local HUGE = math.huge
local _max = math.max
local _min = math.min
local _floor = math.floor
local _tinsert = table.insert
local deg = math.deg
local CSMathf = UnityEngine.Mathf
local M = Util.create_child_mt(Base)
local BE_HIT_CENTER = {
  MISSILE_OWNER = 1,
  MISSILE_CENTER = 2,
  MISSILE_DIR = 3
}
local EFFECT_TIME_SCALE_TYPE = {NONE = 0, EXCEPT = 1}
local MISSILE_TYPE = Config.MISSILE_TYPE
local MISSILE_SHAPE = Config.MISSILE_SHAPE
local MISSILE_TRACK_TYPE = {
  LINEAR = 1,
  ARCHIMEDES = 2,
  PARABOLA = 3,
  TRACK = 4,
  DIFFUSION = 5,
  MUILT_LINEAR = 6,
  SPACE_MOVE = 7,
  FOLLOW_TARGRT = 8,
  LINK_RAY = 9,
  RAYCAST = 10,
  TRAJECTORY = 11,
  BACK_ARCHIMEDES = 12,
  ON_CENTER = 13,
  ELECTRIC_JUMP = 14,
  CIRCLE = 15,
  CENTER_ROTATE = 16,
  TELESCOPIC = 17,
  BEZIER = 18
}
M.MISSILE_TRACK_TYPE = MISSILE_TRACK_TYPE
local MISSILE_BORN_POS_TYPE = Config.MISSILE_BORN_POS_TYPE
local MISSILE_BORN_DIR_TYPE = {
  LAUNCHER_DIR = 0,
  LAUNCHER2TARGET_DIR = 1,
  PARENT_DIR = 2,
  PARENT2TARGET_DIR = 3,
  BORN2TARGET_DIR = 4,
  ORIGIN2TARGET_DIR = 5
}
local COLLIDER_ANCHOR_TYPE = {MID = 0, START = 1}
local MISSILE_TYPE_TAG = Config.MISSILE_TYPE_TAG
M.MISSILE_TYPE_TAG = MISSILE_TYPE_TAG
local MISSILE_BIND_MOVE_TYPE = {
  LAUNCHER = 0,
  TARGET = 1,
  PARENT = 2,
  GLOBAL_HERO = 3
}
local MISSILE_OFFSET_TYPE = {
  WORLD = 0,
  OWNER_FORWARD = 1,
  PARENT_MISSILE_FORWARD = 2
}
local BROARDCAST_TYPE = Config.MISSILE_BROARDCAST_TYPE
local MISSILE_MOVE_COMPONENT = {
  [MISSILE_TRACK_TYPE.LINEAR] = require("manager.fight.movement.missile_linear"),
  [MISSILE_TRACK_TYPE.ARCHIMEDES] = require("manager.fight.movement.missile_archimedes"),
  [MISSILE_TRACK_TYPE.PARABOLA] = require("manager.fight.movement.missile_parabola"),
  [MISSILE_TRACK_TYPE.TRACK] = require("manager.fight.movement.missile_track"),
  [MISSILE_TRACK_TYPE.DIFFUSION] = require("manager.fight.movement.missile_diffusion"),
  [MISSILE_TRACK_TYPE.MUILT_LINEAR] = require("manager.fight.movement.missile_multi_linear"),
  [MISSILE_TRACK_TYPE.SPACE_MOVE] = require("manager.fight.movement.missile_space_move"),
  [MISSILE_TRACK_TYPE.FOLLOW_TARGRT] = require("manager.fight.movement.missile_follow_target"),
  [MISSILE_TRACK_TYPE.LINK_RAY] = require("manager.fight.movement.missile_raytrack"),
  [MISSILE_TRACK_TYPE.RAYCAST] = require("manager.fight.movement.missile_raycast"),
  [MISSILE_TRACK_TYPE.TRAJECTORY] = require("manager.fight.movement.missile_trajectory"),
  [MISSILE_TRACK_TYPE.BACK_ARCHIMEDES] = require("manager.fight.movement.missile_back_archimedes"),
  [MISSILE_TRACK_TYPE.ON_CENTER] = require("manager.fight.movement.missile_on_center"),
  [MISSILE_TRACK_TYPE.ELECTRIC_JUMP] = require("manager.fight.movement.missile_electric_jump"),
  [MISSILE_TRACK_TYPE.CIRCLE] = require("manager.fight.movement.missile_circle"),
  [MISSILE_TRACK_TYPE.CENTER_ROTATE] = require("manager.fight.movement.missile_center_rotate"),
  [MISSILE_TRACK_TYPE.TELESCOPIC] = require("manager.fight.movement.missile_telescopic"),
  [MISSILE_TRACK_TYPE.BEZIER] = require("manager.fight.movement.missile_bezier")
}
local BORN_POSITION = {
  [MISSILE_BORN_POS_TYPE.LAUNCHER] = "_cal_born_launcher",
  [MISSILE_BORN_POS_TYPE.TARGET] = "_cal_born_target",
  [MISSILE_BORN_POS_TYPE.PARENT] = "_cal_born_parent",
  [MISSILE_BORN_POS_TYPE.BYPARAM] = "_cal_born_byparam",
  [MISSILE_BORN_POS_TYPE.BYBRONPOS] = "_cal_born_by_born_pos"
}
local BORN_DIRECTION = {
  [MISSILE_BORN_DIR_TYPE.LAUNCHER_DIR] = "_cal_dir_launcher",
  [MISSILE_BORN_DIR_TYPE.LAUNCHER2TARGET_DIR] = "_cal_dir_2target",
  [MISSILE_BORN_DIR_TYPE.PARENT_DIR] = "_cal_dir_parentdir",
  [MISSILE_BORN_DIR_TYPE.PARENT2TARGET_DIR] = "_cal_dir_parent2target",
  [MISSILE_BORN_DIR_TYPE.BORN2TARGET_DIR] = "_cal_dir_born2target",
  [MISSILE_BORN_DIR_TYPE.ORIGIN2TARGET_DIR] = "_cal_dir_origin2target"
}

function M.get_missle_classs()
  return MISSILE_MOVE_COMPONENT
end

function M:_init_child_missile_data()
  if SceneMgr:be_cleaning_up_missile() then
    return
  end
  local cfg = self.missile_cfg
  self.v_child_missile_params = cfg.ChildMissileParams
  if self.v_child_missile_params then
    self.v_child_missile_last_time = {}
    self.v_chlid_missile_left_cnt = {}
    local live_time = cfg.LiveTime
    local delay = cfg.Delay or 0
    for i = 1, #self.v_child_missile_params do
      local child_missile_config = self.v_child_missile_params[i]
      local child_missile_delay = child_missile_config[2] or 0
      local child_missile_interval = child_missile_config[3] or 1
      child_missile_interval = 0 == child_missile_interval and 1 or child_missile_interval
      child_missile_config[2] = child_missile_delay
      child_missile_config[3] = child_missile_interval
      local cnt = HUGE
      if -1 ~= live_time then
        cnt = _floor((live_time - delay - child_missile_delay) / child_missile_interval) + 1
      end
      self.v_chlid_missile_left_cnt[i] = cnt
    end
  end
  self.v_born_child_whild_dead_id = cfg.BornChildWhileDead
  if 1 == self.v_born_child_whild_dead_id then
    self.v_born_child_whild_dead_id = cfg.ChildId
  end
end

function M:_init(owner, missile_id, target, parent, level, skill_id, target_pos, born_pos, ext_args)
  Base._init(self)
  self.missile_id = missile_id
  local missile_cfg = MissileConfigHookMgr:get_config(missile_id)
  Util.assert(missile_cfg, "can't find missile config: ", missile_id)
  self.missile_cfg = missile_cfg
  if self.missile_cfg.HitSound and #self.missile_cfg.HitSound > MAX_HIT_SOUND_COUNT then
    Log.Error("子弹绑定受击音效过多，子弹ID: ", self.missile_id)
  end
  self.v_owner = owner
  self.v_magic_ext_args = {
    attacker_magic_mgr = owner.magic_mgr,
    attacker_attr_mgr = owner.attr_mgr
  }
  self.v_position.x, self.v_position.y, self.v_position.z = owner:get_pos()
  self:_init_child_missile_data()
  self.v_has_been_rebound = nil
  self.missile_caster = owner
  self.v_cal_born_pos_suc = false
  self.v_is_report_missile_start = false
  self:set_target(target)
  self.v_parent = parent
  if (not level or level <= 0) and owner.skill_mgr then
    local skill = owner.skill_mgr:get_skill(skill_id)
    if skill then
      level = skill.v_level
    else
      level = 1
    end
  end
  self.v_level = level
  self.v_skill_id = skill_id
  self.missile_type = missile_cfg.MissileType
  self.skill_abort_keep_move = missile_cfg.SkillAbortKeepMove
  self.v_bind_skill_life = 1 == missile_cfg.BindSkill
  self.collider_blocked_type = missile_cfg.ColliderBlockedType
  self.need_collide_wall_cb = Util.is_true(missile_cfg.CollideWallCb)
  self.v_skill = owner.skill_mgr:try_create_skill(self.v_skill_id, true)
  self.target_type = self.missile_cfg.TargetType
  if self.missile_cfg.BornPosition ~= MISSILE_BORN_POS_TYPE.BYBRONPOS then
    self.v_born_pos = target_pos
  else
    self.v_born_pos = born_pos or Vec3.zero
  end
  if not target_pos then
    Log.Error("target_pos为空, missile_id: " .. missile_id, debug.traceback())
  end
  self.v_target_pos = target_pos:Clone()
  self.v_target_pos.y = self.v_owner:get_pos_height()
  self.v_start_time = GlobalTimeMgr:get_time()
  self.v_missile_len_time = 0
  self.missile_tag = missile_cfg.MissileTypeTag
  self.v_ignore_livetime = -1 == missile_cfg.LiveTime
  self.v_update_inteval = 0
  self.v_wait_time = missile_cfg.Delay or 0
  self.v_hitcount = missile_cfg.MaxHitCount or 1
  self.v_ignore_hitcount = -1 == self.v_hitcount
  self.v_atk_cd = missile_cfg.AtkCD or 0
  self.v_atk_cd_group = missile_cfg.ShareAtkCDGroup
  self.v_missile_survival_handler = {}
  self.v_atk_cd_timer = {}
  self.interact_type = missile_cfg.InteracteType
  self.v_can_interact_terrain = nil ~= self.interact_type
  self.v_self_magci_cd = self.v_atk_cd
  self.v_explosion_effect = missile_cfg.BurstEffect
  self.v_explosion_height = missile_cfg.BurstHeight or 0
  self.v_is_die = false
  self.v_ext_args = ext_args
  self.v_add_target_magic_count = {}
  self.v_sound_id = missile_cfg.SoundId
  self.v_total_time = 0
  self.v_live_time = self.missile_cfg.LiveTime or 0
  self.v_live_frame = missile_cfg.LiveFrame
  if self.v_live_frame and self.v_live_frame > 0 then
    self.v_live_time = Util.frame2realtime(self.v_live_frame, 0)
  end
  self:_init_scale()
  self.v_real_line_type = self.missile_cfg.LineType
  self:set_is_follow_plat(self.missile_cfg.IsFollowPlat)
  if self.missile_type == MISSILE_TYPE.SnapShoot then
    self.v_record_attr_list = {}
    self:record_missile_init_owner_attrs()
  end
  self.v_record_missile_atk_cd = {}
end

function M:remove_missile_survival_msg()
  for const_id, handler in pairs(self.v_missile_survival_handler) do
    Util.unbind_msg(self, handler)
    self.v_missile_survival_handler[const_id] = nil
  end
end

function M:_bind_missile_survival_msg(const_id, cb, ...)
  if self.v_missile_survival_handler[const_id] then
    return
  end
  self.v_missile_survival_handler[const_id] = Util.bind_msg(self, const_id, cb, ...)
end

function M:bind_missile_survival_msg()
  if self.missile_cfg.DeathWithNpc then
    self:_bind_missile_survival_msg(Const.MSG_ROLE_DEAD, self.on_role_dead, self)
  end
  if self.missile_cfg.BindTarget == MISSILE_BIND_MOVE_TYPE.GLOBAL_HERO then
    self:_bind_missile_survival_msg(Const.MSG_HERO_GO_OUT, self.on_hero_go_out, self)
  end
  if self:is_bound_missile() then
    self:_bind_missile_survival_msg(Const.MSG_OBJ_LEAVE, self.on_obj_leave, self)
    self:_bind_missile_survival_msg(Const.MSG_HERO_GO_BACKGORUND, self.on_hero_go_backgorund, self)
  end
end

local function _remove_self(self)
  self:on_missile_end()
end

function M:on_role_dead(msg)
  if msg.mm_obj == self.v_owner then
    self:stop()
    _remove_self(self)
  end
end

function M:on_obj_leave(msg)
  local map = self.v_bounded_npc_map
  if not map or not map[msg.mm_obj] then
    return
  end
  self:remove_npc_from_bound(msg.mm_obj)
end

function M:on_hero_go_out()
  if self.v_effect_id then
    local act_effect_ctrl = self:get_act_effct_ctrl()
    if Util.is_destroy(act_effect_ctrl) then
      self.v_effect_id = nil
    else
      local remain_time = act_effect_ctrl:set_effect_out_of_char(self.v_effect_id, true)
      if remain_time and (remain_time > 0.1 or remain_time < 0) then
        self:_play_effect(remain_time)
      end
    end
  end
  self.v_bind_object = Global.hero
  if Util.is_more_than_zero(self.missile_cfg.BindLauncher) then
    self.v_movement:update_bind_target(self.v_bind_object)
  end
end

function M:on_hero_go_backgorund(msg)
  if msg.mm_y == Config.HERO_STATE.IN_BACKGROUND then
    self:remove_npc_from_bound(msg.mm_obj.uuid)
  end
end

function M:setup(...)
  Base.setup(self, ...)
  if self.missile_cfg.EffectDestoryWithSelf then
    self:add_component("act_effect_ctrl", require("obj.act.act_effect_ctl_new"):new(self))
  end
  self.v_original_owner_act_effect_ctrl = self.v_owner.act_effect_ctrl
  if self.v_bind_skill_life and self.v_skill then
    self.v_skill:add_bind_skill_missile(self.id)
  end
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
  if 0 == self.v_wait_time then
    self:_init_missible_gameobj()
    self.v_is_init_missible_gameobj = true
  else
    self:report_missile_start(self.v_ext_args)
    self.v_is_init_missible_gameobj = false
  end
  if UNITY_EDITOR then
    self.gameobj.name = "missile_id: " .. self.missile_id
  end
end

function M:_init_missible_gameobj()
  self:bind_missile_survival_msg()
  self:report_missile_start(self.v_ext_args)
  self.transform:SetLocalScaleA(1, 1, 1)
  self:_update_scale()
  self:_init_offset()
  self:_cal_born_direction()
  self:_born_position()
  self:_init_collider()
  self:_play_effect()
  self:_init_movement()
  self:play_sound()
  self:_init_layer()
  self:check_create_debug_area()
  self:_born_shake()
  local vec3 = self:get_pos_vec3()
  local x = vec3.x
  local z = vec3.z
  BehaviorMgr:call_event_fun("on_missile_begin_msg", self.v_owner, x, z, self.missile_cfg, self)
  local is_receive = self.missile_cfg.IsReceive
  if is_receive and is_receive ~= BROARDCAST_TYPE.NONE then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_MISSILE_BEGIN_POS, self.v_owner, x, z, self.missile_cfg, self)
    BehaviorMgr:call_behavior_fun(self.v_owner, "on_self_missile_begin_pos", x, z, self.missile_cfg, self)
  end
  if Global.debug_missile_name then
    self.transform.name = "id_" .. self.missile_id
  end
end

function M:_init_obstacle()
  if self:is_obstacle() then
    local Colliders, InstanceIDs = CSHelper.GetCollidersInstanceID(self.gameobj.gameObject)
    if Colliders then
      local collider, instance_id
      for i = 0, Colliders.Length - 1 do
        self.v_obstacle_collider_map = self.v_obstacle_collider_map or {}
        collider = Colliders[i]
        instance_id = InstanceIDs[i]
        if not self.v_obstacle_collider_map[instance_id] then
          SceneObstacle.add(collider, false)
        end
        self.v_obstacle_collider_map[instance_id] = collider
        SceneMgr:add_client_obj(instance_id, self)
      end
    end
  end
end

function M:_born_shake()
  local born_shake_cfg = self.missile_cfg.BornShake
  if born_shake_cfg then
    local step = 4
    local shake_count = #born_shake_cfg / step
    for i = 0, shake_count - 1 do
      Global.camera:new_shake(born_shake_cfg[1 + i * step], tonumber(born_shake_cfg[2 + i * step]), nil, tonumber(born_shake_cfg[3 + i * step]), self, tonumber(born_shake_cfg[4 + i * step]), MagicDef.TIME_SCELE_TYPE.UNSCALE)
    end
  end
end

function M:_init_layer()
  local missile_cfg = self.missile_cfg
  if missile_cfg.MissileTypeTag == MISSILE_TYPE_TAG.OBSTACLE then
    if 1 == missile_cfg.IsCollideReceive then
      self:set_layer(Layer.Layer.SceneBlock)
    elseif 2 == missile_cfg.IsCollideReceive then
      self:set_layer(Layer.Layer.NoNavBlock)
    else
      self:set_layer(Layer.Layer.WalkBlock)
    end
    return
  end
  if self.v_hit_delay_timer then
    Timer:remove_timer(self.v_hit_delay_timer)
    self.v_hit_delay_timer = nil
  end
  local hit_delay = missile_cfg.HitDelay
  local layer = 1 == missile_cfg.IsCollideReceive and Layer.Layer.Missile2 or Layer.Layer.Missile
  if hit_delay and hit_delay > 0 then
    self:set_layer(Layer.Layer.Default)
    self.v_hit_delay_timer = Timer:add_timer("missile._init_layer", hit_delay, function()
      self:set_layer(layer)
    end)
  else
    self:set_layer(layer)
  end
end

function M:set_layer(layer)
  self.v_layer = layer
  if self.gameobj and not self.gameobj:IsNull() then
    self.gameobj.layer = layer
  end
  if self.effect_trans then
    self.effect_trans.gameObject.layer = layer
  end
  if self.v_collider_trans then
    self.v_collider_trans.gameObject.layer = layer
  end
end

function M:play_sound(sound_id)
  local play_sound_id = sound_id or self.v_sound_id
  if Util.is_empty(play_sound_id) then
    return
  end
  local is_3d_pos_sound = self.missile_cfg.Pos3DSound
  if self.v_owner then
    Global.sound_mgr:missile_sound(self, play_sound_id, self.v_owner:get_role_kind())
  else
    Global.sound_mgr:missile_sound(self, play_sound_id)
  end
end

function M:_init_collider()
  local missile_cfg = self.missile_cfg
  if missile_cfg.HasHit then
    local collider, character_util
    if missile_cfg.Shape == MISSILE_SHAPE.RECT then
      collider = self.gameobj:GetComponent(TypeUnityBoxCollider)
      collider:SetColliderSizeAndCenter(self.v_size_x, self.v_size_y, self.v_size_z, 0, 0, 0)
      self.effect_trans = self.transform:GetChild(0)
    elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE then
      collider = self.gameobj:GetComponent(TypeUnityCapsuleCollider)
      collider.height = self.v_size_y
      collider.radius = self.v_size_x
      self.effect_trans = self.transform:GetChild(0)
    elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE_X then
      collider = self.gameobj:GetComponent(TypeUnityCapsuleCollider)
      collider.height = self.v_size_y
      collider.radius = self.v_size_x
      collider.direction = 0
      self.effect_trans = self.transform:GetChild(0)
    elseif missile_cfg.Shape == MISSILE_SHAPE.SECTOR or missile_cfg.Shape == MISSILE_SHAPE.ANNULAR then
      self.v_collider_trans = self.transform:GetChild(1)
      collider = self.v_collider_trans:GetComponent(TypeMeshCollider)
      self.effect_trans = self.transform:GetChild(0)
      character_util = self.v_collider_trans:GetComponent(TypeCharacterUtil)
      character_util:SetInstanceId(self.cid)
      self.v_collider_trans:SetLocalScaleA(self.v_size_x, self.v_size_y, self.v_size_x)
      self.v_collider_trans:SetLocalPositionA(0, 0, 0)
      self.v_collider_cid = self.v_collider_trans.gameObject:GetInstanceID()
      SceneMgr:add_client_obj(self.v_collider_cid, self)
    elseif missile_cfg.Shape == MISSILE_SHAPE.SPHERE then
      collider = self.gameobj:GetComponent(TypeUnitySphereCollider)
      collider.radius = self.v_size_x
      self.effect_trans = self.transform:GetChild(0)
    end
    if not character_util and collider then
      character_util = collider:GetComponent(TypeCharacterUtil)
    end
    if character_util then
      character_util.IsNeedExit = self:is_bound_missile()
    end
    self.effect_trans:ResetAttr()
    local isTrigger = true
    if self.missile_cfg.MissileTypeTag == MISSILE_TYPE_TAG.OBSTACLE then
      isTrigger = false
    end
    if collider then
      collider.isTrigger = isTrigger
    end
    self.v_collider = collider
    self:update_collier_center()
  end
end

function M:_init_terrain_collider()
  if not self:check_terrain_collision() then
    return
  end
  local box_collider_go = SceneMgr:get_terrain_collider(self)
  box_collider_go.layer = Layer.Layer.NPCCollider
  local box_collider = box_collider_go:GetComponent(TypeUnityBoxCollider)
  local x_size
  if self.missile_cfg.Shape == MISSILE_SHAPE.RECT then
    x_size = self.v_size_x
  else
    x_size = self.v_size_x * 2
  end
  local collider = self.v_owner:get_collider()
  local height = collider and collider.height / 4 or 0.5
  box_collider:SetColliderSizeAndCenter(x_size, 0.5, x_size, 0, height, 0)
  box_collider_go.transform:SetParent(self.gameobj.transform)
  box_collider_go:ResetAttr()
  self.v_terrain_collider = box_collider_go
end

function M:is_obstacle()
  return self.missile_cfg.MissileTypeTag == MISSILE_TYPE_TAG.OBSTACLE
end

function M:update_collider()
  local missile_cfg = self.missile_cfg
  if missile_cfg.HasHit then
    if missile_cfg.Shape == MISSILE_SHAPE.RECT then
      self.v_collider:SetColliderSizeAndCenter(self.v_size_x, self.v_size_y, self.v_size_z, 0, 0, 0)
    elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE then
      self.v_collider.height = self.v_size_y
      self.v_collider.radius = self.v_size_x
    elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE_X then
      self.v_collider.height = self.v_size_y
      self.v_collider.radius = self.v_size_x
      self.v_collider.direction = 0
    elseif missile_cfg.Shape == MISSILE_SHAPE.SECTOR or missile_cfg.Shape == MISSILE_SHAPE.ANNULAR then
      self.v_collider_trans = self.transform:GetChild(1)
      self.v_collider_trans:SetLocalScaleA(self.v_size_x, self.v_size_y, self.v_size_x)
      if self.v_real_line_type ~= MISSILE_TRACK_TYPE.LINEAR then
        self.v_collider_trans:SetLocalPositionA(0, self.v_offset_y, 0)
      end
    elseif missile_cfg.Shape == MISSILE_SHAPE.SPHERE then
      self.v_collider.radius = self.v_size_x
    end
    self:update_collier_center()
    self:check_create_debug_area()
  end
end

function M:check_create_debug_area()
  if Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.NONE or not self.v_collider then
    return
  end
  self.v_skill_area_list = self.v_skill_area_list or {}
  for k, v in pairs(self.v_skill_area_list) do
    ResMgr:destroy_gameobj(v)
    self.v_skill_area_list[k] = nil
  end
  if Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.MESH then
    local max_y, min_y = self:get_colldider_y()
    self:_create_debug_area(min_y)
    self:_create_debug_area(max_y)
  else
    local _, y = self.v_collider.gameObject.transform:GetLocalPositionA3()
    self:_create_debug_area(y)
  end
end

function M:be_rebound(rebound_caster, tar, tarx, tarz, speed, not_change_owner, not_change_movement, need_change_tar)
  self.v_has_been_rebound = true
  self.v_rebound_caster = rebound_caster
  if not not_change_owner then
    self.v_owner = rebound_caster
    self.v_magic_ext_args.attacker_magic_mgr = self.v_owner.magic_mgr
    self.v_magic_ext_args.attacker_attr_mgr = self.v_owner.attr_mgr
  end
  local dir
  if tar then
    local tmp = tar:get_pos_vec3() - self:get_pos_vec3()
    dir = -math.atan(tmp.z, tmp.x) * rad2Deg + 90
  elseif tarx and tarz then
    local self_pos = self:get_pos_vec3()
    dir = -math.atan(tarz - self_pos.z, self_pos.x - tarx) * rad2Deg + 90
  end
  dir = dir or self.v_owner:get_dir()
  if not not_change_movement then
    Global.missile_movement_pool_mgr:release(self.v_real_line_type, self.v_movement)
    self.v_real_line_type = MISSILE_TRACK_TYPE.LINEAR
    self.v_movement = Global.missile_movement_pool_mgr:new_obj(self.v_real_line_type, self, true, speed, 0)
    self.v_movement.__DEBUG_LINE_TYPE = self.v_real_line_type
  end
  if need_change_tar then
    self:set_target(tar)
  end
  self:set_target_dir(dir, true)
  local effect_trans = self:get_effect_trans()
  if self.missile_cfg.LineType == MISSILE_TRACK_TYPE.SPACE_MOVE then
    effect_trans:SetLocalEulerY(0)
  end
end

function M:get_effect_trans()
  return self.effect_trans or self.transform
end

function M:_in_delay_time()
  local now_time = GlobalTimeMgr:get_time()
  return now_time - self.v_start_time < self.v_wait_time
end

function M:_rebound_move()
  local dt = GlobalTimeMgr:get_dt_time()
  local pos = self:get_pos_vec3()
  local dir = self:get_dir_vec()
  local pos = pos + dir * dt * 10
  self:set_pos(pos.x, pos.y, pos.z)
end

function M:update()
  if not self:is_real_finish_init() then
    return
  end
  if self:_in_delay_time() then
    return
  end
  if not self.v_is_init_missible_gameobj then
    self:_init_missible_gameobj()
    self.v_is_init_missible_gameobj = true
  end
  local dt = self.v_owner:get_missile_dt()
  self.v_total_time = self.v_total_time + dt
  if self.missile_cfg.TrackTarget and self.v_target and self.v_target ~= self.v_owner then
    self.v_target_pos = self.v_target:get_pos_vec3()
  end
  Base.update(self)
end

function M:fixed_update()
  self:_check_die()
end

function M:low_update()
  Base.low_update(self)
  if not self:is_real_finish_init() then
    return
  end
  if self.act_effect_ctrl then
    self.act_effect_ctrl:low_update()
  end
  if self:_in_delay_time() then
    return
  end
  self:_update_scale()
  if self.time_mgr then
    self.time_mgr:update()
  end
  self:update_child_create(false)
  self:update_interact_terrain()
  local dt = self.v_owner:get_missile_low_dt()
  if 0 ~= self.v_atk_cd then
    for id, atk_cd in pairs(self.v_atk_cd_timer) do
      if atk_cd ~= Config.MISSILE_ONCE_ATKCD then
        self.v_atk_cd_timer[id] = self.v_atk_cd_timer[id] - dt
        if self.v_atk_cd_timer[id] <= 0 then
          self.v_atk_cd_timer[id] = nil
        end
      end
    end
    self.v_self_magci_cd = self.v_self_magci_cd + dt
  end
end

function M:update_interact_terrain()
  if self.v_can_interact_terrain then
    self.v_can_interact_terrain = false
    SceneMgr:try_interact_special_terrain(self)
  end
end

function M:update_child_create(is_dead)
  if not self.v_child_missile_params then
    return
  end
  if SceneMgr:be_cleaning_up_missile() then
    return
  end
  for i = 1, #self.v_child_missile_params do
    local child_missile_config = self.v_child_missile_params[i]
    local child_missile_id = child_missile_config[1]
    local child_missile_delay = child_missile_config[2]
    local child_missile_interval = child_missile_config[3]
    local last_create_time = self.v_child_missile_last_time[i]
    if is_dead and self.v_is_time_out and not self.v_ignore_livetime and self.v_chlid_missile_left_cnt[i] > 0 then
      NextFrameMgr:add_next_update(self._create_child_missile, self, child_missile_id, false, i)
    elseif self:_check_child_missile(child_missile_delay, last_create_time, child_missile_interval) then
      self.v_chlid_missile_left_cnt[i] = self.v_chlid_missile_left_cnt[i] - 1
      NextFrameMgr:add_next_update(self._create_child_missile, self, child_missile_id, false, i)
    end
  end
end

function M:_check_child_missile(delay, last_create_time, cd)
  if self:get_time() <= delay + self.v_wait_time then
    return false
  end
  if nil == last_create_time then
    return true
  end
  return cd <= GlobalTimeMgr:get_time() - last_create_time
end

function M:late_update()
  if self.v_movement and (self.v_has_been_rebound or self.v_skill:is_stoped() or self.skill_abort_keep_move) then
    self.v_movement:update()
  end
  if self.act_effect_ctrl then
    self.act_effect_ctrl:late_update()
  end
  if self:is_die() then
    self:do_explosion()
  end
end

function M:create_emptygameobj()
  self.v_is_empty_obj = true
  local missile_cfg = self.missile_cfg
  if missile_cfg.HasHit then
    local need_multi_collide = self:_need_multi_collide()
    if missile_cfg.Shape == MISSILE_SHAPE.RECT then
      Global.scene_mgr:load_boxcollider(self, need_multi_collide)
    elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE or missile_cfg.Shape == MISSILE_SHAPE.CIRCLE_X then
      Global.scene_mgr:load_capsulecollider(self, need_multi_collide)
    elseif missile_cfg.Shape == MISSILE_SHAPE.SECTOR then
      Global.scene_mgr:load_sectorcollider(self, need_multi_collide, self.v_size_z)
    elseif missile_cfg.Shape == MISSILE_SHAPE.ANNULAR then
      Global.scene_mgr:load_sectorcollider(self, need_multi_collide, self.missile_cfg.AnnularAngle or 360)
    elseif missile_cfg.Shape == MISSILE_SHAPE.SPHERE then
      Global.scene_mgr:load_spherecollider(self, need_multi_collide)
    end
  else
    Global.scene_mgr:load_emptyobj(self)
  end
end

function M:do_explosion()
  if self.will_destroy then
    return
  end
  self.will_destroy = true
  if self.v_born_child_whild_dead_id > 0 then
    self.v_explosion_dir = self:get_dir()
  end
  self:on_missile_explosion()
  if self.v_born_child_whild_dead_id > 0 then
    NextFrameMgr:add_next_update(self._create_child_missile, self, self.v_born_child_whild_dead_id, true)
  end
  self:update_child_create(true)
end

function M:stop()
  if self.v_is_die then
    return
  end
  self.v_is_die = true
  if self.act_effect_ctrl then
    self.act_effect_ctrl:stop_all()
  end
end

function M:is_comm_missile()
  return self.missile_type == MISSILE_TYPE.COMMON
end

function M:judg_dodge(other)
  if self.missile_type == MISSILE_TYPE.JUDG or self.v_owner == other.v_owner then
    return
  end
  if self.missile_cfg.RemoveAfterCollide then
    self.v_is_die = true
  end
end

function M:explosion(target, target_part_id)
  if self.v_is_die then
    return
  end
  if not self.v_ignore_hitcount then
    self.v_hitcount = self.v_hitcount - 1
    self.v_is_die = self.v_hitcount <= 0
  end
  if self.v_self_magci_cd >= self.v_atk_cd then
    self:clear_magics_limit()
  end
  if self.v_self_magci_cd >= self.v_atk_cd then
    self:_do_magics(self.v_owner, self.missile_cfg.MagicLauncherNpc)
    self:_do_magics_limit(self.v_owner, self.missile_cfg.MagicLauncherNpcList, true)
  end
  self:_do_magics(target, self.missile_cfg.magic, target_part_id)
  self:_do_magics_limit(target, self.missile_cfg.MagicList, false, target_part_id)
  local god_npc = SceneMgr:get_god_npc()
  if god_npc then
    self:_do_magics(god_npc, self.missile_cfg.MagicLauncherGod)
    self:_do_magics_limit(god_npc, self.missile_cfg.MagicLauncherGodList, false)
  end
  if self.v_self_magci_cd >= self.v_atk_cd then
    self.v_self_magci_cd = 0
  end
end

function M:clear_magics_limit()
  for key, _ in pairs(self.v_add_target_magic_count) do
    self.v_add_target_magic_count[key] = 0
  end
end

function M:on_missile_explosion()
  if not Util.is_empty(self.v_explosion_effect) then
    local pos = self:get_pos_vec3():Clone()
    pos.y = pos.y + self.v_explosion_height
    SceneMgr:create_scene_effect(self.v_explosion_effect, pos, nil)
  end
  _remove_self(self)
end

function M:on_time_scale(time_scale, pause, impact_sound_type, impact_sound_volume)
  if not self:is_real_finish_init() then
    return
  end
  if self.animator then
    self.animator.speed = time_scale
  end
  if Global.sound_mgr and self.v_owner:is_hero() then
    Global.sound_mgr:change_sound_speed(time_scale, impact_sound_type, impact_sound_volume)
  end
  if self.act_effect_ctrl then
    self.act_effect_ctrl:update_speed(time_scale, pause)
  end
  if self.v_movement then
    self.v_movement:set_time_scale(time_scale)
  end
  if self.v_owner and self.v_owner.act_effect_ctrl then
    self.v_owner.act_effect_ctrl:set_missile_effect_speed(self.v_effect_id, time_scale)
  end
end

function M:target_play_beattack(target)
  local missile_cfg = self.missile_cfg
  if missile_cfg.Type ~= Config.BEHIT_TYEP.NONE and self.v_owner.skill_mgr then
    local armor_atk_lv
    if self.v_has_been_rebound and not Util.is_destroy(self.missile_caster) then
      armor_atk_lv = self.missile_caster.skill_mgr:get_armor_atk_lv(self.v_skill_id)
    else
      armor_atk_lv = self.v_owner.skill_mgr:get_armor_atk_lv(self.v_skill_id)
    end
    if target:is_npc() then
      local hit_type = missile_cfg.Type
      local damage_type = missile_cfg.DamageType
      local owner_x, owner_z
      if self.missile_tag == MISSILE_TYPE_TAG.RANGE then
        owner_x, owner_z = self:get_pos2()
      else
        owner_x, owner_z = self.v_owner:get_pos2()
      end
      local target_x, target_z = target:get_pos2()
      local dir = Math.get_lookat_dir(target_x, target_z, owner_x, owner_z)
      target:play_behit_effect(hit_type, damage_type, dir)
    end
    local is_in_armor = target:is_in_armor(armor_atk_lv)
    if is_in_armor and (not target.state_manager:is_stun_state() or target.exist_armor == nil or target.exist_armor == true) then
      local shake_ratio = target:get_bone_shake_ratio() or {
        1,
        1,
        1
      }
      local shake_time = (missile_cfg.SAShakeTime or 0) * shake_ratio[3]
      local strength = 0
      local inteval = 0
      local angle = 0
      if missile_cfg.SAShakeParam then
        angle = missile_cfg.SAShakeParam[1]
        strength = missile_cfg.SAShakeParam[2] * shake_ratio[1]
        inteval = missile_cfg.SAShakeParam[3] * shake_ratio[2]
      end
      if shake_time > 0 then
        local hit_dir = self:get_hit_back_dir(target)
        local x, z = _rotate_vec2(hit_dir.x, hit_dir.z, angle)
        local ragdoll_target = target
        if target:is_npc() and target:get_part_id() then
          local main_uuid = target:get_main_part()
          ragdoll_target = main_uuid and SceneMgr:pick_by_uuid(main_uuid) or target
        end
        if ragdoll_target:has_ragdoll() then
          ragdoll_target:hit_ragdoll(hit_dir.x, hit_dir.z, self.v_position, missile_cfg.Type)
        else
          target:on_bone_shake(shake_time, strength, inteval, x, z, angle)
        end
      end
      if missile_cfg.SAHitBackSpeed > 0 then
        target.state_manager:on_beattack(target, self, missile_cfg, true)
      end
      return true
    elseif target:is_monster() and target.state_manager:is_stun_state() then
      target.state_manager:on_stun_attack()
      if target.character_cfg.CanHitBackOnStun and missile_cfg.HitBackSpeed > 0 or missile_cfg.SAHitBackSpeed > 0 then
        local dir = self:get_hit_back_dir(target)
        target.role_move_ctrl:on_behit(dir, missile_cfg, self, is_in_armor)
      end
    else
      target.state_manager:on_beattack(target, self, missile_cfg, false)
    end
  end
  if not self.v_owner.skill_mgr then
    if self.v_owner:is_destroy() or self.v_owner:is_pre_destroy() then
      print("not skill_mgr owner die")
    else
      print("not skill_mgr owner live")
    end
  end
  return false
end

function M:try_attack(target, target_part_id)
  if not self:can_attack(target, target_part_id) then
    return
  end
  if target.character_cfg.TriggerBeHit == false then
    self:_attack_inform(target, target_part_id)
  else
    self:_try_attack(target, target_part_id)
  end
end

local function _add_atk_cd(self, cd_uuid, cd)
  cd = cd or 0
  local atkcd
  if self.v_atk_cd > 0 then
    atkcd = math.max(self.v_atk_cd - cd, 0)
  else
    atkcd = Config.MISSILE_ONCE_ATKCD
  end
  if 0 == atkcd then
    return
  end
  self.v_atk_cd_timer[cd_uuid] = atkcd
  if self.v_atk_cd_group and self.v_atk_cd_group > 0 and not Util.is_destroy(self.v_owner) then
    self.v_owner:refresh_atk_cd_group(self.v_atk_cd_group, cd_uuid, atkcd)
    self:record_missile_atk_cd_group(cd_uuid)
  end
end

local function _check_add_atk_cd(self, target, cd_uuid, cd_part_id, cd)
  _add_atk_cd(self, cd_uuid)
  local all_part_cd = true
  if cd_part_id then
    local part_info = target:get_part_info_by_id(cd_part_id)
    if part_info then
      all_part_cd = part_info.all_part_cd_on_beattack
    end
  end
  if all_part_cd then
    local all_part_info = target:get_all_part_info()
    if all_part_info then
      for part_id in pairs(all_part_info) do
        local part_cd_uuid = cd_uuid + part_id
        _add_atk_cd(self, part_cd_uuid, cd)
      end
    end
  elseif cd_part_id then
    local part_cd_uuid = cd_uuid + cd_part_id
    _add_atk_cd(self, part_cd_uuid, cd)
  end
end

function M:_attack_inform(target, target_part_id)
  if not self.v_ignore_hitcount then
    self.v_hitcount = self.v_hitcount - 1
    self.v_is_die = self.v_hitcount <= 0
  end
  local cd_uuid = target.uuid
  local cd_part_id = target_part_id
  local main_part_uuid
  if not target_part_id and target:is_npc() then
    local part_id = target:get_part_id()
    if part_id then
      cd_part_id = part_id
      main_part_uuid = target:get_main_part()
      cd_uuid = main_part_uuid
    end
  end
  _check_add_atk_cd(self, target, cd_uuid, cd_part_id)
  local npc, skill_id, hit_target, hit_type, missile_cfg, missile = self.v_owner, self.v_skill_id, target, self.missile_cfg.Type, self.missile_cfg, self
  local part_npc
  if main_part_uuid and target:get_part_type() == Config.PART_NPC_TYPE.AFFILIATE then
    hit_target = SceneMgr:pick_by_uuid(main_part_uuid)
    part_npc = target
  elseif target_part_id then
    local part_info = target:get_part_info_by_id(target_part_id)
    if part_info and part_info.part_uuid then
      part_npc = SceneMgr:pick_by_uuid(part_info.part_uuid)
    end
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_HIT, npc, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  BehaviorMgr:call_behavior_fun(npc, "on_self_skill_hit", skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  BehaviorMgr:call_behavior_fun(hit_target, "on_target_self_skill_hit", skill_id, npc, hit_type, missile_cfg, missile, part_npc)
end

function M:_try_attack(target, target_part_id)
  local last_hp_val = target.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  target:quit_throwed(self.v_owner, self.missile_id)
  if self.missile_cfg.CameraShake then
    NextFrameMgr:add_next_update(self._do_hit_magics_shake, self)
  end
  if not Util.is_client_only() then
    local tower = TowerMgr:get_tower()
    if tower then
      local room = tower:get_room()
      if room and room:is_upload_skill_hit() then
        SceneMgr:c2gs_call_scene(BehaviorMgr.EVENTS.ON_SKILL_HIT, self.v_owner.uuid, self.v_skill_id, target.uuid, self.missile_cfg.Type)
      end
    end
  end
  local cd_uuid = target.uuid
  local cd_part_id = target_part_id
  local main_part_uuid
  if not target_part_id and target:is_npc() then
    local part_id = target:get_part_id()
    if part_id then
      cd_part_id = part_id
      main_part_uuid = target:get_main_part()
      cd_uuid = main_part_uuid
    end
  end
  _check_add_atk_cd(self, target, cd_uuid, cd_part_id)
  local part_npc
  if target_part_id then
    local part_info = target:get_part_info_by_id(target_part_id)
    if part_info and part_info.part_uuid then
      part_npc = SceneMgr:pick_by_uuid(part_info.part_uuid)
    end
  end
  if Global.enable_hurt_stop then
    UnityEngine.Time.timeScale = 0
    Global.stop_update = true
  end
  target:set_cur_action_missile_id(self.id)
  self:explosion(target, target_part_id)
  target:set_cur_action_missile_id(nil)
  if self.v_movement and self.v_movement.on_hit then
    self.v_movement:on_hit()
  end
  if target:is_pre_destroy() or target:is_destroy() then
    return
  end
  self:report_missile_explosion(target.uuid)
  local is_armor_atk = false
  if target.attr_mgr:can_beattack() then
    is_armor_atk = self:target_play_beattack(target)
    local new_hp_val = target.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
    if new_hp_val ~= last_hp_val then
      self:check_play_hit_effect(target, target_part_id)
    end
    self:play_hit_sound()
  end
  if self:is_bound_missile() then
    self:catch_npc_to_bound(target)
  end
  local npc, skill_id, hit_target, hit_type, missile_cfg, missile = self.v_owner, self.v_skill_id, target, self.missile_cfg.Type, self.missile_cfg, self
  if main_part_uuid and target:get_part_type() == Config.PART_NPC_TYPE.AFFILIATE then
    hit_target = SceneMgr:pick_by_uuid(main_part_uuid)
    part_npc = target
  elseif target_part_id then
    local part_info = target:get_part_info_by_id(target_part_id)
    if part_info and part_info.part_uuid then
      part_npc = SceneMgr:pick_by_uuid(part_info.part_uuid)
    end
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_HIT, npc, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  BehaviorMgr:call_behavior_fun(npc, "on_self_skill_hit", skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  BehaviorMgr:call_behavior_fun(hit_target, "on_target_self_skill_hit", skill_id, npc, hit_type, missile_cfg, missile, part_npc)
  self:_do_hit_magics_self_time_scale(is_armor_atk)
  if not target.state_manager or not target.state_manager:is_in_stun_start() and not target.state_manager:is_behitfly_state() then
    self._do_hit_magics_target_time_scale(self, target, is_armor_atk)
  end
end

function M:play_hit_sound()
  for key, hit_sound_id in pairs(self.missile_cfg.HitSound) do
    self:play_sound(hit_sound_id)
  end
end

function M:check_play_hit_effect(target, target_part_id)
  if not target:is_show_hit_effect() then
    return
  end
  local interact_type = self.interact_type
  if not interact_type or "" == interact_type then
    interact_type = "AD"
  end
  if ELEMENT_DAMAGE_TYPE[interact_type] then
    local msg_data = {
      element_type = ELEMENT_DAMAGE_TYPE[interact_type],
      target_part_id = target_part_id
    }
    target:trigger_damage(msg_data)
  end
  self:_play_hit_eff(target, target_part_id)
end

function M:_report_cut_grass_be_hit_count()
  if not TowerMgr then
    return
  end
  if TowerMgr:is_need_report_player_blow_cnt() then
    local hit_count = 1
    SceneMgr:c2gs_call_scene("report_player_blow_cnt", hit_count)
    TowerMgr:check_tower_task_update(CommonDefine.TOWER_TASK_TYPE.TOWER_BLOW_CNT, false, hit_count)
  end
end

local dafault_point = "###"

function M:_play_hit_eff(target, target_part_id)
  local missile_cfg = self.missile_cfg
  local hit_effects = missile_cfg.HitEffect
  if hit_effects then
    for i = 1, 2 do
      local hit_effect = hit_effects[i]
      if hit_effect and not Util.is_empty(hit_effect) then
        local part_point, hit_collider
        if target_part_id then
          local part_info = target:get_part_info_by_id(target_part_id)
          if part_info then
            part_point = part_info.attach_point
            hit_collider = part_info.collider
          end
        end
        local point = part_point or missile_cfg.HitOnJoint
        if Util.is_empty(point) or point == dafault_point then
          point = Config.DEFAULT_HIT_POINT
        end
        hit_collider = hit_collider or target:get_collider()
        local world_pos
        if target:is_hit_on_collide_pos() and hit_collider then
          local pos = self:get_pos_vec3()
          world_pos = hit_collider:ClosestPoint(pos)
        end
        local dir = self.v_owner:get_dir()
        local effect_data = target.act_effect_ctrl.create_effect_param()
        effect_data.prefab_name = hit_effect
        effect_data.attach_point = point
        effect_data.world_pos = world_pos
        effect_data.dir = dir
        effect_data.is_world = true
        effect_data.not_time_scale = true
        target.act_effect_ctrl:play_attach_effect(effect_data, target)
      end
    end
  end
end

function M:can_attack(target, target_part_id)
  if self.v_is_die or self.v_is_destroy then
    return false
  end
  if self.missile_cfg.MissileTypeTag == MISSILE_TYPE_TAG.OBSTACLE then
    return false
  end
  if not target or target:is_die() or target:is_after_behitfly_die() then
    return false
  end
  if self:_in_delay_time() or self.will_destroy or not self.v_is_init_missible_gameobj then
    return false
  end
  if not self:check_target_can_attack(target, target_part_id) then
    return false
  end
  local missile_target_type = self.missile_cfg.TargetType
  local is_bound_missile = self:is_bound_missile()
  if target:is_godmode() and not is_bound_missile then
    return false
  end
  local is_target = Util.is_target_camp(self.v_owner, target, missile_target_type)
  if is_target then
    return true
  end
  return Util.has_special_tag(self.v_owner, target, self.missile_cfg.TargetTag)
end

local function _target_can_attack(self, target, target_part_id)
  if not self.v_ignore_hitcount and self.v_hitcount <= 0 then
    return false
  end
  local cd_uuid = target.uuid
  local cd_part_id = target_part_id
  if not target_part_id and target:is_npc() then
    local part_id = target:get_part_id()
    if part_id then
      cd_part_id = part_id
      cd_uuid = target:get_main_part()
    end
  end
  local atk_cd, part_cd
  if self.v_atk_cd_group and self.v_atk_cd_group > 0 then
    atk_cd = self.v_owner:get_atk_cd_group_cd(self.v_atk_cd_group, cd_uuid)
    if cd_part_id then
      part_cd = self.v_owner:get_atk_cd_group_cd(self.v_atk_cd_group, cd_part_id + cd_uuid)
    end
  else
    atk_cd = self.v_atk_cd_timer[cd_uuid]
    if cd_part_id then
      part_cd = self.v_atk_cd_timer[cd_part_id + cd_uuid]
    end
  end
  local cd = cd_part_id and part_cd or atk_cd
  if cd then
    if cd == Config.MISSILE_ONCE_ATKCD then
      return false
    end
    if self.v_atk_cd >= self.v_live_time then
      return false
    end
    if cd >= self:get_missile_remain_time() then
      return false
    end
  end
  return true, cd
end

function M:check_target_can_attack(target, target_part_id)
  local check_pass, cd = _target_can_attack(self, target, target_part_id)
  if not check_pass then
    return false
  end
  return not Util.is_more_than_zero(cd)
end

function M:can_collide_other_missile(target, target_part_id)
  return _target_can_attack(self, target, target_part_id)
end

function M:is_die()
  if self.v_is_die or self:is_destroy() then
    return true
  end
  if self.v_is_time_out then
    self.v_is_die = true
    return true
  end
  return false
end

function M:is_missile()
  return true
end

function M:get_owner()
  return self.v_owner
end

function M:get_skill_id()
  return self.v_skill_id
end

function M:get_missile_remain_time()
  return self.v_live_time - self.v_update_inteval
end

function M:get_armor_atk_lv(is_force_shift)
  local armor_atk_lv
  local magic_list = self.missile_cfg.MagicList
  if is_force_shift and magic_list then
    for key, magic_ids in pairs(magic_list) do
      for k, magic_id in pairs(magic_ids) do
        local magic_cfg = ShareRes.get_magic_cfg(magic_id)
        if magic_cfg then
          armor_atk_lv = magic_cfg.logic.ArmorAtkLevel
        end
        if armor_atk_lv and armor_atk_lv > 0 then
          break
        end
      end
      if armor_atk_lv and armor_atk_lv > 0 then
        break
      end
    end
  end
  if not armor_atk_lv or armor_atk_lv <= 0 then
    armor_atk_lv = self.v_owner.skill_mgr:get_armor_atk_lv(self.v_skill_id)
  end
  return armor_atk_lv
end

function M:get_time()
  return self.v_total_time
end

function M:get_target()
  return self.v_target
end

function M:get_dynamic_target()
  if self.v_target == nil then
    return nil
  end
  if not self.v_target:is_hero() then
    return self.v_target
  end
  if not self.v_target:check_background() then
    return self.v_target
  end
  self:set_target(Global.hero)
  return self.v_target
end

function M:try_get_target()
  self:set_target(SceneMgr:search_target(self.v_owner, self.target_type, 100))
  return self.v_target
end

function M:set_target_pos(target_pos)
  self.v_target_pos = target_pos
end

function M:get_target_pos()
  return self.v_target_pos
end

function M:get_pos_or_target_pos()
  return self.v_target and self.v_target:get_pos_vec3() or self.v_target_pos
end

function M:get_bind_targer()
  return self.v_bind_object
end

function M:on_destroy_luaobj()
  if self.v_bind_skill_life and self.v_skill then
    self.v_skill:remove_bind_skill_missile(self.id)
  end
  self:release_terrain_collider()
  self:remove_obstacle_collider()
  self:remove_missile_survival_msg()
  self.v_record_attr_list = {}
  local vec3 = self:get_pos_vec3()
  local x = vec3.x
  local z = vec3.z
  local is_break = not self.v_is_time_out
  BehaviorMgr:call_event_fun("on_missile_end_msg", self.v_owner, x, z, self.missile_cfg, self, is_break)
  local is_receive = self.missile_cfg.IsReceive
  if is_receive and is_receive ~= BROARDCAST_TYPE.NONE then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_MISSILE_END_POS, self.v_owner, x, z, self.missile_cfg, self, is_break)
    BehaviorMgr:call_behavior_fun(self.v_owner, "on_self_missile_end_pos", x, z, self.missile_cfg, self, is_break)
  end
  if self.v_hit_delay_timer then
    Timer:remove_timer(self.v_hit_delay_timer)
    self.v_hit_delay_timer = nil
  end
  Base.on_destroy_luaobj(self)
  if self.v_skill_area_list then
    for k, v in pairs(self.v_skill_area_list) do
      ResMgr:destroy_gameobj(v)
      self.v_skill_area_list[k] = nil
    end
  end
  local act_effect_ctrl = self:get_act_effct_ctrl()
  if self.v_effect_id and act_effect_ctrl then
    act_effect_ctrl:stop_effect(self.v_effect_id)
    self.v_effect_id = nil
  end
  if self.v_collider_cid then
    SceneMgr:remove_client_obj(self.v_collider_cid)
  end
  self:remove_all_bounded_objs()
  if self.v_atk_cd_group and self.v_atk_cd_group > 0 and not Util.is_destroy(self.v_owner) then
    for cd_uuid in pairs(self.v_record_missile_atk_cd) do
      if self.v_owner:get_atk_cd_group_cd(self.v_atk_cd_group, cd_uuid) then
        self.v_owner:remove_atk_cd_group(self.v_atk_cd_group)
      end
    end
  end
  if self.v_movement then
    if Util.is_more_than_zero(self.missile_cfg.BindLauncher) then
      self.v_movement:on_destroy()
    else
      Global.missile_movement_pool_mgr:release(self.v_real_line_type, self.v_movement)
    end
  end
  self.v_bind_object = nil
  self.v_movement = nil
  self.v_magic_ext_args = nil
  self.v_original_owner_act_effect_ctrl = nil
end

function M:remove_obstacle_collider()
  if self.v_obstacle_collider_map then
    for instance_id, collider in pairs(self.v_obstacle_collider_map) do
      SceneObstacle.remove(collider)
      self.v_obstacle_collider_map[instance_id] = nil
      SceneMgr:remove_client_obj(instance_id)
    end
    self.v_obstacle_collider_map = nil
  end
end

function M:release_terrain_collider()
  if self.v_terrain_collider then
    SceneMgr:remove_terrain_collider(self.v_terrain_collider)
    self.v_terrain_collider = nil
  end
end

function M:get_colldider_y()
  if self.v_collider then
    local _, pos_y, _ = self.v_collider.gameObject.transform:GetLocalPositionA3()
    local missile_cfg = self.missile_cfg
    local y = 0
    if missile_cfg.Shape == MISSILE_SHAPE.RECT or missile_cfg.Shape == MISSILE_SHAPE.SECTOR or missile_cfg.Shape == MISSILE_SHAPE.ANNULAR then
      y = self.v_size_y / 2
    elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE then
      local height = self.v_size_x * 2 + _max(self.v_size_y - self.v_size_x * 2, 0)
      y = height / 2
    elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE_X then
      y = self.v_size_x
    end
    return y + pos_y, pos_y - y
  end
  return 0, 0
end

function M:_create_debug_area_mesh(skill_area, y)
  local missile_cfg = self.missile_cfg
  local skill_area_component = skill_area:GetComponent(TypeSkillArea)
  if missile_cfg.Shape == MISSILE_SHAPE.RECT then
    local outline_width = _max(0.05, _min(self.v_size_x, self.v_size_z) * 0.15 / 20)
    skill_area_component:CreateRectangle(self.v_size_x, self.v_size_z, outline_width, false)
  elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE or missile_cfg.Shape == MISSILE_SHAPE.SPHERE or missile_cfg.Shape == MISSILE_SHAPE.CIRCLE_X then
    local outline_width = _max(0.05, self.v_size_x * 0.15 / 20)
    local segments = _floor(_max(50, self.v_size_x * 10))
    skill_area_component:CreateCircle(self.v_size_x, segments, outline_width, false)
  elseif missile_cfg.Shape == MISSILE_SHAPE.SECTOR then
    local outline_width = _max(0.05, self.v_size_x * 0.15 / 20)
    local segments = _floor(_max(50, self.v_size_x * 10))
    if self.v_size_z < 360 then
      skill_area_component:CreateSector(self.v_size_x, self.v_size_z, segments, outline_width, false)
    else
      skill_area_component:CreateCircle(self.v_size_x, segments, outline_width, false)
    end
  elseif missile_cfg.Shape == MISSILE_SHAPE.ANNULAR then
    local outline_width = _max(0.05, self.v_size_x * 0.15 / 20)
    local segments = _floor(_max(50, self.v_size_x * 10))
    if self.missile_cfg.AnnularAngle < 360 then
      skill_area_component:CreateSector(self.v_size_x, self.missile_cfg.AnnularAngle, segments, outline_width, false)
    else
      skill_area_component:CreateCircle(self.v_size_x, segments, outline_width, false)
    end
    local skill_area2 = ResMgr:create_skill_area_obj()
    skill_area2.transform:SetParent(self.transform)
    skill_area2:ResetAttr()
    local skill_area_component2 = skill_area2:GetComponent(TypeSkillArea)
    if self.missile_cfg.AnnularAngle < 360 then
      skill_area_component2:CreateSector(self.v_size_z, self.missile_cfg.AnnularAngle, segments, outline_width, false)
    else
      skill_area_component2:CreateCircle(self.v_size_z, segments, outline_width, false)
    end
    _tinsert(self.v_skill_area_list, skill_area2)
  end
  if self.missile_cfg.ColliderAnchorType == COLLIDER_ANCHOR_TYPE.START then
  end
end

function M:_create_debug_area_shape(skill_area)
  local missile_cfg = self.missile_cfg
  local skill_area_component = skill_area:GetComponent(TypeSkillArea)
  local size = Util.VEC3_TEMP
  if missile_cfg.Shape == MISSILE_SHAPE.RECT then
    size:Set(self.v_size_x, self.v_size_y, self.v_size_z)
    skill_area_component:ShowCube(size)
  elseif missile_cfg.Shape == MISSILE_SHAPE.SECTOR then
    size:Set(self.v_size_x, self.v_size_y, self.v_size_x)
    skill_area_component:ShowSector(size, self.v_size_z)
  elseif missile_cfg.Shape == MISSILE_SHAPE.ANNULAR then
    size:Set(self.v_size_x, self.v_size_y, self.v_size_x)
    skill_area_component:ShowSector(size, self.missile_cfg.AnnularAngle)
  elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE then
    local size_x = self.v_size_x * 2
    local dif = self.v_size_y - size_x
    if dif > 0 then
      size:Set(size_x, dif, size_x)
      skill_area_component:ShowCapsule(size)
    else
      size:Set(size_x, size_x, size_x)
      skill_area_component:ShowSphere(size)
    end
  elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE_X then
    size:Set(self.v_size_y, self.v_size_x, self.v_size_y)
    skill_area_component:ShowCapsule(size)
  elseif missile_cfg.Shape == MISSILE_SHAPE.SPHERE then
    local size_x = self.v_size_x * 2
    size:Set(size_x, size_x, size_x)
    skill_area_component:ShowSphere(size)
  end
end

function M:_create_debug_area(y)
  local collider_area = ResMgr:create_skill_area_obj()
  collider_area:SetActive(true)
  collider_area.transform:SetParent(self.gameobj.transform)
  collider_area:ResetAttr()
  local offset = self.missile_cfg.ColliderOffset
  if offset then
    collider_area.transform:SetLocalPositionA(offset[1] or 0, offset[2] or 0, offset[3] or 0)
  end
  if Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.MESH then
    self:_create_debug_area_mesh(collider_area, y)
  elseif Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.SHAPE then
    self:_create_debug_area_shape(collider_area)
  end
  CSChangeLayer(collider_area.transform, Layer.Layer.Character)
  _tinsert(self.v_skill_area_list, collider_area)
  local missile_area = ResMgr:create_skill_area_obj()
  missile_area.transform:SetParent(self.gameobj.transform)
  missile_area:ResetAttr()
  local missile_area_component = missile_area:GetComponent(TypeSkillArea)
  if Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.MESH then
  elseif Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.SHAPE then
    local size = Util.VEC3_TEMP
    size:Set(0.5, 0.5, 0.5)
    missile_area_component:ShowSphere(size, true)
  end
  CSChangeLayer(missile_area.transform, Layer.Layer.Character)
  _tinsert(self.v_skill_area_list, missile_area)
end

function M:_do_magics(char, magics, part_id)
  if not magics then
    return
  end
  local magic_cfg
  for _, magic_id in ipairs(magics) do
    if 0 ~= magic_id and not char:is_destroy() then
      if char:is_hero() then
        magic_cfg = ShareRes.get_magic_cfg(magic_id)
        if magic_cfg.logic.type == Config.MagicDefine.MAGIC_TYPE.HurtDamage then
          self:_report_cut_grass_be_hit_count()
        end
      end
      local magic_level = self.v_level
      char.magic_attacker = self.v_owner.id
      char.magic_mgr:add_magic(self.v_owner, magic_id, self, nil, magic_level, part_id, self.v_magic_ext_args)
      char.magic_attacker = nil
    end
  end
end

function M:_do_magics_limit(char, magics, is_add_owner, part_id, temp)
  if not magics then
    return
  end
  local add_owner_magic_count = self.v_add_target_magic_count
  for _, magic_cfg in ipairs(magics) do
    local magic_id = magic_cfg[1]
    local magic_add_max = magic_cfg[2]
    if 0 ~= magic_id and not char:is_destroy() then
      local count = add_owner_magic_count[magic_id] or 0
      if magic_add_max > count or magic_add_max < 0 then
        count = count + 1
        add_owner_magic_count[magic_id] = count
        local magic_level = self.v_level
        char.magic_mgr:add_magic(self.v_owner, magic_id, self, nil, magic_level, part_id)
      end
    end
  end
end

function M:_do_hit_magics_shake()
  if self.v_owner:is_destroy() then
    return
  end
  if self.v_owner:is_hero() and not self.v_owner:check_in_control() then
    return
  end
  local params = self.missile_cfg.CameraShake
  local shake_preset = self.missile_cfg.ShakePreset
  if params then
    if shake_preset then
      local cam = Global.camera
      local extend_param
      if params[4] then
        extend_param = {
          params[2],
          params[3],
          params[4],
          params[5],
          params[6]
        }
      end
      cam:new_shake(shake_preset[1], params[1], extend_param, params[#params - 1], self, params[#params], MagicDef.TIME_SCELE_TYPE.UNSCALE)
    else
      local cam = Global.camera
      local cam_type = cam:get_view_type()
      local camera_shake_type = cam:get_camera_shake_type()
      local c2, c3, c4, c5 = 1, 1, 1, 1
      local correct = self.missile_cfg.CamSSCorrect
      if cam_type == Config.CAMERA_VIEW_TYPE.SHOULDER or camera_shake_type == Config.CAMERA_SHAKE_TYPE.OTS and correct then
        c2 = correct[1] or 1
        c3 = correct[2] or 1
        c4 = correct[3] or 1
        c5 = correct[4] or 1
      end
      cam:shake(params[1], params[2] * c2, params[3] * c3, params[4] * c4, params[5] * c5, params[6])
    end
  end
end

function M:_do_hit_magics_self_time_scale(is_armor)
  if self.v_owner:is_destroy() then
    return
  end
  local magic_funcs = Magic.fun
  local self_time_scale
  if is_armor then
    self_time_scale = self.missile_cfg.SASelfTimeScale
  else
    self_time_scale = self.missile_cfg.SelfTimeScale
  end
  if self.v_owner:has_ragdoll() then
    self_time_scale = nil
  end
  if self_time_scale then
    if self.v_owner:is_destroy() then
      return
    end
    if not self_time_scale[6] then
      self_time_scale[6] = 1
    end
    self.v_owner:add_hit_stop(self_time_scale)
  end
end

local BEHIT_TYEP = Config.BEHIT_TYEP

function M:_do_hit_magics_target_time_scale(target, is_armor)
  if target:is_close_time_scale() then
    return
  end
  local target_time_scale
  if is_armor then
    target_time_scale = self.missile_cfg.SATargetTimeScale
  else
    target_time_scale = self.missile_cfg.TargetTimeScale
  end
  if target:has_ragdoll() then
    target_time_scale = nil
  end
  if target_time_scale then
    if target:is_destroy() then
      return
    end
    if not target_time_scale[6] then
      target_time_scale[6] = 1
    end
    local is_hit_fly = self.missile_cfg.Type == BEHIT_TYEP.HIT_FLY or self.missile_cfg.Type == BEHIT_TYEP.HIT_DOWN or target.state_manager:is_behitfly_state()
    target:add_hit_stop(target_time_scale, is_hit_fly)
  end
end

function M:_create_child_missile(missile_id, last_missile, config_index)
  if SceneMgr:be_cleaning_up_missile() then
    return
  end
  local lookat_pos, skill_action_info
  if self.v_ext_args then
    lookat_pos = self.v_ext_args.lookat_pos
    skill_action_info = self.v_ext_args.skill_action_info
  end
  local ext_arg = {
    last_child_missile = last_missile,
    lookat_pos = lookat_pos,
    explosion_dir = self.v_explosion_dir,
    skill_action_info = skill_action_info
  }
  SceneMgr:create_missile(self.v_owner, nil, missile_id, self.v_target, self, self.v_level, self.v_skill_id, self.v_target_pos, self.v_born_pos, ext_arg)
  self.v_explosion_dir = nil
  if not last_missile and config_index then
    self.v_child_missile_last_time[config_index] = GlobalTimeMgr:get_time()
  end
end

function M:_check_die()
  if self.v_is_time_out then
    return true
  end
  if self.v_create_fixed_frame and Global.fixed_frame_id - self.v_create_fixed_frame <= 1 and Util.is_more_than_zero(self.v_live_time) then
    return false
  end
  local dt = self.time_mgr and self.time_mgr:get_fixed_dt_time() or self.v_owner:get_missile_fixed_dt()
  self.v_update_inteval = self.v_update_inteval + dt
  if not self.v_ignore_livetime and self.v_update_inteval >= self.v_live_time then
    self.v_is_time_out = true
    self.time_out_fixed_frame = Global.fixed_frame_id
    return true
  end
  return false
end

function M:get_movement()
  return self.v_movement
end

function M:_init_movement()
  local line_type = self.v_real_line_type
  local bind_launcher = self.missile_cfg.BindLauncher or -1
  local target_type = self.missile_cfg.BindTarget
  self.v_bind_object = nil
  if target_type == MISSILE_BIND_MOVE_TYPE.LAUNCHER then
    self.v_bind_object = self.v_owner
  elseif target_type == MISSILE_BIND_MOVE_TYPE.TARGET then
    self.v_bind_object = self.v_target
  elseif target_type == MISSILE_BIND_MOVE_TYPE.PARENT then
    self.v_bind_object = self.v_parent
  elseif target_type == MISSILE_BIND_MOVE_TYPE.GLOBAL_HERO then
    self.v_bind_object = Global.hero
  end
  if bind_launcher > 0 then
    if not self.v_bind_object or self.v_bind_object:is_destroy() then
      return
    end
    self.v_movement = BindLauncherMovement:new(self, self.v_bind_object)
    self.v_movement.__DEBUG_LINE_TYPE = "bind_launcher"
  elseif MISSILE_MOVE_COMPONENT[line_type] then
    self.v_movement = Global.missile_movement_pool_mgr:new_obj(line_type, self)
    self.v_movement.__DEBUG_LINE_TYPE = line_type
  end
end

function M:_init_scale()
  local missile_cfg = self.missile_cfg
  self.v_scale_type = missile_cfg.ScaleType or 0
  self.v_missile_scale_func = nil
  self.v_origin_scale = 1
  self.v_origin_size_x = missile_cfg.SizeX
  self.v_origin_size_y = missile_cfg.SizeY
  self.v_origin_size_z = missile_cfg.SizeZ
  self.v_size_x = self.v_origin_size_x * self.v_origin_scale
  self.v_size_y = self.v_origin_size_y * self.v_origin_scale
  self.v_size_z = self.v_origin_size_z * self.v_origin_scale
  self.v_scale = self.v_origin_scale
end

function M:_init_offset()
  local missile_cfg = self.missile_cfg
  local offset = missile_cfg.Offset
  if offset then
    self.v_offset_x = (offset[3] or 0) * self.v_origin_scale
    self.v_offset_y = (offset[2] or 0) * self.v_origin_scale
    self.v_offset_z = (offset[1] or 0) * self.v_origin_scale
  else
    self.v_offset_x = 0
    self.v_offset_y = 0
    self.v_offset_z = 0
  end
end

function M:get_offset()
  return self.v_offset_x, self.v_offset_y, self.v_offset_z
end

function M:get_origin_pos()
  return self.v_origin_pos
end

function M:get_radius()
  return self.v_size_x
end

function M:set_radius(size)
  self.v_size_x = size
end

function M:get_size_z()
  return self.v_size_z
end

function M:set_size_z(size)
  self.v_size_z = size
end

function M:_cal_scale(time)
  return self.v_origin_scale * self.v_missile_scale_func(time)
end

function M:_update_scale()
  if not self.v_missile_scale_func then
    return
  end
  local dt = self:get_time() - self.missile_cfg.WaitTime
  local scale = self:_cal_scale(dt)
  self:set_scale(scale)
  self:_update_common_scale()
end

function M:_update_common_scale()
  self.v_size_x = self.v_origin_size_x * self.v_scale
  self.v_size_z = self.v_origin_size_z * self.v_scale
end

function M:add_deflection()
  if not self.v_dir_inited then
    return
  end
  local cur_dir = self:get_dir()
  local missile_cfg = self.missile_cfg
  if missile_cfg.Deflection then
    cur_dir = cur_dir + missile_cfg.Deflection
  end
  self:set_target_dir(cur_dir, true)
end

function M:_cal_born_direction()
  local missile_cfg = self.missile_cfg
  if missile_cfg.LineType == MISSILE_TRACK_TYPE.TELESCOPIC then
    self:_born_position()
    self.v_cal_born_pos_suc = true
  end
  local direction_func = BORN_DIRECTION[missile_cfg.BornDirectionType]
  assert(direction_func, "error born direction: " .. missile_cfg.BornDirectionType)
  self.v_dir_inited = self[direction_func](self)
  self:add_deflection()
end

function M:_born_position()
  if self.v_cal_born_pos_suc then
    return
  end
  local func = BORN_POSITION[self.missile_cfg.BornPosition]
  assert(func, "can't find born position func, missile id: " .. self.missile_id .. ", born position: " .. self.missile_cfg.BornPosition)
  self[func](self)
end

function M:_cal_born_launcher()
  if not self.v_owner then
    return
  end
  self:_cal_born_position(self.v_owner:get_pos_vec3())
end

function M:_cal_born_parent()
  if not self.v_parent then
    return
  end
  self:_cal_born_position(self.v_parent:get_pos_vec3())
end

function M:get_hit_back_dir(target)
  local hit_back_center = self.missile_cfg.BeHitCenter
  if hit_back_center == BE_HIT_CENTER.MISSILE_OWNER then
    return self.v_owner:get_dir_to_target(target)
  elseif hit_back_center == BE_HIT_CENTER.MISSILE_CENTER then
    return self:get_dir_to_target(target)
  elseif hit_back_center == BE_HIT_CENTER.MISSILE_DIR then
    return self:get_dir_vec()
  else
    return self.v_owner:get_dir_to_target(target)
  end
end

function M:_cal_born_target()
  if self.v_target then
    self:_cal_born_position(self.v_target:get_pos_vec3())
  else
    self:_cal_born_position(self.v_target_pos)
  end
end

function M:_cal_born_byparam()
  self:_cal_born_position(self.v_born_pos)
end

function M:_cal_born_by_born_pos()
  self:_cal_born_position(self.v_born_pos)
end

function M:_update_plat_at_born()
  if self.v_is_follow_plat and self:_is_scene_has_plat() then
    self:_update_land_height()
    self:_update_belong_plat()
  end
end

function M:_cal_born_position(pos)
  local dir = self:get_dir()
  if not self.v_offset_z or not self.v_offset_x then
    Log.Error("_cal_born_position offset is nil")
    if self.v_owner:is_destroy() then
      Log.Info("missile v_owner destroy")
      return
    end
    self:set_pos_vec(pos)
    self:_update_plat_at_born()
    return
  end
  local after_rotate_x, after_rotate_z = Math.get_pos_rotation_dir(dir, self.v_offset_x, self.v_offset_z)
  self.v_origin_pos = pos:Clone()
  self.v_origin_pos.x = self.v_origin_pos.x + after_rotate_x
  self.v_origin_pos.z = self.v_origin_pos.z + after_rotate_z
  self.v_origin_pos.y = self.v_origin_pos.y + self.v_offset_y
  self:set_pos_vec(self.v_origin_pos)
  if self.v_dir_cb then
    self.v_dir_cb()
    self.v_dir_cb = nil
  end
  self:_update_plat_at_born()
end

function M:_cal_dir_launcher()
  self:set_target_dir(self.v_owner:get_dir(), true)
  return true
end

function M:_cal_dir_2target()
  local pos = self.v_target_pos
  if self.v_ext_args then
    local lookat_pos = self.v_ext_args.lookat_pos
    if lookat_pos then
      pos = lookat_pos
    end
  elseif self.v_target then
    pos = self.v_target:get_pos_vec3()
  end
  self:face_to_pos(pos.x, pos.z, true)
  return true
end

function M:_cal_dir_parentdir()
  local dir
  if self.v_ext_args and self.v_ext_args.explosion_dir then
    dir = self.v_ext_args.explosion_dir
  elseif self:_check_parent() then
    dir = self.v_parent:get_dir()
  else
    return
  end
  if not dir then
    return
  end
  self:set_target_dir(dir, true)
  return true
end

function M:_cal_dir_parent2target()
  if not self:_check_parent() then
    return
  end
  local target_pos
  if self.v_target then
    target_pos = self.v_target:get_pos_vec3()
  else
    target_pos = self.v_target_pos
  end
  local parent_pos = self.v_parent:get_pos_vec3()
  local dir = Math.get_lookat_dir(parent_pos.x, parent_pos.z, target_pos.x, target_pos.z)
  self:set_target_dir(dir)
  return true
end

function M:_cal_dir_born2target()
  local target_posx = self.v_target_pos.x
  local target_posz = self.v_target_pos.z
  if self.v_ext_args then
    local lookat_pos = self.v_ext_args.lookat_pos
    if lookat_pos then
      target_posx = lookat_pos.x
      target_posz = lookat_pos.z
    else
      self:set_target_dir(self.v_owner:get_dir(), true)
      return
    end
  end
  local dir = Math.get_lookat_dir(self.v_born_pos.x, self.v_born_pos.z, target_posx, target_posz)
  self:set_target_dir(dir, true)
  return true
end

function M:get_space_move_dir(face_to_target)
  if not face_to_target then
    return (self.v_target_pos - self.v_origin_pos):Normalize()
  end
  local dir
  local camera_aimed = Global.camera:check_camera_aimed()
  if camera_aimed and self.v_owner:is_hero() then
    local camera_pos = Global.camera:get_camera_forward_pos()
    dir = camera_pos:Sub(self.v_origin_pos)
    dir = dir:SetNormalize()
  elseif self.v_owner:is_npc() then
    local transform = Global.hero:get_transform()
    local x, y, z = transform:GetPositionA()
    dir = Vec3.New(x, y, z):Sub(self.v_origin_pos)
    dir = dir:SetNormalize()
  else
    dir = self:get_dir_vec()
  end
  return dir
end

function M:_cal_dir_origin2target()
  if not self.v_origin_pos then
    function self.v_dir_cb()
      self.v_dir_inited = self:_cal_dir_origin2target()
      
      self:add_deflection()
    end
    
    return
  end
  local dir = Math.get_lookat_dir(self.v_origin_pos.x, self.v_origin_pos.z, self.v_target_pos.x, self.v_target_pos.z)
  self:set_target_dir(dir, true)
  return true
end

function M:_check_parent()
  if not self.v_parent then
    Log.Error("没有parent: ", self.missile_id)
    return false
  end
  return true
end

function M:_play_effect(effect_length)
  local cfg = self.missile_cfg
  local parent = self:get_effect_trans()
  if cfg.LineType == MISSILE_TRACK_TYPE.SPACE_MOVE then
    if Global.camera:check_camera_aimed() then
      local dir = Global.camera:get_aimed_camera_angle() or 0
      parent.transform:SetLocalEuler(dir, 0, 0)
    elseif self.v_owner:is_npc() then
      local dir = self:get_space_move_dir(self.missile_cfg.lineparams[3] == nil or 0 == self.missile_cfg.lineparams[3])
      parent.transform:SetForwardA(dir:Get())
    end
  end
  if not Util.is_empty(cfg.Effect) then
    local act_effect_ctrl = self:get_act_effct_ctrl()
    local effect_param = act_effect_ctrl.create_effect_param()
    effect_param.prefab_name = cfg.Effect
    effect_param.parent = parent
    effect_param.callback_params = self
    effect_param.effect_source = Config.EFFECT_SOURCE.MISSILE_PLAY
    effect_param.scale = cfg.EffectScale
    effect_param.time_scale = cfg.EffectTimeScale
    effect_param.effect_length = effect_length
    effect_param.not_time_scale = cfg.IsTimeScale == EFFECT_TIME_SCALE_TYPE.NONE
    if cfg.EffectOffset then
      effect_param.position_offset = Vec3.New(cfg.EffectOffset[1] or 0, cfg.EffectOffset[2] or 0, cfg.EffectOffset[3] or 0)
    end
    if self:is_obstacle() then
      function effect_param.load_callback()
        if self:is_die_or_destroy() or Util.is_destroy(self.v_owner) then
          return
        end
        self:_init_obstacle()
      end
    end
    self.v_effect_id = act_effect_ctrl:play_effect(effect_param)
  end
end

function M:get_act_effct_ctrl()
  if self.missile_cfg.EffectDestoryWithSelf then
    return self.act_effect_ctrl
  else
    return self.v_original_owner_act_effect_ctrl
  end
end

function M:update_collier_center()
  local missile_cfg = self.missile_cfg
  if missile_cfg.ColliderOffset then
    local offset = missile_cfg.ColliderOffset
    self.v_collider:SetLocalPositionA(offset[1] or 0, offset[2] or 0, offset[3] or 0)
    return
  end
  if missile_cfg.ColliderAnchorType == COLLIDER_ANCHOR_TYPE.START then
    self.v_collider:SetCenter(0, self.v_offset_y, self.v_size_z / 2)
  elseif missile_cfg.Shape == MISSILE_SHAPE.CIRCLE or missile_cfg.Shape == MISSILE_SHAPE.CIRCLE_X then
    self.v_collider:SetCenter(0, 0, 0)
  end
end

function M:report_missile_start(ext_args)
  if not StateReport then
    return
  end
  if self.v_is_report_missile_start then
    return
  end
  if self.rtid then
    return
  end
  self.rtid = SceneMgr:get_rtid()
  local request = {
    uuid = self.v_owner.uuid,
    missile_id = self.missile_id,
    missile_level = self.v_level,
    missile_rtid = self.rtid,
    is_snapshot = self.missile_type == MISSILE_TYPE.SnapShoot
  }
  if self.v_parent then
    request.parent_rtid = self.v_parent.rtid
    if ext_args then
      request.last_child_missile = ext_args.last_child_missile == true
    end
  elseif self.v_skill and (not self.v_ext_args or not self.v_ext_args.not_report_skill) then
    request.cast_skill_rtid = self.v_skill.rtid
    request.key_frame_num = self.v_cast_frame or self.v_skill.v_frame
  end
  if self.missile_cfg.__HOOKED_LIFE_TIME__ then
    request.life_time = self.missile_cfg.LiveTime
  end
  StateReport:cast_missile(request)
  self.v_is_report_missile_start = true
end

function M:report_missile_explosion(def_uuid)
  if not StateReport then
    return
  end
  local request = {
    uuid = self.v_owner.uuid,
    victim_uuid = def_uuid,
    missile_rtid = self.rtid
  }
  StateReport:missile_explosion(request)
end

function M:on_missile_end()
  if self.v_removed or self.v_is_destroy then
    return
  end
  if not self.rtid then
    self:report_missile_start(self.v_ext_args)
  end
  self.v_removed = true
  SceneMgr:remove_missile(self)
  local request = {
    uuid = self.v_owner.uuid,
    missile_rtid = self.rtid,
    is_building = MagicReporter:is_building_report() or self.v_born_child_whild_dead_id > 0
  }
  self:remove_missile_survival_msg()
  if StateReport then
    StateReport:remove_missile(request)
  end
end

function M:destroy()
  Global.scene_mgr:remove_missile(self)
end

function M:collider_is_invalid(target)
  if self.missile_cfg.Shape == MISSILE_SHAPE.ANNULAR then
    local distance = self:get_distance(target)
    return distance < self.v_size_z
  end
  return false
end

function M:get_collider_square_dist(other, part_info)
  if self.missile_cfg.MissileTypeTag == MISSILE_TYPE_TAG.MELEE then
    if part_info then
      Util.VEC3_TEMP:Set(part_info.transform:GetPositionA())
      return Vec3.SquareDistance(self.v_owner:get_pos_vec3(), Util.VEC3_TEMP)
    else
      return self.v_owner:get_square_dist(other)
    end
  elseif part_info then
    Util.VEC3_TEMP:Set(part_info.transform:GetPositionA())
    return Vec3.SquareDistance(self:get_pos_vec3(), Util.VEC3_TEMP)
  else
    return self:get_square_dist(other)
  end
end

function M:get_line_type()
  return self.v_real_line_type or self.missile_cfg.LineType
end

function M:get_in_global_scale()
  if not self.v_owner:is_destroy() and self.v_owner.time_mgr then
    return self.v_owner.time_mgr:get_is_global_scale()
  end
  return false
end

function M:get_owner_time_scale()
  if not self.v_owner:is_destroy() then
    local time_mgr = self.v_owner.time_mgr
    if time_mgr and not time_mgr:get_is_ignoral_missile() then
      return time_mgr:get_time_scale()
    end
  end
  return 1
end

function M:get_missile_effect()
  return self.v_effect_id
end

function M:_need_multi_collide()
  local missile_cfg = self.missile_cfg
  if missile_cfg.NoMultiCollide then
    return false
  end
  return 1 ~= self.v_hitcount or missile_cfg.AtkCD < missile_cfg.LiveTime
end

function M:get_collider_component()
  return self.v_collider
end

local COLLIDE_OBSTACLE_TYPE = {
  OBJ = 1,
  OBSTACLE_AREA = 2,
  WALL = 3
}

function M:on_collide_obstacle_collider(is_obj, is_wall)
  local type
  if is_obj then
    type = COLLIDE_OBSTACLE_TYPE.OBJ
  elseif is_wall then
    type = COLLIDE_OBSTACLE_TYPE.WALL
  else
    type = COLLIDE_OBSTACLE_TYPE.OBSTACLE_AREA
  end
  BehaviorMgr:call_event_fun("on_missile_collide_obstacle_msg", self.v_owner, type, self.missile_cfg, self)
end

function M:on_collide_obstacle_mask(other_cid)
  if not self.v_collide_obstacle_trigger then
    if self.collider_blocked_type == Config.COLLIDER_BLOCKED_TYPE.STOP then
      local scene_map = SceneMgr:get_scene_map()
      if scene_map and scene_map:check_missile_collider(self, other_cid) then
        self:stop()
        self.v_collide_obstacle_trigger = true
      end
    elseif self.collider_blocked_type == Config.COLLIDER_BLOCKED_TYPE.CHANGE_SPEED then
      if self.v_movement then
        self.v_movement:set_time_scale(0)
      end
      self.v_collide_obstacle_trigger = true
    end
  end
  if self.need_collide_wall_cb then
    local scene_map = SceneMgr:get_scene_map()
    if scene_map then
      local is_collide, is_obj, is_wall = scene_map:check_missile_collide_unwalkable(self, other_cid)
      if is_collide then
        self:on_collide_obstacle_collider(is_obj, is_wall)
      end
    end
  end
end

function M:is_bound_missile()
  return self.missile_tag == MISSILE_TYPE_TAG.BOUND
end

function M:is_range_missile()
  return self.missile_tag == MISSILE_TYPE_TAG.RANGE
end

function M:is_die_or_destroy()
  return self.v_is_die or self:is_destroy()
end

function M:check_terrain_collision()
end

function M:catch_missile_to_bound(missile)
  local map = self.v_bounded_missile_map or {}
  self.v_bounded_missile_map = map
  if self:is_die_or_destroy() then
    return
  end
  if map[missile] or missile:is_die_or_destroy() then
    return
  end
  local is_valid_camp = Util.is_target_camp(self.v_owner, missile.v_owner, self.missile_cfg.TargetType)
  if not is_valid_camp then
    return
  end
  map[missile] = true
  BehaviorMgr:on_missile_bound_catch_missile(self.v_owner, missile.missile_cfg, missile, self.missile_cfg, self, missile.v_owner)
end

function M:remove_missile_from_bound(missile)
  local map = self.v_bounded_missile_map
  if not map or not map[missile] then
    return
  end
  map[missile] = nil
  BehaviorMgr:on_missile_bound_release_missile(self.v_owner, missile, self.missile_cfg, self)
end

function M:catch_npc_to_bound(npc)
  assert(npc)
  local map = self.v_bounded_npc_map or {}
  self.v_bounded_npc_map = map
  local uuid = npc.uuid
  if map[uuid] or npc:is_destroy() then
    return
  end
  local is_valid_camp = Util.is_target_camp(self.v_owner, npc, self.missile_cfg.TargetType)
  if not is_valid_camp then
    return
  end
  map[uuid] = true
  BehaviorMgr:on_missile_bound_catch_npc(self.v_owner, npc, self.missile_cfg, self)
end

function M:remove_npc_from_bound(uuid)
  assert(uuid)
  local map = self.v_bounded_npc_map
  if not map or not map[uuid] then
    return
  end
  map[uuid] = nil
  local npc = SceneMgr:pick_by_uuid(uuid)
  if not Util.is_destroy(npc) then
    BehaviorMgr:on_missile_bound_release_npc(self.v_owner, npc, self.missile_cfg, self)
  end
end

function M:remove_all_bounded_objs()
  local map = self.v_bounded_npc_map
  if map then
    for uuid in pairs(map) do
      self:remove_npc_from_bound(uuid)
    end
    self.v_bounded_npc_map = nil
  end
  map = self.v_bounded_missile_map
  if map then
    for k in pairs(map) do
      self:remove_missile_from_bound(k)
    end
    self.v_bounded_missile_map = nil
  end
end

function M:change_linetype(line_type, lineparams)
  if self.v_movement then
    if Util.is_more_than_zero(self.missile_cfg.BindLauncher) then
      self.v_movement:on_destroy()
    else
      Global.missile_movement_pool_mgr:release(self.v_real_line_type, self.v_movement)
    end
  end
  self.v_real_line_type = line_type
  self.v_movement = Global.missile_movement_pool_mgr:new_obj(line_type, self, lineparams)
  self.v_movement.__DEBUG_LINE_TYPE = line_type
end

function M:set_missile_time_scale(scale)
  if self.missile_tag ~= MISSILE_TYPE_TAG.RANGE then
    return
  end
  if not self.time_mgr then
    self.time_mgr = Time:new(self)
  end
  local scale_data = {magic_id = 9999999}
  self.time_mgr:add_time_scale(scale, 99999, scale_data)
end

function M:set_remove_flag()
  self.v_remove_flag = true
end

function M:get_remove_flag()
  return self.v_remove_flag
end

function M:set_movement_pramas(params)
  if not self.v_movement then
    return
  end
  self.v_movement:set_params(params)
end

function M:record_missile_init_owner_attrs()
  local attr_mgr = self.v_owner.attr_mgr
  for attr_id, value in pairs(DAMAGE_CALCU_USED_ATTRS) do
    self.v_record_attr_list[attr_id] = attr_mgr:get_attr(attr_id) or 0
  end
end

function M:get_record_attr_list()
  return self.v_record_attr_list
end

function M:set_cast_frame(cast_frame)
  self.v_cast_frame = cast_frame
end

function M:set_collider_pos(pos)
  if self.v_collider then
    self.v_collider.transform:SetPositionA(pos:Get())
  end
end

function M:get_collider_pos()
  if self.v_collider then
    return self.v_collider.transform:GetPositionA()
  end
end

function M:get_born_pos()
  return self.v_born_pos
end

function M:set_target(target)
  self.v_target = target
end

function M:get_skill_action_info()
  return self.v_ext_args and self.v_ext_args.skill_action_info
end

function M:is_need_land_height()
  return false
end

function M:set_effect_id(effect_id)
  self.v_effect_id = effect_id
end

function M:add_kill_role_count(uuid)
  self.v_kill_role_count = self.v_kill_role_count or {}
  self.v_kill_role_count[uuid] = (self.v_kill_role_count[uuid] or 0) + 1
end

function M:get_kill_role_count(uuid)
  return self.v_kill_role_count and self.v_kill_role_count[uuid] or 0
end

function M:behavior_add_atk_cd(npc, cd)
  local uuid = npc.uuid
  _check_add_atk_cd(self, npc, uuid, nil, cd)
end

function M:record_missile_atk_cd_group(cd_uuid)
  self.v_record_missile_atk_cd[cd_uuid] = true
end

function M:effect_play_anim(anim_state_name)
  if not self.v_effect_id then
    return
  end
  local effect_ctrl = self:get_act_effct_ctrl()
  effect_ctrl:assign_effect_play_anim(self.v_effect_id, anim_state_name)
end

function M:set_effect_end_anim_idx(idx)
  if not self.v_effect_id then
    return
  end
  local effect_ctrl = self:get_act_effct_ctrl()
  effect_ctrl:set_end_anim_idx_by_effect_id(self.v_effect_id, idx)
end

return M
