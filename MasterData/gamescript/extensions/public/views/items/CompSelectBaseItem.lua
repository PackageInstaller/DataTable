local CompSelectBaseItem, Super = NewViewComponent("CompSelectBaseItem")

function CompSelectBaseItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Events_Item_OptionalResource(uiNode)
  self.data = data
end

function CompSelectBaseItem:RegisterNotifications()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnClick))
end

function CompSelectBaseItem:OnEnterComponent()
  self:InitBaseUIElement()
  self:InitOtherUIElement()
end

function CompSelectBaseItem:InitBaseUIElement()
  self.ui.Image_Selected:SetActive(self.data.isSelect)
end

function CompSelectBaseItem:InitOtherUIElement()
end

function CompSelectBaseItem:OnClick()
  if self.data.clickFunc then
    self.data.clickFunc()
  end
end

function CompSelectBaseItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompSelectBaseItem
