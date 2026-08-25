local ItemType = CommonDefine.ItemType
local WeaponRefineTipItem, Super = System.NewComponent("WeaponRefineTipItem")

function WeaponRefineTipItem:ctor(uiNode, weaponDetailModel)
  Super.ctor(self)
  self.model = weaponDetailModel
  self.ui = UI_Awaker_Popup_Trinket_TipResource(uiNode)
end

function WeaponRefineTipItem:OnBind(binder)
  Super.OnBind(self, binder)
  binder:BindToVisible(self.ui.Group_Prop, function()
    local itemType = self.model:GetItemType()
    return itemType == ItemType.Trinket
  end)
  binder:BindToVisible(self.ui.UI_Awaker_Item_Trinket_Suitdesc, function()
    local itemType = self.model:GetItemType()
    return itemType == ItemType.Trinket
  end)
  binder:BindToImage(self.ui.Image_Bg_Quality, function()
    if self.model.weapon == nil then
      return
    end
    local framePath = ItemDataUtils.GetBgQualityFramePath(self.model.weapon.tid)
    return framePath
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    local image = self.model:GetWeaponPainting()
    return image
  end)
  binder:BindToImage(self.ui.Image_Title_Quality, function()
    if self.model.weapon == nil then
      return
    end
    local framePath = ItemDataUtils.GetTitleQualityFramePath(self.model.weapon.tid)
    return framePath
  end)
  binder:BindToText(self.ui.Text_Name, function()
    local name = self.model:GetWeaponName()
    return name
  end)
  binder:BindToText(self.ui.Text_Type, function()
    do return self.model.GetSubTypeName end
    return self.model.GetSubTypeName, self.model
  end)
  binder:BindToText(self.ui.Text_Weapon_Level, function()
    do return LT.Textf, "WeaponRefineLevel", self.model:GetWeaponlevel() end
    return LT.Textf, "WeaponRefineLevel", self.model:GetWeaponlevel()
  end)
  binder:BindToRaw(function(_, value)
    local groupStarTransform = self.ui.Group_Stars.transform
    local childCount = groupStarTransform.childCount
    for i = 0, childCount - 1 do
      if i < value then
        groupStarTransform:GetChild(i).gameObject:SetActive(true)
      else
        groupStarTransform:GetChild(i).gameObject:SetActive(false)
      end
    end
  end, function()
    do return self.model.GetWeaponlevel end
    return self.model.GetWeaponlevel, self.model
  end)
  binder:BindToRaw(function(_, value)
    if "" == value then
      self.ui.Text_Weapon_Desc_1:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_1:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_1, value)
  end, function()
    do return self.model.GetStateDesc end
    return self.model.GetStateDesc, self.model
  end)
  binder:BindToRaw(function(_, value)
    if "" == value then
      self.ui.Text_Weapon_Desc_2:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_2:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_2, value)
  end, function()
    do return self.model.GetExclusiveDesc end
    return self.model.GetExclusiveDesc, self.model
  end)
  binder:BindToText(self.ui.Text_Story, function()
    do return self.model.GetStory end
    return self.model.GetStory, self.model
  end)
  binder:BindToText(self.ui.Text_Main_Property, function()
    do return self.model.GetWeaponAttrName end
    return self.model.GetWeaponAttrName, self.model
  end)
  binder:BindToText(self.ui.Textt_Main_Property_Count, function()
    do return self.model.GetWeapponAttrValue end
    return self.model.GetWeapponAttrValue, self.model
  end)
end

return WeaponRefineTipItem
