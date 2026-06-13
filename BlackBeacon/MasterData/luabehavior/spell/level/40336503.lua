local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 1 == skill_type then
    cast_magic(self.npc, self.npc, 4033650301, 1)
  end
end

return M
