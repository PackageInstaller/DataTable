local M = Util.create_class()
local tool = import("common.tool")
local magic_list = {
  [2] = 4033710301,
  [3] = 4033710302,
  [4] = 4033710303,
  [5] = 4033710304,
  [6] = 4033710305
}

function M:_init()
end

function M:on_npc_born(npc)
  if get_come_on_hero() ~= self.npc then
    return
  end
  local kind = get_role_kind(npc)
  if 2 == kind or 3 == kind or 4 == kind then
    for i = 4033710301, 4033710305 do
      cast_magic(npc, npc, i, 3)
    end
  end
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if get_come_on_hero() ~= self.npc then
    return
  end
  if not magic_list[element] then
    return
  end
  if check_magic(npc, magic_list[element]) then
    abort_magic_by_id(npc, magic_list[element])
  end
end

return M
