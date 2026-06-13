local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  local kind = get_role_kind(npc)
  if check_magic(self.npc, rogueMgr.weilai) and 1 ~= kind then
    local level = get_ability_level(20018) or 1
    cast_magic(self.npc, self.npc, 61706323, level)
  end
end

function M:on_start()
end

function M:_init(npc)
end

return M
