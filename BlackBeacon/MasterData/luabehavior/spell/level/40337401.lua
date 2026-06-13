local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local magic = 4033740101
local rolebase = import("character.base.role_base")

function M.red_skill_counter_fragile(role, attackerNpc, victimNpc)
  if attackerNpc.id == role.id then
    cast_magic(victimNpc, victimNpc, magic)
  end
end

function M:on_start()
  if self:getInstNum() > 1 then
    return
  end
  tool.insert(rolebase, "on_red_skill_countered", self.red_skill_counter_fragile)
end

function M:on_remove()
  self.base.on_remove(self)
  if self:getInstNum() > 0 then
    return
  end
  tool.remove(rolebase, "on_red_skill_countered", self.red_skill_counter_fragile)
end

function M:_init(npc)
end

return M
