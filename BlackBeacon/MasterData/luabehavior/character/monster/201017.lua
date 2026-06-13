local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill03 = {
    20101703,
    5,
    1,
    0,
    3,
    get_skill_cfg(20101703).CastTime,
    get_skill_cfg(20101703).AfterTime,
    0
  }
  self.skill02 = {
    20101702,
    3,
    1,
    0,
    3,
    get_skill_cfg(20101702).CastTime,
    get_skill_cfg(20101702).AfterTime,
    0
  }
  self.skill01 = {
    20101701,
    10,
    1,
    0,
    7,
    get_skill_cfg(20101701).CastTime,
    get_skill_cfg(20101701).AfterTime,
    self.skill02
  }
  self.monster_type = 2
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

function M:on_start()
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

function M:on_skill_begin(npc, skill_id, skill_type)
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
      self.skill01[4] = math.random(5, 6)
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
  local dis3 = check_npc_distance(self.npc, self.target, self.skill03[5], true)
  local nowTime = get_npc_time(self.npc)
  if dis3 and nowTime > self.near_attack_time then
    stop_move(self.npc)
    self:Relese_skill(self.skill03)
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

function M:on_skill_end(npc, skill_id)
  if npc == self.npc and skill_id == self.skill01[1] then
    cast_skill(self.npc, self.target, self.skill02[1])
  end
  if npc == self.npc and skill_id == self.skill02[1] then
    if self.target then
      lookat_npc(self.npc, self.target)
    else
      return
    end
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
  if 1 == self.skill_set and self.now_time >= self.skill01[3] then
    self:cast_skill(self.skill01)
  elseif 2 == self.skill_set and self.now_time >= self.skill02[3] then
    if check_npc_distance(self.npc, self.target, 5, false) then
      self:cast_skill(self.skill03)
    else
      self.skill_set = 1
    end
  end
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.camp_main_logic(self)
  CommonMonster.attack_wander_logic(self, self.skill01, self.skill02)
  CommonMonster.skill_change_logic(self)
  CommonMonster.Hit_wall(self)
end

return M
