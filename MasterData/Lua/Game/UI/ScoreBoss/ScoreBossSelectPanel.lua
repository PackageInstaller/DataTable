local ScoreBossSelectPanel = class("ScoreBossSelectPanel", BasePanel)
ScoreBossSelectPanel._tbDefine = {
  {
    sPrefabPath = "Play_ScoreBoss/ScoreBossSelectPanel.prefab",
    sCtrlName = "Game.UI.ScoreBoss.ScoreBossSelectCtrl"
  }
}

function ScoreBossSelectPanel:Awake()
end

function ScoreBossSelectPanel:OnEnable()
end

function ScoreBossSelectPanel:OnDisable()
end

function ScoreBossSelectPanel:OnDestroy()
end

function ScoreBossSelectPanel:OnRelease()
end

return ScoreBossSelectPanel
