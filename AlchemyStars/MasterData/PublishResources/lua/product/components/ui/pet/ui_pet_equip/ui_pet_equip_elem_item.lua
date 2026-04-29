_class("UIPetEquipElemItem", UICustomWidget)
UIPetEquipElemItem = UIPetEquipElemItem

function UIPetEquipElemItem:Constructor()
end

function UIPetEquipElemItem:OnShow(uiParams)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._attName = self:GetUIComponent("UILocalizationText", "attName")
  self._elem = self:GetUIComponent("Image", "elem")
  self._elem2str = {
    [1] = "str_pet_filter_water_element",
    [2] = "str_pet_filter_fire_element",
    [3] = "str_pet_filter_sen_element",
    [4] = "str_pet_filter_electricity_element",
    [6] = "str_tale_pet_att_none"
  }
end

function UIPetEquipElemItem:SetData(elem, value)
  self._attName:SetText(StringTable.Get("str_pet_equip_property_restraint_value", StringTable.Get(self._elem2str[elem])) .. "+" .. value * 100 .. "%")
  local cfg_elem = Cfg.cfg_pet_element[elem]
  if cfg_elem then
    local icon = cfg_elem.Icon
    self._elem.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(icon))
  else
    Log.fatal("###[UIPetEquipElemItem] cfg_elem is nil ! id --> ", elem)
  end
end

function UIPetEquipElemItem:OnHide()
  self._attName = nil
  self._elem = nil
  self._elem2str = nil
end
