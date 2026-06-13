local M = Util.create_class()
local tool = import("common.tool")
local team = tool.team.npc

function M:_init()
end

local addlight = false

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651130071)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if 5 == element then
    addlight = true
  end
end

function M:on_skill_begin(npc, skill_id, skill_typer)
  if npc == self.npc and npc:get_behavior().skAct.type == "linkQte" and addlight then
    tool:castMagicToTeam(651130072, self.level, self.npc, 1)
    addlight = false
  end
end

return M
