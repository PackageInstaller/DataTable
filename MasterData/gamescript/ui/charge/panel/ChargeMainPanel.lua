local ChargeMainPanel, Super = System.NewClass("ChargeMainPanel", UIBasePanel)
ChargeMainPanel.uiResCls = UI_Recharge_Panel_ExtractResource

function ChargeMainPanel:_GetUIResCls()
  local chargeConfig = ShopDataUtils.GetChargeConfig()
  local itemCount = 0
  for _, config in pairs(chargeConfig) do
    if config.Type == CommonDefine.ChagreType.Recharge and config.Channel == SdkMgr.Instance.model.packageChannel and (not config.PCExclusive or 0 == config.PCExclusive or ApplicationUtils.IsWindowsOrEditor()) then
      itemCount = itemCount + 1
    end
  end
  if itemCount > 6 then
    self.uiResCls = UI_Recharge_Panel_ExtractPCResource
  end
  return self.uiResCls
end

function ChargeMainPanel:ctor()
  Super.ctor(self)
  SdkMgr.Instance:ResetCountryCode()
end

function ChargeMainPanel:OnBind(binder)
  local model = binder:createModel(ChargeMainPanelModel)
  self.model = model
  self:_BindCurrency(binder, model)
  self:_BindChargeGroup(binder, model)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  if self.ui.Btn_Law1 then
    binder:BindButtonClick(self.ui.Btn_Law1, System.fn(self, self.OnLaw1))
  end
  if self.ui.Btn_Law2 then
    binder:BindButtonClick(self.ui.Btn_Law2, System.fn(self, self.OnLaw2))
  end
end

function ChargeMainPanel:_BindCurrency(binder)
  local currencyList = DT.GetOriginalConstant("ChargePanelCurrencies")
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, currencyList, false, true))
end

function ChargeMainPanel:_BindChargeGroup(binder)
  binder:BindButtonClick(self.ui.Btn_Service, self.OnCustomerService)
  if SteamSdk.Instance:IsNativeSteamSdk() then
    self.ui.Btn_Service:SetActive(false)
  end
  binder:BindToCircularListView(self.ui.ScrollView_Reset, function()
    return self.model.showRechargeItemList
  end, function(itemBinder, item, index)
    local tid = self.model.showRechargeItemList[index].tid
    local isDouble = self.model.showRechargeItemList[index].isDouble
    local sdkData
    for _, data in pairs(self.model.productList) do
      if data.product_id == DT.Charge[tid].PayCode then
        sdkData = data
        break
      end
    end
    local itemData = {
      chargeId = tid,
      isDouble = isDouble,
      sdkData = sdkData,
      defaultPrice = DT.Constant.ChargePriceListShow.Data[index]
    }
    itemBinder:BindComponent(MainShopChargeItem(item, itemData))
  end)
  binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Reset)
end

function ChargeMainPanel.OnCustomerService()
  SdkMgr.GetCustomerService()
end

function ChargeMainPanel:OnLaw1()
  SdkMgr.Instance:ShowUserAgreement(2)
end

function ChargeMainPanel:OnLaw2()
  SdkMgr.Instance:ShowUserAgreement(3)
end

function ChargeMainPanel:StackTopUIAudioProcess(lastCloseUI)
  AudioManager.Instance:PostSoundEvent("Set_State_Aa_Interface_Store_Charge")
end

function ChargeMainPanel:_CheckOpenAgeVerificationView()
  if PlayerDataUtils.GetAgeAuthentication() ~= nil and PlayerDataUtils.GetAgeAuthentication() ~= "" then
    return
  end
  self:LoadHideLowerLayerPanelCb(function()
    UIManager.Instance:Reopen(Urls.AgeVerificationView)
  end)
end

return ChargeMainPanel
