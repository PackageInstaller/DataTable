require("action_is_base")
_class("ActionCheckTotalRound", ActionIsBase)
ActionCheckTotalRound = ActionCheckTotalRound

function ActionCheckTotalRound:OnUpdate()
  local skillCount = self:GetLogicData(-1)
  local battleStatCmpt = self._world:BattleStat()
  local levelTotalRoundCount = battleStatCmpt:GetLevelTotalRoundCount()
  local roundCount = levelTotalRoundCount % skillCount
  if roundCount == 0 then
    roundCount = skillCount
  end
  return AINewNodeStatus.Other + roundCount
end
