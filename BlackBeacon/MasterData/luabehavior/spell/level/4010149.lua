local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  local random = math.random(1, 6)
  if 1 == random or 3 == random then
    cast_magic(self.npc, target, 4010148, 1)
  end
end

return M
