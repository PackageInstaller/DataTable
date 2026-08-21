_class("UISimpleHauteCouturePurchaseController", UIController)
UISimpleHauteCouturePurchaseController = UISimpleHauteCouturePurchaseController

function UISimpleHauteCouturePurchaseController:Constructor()
end

function UISimpleHauteCouturePurchaseController:OnShow(uiParams)
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnBuySuccess)
  self:AttachEvent(GameEventType.PayGetLocalPriceFinished, self.RefreshPrice)
  self._campaign = uiParams[1]
  self.isHomeGameServer = uiParams[2]
  self._randomLotteryComponent = self._campaign:GetComponent(ECampaignPetSkinComponentID.RANDOMLOTTERY)
  self._buyGiftComponent = self._campaign:GetComponent(ECampaignPetSkinComponentID.BUYGIFT)
  self._buyGiftComponent:GetAllGiftLocalPrice()
  self._cfgMap = self._randomLotteryComponent:GetFirstCfg()
  self._cfgMain = self._randomLotteryComponent:GetCfgMain()
  self:_GetComponents()
  self:_Init()
end

function UISimpleHauteCouturePurchaseController:_GetComponents()
  local topBarPool = self:GetUIComponent("UISelectObjectPath", "topbtn")
  local topBtns = topBarPool:SpawnObject("UINewCommonTopButton")
  topBtns:SetData(function()
    self:CloseDialog()
  end)
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._topContent = self:GetUIComponent("UISelectObjectPath", "topContent")
  self._topTips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._topTipsInfo = self._topTips:SpawnObject("UITopTipsContext")
end

function UISimpleHauteCouturePurchaseController:_Init()
  local ids = self._buyGiftComponent:GetAllGiftIDByType(CampaignGiftType.ECGT_SENIOR_SKIN)
  
  local function onclick(id)
    local giftNum = 1
    self:ShowDialog("UISimpleHauteCoutureGiftPackDetail", self._campaign, self._buyGiftComponent, id, giftNum, function(res)
      if res:GetSucc() then
        self:OnBuySuccess(id)
      else
        Log.fatal("购买失败！：", res:GetResult())
      end
    end)
  end
  
  local idGroup = {}
  for _, id in pairs(ids) do
    local cfg = Cfg.cfg_shop_common_goods[id]
    if cfg.CurrencySkinID then
      table.insert(idGroup, id)
    end
  end
  self._items = self._content:SpawnObjects("UISimpleHauteCouturePurchaseItem", table.count(idGroup))
  local closeTime = self._buyGiftComponent:GetComponentInfo().m_close_time
  for i, uiItem in ipairs(self._items) do
    uiItem:SetData(idGroup[i], self._buyGiftComponent, onclick, closeTime)
  end
  local topMenu = self._topContent:SpawnObject("UISimpleHauteCoutureTopMenu")
  topMenu:SetData(self._topTipsInfo, self._cfgMap.CostItemID, RoleAssetID.RoleAssetDiamond, self._cfgMain.ScoreID, function()
    self:ShowDialog("UISimpleHauteCouturePurchaseController", self._campaign, self.isHomeGameServer)
  end)
  topMenu:ShowHideTSFBtn(true)
  topMenu:HideTicketAddBtn()
  self:RefreshPrice()
end

function UISimpleHauteCouturePurchaseController:RefreshPrice()
  for _, uiItem in ipairs(self._items) do
    uiItem:RefreshPrice()
  end
end

function UISimpleHauteCouturePurchaseController:OnBuySuccess(buyID)
  Log.debug("购买礼包成功:", buyID)
  local cfg = Cfg.cfg_component_buy_gift({GiftID = buyID})
  if not cfg then
    return
  end
  local awards = {}
  for _, v in pairs(cfg[1].ExtraAward) do
    local asset = RoleAsset:New()
    asset.assetid = v[1]
    asset.count = v[2]
    table.insert(awards, asset)
  end
  self:ShowDialog("UIGetItemController", awards, nil, true)
end
