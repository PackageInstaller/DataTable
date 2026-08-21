require("ai_node_new")
_class("ActionCastSelectedSkillByTotalRound", ActionCastSkillBase)
ActionCastSelectedSkillByTotalRound = ActionCastSelectedSkillByTotalRound

function ActionCastSelectedSkillByTotalRound:Constructor()
end

function ActionCastSelectedSkillByTotalRound:GetWorkSkillID()
  local skillCount = self:GetLogicData(-1)
  local totalRound = self:GetLogicData(-2)
  local skillId = self:GetLogicData(-3)
  local battleStatCmpt = self._world:BattleStat()
  local levelTotalRoundCount = battleStatCmpt:GetLevelTotalRoundCount()
  local roundCount = levelTotalRoundCount % skillCount
  if totalRound ~= roundCount then
    skillId = 0
  end
  return skillId
end
