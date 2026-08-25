local CompStageStar, Super = NewViewComponent("CompStageStar")

function CompStageStar:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Group_StarResource(uiNode)
  self.data = data
  self.clickFunc = self.data.clickFunc
end

function CompStageStar:OnEnterComponent()
  self.ui.Star_1:SetActive(self.data.star >= 1)
  self.ui.Star_2:SetActive(self.data.star >= 2)
  self.ui.Star_3:SetActive(self.data.star >= 3)
  if self.clickFunc then
    self:AddButtonClickListener(self.ui.Btn_Star, System.fn(self, self.clickFunc))
  end
end

function CompStageStar:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompStageStar
