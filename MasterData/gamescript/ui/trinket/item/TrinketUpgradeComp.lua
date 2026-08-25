local TrinketUpgradeComp, Super = System.NewComponent("TrinketUpgradeComp")

function TrinketUpgradeComp:ctor(uiNode, strengthenModel, trinketModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_UpgradeResource(uiNode)
  self.strengthenModel = strengthenModel
  self.trinketModel = trinketModel
  AlchemyExchangeExtModel.Instance:ClearExchangePlan()
end

function TrinketUpgradeComp:OnBind(binder)
  self.binder = binder
  self:BindTrinketInfo(binder)
  self:BindUpgrade(binder)
  self:BindUpgradeCurrencyCost(binder)
  self:BindMainProp(binder)
  self:InitLabels(binder)
  self:BindUpgradeType(binder)
  self.matTypeComp = TrinketUpgradeUsingMaterialsComp(self.ui, self.strengthenModel)
  self.matTypeComp:OnBind(binder)
  binder:BindEvent(EventMgr.Instance.OnExchangePlanChanged, function()
    self.strengthenModel:RefreshExchangePlanVersion()
  end)
end

function TrinketUpgradeComp:InitLabels(binder)
  binder:SetText(self.ui.Text_C_Consume, LT.Text("TrinketUpgradeConsume"))
  binder:SetText(self.ui.Text_C_Name_3, LT.Text("TrinketUpgrade"))
  binder:SetText(self.ui.Text_C_Fast_Normal, LT.Text("TrinketsUpgradeOne"))
  binder:SetText(self.ui.Text_C_Fast_High, LT.Text("TrinketsUpgradeOne"))
  binder:SetText(self.ui.Text_C_Max_Normal, LT.Text("TrinketsUpgradeMax"))
  binder:SetText(self.ui.Text_C_Max_High, LT.Text("TrinketsUpgradeMax"))
  binder:SetText(self.ui.Text_C_MaxLevel, LT.Text("TrinketsUpgradeMaxLevel"))
end

function TrinketUpgradeComp:BindUpgradeType(binder)
  binder:BindButtonClick(self.ui.Btn_UpgradeLevel, function()
    self.strengthenModel:SetUpgradeType(CommonDefine.TrinketUpgradeType.One)
  end, function()
    if self.strengthenModel:GetUpgradeType() ~= CommonDefine.TrinketUpgradeType.One then
      return CommonDefine.Z1ButtonState.Normal
    end
    return CommonDefine.Z1ButtonState.High
  end)
  binder:BindButtonClick(self.ui.Btn_UpgradeMaxLevel, function()
    self.strengthenModel:SetUpgradeType(CommonDefine.TrinketUpgradeType.Max)
  end, function()
    if self.strengthenModel:GetUpgradeType() ~= CommonDefine.TrinketUpgradeType.Max then
      return CommonDefine.Z1ButtonState.Normal
    end
    return CommonDefine.Z1ButtonState.High
  end)
  binder:BindButtonClick(self.ui.Btn_Exchange, System.fn(self, self._OnClickExchange))
end

function TrinketUpgradeComp:_OnClickExchange()
  UIManager.Instance:Reopen(Urls.AlchemyExchangeItemBagView, true)
end

function TrinketUpgradeComp:BindTrinketInfo(binder)
  binder:BindToImage(self.ui.Image_Icon, function()
    do return self.strengthenModel.GetTrinketIcon end
    return self.strengthenModel.GetTrinketIcon, self.strengthenModel
  end)
  local iconLightComp = UICompTrinketIconMat(self.ui.Image_Icon, {binder = binder})
  binder:BindToRaw(function(_, hasBound, _)
    local partIndex = AwakerTrinketDataUtils.GetTrinketLightPartIndex(self.strengthenModel.trinketTid)
    iconLightComp:EnableLight(true == hasBound, partIndex)
  end, function()
    do return AwakerTrinketDataUtils.IsTrinketBoundForLight end
    return AwakerTrinketDataUtils.IsTrinketBoundForLight, self.strengthenModel.trinketUid
  end)
  self._iconLightComp = iconLightComp
  binder:BindToText(self.ui.Text_Name, function()
    do return self.strengthenModel.GetTrinketName end
    return self.strengthenModel.GetTrinketName, self.strengthenModel
  end)
  binder:BindToText(self.ui.Text_Foundation_1, function()
    local level = self.strengthenModel:GetTrinketLevel()
    do return string.format, "+%s" end
    return string.format, "+%s", level
  end)
  binder:BindToText(self.ui.Text_Hoist_1, function()
    local level = self.strengthenModel:GetTrinketUpgradeLevel()
    do return string.format, "+%s" end
    return string.format, "+%s", level
  end)
  binder:BindToText(self.ui.Text_CompletRate_Cur, function()
    local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.strengthenModel.trinketUid)
    return completRate .. "%"
  end)
  binder:BindToText(self.ui.Text_CompletRate_Next, function()
    local completRate = AwakerTrinketDataUtils.GetTrinketPreviewCompletionRate(self.strengthenModel.trinketUid, self.strengthenModel.trinketUpgradeLevel)
    return completRate .. "%"
  end)
  local position = AwakerTrinketDataUtils.GetStrengthTrinketIconPosTable(self.strengthenModel.trinketTid)
  self.ui.Image_Icon.transform.anchoredPosition = CS.UnityEngine.Vector2(position[1], position[2])
end

