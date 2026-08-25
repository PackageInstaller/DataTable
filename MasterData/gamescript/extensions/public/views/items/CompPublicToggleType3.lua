local CompPublicToggleType3, Super = NewViewComponent("CompPublicToggleType3")

function CompPublicToggleType3:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_Toggle_3Resource(uiNode)
  self.redFunc = data.redFunc
  self.btnText = data.btnText
  self.isLock = data.isLock
  self.clickFunc = data.clickFunc
end

function CompPublicToggleType3:OnEnterComponent()
  self:AddZ1ToggleValueChangedListener(self.ui.uiNode, function()
    if self.clickFunc then
      self.clickFunc()
    end
  end)
  self.ui.Group_Disable:SetActive(self.isLock)
  self.ui.Group_Normal:SetActive(not self.isLock)
  if self.btnText then
    self:SetText(self.ui.Text_C_Name, self.btnText)
  end
  if self.redFunc then
    self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, self.redFunc)
  end
end

function CompPublicToggleType3:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicToggleType3
