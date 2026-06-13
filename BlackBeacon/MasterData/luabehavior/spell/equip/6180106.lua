local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:add_buff(dash, atkMis)
  cast_magic(self.npc, self.npc, 618010601)
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  role:clearDashCd()
end

function M:on_start()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.insert(role, "onPdashSlomo", self.add_buff)
end

function M:on_remove()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.remove(role, "onPdashSlomo", self.add_buff)
end

return M
