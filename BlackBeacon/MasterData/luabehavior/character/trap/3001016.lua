local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300101601,
    13,
    9,
    0,
    10,
    get_skill_cfg(300101601).CastTime,
    get_skill_cfg(300101601).AfterTime,
    0
  }
  self.control = nil
  self.target = nil
  self.splash_timer = nil
end

function M:cast_skill(skill_instant_ID)
  if 300101601 == skill_instant_ID[1] and self.target then
    cast_skill(self.npc, self.target, skill_instant_ID[1], nil, nil)
    self.splash_timer = get_npc_time(self.npc) + 8
    self.control = 3
  end
end

function M:search_target()
  if not check_magic(self.npc, 4010172) then
    self.target = search_npc(self.npc, 7, 10, nil, 1)
  end
end

function M:control_set()
  if 0 == self.control then
    self:cast_skill(self.skill01)
  end
end

function M:on_frame()
  self:control_set()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
  end
  if 3 == self.control and get_npc_time(self.npc) > self.splash_timer then
    self.control = nil
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

return M
