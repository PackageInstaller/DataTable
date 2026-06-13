local Base = require("obj.baseobj")
local Util = require("utils.util")
local Vec3 = require("base.vec3")
local Math = require("base.mathx")
local CircleCollider = require("manager.fight.collider.circle")
local BoolTable = require("utils.bool_table")
local ToughDownChangeDefLevel = ShareRes.get_comm_value("ToughDownChangeDefLevel")
local _sin = math.sin
local _cos = math.cos
local _abs = math.abs
local _lerp = Math.lerp_number
local _deg2rad = math.rad(1)
local ROLE_MOVE_TYPE = Config.ROLE_MOVE_TYPE
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.v_speed_factor = 1
  self.v_godmode = BoolTable:new()
  self.v_close_time_scale = false
  self.v_lock_spell_type_map = {}
  self.scope = {}
  self.v_dir_vec = Vec3.New(0, 0, 0)
  self.v_move_type = ROLE_MOVE_TYPE.run
  self.v_pre_move_type = self.v_move_type
  self.v_joint_hide_bone = {}
  self.v_speed_correct_param = {
    0,
    0,
    0,
    0
  }
  self:set_is_follow_plat(true)
end

function M:get_move_type()
  return self.v_move_type
end

function M:get_pre_move_type()
  return self.v_pre_move_type
end

function M:update_move_type(type)
  if self.v_move_type ~= type then
    self.v_pre_move_type = self.v_move_type
    self.v_move_type = type
  end
end

function M:setup(...)
  Base.setup(self, ...)
  self:add_component("orienter", require("obj.behavior.orienter"):new(self))
end

function M:get_collider_pos2()
  return self.collider:get_pos2()
end

function M:aftersetup(...)
  Base.setup(self, ...)
  if self.character_cfg then
    local body_radius = self.character_cfg.BodyRadius
    self.v_body_radius = body_radius
    if not self:is_god() then
      self.collider = CircleCollider:new(self, body_radius)
    end
    self.v_cfg_model_scale = self.character_cfg.ModelScale
  end
  self.v_cfg_model_scale = self.v_cfg_model_scale or 1
  self.v_tar_model_scale = self.v_cfg_model_scale
  self:set_model_scale(self.v_cfg_model_scale)
end

function M:set_model_scale(scale)
  self.model_scale = scale
  self.radius = self.radius * scale
  if self.transform and not self.transform:IsNull() then
    self.transform:SetLocalScaleA(self.model_scale)
  end
  self:refresh_anim_speed()
end

function M:update_model_scale()
  if _abs(self.v_tar_model_scale - self.model_scale) > 0.01 then
    local scale = _lerp(self.model_scale, self.v_tar_model_scale, self.v_model_scale_fade)
    self:set_model_scale(scale)
  end
end

function M:change_model_scale(scale, fadein)
  self.v_tar_model_scale = scale
  self.v_model_scale_fade = fadein
end

function M:revert_model_scale(fadeout)
  self.v_tar_model_scale = self.v_cfg_model_scale
  self.v_model_scale_fade = fadeout
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
  self.transform:SetLocalScaleA(self.model_scale)
  self.orienter:orienter_setup()
end

function M:create_gameobj()
  if self.v_is_empty_obj then
    Global.scene_mgr:release_emptyobj(self)
    self:_clear_gameobj()
  end
  self.v_is_empty_obj = false
  Global.scene_mgr:load_gameobj_async(self)
end

function M:create_emptygameobj()
  self.v_is_empty_obj = true
  Global.scene_mgr:load_emptyobj(self)
end

function M:clear_joint()
  for k, v in ipairs(self.v_joint_hide_bone) do
    v:SetActive(true)
  end
  self.v_joint_hide_bone = {}
end

function M:on_destroy_gameobj()
  self:clear_joint()
  Base.on_destroy_gameobj(self)
  if self.collider then
    self.collider:on_destroy()
    self.collider = nil
  end
end

function M:update()
  if self:is_hero() and self:check_background() then
    return
  end
  Base.update(self)
  if self:is_real_finish_init() then
    self.orienter:update_orienter()
  end
end

function M:low_update()
  if self:is_hero() and self:check_background() then
    return
  end
  Base.low_update(self)
  if self.collider then
    self.collider:update()
  end
  self:update_model_scale()
end

