local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.target = nil
  self.stun_timer = 0
  self.control = 0
  self.wander = {
    3,
    10,
    1
  }
  self.wander_timer = 2
  self.monster_type = 1
  self.camp_skill_list = {}
  self.targetPos1 = nil
  self.targetPos2 = nil
  self.targetPos3 = nil
  self.heroAtTimePos = {
    x = 0,
    y = 0,
    z = 0
  }
end

function M:on_start()
  if get_area_pos("BB1") ~= nil then
    self.targetPos1 = get_area_pos("BB1")
    self.targetPos = {
      x = self.targetPos1.X,
      y = 20,
      z = self.targetPos1.Z
    }
  end
end

function M:cast_skill(skill_instant_ID)
  local ran_interval = math.random() * 1.5 + 2
  local now_time = get_npc_time(self.npc)
  if CommonMonster.skill_cast_condition(self, skill_instant_ID, now_time, get_npc_group_id(self.npc), self.monster_type, 1, ran_interval) then
    return false
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
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
  else
    return
  end
  if get_target_angel(self.npc, self.target, true) <= -60 or get_target_angel(self.npc, self.target, true) >= 60 then
    return
  end
  if get_npc_time(self.npc) >= skill_instant_ID[3] then
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
    self.stun_timer = get_npc_time(self.npc) + 1.5
  end
end

function M:skill_main_logic()
  if not self.target then
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
end

function M:look_at()
  if not self.target then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 11) then
    return
  end
  if not is_cast_skill_time(self.npc) then
    lookat_npc(self.npc, self.target, false)
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

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  move_to_pos(self.npc, self.targetPos)
end

function M:run_approch_wander()
  switch_move_type(self.npc, 0)
  move_to_pos(self.npc, self.targetPos)
end

function M:move_away_wander()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.targetPos then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if npc_time < self.wander_timer then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if 9 == self.control then
    return
  end
  if not check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 1, true) then
    if get_come_on_hero() ~= nil then
      if check_npc_distance(self.npc, get_come_on_hero(), 4, true) then
        self:run_approch_wander()
        cast_magic(self.npc, self.npc, 20104201030, 1)
      elseif not check_npc_distance(self.npc, get_come_on_hero(), 10, true) then
        self:move_approch_wander()
        abort_magic_by_id(self.npc, 20104201030, 1)
      else
        self:move_approch_wander()
        abort_magic_by_id(self.npc, 20104201030, 1)
      end
    else
      self:move_approch_wander()
    end
  elseif check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 1, true) then
    if self.targetPos.x == self.targetPos1.X then
      if nil ~= get_area_pos("BB2") then
        self.targetPos2 = get_area_pos("BB2")
        self.targetPos = {
          x = self.targetPos2.X,
          y = 20,
          z = self.targetPos2.Z
        }
      end
    elseif self.targetPos.x == self.targetPos2.X then
      if nil ~= get_area_pos("BB3") then
        self.targetPos3 = get_area_pos("BB3")
        self.targetPos = {
          x = self.targetPos3.X,
          y = 20,
          z = self.targetPos3.Z
        }
      end
    else
      stop_move(self.npc)
    end
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_frame()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
  self:wander_main_logic()
end

return M
