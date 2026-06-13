local M = Util.create_class()

function M:_init()
end

function M:on_start()
  local npc_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
  local attr_id = 101
  local level = 0
  for i, npc in ipairs(npc_list) do
    if npc then
      level = level + get_npc_attr(npc, attr_id)
    end
  end
  if level > 0 then
    cast_magic(self.npc, self.npc, 6064040, level)
    cast_magic(self.npc, self.npc, 6064041, level)
    cast_magic(self.npc, self.npc, 6064042, level)
  end
end

return M
