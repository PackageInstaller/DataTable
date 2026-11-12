local GoldenSpyLevelPanel = class("GoldenSpyLevelPanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
GoldenSpyLevelPanel._bIsMainPanel = true
GoldenSpyLevelPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
GoldenSpyLevelPanel._sUIResRootPath = "UI_Activity/"
GoldenSpyLevelPanel._tbDefine = {
  {
    sPrefabPath = "_400017/GoldenSpyPanel.prefab",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyLevelCtrl"
  }
}

function GoldenSpyLevelPanel:Awake()
  PlayerData.Base:SetSkipNewDayWindow(true)
  self.bFirstInCtrl = true
  self.nTipsPanelId = PanelId.GoldenSpyBuffTipsPanel_400017
  self.nResultPanelId = PanelId.GoldenSpyResultPanel_400017
  self.nBuffSelectPanelId = PanelId.GoldenSpyBuffSelectPanel_400017
end

function GoldenSpyLevelPanel:OnEnable()
end

function GoldenSpyLevelPanel:OnAfterEnter()
end

function GoldenSpyLevelPanel:OnDisable()
end

function GoldenSpyLevelPanel:OnDestroy()
  PlayerData.Base:SetSkipNewDayWindow(false)
  PlayerData.Base:OnBackToMainMenuModule()
end

function GoldenSpyLevelPanel:OnRelease()
end

return GoldenSpyLevelPanel
