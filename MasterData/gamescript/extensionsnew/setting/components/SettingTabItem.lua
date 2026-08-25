local UIAnimationController = CS.Z1Client.UIAnimationController
local TYPEOF_UIANIMATIONCONTROLLER = typeof(UIAnimationController)
local SettingTabItem, Super = NewViewComponent("SettingTabItem")

function SettingTabItem:ctor(uiNode, view, toggleName, isSelected, tabContentGroupMap, onSelect)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Setting_Item_ToggleResource(uiNode)
  self._toggleName = toggleName
  self._isSelected = isSelected
  self._tabContentGroupMap = tabContentGroupMap
  self._onSelect = onSelect
end

function SettingTabItem:OnEnterComponent()
  self.ui.Group_Buuble.gameObject:SetActive(false)
  self:SetText(self.ui.Text_Toggle, LT.Text(DT.CommonID[self._toggleName].Desc))
  self:AddZ1ToggleValueChangedListener(self.ui.uiNode, System.fn(self, self._OnToggleChanged))
  self:SetZ1Toggle(self.ui.uiNode, self._isSelected, true)
  local tabContentGroupMap = self._tabContentGroupMap
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, function()
    do return SettingManager.Instance.EnableRedByTab, SettingManager.Instance end
    return SettingManager.Instance.EnableRedByTab, SettingManager.Instance, tabContentGroupMap
  end)
end

function SettingTabItem:OnExitComponent()
  self:RemoveViewComponentOnce(self.ui.Com_RedDot, UICompRedDot)
  Super.OnExitComponent(self)
end

function SettingTabItem:_OnToggleChanged(isOn)
  if not isOn then
    return
  end
  local animCtrl = self.ui.uiNode:GetComponent(TYPEOF_UIANIMATIONCONTROLLER)
  if animCtrl then
    animCtrl:PlayState("UI_Setting_Item_Toggle_Select")
  end
  if self._onSelect then
    self._onSelect(self._toggleName)
  end
end

return SettingTabItem
