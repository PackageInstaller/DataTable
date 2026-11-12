local TravelerDuelRankUploadSuccessPanel = class("TravelerDuelRankUploadSuccessPanel", BasePanel)
TravelerDuelRankUploadSuccessPanel._bIsMainPanel = false
TravelerDuelRankUploadSuccessPanel._tbDefine = {
  {
    sPrefabPath = "TravelerDuelLevelSelect/TDUploadSuccessPanel.prefab",
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelRanking.TravelerDuelRankUploadSuccessCtrl"
  }
}

function TravelerDuelRankUploadSuccessPanel:Awake()
end

function TravelerDuelRankUploadSuccessPanel:OnEnable()
end

function TravelerDuelRankUploadSuccessPanel:OnAfterEnter()
end

function TravelerDuelRankUploadSuccessPanel:OnDisable()
end

function TravelerDuelRankUploadSuccessPanel:OnDestroy()
end

function TravelerDuelRankUploadSuccessPanel:OnRelease()
end

return TravelerDuelRankUploadSuccessPanel
