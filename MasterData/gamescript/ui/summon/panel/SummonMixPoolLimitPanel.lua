local SummonMixPoolLimitPanel, Super = System.NewClass("SummonMixPoolLimitPanel", UIBasePanel)
SummonMixPoolLimitPanel.uiResCls = UI_Summon_Popup_MixPoolLimitResource

function SummonMixPoolLimitPanel:ctor(viewData)
  Super.ctor(self)
  self.viewData = viewData or {}
  self.poolTid = self.viewData.poolTid
  self._slotItemList = {}
end

function SummonMixPoolLimitPanel:OnBind(binder)
  self.binder = binder
  self:_BindEvent()
  self:_RefreshView()
  CameraManager:SetUICameraModel(true)
end

function SummonMixPoolLimitPanel:OnUnbind()
  SummonCategorySelectController.Instance:OnDiscardDraft(self.poolTid)
  CameraManager:SetUICameraModel(false)
end

function SummonMixPoolLimitPanel:Close(...)
  SummonCategorySelectController.Instance:OnDiscardDraft(self.poolTid)
  Super.Close(self, ...)
end

function SummonMixPoolLimitPanel:_BindEvent()
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self.binder:BindZ1Button(self.ui.Btn_Change, System.fn(self, self._OnClickChange), function()
    do return self._GetChangeBtnType end
    return self._GetChangeBtnType, self
  end)
  self.binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm), function()
    do return self._GetConfirmBtnType end
    return self._GetConfirmBtnType, self
  end, function()
    do return self._GetConfirmBtnText end
    return self._GetConfirmBtnText, self
  end)
  self.binder:BindEvent(EventMgr.Instance.OnCategorySelectDraftChanged, System.fn(self, self._OnDraftChanged))
  self.binder:BindEvent(EventMgr.Instance.OnChooseCategorySelectAwaker, System.fn(self, self._OnChooseConfirm))
end

function SummonMixPoolLimitPanel:_OnDraftChanged(poolId)
  if poolId and poolId ~= self.poolTid then
    return
  end
  self:_RefreshView()
end

function SummonMixPoolLimitPanel:_OnChooseConfirm(summonId, _)
  if summonId and summonId ~= self.poolTid then
    return
  end
  self:Close()
end

function SummonMixPoolLimitPanel:_GetModel()
  return SummonCategorySelectModel.Instance
end

function SummonMixPoolLimitPanel:_GetSelectNum()
  do return SummonCategorySelectDataUtils.GetSelectNum end
  return SummonCategorySelectDataUtils.GetSelectNum, self.poolTid
end

function SummonMixPoolLimitPanel:_IsFull()
  local model = self:_GetModel()
  return model:GetDraftSelectedCount() >= self:_GetSelectNum() and self:_GetSelectNum() > 0
end

function SummonMixPoolLimitPanel:_ShouldShowChangeBtn()
  local model = self:_GetModel()
  return not model:IsLocked() and model:GetDraftSelectedCount() > 0
end

function SummonMixPoolLimitPanel:_GetChangeBtnType()
  if self:_ShouldShowChangeBtn() then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function SummonMixPoolLimitPanel:_GetConfirmBtnType()
  return CommonDefine.BtnType.High
end

function SummonMixPoolLimitPanel:_GetConfirmBtnText()
  if self:_IsFull() then
    do return LT.PanelText end
    return LT.PanelText, "UI_Summon_Popup_OptionalLimit_Text_C_Confirm"
  end
  do return LT.PanelText end
  return LT.PanelText, "UI_Summon_Popup_MixPoolLimit_Text_C_Choose"
end

function SummonMixPoolLimitPanel:_RefreshConfirmBtn()
  local btnGO = self.ui.Btn_Confirm
  if not btnGO then
    return
  end
  self.binder:SetButtonState(btnGO, self:_GetConfirmBtnType())
  local buttonComp = self:GetButton(btnGO)
  if buttonComp and buttonComp.buttonTextComp then
    self.binder:SetText(buttonComp.buttonTextComp, self:_GetConfirmBtnText())
  end
end

