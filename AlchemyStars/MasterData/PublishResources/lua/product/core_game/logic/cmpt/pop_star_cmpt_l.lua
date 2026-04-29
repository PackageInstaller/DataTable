_class("PopStarLogicComponent", Object)
PopStarLogicComponent = PopStarLogicComponent

function PopStarLogicComponent:Constructor()
  self._popConnectPieces = {}
  self._popGridNum = 0
  self._lastPopGridNum = 0
  self._challengeIndex = 1
  self._totalWeight = 0
  self._trapRandomTab = {}
  self._trapCountDic = {}
  self._propIDDic = {}
  self._campID = 0
end

function PopStarLogicComponent:GetPopConnectPieces()
  return self._popConnectPieces
end

function PopStarLogicComponent:SetPopConnectPieces(connectPieces)
  self._popConnectPieces = connectPieces
end

function PopStarLogicComponent:GetPopGridNum()
  return self._popGridNum
end

function PopStarLogicComponent:GetLastPopGridNum()
  return self._lastPopGridNum
end

function PopStarLogicComponent:AddPopGridNum(num)
  self._popGridNum = self._popGridNum + num
  self._lastPopGridNum = num
end

function PopStarLogicComponent:GetChallengeIndex()
  return self._challengeIndex
end

function PopStarLogicComponent:SetChallengeIndex(index)
  self._challengeIndex = index
end

function PopStarLogicComponent:GetTrapRandomData()
  return self._totalWeight, self._trapRandomTab
end

function PopStarLogicComponent:SetTrapRandomData(totalWeight, trapRandomTab)
  self._totalWeight = totalWeight
  self._trapRandomTab = trapRandomTab
end

function PopStarLogicComponent:GetTrapRandomCount(trapID)
  if not self._trapCountDic[trapID] then
    return 0
  end
  return self._trapCountDic[trapID]
end

function PopStarLogicComponent:AddTrapRandomCount(trapID)
  if not self._trapCountDic[trapID] then
    self._trapCountDic[trapID] = 0
  end
  self._trapCountDic[trapID] = self._trapCountDic[trapID] + 1
end

function PopStarLogicComponent:AddPropID(num, propID)
  if self._propIDDic[num] then
    return
  end
  self._propIDDic[num] = propID
end

function PopStarLogicComponent:GetPropIDByPopNum(num)
  return self._propIDDic[num]
end

function PopStarLogicComponent:GetCampID()
  return self._campID
end

function PopStarLogicComponent:SetCampID(campID)
  self._campID = campID
end

function Entity:PopStarLogic()
  return self:GetComponent(self.WEComponentsEnum.PopStarLogic)
end

function Entity:HasPopStarLogic()
  return self:HasComponent(self.WEComponentsEnum.PopStarLogic)
end

function Entity:AddPopStarLogic()
  local index = self.WEComponentsEnum.PopStarLogic
  local component = PopStarLogicComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePopStarLogic()
  local index = self.WEComponentsEnum.PopStarLogic
  local component = PopStarLogicComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePopStarLogic()
  if self:HasPopStarLogic() then
    self:RemoveComponent(self.WEComponentsEnum.PopStarLogic)
  end
end
