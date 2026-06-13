local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_room_change(npc)
  self.level = get_ability_level(50017) or 1
  if self.level > 1 then
    rogueMgr.add_money_possible = 0.5
  else
    rogueMgr.add_money_possible = 0.3
  end
end

function M:on_start()
  rogueMgr.crit_add_money = true
  if not check_magic(get_god_npc(), 61708001) then
    cast_magic(self.npc, get_god_npc(), 61708001)
  end
  self.level = get_ability_level(50017) or 1
  if self.level > 1 then
    rogueMgr.add_money_possible = 0.5
  else
    rogueMgr.add_money_possible = 0.3
  end
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170833)
  if 0 == num then
    rogueMgr.crit_add_money = false
  end
end

return M
