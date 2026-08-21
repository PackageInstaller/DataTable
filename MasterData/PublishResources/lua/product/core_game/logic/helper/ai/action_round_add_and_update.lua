require("action_save_round_count")
_class("ActionRound_AddAndUpdate", ActionRoundBase)
ActionRound_AddAndUpdate = ActionRound_AddAndUpdate

function ActionRound_AddAndUpdate:Constructor()
end

function ActionRound_AddAndUpdate:OnBegin()
  local nLoopLimit = self:GetRuntimeData("SkillCount") or 1
  local nOldRoundData = self.m_nRoundData
  self.m_nRoundData = self:_SaveRoundCount(nOldRoundData, nLoopLimit)
  local nSaveGameRound = self:GetRuntimeData("GameRound")
  self:SetRuntimeData("GameRound", nil)
  self.m_logicOwn:ReSelectWorkSkill()
  self:SetRuntimeData("GameRound", nSaveGameRound)
  self:PrintLog("更新当前回合技能, nOldRount = ", nOldRoundData, ", nNewRount", self.m_nRoundData)
end

function ActionRound_AddAndUpdate:OnUpdate()
  return AINewNodeStatus.Success
end
