local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.target = nil
  self.targetPos = {
    x = 0,
    y = 0,
    z = 0
  }
  self.stun_timer = 0
  self.escapeTimer = 0
  self.control = 0
  self.wander = {6, 0.5}
  self.wander_timer = 3
  self.heroAtTime = nil
  self.skill01 = {
    20109901,
    0,
    1,
    0,
    9,
    get_skill_cfg(20109901).CastTime,
    get_skill_cfg(20109901).AfterTime
  }
  if get_cur_room_id() == 102203 then
    self.targetPos = {
      x = 151,
      y = -10,
      z = 0
    }
  end
  if get_cur_room_id() == 102204 then
    self.targetPos = {
      x = 188.94,
      y = -25,
      z = 36.9
    }
  end
  if get_cur_room_id() == 102205 then
    self.targetPos = {
      x = 189.0503,
      y = 0.4,
      z = 78.81
    }
  end
end

function M:cast_skill(skill_instant_ID)
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if 1 == self.escapeTimer then
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
  if check_npc_distance(self.npc, self.target, self.wander[1], true) then
    if not self:cast_skill(self.skill01) then
      return
    end
  else
    abort_skill(self.npc)
  end
  if not self:cast_skill(self.skill01) then
    return
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  if get_cur_room_id() == 102203 then
    move_to_pos(self.npc, self.targetPos)
  else
    self.heroAtTime = get_come_on_hero()
    if check_npc_distance(self.npc, self.heroAtTime, 5, true) then
      move_to_pos(self.npc, self.targetPos)
    else
      stop_move(self.npc)
    end
  end
end

function M:wander_main_logic()
  if not self.targetPos then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1.5
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if 0 ~= self.control then
    return
  end
  if not check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 1, true) then
    self:move_approch_wander()
  elseif check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 1, true) then
    stop_move(self.npc)
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
    if check_npc_status(self.npc, 1) then
      return
    end
  end
end

function M:on_frame()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
  self:skill_main_logic()
  if check_npc_status(self.npc, 1) then
    return
  end
  if check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 1, true) then
    return
  end
  self:wander_main_logic()
end

return M