function SummonMixPoolLimitPanel:_RefreshChangeBtn()
  local showChangeBtn = self:_ShouldShowChangeBtn()
  self.binder:SetActive(self.ui.Btn_Change, showChangeBtn)
  if showChangeBtn then
    self.binder:SetButtonState(self.ui.Btn_Change, self:_GetChangeBtnType())
  end
  if self.ui.Btn_Confirm then
    local parentRt = self.ui.Btn_Confirm.transform.parent
    if parentRt then
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentRt)
    end
  end
end

function SummonMixPoolLimitPanel:_RefreshView()
  if self._isRefreshing then
    return
  end
  self._isRefreshing = true
  local model = self:_GetModel()
  if model:GetPoolId() ~= self.poolTid then
    SummonCategorySelectController.Instance:OnInitDraft(self.poolTid)
  end
  self.binder:SetText(self.ui.Text_Desc, LT.Text("SummonType_17SelectPanelDesc"))
  self:_RefreshSlotItems()
  self:_RefreshChangeBtn()
  self:_RefreshConfirmBtn()
  self._isRefreshing = false
end

function SummonMixPoolLimitPanel:_RefreshSlotItems()
  local selectNum = self:_GetSelectNum()
  local itemGo = self.ui.UI_Summon_Item_MixPoolLimit
  if not itemGo then
    return
  end
  self.binder:SetActive(itemGo, false)
  local model = self:_GetModel()
  for slot = 1, selectNum do
    local item = self._slotItemList[slot]
    if not item then
      local gameObj = self.binder:Instantiate(itemGo, itemGo.transform.parent)
      self.binder:SetActive(gameObj, true)
      item = self.binder:BindComponent(SummonMixPoolLimitItemComp(gameObj, self.poolTid, slot, System.fn(self, self._OnClickSlot)))
      self._slotItemList[slot] = item
    else
      self.binder:SetActive(item.ui.uiNode, true)
    end
    item:UpdateItemTid(model:GetDraftItemTid(slot))
  end
  for slot = selectNum + 1, #self._slotItemList do
    local item = self._slotItemList[slot]
    if item then
      self.binder:SetActive(item.ui.uiNode, false)
    end
  end
end

function SummonMixPoolLimitPanel:_OnClickSlot(slot)
  SummonCategorySelectController.Instance:OnOpenCategoryList(slot)
end

function SummonMixPoolLimitPanel:_OnClickChange()
  if not self:_ShouldShowChangeBtn() then
    return
  end
  SummonCategorySelectController.Instance:OnResetDraft()
end

function SummonMixPoolLimitPanel:_OnClickConfirm()
  if not self:_IsFull() then
    local emptySlot = self:_GetModel():GetFirstEmptySlot()
    if emptySlot then
      self:_OnClickSlot(emptySlot)
    end
    return
  end
  local canConfirm, errKey = self:_GetModel():CanConfirm()
  if not canConfirm then
    Logger.Error("SummonMixPoolLimitPanel confirm failed:" .. tostring(errKey))
    return
  end
  local tipsTypeTid = "SummonType_17SelectConfirm"
  local tipsTypeCfg = DT.TipsType[tipsTypeTid]
  if not tipsTypeCfg then
    SummonCategorySelectController.Instance:OnConfirmSelect()
    return
  end
  local nameList = self:_GetDraftAwakerNames()
  local desc = LT.Textf(tipsTypeCfg.Desc, table.unpack(nameList))
  Alert.Show(tipsTypeTid, nil, System.fn(self, self._DoConfirm), nil, desc)
end

function SummonMixPoolLimitPanel:_DoConfirm()
  SummonCategorySelectController.Instance:OnConfirmSelect()
end

function SummonMixPoolLimitPanel:_GetDraftAwakerNames()
  do return SummonCategorySelectDataUtils.GetDraftAwakerNames, self.poolTid, self:_GetModel():CopyDraftSlotMap() end
  return SummonCategorySelectDataUtils.GetDraftAwakerNames, self.poolTid, self:_GetModel():CopyDraftSlotMap()
end

return SummonMixPoolLimitPanel
