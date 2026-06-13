local M = Util.create_class()
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function M:_init(npc)
  enable_shadow(npc, false)
  set_can_searched(npc, false)
  set_npc_status(npc, 3, true)
  set_npc_status(npc, 1, true)
  self.skill_aim = 321030201
  self.skill_attack = 321030202
  self.missile_aim = 32103020101
  self.missile_aim_fx = 32103020102
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.missile_aim, self.on_find_targrt, self)
  self.move_distance = 10
  local status = pcall(get_sync_var, "move_distance")
  if status and get_sync_var("move_distance") then
    self.move_distance = get_sync_var("move_distance")
  end
  self.attack_time = get_skill_cfg(self.skill_attack).CastTime
  self.move_time = self.attack_time
  self.move_speed = self.move_distance / self.move_time
  set_npc_speed_correct_param(npc, 0, self.move_speed, 0, 0)
  self.control = 0
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.missile_aim, self)
end

function M:on_npc_born(npc)
  if npc == self.npc then
    self.move_type = 4
    switch_move_type(self.npc, self.move_type)
    move_by_dir(self.npc)
    self.remain_time = self.move_time
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
    stop_move(self.npc)
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
    if 4 == self.move_type then
      self.move_type = 3
      switch_move_type(self.npc, self.move_type)
      move_by_dir(self.npc)
      self.remain_time = self.move_time
      self.start_time = get_npc_time(self.npc)
    else
      self.move_type = 4
      switch_move_type(self.npc, self.move_type)
      move_by_dir(self.npc)
      self.remain_time = self.move_time
      self.start_time = get_npc_time(self.npc)
    end
  end
  if 3 == self.control then
    move_by_dir(self.npc)
    self.control = 1
  end
end

return M
