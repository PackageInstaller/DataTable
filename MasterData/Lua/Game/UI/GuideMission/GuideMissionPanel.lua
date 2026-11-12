local GuideMissionPanel = class("GuideMissionPanel", BasePanel)
GuideMissionPanel._tbDefine = {
  {
    sPrefabPath = "GuideMission/GuideMissionPanel.prefab",
    sCtrlName = "Game.UI.GuideMission.GuideMissionCtrl"
  }
}

function GuideMissionPanel:Awake()
end

function GuideMissionPanel:OnEnable()
end

function GuideMissionPanel:OnDisable()
end

function GuideMissionPanel:OnDestroy()
end

return GuideMissionPanel
