local TravelerDuelRankingUploadPanel = class("TravelerDuelRankingUploadPanel", BasePanel)
TravelerDuelRankingUploadPanel._bIsMainPanel = false
TravelerDuelRankingUploadPanel._tbDefine = {
  {
    sPrefabPath = "TravelerDuelLevelSelect/TDRankingUploadPanel.prefab",
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelRanking.TravelerDuelRankingUploadCtrl"
  }
}

function TravelerDuelRankingUploadPanel:Awake()
end

function TravelerDuelRankingUploadPanel:OnEnable()
end

function TravelerDuelRankingUploadPanel:OnAfterEnter()
end

function TravelerDuelRankingUploadPanel:OnDisable()
end

function TravelerDuelRankingUploadPanel:OnDestroy()
end

function TravelerDuelRankingUploadPanel:OnRelease()
end

return TravelerDuelRankingUploadPanel
