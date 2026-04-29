_class("UIShopSailingBuyTips", UIController)
UIShopSailingBuyTips = UIShopSailingBuyTips

function UIShopSailingBuyTips:Constructor()
  self:AttachEvent(GameEventType.OnSailingPlanBuySucc, self.BgOnClick)
end

function UIShopSailingBuyTips:OnShow(uiParams)
  self._buyCb = uiParams[1]
  self._buyPrice = uiParams[2]
  self._awards = uiParams[3]
  self:GetComponents()
  self:OnValue()
end

function UIShopSailingBuyTips:GetComponents()
  self._priceTex = self:GetUIComponent("UILocalizationText", "price")
  self._pools = self:GetUIComponent("UISelectObjectPath", "pools")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
end

function UIShopSailingBuyTips:OnValue()
  local count = #self._awards
  self._pools:SpawnObjects("UIShopSailingPlanItem", count)
  local awards = self._pools:GetAllSpawnList()
  for i = 1, count do
    local item = awards[i]
    local award = self._awards[i]
    item:SetData(i, award, function(id, pos)
      self:ItemOnClick(id, pos)
    end, nil, nil, nil, 0, false, true, 0.9)
  end
  local tex = RechargeShopItem.RemoveDot00(self._buyPrice)
  self._priceTex:SetText(tex)
end

function UIShopSailingBuyTips:ItemOnClick(id, pos)
  if self._tips then
    self._tips:SetData(id, pos)
  end
end

function UIShopSailingBuyTips:OnHide()
end

function UIShopSailingBuyTips:BtnOnClick(go)
  if self._buyCb then
    self._buyCb()
  end
end

function UIShopSailingBuyTips:BgOnClick(go)
  self:CloseDialog()
end
