local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666303)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if 7 == damage_sign and self.npc == npc and not check_magic(self.npc, 6663031) then
    cast_magic(npc, target, 6663032, self.stone_lv)
    cast_magic(npc, npc, 6663031, 0)
  end
end

return M
