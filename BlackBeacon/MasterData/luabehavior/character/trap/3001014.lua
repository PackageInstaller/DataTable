local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300101401,
    5,
    0,
    0,
    0,
    get_skill_cfg(300100702).CastTime,
    get_skill_cfg(300100601).AfterTime
  }
  self.control = nil
  self.target = nil
  self.splash_timer = nil
end

function M:cast_skill(skill_instant_ID)
  if 300101401 == skill_instant_ID[1] then
    cast_skill(self.npc, self.target, skill_instant_ID[1], nil, nil)
    self.splash_timer = get_npc_time(self.npc) + 6
    self.control = 1
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 7, 30, nil, 1)
end

function M:control_set()
  if 0 == self.control then
    self:cast_skill(self.skill01)
  end
end

function M:on_frame()
  if is_pass_room() and not get_sync_var("trap_switch_on") then
    abort_skill(self.npc)
    self.control = 9
  end
  self:control_set()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
  end
  if 1 == self.control and get_npc_time(self.npc) > self.splash_timer then
    self.control = 0
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
