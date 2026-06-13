local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    return
  else
    cast_magic(self.npc, self.npc, 650021011, 0)
  end
end

function M:on_frame()
end

return M
