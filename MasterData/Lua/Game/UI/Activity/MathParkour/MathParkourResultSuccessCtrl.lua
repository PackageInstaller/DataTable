local MathParkourResultSuccessCtrl = class("MathParkourResultSuccessCtrl", BaseCtrl)
MathParkourResultSuccessCtrl._mapNodeConfig = {
  txtCompleteTipsPrev1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_StarTitle"
  },
  ScoreStar = {nCount = 3},
  txtCompleteTipsPrev2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Text_CompleteTipsPrev"
  },
  txt_Complete = {sComponentName = "TMP_Text"},
  txt_curScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Text_NewScore"
  },
  btn_Confirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txt_confirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Text_Confirm"
  },
  btn_Nextlevel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextLevel"
  },
  txt_nextlevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Text_NextLevel"
  }
}
MathParkourResultSuccessCtrl._mapEventConfig = {}
MathParkourResultSuccessCtrl._mapRedDotConfig = {}

function MathParkourResultSuccessCtrl:ShowPanel(nScore, bNew, nStarCount, bCanNextLevel, nActId)
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txt_Complete, nScore)
  self._mapNode.txt_curScore.gameObject:SetActive(bNew)
  for i = 1, 3 do
    self._mapNode.ScoreStar[i].gameObject:SetActive(i <= nStarCount)
  end
  bCanNextLevel = bCanNextLevel or false
  self._mapNode.btn_Nextlevel.gameObject:SetActive(bCanNextLevel)
  self.actData = PlayerData.Activity:GetActivityDataById(nActId)
  if self.actData ~= nil then
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
    self:AddTimer(1, 1, function()
      self.actData:OpenTempChangeInfo()
    end, true, true, true)
  end
end

function MathParkourResultSuccessCtrl:HidePanel()
  self.gameObject:SetActive(false)
end

function MathParkourResultSuccessCtrl:OnBtnClick_Confirm()
  EventManager.Hit("MathParkour_Confirm")
end

function MathParkourResultSuccessCtrl:OnBtnClick_NextLevel()
  EventManager.Hit("MathParkour_NextLevel")
end

return MathParkourResultSuccessCtrl