function TrinketUpgradeComp:BindMainProp(binder)
  binder:BindToText(self.ui.Text_Main, function()
    local mainAttr = self.trinketModel:GetMainAttr(self.strengthenModel.trinketUid)
    local tid = mainAttr.tid
    if not tid or 0 == tid then
      return ""
    end
    do return LT.Text end
    return LT.Text, DT.ActorAttrType[tid].Text
  end)
  binder:BindToText(self.ui.Text_Foundation_2, function()
    local mainAttr = self.trinketModel:GetMainAttr(self.strengthenModel.trinketUid)
    local textCount = AwakerTrinketDataUtils.GetAttrFmtString(mainAttr)
    local itemData = ItemDataUtils.GetItemByUid(self.strengthenModel.trinketUid)
    if AwakerTrinketDataUtils.IsTrinketBindBonusActive(itemData) then
      textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(AwakerTrinketDataUtils.GetBindBonusDisplayCount(mainAttr.count, mainAttr.isPercent), mainAttr.isPercent)
      textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
    end
    return textCount
  end)
  binder:BindToImage(self.ui.Image_Main_Icon, function()
    local mainAttr = self.trinketModel:GetMainAttr(self.strengthenModel.trinketUid)
    local tid = mainAttr.tid
    if not tid or 0 == tid then
      return ""
    end
    return DT.ActorAttrType[tid].Icon
  end)
  binder:BindToText(self.ui.Text_Hoist_2, function()
    local trinketUpgradeLevel = self.strengthenModel.trinketUpgradeLevel
    if trinketUpgradeLevel <= self.strengthenModel.trinketCurrLevel then
      return ""
    end
    local mainAttr = self.trinketModel:GetMainAttr(self.strengthenModel.trinketUid)
    local value = self.strengthenModel:GetTrinketMainAttrValue(trinketUpgradeLevel, mainAttr.tid)
    local textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(value, mainAttr.isPercent)
    local itemData = ItemDataUtils.GetItemByUid(self.strengthenModel.trinketUid)
    if AwakerTrinketDataUtils.IsTrinketBindBonusActive(itemData) then
      textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(AwakerTrinketDataUtils.GetBindBonusDisplayCount(value, mainAttr.isPercent), mainAttr.isPercent)
      textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
    end
    return textCount
  end)
  binder:BindToRaw(function(childBinder, v, _)
    childBinder:SetActive(self.ui.Main_PropAdd, v)
    childBinder:SetActive(self.ui.ImageText_Foundation_2_Arrow, v)
    childBinder:SetActive(self.ui.Text_Hoist_2, v)
    childBinder:SetActive(self.ui.Image_Arrowhead, v)
    childBinder:SetActive(self.ui.Image_CompletRate_Arrow, v)
  end, function()
    local trinketUpgradeLevel = self.strengthenModel.trinketUpgradeLevel
    if trinketUpgradeLevel <= self.strengthenModel.trinketCurrLevel then
      return false
    end
    return true
  end)
end

function TrinketUpgradeComp:BindUpgrade(binder)
  binder:BindButtonClick(self.ui.Btn_Level, function()
    local curLevel = self.strengthenModel.trinketCurrLevel
    
    local function OnReqSuccess(svrData)
      UIManager.Instance:Reopen(Urls.TrinketUpdradeSuccessPanel, self.strengthenModel.trinketUid, curLevel, self.strengthenModel.trinketCurrLevel)
    end
    
    self.strengthenModel:ReqUpgradeTrinket(OnReqSuccess)
  end, function()
    local state = CommonDefine.BtnType.High
    if not self.strengthenModel:CanStrengthen() then
      state = CommonDefine.BtnType.Unclickable
    end
    return state
  end, function()
    do return LT.Text end
    return LT.Text, "AwakerTrinketStrengthenBtnText"
  end)
  binder:BindToRaw(function(childBinder, showData, _)
    local maxLevel = self.strengthenModel:GetTrinketMaxLevel()
    local isMaxLevel = maxLevel <= showData.currLevel
    self.ui.NodeToMaxLevel:SetActive(isMaxLevel)
    self.ui.Btn_Exchange:SetActive(showData.exchangeUnlock and not isMaxLevel)
    self.ui.NodeLevelable:SetActive(not isMaxLevel)
  end, function()
    local _, exchangeUnlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Exchange, 0)
    return {
      currLevel = self.strengthenModel.trinketCurrLevel,
      exchangeUnlock = exchangeUnlock
    }
  end)
end

function TrinketUpgradeComp:BindUpgradeCurrencyCost(binder)
  local currencyItemId = self.strengthenModel:GetUpgradeCurrencyType()
  local com = binder:BindComponent(CommonCoinCostCom(self.ui.UI_Common_Group_Coin))
  com:UpdateItem(currencyItemId)
  com:UpdateOriValue("")
  binder:BindToRaw(function(_, need, _)
    local own = ItemDataUtils.GetItemNum(currencyItemId)
    com:NowColorNormal(need <= own)
    com:UpdateNow(need)
    com:UpdateOriValue("")
  end, function()
    return self.strengthenModel.trinketUpgradeNeedMoney
  end)
  binder:BindEvent(EventMgr.Instance.UpdateBagEvent, function(items)
    for k, v in pairs(items) do
      if currencyItemId == v.tid then
        local own = ItemDataUtils.GetItemNum(currencyItemId)
        local need = self.strengthenModel.trinketUpgradeNeedMoney
        com:NowColorNormal(own >= need)
        com:UpdateNow(need)
        com:UpdateOriValue("")
        break
      end
    end
  end)
end

function TrinketUpgradeComp:OnUnbind()
  if self._iconLightComp then
    self._iconLightComp:OnExitComponent()
    self._iconLightComp = nil
  end
  Super.OnUnbind(self)
end

return TrinketUpgradeComp
