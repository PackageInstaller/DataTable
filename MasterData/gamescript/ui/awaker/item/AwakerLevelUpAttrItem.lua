local AwakerLevelUpAttrItem, Super = System.NewComponent("AwakerLevelUpAttrItem")

function AwakerLevelUpAttrItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_This_ListResource(res)
  self.data = data
  self.newColorState = true
end

function AwakerLevelUpAttrItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Name, self.data.nameText)
  binder:SetImage(self.ui.Image_Icon, self.data.iconPath)
  binder:SetText(self.ui.Text_Number_Old, self.data.oldValue)
  binder:SetText(self.ui.Text_Number_New, self.data.newValue)
  self:VisibleGroup_New(self.data.hasImproved)
  self:NewColorNormal(self.data.hasImproved)
  self.binder:BindToTextColor(self.ui.Text_Number_New, function()
    return self.newColorState and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  end)
end

function AwakerLevelUpAttrItem:VisibleGroup_New(value)
  self.binder:SetActive(self.ui.Group_New, value)
end

function AwakerLevelUpAttrItem:NewColorNormal(value)
  self.oriColorState = value
end

return AwakerLevelUpAttrItem
