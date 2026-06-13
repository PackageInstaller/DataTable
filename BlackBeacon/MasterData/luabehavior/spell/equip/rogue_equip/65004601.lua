local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 65004601) then
    cast_magic(self.npc, self.hero_one, 65004601, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 65004601) then
    cast_magic(self.npc, self.hero_two, 65004601, 0)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 3 == skill_type or 4 == skill_type then
    cast_magic(self.npc, self.npc, 65004602, 0)
  end
end

function M:on_frame()
end

return M
