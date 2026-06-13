local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill02 = {
    20101202,
    4,
    1,
    0,
    3,
    get_skill_cfg(20101202).CastTime,
    get_skill_cfg(20101202).AfterTime,
    0
  }
  self.skill01 = {
    20101201,
    5,
    1,
    3.5,
    8,
    get_skill_cfg(20101201).CastTime,
    get_skill_cfg(20101201).AfterTime,
    0
  }
  self.Entter_Attack_Range = 9
  self.stun_timer = 0
  self.born_skill = 20100903
  self.control = 0
  self.wander_time = 0
  self.near_attack_time = 0
  self.hitwall = false
  self.hitwall_pos = {}
end

function M:on_start()
  self.skill01[4] = math.random(4, 6)
end

function M:Relese_skill(Skill_ID)
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    return
  end
  if check_npc_distance(self.npc, self.target, Skill_ID[5], true) and not check_npc_distance(self.npc, self.target, Skill_ID[4], true) then
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if get_npc_time(self.npc) >= Skill_ID[3] then
    stop_move(self.npc)
    cast_skill(self.npc, self.target, Skill_ID[1])
    Skill_ID[3] = get_npc_time(self.npc) + Skill_ID[2]
    self.stun_timer = get_npc_time(self.npc) + 1.5
    if Skill_ID == self.skill01 then
      self.skill01[4] = math.random(4, 6)
    end
  elseif get_npc_time(self.npc) < Skill_ID[3] then
    self:Wandering()
  end
end

function M:Enter_Attack()
  if not self.target then
    return
  end
  local dis1 = check_npc_distance(self.npc, self.target, self.skill01[4], true)
  local dis2 = check_npc_distance(self.npc, self.target, self.skill01[5], true)
  if 1 == self.control then
  else
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 0.5
    self.skill_number = math.random(1, 2)
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    return
  end
  if get_npc_time(self.npc) < self.wander_time then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if not dis2 then
    self:Move()
  elseif dis2 and not dis1 then
    stop_move(self.npc)
    lookat_npc(self.npc, self.target, 1)
    self:Relese_skill(self.skill01)
  elseif dis1 then
    self:Back()
  end
end

function M:Move()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:Wandering()
  self.wander_randomseed = math.random()
  if self.wander_randomseed > 0.5 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  elseif self.wander_randomseed < 0.5 then
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  end
end

function M:Back()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
  local dis3 = check_npc_distance(self.npc, self.target, self.skill02[5], true)
  local nowTime = get_npc_time(self.npc)
  if dis3 and nowTime > self.near_attack_time then
    stop_move(self.npc)
    lookat_npc(self.npc, self.target, 1)
    self:Relese_skill(self.skill02)
    self.near_attack_time = get_npc_time(self.npc) + 6
  end
end

function M:Move_To_Target()
  if not self.target then
    return
  end
  local dis6 = check_npc_distance(self.npc, self.target, self.Entter_Attack_Range, true)
  if not dis6 then
    self.control = 0
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 ~= self.control then
    return
  end
  if not dis6 then
    self:Move()
  elseif dis6 then
    lookat_npc(self.npc, self.target)
    stop_move(self.npc)
    self.control = 1
  end
end

function M:Hit_wall()
  if not self.target then
    return
  end
  if 2 ~= self.control then
    return
  end
  if check_npc_status(self.npc, 2) then
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1
    self.hitwall = true
    return
  end
  if self.hitwall and get_npc_time(self.npc) >= self.stun_timer then
    self.hitwall_pos = get_npc_offset_position(self.npc, get_npc_pos(self.target), 30, 5)
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.hitwall_pos)
    self.hitwall = false
  end
  if not self.hitwall and check_npc_distance_to_pos(self.npc, self.hitwall_pos.x, self.hitwall_pos.z, 1, true) then
    self.control = 1
    self.hitwall = false
  end
end

function M:check_wall_dis()
  if not self.target then
    return
  end
  if get_npc_distance(self.npc, 3, 3) <= 2 or get_npc_distance(self.npc, 3, 1) <= 2 then
    self.hitwall = true
    self.control = 2
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.remove_timer(self)
  self:Move_To_Target()
  self:Enter_Attack()
  self:check_wall_dis()
  self:Hit_wall()
end

return M
