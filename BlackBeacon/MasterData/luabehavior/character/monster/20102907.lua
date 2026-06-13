local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    2010290101,
    7,
    1,
    0,
    3.5,
    get_skill_cfg(2010290101).CastTime,
    get_skill_cfg(2010290101).AfterTime,
    0
  }
  self.skill02 = {
    2010290102,
    7,
    1,
    0,
    3.5,
    get_skill_cfg(2010290102).CastTime,
    get_skill_cfg(2010290102).AfterTime,
    0
  }
  self.skill03 = {
    2010290103,
    10,
    1,
    3.5,
    7,
    get_skill_cfg(2010290103).CastTime,
    get_skill_cfg(2010290103).AfterTime,
    0
  }
  self.skill04 = {
    2010290104,
    10,
    1,
    0,
    7,
    get_skill_cfg(2010290104).CastTime,
    get_skill_cfg(2010290104).AfterTime,
    0
  }
  self.skill05 = {
    2010290105,
    10,
    1,
    0,
    7,
    get_skill_cfg(2010290105).CastTime,
    get_skill_cfg(2010290105).AfterTime,
    0
  }
  self.camp_skill_list = {
    self.skill01,
    self.skill02,
    self.skill03
  }
  self.counter_reatk_skill = self.skill01
  self.monster_type = 1
  self.wander = {
    1.5,
    3.5,
    1
  }
  self.wander_timer = 2
  self.control = 0
  self.target = nil
  self.stun_timer = 0
  self.move_timer = 0
  self.countinue = 0
  self.hit_random = 0
  self.jink_random = 0
  self.skill_set_time = 0
  self.strike_back = 0
  self.isHavingShield = false
  self.shieldCD = 30
  self.ShieldTimer = 0
  self.shieldType = 0
  self.shieldTypeforBreak = 0
end

function M:skill_main_logic()
  local now_time = get_npc_time(self.npc)
  local ran_interval = math.random() * 1.5 + 2
  if CommonMonster.skill_main_condition(self) then
    return
  end
  if CommonMonster.skill_cast_condition(self, nil, now_time, get_npc_group_id(self.npc), self.monster_type, 2, ran_interval) then
    return false
  end
  if not check_npc_distance(self.npc, self.target, self.skill01[4], false) and check_npc_distance(self.npc, self.target, self.skill01[5], false) and now_time >= self.skill01[3] then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, self.skill01[1])
    self.control = 99
    self.skill_set_time = now_time + 2
    self.skill01[3] = now_time + self.skill01[2]
  end
end

function M:move_normal_wander()
  self.wander_randomseed = math.random()
  if self.wander_randomseed >= 0.5 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
  else
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
  end
end

function M:move_leave_wander()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
  self.wander_timer = get_npc_time(self.npc) + 1
end

function M:move_approch_wander()
  if 1 == self.run then
    return
  end
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:run_approch_wander()
  switch_move_type(self.npc, 0)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if not check_activate(self.target) then
    return
  end
  if npc_time < self.wander_timer then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  local distance_maxx = check_npc_distance(self.npc, self.target, self.wander[2] + 3, true)
  if distance_max and not distance_min then
    self:move_normal_wander()
  elseif distance_min then
    self:move_leave_wander()
  elseif not distance_max and distance_maxx then
    self:move_approch_wander()
  elseif not distance_maxx then
    self:run_approch_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:attack_done_bonus()
  if is_cast_skill_time(self.npc) then
    return
  end
  if 99 == self.control then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.skill_set_time then
      self.control = 0
    end
  end
end

function M:on_frame()
  self:wander_main_logic()
  self:skill_main_logic()
  self:attack_done_bonus()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
