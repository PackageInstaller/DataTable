local ActivityListPanel = class("ActivityListPanel", BasePanel)
ActivityListPanel._tbDefine = {
  {
    sPrefabPath = "ActivityList/ActivityListPanel.prefab",
    sCtrlName = "Game.UI.ActivityList.ActivityListCtrl"
  }
}

function ActivityListPanel:Awake()
  self.nSelectActId = nil
end

function ActivityListPanel:OnEnable()
end

function ActivityListPanel:OnAfterEnter()
end

function ActivityListPanel:OnDisable()
end

function ActivityListPanel:OnDestroy()
end

function ActivityListPanel:OnRelease()
end

return ActivityListPanel
