local EditTrinketSuitPlanModel, Super = NewClass("EditTrinketSuitPlanModel", TrinketListBaseModel)

function EditTrinketSuitPlanModel:OnInit()
  self:OnReset()
end

function EditTrinketSuitPlanModel:OnReset()
  Super.OnReset(self)
  self.suitPlanId = 0
  self.curTrinkets = nil
end

function EditTrinketSuitPlanModel:ResetTrinketSuitPlanEditedData(planId)
  self.curChoosenTrinketUid = 0
  self:SetPlanId(planId)
  EditTrinketSuitPlanModel.Instance:ResetByPartType(1)
end

function EditTrinketSuitPlanModel:SetPlanId(planId)
  self.suitPlanId = planId
  local trinkets = AwakerTrinketExtModel.Instance:GetPlanTrinkets(planId)
  if not trinkets then
    self.curTrinkets = TrinketModel.CopyAwakerTrinkets()
  else
    self.curTrinkets = TrinketModel.CopyAwakerTrinkets(trinkets)
  end
end

function EditTrinketSuitPlanModel:NeedSavePlan()
  if not TrinketModel.Instance:ExistsAnyTrinkets(self.curTrinkets) then
    return false
  end
  local suitPlanId = AwakerTrinketExtModel.Instance:GetPlanIdByTrinkets(self.curTrinkets)
  if 0 == suitPlanId then
    return true
  end
  if suitPlanId ~= self.suitPlanId then
    return true
  end
  return false
end

function EditTrinketSuitPlanModel:GetPlanId()
  return self.suitPlanId
end

function EditTrinketSuitPlanModel:SetCurEditingPartType(partType)
  self.partType = partType
  self:CalFilterTrinketsList()
  self:LocalNotify(NotifyId.OnEditTrinketPlanPartTypeChanged, partType)
end

function EditTrinketSuitPlanModel:GetCurEditingPartType()
  return self.partType
end

function EditTrinketSuitPlanModel:SetCurEditingChoosingTrinketUid(curChoosenTrinketUid)
  if self.curChoosenTrinketUid ~= curChoosenTrinketUid then
    local lastUid = self.curChoosenTrinketUid
    self.curChoosenTrinketUid = curChoosenTrinketUid
    self:LocalNotify(NotifyId.OnEditTrinketChoosenChanged, curChoosenTrinketUid, lastUid)
  end
end

function EditTrinketSuitPlanModel:GetCurEditingChoosingTrinketUid()
  return self.curChoosenTrinketUid
end

function EditTrinketSuitPlanModel:GetEditTrinketUidOnPart(part)
  return self.curTrinkets[part] or 0
end

function EditTrinketSuitPlanModel:GetCurEquipTrinketUid()
  do return self.GetEditTrinketUidOnPart, self end
  return self.GetEditTrinketUidOnPart, self, self.partType
end

function EditTrinketSuitPlanModel:_GetListExemptUid()
  do return self.GetCurEquipTrinketUid end
  return self.GetCurEquipTrinketUid, self
end

function EditTrinketSuitPlanModel:GetCurTrinkets()
  return self.curTrinkets
end

function EditTrinketSuitPlanModel:IsEquipAnyTrinkets()
  if not self.curTrinkets then
    return false
  end
  do return TrinketModel.Instance.ExistsAnyTrinkets, TrinketModel.Instance end
  return TrinketModel.Instance.ExistsAnyTrinkets, TrinketModel.Instance, self.curTrinkets
end

function EditTrinketSuitPlanModel:IsTrinketInCurPlan(trinketUid)
  if not self.curTrinkets then
    return false
  end
  for _, v in pairs(self.curTrinkets) do
    if v == trinketUid then
      return true
    end
  end
  return false
end

function EditTrinketSuitPlanModel:PutOffTrinket(uid)
  if not self.curTrinkets then
    return
  end
  for k, v in pairs(self.curTrinkets) do
    if v == uid then
      self.curTrinkets[k] = 0
      break
    end
  end
  self:LocalNotify(NotifyId.OnSuitPlanUnequipedTrinket, uid)
end

function EditTrinketSuitPlanModel:PutOnTrinket(uid)
  if not self.curTrinkets then
    return
  end
  local trinket = ItemDataUtils.GetItemByUid(uid)
  if not trinket then
    return
  end
  local pos = ItemDataUtils.GetTrinketPosIndex(trinket)
  self.curTrinkets[pos] = uid
  self:LocalNotify(NotifyId.OnSuitPlanEquipedTrinket, uid)
end

function EditTrinketSuitPlanModel:TakeOffAllTrinkets()
  if not self.curTrinkets then
    return
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    self.curTrinkets[i] = 0
  end
  self:LocalNotify(NotifyId.OnSuitPlanTakeoffAllTrinkets)
end

function EditTrinketSuitPlanModel:IsTrinketInOtherPlan(uid)
  local curPlanId = self:GetPlanId()
  local planId = AwakerTrinketExtModel.Instance:GetTrinketPlanId(uid)
  if 0 ~= planId and planId ~= curPlanId then
    return true
  else
    return false
  end
end

function EditTrinketSuitPlanModel:_SortCurFilterTrinkets()
  self.curFilterTrinkets = self:_SortTrinkets(self.curFilterTrinkets)
  local list0 = {}
  local list1 = {}
  for _, v in pairs(self.curFilterTrinkets) do
    if self:IsTrinketInOtherPlan(v.uid) then
      table.insert(list1, v)
    else
      table.insert(list0, v)
    end
  end
  list0 = self:_SortTrinkets(list0)
  list1 = self:_SortTrinkets(list1)
  table.clear(self.curFilterTrinkets)
  table.append(self.curFilterTrinkets, list0)
  table.append(self.curFilterTrinkets, list1)
end

function EditTrinketSuitPlanModel:DeleteTrinketFromTrinketsList(trinketUids)
  if not trinketUids then
    return
  end
  if self.curTrinkets then
    for _, uid in pairs(trinketUids) do
      for i = 1, CommonDefine.MaxEquipTrinketsNum do
        if self.curTrinkets[i] == uid then
          self.curTrinkets[i] = 0
          break
        end
      end
    end
  end
  Super.DeleteTrinketFromTrinketsList(self, trinketUids)
end

return EditTrinketSuitPlanModel
