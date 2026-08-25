local DBGProgressItem, Super = System.NewComponent("DBGProgressItem")

function DBGProgressItem:ctor(uiNode, progress, mainText, subText)
  Super.ctor(self)
  self.ui = UI_Dungeons_Item_Out_ProgressResource(uiNode)
  self.progress = progress
  self.mainText = mainText
  self.subText = subText
end

function DBGProgressItem:OnBind(binder)
  self.binder = binder
  binder:SetSliderCurValue(self.ui.Slider_Nurturance, self.progress)
  if self.mainText then
    binder:SetText(self.ui.Text_Grade, self.mainText)
  end
  if self.subText then
    binder:SetText(self.ui.Text_Recommend, self.subText)
  end
end

return DBGProgressItem
