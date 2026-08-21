_class("UIShopSailingPlanRecommend", UICustomWidget)
UIShopSailingPlanRecommend = UIShopSailingPlanRecommend

function UIShopSailingPlanRecommend:Constructor()
end

function UIShopSailingPlanRecommend:BgOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OpenShop, ShopMainTabType.SailingPlan)
end

function UIShopSailingPlanRecommend:SetData(uishopcontroller)
  self._uishopcontroller = uishopcontroller
  self._uiShopSailingPlanHelper = UIShopSailingPlanHelper:New()
  local active = self._uiShopSailingPlanHelper:CheckActive()
  local go = self:GetGameObject()
  go:SetActive(active)
  if active then
    self:GetComponents()
    self:OnValue()
  end
end

function UIShopSailingPlanRecommend:GetComponents()
  self._priceTex = self:GetUIComponent("UILocalizationText", "price")
  self._bgImg = self:GetUIComponent("Image", "Bg")
  self._atlas = self:GetAsset("SailingPlan.spriteatlas", LoadType.SpriteAtlas)
  self._tex = self:GetUIComponent("UILocalizationText", "tex")
  self._texTr = self:GetUIComponent("RectTransform", "tex")
  self._priceTexGo = self:GetGameObject("price")
end

function UIShopSailingPlanRecommend:OnValue()
  self._sailingPlanLocalProcess = self._uishopcontroller:GetSailingPlanLocalProgress()
  self._buyInfo = self._sailingPlanLocalProcess:GetComponentInfo(ECCampaignInlandSailingComponentID.BUY_GIFT)
  local gift = self._buyInfo.m_campaign_gift_list[1]
  local price = gift.m_now_price
  local priceTex = math.floor(price * 0.1)
  self._priceTex:SetText(RechargeShopItem.RemoveDot00(priceTex))
  self._buyState = self._buyInfo.m_buy_state
  local bgSpriteName, tex, posx, priceActive
  if self._buyState ~= BuyGiftStateType.EBGST_INIT then
    bgSpriteName = "shop_qh_lh06"
    tex = "str_shop_sailing_plan17"
    posx = 0
    priceActive = false
  else
    bgSpriteName = "shop_qh_lh05"
    tex = "str_shop_sailing_plan16"
    posx = -81.5
    priceActive = true
  end
  self._priceTexGo:SetActive(priceActive)
  self._tex:SetText(StringTable.Get(tex))
  local sp = self._atlas:GetSprite(bgSpriteName)
  self._bgImg.sprite = sp
  self._texTr.anchoredPosition = Vector2(posx, 1.3)
end
