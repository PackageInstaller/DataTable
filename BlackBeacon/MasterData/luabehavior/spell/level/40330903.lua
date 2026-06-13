local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 40330903) then
    cast_magic(self.npc, self.hero_one, 40330903, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 40330903) then
    cast_magic(self.npc, self.hero_two, 40330903, 0)
  end
  cast_magic(self.npc, self.npc, 4033090301, 0)
end

return M
