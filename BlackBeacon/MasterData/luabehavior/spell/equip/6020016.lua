local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  cast_magic(self.npc, target, 6021054, 1)
end

return M
