local M = Util.create_class()
local tool = import("common.tool")
local is_niubi = false

function M:after_heal_self(npc, magic_id, heal_val)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if get_magic_num(self.npc, 61709321) < 4 then
    cast_magic(self.npc, self.npc, 61709321, self.level)
  end
end

function M:on_room_pass(room_id)
  self.level = get_ability_level(30018) or 1
  if check_magic(self.npc, 61709321) then
    abort_magic_by_id(self.npc, 61709321)
  end
end

function M:on_start()
  self.level = get_ability_level(30018) or 1
end

function M:_init(npc)
end

return M
