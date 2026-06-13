local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.kuangnu and get_magic_num(self.npc, rogueMgr.baojun) < 5 then
    cast_magic(self.npc, self.npc, rogueMgr.baojun)
    local level = get_ability_level(40013) or 1
    if level > 1 and not check_magic(self.npc, 61707221) then
      cast_magic(self.npc, self.npc, 61707221)
    end
  end
end

function M:_init(npc)
end

return M
