local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill02 = {
    2020350501,
    5,
    1,
    0,
    2,
    get_skill_cfg(2010350201).CastTime,
    get_skill_cfg(2010350201).AfterTime,
    0
  }
  self.skill01 = {
    2020350502,
    8,
    1,
    1.5,
    9,
    get_skill_cfg(2010350202).CastTime,
    get_skill_cfg(2010350202).AfterTime,
    0
  }
  self.monster_type = 2
  self.camp_skill_list = {
    self.skill01,
    self.skill02
  }
  self.control = 0
  self.infinting_timer = 0
  self.target = nil
  self.stun_timer = 0
  self.move_timer = 0
  self.counter_reatk_skill = self.skill02
  self.flash_skill_timer = 0
  self.born_state = 0
end

function M:born()
  if 0 == self.born_state then
    set_npc_controller(self.npc, 1)
    cast_magic(self.npc, self.npc, 20103502011, 0)
    cast_magic(self.npc, self.npc, 20103503014, 0)
    self.born_state = 1
  end
end

function M:skill_cast(skill_instant)
  local now_time = get_npc_time(self.npc)
  local ran_interval = math.random() * 2.5 + 1.5
  if CommonMonster.skill_cast_condition(self, skill_instant, now_time, get_npc_group_id(self.npc), self.monster_type, 1, ran_interval) then
    return false
  end
  if check_npc_distance(self.npc, self.target, skill_instant[5], false) and not check_npc_distance(self.npc, self.target, skill_instant[4], false) then
    cast_skill(self.npc, self.target, skill_instant[1])
    skill_instant[3] = now_time + skill_instant[2] + math.random(10, 30) / 10
    self.skill_set_time = self.now_time + math.random(50, 90) / 10
    self.skill_set = 0
  elseif check_npc_distance(self.npc, self.target, skill_instant[4], false) then
    if now_time > self.move_timer then
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
      self.move_timer = now_time + 1
    end
  elseif not check_npc_distance(self.npc, self.target, skill_instant[5], false) and now_time > self.move_timer then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    self.move_timer = now_time + 1
  end
  if 2010350202 == skill_instant[1] and not check_npc_distance(self.npc, self.target, skill_instant[5], false) then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, self.skill01[1])
    skill_instant[3] = now_time + skill_instant[2] + math.random(10, 30) / 10
    self.skill_set_time = self.now_time + math.random(50, 90) / 10
    self.skill_set = 0
  end
end

function M:skill_main_logic()
  if CommonMonster.skill_main_condition(self) then
    return
  end
  if get_target_angel(self.npc, self.target, true) <= -60 or get_target_angel(self.npc, self.target, true) >= 60 then
    return
  end
  if not self:skill_cast(self.skill02) then
    self:skill_cast(self.skill01)
  end
end

function M:on_frame()
  self:skill_main_logic()
  self:born()
  CommonMonster.wander_main_logic(self, 6, 8, 1)
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
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
