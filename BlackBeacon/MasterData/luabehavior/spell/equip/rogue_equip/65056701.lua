local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 65056701) then
    cast_magic(self.npc, self.hero_one, 65056701, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 65056701) then
    cast_magic(self.npc, self.hero_two, 65056701, 0)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if 30010650301 ~= magic_id and 30010660306 ~= magic_id then
    return
  end
  if target == self.npc then
    cast_magic(npc, npc, 65056702, 1)
  else
    cast_magic(npc, npc, 65056703, 1)
  end
end

function M:on_frame()
end

return M
