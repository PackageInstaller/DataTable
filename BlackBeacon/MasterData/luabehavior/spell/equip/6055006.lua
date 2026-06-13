local M = Util.create_class()

function M:_init()
  self.cd_timer = 0
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  if check_magic(npc, 1999050) and get_npc_time(self.npc) > self.cd_timer then
    self:cast_magic_to_team(60550061)
    self:cast_magic_to_team(60550062)
    self.cd_timer = get_npc_time(self.npc) + 10
  end
end

function M:cast_magic_to_team(magic_id)
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if teammate1 then
    cast_magic(self.npc, teammate1, magic_id, 0)
  end
  if teammate2 then
    cast_magic(self.npc, teammate2, magic_id, 0)
  end
  cast_magic(self.npc, self.npc, magic_id, 0)
end

return M
