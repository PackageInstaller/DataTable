_class("UICN20N49AlchemyShopRevenueLevelUpInfoItemItem", UICustomWidget)
UICN20N49AlchemyShopRevenueLevelUpInfoItemItem = UICN20N49AlchemyShopRevenueLevelUpInfoItemItem

function UICN20N49AlchemyShopRevenueLevelUpInfoItemItem:OnShow()
  self:InitWidgets()
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItemItem:InitWidgets()
  self._countTex = self:GetUIComponent("UILocalizationText", "Count")
  self._priceTex = self:GetUIComponent("UILocalizationText", "Price")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._color = self:GetUIComponent("Image", "Color")
  self._priceGo = self:GetGameObject("Image")
  self._countGo = self:GetGameObject("Count")
  self._noGo = self:GetGameObject("no")
  self._infoGo = self:GetGameObject("info")
  self._atlas = self:GetAsset("UICN20N49_Ryza.spriteatlas", LoadType.SpriteAtlas)
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItemItem:BtnOnClick(go)
  if self.tipsCallback then
    self.tipsCallback(self._roleAsset.assetid, Vector3(0.5, go.transform.position.y - 0.3, 0))
  end
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItemItem:SetData(cfgData, callback)
  self.tipsCallback = callback
  self._roleAsset = cfgData
  if self._roleAsset then
    local cfg = Cfg.cfg_item[self._roleAsset.assetid]
    if cfg then
      self._icon:LoadImage(cfg.Icon)
    end
    local price, color = UICN20N49Ryza_Shop.GetItemPriceColor(self._roleAsset.assetid)
    local spName = UICN20N49Ryza_Shop.Color2SpName(color)
    self._priceGo:SetActive(true)
    self._priceTex:SetText(self._roleAsset.count)
  end
end
