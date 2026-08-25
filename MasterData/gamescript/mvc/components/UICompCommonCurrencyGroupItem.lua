local featrueItemMap = {
  [CommonDefine.CurrencyType.Energy] = CommonDefine.FeatureId.ResCopy
}
local UICompCommonCurrencyGroupItem, Super = NewViewComponent("UICompCommonCurrencyGroupItem")

function UICompCommonCurrencyGroupItem:ctor(uiNode, view, coinList, showBg, hidePlusBtn, ingCheckReddot)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_Coin_GroupResource(uiNode)
  self.coinList = coinList
  self.showBg = showBg and true or false
  self.hidePlusBtn = hidePlusBtn and true or false
  self.ingCheckReddot = ingCheckReddot or false
  self.coinGameObjs = {}
end

function UICompCommonCurrencyGroupItem:OnEnterComponent()
  if self.ui.Image then
    self.ui.Image:SetActive(self.showBg)
  end
  for index = 1, 5 do
    local coinUI = self.ui["Coin_" .. index]
    local coinId = self.coinList and self.coinList[index] or nil
    local isActive = nil ~= coinId and self.IsFeatrueUnlockItem(coinId)
    if isActive and not coinUI then
      coinUI = self:FindChild(self.ui.uiNode, "Coin_" .. index)
      if not coinUI then
        coinUI = Instantiate(self.ui.Coin_1, self.ui.uiNode.transform)
        table.insert(self.coinGameObjs, coinUI)
        coinUI.name = "Coin_" .. index
      end
    end
    if coinUI then
      coinUI:SetActive(isActive)
    end
    if isActive then
      local clickCallBack
      if not self.hidePlusBtn then
        clickCallBack = CurrencyDefine.CurrencyBuyFunc[coinId]
      end
      self:AddViewComponentOnce(coinUI, UICoinInfoComponent, coinId, clickCallBack, nil, self.ingCheckReddot)
    elseif coinUI then
      self:RemoveViewComponentOnce(coinUI, UICoinInfoComponent)
    end
  end
end

function UICompCommonCurrencyGroupItem:OnExitComponent()
  for index = 1, 5 do
    local coinUI = self.ui["Coin_" .. index] or self:FindChild(self.ui.uiNode, "Coin_" .. index)
    if coinUI then
      self:RemoveViewComponentOnce(coinUI, UICoinInfoComponent)
    end
  end
  for _, go in ipairs(self.coinGameObjs) do
    DestroyImmediate(go)
  end
  self.coinGameObjs = nil
  Super.OnExitComponent(self)
end

function UICompCommonCurrencyGroupItem.IsFeatrueUnlockItem(itemTid)
  if featrueItemMap[itemTid] then
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.ResCopy, 0)
    return unlock
  end
  return true
end

function UICompCommonCurrencyGroupItem:OnOpenChargePanel()
  UIManager.Instance:Reopen(Urls.ChargeMainPanel)
end

return UICompCommonCurrencyGroupItem
