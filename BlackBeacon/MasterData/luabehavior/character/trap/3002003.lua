local M = Util.create_class()

function M:_init(npc)
  self.skill01 = {
    300200301,
    0,
    0,
    0,
    0,
    get_skill_cfg(300200301).CastTime,
    get_skill_cfg(300200301).AfterTime
  }
  self.skill02 = {
    300200302,
    0,
    0,
    0,
    0,
    get_skill_cfg(300200302).CastTime,
    get_skill_cfg(300200302).AfterTime
  }
  self.control = nil
  enable_shadow(npc, false)
end

function M:cast_skill(skill_instant_ID)
  if 300200301 == skill_instant_ID[1] then
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.control = nil
  end
  if 300200302 == skill_instant_ID[1] then
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.control = nil
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    return
  end
  if hit_target == self.npc and self.control == nil and 0 ~= hit_type then
    if missile_cfg.InteracteType == "Light" then
      self:cast_skill(self.skill02)
    else
      self:cast_skill(self.skill01)
    end
    self.control = 1
  end
end

function M:on_frame()
  if is_pass_room() then
    abort_skill(self.npc)
    set_can_searched(self.npc, false)
    self.control = 9
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300200301 ~= skill_id then
  end
  self.npc:on_dead(nil, true)
  remove_npc(npc)
end

return M
