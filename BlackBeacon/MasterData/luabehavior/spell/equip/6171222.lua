local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= get_come_on_hero() then
    return
  end
  if act:deemUlt() then
    for _ = 1, self.num do
      cast_magic(act.role.npc, act.role.npc, rogueMgr.fragment_magic)
    end
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(70005) or 1
  if 1 == self.level then
    self.num = 2
  else
    self.num = 3
  end
end

function M:on_start()
  self.level = get_ability_level(70005) or 1
  if 1 == self.level then
    self.num = 2
  else
    self.num = 3
  end
  tool:castMagicToTeam(rogueMgr.fragment_control)
  cast_magic(self.npc, self.npc, 61712221)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6171222)
  if 0 == num then
    unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
    tool:abortMagicToTeam(61712221)
  end
end

return M
