local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.target = nil
  self.wander_timer = 0
  self.wander_timer_skill_makeup = 0
end

function M:Get_Target()
  self.target = search_npc(self.npc, 4, 14, 0, 1)
end

function M:cast_skill(Skill_instant_ID)
  local Nowtime = get_time()
  if not self.target then
    return
  end
  if not check_npc_status(self.npc, 0) then
    return
  end
  if check_npc_distance(self.npc, self.target, Skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, Skill_instant_ID[4], false) then
  else
    return
  end
  if Nowtime > Skill_instant_ID[3] then
    cast_skill(self.npc, self.target, Skill_instant_ID[1])
    Skill_instant_ID[3] = get_time() + Skill_instant_ID[2]
  end
  self.control = 0
  self.wander_timer_skill_makeup = Skill_instant_ID[6] + Skill_instant_ID[7]
end

function M:Skill_main_logic()
  if get_time() < self.wander_timer then
    return
  end
end

function M:Move_main_logic()
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  if not check_npc_distance(self.npc, self.target, 7, false) then
    switch_move_type(self.npc, 0)
    moveto_npc(self.npc, self.target)
  end
  if check_npc_distance(self.npc, self.target, 4, false) and not check_npc_distance(self.npc, self.target, 3.5, false) then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  end
  if check_npc_distance(self.npc, self.target, 2.8, false) then
    stop_move(self.npc)
    lookat_npc(self.npc, self.target, true)
  end
  if get_time() < self.wander_timer then
    return
  end
  self.control = 1
  self.wander_timer = get_time() + 1.2 + self.wander_timer_skill_makeup
end

function M:on_frame()
  self:Get_Target()
  self:Move_main_logic()
end

function M:on_skill()
end

function M:on_behit()
end

return M
