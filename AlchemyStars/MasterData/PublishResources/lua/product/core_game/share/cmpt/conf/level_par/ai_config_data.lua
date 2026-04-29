_class("AiConfigData_Single", Object)
AiConfigData_Single = AiConfigData_Single

function AiConfigData_Single:Constructor(aiConfig)
  if nil == aiConfig then
    return
  end
  self.m_nKey = aiConfig.ID
  self.m_nLogicID = aiConfig.LogicID
  self.m_nLogicType = aiConfig.LogicType
  self.m_nLogicOrder = aiConfig.LogicOrder
  self.m_bPreview = aiConfig.Preview
  self.m_listSkillID = aiConfig.SkillList
  self.m_extParam = aiConfig.ExtParam
end

_class("AiConfigData", Object)
AiConfigData = AiConfigData

function AiConfigData:Constructor()
end

function AiConfigData:GetAiObject(nConfigAiKey)
  return AiConfigData_Single:New(Cfg.cfg_ai[nConfigAiKey])
end

function AiConfigData:GetLogicID(nConfigAiKey)
  local aiConfig = self:GetAiObject(nConfigAiKey)
  return aiConfig.m_nLogicID
end

function AiConfigData:GetLogicType(nConfigAiKey)
  local aiConfig = self:GetAiObject(nConfigAiKey)
  return aiConfig.m_nLogicType
end

function AiConfigData:GetLogicOrder(nConfigAiKey)
  local aiConfig = self:GetAiObject(nConfigAiKey)
  return aiConfig.m_nLogicOrder
end

function AiConfigData:GetSkillList(nConfigAiKey)
  local aiConfig = self:GetAiObject(nConfigAiKey)
  return aiConfig.m_listSkillID
end

function AiConfigData:GetExtParam(nConfigAiKey)
  local aiConfig = self:GetAiObject(nConfigAiKey)
  return aiConfig.m_extParam
end
