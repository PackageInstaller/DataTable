local CommonConceptDescItem, Super = NewViewComponent("CommonConceptDescItem")

function CommonConceptDescItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Image_DescribeResource(uiNode)
  self.data = data
end

function CommonConceptDescItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:SetText(self.ui.Text_Title_02, self.data.title)
  self:SetText(self.ui.Text_Describe, self.data.content)
  StrUtils.SetPreferredHeight(self.ui.Text_Describe)
end

return CommonConceptDescItem
