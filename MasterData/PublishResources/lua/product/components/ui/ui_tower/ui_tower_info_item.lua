_class("UITowerInfoItem", UICustomWidget)
UITowerInfoItem = UITowerInfoItem

function UITowerInfoItem:OnShow(uiParams)
  self:InitWidget()
end

function UITowerInfoItem:InitWidget()
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.towerName = self:GetUIComponent("UILocalizationText", "TowerName")
  self.towerLayer = self:GetUIComponent("UILocalizationText", "TowerLayer")
  self._icon = self:GetUIComponent("Image", "icon")
  self._effs = {
    self:GetGameObject("eff_ui_uitower_1"),
    self:GetGameObject("eff_ui_uitower_2"),
    self:GetGameObject("eff_ui_uitower_3"),
    self:GetGameObject("eff_ui_uitower_4")
  }
end

function UITowerInfoItem:SetData(type)
  self._elementType = type
  local module = self:GetModule(TowerModule)
  local ceiling = module:GetTowerCeiling(self._elementType)
  local cur = module:GetTowerLayer(self._elementType)
  self._layer = 0
  if ceiling <= cur then
    self._layer = ceiling
  else
    self._layer = cur + 1
  end
  self.towerName.text = module:GetTowerName(self._elementType)
  self.towerLayer.text = string.format(StringTable.Get("str_tower_cur_layer"), self._layer)
  self.bg:LoadImage(UITowerInfoCfg[self._elementType].image)
  local atlas = self:GetAsset("UITower.spriteatlas", LoadType.SpriteAtlas)
  self._icon.sprite = atlas:GetSprite(UITowerInfoCfg[self._elementType].icon)
  if 4 < type then
    self._effs[type - 4]:SetActive(true)
  else
    self._effs[type]:SetActive(true)
  end
end

function UITowerInfoItem:itemOnClick(go)
  self:ShowDialog("UITowerLayerController", self._elementType)
end

UITowerInfoCfg = {
  [TowerElementType.TowerElementType_Blue] = {
    image = "tower_xuanze_shui",
    icon = "tower_xuanze_icon4"
  },
  [TowerElementType.TowerElementType_Red] = {
    image = "tower_xuanze_huo",
    icon = "tower_xuanze_icon2"
  },
  [TowerElementType.TowerElementType_Green] = {
    image = "tower_xuanze_sen",
    icon = "tower_xuanze_icon1"
  },
  [TowerElementType.TowerElementType_Yellow] = {
    image = "tower_xuanze_lei",
    icon = "tower_xuanze_icon3"
  },
  [TowerElementType.TowerElementType_Difficulty_Blue] = {
    image = "ht_gqxq_di11",
    icon = "tower_logo_icon4"
  },
  [TowerElementType.TowerElementType_Difficulty_Red] = {
    image = "ht_gqxq_di12",
    icon = "tower_logo_icon2"
  },
  [TowerElementType.TowerElementType_Difficulty_Green] = {
    image = "ht_gqxq_di13",
    icon = "tower_logo_icon1"
  },
  [TowerElementType.TowerElementType_Difficulty_Yellow] = {
    image = "ht_gqxq_di14",
    icon = "tower_logo_icon3"
  }
}
