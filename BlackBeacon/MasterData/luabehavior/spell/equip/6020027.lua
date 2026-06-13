local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.magic_timer = 0
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if npc ~= self.npc then
    return
  end
  self.random_judge = math.random(1, 11)
  if self.random_judge >= 8 and 0 == self.magic_set then
    cast_magic(self.npc, self.target, 6021039, 1)
    self.magic_set = 1
    self.magic_timer = get_npc_time(self.npc) + 0.5
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, damage_val)
  if npc ~= self.npc then
    return
  end
  if 6021039 == magic_id then
    return
  end
  self.random_judge = math.random(1, 11)
  if self.random_judge >= 8 and 0 == self.magic_set then
    cast_magic(self.npc, self.target, 6021039, 1)
    self.magic_set = 1
    self.magic_timer = get_npc_time(self.npc) + 0.5
  end
end

function M:on_frame()
  self:search_target()
  if get_npc_time(self.npc) > self.magic_timer then
    self.magic_set = 0
  end
end

return M
