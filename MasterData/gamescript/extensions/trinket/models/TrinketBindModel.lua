local TrinketChoosenType = CommonDefine.TrinketChoosenType
local TrinketBindModel, Super = NewClass("TrinketBindModel", TrinketListBaseModel)

function TrinketBindModel:OnInit()
  self:OnReset()
end

function TrinketBindModel:OnReset()
  Super.OnReset(self)
  self.awakerData = nil
  self.curBoundTrinkets = nil
  self.trinketChoosenType = TrinketChoosenType.SingleTrinket
end

function TrinketBindModel:ResetByAwakerData(awakerData, boundTrinkets)
  self.awakerData = awakerData
  self.curBoundTrinkets = TrinketModel.CopyAwakerTrinkets(boundTrinkets)
  self.curChoosenTrinketUid = 0
  self.trinketChoosenType = TrinketChoosenType.SingleTrinket
  self:ResetByPartType(1)
end

function TrinketBindModel:IsBindMode()
  return true
end

function TrinketBindModel:GetCurAwakerTid()
  return self.awakerData and self.awakerData.tid or 0
end

function TrinketBindModel:GetCurTrinketChoosenType()
  return self.trinketChoosenType
end

function TrinketBindModel:SetCurTrinketChoosenType(trinketChoosenType)
  if trinketChoosenType ~= TrinketChoosenType.SingleTrinket then
    return
  end
  if self.trinketChoosenType ~= trinketChoosenType then
    self.trinketChoosenType = trinketChoosenType
    self.curChoosenTrinketUid = 0
    self:CalFilterTrinketsList()
    self:LocalNotify(NotifyId.OnTrinketChoosenTypeChanged, trinketChoosenType)
  end
end

function TrinketBindModel:SetCurPartType(partType)
  self.partType = partType
  self:CalFilterTrinketsList()
  self:LocalNotify(NotifyId.OnTrinketChoosenPartTypeChanged, partType)
end

function TrinketBindModel:GetCurPartType()
  return self.partType
end

function TrinketBindModel:SetCurChoosenTrinketUid(curChoosenTrinketUid)
  local lastUid = self.curChoosenTrinketUid
  self.curChoosenTrinketUid = curChoosenTrinketUid
  self:LocalNotify(NotifyId.OnTrinketChoosen, curChoosenTrinketUid, lastUid)
end

function TrinketBindModel:GetCurChoosenTrinketUid()
  return self.curChoosenTrinketUid
end

function TrinketBindModel:GetCurBoundTrinketsUidList()
  return self.curBoundTrinkets
end

function TrinketBindModel:GetCurShowTrinkets()
  return self.curBoundTrinkets
end

function TrinketBindModel:GetCurEquipTrinketUid()
  if not self.curBoundTrinkets then
    return 0
  end
  return self.curBoundTrinkets[self.partType] or 0
end

function TrinketBindModel:_GetListExemptUid()
  do return self.GetCurEquipTrinketUid end
  return self.GetCurEquipTrinketUid, self
end

function TrinketBindModel:GetCurPartBoundTrinketUid()
  local awakerTid = self:GetCurAwakerTid()
  if not awakerTid or 0 == awakerTid then
    return 0
  end
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(awakerTid, self.partType)
  if 0 == boundUid then
    return 0
  end
  if not ItemDataUtils.GetItemByUid(boundUid) then
    return 0
  end
  return boundUid
end

function TrinketBindModel:GetTrinketOwnerTid(trinketUid)
  if not trinketUid or 0 == trinketUid then
    return 0
  end
  if not self.curBoundTrinkets then
    return 0
  end
  for _, v in pairs(self.curBoundTrinkets) do
    if v == trinketUid then
      return self:GetCurAwakerTid()
    end
  end
  return 0
end

function TrinketBindModel:CalFilterTrinketsList()
  self:_RefreshBoundTrinketsSnapshot()
  Super.CalFilterTrinketsList(self)
end

function TrinketBindModel:_RefreshBoundTrinketsSnapshot()
  local awakerTid = self:GetCurAwakerTid()
  if not awakerTid or 0 == awakerTid then
    return
  end
  self.curBoundTrinkets = TrinketModel.CopyAwakerTrinkets(AwakerDataUtils.GetBoundTrinkets(awakerTid))
end

function TrinketBindModel:DeleteTrinketFromTrinketsList(trinketUids)
  if not trinketUids then
    return
  end
  if self.curBoundTrinkets then
    for _, uid in pairs(trinketUids) do
      for i = 1, CommonDefine.MaxEquipTrinketsNum do
        if self.curBoundTrinkets[i] == uid then
          self.curBoundTrinkets[i] = 0
        end
      end
    end
  end
  Super.DeleteTrinketFromTrinketsList(self, trinketUids)
end

return TrinketBindModel
