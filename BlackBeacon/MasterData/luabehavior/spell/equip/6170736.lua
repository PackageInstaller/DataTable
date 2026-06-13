local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.level = get_ability_level(40022) or 1
  cast_magic(self.npc, self.npc, 61707361, self.level)
end

function M:on_fate_book_battle_start()
  self.level = get_ability_level(40022) or 1
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.baojun and not check_magic(self.npc, 61707362) then
    cast_magic(self.npc, self.npc, 61707362, self.level)
  end
end

function M:on_target_self_magic_end(npc, magic_id, magic_kind, magic_type, is_break)
  if magic_id == rogueMgr.baojun and not check_magic(self.npc, rogueMgr.baojun) and check_magic(self.npc, 61707362) then
    abort_magic_by_id(self.npc, 61707362)
  end
end

function M:_init(npc)
end

return M
