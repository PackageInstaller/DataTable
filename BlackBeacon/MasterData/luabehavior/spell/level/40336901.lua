local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local rolebase = import("character.base.role_base")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  if act:isDashInput() then
    role:addMagic(Const.DEFEND.DASH.COMMON.CD)
  end
end

function M:clearCD(dash, atkMis)
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  role:clearDashCd()
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  if self:getInstNum() > 1 then
    return
  end
  tool.insert(rolebase, "onPdashSlomo", self.clearCD)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
  self.base.on_remove(self)
  if self:getInstNum() > 0 then
    return
  end
  tool.remove(rolebase, "onPdashSlomo", self.clearCD)
end

return M
