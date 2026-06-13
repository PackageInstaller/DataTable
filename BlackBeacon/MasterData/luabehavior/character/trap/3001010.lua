local M = Util.create_class()

function M:_init()
  self.control = nil
  self.boom_timer = 0
  self.skill01 = {
    300101001,
    5,
    0,
    0,
    0,
    get_skill_cfg(300101001).CastTime,
    get_skill_cfg(300101001).AfterTime
  }
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg)
  if npc == self.npc then
    return
  end
  local angle_now = get_target_angel(self.npc, npc, true)
  if hit_target == self.npc then
    if angle_now > -45 or angle_now < 45 then
      self.control = 0
    end
    if angle_now >= 45 and angle_now < 135 then
      self.control = 1
    end
    if angle_now >= 135 or angle_now <= -135 then
      self.control = 2
    end
    if angle_now <= -45 and angle_now > -135 then
      self.control = 3
    end
  end
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  if is_pass_room() and not get_sync_var("trap_switch_on") then
    abort_skill(self.npc)
    self.control = 9
  end
  if now_time >= self.boom_timer + 1.5 and 5 == self.control then
    stop_move(self.npc)
    self.boom_timer = now_time
    self.control = 6
    cast_skill(self.npc, nil, self.skill01[1], nil, nil)
    cast_magic(self.npc, self.npc, 399933, 1)
    cast_magic(self.npc, self.npc, 4010005, 1)
  end
  if now_time >= self.boom_timer + 1 and 6 == self.control then
    remove_npc(self.npc)
  end
  if 0 == self.control then
    switch_move_type(self.npc, 2)
    move_by_dir(self.npc)
    self.boom_timer = get_npc_time(self.npc)
    self.control = 5
  end
  if 1 == self.control then
    switch_move_type(self.npc, 3)
    move_by_dir(self.npc)
    self.boom_timer = get_npc_time(self.npc)
    self.control = 5
  end
  if 2 == self.control then
    switch_move_type(self.npc, 1)
    move_by_dir(self.npc)
    self.boom_timer = get_npc_time(self.npc)
    self.control = 5
  end
  if 3 == self.control then
    switch_move_type(self.npc, 4)
    move_by_dir(self.npc)
    self.boom_timer = get_npc_time(self.npc)
    self.control = 5
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

return M
