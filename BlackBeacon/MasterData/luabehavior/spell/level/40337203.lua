local M = Util.create_class()
local tool = import("common.tool")
local magic = 4033720103

function M:_init()
end

function M:on_npc_born(npc)
  if get_come_on_hero() ~= self.npc then
    return
  end
  local kind = get_role_kind(npc)
  if 2 == kind or 3 == kind or 4 == kind then
    print("好加！")
    cast_magic(npc, npc, magic, 1)
  end
end

function M:on_force_shift_end(caster, target, magic_id, is_success)
  if get_come_on_hero() ~= self.npc then
    return
  end
  if not is_success then
    return
  end
  local kind = get_role_kind(target)
  if (2 == kind or 3 == kind or 4 == kind) and check_magic(target, magic) then
    print("移除了")
    abort_magic_by_id(target, magic)
  end
end

return M
