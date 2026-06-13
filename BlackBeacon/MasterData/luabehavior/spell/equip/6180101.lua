local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:on_fate_book_battle_start()
  self.SkillOver = false
end

function M:_init(npc)
  self.SkillOver = false
  self.ultCasting = false
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:isUlt() and not self.SkillOver then
    self.SkillOver = true
    self.ultCasting = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if self.ultCasting then
    cast_magic(self.npc, self.npc, 618010101, 1)
    cast_magic(self.npc, self.npc, 618010102, 1)
    self.ultCasting = false
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
