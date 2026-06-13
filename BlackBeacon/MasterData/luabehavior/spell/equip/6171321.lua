local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  local role = self.npc:get_behavior()
  if role then
    tool.insert(role, "onRampageStart", self.add_ult_energy)
  end
end

function M:add_ult_energy()
  cast_magic(self.npc, self.npc, 61713211)
end

function M:on_remove()
  local role = self.npc:get_behavior()
  if role then
    tool.remove(role, "onRampageStart", self.add_ult_energy)
  end
end

return M
