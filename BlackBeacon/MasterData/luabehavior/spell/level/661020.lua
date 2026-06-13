local M = Util.create_class()

function M:_init()
  self.come_on_hero = nil
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  if self.hero_one then
    cast_magic(self.hero_one, self.hero_one, 66102001)
  end
  if self.hero_two then
    cast_magic(self.hero_two, self.hero_two, 66102001)
  end
end

function M:on_hero_showup_or_back(npc, is_showup)
  if true == is_showup then
    self.come_on_hero = get_come_on_hero()
    self.hero_one = get_scene_hero_by_poskey(21)
    self.hero_two = get_scene_hero_by_poskey(22)
  end
  if npc ~= self.npc or true ~= is_showup then
    return
  end
  abort_magic_by_id(self.come_on_hero, 66102001, 1)
  if self.hero_one then
    cast_magic(self.hero_one, self.hero_one, 66102001)
  end
  if self.hero_two then
    cast_magic(self.hero_two, self.hero_two, 66102001)
  end
end

return M
