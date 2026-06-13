local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.Skill01 = {
    20100501,
    6,
    1,
    0,
    3,
    get_skill_cfg(20100501).CastTime,
    get_skill_cfg(20100501).AfterTime
  }
  self.Skill02 = {
    20100502,
    5,
    1,
    0,
    3,
    get_skill_cfg(20100502).CastTime,
    get_skill_cfg(20100502).AfterTime
  }
  self.Skill03 = {
    20100503,
    5,
    7,
    0,
    3,
    get_skill_cfg(20100503).CastTime,
    get_skill_cfg(20100503).AfterTime
  }
  self.Skill04 = {
    20100504,
    7,
    4,
    0,
    6,
    get_skill_cfg(20100504).CastTime,
    get_skill_cfg(20100504).AfterTime
  }
  self.Skill05 = {
    20100505,
    9,
    1,
    0,
    6,
    get_skill_cfg(20100505).CastTime,
    get_skill_cfg(20100505).AfterTime
  }
  self.target = nil
  self.wander = {
    3,
    5,
    1
  }
  self.wander_timer = 0
  self.wander_timer_skill_makeup = 0
  self.stun_timer = 0
end

function M:Get_Target()
  self.target = search_npc(self.npc, 4, 14, 0, 1)
end

function M:hurt()
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 0.2
    return
  end
end

function M:attack_done_bonus()
  local bonus_timer = self.wander_timer + 1
  if bonus_timer <= get_npc_time(self.npc) and 3 == self.control then
    self.control = 0
    self:wander_main_logic()
  end
end

function M:cast_skill(Skill_instant_ID)
  if not self.npc then
    return
  end
  local now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if now_time < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if not check_npc_status(self.npc, 0) then
    stop_move(self.npc)
    return
  end
  if check_npc_distance(self.npc, self.target, Skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, Skill_instant_ID[4], false) then
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if now_time > Skill_instant_ID[3] then
    cast_skill(self.npc, self.target, Skill_instant_ID[1])
    Skill_instant_ID[3] = get_time() + Skill_instant_ID[2]
  end
  self.control = 0
  self.wander_timer_skill_makeup = Skill_instant_ID[6] + Skill_instant_ID[7]
  self.control = 3
end

function M:Skill_main_logic()
  if not self.npc then
    return
  end
  if get_npc_time(self.npc) < self.wander_timer then
    return
  end
  if self:cast_skill(self.Skill04) then
    return
  end
  if check_npc_status(self.npc, 2) then
    stop_move(self.npc)
    return
  end
  if self:cast_skill(self.Skill03) then
    return
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
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:move_approch_wander2()
  switch_move_type(self.npc, 0)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if check_npc_status(self.npc, 2) then
    stop_move(self.npc)
    return
  end
  local npc_time = get_npc_time(self.npc)
  if npc_time < self.wander_timer then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  if distance_max and not distance_min then
    self:move_approch_wander()
  elseif not distance_max then
    self:move_approch_wander2()
  elseif distance_min then
    self:move_normal_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_frame()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:Skill_main_logic()
  self:wander_main_logic()
  self:hurt()
  self:attack_done_bonus()
  if not check_npc_status(self.npc, 0) then
    stop_move(self.npc)
    return
  end
end

return M
