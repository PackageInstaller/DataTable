local M = Util.create_class()

function M:_init(npc)
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.god_npc = get_god_npc()
  if check_magic(npc, 399933) then
    abort_magic_by_id(npc, 399933, get_magic_num(npc, 399933))
  end
  if self.hero_one and check_magic(self.hero_one, 399933) then
    abort_magic_by_id(self.hero_one, 399933, get_magic_num(self.hero_one, 399933))
  end
  if self.hero_two and check_magic(self.hero_two, 399933) then
    abort_magic_by_id(self.hero_two, 399933, get_magic_num(self.hero_two, 399933))
  end
end

function M:on_frame()
end

return M
