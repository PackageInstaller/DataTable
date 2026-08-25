local BtnBlockWindow, Super = System.NewComponent("BtnBlockWindow")

function BtnBlockWindow:ctor(uiNode, relateNode, onClickFunc)
  Super.ctor(self)
  self.ui = Btn_Block_WindowResource(uiNode)
  self.relateNode = relateNode
  self.onClickFunc = onClickFunc
  self.isShow = true
end

function BtnBlockWindow:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.uiNode, function()
    self.isShow = not self.isShow
    if self.onClickFunc then
      self.onClickFunc(self.isShow)
    end
    if self.relateNode then
      self.relateNode:SetActive(self.isShow)
    end
    self:SetShowState()
  end)
  self:SetShowState()
end

function BtnBlockWindow:SetShowState()
  self.ui.Image_Open:SetActive(self.isShow)
  self.ui.Image_Close:SetActive(not self.isShow)
end

return BtnBlockWindow
