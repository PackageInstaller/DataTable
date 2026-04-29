_class("UICN20N49Ryza_ShopCell", UICustomWidget)
UICN20N49Ryza_ShopCell = UICN20N49Ryza_ShopCell

function UICN20N49Ryza_ShopCell:OnShow()
  self:InitWidgets()
end

function UICN20N49Ryza_ShopCell:InitWidgets()
  self._countTex = self:GetUIComponent("UILocalizationText", "Count")
  self._priceTex = self:GetUIComponent("UILocalizationText", "Price")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._color = self:GetUIComponent("Image", "Color")
  self._priceGo = self:GetGameObject("Image")
  self._countGo = self:GetGameObject("Count")
  self._noGo = self:GetGameObject("no")
  self._infoGo = self:GetGameObject("info")
  self._addGo = self:GetGameObject("addGo")
  self._atlas = self:GetAsset("UICN20N49_Ryza.spriteatlas", LoadType.SpriteAtlas)
end

function UICN20N49Ryza_ShopCell:ShowHideCellAddGo(show)
  if self._addGo then
    self._addGo:SetActive(show)
  end
end

function UICN20N49Ryza_ShopCell:BtnOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end

function UICN20N49Ryza_ShopCell:SetData(idx, info, callback)
  self._idx = idx
  self._callback = callback
  self._info = info
  self._noGo:SetActive(self._info == nil)
  self._infoGo:SetActive(self._info ~= nil)
  if self._info then
    local cfg = Cfg.cfg_item[self._info.id]
    if cfg then
      self._icon:LoadImage(cfg.Icon)
    end
    local spName = UICN20N49Ryza_Shop.Color2SpName(self._info.color)
    self._color.sprite = self._atlas:GetSprite(spName)
    self._priceGo:SetActive(self._info.price ~= nil)
    if self._info.price then
      self._priceTex:SetText(self._info.price)
    end
    self._countGo:SetActive(self._info.count ~= nil)
    if self._info.count then
      self._countTex:SetText(UICN20N49Ryza_Shop.MulString() .. self._info.count)
    end
  end
end
