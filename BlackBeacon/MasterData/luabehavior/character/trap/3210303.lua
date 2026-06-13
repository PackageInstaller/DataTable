local M = Util.create_class()
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function M:_init(npc)
  enable_shadow(npc, false)
  set_can_searched(npc, false)
  set_npc_status(npc, 3, true)
  set_npc_status(npc, 1, true)
  self.skill_aim = 321030301
  self.skill_attack = 321030302
  self.missile_aim = 32103030101
  self.missile_aim_fx = 32103030102
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.missile_aim, self.on_find_targrt, self)
  self.rotate_angle = 45
  local status = pcall(get_sync_var, "rotate_angle")
  if status and get_sync_var("rotate_angle") then
    self.rotate_angle = get_sync_var("rotate_angle")
  end
  self.attack_time = get_skill_cfg(self.skill_attack).CastTime
  self.rotate_time = self.attack_time
  self.rotate_speed = 3.5 / self.rotate_time
  set_lock_velocity(npc, self.rotate_speed)
  self.first_pos = get_npc_offset_position(npc, nil, 0, 1)
  self.second_pos = get_npc_offset_position(npc, nil, self.rotate_angle, 1)
  self.control = 0
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.missile_aim, self)
end

function M:on_npc_born(npc)
  if npc == self.npc then
    lookat_position(self.npc, self.second_pos.x, self.second_pos.z, false)
    self.rotate_type = 1
    self.remain_time = self.rotate_time
    self.start_time = get_npc_time(self.npc)
    cast_missile(self.npc, self.npc, nil, nil, self.missile_aim, 1)
    cast_missile(self.npc, self.npc, nil, nil, self.missile_aim_fx, 1)
    self.control = 1
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break)
  if skill_id == self.skill_attack then
    self.start_time = get_npc_time(self.npc)
    cast_missile(self.npc, self.npc, nil, nil, self.missile_aim, 1)
    cast_missile(self.npc, self.npc, nil, nil, self.missile_aim_fx, 1)
    self.control = 3
  end
end

function M:on_find_targrt(owner, target_npc, missile_cfg, missile)
  if owner == self.npc and 5 ~= get_role_kind(target_npc) and 6 ~= get_role_kind(target_npc) then
    lookat_npc(self.npc, target_npc, false)
    local temp_remain_time = self.start_time + self.remain_time - get_npc_time(self.npc)
    self.remain_time = temp_remain_time
    remove_missile(missile)
    remove_missile_by_id(self.missile_aim_fx, self.npc)
    cast_skill(self.npc, nil, self.skill_attack)
    self.control = 2
  end
end

function M:on_frame()
  if 1 == self.control and get_npc_time(self.npc) >= self.start_time + self.remain_time then
    if 1 == self.rotate_type then
      self.rotate_type = 2
      lookat_position(self.npc, self.first_pos.x, self.first_pos.z, false)
      self.remain_time = self.rotate_time
      self.start_time = get_npc_time(self.npc)
    else
      self.rotate_type = 1
      lookat_position(self.npc, self.second_pos.x, self.second_pos.z, false)
      self.remain_time = self.rotate_time
      self.start_time = get_npc_time(self.npc)
    end
  end
  if 3 == self.control then
    if 1 == self.rotate_type then
      lookat_position(self.npc, self.second_pos.x, self.second_pos.z, false)
    else
      lookat_position(self.npc, self.first_pos.x, self.first_pos.z, false)
    end
    self.control = 1
  end
end

return M
