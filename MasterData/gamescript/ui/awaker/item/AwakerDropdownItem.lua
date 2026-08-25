local AwakerDropdownItem, Super = System.NewComponent("AwakerDropdownItem")

function AwakerDropdownItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Toggle_Full_ListResource(uiNode)
  self.tid = data.tid
  self.name = data.name
  self.selectedFunc = data.selectedFunc
  self.callback = data.callback
end

function AwakerDropdownItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.uiNode, System.fn(self, self.OnClick))
  binder:SetText(self.ui.Text_Normal, self.name)
  binder:SetText(self.ui.Text_High, self.name)
  binder:BindToVisible(self.ui.Group_Normal, function()
    local state = self.selectedFunc()
    return not state
  end)
  binder:BindToVisible(self.ui.Group_High, function()
    local state = self.selectedFunc()
    return state
  end)
end

function AwakerDropdownItem:OnClick()
  if self.callback then
    self.callback(self.tid)
  end
end

return AwakerDropdownItem
