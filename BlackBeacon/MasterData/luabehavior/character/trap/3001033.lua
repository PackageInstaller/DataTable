local M = Util.create_class()

function M:_init()
  self.skill03 = {
    300103303,
    0,
    0,
    0,
    0,
    get_skill_cfg(300103303).CastTime,
    get_skill_cfg(300103303).AfterTime
  }
  self.skill02 = {
    300103302,
    0,
    0,
    0,
    0,
    get_skill_cfg(300103302).CastTime,
    get_skill_cfg(300103302).AfterTime
  }
  self.skill01 = {
    300103301,
    0,
    0,
    0,
    0,
    get_skill_cfg(300103301).CastTime,
    get_skill_cfg(300103301).AfterTime
  }
  self.control = nil
  self.boom_timer = nil
  self.check_set = false
end

function M:cast_skill(skill_instant_ID)
  if 300103301 == skill_instant_ID[1] then
    cast_skill(self.npc, self.npc, skill_instant_ID[1], nil, nil)
  end
  if 300103302 == skill_instant_ID[1] then
    abort_skill(self.npc, true)
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.boom_timer = get_npc_time(self.npc) + 0.8
    self.control = 3
  end
  if 300103303 == skill_instant_ID[1] then
    abort_skill(self.npc, true)
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.boom_timer = get_npc_time(self.npc) + 3
    cast_magic(self.npc, self.npc, 399933, 1)
    cast_magic(self.npc, self.npc, 4010005, 1)
    self.control = 4
  end
end

function M:control_set()
  if 0 == self.control then
    self:cast_skill(self.skill02)
  end
  if 1 == self.control then
    self:cast_skill(self.skill03)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if self.control == nil and skill_id == self.skill01[1] and hit_target ~= self.npc then
    self.control = 0
  end
end

function M:on_frame()
  if self.check_set == false then
    self:cast_skill(self.skill01)
    self.check_set = true
  end
  self:control_set()
  if 3 == self.control and get_npc_time(self.npc) > self.boom_timer then
    self.control = 1
  end
  if 4 == self.control and get_npc_time(self.npc) > self.boom_timer then
    abort_magic_by_id(self.npc, 4010005)
    self.control = nil
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

return M
