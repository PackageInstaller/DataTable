local ScoreBossRankingPanel = class("ScoreBossRankingPanel", BasePanel)
ScoreBossRankingPanel._tbDefine = {
  {
    sPrefabPath = "Play_ScoreBoss/ScoreBossRankingPanel.prefab",
    sCtrlName = "Game.UI.ScoreBoss.ScoreBossRanking.ScoreBossRankingCtrl"
  }
}

function ScoreBossRankingPanel:Awake()
  self.mapRankDetail = nil
  self.nGridPos = 0
end

function ScoreBossRankingPanel:OnEnable()
end

function ScoreBossRankingPanel:OnDisable()
end

function ScoreBossRankingPanel:OnDestroy()
end

function ScoreBossRankingPanel:OnRelease()
end

return ScoreBossRankingPanel
