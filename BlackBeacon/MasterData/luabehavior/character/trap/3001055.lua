local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300105501,
    3,
    0,
    0,
    0,
    get_skill_cfg(300105501).CastTime,
    get_skill_cfg(300105501).AfterTime
  }
  self.skill02 = {
    300105502,
    3,
    0,
    0,
    0,
    get_skill_cfg(300105502).CastTime,
    get_skill_cfg(300105502).AfterTime
  }
  self.control = nil
  self.target = nil
  self.splash_timer = nil
end

function M:skill_logic()
  if 0 == self.control then
    cast_skill(self.npc, self.target, 300105501, nil, nil)
    self.control = 1
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 5, nil, 1)
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
  if 1 == self.control then
    self.control = nil
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if 300103902 == skill_id then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, 300105502)
  end
end

function M:on_skill_end(npc, skill_id)
  local now_time = get_npc_time(self.npc)
  if npc ~= self.npc then
    return
  end
  if 300105402 == skill_id and now_time >= self.skill03_time then
    cast_skill(self.npc, self.target, 300105503)
    self.skill03_time = now_time + 99
    remove_npc(self.npc)
  end
end

return M
