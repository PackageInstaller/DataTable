local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill08 = {
    20103808,
    0,
    0,
    0,
    10,
    get_skill_cfg(20103808).CastTime,
    get_skill_cfg(20103808).AfterTime,
    0
  }
  self.skill07 = {
    20103807,
    0,
    0,
    0,
    10,
    get_skill_cfg(20103807).CastTime,
    get_skill_cfg(20103807).AfterTime,
    self.skill08
  }
  self.skill06 = {
    20103806,
    0,
    2,
    0,
    8,
    get_skill_cfg(20103806).CastTime,
    get_skill_cfg(20103806).AfterTime,
    self.skill07
  }
  self.skill05 = {
    20103805,
    0,
    0,
    0,
    10,
    get_skill_cfg(20103805).CastTime,
    get_skill_cfg(20103805).AfterTime,
    0
  }
  self.skill04 = {
    20103804,
    0,
    0,
    0,
    10,
    get_skill_cfg(20103804).CastTime,
    get_skill_cfg(20103804).AfterTime,
    self.skill05
  }
  self.skill03 = {
    20103803,
    1,
    2,
    0,
    10,
    get_skill_cfg(20103803).CastTime,
    get_skill_cfg(20103803).AfterTime,
    self.skill04
  }
  self.skill02 = {
    20103802,
    6,
    2,
    4.5,
    11,
    get_skill_cfg(20103802).CastTime,
    get_skill_cfg(20103802).AfterTime,
    0
  }
  self.skill01 = {
    20103801,
    5.5,
    1,
    0,
    4.5,
    get_skill_cfg(20103801).CastTime,
    get_skill_cfg(20103801).AfterTime,
    0
  }
  self.wander = {4.5, 1}
  self.wander_timer = 3
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.stun_timer = 0
  self.supa_set = 0
  self.max_supa = nil
  self.skill3_set = 0
  self.skill_set = 0
  self.npc_now_time = 0
  self.loop_set = 0
  self.spawn = 0
  self.fx_set = 0
  self.bounce_set = 0
end

function M:hurt()
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    return
  end
end

function M:spawn_skill()
  if 0 == self.control or 6 == self.control then
  else
    return
  end
  if (get_target_angel(self.npc, self.target, false) > 60 or get_target_angel(self.npc, self.target, false) < -60) and 0 == self.turn_switch then
    self.turn_switch = 1
    cast_skill(self.npc, self.target, 20103809, nil, nil)
  end
  if 0 == self.spawn then
    set_lock_velocity(self.npc, 2)
    self.spawn = 1
  end
end

function M:cast_skill(skill_instant_ID)
  if 0 ~= self.control then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], true) then
  else
    return
  end
  if 20103803 == skill_instant_ID[1] or 20103806 == skill_instant_ID[1] then
  elseif get_npc_time(self.npc) < self.stun_timer then
    return
  elseif not (get_target_angel(self.npc, self.target, true) > 30 or get_target_angel(self.npc, self.target, true) < -30) or check_npc_distance(self.npc, self.target, self.wander[1], false) then
  else
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    return
  end
  if get_npc_time(self.npc) >= skill_instant_ID[3] then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
    if 20103801 == skill_instant_ID[1] and 0 == self.skill3_set then
      self.control = 6
      self.stun_timer = get_npc_time(self.npc) + 3.2
    elseif 20103802 == skill_instant_ID[1] and 0 == self.skill3_set then
      self.control = 6
      self.stun_timer = get_npc_time(self.npc) + 3.4
    end
    if 20103803 == skill_instant_ID[1] and skill_instant_ID[8] then
      local now_time = get_npc_time(self.npc)
      if not check_magic(self.npc, 100454) then
        cast_magic(self.npc, self.npc, 100453, 1)
      end
      self.skill3_set = 1
      self.npc_now_time = now_time + 0.8
      self.control = 2
    elseif 20103806 == skill_instant_ID[1] and skill_instant_ID[8] then
      local now_time = get_npc_time(self.npc)
      cast_magic(self.npc, self.npc, 100456, 1)
      cast_magic(self.npc, self.npc, 100457, 1)
      if check_magic(self.npc, 100453) then
        abort_magic_by_id(self.npc, 100453)
        abort_magic_by_id(self.npc, 100454)
        abort_magic_by_id(self.npc, 100455)
        abort_magic_by_id(self.npc, 100459)
        abort_magic_by_id(self.npc, 100460)
      end
      self.npc_now_time = now_time + 0.8
      self.control = 4
    end
  else
    return
  end
end

