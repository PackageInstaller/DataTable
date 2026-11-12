local TravelerDuelRankUploadSuccessCtrl = class("TravelerDuelRankUploadSuccessCtrl", BaseCtrl)
TravelerDuelRankUploadSuccessCtrl._mapNodeConfig = {
  TMPScoreTitle = {sComponentName = "TMP_Text"},
  TMPRankingTitle = {sComponentName = "TMP_Text"},
  TMPOldRanking = {sComponentName = "TMP_Text"},
  TMPNewRanking = {sComponentName = "TMP_Text"},
  TMPOldScore = {sComponentName = "TMP_Text"},
  TMPNewScore = {sComponentName = "TMP_Text"},
  imgRankIcon = {nCount = 4},
  btnMaskClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  imgArrowRanking = {},
  imgArrowScore = {},
  TMPFirstRanking = {sComponentName = "TMP_Text"},
  TMPFirstScore = {sComponentName = "TMP_Text"},
  imgFirstArrowRanking = {},
  imgFirstArrowScore = {},
  goNormalRanking = {},
  goNormalScore = {}
}
TravelerDuelRankUploadSuccessCtrl._mapEventConfig = {}
TravelerDuelRankUploadSuccessCtrl._mapRedDotConfig = {}

function TravelerDuelRankUploadSuccessCtrl:Awake()
end

function TravelerDuelRankUploadSuccessCtrl:FadeIn()
end

function TravelerDuelRankUploadSuccessCtrl:FadeOut()
end

function TravelerDuelRankUploadSuccessCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nOldScore = tbParam[1]
  local nNewScore = tbParam[2]
  local nOldRank = tbParam[3]
  local nNewRank = tbParam[4]
  local nRewardIdx = tbParam[5]
  if nOldRank == 0 and nOldScore == 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPFirstRanking, nNewRank)
    NovaAPI.SetTMPText(self._mapNode.TMPFirstScore, nNewScore)
    self._mapNode.imgFirstArrowRanking:SetActive(nOldRank < nNewRank)
    self._mapNode.imgFirstArrowScore:SetActive(nOldScore < nNewScore)
    self._mapNode.TMPFirstRanking.gameObject:SetActive(true)
    self._mapNode.TMPFirstScore.gameObject:SetActive(true)
    self._mapNode.goNormalRanking.gameObject:SetActive(false)
    self._mapNode.goNormalScore.gameObject:SetActive(false)
    self._mapNode.imgArrowScore:SetActive(false)
    self._mapNode.imgArrowRanking:SetActive(false)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPOldRanking, nOldRank)
    NovaAPI.SetTMPText(self._mapNode.TMPNewRanking, nNewRank)
    NovaAPI.SetTMPText(self._mapNode.TMPOldScore, nOldScore)
    NovaAPI.SetTMPText(self._mapNode.TMPNewScore, nNewScore)
    self._mapNode.imgArrowScore:SetActive(nOldScore < nNewScore)
    self._mapNode.imgArrowRanking:SetActive(nOldRank > nNewRank)
  end
  for i = 1, 4 do
    self._mapNode.imgRankIcon[i]:SetActive(nRewardIdx == i)
  end
end

function TravelerDuelRankUploadSuccessCtrl:OnDisable()
end

function TravelerDuelRankUploadSuccessCtrl:OnDestroy()
end

function TravelerDuelRankUploadSuccessCtrl:OnRelease()
end

function TravelerDuelRankUploadSuccessCtrl:OnBtnClick_Close()
  EventManager.Hit("TDUploadRankEnd")
  EventManager.Hit(EventId.ClosePanel, PanelId.TravelerDuelRankUploadSuccess)
end

return TravelerDuelRankUploadSuccessCtrl
