local GoldenSpyLevelSelectPanel = class("GoldenSpyLevelSelectPanel", BasePanel)
GoldenSpyLevelSelectPanel._bIsMainPanel = true
GoldenSpyLevelSelectPanel._bAddToBackHistory = true
GoldenSpyLevelSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
GoldenSpyLevelSelectPanel._sUIResRootPath = "UI_Activity/"
GoldenSpyLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "_400017/GoldenSpyLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyLevelSelectCtrl"
  }
}
local PanelTab = {Group = 1, Level = 2}

function GoldenSpyLevelSelectPanel:Awake()
  self.nPanelTab = PanelTab.Group
  self.nSelectGroupId = 0
  self.nSelectLevelId = 0
end

function GoldenSpyLevelSelectPanel:OnEnable()
end

function GoldenSpyLevelSelectPanel:OnAfterEnter()
end

function GoldenSpyLevelSelectPanel:OnDisable()
end

function GoldenSpyLevelSelectPanel:OnDestroy()
end

function GoldenSpyLevelSelectPanel:OnRelease()
end

return GoldenSpyLevelSelectPanel
