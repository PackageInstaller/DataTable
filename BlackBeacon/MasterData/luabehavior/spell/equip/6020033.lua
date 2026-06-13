local M = Util.create_class()

function M:_init()
  self.cover_target = nil
  self.on_show_set = 0
end

function M:on_frame()
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if self.npc == teammate1 or self.npc == teammate2 then
    self.on_show_set = 0
    return
  else
    self.on_show_set = 1
  end
end

function M:on_npc_removed(npc)
  if npc ~= self.npc and 1 == self.on_show_set then
    cast_magic(self.npc, self.npc, 6021045, 1)
  end
end

return M
