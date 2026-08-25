local AwakerSkillAttrItem, Super = System.NewComponent("AwakerSkillAttrItem")

function AwakerSkillAttrItem:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_Attr_LevelUpResource(res)
  self.data = data
end

function AwakerSkillAttrItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Attr_Name, self.data.typeName)
  binder:SetText(self.ui.Text_Attr_CurrVal, self.data.currVal)
  binder:SetText(self.ui.Text_Attr_NextVal, self.data.nextVal)
end

return AwakerSkillAttrItem
