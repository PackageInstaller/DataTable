local WorldStageEnchantConfirmPanel, Super = System.NewClass("WorldStageEnchantConfirmPanel", UIBasePanel)
WorldStageEnchantConfirmPanel.uiResCls = UI_Dbgcopy_Popup_Remove_EnchantmentResource

function WorldStageEnchantConfirmPanel:ctor(uid, configId, runeTid, confirmCb, cancelCb)
  Super.ctor(self)
  self.uid = uid
  self.configId = configId
  self.runeTid = runeTid
  self.confirmCb = confirmCb
  self.cancelCb = cancelCb
  self.runeConfig = DT.EnchantConfig[self.runeTid]
end

function WorldStageEnchantConfirmPanel:OnBind(binder)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "StoreEnchantmentConfirm"
  end)
  binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base_1, self.uid, self.configId, false))
  local comp2 = binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base_2, self.uid, self.configId, false))
  comp2:EnableRuneList(self.runeTid)
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnConfirmClick), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "StoreEnchantmentConfirm"
  end, nil, nil, nil)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.Close), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "StoreEnchantmentCancel"
  end, nil, nil, nil)
end

function WorldStageEnchantConfirmPanel:OnConfirmClick()
  if self.confirmCb then
    self.confirmCb()
  end
  Super.Close(self)
end

function WorldStageEnchantConfirmPanel:Close()
  if self.cancelCb then
    self.cancelCb()
  end
  Super.Close(self)
end

return WorldStageEnchantConfirmPanel
