_class("SkillPetAttackDataComponent", Object)
SkillPetAttackDataComponent = SkillPetAttackDataComponent

function SkillPetAttackDataComponent:Constructor()
  self._chainSkillID = -1
  self._normalAttackData = SkillPathNormalAttackData:New()
  self._chainSkillShadowData = {}
  self._chainSkillAgentData = {}
  self._chainSkillReplaceData = {}
  self._curCastDamage = 0
  self._curChainDamageRate = 0
  self._curSuperGridNum = 0
  self._curPoorGridNum = 0
  self._curChainSkillTimeIndex = 0
  self._curChainSkillStage = 0
  self._castChainSkill = false
  self._multiStageChainSkillAttackDataList = {}
  self._chainRateList = {}
  self._chainSuperGridNumList = {}
  self._chainPoorGridNumList = {}
  self._chainSkillIndexList = {}
  self._chainSkillStageList = {}
end

function SkillPetAttackDataComponent:ClearPetAttackData()
  self._curCastDamage = 0
  self._chainSkillID = -1
  self._curChainSkillTimeIndex = 0
  self._curChainSkillStage = 0
  self._normalAttackData:ClearNormalAttackData()
  self:ClearPetChainAttackData()
end

function SkillPetAttackDataComponent:GetShadowChainAttackDataList()
  return self._chainSkillShadowData
end

function SkillPetAttackDataComponent:GetAgentChainAttackDataList()
  return self._chainSkillAgentData
end

function SkillPetAttackDataComponent:GetReplaceChainAttackDataList()
  return self._chainSkillReplaceData
end

function SkillPetAttackDataComponent:ClearPetChainAttackData()
  self._chainSkillShadowData = {}
  self._chainSkillAgentData = {}
  self._chainSkillReplaceData = {}
  self._multiStageChainSkillAttackDataList = {}
end

function SkillPetAttackDataComponent:GetNormalAttackData()
  return self._normalAttackData
end

function SkillPetAttackDataComponent:GetChainShadowData(idx)
  if idx == nil then
    return self._chainSkillShadowData
  end
  return self._chainSkillShadowData[idx]
end

function SkillPetAttackDataComponent:GetChainAgentData(idx)
  if idx == nil then
    return self._chainSkillAgentData
  end
  return self._chainSkillAgentData[idx]
end

function SkillPetAttackDataComponent:GetChainReplaceData(idx)
  if idx == nil then
    return self._chainSkillReplaceData
  end
  return self._chainSkillReplaceData[idx]
end

function SkillPetAttackDataComponent:GetChainSkillID()
  return self._chainSkillID
end

function SkillPetAttackDataComponent:SetChainSkillID(chainSkillID)
  self._chainSkillID = chainSkillID
end

function SkillPetAttackDataComponent:SetCurChainSkillTimeIndex(idx)
  self._curChainSkillTimeIndex = idx
end

function SkillPetAttackDataComponent:GetCurChainSkillTimeIndex()
  return self._curChainSkillTimeIndex
end

function SkillPetAttackDataComponent:SetCurChainSkillStage(chainSkillStage)
  self._curChainSkillStage = chainSkillStage
end

function SkillPetAttackDataComponent:GetCurChainSkillStage()
  return self._curChainSkillStage
end

function SkillPetAttackDataComponent:AddNormalAttackData(pathPointPosition, pathPointNormalAttackData)
  self._normalAttackData:AddPathPointNormalAttackData(pathPointPosition, pathPointNormalAttackData)
end

function SkillPetAttackDataComponent:AddChainShadowData(idx)
  if self._chainSkillShadowData[idx] == nil then
    self._chainSkillShadowData[idx] = SkillChainAttackData:New(idx)
  end
end

function SkillPetAttackDataComponent:AddChainAgentData(idx)
  if self._chainSkillAgentData[idx] == nil then
    self._chainSkillAgentData[idx] = SkillChainAttackData:New(idx)
  end
end

function SkillPetAttackDataComponent:AddChainReplaceData(idx)
  if self._chainSkillReplaceData[idx] == nil then
    self._chainSkillReplaceData[idx] = SkillChainAttackData:New(idx)
  end
end

function SkillPetAttackDataComponent:HasNormalAttackData(pathPointPosition)
  return self._normalAttackData:HasPathPointNormalAttackData(pathPointPosition)
end

function SkillPetAttackDataComponent:RemoveNormalAttackData(pathPointPosition)
  self._normalAttackData:RemovePathPointNormalAttackData(pathPointPosition)
end

function SkillPetAttackDataComponent:RemoveUnusedPathPointData(chain_path_data)
  self._normalAttackData:RemoveUnusedPathPointData(chain_path_data)
end

function SkillPetAttackDataComponent:GetCastChainSkill()
  return self._castChainSkill
end

function SkillPetAttackDataComponent:SetCastChainSkill(cast)
  self._castChainSkill = cast
end

function SkillPetAttackDataComponent:SetCurrentChainDamageRate(value)
  self._curChainDamageRate = value
end

function SkillPetAttackDataComponent:GetCurrentChainDamageRate()
  return self._curChainDamageRate
end

