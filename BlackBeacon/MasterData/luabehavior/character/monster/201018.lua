local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill02 = {
    20101002,
    3,
    1,
    0,
    3,
    get_skill_cfg(20101002).CastTime,
    get_skill_cfg(20101002).AfterTime,
    0
  }
  self.skill01 = {
    20101801,
    2.5,
    0.5,
    0,
    12,
    get_skill_cfg(20101801).CastTime,
    get_skill_cfg(20101801).AfterTime,
    0
  }
  self.monster_type = 1
  self.wander = {1.7, 0.5}
  self.wander_backrange = (math.random() + math.random(30, 40)) / 10
  self.wander_backtimer = 0
  self.wander_timer = 3
  self.wander_state = 0
  self.target = nil
  self.control = 0
  self.stun_timer = 0
  self.born_skill = 20100903
  self.hurt_reatk_skill = self.skill01
  self.hurt_check = 0
  self.hurt_check_timer = 0
  self.hurt_cnt_timer = 0
end

function M:cast_skill(skill_instant_id)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
  end
  if 0 == self.control then
  else
    return
  end
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and not check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    if get_npc_time(self.npc) >= skill_instant_id[3] then
      cast_skill(self.npc, self.target, skill_instant_id[1])
      skill_instant_id[3] = now_time + skill_instant_id[2] + math.random(10, 30) / 10
      self.skill_set_time = self.now_time + math.random() + math.random(30, 50) / 10
      self.skill_set = 0
    end
  elseif check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    switch_move_type(self.npc, 2)
    moveto_npc(self.npc, self.target)
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5], false) then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if not self:cast_skill(self.skill01) and check_npc_distance(self.npc, self.target, self.wander[1], true) then
    return
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:move_leave_wander()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1.5
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 ~= self.control then
    return
  end
  if not check_npc_distance(self.npc, self.target, self.wander[2], true) then
    self:move_approch_wander()
  elseif check_npc_distance(self.npc, self.target, self.wander[2], true) and not check_npc_distance(self.npc, self.target, self.wander[1], true) then
    stop_move(self.npc)
    lookat_npc(self.npc, self.target, 1)
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
  elseif check_npc_distance(self.npc, self.target, self.wander[1], false) then
    self:move_leave_wander()
  end
end

function M:on_frame()
  if 1 == self.skill_set and self.now_time >= self.skill01[3] then
    self:cast_skill(self.skill01)
  elseif 2 == self.skill_set and self.now_time >= self.skill02[3] then
    self:cast_skill(self.skill02)
  end
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.camp_main_logic(self)
  CommonMonster.attack_wander_logic(self, self.skill01, self.skill02)
  CommonMonster.skill_change_logic(self)
  CommonMonster.Hit_wall(self)
end

return M
