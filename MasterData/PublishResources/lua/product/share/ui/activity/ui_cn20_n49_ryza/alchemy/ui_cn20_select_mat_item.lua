_class("UICN20SelectMatItem", UICustomWidget)
UICN20SelectMatItem = UICN20SelectMatItem

function UICN20SelectMatItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20SelectMatItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.quiatly = self:GetUIComponent("Image", "quiatly")
  self.value = self:GetUIComponent("UILocalizationText", "value")
  self.matIcon = self:GetUIComponent("Image", "attribute")
  self._atlas = self:GetAsset("UICN20N49.spriteatlas", LoadType.SpriteAtlas)
end

function UICN20SelectMatItem:SetData(itemId, selectCB)
  self.itemId = itemId
  self.selectCB = selectCB
  local itemCfg = Cfg.cfg_item[itemId]
  if not itemCfg then
    Log.error("itemCfg IS NIL", itemId)
    return
  end
  self._cfg_item = itemCfg
  local matCfg = Cfg.cfg_component_alchemy_material[itemId]
  if matCfg == nil then
    Log.error("alchemyCfg matCfg IS nil", itemId)
    return
  end
  self.matCfg = matCfg
  if self.matCfg.Property == 1 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx02")
  elseif self.matCfg.Property == 2 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx01")
  elseif self.matCfg.Property == 3 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx03")
  elseif self.matCfg.Property == 4 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx04")
  end
  local icon = self._cfg_item.Icon
  self.icon:LoadImage(icon)
  local color = self.matCfg.Quality
  if color == 1 then
    self.quiatly.sprite = self._atlas:GetSprite("cn20_ljdp_gezi05_01")
  elseif color == 2 then
    self.quiatly.sprite = self._atlas:GetSprite("cn20_ljdp_gezi04_01")
  elseif color == 3 then
    self.quiatly.sprite = self._atlas:GetSprite("cn20_ljdp_gezi03_01")
  elseif 3 < color then
    self.quiatly.sprite = self._atlas:GetSprite("cn20_ljdp_gezi01_01")
  end
end

function UICN20SelectMatItem:BgOnClick(go)
  if self.selectCB then
    self.selectCB()
  end
end
