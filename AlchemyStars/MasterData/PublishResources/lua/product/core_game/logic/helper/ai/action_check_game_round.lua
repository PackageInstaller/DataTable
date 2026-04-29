require("action_is_base")
_class("ActionCheckGameRound", ActionIsBase)
ActionCheckGameRound = ActionCheckGameRound

function ActionCheckGameRound:OnUpdate()
  local skillCount = self:GetLogicData(-1)
  local roundCount = self:GetRuntimeData("GameRound") or 1
  local roundCount = roundCount % skillCount
  if roundCount == 0 then
    roundCount = skillCount
  end
  return AINewNodeStatus.Other + roundCount
end
