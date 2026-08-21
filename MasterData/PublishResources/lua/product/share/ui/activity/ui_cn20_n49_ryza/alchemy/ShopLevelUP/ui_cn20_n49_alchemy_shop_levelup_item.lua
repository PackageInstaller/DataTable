_class("UICN20N49AlchemyShopLevelUPItem", UICustomWidget)
UICN20N49AlchemyShopLevelUPItem = UICN20N49AlchemyShopLevelUPItem
local UICN20N49AlchemyShopLevelUPItemState = {
  CanBuy = 1,
  CanNotBuy = 2,
  Complete = 3
}
_enum("UICN20N49AlchemyShopLevelUPItemState", UICN20N49AlchemyShopLevelUPItemState)

function UICN20N49AlchemyShopLevelUPItem:Contructor()
end

function UICN20N49AlchemyShopLevelUPItem:OnShow(uiParams)
  self._bgImage = {}
  self._bgImage[UICN20N49AlchemyShopLevelUPItemState.CanBuy] = "cn20_dpzx_di03"
  self._bgImage[UICN20N49AlchemyShopLevelUPItemState.CanNotBuy] = "cn20_dpzx_mask01"
  self._bgImage[UICN20N49AlchemyShopLevelUPItemState.Complete] = "cn20_dpzx_di04"
  self._buttonImage = {}
  self._buttonImage[UICN20N49AlchemyShopLevelUPItemState.CanBuy] = "cn20_dpzx_button01"
  self._buttonImage[UICN20N49AlchemyShopLevelUPItemState.CanNotBuy] = "cn20_dpzx_mask02"
  self._buttonImage[UICN20N49AlchemyShopLevelUPItemState.Complete] = "cn20_dpzx_button02"
  self:InitWidget()
end

function UICN20N49AlchemyShopLevelUPItem:SetData(cfg, isFinish, shopLevelUP)
  self.shopLevelUP = shopLevelUP
  self._canBuy = false
  self.formulaText:SetText(StringTable.Get(cfg.Desc))
  self.cfg = cfg
  self.costText:SetText(tostring(cfg.Money))
  self.bgMaskGO:SetActive(false)
  self.buyBtnMaskGO:SetActive(false)
  self._noMoney = false
  self._noLevel = false
  if isFinish then
    self.costGO:SetActive(false)
    self.cantBuyImageGO:SetActive(false)
    self.completeIconGO:SetActive(true)
    self.buyTextGO:SetActive(false)
    self.bgImage.sprite = self._atlas:GetSprite(self._bgImage[UICN20N49AlchemyShopLevelUPItemState.Complete])
    self.buyBtnImage.sprite = self._atlas:GetSprite(self._buttonImage[UICN20N49AlchemyShopLevelUPItemState.Complete])
    if cfg.Type == EAlchemyShopItemType.EAlchemyShopItemType_BuyFormula then
      self.titleText:SetText(StringTable.Get("str_cn20_n49_shop_levelup_buyComplete"))
    else
      self.titleText:SetText(StringTable.Get("str_cn20_n49_shop_levelup_UPComplete"))
    end
  else
    self.costGO:SetActive(true)
    self.completeIconGO:SetActive(false)
    self.buyTextGO:SetActive(true)
    if cfg.UnlockLevel > shopLevelUP._curProgress then
      self._noLevel = true
      self.cantBuyImageGO:SetActive(true)
      self.bgMaskGO:SetActive(true)
      self.buyBtnMaskGO:SetActive(true)
      if cfg.Type == EAlchemyShopItemType.EAlchemyShopItemType_BuyFormula then
        self.titleText:SetText(StringTable.Get("str_cn20_n49_shop_levelup_cantbuy", cfg.UnlockLevel))
      else
        self.titleText:SetText(StringTable.Get("str_cn20_n49_shop_levelup_cantUP", cfg.UnlockLevel))
      end
      self.buyText:SetText((StringTable.Get("str_cn20_n49_shop_levelup_noLevel")))
    else
      if cfg.Type == EAlchemyShopItemType.EAlchemyShopItemType_BuyFormula then
        self.titleText:SetText(StringTable.Get("str_cn20_n49_shop_levelup_canbuy"))
      else
        self.titleText:SetText(StringTable.Get("str_cn20_n49_shop_levelup_canUP"))
      end
      if cfg.Money > shopLevelUP._gold then
        self._noMoney = true
        self.cantBuyImageGO:SetActive(true)
        self.bgMaskGO:SetActive(true)
        self.buyBtnMaskGO:SetActive(true)
        self.buyText:SetText((StringTable.Get("str_cn20_n49_shop_levelup_noMoney")))
      else
        self._canBuy = true
        self.cantBuyImageGO:SetActive(false)
        self.bgImage.sprite = self._atlas:GetSprite(self._bgImage[UICN20N49AlchemyShopLevelUPItemState.CanBuy])
        self.buyBtnImage.sprite = self._atlas:GetSprite(self._buttonImage[UICN20N49AlchemyShopLevelUPItemState.CanBuy])
        self.buyText:SetText((StringTable.Get("str_cn20_n49_shop_levelup_canbuyBtn")))
      end
    end
  end
end

function UICN20N49AlchemyShopLevelUPItem:InitWidget()
  self._atlas = self:GetAsset("UICN20N49_Ryza.spriteatlas", LoadType.SpriteAtlas)
  self.costGO = self:GetGameObject("Cost")
  self.buyBtnGO = self:GetGameObject("ButBtn")
  self.completeIconGO = self:GetGameObject("CompleteIcon")
  self.buyTextGO = self:GetGameObject("BuyText")
  self.cantBuyImageGO = self:GetGameObject("cantBuyImage")
  self.bgMaskGO = self:GetGameObject("bgMask")
  self.buyBtnMaskGO = self:GetGameObject("BuyBtnMask")
  self.titleText = self:GetUIComponent("UILocalizationText", "Title")
  self.formulaText = self:GetUIComponent("UILocalizationText", "Formula")
  self.costText = self:GetUIComponent("UILocalizationText", "CostText")
  self.buyText = self:GetUIComponent("UILocalizationText", "BuyText")
  self.buyBtnImage = self:GetUIComponent("Image", "BuyBtn")
  self.bgImage = self:GetUIComponent("Image", "bg")
end

function UICN20N49AlchemyShopLevelUPItem:BuyBtnOnClick()
  if self.shopLevelUP.alchemyComponent:ComponentIsClose() then
    local tips = StringTable.Get("str_activity_error_107")
    ToastManager.ShowToast(tips)
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if self._canBuy then
    self:Lock("UICN20N49AlchemyShopLevelUPItem:BuyBtn")
    GameGlobal.TaskManager():StartTask(function(TT)
      local res = AsyncRequestRes:New()
      local ret = self.shopLevelUP.alchemyComponent:HandleAlchemyShopBuy(TT, res, self.cfg.Type, self.cfg.ID)
      if ret then
        self.shopLevelUP:ShowBonus(self.cfg)
      end
      self.shopLevelUP:RefreshWidgetData()
      self:UnLock("UICN20N49AlchemyShopLevelUPItem:BuyBtn")
    end)
  elseif self._noMoney then
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_ryza_tips_2"))
  elseif self._noLevel then
    ToastManager.ShowToast(StringTable.Get("str_cn20_n49_ryza_tips_4"))
  end
end
