_class("UIAircraftSmeltTab", UICustomWidget)
UIAircraftSmeltTab = UIAircraftSmeltTab

function UIAircraftSmeltTab:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:GetAsset("UIAircraftSmeltRoom.spriteatlas", LoadType.SpriteAtlas)
end

function UIAircraftSmeltTab:InitWidget()
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.icon = self:GetUIComponent("Image", "icon")
  self.select = self:GetGameObject("select")
end

function UIAircraftSmeltTab:SetData(cfg, onClick)
  self._id = cfg.ID
  self._normalSprite = self._atlas:GetSprite(cfg.Icon)
  self._selectSprite = self._atlas:GetSprite(cfg.SelectIcon)
  self.name:SetText(StringTable.Get(cfg.Name))
  self._onClick = onClick
  self:Cancel()
  self._uiType = cfg.UIType
end

function UIAircraftSmeltTab:Select()
  self.select:SetActive(true)
  self.icon.sprite = self._selectSprite
end

function UIAircraftSmeltTab:Cancel()
  self.select:SetActive(false)
  self.icon.sprite = self._normalSprite
end

function UIAircraftSmeltTab:UIType()
  return self._uiType
end

function UIAircraftSmeltTab:ItemOnClick()
  self._onClick(self._id)
end
