local OrganizationDescItem, Super = NewViewComponent("OrganizationDescItem")

function OrganizationDescItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Image_ContainerResource(uiNode)
  self:UpdateViewData(data)
end

function OrganizationDescItem:UpdateViewData(data)
  self.data = data
end

function OrganizationDescItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:RefreshView()
end

function OrganizationDescItem:RefreshView()
  self:SetText(self.ui.Text_Title, self.data.title)
  self:SetText(self.ui.Text_Content, self.data.content)
  StrUtils.SetPreferredHeight(self.ui.Text_Content)
end

function OrganizationDescItem:Hide()
  self:SetActive(self.ui.uiNode, false)
end

function OrganizationDescItem:Show()
  self:SetActive(self.ui.uiNode, true)
end

return OrganizationDescItem