function M:ready_play_cg(cb)
  if not Global.is_fixed_timeline then
    if not self.cg_play_obj then
      self.cg_play_obj = ResMgr:instantiate(self.gameobj)
    end
    Util.reset_by_root(self.cg_play_obj)
  end
  if cb then
    cb()
  end
end

function M:end_play_cg()
  if self.cg_play_obj and not Global.is_fixed_timeline then
    ResMgr:destroy_gameobj(self.cg_play_obj)
    self.cg_play_obj = nil
  end
  if self.gameobj and not self.gameobj:IsNull() then
    self.gameobj:SetActive(true)
  end
end

function M:set_playing_cg(param, load_cb)
  if param then
    if self.gameobj then
      self:ready_play_cg(load_cb)
    else
      self:add_loaded_cb(function()
        self:ready_play_cg(load_cb)
      end)
    end
  else
    self:end_play_cg()
  end
end

function M:set_camp()
end

function M:get_camp()
  return 1
end

function M:get_index()
  return 0
end

function M:get_dir()
  if not self.orienter then
    return Base.get_dir(self)
  end
  return self.orienter:get_dir()
end

function M:get_dir_vec()
  local dir = self:get_dir()
  local x = _sin(_deg2rad * dir)
  local z = _cos(_deg2rad * dir)
  self.v_dir_vec.x = x
  self.v_dir_vec.z = z
  return self.v_dir_vec
end

function M:get_dir_to_target(target)
  local target_pos = target:get_pos_vec3()
  return self:get_dir_to_pos(target_pos)
end

function M:get_dir_to_pos(target_pos)
  if Math.almost_equal_vec3(self.v_position, target_pos) then
    return self:get_dir_vec()
  end
  local dir = Vec3.New(target_pos.x - self.v_position.x, 0, target_pos.z - self.v_position.z)
  dir:SetNormalize()
  return dir
end

function M:get_dir_to_pos2(target_pos)
  if Math.almost_equal_vec3(self.v_position, target_pos) then
    local dir_vec = self:get_dir_vec()
    return dir_vec:Get()
  end
  return Vec3.NormalizeA(target_pos.x - self.v_position.x, 0, target_pos.z - self.v_position.z)
end

function M:get_root_scope()
  return self.scope
end

function M:lookat_pos(target_pos)
  local dir = Math.get_lookat_dir(self.v_position.x, self.v_position.z, target_pos.x, target_pos.z)
  self:set_target_dir(dir)
end

function M:set_joint_active(target_bone, visible)
  if self.v_is_destroy then
    return
  end
  self:add_loaded_cb(function()
    local bone = self:get_setting_point(target_bone) or self.transform:Find(target_bone)
    if bone and not bone:IsNull() then
      bone.gameObject:SetActive(visible)
      if not visible then
        table.insert(self.v_joint_hide_bone, bone.gameObject)
      end
    end
    local lod0 = "lod0/" .. target_bone .. "_lod0"
    local bone_lod0 = self:get_setting_point(lod0) or self.transform:Find(lod0)
    if bone_lod0 and not bone_lod0:IsNull() then
      bone_lod0.gameObject:SetActive(visible)
      if not visible then
        table.insert(self.v_joint_hide_bone, bone_lod0.gameObject)
      end
    end
    local lod1 = "lod1/" .. target_bone .. "_lod1"
    local bone_lod1 = self:get_setting_point(lod1) or self.transform:Find(lod1)
    if bone_lod1 and not bone_lod1:IsNull() then
      bone_lod1.gameObject:SetActive(visible)
      if not visible then
        table.insert(self.v_joint_hide_bone, bone_lod1.gameObject)
      end
    end
    local lod2 = "lod2/" .. target_bone .. "_lod2"
    local bone_lod2 = self:get_setting_point(lod2) or self.transform:Find(lod2)
    if bone_lod2 and not bone_lod2:IsNull() then
      bone_lod2.gameObject:SetActive(visible)
      if not visible then
        table.insert(self.v_joint_hide_bone, bone_lod2.gameObject)
      end
    end
  end)
end

function M:is_active()
  return self.gameobj.activeSelf
end

function M:get_speed()
  if self.v_move_type == ROLE_MOVE_TYPE.run then
    local speed = (self.character_cfg.Speed[3] + self.v_speed_correct_param[3]) * self:get_speed_ratio()
    return speed
  elseif self.v_move_type == ROLE_MOVE_TYPE.forward or self.v_move_type == ROLE_MOVE_TYPE.back then
    local speed = (self.character_cfg.Speed[1] + self.v_speed_correct_param[1]) * self:get_speed_ratio()
    return speed
  elseif self.v_move_type == ROLE_MOVE_TYPE.left or self.v_move_type == ROLE_MOVE_TYPE.right then
    local speed = (self.character_cfg.Speed[2] + self.v_speed_correct_param[2]) * self:get_speed_ratio()
    return speed
  end
