local SettingTitleItem, Super = NewViewComponent("SettingTitleItem")

function SettingTitleItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Setting_Content_TitleResource(uiNode)
  self.data = data
end

function SettingTitleItem:OnEnterComponent()
  self:SetText(self.ui.Text_Content_Title, LT.Text(self.data.titleText or ""))
end

return SettingTitleItem