function SkillPetAttackDataComponent:SetCurrentSuperGridNum(value)
  self._curSuperGridNum = value
end

function SkillPetAttackDataComponent:GetCurrentSuperGridNum()
  return self._curSuperGridNum
end

function SkillPetAttackDataComponent:SetCurrentPoorGridNum(value)
  self._curPoorGridNum = value
end

function SkillPetAttackDataComponent:GetCurrentPoorGridNum()
  return self._curPoorGridNum
end

function SkillPetAttackDataComponent:GetMultiStageChainAttackDataList()
  return self._multiStageChainSkillAttackDataList
end

function SkillPetAttackDataComponent:GetMultiStageChainAttackData(timeIndex, index)
  if self._multiStageChainSkillAttackDataList[timeIndex] == nil then
    self._multiStageChainSkillAttackDataList[timeIndex] = {}
  end
  return self._multiStageChainSkillAttackDataList[timeIndex][index]
end

function SkillPetAttackDataComponent:AddMultiStageChainAttackData(timeIndex, index, chainSkillID)
  if self._multiStageChainSkillAttackDataList[timeIndex] == nil then
    self._multiStageChainSkillAttackDataList[timeIndex] = {}
  end
  if self._multiStageChainSkillAttackDataList[timeIndex][index] == nil then
    self._multiStageChainSkillAttackDataList[timeIndex][index] = {}
  end
  self._multiStageChainSkillAttackDataList[timeIndex][index] = SkillChainAttackData:New(timeIndex, index, chainSkillID)
end

function SkillPetAttackDataComponent:GetChainSkillStageIndexWithSkillIDAndTimeIndex(chainSkillID, chainTimeIndex)
  local chainStageIndex = 1
  local multiStageChainAttackDataList = self:GetMultiStageChainAttackDataList()
  if multiStageChainAttackDataList and multiStageChainAttackDataList[chainTimeIndex] then
    local chainAttackDataList = multiStageChainAttackDataList[chainTimeIndex]
    for k, skillChainAttackData in pairs(chainAttackDataList) do
      local attdata = skillChainAttackData
      if attdata:GetChainAttackDataSkillID() == chainSkillID then
        chainStageIndex = attdata:GetChainSkillStageIndex()
        return chainStageIndex
      end
    end
  end
  local agentChainAttackDataList = self:GetAgentChainAttackDataList()
  for k, skillChainAttackData in pairs(agentChainAttackDataList) do
    local attdata = skillChainAttackData
    if attdata:GetChainAttackDataSkillID() == chainSkillID then
      chainStageIndex = attdata:GetChainSkillStageIndex()
      return chainStageIndex
    end
  end
  local replaceChainAttackDataList = self:GetReplaceChainAttackDataList()
  for k, skillChainAttackData in pairs(replaceChainAttackDataList) do
    local attdata = skillChainAttackData
    if attdata:GetChainAttackDataSkillID() == chainSkillID then
      chainStageIndex = attdata:GetChainSkillStageIndex()
      return chainStageIndex
    end
  end
  return chainStageIndex
end

function SkillPetAttackDataComponent:GetChainRateList(skillID)
  local chainRate = self._chainRateList[skillID]
  chainRate = chainRate or self:GetCurrentChainDamageRate()
  return chainRate
end

function SkillPetAttackDataComponent:SetChainRateList(skillID, chainRate)
  self._chainRateList[skillID] = chainRate
end

function SkillPetAttackDataComponent:GetChainSuperGridNumList(skillID)
  local chainSuperGridNum = self._chainSuperGridNumList[skillID]
  chainSuperGridNum = chainSuperGridNum or self:GetCurrentSuperGridNum()
  return chainSuperGridNum
end

function SkillPetAttackDataComponent:SetChainSuperGridNumList(skillID, superGridNum)
  self._chainSuperGridNumList[skillID] = superGridNum
end

function SkillPetAttackDataComponent:GetChainPoorGridNumList(skillID)
  local chainPoorGridNum = self._chainPoorGridNumList[skillID]
  chainPoorGridNum = chainPoorGridNum or self:GetCurrentPoorGridNum()
  return chainPoorGridNum
end

function SkillPetAttackDataComponent:SetChainPoorGridNumList(skillID, poorGridNum)
  self._chainPoorGridNumList[skillID] = poorGridNum
end

function Entity:SkillPetAttackData()
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local debugInfo = debug.getinfo(2, "S")
    local filePath = debugInfo.short_src
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call SkillPetAttackData() ", Log.traceback())
      return nil
    end
  end
  return self:GetComponent(self.WEComponentsEnum.SkillPetAttackData)
end

function Entity:HasSkillPetAttackData()
  return self:HasComponent(self.WEComponentsEnum.SkillPetAttackData)
end

function Entity:AddSkillPetAttackData()
  local index = self.WEComponentsEnum.SkillPetAttackData
  local component = SkillPetAttackDataComponent:New()
  self:AddComponent(index, component)
end

function Entity:RemoveSkillPetAttackData()
  if self:HasSkillPetAttackData() then
    self:RemoveComponent(self.WEComponentsEnum.SkillPetAttackData)
  end
end
