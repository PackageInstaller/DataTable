_class("SkillEffectResult_AddBlood", SkillEffectResultBase)
SkillEffectResult_AddBlood = SkillEffectResult_AddBlood

function SkillEffectResult_AddBlood:Constructor(nType, nData, posGrid, stageIndex)
  self.m_nType = nType
  self.m_nData = nData
  self.m_posGrid = posGrid
  self.m_nTargetID = 0
  self.m_nCurAdd = 0
  self.m_stageIndex = stageIndex
end

function SkillEffectResult_AddBlood:GetEffectType()
  return SkillEffectType.AddBlood
end

function SkillEffectResult_AddBlood:SetAddData(nTargetID, nCurAdd)
  self.m_nTargetID = nTargetID
  self.m_nCurAdd = nCurAdd
end

function SkillEffectResult_AddBlood:SetAddValue(nCurAdd)
  self.m_nCurAdd = nCurAdd
end

function SkillEffectResult_AddBlood:GetGridPos()
  return self.m_posGrid
end

function SkillEffectResult_AddBlood:GetType()
  return self.m_nType
end

function SkillEffectResult_AddBlood:GetData()
  return self.m_nData
end

function SkillEffectResult_AddBlood:GetTargetID()
  return self.m_nTargetID
end

function SkillEffectResult_AddBlood:GetAddValue()
  return self.m_nCurAdd
end

function SkillEffectResult_AddBlood:SetDamageInfo(nDamageInfo)
  self.m_nDamageInfo = nDamageInfo
end

function SkillEffectResult_AddBlood:GetDamageInfo()
  return self.m_nDamageInfo
end

function SkillEffectResult_AddBlood:GetStageIndex()
  return self.m_stageIndex
end

function SkillEffectResult_AddBlood:GetDamageStageIndex()
  return self.m_stageIndex
end
