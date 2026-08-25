local CommonSkillResultItem, Super = System.NewComponent("CommonSkillResultItem")

function CommonSkillResultItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = Item_Cardinfo_Level_1Resource(uiNode)
  self.data = data
end

local function GetPercentNum(val)
  return math.floor(val * 100) .. "%"
end

function CommonSkillResultItem:OnBind(binder)
  self.binder = binder
  local old = self.data.isPercent and GetPercentNum(self.data.oldVal) or self.data.oldVal
  local new = self.data.isPercent and GetPercentNum(self.data.newVal) or self.data.newVal
  binder:SetText(self.ui.Text_Name, self.data.name)
  binder:SetText(self.ui.Text_Old, self.data.oldFormula)
  binder:SetText(self.ui.Text_New, self.data.newFormula)
  binder:SetText(self.ui.Text_Count_Old, old)
  binder:SetText(self.ui.Text_Count_New, new)
end

return CommonSkillResultItem
