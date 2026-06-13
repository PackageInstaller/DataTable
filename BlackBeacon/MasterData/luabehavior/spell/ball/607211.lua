local M = Util.create_class()

function M:_init()
end

function M:on_npc_hp_zero(npc)
  if nil == npc then
    return
  end
  local npc1, npc2, npc3
  if get_come_on_hero() then
    npc1 = get_come_on_hero()
  end
  if get_scene_hero_by_poskey(21) then
    npc2 = get_scene_hero_by_poskey(21)
  end
  if get_scene_hero_by_poskey(22) then
    npc3 = get_scene_hero_by_poskey(22)
  end
  if npc == npc1 or npc == npc2 or npc == npc3 then
    return
  end
  if npc1 then
    cast_magic(npc1, npc1, 60721101, 1)
  end
  if npc2 then
    cast_magic(npc2, npc2, 60721101, 1)
  end
  if npc3 then
    cast_magic(npc3, npc3, 60721101, 1)
  end
end

return M
