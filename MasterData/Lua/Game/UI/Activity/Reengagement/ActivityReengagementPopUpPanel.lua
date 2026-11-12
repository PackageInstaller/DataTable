local ActivityReengagementPopUpPanel = class("ActivityReengagementPopUpPanel", BasePanel)
ActivityReengagementPopUpPanel._bIsMainPanel = false
ActivityReengagementPopUpPanel._tbDefine = {
  {
    sPrefabPath = "ActivityList/ActivityPopUpPanel.prefab",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementPopUpCtrl"
  }
}

function ActivityReengagementPopUpPanel:Awake()
end

function ActivityReengagementPopUpPanel:OnEnable()
end

function ActivityReengagementPopUpPanel:OnAfterEnter()
end

function ActivityReengagementPopUpPanel:OnDisable()
end

function ActivityReengagementPopUpPanel:OnDestroy()
end

function ActivityReengagementPopUpPanel:OnRelease()
end

return ActivityReengagementPopUpPanel
