local SummonCategorySelectController = NewClass("SummonCategorySelectController", BaseController)

function SummonCategorySelectController:OnInit()
end

function SummonCategorySelectController:OnReset()
end

function SummonCategorySelectController:OnInitDraft(poolId, force)
  if not poolId then
    return
  end
  local model = SummonCategorySelectModel.Instance
  if force or model:GetPoolId() ~= poolId then
    model:InitDraft(poolId)
    return
  end
  if model:IsLocked() then
    model:InitDraft(poolId)
  end
end

function SummonCategorySelectController:OnOpenSelectPopup(poolId)
  if not poolId or not SummonDataUtils.IsCategorySelectPool(poolId) then
    return
  end
  if SummonDataUtils.HasConfirmedSelection(poolId) then
    return
  end
  SummonCategorySelectModel.Instance:InitDraft(poolId)
  UIManager.Instance:Reopen(Urls.SummonMixPoolLimitPanel, {poolTid = poolId})
end

function SummonCategorySelectController:_BuildOptionalLimitViewData(slot)
  local model = SummonCategorySelectModel.Instance
  local poolId = model:GetPoolId()
  local draftSlotMap = model:CopyDraftSlotMap()
  local itemTidList = SummonCategorySelectDataUtils.GetCategoryItemTidList(poolId, slot)
  itemTidList = SummonCategorySelectDataUtils.SortCategoryItemList(poolId, slot, draftSlotMap, itemTidList)
  return {
    poolTid = poolId,
    slot = slot,
    isCategorySelect = true,
    awakerItemTidList = itemTidList,
    maxSelect = 1,
    miniSelect = 1,
    confirmFunc = function(selectedItemTidList)
      local itemTid = SummonCategorySelectDataUtils.GetListItemTid(selectedItemTidList, 1)
      local activeSlot = SummonCategorySelectModel.Instance:GetActiveSlot()
      if itemTid and activeSlot then
        SummonCategorySelectController.Instance:OnSelectForSlot(activeSlot, itemTid)
      end
    end
  }
end

function SummonCategorySelectController:OnOpenCategoryList(slot)
  local model = SummonCategorySelectModel.Instance
  local poolId = model:GetPoolId()
  if not (poolId and slot) or model:IsLocked() then
    return
  end
  model:SetActiveSlot(slot)
  UIManager.Instance:Reopen(Urls.SummonOptionalLimitPanel, self:_BuildOptionalLimitViewData(slot))
end

function SummonCategorySelectController:OnSelectForSlot(slot, itemTid)
  do return SummonCategorySelectModel.Instance.SelectForSlot, SummonCategorySelectModel.Instance, slot end
  return SummonCategorySelectModel.Instance.SelectForSlot, SummonCategorySelectModel.Instance, slot, itemTid
end

function SummonCategorySelectController:OnResetDraft()
  SummonCategorySelectModel.Instance:ClearDraft()
end

function SummonCategorySelectController:OnDiscardDraft(poolId)
  SummonCategorySelectModel.Instance:DiscardDraft(poolId)
end

function SummonCategorySelectController:OnConfirmSelect()
  local model = SummonCategorySelectModel.Instance
  local poolId = model:GetPoolId()
  if not poolId then
    Logger.Error("SummonCategorySelectController.OnConfirmSelect poolId is nil")
    return
  end
  if not SummonDataUtils.IsCategorySelectPool(poolId) then
    Logger.Error("SummonCategorySelectController.OnConfirmSelect not category select pool:" .. tostring(poolId))
    return
  end
  if SummonDataUtils.HasConfirmedSelection(poolId) then
    Logger.Error("SummonCategorySelectController.OnConfirmSelect already confirmed, poolId:" .. tostring(poolId))
    return
  end
  local canConfirm, errKey = model:CanConfirm()
  if not canConfirm then
    Logger.Error("SummonCategorySelectController.OnConfirmSelect failed:" .. tostring(errKey) .. ", poolId:" .. tostring(poolId))
    return
  end
  local itemTidList = SummonCategorySelectDataUtils.BuildConfirmItemTidList(poolId, model:CopyDraftSlotMap())
  SummonDataUtils.ReqChooseMultiCategoryAwakerTargets(poolId, itemTidList)
end

return SummonCategorySelectController
