local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    20107701,
    8,
    3,
    0,
    3,
    get_skill_cfg(20107701).CastTime,
    get_skill_cfg(20107701).AfterTime,
    1
  }
  self.skill02 = {
    20107701,
    8,
    3,
    0,
    3,
    get_skill_cfg(20107701).CastTime,
    get_skill_cfg(20107701).AfterTime,
    1
  }
  self.control = 0
  self.jinking = 0
  self.jinking_skill = 20107702
  self.jinking_skill_timer = 0
  self.monster_type = 1
  self.target = nil
  self.move_timer = 0
end

function M:on_input(input_id)
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if not check_npc_distance(self.npc, self.target, 3, false) then
    return
  end
  if 15 == input_id then
    self.jinking = math.random(1, 2)
    if 1 == self.jinking and get_npc_time(self.npc) >= self.jinking_skill_timer then
      abort_skill(self.npc)
      cast_skill(self.npc, self.npc, self.jinking_skill)
      self.jinking_skill_timer = get_npc_time(self.npc) + 5
    end
  elseif 15 ~= input_id then
    return
  end
end

function M:logic(skill_instant_id)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.control = 0
    return
  end
  if 0 ~= self.control then
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
  if is_cast_skill_time(self.npc) then
    return
  end
  if self.now_time < skill_instant_id[3] then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and not check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    cast_skill(self.npc, self.target, skill_instant_id[1])
    skill_instant_id[3] = now_time + skill_instant_id[2] + math.random(10, 30) / 10
    self.skill_set_time = self.now_time + math.random(50, 90) / 10
    self.skill_set = 0
  elseif check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    if now_time > self.move_timer then
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
      self.move_timer = now_time + 1
    end
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and now_time > self.move_timer then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    self.move_timer = now_time + 1
  end
end

function M:skill_main_logic()
  if self.target and 0 == self.control and not check_npc_status(self.npc, 2) and not is_cast_skill_time(self.npc) and not self.hurt_atk_state then
  else
    return
  end
  if 1 == self.skill_set then
    self:logic(self.skill01)
  elseif 2 == self.skill_set then
    self:logic(self.skill02)
  end
end

function M:on_frame()
  self:skill_main_logic()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.camp_main_logic(self)
  CommonMonster.attack_wander_logic(self, self.skill01, self.skill02)
  CommonMonster.skill_change_logic(self)
  CommonMonster.Hit_wall(self)
  CommonMonster.monster_on_frame(self)
  CommonMonster.platform_move(self)
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
  end
end

return M
