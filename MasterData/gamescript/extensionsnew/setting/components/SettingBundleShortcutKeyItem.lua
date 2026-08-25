local SettingBundleShortcutKeyItem, Super = NewViewComponent("SettingBundleShortcutKeyItem")

function SettingBundleShortcutKeyItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Setting_Content_ShortcutKeyResource(uiNode)
  self.data = data
end

function SettingBundleShortcutKeyItem:OnEnterComponent()
  self:AddViewComponent(self.ui.UI_Setting_Item_ShortcutKey_1, SettingBundleShortcutSingleItem, self.data)
  self:AddViewComponent(self.ui.UI_Setting_Item_ShortcutKey_2, SettingBundleShortcutSingleItem, (self.data or {}).secondItem)
end

return SettingBundleShortcutKeyItem
