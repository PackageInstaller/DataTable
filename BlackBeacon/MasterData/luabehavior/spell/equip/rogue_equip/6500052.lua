local M = Util.create_class()

function M:_init()
  self.check_cd = 0
end

function M:on_start()
end

function M:check_element()
  local list_monster = search_npc(self.npc, 4, 30, nil, false, true)
  for k, v in pairs(list_monster) do
    if get_magic_num(v, 1998040) > 1 and not check_magic(v, 650005011) then
      cast_magic(self.npc, v, 650005021, 0)
    end
  end
  self.check_cd = get_npc_time(self.npc) + 0.25
end

function M:on_frame()
  if self.check_cd < get_npc_time(self.npc) then
    self:check_element()
  end
end

return M
