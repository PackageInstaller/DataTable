local CompSelectWeaponItem, Super = NewViewComponent("CompSelectWeaponItem", CompSelectBaseItem)

function CompSelectWeaponItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view, data)
  self.weaponTid = data.weaponTid
  self.weaponUid = data.weaponUid
  self.refineLevel = data.refineLevel
end

function CompSelectWeaponItem:InitOtherUIElement()
  local weaponCfg = DT.Item[self.weaponTid]
  local qualityCfg = DT.ItemQuality[weaponCfg.Quality]
  local owned = ItemDataUtils.GetItemNum(self.weaponTid) > 0
  self.ui.Image_Awaker:SetActive(false)
  self.ui.Image_Icon:SetActive(true)
  self.ui.Image_Career:SetActive(false)
  self.ui.Image_Have:SetActive(owned)
  self:SetActive(self.ui.Image_Full, MainShopDataUtils.IsMaxPotencyByItemId(self.weaponTid))
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetSmallIcon(self.weaponTid))
  self:SetImage(self.ui.Image_Quality, qualityCfg.AwakerWeaponSelectQualityColor)
  self:SetText(self.ui.Text_Name, ItemDataUtils.GetItemName(self.weaponTid))
  self:SetText(self.ui.Text_C_Full, LT.Text("MaxLevelWeaponShopTips"))
  self:_InitRefineComp()
end

function CompSelectWeaponItem:_InitRefineComp()
  local viewData = {
    weaponLevel = self.refineLevel
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompWeaponRefineItem, viewData)
end

function CompSelectWeaponItem:OnClick()
  if self.data.clickFunc then
    self.data.clickFunc()
  end
end

function CompSelectWeaponItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompSelectWeaponItem
