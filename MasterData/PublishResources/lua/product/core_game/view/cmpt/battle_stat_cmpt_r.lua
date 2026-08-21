_class("RenderBattleStatComponent", Object)
RenderBattleStatComponent = RenderBattleStatComponent

function RenderBattleStatComponent:Constructor()
  self._everSpeed = 1
  self._finishedSequenceNoDic = {}
  self._changeTeamOrderViewQueue = {}
  self._viewQueueSequenceNo = 0
  self._currentTeamOrderRequest = nil
  self._isChangeTeamOrderViewDisabled = false
  self._trapIDBySummonCasterEntityID = {}
  self._setActorOutLineState = false
  self._isPet1702361ActiveSkillPreview = false
end

function RenderBattleStatComponent:Initialize()
end

function RenderBattleStatComponent:GetEverSpeed()
  return self._everSpeed
end

function RenderBattleStatComponent:SetEverSpeed(speed)
  if speed > self._everSpeed then
    self._everSpeed = speed
  end
end

function RenderBattleStatComponent:IsChangeTeamOrderViewDisabled()
  return self._isChangeTeamOrderViewDisabled
end

function RenderBattleStatComponent:SetChangeTeamOrderViewDisabled(v)
  self._isChangeTeamOrderViewDisabled = v
end

function RenderBattleStatComponent:GetChangeTeamOrderViewQueue()
  return self._changeTeamOrderViewQueue
end

function RenderBattleStatComponent:ClearChangeTeamOrderViewQueue()
  self._changeTeamOrderViewQueue = {}
end

function RenderBattleStatComponent:GetCurrentTeamOrderRequest()
  return self._currentTeamOrderRequest
end

function RenderBattleStatComponent:AddChangeTeamOrderViewRequest(req)
  self._viewQueueSequenceNo = self._viewQueueSequenceNo + 1
  req:SetRequestSequenceNo(self._viewQueueSequenceNo)
  table.insert(self._changeTeamOrderViewQueue, req)
end

function RenderBattleStatComponent:PopFirstTeamOrderRequestAsCurrent()
  self._currentTeamOrderRequest = table.remove(self._changeTeamOrderViewQueue, 1)
  return self._currentTeamOrderRequest
end

function RenderBattleStatComponent:MarkCurrentTeamOrderRequestFinished()
  if not self._currentTeamOrderRequest then
    return
  end
  local seqNo = self._currentTeamOrderRequest:GetRequestSequenceNo()
  self._finishedSequenceNoDic[seqNo] = true
  self._currentTeamOrderRequest = nil
end

function RenderBattleStatComponent:IsChangeTeamOrderRequestFinished(seqNo)
  return self._finishedSequenceNoDic[seqNo]
end

function RenderBattleStatComponent:AddTrapIDByCasterEntityID(trapID, casterEntityID)
  if not self._trapIDBySummonCasterEntityID[casterEntityID] then
    self._trapIDBySummonCasterEntityID[casterEntityID] = {}
  end
  if not table.icontains(self._trapIDBySummonCasterEntityID[casterEntityID], trapID) then
    table.insert(self._trapIDBySummonCasterEntityID[casterEntityID], trapID)
  end
end

function RenderBattleStatComponent:IsTrapSummonedByCasterBefore(trapID, casterEntityID)
  if not self._trapIDBySummonCasterEntityID[casterEntityID] then
    return false
  end
  return table.icontains(self._trapIDBySummonCasterEntityID[casterEntityID], trapID)
end

function RenderBattleStatComponent:SetActorOutLineState(state)
  self._setActorOutLineState = state
end

function RenderBattleStatComponent:IsActorOutLine()
  return self._setActorOutLineState
end

function RenderBattleStatComponent:IsPet1702361ActiveSkillPreview()
  return self._isPet1702361ActiveSkillPreview
end

function RenderBattleStatComponent:SetPet1702361ActiveSkillPreviewState(state)
  self._isPet1702361ActiveSkillPreview = state
end

function MainWorld:RenderBattleStat()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.RenderBattleStat)
end

function MainWorld:HasRenderBattleStat()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.RenderBattleStat) ~= nil
end

function MainWorld:AddRenderBattleStat()
  local index = self.BW_UniqueComponentsEnum.RenderBattleStat
  local component = RenderBattleStatComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveRenderBattleStat()
  if self:HasRenderBattleStat() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.RenderBattleStat, nil)
  end
end
