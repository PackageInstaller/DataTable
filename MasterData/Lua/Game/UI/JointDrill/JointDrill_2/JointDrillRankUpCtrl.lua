local JointDrillRankUpCtrl = class("JointDrillRankUpCtrl", BaseCtrl)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillRankUpCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "GameObject"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgTag = {},
  imgRank = {},
  txtRank = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Text"
  },
  txtRankBefore = {sComponentName = "TMP_Text"},
  txtRankAfter = {sComponentName = "TMP_Text"},
  imgRankUp = {},
  txtRankAfterUp = {sComponentName = "TMP_Text"},
  imgScore = {},
  txtRankScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Score"
  },
  txtScoreBefore = {sComponentName = "TMP_Text"},
  txtScoreAfter = {sComponentName = "TMP_Text"},
  imgScoreUp = {},
  txtAllRankScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Score_All"
  },
  txtScoreAfterUp = {sComponentName = "TMP_Text"},
  imgAllScore = {},
  txtAllScoreBefore = {sComponentName = "TMP_Text"},
  txtAllScoreAfter = {sComponentName = "TMP_Text"},
  imgAllScoreUp = {},
  txtAllScoreAfterUp = {sComponentName = "TMP_Text"}
}
JointDrillRankUpCtrl._mapEventConfig = {}
JointDrillRankUpCtrl._mapRedDotConfig = {}

function JointDrillRankUpCtrl:Refresh()
  NovaAPI.SetTMPText(self._mapNode.txtRankBefore, self:ThousandsNumber(self.nOld))
  NovaAPI.SetTMPText(self._mapNode.txtRankAfter, self:ThousandsNumber(self.nNew))
  NovaAPI.SetTMPText(self._mapNode.txtRankAfterUp, self:ThousandsNumber(self.nNew))
  local bNew = self.nNew < self.nOld or self.nOld == 0 and self.nNew > 0
  self._mapNode.imgRankUp.gameObject:SetActive(bNew)
  self._mapNode.txtRankAfter.gameObject:SetActive(not bNew)
  if self.mapScore ~= nil then
    local nScoreNew = self.mapScore.nScore
    local nScoreOld = self.mapScore.nScoreOld
    self._mapNode.txtScoreAfter.gameObject:SetActive(nScoreNew <= nScoreOld or self.nResultType ~= AllEnum.JointDrillResultType.Success)
    self._mapNode.imgScoreUp.gameObject:SetActive(nScoreNew > nScoreOld and self.nResultType == AllEnum.JointDrillResultType.Success)
    NovaAPI.SetTMPText(self._mapNode.txtScoreBefore, self:ThousandsNumber(nScoreOld))
    if self.nResultType == AllEnum.JointDrillResultType.Success then
      NovaAPI.SetTMPText(self._mapNode.txtScoreAfter, self:ThousandsNumber(math.max(nScoreOld, nScoreNew)))
    else
      NovaAPI.SetTMPText(self._mapNode.txtScoreAfter, self:ThousandsNumber(nScoreOld))
    end
    NovaAPI.SetTMPText(self._mapNode.txtScoreAfterUp, self:ThousandsNumber(nScoreNew))
    self._mapNode.imgTag.gameObject:SetActive(nScoreNew > nScoreOld and self.nResultType == AllEnum.JointDrillResultType.Success)
    local nTotalScoreNew = self.mapScore.nTotalScore or 0
    local nTotalScoreOld = nTotalScoreNew - nScoreNew
    self._mapNode.txtAllScoreAfter.gameObject:SetActive(nTotalScoreOld == nTotalScoreNew)
    self._mapNode.imgAllScoreUp.gameObject:SetActive(nTotalScoreNew > nTotalScoreOld)
    NovaAPI.SetTMPText(self._mapNode.txtAllScoreBefore, self:ThousandsNumber(nTotalScoreOld))
    NovaAPI.SetTMPText(self._mapNode.txtAllScoreAfter, self:ThousandsNumber(nTotalScoreNew))
    NovaAPI.SetTMPText(self._mapNode.txtAllScoreAfterUp, self:ThousandsNumber(nTotalScoreNew))
  end
end

function JointDrillRankUpCtrl:Awake()
end

function JointDrillRankUpCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if tbParam ~= nil then
    self.nOld = tbParam[1]
    self.nNew = tbParam[2]
    self.mapScore = tbParam[3]
    self.nResultType = tbParam[4]
    self.callback = tbParam[5]
  end
  self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self._mapNode.btnClose.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  self:Refresh()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function JointDrillRankUpCtrl:OnDisable()
end

function JointDrillRankUpCtrl:OnDestroy()
  if self.callback ~= nil then
    self.callback()
  end
end

function JointDrillRankUpCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(PlayerData.JointDrill_2.nActId, "RankUp"))
end

return JointDrillRankUpCtrl