function M:loop_skill()
  local now_time = get_npc_time(self.npc)
  if 2 == self.control and now_time >= self.npc_now_time then
    local now_time = get_npc_time(self.npc)
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill04[1])
    if not check_magic(self.npc, 100454) then
      cast_magic(self.npc, self.npc, 100454, 1)
    end
    if now_time >= self.npc_now_time + 2 and 0 == self.fx_set then
      cast_magic(self.npc, self.npc, 100459, 1)
      self.fx_set = 1
      self.npc_now_time = now_time
    end
    if now_time >= self.npc_now_time + 2 and 1 == self.fx_set then
      cast_magic(self.npc, self.npc, 100460, 1)
      self.fx_set = 2
      self.npc_now_time = now_time
    end
    self.wander_timer_skill_makeup = self.skill04[6] + self.skill04[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    if now_time >= self.npc_now_time + 2.5 then
      self.npc_now_time = now_time
      self.control = 3
    end
  end
  if 4 == self.control and now_time >= self.npc_now_time then
    local now_time = get_npc_time(self.npc)
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill07[1])
    self.wander_timer_skill_makeup = self.skill07[6] + self.skill07[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    if now_time >= self.npc_now_time + 5 then
      self.npc_now_time = now_time
      self.control = 5
    end
  end
end

function M:last_skill()
  local now_time = get_npc_time(self.npc)
  if 3 == self.control then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill05[1])
    cast_magic(self.npc, self.npc, 100455, 1)
    self.wander_timer_skill_makeup = self.skill05[6] + self.skill05[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 3
    self.npc_now_time = now_time
    self.control = 6
    self.skill_set = 0
    self.skill3_set = 2
  end
  if 5 == self.control and now_time >= self.npc_now_time then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill08[1])
    self.wander_timer_skill_makeup = self.skill08[6] + self.skill08[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 3
    self.control = 6
    self.skill_set = 0
  end
end

function M:attack_done_bonus()
  local now_time = get_npc_time(self.npc)
  if not self.target then
    self.control = 0
    return
  end
  if check_npc_status(self.target, 2) then
    self.stun_timer = get_npc_time(self.npc) + 0.5
    return
  end
  if now_time >= self.stun_timer and 6 == self.control then
    self.control = 0
  else
  end
end

function M:on_superarmor_break(npc, camp)
  if 1 == self.skill3_set then
    abort_skill(self.npc)
    self.skill_set = 1
    self.control = 0
    self:cast_skill(self.skill06)
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 20103801 == skill_id or 20103802 == skill_id then
    self.control = 0
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 20103801 == skill_id or 20103802 == skill_id or 20103805 == skill_id or 20103808 == skill_id then
    self.stun_timer = get_npc_time(self.npc) + 2
    self.turn_switch = 0
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner ~= self.npc then
    return
  end
  if m1_cfg.Id == 2010381001 and m2_owner ~= self.npc and 2 == m2_cfg.MissileTypeTag then
    rebound_missile(m2, m1_owner, m2_owner, nil, nil, 50)
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  local now_supa = get_npc_attr(self.npc, 69)
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.target, 2) then
    return
  end
  if now_supa / self.max_supa <= 0.5 and 0 == self.skill3_set then
    abort_skill(self.npc)
    self.skill_set = 1
    self:cast_skill(self.skill03)
  end
  if 0 ~= self.control then
    return
  end
  if 1 == self.skill_set then
    return
  elseif not self:cast_skill(self.skill02) and not self:cast_skill(self.skill01) and check_npc_distance(self.npc, self.target, self.wander[1], true) then
    return
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if 0 ~= self.control then
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    return
  end
  if 1 == self.skill_set then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if get_npc_time(self.npc) < self.wander_timer then
    return
  end
  if not check_npc_distance(self.npc, self.target, self.wander[1], true) then
    self:move_approch_wander()
  end
  if check_npc_distance(self.npc, self.target, self.wander[1], false) then
    stop_move(self.npc)
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
  end
end

function M:on_frame()
  if get_sync_var("in_daze") then
    self.control = 9
  end
  self:wander_main_logic()
  self:skill_main_logic()
  self:loop_skill()
  self:last_skill()
  self:attack_done_bonus()
  self:spawn_skill()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:hurt()
  if 0 == self.supa_set then
    self.max_supa = get_npc_attr(self.npc, 69)
    self.supa_set = 1
  end
  if 0 == self.bounce_set then
    cast_magic(self.npc, self.npc, 100471, 1)
    cast_missile(self.npc, self.npc, nil, nil, 2010381001, 1)
    self.bounce_set = 1
  end
  if not check_magic(self.npc, 100471) and 1 == self.bounce_set then
    self.bounce_set = 0
  end
end

return M
