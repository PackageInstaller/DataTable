local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300104501,
    3,
    0,
    0,
    0,
    get_skill_cfg(300104501).CastTime,
    get_skill_cfg(300104501).AfterTime
  }
  self.skill02 = {
    300104502,
    5,
    0,
    0,
    0,
    get_skill_cfg(300104502).CastTime,
    get_skill_cfg(300104502).AfterTime
  }
  self.control = nil
  self.target = nil
  self.splash_timer = nil
end

function M:skill_logic()
  if 0 == self.control then
    cast_skill(self.npc, self.target, 300104501, nil, nil)
    self.splash_timer = get_npc_time(self.npc) + 0.75
    self.control = 3
  end
  if 1 == self.control then
    cast_skill(self.npc, self.target, 300104502, nil, nil)
    self.splash_timer = get_npc_time(self.npc) + 6
    self.control = 4
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 6, nil, 1)
end

function M:on_frame()
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  self:skill_logic()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
  end
  if 3 == self.control and get_npc_time(self.npc) > self.splash_timer then
    self.control = 1
  end
  if 4 == self.control and get_npc_time(self.npc) > self.splash_timer then
    self.control = nil
  end
end

return M
