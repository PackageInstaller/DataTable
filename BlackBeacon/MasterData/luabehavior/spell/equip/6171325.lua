local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:add_ExQTETimes()
  print("逗逗你的呀，这个词条毛用没有")
end

function M:on_start()
  local role = self.npc:get_behavior()
  if role then
    tool.insert(role, "onRampageStart", self.add_ExQTETimes)
  end
  local pos = get_npc_pos(self.npc)
  cast_missile3(self.npc, nil, nil, nil, 201038012901)
end

return M
