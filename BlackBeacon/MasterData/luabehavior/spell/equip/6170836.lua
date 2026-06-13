local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
  rogueMgr.heal_magic = true
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170836)
  if 0 == num then
    rogueMgr.heal_magic = false
  end
end

function M:on_start()
  rogueMgr.level_6170836 = get_ability_level(50022) or 1
end

function M:on_room_change(npc)
  rogueMgr.level_6170836 = get_ability_level(50022) or 1
end

return M
