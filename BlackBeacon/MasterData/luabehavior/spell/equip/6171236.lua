local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= get_come_on_hero() then
    return
  end
  if act == act.role.baseActs.wander then
    cast_magic(act.role.npc, act.role.npc, 61712361, self.level)
  else
    abort_magic_by_id(act.role.npc, 61712361)
  end
end

function M:on_room_change(npc)
  self:get_level()
end

function M:on_start()
  self:get_level()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:get_level()
  self.level = get_ability_level(70014)
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6171236)
  if 0 == num then
    unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  end
end

return M
