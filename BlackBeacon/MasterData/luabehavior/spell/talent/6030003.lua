local M = Util.create_class()

function M:_init()
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    cast_magic(self.npc, target, 6031019, 1)
  end
end

return M
