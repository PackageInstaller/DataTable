local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  cast_magic(self.npc, self.npc, 40321911, 0)
  if self.hero_one then
    cast_magic(self.npc, self.hero_one, 40321911, 0)
  end
  if self.hero_two then
    cast_magic(self.npc, self.hero_two, 40321911, 0)
  end
end

function M:on_frame()
end

return M
