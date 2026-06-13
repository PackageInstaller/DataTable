local M = Util.create_class()
local tool = import("common.tool")
local hero = get_come_on_hero()

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(60012) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(60012) or 1
end

function M:on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if magic_kind and magic_kind[61710] and not check_magic(self.npc, 61710171) then
    cast_magic(self.npc, self.npc, 61710171, self.level)
  end
end

function M:on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  if magic_kind and magic_kind[61710] and check_magic(self.npc, 61710171) and get_magic_kind_num(self.npc, 61710) < 1 then
    abort_magic_by_id(self.npc, 61710171)
  end
end

return M
