local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M.onPerfectDash(role)
  if check_magic(role.npc, rogueMgr.fragment_magic) >= 6 then
    local num = 1
  else
    local num = 3
  end
  rogueMgr.random_cast_fragment(rogueMgr, role.npc, num, 2)
end

function M:listen_perfect_dash()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.insert(role, "onPdashSlomo", self.onPerfectDash)
end

function M:on_start()
  local unit = self.npc:get_behavior()
  if not unit then
    return
  end
  self:listen_perfect_dash()
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self.level = get_ability_level(70002) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(70002) or 1
end

function M:on_remove()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.remove(role, "onPdashSlomo", self.onPerfectDash)
end

return M
