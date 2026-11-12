local ScoreBossClearBDPanel = class("ScoreBossClearBDPanel", BasePanel)
ScoreBossClearBDPanel._bIsMainPanel = false
ScoreBossClearBDPanel._tbDefine = {
  {
    sPrefabPath = "Play_ScoreBoss/ScoreBossClearBDPanel.prefab",
    sCtrlName = "Game.UI.ScoreBoss.ScoreBossClearBDCtrl"
  }
}

function ScoreBossClearBDPanel:Awake()
end

function ScoreBossClearBDPanel:OnEnable()
end

function ScoreBossClearBDPanel:OnDisable()
end

function ScoreBossClearBDPanel:OnDestroy()
end

function ScoreBossClearBDPanel:OnRelease()
end

return ScoreBossClearBDPanel
