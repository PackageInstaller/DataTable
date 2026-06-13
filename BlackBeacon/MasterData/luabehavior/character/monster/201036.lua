local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local npc_now_time = 0

function M:_init()
  Base._init(self)
  self.skill01 = {
    20103601,
    0.2,
    1,
    2,
    99,
    get_skill_cfg(20103601).CastTime,
    get_skill_cfg(20103601).AfterTime,
    0
  }
  self.wander = {
    2,
    6,
    0.5
  }
  self.wander_timer = 3
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.side_choice = 0
  self.stun_timer = 0
  self.cast_timer = 0
  self.walk_timer = 0
  self.walk_set = 0
  self.TEMP_POS = {}
end

function M:hurt()
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1
    self.control = 3
    return
  end
end

function M:attack_done_bonus()
  local now_time = get_npc_time(self.npc)
  if now_time >= self.stun_timer and 3 == self.control then
    self.control = 0
  end
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if not self.npc then
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
  if 0 == self.walk_set then
    local now_time = get_npc_time(self.npc)
    local now_pos = get_npc_pos(self.npc)
    local aim_pos_x = now_pos.x + 8
    self.TEMP_POS.x = aim_pos_x
    self.TEMP_POS.z = now_pos.z
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.walk_timer = now_time + 3
    self.walk_set = 1
  elseif 2 == self.walk_set then
    local now_time = get_npc_time(self.npc)
    local now_pos = get_npc_pos(self.npc)
    local aim_pos_x = now_pos.x - 8
    self.TEMP_POS.x = aim_pos_x
    self.TEMP_POS.z = now_pos.z
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.walk_timer = now_time + 3
    self.walk_set = 3
  end
end

function M:dir_change()
  local now_time = get_npc_time(self.npc)
  if 1 == self.walk_set and now_time >= self.walk_timer then
    self.walk_set = 2
  elseif 3 == self.walk_set and now_time >= self.walk_timer then
    self.walk_set = 0
  end
end

function M:on_frame()
  if get_sync_var("in_daze") then
    self.control = 9
  end
  local now_time = get_npc_time(self.npc)
  self:dir_change()
  self:wander_main_logic()
  self:attack_done_bonus()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:hurt()
  if now_time >= self.cast_timer then
    if check_npc_status(self.npc, 2) then
      self.cast_timer = now_time + 1.5
      return
    end
    cast_missile(self.npc, self.npc, nil, nil, 2010360101, 1)
    self.cast_timer = now_time + 0.7
  end
end

return M
