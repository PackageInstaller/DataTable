local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")
local buffCastTime = 0
local CorpSkill = false

function M:_init(npc)
end

function M:Rampage()
  cast_magic(self.npc, self.npc, 618000501, 1)
end

function M:RampageEnd()
  abort_magic_by_id(self.npc, 618000501)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isLinkQte() then
    cast_magic(self.npc, self.npc, 618000502, 1)
    cast_magic(self.npc, self.npc, 618000503, 1)
    cast_magic(self.npc, self.npc, 618000504, 1)
  end
end

function M:on_skact_end(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isLinkQte() then
    abort_magic_by_id(self.npc, 618000502)
    abort_magic_by_id(self.npc, 618000503)
    abort_magic_by_id(self.npc, 618000504)
  end
end

function M:on_start()
  if self.npc == get_come_on_hero() then
    change_skill_link_duration(1, 5)
    change_skill_link_duration(2, 10)
  end
  buffCastTime = get_npc_time(self.npc)
  local role = self.npc:get_behavior()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_END, self.npc, self.on_skact_end, self)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BREAK, self.npc, self.on_skact_end, self)
  if role then
    tool.insert(role, "onRampageStart", self.Rampage)
    tool.insert(role, "onRampageEnd", self.RampageEnd)
  end
end

function M:on_remove()
  local role = self.npc:get_behavior()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_END, self.npc, self)
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BREAK, self.npc, self)
  if role then
    tool.remove(role, "onRampageStart", self.Rampage)
    tool.remove(role, "onRampageEnd", self.RampageEnd)
  end
  if self.npc == get_come_on_hero() then
    change_skill_link_duration(1, -5)
    change_skill_link_duration(2, -10)
  end
  abort_magic_by_id(self.npc, 618000501)
  abort_magic_by_id(self.npc, 618000502)
  abort_magic_by_id(self.npc, 618000503)
  abort_magic_by_id(self.npc, 618000504)
end

return M
