local M = Util.create_class()
local rogueMgr = import("common.rogueManager")
local tool = import("common.tool")

function M:_init(npc)
end

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  if check_magic(npc, rogueMgr.baojin) then
    cast_magic(get_come_on_hero(), npc, rogueMgr.jiaguangchen50)
  end
end

return M
