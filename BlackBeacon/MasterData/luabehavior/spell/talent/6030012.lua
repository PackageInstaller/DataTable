local M = Util.create_class()

function M:_init()
end

function M:effect_aborn_magic(npc, target, element)
  if npc ~= self.npc then
    return
  end
  cast_magic(self.npc, self.npc, 6031016, 1)
end

return M
