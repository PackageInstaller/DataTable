local LevelSelectPanel = class("LevelSelectPanel", BasePanel)
LevelSelectPanel._bIsMainPanel = true
LevelSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
LevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "30102/Play/BreakOutLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.Play_BreakOut_30101.LevelSelectCtrl"
  }
}

function LevelSelectPanel:Awake()
end

function LevelSelectPanel:OnEnable()
end

function LevelSelectPanel:OnAfterEnter()
end

function LevelSelectPanel:OnDisable()
end

function LevelSelectPanel:OnDestroy()
end

function LevelSelectPanel:OnRelease()
end

return LevelSelectPanel
