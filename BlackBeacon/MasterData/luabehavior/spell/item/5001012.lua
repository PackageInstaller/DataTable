local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_start()
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 50010121, 1)
    cast_magic(self.npc, self.npc, 50010122, 1)
    cast_magic(self.npc, self.npc, 50010123, 1)
    cast_magic(self.npc, self.npc, 50010124, 1)
    if teammate1 then
      cast_magic(self.npc, teammate1, 50010121, 1)
      cast_magic(self.npc, teammate1, 50010122, 1)
      cast_magic(self.npc, teammate1, 50010123, 1)
      cast_magic(self.npc, teammate1, 50010124, 1)
    end
    if teammate2 then
      cast_magic(self.npc, teammate2, 50010121, 1)
      cast_magic(self.npc, teammate2, 50010122, 1)
      cast_magic(self.npc, teammate2, 50010123, 1)
      cast_magic(self.npc, teammate2, 50010124, 1)
    end
    self.magic_set = 1
  end
end

return M
