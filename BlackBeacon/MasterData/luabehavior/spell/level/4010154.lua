local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_frame()
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if 0 == self.magic_set then
    abort_magic_by_id(self.npc, 4010151, 1)
    if teammate1 then
      abort_magic_by_id(teammate1, 4010151, 1)
    end
    if teammate2 then
      abort_magic_by_id(teammate2, 4010151, 1)
    end
  end
end

return M
