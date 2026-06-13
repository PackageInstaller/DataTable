local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_start()
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 4033006, 1)
    if teammate1 then
      cast_magic(self.npc, teammate1, 4033006, 1)
    end
    if teammate2 then
      cast_magic(self.npc, teammate2, 4033006, 1)
    end
  end
end

return M
