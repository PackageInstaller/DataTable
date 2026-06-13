local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill04 = {
    20107204,
    9,
    3,
    0,
    3,
    get_skill_cfg(20107204).CastTime,
    get_skill_cfg(20107204).AfterTime,
    1
  }
  self.skill03 = {
    20107203,
    6,
    3,
    0,
    3,
    get_skill_cfg(20107203).CastTime,
    get_skill_cfg(20107203).AfterTime,
    1
  }
  self.skill02 = {
    20107202,
    10,
    3,
    6,
    10,
    get_skill_cfg(20107202).CastTime,
    get_skill_cfg(20107202).AfterTime,
    1
  }
  self.skill01 = {
    20107201,
    8,
    3,
    6,
    10,
    get_skill_cfg(20107201).CastTime,
    get_skill_cfg(20107201).AfterTime,
    1
  }
  self.to_drink_skill = 20107205
  self.drink_skill = 20107206
  self.monster_type = 2
  self.wander = {
    3,
    5,
    3.5
  }
  self.wander_timer = 2
  self.wander_backrange = 1
  self.wander_backtimer = 0
  self.wander_state = 0
  self.control = 0
  self.stun_timer = 0
  self.insane_set = 0
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.drink_skill then
    abort_skill(self.npc, true)
    cast_magic(self.npc, self.npc, 20107203, 1)
    self.insane_set = 3
  end
end

function M:attack_done_bonus()
  if is_cast_skill_time(self.npc) then
    return
  end
  if 99 == self.control then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.stun_timer then
      self.control = 0
    end
  end
end

function M:insane_state()
  if not self.npc then
    return
  end
  if is_cast_skill_time(self.npc) and not check_magic(self.npc, 20107201) then
    return
  end
  local now_hp = get_npc_attr(self.npc, 1)
  local max_hp = get_npc_attr(self.npc, 4)
  if now_hp / max_hp <= 0.9 and 0 == self.insane_set then
    abort_skill(self.npc, true)
    lookat_position(self.npc, 0, 0, 1)
    cast_skill(self.npc, nil, self.to_drink_skill, 0, 0)
    self.insane_set = 1
    self.skill_set = 99
  elseif 1 == self.insane_set then
    local now_pos = get_npc_pos(self.npc)
    if now_pos.x <= 0.5 and now_pos.z <= 0.5 then
      abort_skill(self.npc, true)
      cast_skill(self.npc, self.npc, self.drink_skill)
      self.insane_set = 2
    end
  end
end

function M:skill_cast(skill_instant_id)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
  end
  if 3 == self.insane_set then
    if now_time < skill_instant_id[3] - 2 then
      return
    end
  elseif now_time < skill_instant_id[3] then
    return
  end
  if not check_npc_distance(self.npc, self.target, skill_instant_id[5], true) or not not check_npc_distance(self.npc, self.target, skill_instant_id[4], true) then
    return
  end
  abort_skill(self.npc, true)
  lookat_npc(self.npc, self.target)
  cast_skill(self.npc, self.target, skill_instant_id[1])
  skill_instant_id[3] = now_time + skill_instant_id[2] + math.random() * 2
  self.stun_timer = now_time + math.random() * 2 + 2
  self.skill_set_time = self.now_time + math.random(50, 90) / 10
  self.skill_set = 0
  self.control = 99
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if 0 ~= self.control then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if not check_npc_distance(self.npc, self.target, 6, true) then
    self.skill_set = math.random(1, 2)
    if 1 == self.skill_set then
      self:skill_cast(self.skill01)
    elseif 2 == self.skill_set then
      self:skill_cast(self.skill02)
    end
  else
    self.skill_set = math.random(3, 4)
    if 3 == self.skill_set then
      self:skill_cast(self.skill03)
    elseif 4 == self.skill_set then
      self:skill_cast(self.skill04)
    end
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
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
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
  if distance_max and not distance_min then
    self:move_normal_wander()
  elseif distance_min then
    self:move_leave_wander()
  elseif not distance_max then
    self:move_approch_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_frame()
  if check_magic(self.npc, 100174) then
    return
  end
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:skill_main_logic()
  self:insane_state()
  self:wander_main_logic()
  self:attack_done_bonus()
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 0)
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
