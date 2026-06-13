local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_fate_book_battle_start()
  if self.hero_one and not check_magic(self.hero_one, 66602401) then
    cast_magic(self.npc, self.hero_one, 66602401, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 66602401) then
    cast_magic(self.npc, self.hero_two, 66602401, 0)
  end
end

function M:on_npc_born(npc)
  if npc == self.npc then
    return
  end
  if self.npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(npc)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if not check_magic(npc, 66602402) then
    cast_magic(self.npc, npc, 66602402, 0)
  end
end

return M
