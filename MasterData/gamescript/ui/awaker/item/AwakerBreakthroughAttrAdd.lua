local AwakerBreakthroughAttrAdd, Super = System.NewComponent("AwakerBreakthroughAttrAdd")

function AwakerBreakthroughAttrAdd:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_This_ListResource(res)
  self.data = data
end

function AwakerBreakthroughAttrAdd:OnBind(binder)
  if self.data.isMaxHP then
    self:SetMaxHPChange(binder, self.data)
  else
    self:SetAttrChange(binder, self.data)
  end
end

function AwakerBreakthroughAttrAdd:SetMaxHPChange(binder, data)
  local attrTypeMap = AttrUtils.GetAttrTypeMap()
  local attrID = attrTypeMap.physique
  local attrCfg = DT.ActorAttrType[attrID]
  local physiqueText = LT.Text(attrCfg.Text)
  self.ui.Image_Icon:SetActive(false)
  binder:SetText(self.ui.Text_Name, LT.Text("MaxHp"))
  binder:SetText(self.ui.Text_Number_Old, string.format("%s*%.0f%%", physiqueText, data.oldValue * 100))
  binder:SetText(self.ui.Text_Number_New, string.format("%s*%.0f%%", physiqueText, data.newValue * 100))
end

function AwakerBreakthroughAttrAdd:SetAttrChange(binder, data)
  local id = data.id
  local attrIcon = DT.ActorAttrType[id].Icon
  local isPercentage = DT.ActorAttrType[id].Percentage
  local attrName = LT.Text(DT.ActorAttrType[id].Text)
  self.ui.Image_Icon:SetActive(true)
  binder:SetImage(self.ui.Image_Icon, attrIcon)
  binder:SetText(self.ui.Text_Name, attrName)
  binder:SetText(self.ui.Text_Number_Old, isPercentage and data.oldValue .. "%%" or data.oldValue)
  binder:SetText(self.ui.Text_Number_New, isPercentage and data.newValue .. "%%" or data.newValue)
end

return AwakerBreakthroughAttrAdd
