local AwakerSkillUpAttrItem, Super = System.NewComponent("AwakerSkillUpAttrItem")

function AwakerSkillUpAttrItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Levelup_ListResource(res)
  self.data = data
end

function AwakerSkillUpAttrItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Name, self.data.nameText)
  binder:SetImage(self.ui.Image_Icon, self.data.iconPath)
  binder:SetText(self.ui.Text_Number_Old, self.data.oldValue)
  binder:SetText(self.ui.Text_Number_New, self.data.newValue)
  binder:SetActive(self.ui.Image_LevelUP, self.data.hasImproved)
  if self.data.showArrow ~= nil and self.ui.Image_Arrow then
    binder:SetActive(self.ui.Image_Arrow, self.data.showArrow)
  end
end

return AwakerSkillUpAttrItem
