local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if hit_target ~= self.npc then
    cast_magic(self.npc, self.npc, 4010134, 1)
  end
end

return M
