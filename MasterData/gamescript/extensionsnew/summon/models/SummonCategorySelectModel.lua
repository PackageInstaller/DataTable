local SummonCategorySelectModel = NewClass("SummonCategorySelectModel", BaseModel)

function SummonCategorySelectModel:OnInit()
  self:OnReset()
  EventMgr.Instance.OnChooseCategorySelectAwaker:RegisterEvent(System.fn(self, self.OnChooseCategorySelectAwaker))
end

function SummonCategorySelectModel:OnReset()
  self.poolId = nil
  self.activeSlot = 1
  self.locked = false
  self.draftSlot2ItemTid = {}
end

function SummonCategorySelectModel:OnChooseCategorySelectAwaker(summonId, _)
  if self.poolId and summonId == self.poolId then
    self.locked = true
    self:Notify(NotifyId.OnChooseCategorySelectAwaker, summonId)
  end
end

function SummonCategorySelectModel:_NotifyDraftChanged()
  self:Notify(NotifyId.OnCategorySelectDraftChanged)
  EventMgr.Instance.OnCategorySelectDraftChanged:Dispatch(self.poolId)
end

function SummonCategorySelectModel:InitDraft(poolId)
  self.poolId = poolId
  self.activeSlot = 1
  self.draftSlot2ItemTid = {}
  self.locked = SummonDataUtils.HasConfirmedSelection(poolId)
  self:_NotifyDraftChanged()
end

function SummonCategorySelectModel:GetPoolId()
  return self.poolId
end

function SummonCategorySelectModel:IsLocked()
  return self.locked == true
end

function SummonCategorySelectModel:GetActiveSlot()
  return self.activeSlot
end

function SummonCategorySelectModel:SetActiveSlot(slot)
  if not slot then
    return
  end
  self.activeSlot = slot
end

function SummonCategorySelectModel:GetDraftItemTid(slot)
  return self.draftSlot2ItemTid[slot]
end

function SummonCategorySelectModel:CopyDraftSlotMap()
  do return SummonCategorySelectDataUtils.CopyDraftSlotMap end
  return SummonCategorySelectDataUtils.CopyDraftSlotMap, self.draftSlot2ItemTid
end

function SummonCategorySelectModel:GetDraftSelectedCount()
  do return SummonCategorySelectDataUtils.GetDraftSelectedCount, self.poolId end
  return SummonCategorySelectDataUtils.GetDraftSelectedCount, self.poolId, self.draftSlot2ItemTid
end

function SummonCategorySelectModel:GetFirstEmptySlot()
  do return SummonCategorySelectDataUtils.GetFirstEmptySlot, self.poolId end
  return SummonCategorySelectDataUtils.GetFirstEmptySlot, self.poolId, self.draftSlot2ItemTid
end

function SummonCategorySelectModel:CanSelectItem(slot, itemTid)
  if self.locked then
    return false
  end
  if not SummonCategorySelectDataUtils.IsItemInCategory(self.poolId, slot, itemTid) then
    return false
  end
  local conflictSlot = SummonCategorySelectDataUtils.GetConflictSlot(self.poolId, itemTid, self.draftSlot2ItemTid, slot)
  if conflictSlot then
    return false, conflictSlot
  end
  return true
end

function SummonCategorySelectModel:SelectForSlot(slot, itemTid)
  local canSelect, conflictSlot = self:CanSelectItem(slot, itemTid)
  if not canSelect then
    return false, conflictSlot
  end
  self.draftSlot2ItemTid[slot] = itemTid
  self.activeSlot = slot
  self:_NotifyDraftChanged()
  return true
end

function SummonCategorySelectModel:ClearSlot(slot)
  if self.locked or not slot then
    return
  end
  self.draftSlot2ItemTid[slot] = nil
  self:_NotifyDraftChanged()
end

function SummonCategorySelectModel:ClearDraft()
  if self.locked then
    return
  end
  self.draftSlot2ItemTid = {}
  self.activeSlot = 1
  self:_NotifyDraftChanged()
end

function SummonCategorySelectModel:DiscardDraft(poolId)
  if self.locked then
    return
  end
  if poolId and self.poolId and self.poolId ~= poolId then
    return
  end
  self.poolId = nil
  self.activeSlot = 1
  self.draftSlot2ItemTid = {}
  self:_NotifyDraftChanged()
end

function SummonCategorySelectModel:CanConfirm()
  if self.locked then
    return false, "AlreadyConfirmed"
  end
  do return SummonCategorySelectDataUtils.CanConfirm, self.poolId end
  return SummonCategorySelectDataUtils.CanConfirm, self.poolId, self.draftSlot2ItemTid
end

return SummonCategorySelectModel
