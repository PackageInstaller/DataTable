local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.TargetPos1X, self.TargetPos1Y, self.TargetPos1Z = get_area_pos("BB1")
  self.TargetPos2X, self.TargetPos2Y, self.TargetPos2Z = get_area_pos("BB2")
  self.TargetPos3X, self.TargetPos3Y, self.TargetPos3Z = get_area_pos("BB3")
  self.TargetPos4X, self.TargetPos4Y, self.TargetPos4Z = get_area_pos("BB4")
  self.TargetPos5X, self.TargetPos5Y, self.TargetPos5Z = get_area_pos("BB5")
  self.TargetPos6X, self.TargetPos6Y, self.TargetPos6Z = get_area_pos("BB6")
  self.TargetPos1 = {
    x = self.TargetPos1X,
    y = self.TargetPos1Y,
    z = self.TargetPos1Z
  }
  self.TargetPos2 = {
    x = self.TargetPos2X,
    y = self.TargetPos2Y,
    z = self.TargetPos2Z
  }
  self.TargetPos3 = {
    x = self.TargetPos3X,
    y = self.TargetPos3Y,
    z = self.TargetPos3Z
  }
  self.TargetPos4 = {
    x = self.TargetPos4X,
    y = self.TargetPos4Y,
    z = self.TargetPos4Z
  }
  self.TargetPos5 = {
    x = self.TargetPos5X,
    y = self.TargetPos5Y,
    z = self.TargetPos5Z
  }
  self.TargetPos6 = {
    x = self.TargetPos6X,
    y = self.TargetPos6Y,
    z = self.TargetPos6Z
  }
  self.FirstTimeEnter = true
  self.target = nil
  self.ArriveTargetPos1 = false
  self.ArriveTargetPos2 = false
  self.ArriveTargetPos3 = false
  self.ArriveTargetPos4 = false
  self.ArriveTargetPos5 = false
  self.ArriveTargetPos6 = false
  self.Skill01 = {
    30010031102,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(30010031102).CastTime,
    get_skill_cfg(30010031102).AfterTime
  }
  self.Skill02 = {
    30010031101,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(30010031102).CastTime,
    get_skill_cfg(30010031102).AfterTime
  }
  self.AllowRun = true
  self.DistanceMoreThan10 = true
  self.DistanceMoreThan15 = true
  self.DistanceMoreThan20 = true
  self.FirstTimeBB1 = true
  self.FirstTimeBB2 = true
  self.FirstTimeBB3 = true
  self.FirstTimeBB4 = true
  self.FirstTimeBB5 = true
  self.FirstTimeBB6 = true
  self.BeHitTime = 0
  self.BehitInterval = 2
end

function M:on_born_behavior()
  cast_magic(self.npc, self.npc, 30010050101, 1)
  cast_magic(self.npc, self.npc, 300100501012, 1)
  cast_magic(self.npc, self.npc, 300100501013, 1)
  cast_magic(self.npc, self.npc, 22010280, 1)
  set_npc_hp_visible(self.npc, false)
end

function M:CheckPlayerDistance()
  if check_npc_distance_to_pos(self.npc, self.TargetPos6.x, self.TargetPos6.z, 1, false) == false and self.AllowRun == true and false == self.ArriveTargetPos6 and true == self.ArriveTargetPos5 and true == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos6)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos5.x, self.TargetPos5.z, 1, false) and self.AllowRun == true and false == self.ArriveTargetPos5 and true == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos5)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos4.x, self.TargetPos4.z, 1, false) and self.AllowRun == true and false == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos4)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 1, false) and self.AllowRun == true and false == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos3)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 1, false) and self.AllowRun == true and false == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos2)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 1, false) and self.AllowRun == true and false == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos1)
    self.FirstTimeEnter = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 1, false) and true == self.FirstTimeBB1 then
    self.FirstTimeBB1 = false
    self.ArriveTargetPos1 = true
    self.AllowRun = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 1, false) and true == self.FirstTimeBB2 then
    self.FirstTimeBB2 = false
    self.ArriveTargetPos2 = true
    self.AllowRun = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 1, false) and true == self.FirstTimeBB3 then
    self.FirstTimeBB3 = false
    self.ArriveTargetPos3 = true
    self.AllowRun = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos4.x, self.TargetPos4.z, 1, false) and true == self.FirstTimeBB4 then
    self.FirstTimeBB4 = false
    self.ArriveTargetPos4 = true
    self.AllowRun = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos5.x, self.TargetPos5.z, 1, false) and true == self.FirstTimeBB5 then
    self.FirstTimeBB5 = false
    self.ArriveTargetPos5 = true
    self.AllowRun = true
  end
  if check_npc_distance_to_pos(self.npc, self.TargetPos6.x, self.TargetPos6.z, 1, false) == true and true == self.FirstTimeBB6 then
    self.FirstTimeBB6 = false
    self.ArriveTargetPos6 = true
    set_sync_var("BB5", true)
    self.AllowRun = true
  end
end

function M:on_target_self_skill_hit(skill_id, attacker, hit_type, missile_cfg, missile)
  self.BeHitTime = get_npc_time(self.npc)
end

function M:CheckCurrentStatus()
  if self.BeHitTime + self.BehitInterval > get_npc_time(self.npc) and self.FirstTimeEnter == true then
    self.FirstTimeEnter = false
    stop_move(self.npc)
    self.AllowRun = true
  end
  if search_npc(self.npc, 2, 8, nil, false, false, nil, 1) == nil and self.FirstTimeEnter == true then
    self.FirstTimeEnter = false
    stop_move(self.npc)
    play_DBM_ani(25)
    return
  end
  if search_npc(self.npc, 2, 3, nil, false, false, nil, 1) == nil then
    return
  end
  if true == check_npc_distance(self.npc, search_npc(self.npc, 2, 3, nil, false, false, nil, 1), 5, 1) then
    self.AllowRun = true
  end
end

function on_magic_end(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 20120302 == magic_id then
    self.AllowRun = true
  end
end

function M:on_frame()
  self:CheckCurrentStatus()
  self:CheckPlayerDistance()
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
end

return M
