local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666102)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc == self.npc and is_crit then
    cast_magic(npc, npc, 6661021, self.stone_lv)
    if check_magic(npc, 6661031) then
      local num = get_magic_num(npc, 6661031)
      cast_magic(npc, npc, 6661022, num)
    end
  end
end

return M
