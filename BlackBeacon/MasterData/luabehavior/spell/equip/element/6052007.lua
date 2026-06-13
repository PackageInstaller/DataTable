local M = Util.create_class()

function M:_init()
  self.target = nil
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if check_magic(npc, 60520071) then
    self.target = target
    cast_magic(npc, npc, 60520071, 1)
    cast_magic(npc, target, 60520072, 1)
  end
end

return M
