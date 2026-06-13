local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if false == is_crit then
    cast_magic(self.npc, self.npc, 6021059, 1)
  elseif true == is_crit then
    cast_magic(self.npc, self.npc, 6021060, 1)
  end
end

function M:on_frame()
  if self.npc and 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 6021057, 1)
    self.magic_set = 1
  end
end

return M
