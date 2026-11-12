local GoldenSpyBuffSelectPanel = class("GoldenSpyBuffSelectPanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
GoldenSpyBuffSelectPanel._bIsMainPanel = false
GoldenSpyBuffSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
GoldenSpyBuffSelectPanel._sUIResRootPath = "UI_Activity/"
GoldenSpyBuffSelectPanel._tbDefine = {
  {
    sPrefabPath = "_400012/GoldenSpyBuffSelectPanel.prefab",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyBuffSelectCtrl"
  }
}

function GoldenSpyBuffSelectPanel:Awake()
  GamepadUIManager.EnableGamepadUI("GoldenSpyBuffSelect", {})
  self.nTipsPanelId = PanelId.GoldenSpyBuffTipsPanel_400012
end

function GoldenSpyBuffSelectPanel:OnEnable()
end

function GoldenSpyBuffSelectPanel:OnAfterEnter()
end

function GoldenSpyBuffSelectPanel:OnDisable()
end

function GoldenSpyBuffSelectPanel:OnDestroy()
  GamepadUIManager.DisableGamepadUI("GoldenSpyBuffSelect")
end

function GoldenSpyBuffSelectPanel:OnRelease()
end

return GoldenSpyBuffSelectPanel
