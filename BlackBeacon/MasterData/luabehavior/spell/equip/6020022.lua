local M = Util.create_class()

function M:_init()
  self.count_set = 0
  self.magic_timer = 0
  self.cooldown_timer = 0
  self.target = nil
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  self.target = hit_target
end

function M:on_superarmor_break(npc, camp)
  if npc == self.target and get_npc_time(self.npc) > self.cooldown_timer and 2 == camp then
    cast_magic(self.npc, self.npc, 6021034, 1)
    self.count_set = 1
    self.magic_timer = get_npc_time(self.npc) + 5
    self.cooldown_timer = get_npc_time(self.npc) + 20
  end
end

function M:on_frame()
  if 1 == self.count_set and get_npc_time(self.npc) > self.magic_timer then
    abort_magic_by_id(self.npc, 6021034)
    self.count_set = 0
  end
end

return M
