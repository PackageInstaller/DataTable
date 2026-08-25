local WorldStageShopConfirmPanel, Super = System.NewClass("WorldStageShopConfirmPanel", UIBasePanel)
WorldStageShopConfirmPanel.uiResCls = UI_Dbgcopy_Popup_SureResource

function WorldStageShopConfirmPanel:ctor(relic, callback, btnConfirmFunc, btnGiveUpFunc, loadEndCallback, forbidCntTip)
  Super.ctor(self)
  self.relic = Vue.ref(relic)
  self.callback = callback
  self.btnConfigrmFunc = btnConfirmFunc
  self.btnGiveUpFunc = btnGiveUpFunc
  self.isOpenDetail = false
  self.config = nil
  if self.relic.value.itemType == CommonDefine.WorldStageShopItemType.Relic then
    self.config = DT.RelicConfig[self.relic.value.relicTid]
  end
  if self.relic.value.itemType == CommonDefine.WorldStageShopItemType.Enchant then
    self.config = DT.EnchantConfig[self.relic.value.relicTid]
  end
  if self.relic.value.itemType == CommonDefine.WorldStageShopItemType.Item then
    self.config = DT.Item[self.relic.value.relicTid]
  end
  assert(self.config ~= nil, "there is no such relic in Item")
  self.playingAnim = false
  self.isNotPlayAnim = false
  self.forbidCntTip = forbidCntTip
  self:SetOpenEndCallback(loadEndCallback)
end

function WorldStageShopConfirmPanel:OnBind(binder)
  local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  local enchantTypeMap = CommonDefine.GetEnchantTypeNameMap()
  binder:BindToText(self.ui.Text_Special, function()
    return self.config.StoryDesc or ""
  end)
  binder:BindToText(self.ui.Text_Introduce, function()
    do return self.GetItemDesc end
    return self.GetItemDesc, self
  end, nil, nil, {
    lockParentNode = self.ui.KeyWordTips_Node
  })
  StrUtils.SetPreferredHeight(self.ui.Text_Special)
  StrUtils.SetPreferredHeight(self.ui.Text_Introduce)
  binder:BindToText(self.ui.Text_Enchantment, function()
    if self.relic.value.itemType == CommonDefine.WorldStageShopItemType.Relic then
      return relicTypeMap[self.config.Quality] or ""
    elseif self.relic.value.itemType == CommonDefine.WorldStageShopItemType.Enchant then
      return enchantTypeMap[self.config.Quality] or ""
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Title, function()
    return self.config.Name or ""
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.config.Icon
  end)
  binder:BindZ1Button(self.ui.Btn_Sure, System.fn(self, self.OnConfirmClick), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "StoreBuyConfirm"
  end, nil, nil, nil)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.Close), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "StoreBuyCancel"
  end, nil, nil, nil)
  if self.relic.value.uid then
    local price = math.modf(ShopDataUtils.GetShopItem(self.relic.value.uid).price)
    local haveMoney = DataCenter.playerData.DMoney.gold or 0
    local icon = 100 == DataCenter.itemData.Coin and DT.GetOriginalConstant("PhiloStone")[2] or DT.Item[DataCenter.itemData.Coin].SmallIcon
    self.binder:SetText(self.ui.Text_Price, price)
    self.binder:SetImage(self.ui.Image_Coin_Icon, icon)
    local originColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop1)
    local notEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop3)
    self.binder:SetTextColorByHtml(self.ui.Text_Price, price > haveMoney and notEnoughColor or originColor)
  end
end

function WorldStageShopConfirmPanel:GetItemDesc()
  local ok, out = pcall(function()
    if self.relic.value.itemType == CommonDefine.WorldStageShopItemType.Relic then
      return RelicDataUtils.GetRelicDesc(self.relic.value.relicTid, DataCenter.playerData.DRole.level) or ""
    end
    return SkillUtils.GetEnchantDesc(self.relic.value.relicTid) or ""
  end)
  if ok and type(out) == "string" then
    return out
  end
  return ""
end

function WorldStageShopConfirmPanel:OnConfirmClick()
  local function cb()
    AudioManager.Instance:PostSoundEvent("SHOP_BUY_ITEM")
  end
  
  if self.btnConfigrmFunc then
    self.btnConfigrmFunc(cb)
  end
  Super.Close(self)
end

function WorldStageShopConfirmPanel:Close()
  if self.btnGiveUpFunc then
    self.btnGiveUpFunc()
  end
  Super.Close(self)
end

return WorldStageShopConfirmPanel
