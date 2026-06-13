local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_fate_book_battle_start()
  local hero = get_come_on_hero()
  for _ = 1, 3 do
    cast_magic(hero, hero, rogueMgr.fragment_magic)
  end
end

function M:on_start()
  self.level = get_ability_level(70003) or 1
  tool:castMagicToTeam(rogueMgr.fragment_control)
  rogueMgr.fragment_effect_magic = 61712012
end

function M:on_room_change(npc)
  self.level = get_ability_level(70003) or 1
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6171213)
  if 0 == num then
    rogueMgr.fragment_effect_magic = 61712011
  end
end

return M
