local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc then
    cast_magic(self.npc, target, 6021055, 1)
  end
end

return M
