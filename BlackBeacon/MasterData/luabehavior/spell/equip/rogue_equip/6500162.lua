local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
end

function M:check_perfect()
  if check_magic(self.npc, 1999198) or check_magic(self.npc, 1999187) then
    cast_magic(self.npc, self.npc, 650016021, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650016021, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650016021, 0)
    end
  end
end

function M:on_frame()
  self:check_perfect()
end

return M
