local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_start()
  self.last_time = get_npc_time(self.npc)
  self.is_battle = true
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self.level = get_ability_level(70007) or 1
  if 1 == self.level then
    self.cd = 5
  else
    self.cd = 3
  end
end

function M:on_fate_book_battle_start()
  self.last_time = get_npc_time(self.npc)
  self.is_battle = true
end

function M:on_room_change(npc)
  self.is_battle = false
  self.level = get_ability_level(70007) or 1
  if 1 == self.level then
    self.cd = 5
  else
    self.cd = 3
  end
end

function M:on_frame()
  if not self.is_battle then
    return
  end
  self.curr_time = get_npc_time(self.npc)
  if self.curr_time > self.last_time + self.cd then
    local hero = get_come_on_hero()
    cast_magic(hero, hero, rogueMgr.fragment_magic)
    self.last_time = self.curr_time
  end
end

return M
