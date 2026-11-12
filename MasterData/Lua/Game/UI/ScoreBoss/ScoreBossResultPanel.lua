local ScoreBossResultPanel = class("ScoreBossResultPanel", BasePanel)
ScoreBossResultPanel._bAddToBackHistory = false
ScoreBossResultPanel._tbDefine = {
  {
    sPrefabPath = "Play_ScoreBoss/ScoreBossResultPanel.prefab",
    sCtrlName = "Game.UI.ScoreBoss.ScoreBossResultCtrl"
  }
}

function ScoreBossResultPanel:Awake()
end

function ScoreBossResultPanel:OnEnable()
end

function ScoreBossResultPanel:OnDisable()
end

function ScoreBossResultPanel:OnDestroy()
end

return ScoreBossResultPanel
