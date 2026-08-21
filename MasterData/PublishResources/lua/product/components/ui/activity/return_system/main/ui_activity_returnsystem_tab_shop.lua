_class("UIActivityReturnSystemTabShop", UICustomWidget)
UIActivityReturnSystemTabShop = UIActivityReturnSystemTabShop

function UIActivityReturnSystemTabShop:OnShow(uiParams)
  self._isOpen = true
  self:AddListener()
  UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_Return_Gift")
end

function UIActivityReturnSystemTabShop:OnHide()
  self:DetachListener()
end

function UIActivityReturnSystemTabShop:SetData(campaign)
  self._campaign = campaign
  self._componentExchange = UIActivityReturnSystemHelper.GetComponentByTabName(self._campaign, "shop", 1)
  self._componentPower2Item = UIActivityReturnSystemHelper.GetComponentByTabName(self._campaign, "shop", 2)
  self:Refresh()
  UIActivityReturnSystemHelper.SetShopRedPoint()
end

function UIActivityReturnSystemTabShop:SetTopTips(callback)
  self._topTips = callback
end

function UIActivityReturnSystemTabShop:Refresh()
  if self._isOpen then
    self:_SetShopBoardGroup()
  end
end

function UIActivityReturnSystemTabShop:_SetShopBoardGroup()
  local componentInfo = self._componentExchange:GetComponentInfo()
  self._widigets = {}
  self._shopList = {}
  local moneyID = componentInfo.m_exchange_item_list[1].m_cost_item_id
  self._coinId = moneyID
  local moneyCfg = Cfg.cfg_item[moneyID]
  local itemModule = GameGlobal.GetModule(ItemModule)
  local moneyNum = itemModule:GetItemCount(moneyID)
  local max = self._componentPower2Item:GetCampaignCount()
  UIWidgetHelper.SetLocalizationText(self, "coinCount", moneyNum)
  local list = self._componentExchange:GetItemList()
  self._widigets = UIWidgetHelper.SpawnObjects(self, "Content", "UIActivityReturnSystemItemShop", #list)
  for i, v in ipairs(self._widigets) do
    local campaignItem = DCampaignShopItemBase:New()
    campaignItem:Refresh(list[i], self._componentExchange)
    v:Refresh(campaignItem, nil, max)
  end
end

function UIActivityReturnSystemTabShop:CoinOnClick(go)
  if self._topTips then
    self._topTips(self._coinId, go)
  end
end

function UIActivityReturnSystemTabShop:AddListener()
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.Refresh)
end

function UIActivityReturnSystemTabShop:DetachListener()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.Refresh)
end
