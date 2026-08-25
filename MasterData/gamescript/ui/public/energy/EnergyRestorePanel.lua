local EnergyRestorePanel, Super = System.NewClass("EnergyRestorePanel", UIBasePanel)
EnergyRestorePanel.uiResCls = UI_Other_Popup_Key_Time_RevertResource

function EnergyRestorePanel:ctor(data)
  Super.ctor(self)
  self.data = data
end

function EnergyRestorePanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnClickComfirm))
  binder:BindToText(self.ui.Text_Time, function()
    local maxBuyTimes = PlayerDataUtils.GetEnergyMaxBuyTimes()
    local leftBuyTimes = PlayerDataUtils.GetEnergyLeftBuyTimes()
    local buyTimesStr = LT.Textf("Energy_Revert_Str_Time", leftBuyTimes, maxBuyTimes)
    return buyTimesStr
  end)
  local currEnergy = PlayerDataUtils.GetEnergy()
  local nextEnergy = currEnergy + PlayerDataUtils.GetEnergyRestoreNum(DataCenter.playerData.DRole.level)
  local maxStoreEnergy = PlayerDataUtils.GetMaxStoreEnergy()
  binder:SetText(self.ui.Text_Ticket_Now, currEnergy)
  binder:SetText(self.ui.Text_Ticket_Next, nextEnergy >= maxStoreEnergy and maxStoreEnergy or nextEnergy)
  local currBuyMoney = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.SeniorMoney)
  local costMoney = PlayerDataUtils.GetCurrentBuyEnergyCost()
  binder:SetText(self.ui.Text_Diamond_Now, currBuyMoney)
  binder:SetText(self.ui.Text_Diamond_Next, costMoney)
  self:BindButtonState()
end

function EnergyRestorePanel:BindButtonState()
  local binder = self.binder
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnClickComfirm), function()
    return self:CanRestore() and CommonDefine.BtnType.High or CommonDefine.BtnType.Disabled
  end, function()
    do return LT.Text end
    return LT.Text, "Ticket_Revert_Btn_Sure"
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.Close), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Ticket_Revert_Btn_Return"
  end)
end

function EnergyRestorePanel:CanRestore()
  local leftBuyTimes = PlayerDataUtils.GetEnergyLeftBuyTimes()
  if leftBuyTimes <= 0 then
    return false
  end
  local cost = PlayerDataUtils.GetCurrentBuyEnergyCost()
  if -1 == cost then
    return false
  end
  local itemData = ItemDataUtils.GetItemByTid(CommonDefine.CurrencyType.SeniorMoney)
  local own = itemData and itemData.num or 0
  if cost > own then
    return false
  end
  local storeMax = PlayerDataUtils.GetMaxStoreEnergy()
  if storeMax <= PlayerDataUtils.GetEnergy() then
    return false
  end
  return true
end

function EnergyRestorePanel:OnClickComfirm()
  local leftBuyTimes = PlayerDataUtils.GetEnergyLeftBuyTimes()
  if leftBuyTimes <= 0 then
    Alert.Show(10440)
    return
  end
  local storeMax = PlayerDataUtils.GetMaxStoreEnergy()
  if storeMax <= PlayerDataUtils.GetEnergy() then
    Alert.Show(10445)
    return
  end
  local cost = PlayerDataUtils.GetCurrentBuyEnergyCost()
  local own = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.SeniorMoney)
  if cost > own then
    DiamondShopDataUtils.RechargeTips(cost - own)
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnBuyEnergy", function(data)
    Logger.Info("OnBuyEnergy", table.tostring(data))
    Alert.ShowStr("购买成功")
    self:ClosePanel()
  end)
end

function EnergyRestorePanel:Close()
  if self.data.cancelCallback then
    self.data.cancelCallback()
  end
  self:ClosePanel()
end

function EnergyRestorePanel:ClosePanel()
  Super.Close(self)
end

return EnergyRestorePanel
