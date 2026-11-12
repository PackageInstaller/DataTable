local TravelerDuelRankingUploadCtrl = class("TravelerDuelRankingUploadCtrl", BaseCtrl)
TravelerDuelRankingUploadCtrl._mapNodeConfig = {
  TMPNewScoreTitle = {sComponentName = "TMP_Text"},
  TMPOldScoreTitle = {sComponentName = "TMP_Text"},
  TMPOldScore = {sComponentName = "TMP_Text"},
  TMPNewScore = {sComponentName = "TMP_Text"},
  TMPHintTimes = {sComponentName = "TMP_Text"},
  TMPHint = {sComponentName = "TMP_Text"},
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  }
}
TravelerDuelRankingUploadCtrl._mapEventConfig = {}
TravelerDuelRankingUploadCtrl._mapRedDotConfig = {}

function TravelerDuelRankingUploadCtrl:Awake()
end

function TravelerDuelRankingUploadCtrl:FadeIn()
end

function TravelerDuelRankingUploadCtrl:FadeOut()
end

function TravelerDuelRankingUploadCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nOldScore = tbParam[1]
  local nNewScore = tbParam[2]
  local nRemainTimes = tbParam[3]
  local tbChar = tbParam[4]
  self.tbChar = tbChar
  self.nNewScore = nNewScore
  NovaAPI.SetTMPText(self._mapNode.TMPOldScore, nOldScore)
  NovaAPI.SetTMPText(self._mapNode.TMPNewScore, nNewScore)
  NovaAPI.SetTMPText(self._mapNode.TMPHintTimes, orderedFormat(ConfigTable.GetUIText("TDRanking_UploadTimes"), nRemainTimes))
end

function TravelerDuelRankingUploadCtrl:OnDisable()
end

function TravelerDuelRankingUploadCtrl:OnDestroy()
end

function TravelerDuelRankingUploadCtrl:OnRelease()
end

function TravelerDuelRankingUploadCtrl:OnBtnClick_Confirm()
  PlayerData.TravelerDuel:SendMsg_UplodeTravelerDuelRanking(self.tbChar, self.nNewScore, nil)
  EventManager.Hit(EventId.ClosePanel, PanelId.TravelerDuelRankingUpload)
end

function TravelerDuelRankingUploadCtrl:OnBtnClick_Cancel()
  local function confirmCallback()
    EventManager.Hit("TDUploadRankEnd")
    
    EventManager.Hit(EventId.ClosePanel, PanelId.TravelerDuelRankingUpload)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("TravelerDuel_UploadCancelHint"),
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return TravelerDuelRankingUploadCtrl
