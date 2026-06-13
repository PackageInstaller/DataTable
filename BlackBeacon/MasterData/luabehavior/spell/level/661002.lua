local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 661002) then
    cast_magic(self.npc, self.hero_one, 661002, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 661002) then
    cast_magic(self.npc, self.hero_two, 661002, 0)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if target ~= self.npc then
    return
  end
  if damage_val < 0 then
    cast_magic(target, target, 66100201)
  end
end

return M
