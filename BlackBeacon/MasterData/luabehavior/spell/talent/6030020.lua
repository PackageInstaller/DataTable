local M = Util.create_class()

function M:_init(npc)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if 6 == damage_sign or 7 == damage_sign or 1 == damage_sign then
    return
  end
  if 1 == damage_type then
    return
  end
  cast_magic(self.npc, target, 6031042, 1)
end

return M
