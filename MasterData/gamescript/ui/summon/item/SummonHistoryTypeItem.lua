local SummonHistoryTypeItem, Super = System.NewComponent("SummonHistoryTypeItem")

function SummonHistoryTypeItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Summon_Btn_SuitResource(uiNode)
  self.summonType = data.summonType
  self.clickCb = data.clickCb
end

function SummonHistoryTypeItem:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Mtrl_Type_1, System.fn(self, self.OnClick))
  binder:BindToText(self.ui.Text_Name, function()
    do return LT.Text end
    return LT.Text, "SummonTypeText_" .. self.summonType, self.summonType
  end)
end

function SummonHistoryTypeItem:OnClick()
  if self.clickCb then
    self.clickCb()
  end
end

return SummonHistoryTypeItem
