local AwakerCommonUpAttrItem, Super = System.NewComponent("AwakerCommonUpAttrItem")

function AwakerCommonUpAttrItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Common_Popup_Tip_4_ItemResource(res)
  self.data = data
end

function AwakerCommonUpAttrItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Name, self.data.nameText)
  binder:SetText(self.ui.Text_Number_Old, self.data.oldValue)
  binder:SetText(self.ui.Text_Number_New, self.data.newValue)
  binder:SetImage(self.ui.Image_Icon, self.data.iconPath)
end

return AwakerCommonUpAttrItem
