local ActivityLevelsSelectPanel = class("ActivityLevelsSelectPanel", BasePanel)
ActivityLevelsSelectPanel._sUIResRootPath = "UI_Activity/"
ActivityLevelsSelectPanel._tbDefine = {
  {
    sPrefabPath = "20101/ActivityLevels/ActivityLevelsSelect.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20101.ActivityLevels.ActivityLevelsSelectCtrl"
  }
}

function ActivityLevelsSelectPanel:Awake()
end

function ActivityLevelsSelectPanel:OnEnable()
end

function ActivityLevelsSelectPanel:OnAfterEnter()
end

function ActivityLevelsSelectPanel:OnDisable()
end

function ActivityLevelsSelectPanel:OnDestroy()
end

function ActivityLevelsSelectPanel:OnRelease()
end

return ActivityLevelsSelectPanel
