local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local npc_now_time = 0

function M:_init()
  Base._init(self)
  self.skill01 = {
    20103201,
    2,
    1,
    0,
    2,
    get_skill_cfg(20103201).CastTime,
    get_skill_cfg(20103201).AfterTime,
    self.skill02
  }
  self.wander = {1.5, 0.5}
  self.wander_timer = 3
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.walk_set = 0
  self.born_timer = 0.5
  self.hp_set = 0
end

function M:hurt()
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    return
  end
end

function M:cast_skill(skill_instant_ID)
  local cast_now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if cast_now_time < self.born_timer then
    stop_move(self.npc)
    return
  end
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if 0 ~= self.control then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], false) then
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if cast_now_time >= skill_instant_ID[3] then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill01[1])
    cast_magic(self.npc, self.npc, 100458, 1)
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
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

function M:wander_main_logic()
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.born_timer then
    stop_move(self.npc)
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 ~= self.control then
    return
  end
  if not check_npc_distance(self.npc, self.target, self.wander[1], true) then
    self:move_approch_wander()
  end
  if check_npc_distance(self.npc, self.target, self.wander[1], false) then
    stop_move(self.npc)
  end
end

function M:on_frame()
  if get_sync_var("in_daze") then
    self.control = 9
  end
  self:wander_main_logic()
  self:skill_main_logic()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:hurt()
  if 0 == self.hp_set then
    cast_magic(self.npc, self.npc, 100462, 1)
    self.hp_set = 1
  end
end

return M