end

function M:set_hp()
end

function M:set_server_move_type(move_type)
  self.v_server_move_type = move_type
end

function M:get_server_move_type()
  return self.v_server_move_type
end

function M:set_server_stop_move(stop_move)
  self.v_server_stop_move = stop_move
end

function M:is_server_stop_move()
  return self.v_server_stop_move
end

function M:set_speed_factor(factor)
  self.v_speed_factor = factor
end

function M:reset_speed_factor()
  self.v_speed_factor = 1
end

function M:_on_move_to_dst(interrupt)
  if interrupt then
    return
  end
  if self.v_target_dir_x then
    self.state_manager:move_by_dir(self.v_target_dir_x, self.v_target_dir_z, self.v_target_speed)
  end
end

function M:on_dead(_, not_need_anim)
end

function M:set_dead(...)
  self:on_dead(...)
end

function M:get_title()
  return ""
end

function M:get_belongtitle()
  return ""
end

function M:get_monster_title()
  return ""
end

function M:is_die()
  return false
end

function M:is_in_action(layer, action)
  return self.act_ctrl:is_in_action(layer, action)
end

function M:on_buff_change(...)
  self.uicomponent:update_name()
end

function M:get_buff_title()
  if self.buff_mgr then
    return self.buff_mgr:get_buff_title()
  end
end

function M:set_atk_armor_level(level, is_force)
  if not self.skill_mgr then
    return
  end
  self.skill_mgr:set_armor_atk_lv(level, is_force)
end

function M:set_def_armor_level(level, is_force)
  if not self.skill_mgr then
    return
  end
  self.skill_mgr:set_armor_def_lv(level, is_force)
end

function M:is_in_armor(armor_atk_lv)
  if not self.skill_mgr then
    return
  end
  local def_lv = self.skill_mgr:get_armor_def_lv()
  if self:is_have_tough() then
    if def_lv > -1 then
      local down_lv = self:get_cur_tough_down_lv() * ToughDownChangeDefLevel
      return def_lv >= armor_atk_lv + down_lv
    else
      return false
    end
  else
    return armor_atk_lv <= def_lv
  end
end

function M:set_godmode(is_godmode, factor)
  if is_godmode then
    self.v_godmode:add(factor)
  else
    self.v_godmode:remove(factor)
  end
end

function M:is_godmode()
  return self.v_godmode:is_true()
end

function M:set_close_time_scale(is_close_time_scale)
  self.v_close_time_scale = is_close_time_scale
end

function M:is_close_time_scale()
  return self.v_close_time_scale
end

function M:get_real_radius()
  return 0
end

function M:get_real_height()
end

function M:get_diff_dir(another_obj, is_full_angel)
  local another_x, another_z = another_obj:get_pos2()
  return self:get_diff_pos_dir(another_x, another_z, is_full_angel)
end

function M:get_diff_pos_dir(another_x, another_z, is_full_angel)
  local self_x, self_z = self:get_pos2()
  local face_dir = Math.get_lookat_dir(self_x, self_z, another_x, another_z)
  local self_dir = self:get_dir()
  local diff_dir = math.floor(self_dir - face_dir) % 360
  diff_dir = math.min(diff_dir, 360 - diff_dir)
  if is_full_angel then
    if face_dir > self_dir then
      if face_dir - self_dir > 180 then
        diff_dir = 360 - diff_dir
      end
    elseif face_dir - self_dir > -180 then
      diff_dir = 360 - diff_dir
    end
  end
  return diff_dir
end

function M:is_char()
  return true
end

function M:set_speed_correct_param(param1, param2, param3, param4)
  self.v_speed_correct_param = self.v_speed_correct_param or {}
  self.v_speed_correct_param[1] = param1
  self.v_speed_correct_param[2] = param2
  self.v_speed_correct_param[3] = param3
  self.v_speed_correct_param[4] = param4
end

function M:is_hero_sub_char()
  if self.character_cfg.MasterNpcId then
    local master = SceneMgr:get_hero_by_id(self.character_cfg.MasterNpcId)
    return nil ~= master
  end
end

return M
