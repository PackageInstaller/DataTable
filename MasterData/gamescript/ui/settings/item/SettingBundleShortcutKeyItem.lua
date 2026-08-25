local SettingItemType = CommonDefine.SettingItemType
local KeyCode = CS.UnityEngine.KeyCode
local SettingBundleShortcutKeyItem, Super = System.NewComponent("SettingBundleShortcutKeyItem", SettingBaseItem)

function SettingBundleShortcutKeyItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_ShortcutKeyResource(uiNode)
  self.data = data
end

function SettingBundleShortcutKeyItem:OnBind(binder)
  local model = binder:createModel(SettingContentItemModel, self.data)
  self.model = model
  self.binder = binder
  binder:BindComponent(SettingBundleShortcutSingleItem(self.ui.UI_Setting_Item_ShortcutKey_1, self.data))
  binder:BindComponent(SettingBundleShortcutSingleItem(self.ui.UI_Setting_Item_ShortcutKey_2, (self.data or {}).secondItem))
end

return SettingBundleShortcutKeyItem
