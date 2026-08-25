local SettingTitleItem, Super = System.NewComponent("SettingTitleItem")

function SettingTitleItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_TitleResource(uiNode)
  self.data = data
end

function SettingTitleItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Content_Title, function()
    do return LT.Text end
    return LT.Text, self.data.titleText or ""
  end)
end

return SettingTitleItem
