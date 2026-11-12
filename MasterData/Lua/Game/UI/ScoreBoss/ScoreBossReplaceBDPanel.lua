local ScoreBossReplaceBDPanel = class("ScoreBossReplaceBDPanel", BasePanel)
ScoreBossReplaceBDPanel._bIsMainPanel = false
ScoreBossReplaceBDPanel._tbDefine = {
  {
    sPrefabPath = "Play_ScoreBoss/ScoreBossReplaceBDPanel.prefab",
    sCtrlName = "Game.UI.ScoreBoss.ScoreBossReplaceBDCtrl"
  }
}

function ScoreBossReplaceBDPanel:Awake()
end

function ScoreBossReplaceBDPanel:OnEnable()
end

function ScoreBossReplaceBDPanel:OnDisable()
end

function ScoreBossReplaceBDPanel:OnDestroy()
end

function ScoreBossReplaceBDPanel:OnRelease()
end

return ScoreBossReplaceBDPanel
