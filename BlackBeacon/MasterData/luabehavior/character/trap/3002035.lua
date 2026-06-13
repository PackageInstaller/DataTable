local M = Util.create_class()

function M:_init(npc)
  self.skill01 = {
    300100101,
    1.5,
    0,
    0,
    0,
    get_skill_cfg(300100101).CastTime,
    get_skill_cfg(300100101).AfterTime
  }
  self.skill02 = {
    300100102,
    9999,
    0,
    0,
    0,
    get_skill_cfg(300100102).CastTime,
    get_skill_cfg(300100102).AfterTime
  }
  self.control = 0
  set_can_searched(npc, false)
  enable_shadow(npc, false)
end

function M:skill_logic(skill_instant_ID)
  if skill_instant_ID == self.skill01 and 1 ~= self.control then
    return
  end
  if get_npc_time(self.npc) > skill_instant_ID[3] then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
  end
end

function M:on_frame()
  self:skill_logic(self.skill01)
  self:skill_logic(self.skill02)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if npc == self.npc and 9 ~= self.control and 300100102 == skill_id then
    self.control = 1
  end
end

function M:on_skill_end(npc, skill_id)
  if 300100101 == skill_id then
    self.skill02[3] = get_npc_time(self.npc) + self.skill01[2]
    self.control = 0
  end
end

return M
