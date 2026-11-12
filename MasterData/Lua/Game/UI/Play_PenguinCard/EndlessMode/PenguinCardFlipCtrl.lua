local PenguinCardFlipCtrl = class("PenguinCardFlipCtrl", BaseCtrl)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local WwiseManger = CS.WwiseAudioManager.Instance
local LoopType = CS.DG.Tweening.LoopType
local ScaleUpTime = 0.3
local ScaleDownTime = 0.12
local _, BtnOn = ColorUtility.TryParseHtmlString("#b48339")
local _, BtnOff = ColorUtility.TryParseHtmlString("#3E3C5B")
PenguinCardFlipCtrl._mapNodeConfig = {
  aniHandRankBg = {
    sNodeName = "imgHandRankBg",
    sComponentName = "Animator"
  },
  txtFlipTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_FlipAllCardTip"
  },
  txtHandRank = {sComponentName = "TMP_Text"},
  imgSuitCount = {nCount = 6, sComponentName = "Image"},
  btnHandRank = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HandRank"
  },
  imgRoundTitleBg = {},
  txtRoundTip = {sComponentName = "TMP_Text"},
  btnShow = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Show"
  },
  PenguinBaseCard = {
    nCount = 5,
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinBaseCardCtrl"
  },
  imgNextRound = {},
  txtRound = {sComponentName = "TMP_Text"},
  btnNextRound = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextRound"
  },
  txtBtnNextRound = {sComponentName = "TMP_Text"},
  goNextRoundOn = {},
  btnShowAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowAll"
  },
  txtBtnShowAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_FlipAll"
  },
  goShowAllOn = {},
  imgCheckRound = {},
  txtCheckRound = {sComponentName = "TMP_Text"},
  btnCheckRound = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CheckRound"
  },
  txtBtnCheckRound = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_CheckRound"
  },
  goCheckRoundOff = {},
  btnAuto = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Auto"
  },
  imgBtnAuto = {sComponentName = "Image"},
  trAuto = {sNodeName = "imgBtnAuto", sComponentName = "Transform"},
  txtBtnAuto = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Auto"
  },
  btnSpeed = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Speed"
  },
  txtBtnSpeed = {sComponentName = "TMP_Text"},
  imgBtnSpeed = {nCount = 2, sComponentName = "Image"},
  txtRoundScore = {sComponentName = "TMP_Text"},
  txtRoundScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Round_Score"
  },
  txtRoundScoreBase = {sComponentName = "TMP_Text"},
  txtRoundScoreBaseCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Round_Base"
  },
  txtRoundScoreRatio = {sComponentName = "TMP_Text"},
  txtRoundScoreRatioCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Round_Ratio"
  },
  txtLevelAimScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_EndlessAimTitle"
  },
  txtLevelAimScore = {sComponentName = "TMP_Text"},
  imgGoalIcon = {},
  aniGoalTitleBg = {
    sNodeName = "imgGoalTitleBg",
    sComponentName = "Animator"
  },
  trRoundScore = {
    sNodeName = "txtRoundScore",
    sComponentName = "Transform"
  },
  trRoundScoreBase = {
    sNodeName = "txtRoundScoreBase",
    sComponentName = "Transform"
  },
  trRoundScoreRatio = {
    sNodeName = "txtRoundScoreRatio",
    sComponentName = "Transform"
  },
  aniRoundScoreBaseBg = {
    sNodeName = "imgRoundScoreBaseBg",
    sComponentName = "Animator"
  },
  aniRoundScoreRatioBg = {
    sNodeName = "imgRoundScoreRatioBg",
    sComponentName = "Animator"
  },
  txtScore = {sComponentName = "TMP_Text"},
  goHp = {nCount = 3, sComponentName = "Animator"},
  txtHp = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Endless_HP"
  }
}
PenguinCardFlipCtrl._mapEventConfig = {
  PenguinCard_ChangeRoundScore = "OnEvent_ChangeRoundScore",
  PenguinCard_ReplaceBaseCard = "OnEvent_ReplaceBaseCard",
  PenguinCard_ShowBaseCard = "OnEvent_ShowBaseCard",
  PenguinCard_Pause = "OnEvent_Pause",
  PenguinCard_Resume = "OnEvent_Resume",
  PenguinCard_QuitScoreAni = "QuitScoreAni",
  PenguinCard_ChangeHp = "OnEvent_ChangeHp",
  PenguinCard_ChangeScore = "OnEvent_ChangeScore",
  PenguinCard_ChangeCheckRoundLimit = "OnEvent_ChangeCheckRoundLimit",
  PenguinCard_ChangeRoundLimitInTurn = "OnEvent_ChangeRoundLimitInTurn"
}

function PenguinCardFlipCtrl:Refresh_Dealing()
  self._mapNode.imgNextRound:SetActive(false)
  self._mapNode.btnNextRound.gameObject:SetActive(false)
  self._mapNode.imgCheckRound:SetActive(false)
  self._mapNode.btnCheckRound.gameObject:SetActive(false)
  self._mapNode.imgRoundTitleBg:SetActive(false)
  self._mapNode.goNextRoundOn:SetActive(false)
  self._mapNode.btnShowAll.gameObject:SetActive(true)
  self._mapNode.btnShowAll.interactable = false
  self._mapNode.goShowAllOn:SetActive(false)
  self:RefreshRoundScore()
  self:RefreshHp()
  self._mapNode.aniRoundScoreBaseBg.gameObject:SetActive(false)
  self._mapNode.aniRoundScoreBaseBg.gameObject:SetActive(true)
  self._mapNode.aniRoundScoreRatioBg.gameObject:SetActive(false)
  self._mapNode.aniRoundScoreRatioBg.gameObject:SetActive(true)
  self._mapNode.aniHandRankBg:Play("PengUinCard_HandRank_Off", 0, 1)
  for i = 1, 5 do
    self._mapNode.btnShow[i].interactable = false
    self._mapNode.PenguinBaseCard[i]:Refresh(self._panel.mapLevel.tbBaseCardId[i])
    self._mapNode.PenguinBaseCard[i]:PlayInAni()
  end
  if self._panel.mapLevel.bCheckRound then
    self.animator:Play("PengUinCard_Flip_Card_shuffle", 0, 0)
    WwiseManger:PostEvent("Mode_Card_re")
  else
    if self._panel.mapLevel.nCurRound == 1 then
      self.animator:Play("PengUinCard_Flip_in", 0, 0)
    else
      self.animator:Play("PengUinCard_Flip_Card_in", 0, 0)
    end
    WwiseManger:PostEvent("Mode_Card_nextround")
  end
end

function PenguinCardFlipCtrl:Refresh_Flip()
  self._mapNode.btnShowAll.interactable = true
  for i = 1, 5 do
    self._mapNode.btnShow[i].interactable = true
  end
  self:StartShowAllOn()
  self.mapHandRankScore = {}
end

function PenguinCardFlipCtrl:Refresh_Settlement()
  if self._panel.mapLevel:GetRoundLimitInTurn() > self._panel.mapLevel.nCurRound then
    self._mapNode.imgNextRound:SetActive(true)
  end
  self._mapNode.btnNextRound.gameObject:SetActive(true)
  self._mapNode.btnNextRound.interactable = false
  self._mapNode.btnCheckRound.interactable = false
  self:AddTimer(1, 2 / self._panel.mapLevel.nSpeed, function()
    self._mapNode.btnNextRound.interactable = true
    self._mapNode.btnCheckRound.interactable = true
  end, true, true, true)
  self._mapNode.btnShowAll.gameObject:SetActive(false)
  self._mapNode.goShowAllOn:SetActive(false)
  self:RefreshRoundCount()
  self:RefreshCheckRoundCount()
  self._mapNode.aniHandRankBg:Play("PengUinCard_HandRank_On", 0, 0)
  self:RefreshHandRank()
  for i = 1, 5 do
    self._mapNode.PenguinBaseCard[i]:PlayTriggerAni()
    self._mapNode.btnShow[i].interactable = false
  end
  self:PlayScoreAni()
end

function PenguinCardFlipCtrl:RefreshRoundCount()
  NovaAPI.SetTMPText(self._mapNode.txtRound, orderedFormat(ConfigTable.GetUIText("PenguinCard_LeftRound"), self._panel.mapLevel:GetRoundLimitInTurn() - self._panel.mapLevel.nCurRound))
  if self._panel.mapLevel:GetRoundLimitInTurn() == self._panel.mapLevel.nCurRound then
    NovaAPI.SetTMPText(self._mapNode.txtBtnNextRound, ConfigTable.GetUIText("PenguinCard_Btn_EndTurn"))
    NovaAPI.SetTMPText(self._mapNode.txtRoundTip, ConfigTable.GetUIText("PenguinCard_EndTurnTip"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBtnNextRound, ConfigTable.GetUIText("PenguinCard_Btn_NextRound"))
    NovaAPI.SetTMPText(self._mapNode.txtRoundTip, ConfigTable.GetUIText("PenguinCard_NextRoundTip"))
  end
end

function PenguinCardFlipCtrl:RefreshCheckRoundCount()
  local nLimit = self._panel.mapLevel:GetCheckRoundLimit()
  NovaAPI.SetTMPText(self._mapNode.txtCheckRound, orderedFormat(ConfigTable.GetUIText("PenguinCard_LeftCheckRound"), nLimit - self._panel.mapLevel.nCheckRoundCount))
  self._mapNode.goCheckRoundOff:SetActive(self._panel.mapLevel.bCheckRound or nLimit <= self._panel.mapLevel.nCheckRoundCount)
  self._mapNode.btnCheckRound.gameObject:SetActive(0 < nLimit)
  self._mapNode.imgCheckRound:SetActive(0 < nLimit)
end

function PenguinCardFlipCtrl:RefreshHandRank()
  local nAll = #self._panel.mapLevel.tbHandRank
  if 0 < nAll then
    for i = 1, 6 do
      self._mapNode.imgSuitCount[i].gameObject:SetActive(i <= nAll)
      if i <= nAll then
        local sName = AllEnum.PenguinCardSuitSprite[self._panel.mapLevel.tbHandRank[i]]
        self:SetSprite(self._mapNode.imgSuitCount[i], "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. sName)
      end
    end
  end
  local mapCfg = ConfigTable.GetData("PenguinCardHandRank", self._panel.mapLevel.nHandRankId)
  if mapCfg then
    NovaAPI.SetTMPText(self._mapNode.txtHandRank, mapCfg.Title)
  end
end

function PenguinCardFlipCtrl:RefreshRoundScore()
  local nScore = math.floor(self._panel.mapLevel.nScore)
  local nRoundScore = math.floor(self._panel.mapLevel.nRoundScore)
  local nRoundValue = math.floor(self._panel.mapLevel.nRoundValue)
  local nAimScore = math.floor(self._panel.mapLevel:GetAimScore())
  local sScore = self:ThousandsNumber(nScore)
  local sAimScore = self:ThousandsNumber(nAimScore)
  NovaAPI.SetTMPText(self._mapNode.txtScore, sScore)
  NovaAPI.SetTMPText(self._mapNode.txtRoundScore, self:ThousandsNumber(nRoundScore))
  NovaAPI.SetTMPText(self._mapNode.txtRoundScoreBase, self:ThousandsNumber(nRoundValue))
  local nRatio = self._panel.mapLevel.nRoundMultiRatio > 0 and self._panel.mapLevel.nRoundRatio * self._panel.mapLevel.nRoundMultiRatio or self._panel.mapLevel.nRoundRatio
  NovaAPI.SetTMPText(self._mapNode.txtRoundScoreRatio, math.floor(nRatio * 100) / 100)
  if self._panel.mapLevel.nScore >= self._panel.mapLevel:GetAimScore() then
    self._mapNode.imgGoalIcon:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtLevelAimScore, "<color=#ffde6a>" .. sScore .. "</color>/" .. sAimScore)
  else
    self._mapNode.imgGoalIcon:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtLevelAimScore, sScore .. "/" .. sAimScore)
  end
end

function PenguinCardFlipCtrl:RefreshHp()
  for i = 1, 3 do
    if i > self._panel.mapLevel.nHp then
      self._mapNode.goHp[i]:Play("PenguinCardHp_Null", 0, 0)
    end
  end
end

function PenguinCardFlipCtrl:RefreshButton()
  self:RefreshAuto()
  self:RefreshSpeed()
end

function PenguinCardFlipCtrl:RefreshAuto()
  NovaAPI.SetImageColor(self._mapNode.imgBtnAuto, self._panel.mapLevel.bAuto and BtnOn or BtnOff)
  NovaAPI.SetTMPColor(self._mapNode.txtBtnAuto, self._panel.mapLevel.bAuto and BtnOn or BtnOff)
  if self._panel.mapLevel.bAuto == true then
    if self.tweener == nil then
      self.tweener = self._mapNode.trAuto:DOLocalRotate(Vector3(0, 0, -360), 2.6, RotateMode.FastBeyond360):SetLoops(-1, LoopType.Restart):SetEase(Ease.Linear):SetUpdate(true)
    end
  elseif self.tweener ~= nil then
    self.tweener:Kill()
    self._mapNode.trAuto.localRotation = Quaternion.identity
    self.tweener = nil
  end
end

function PenguinCardFlipCtrl:RefreshSpeed()
  local bFast = self._panel.mapLevel.nSpeed > 1
  NovaAPI.SetImageColor(self._mapNode.imgBtnSpeed[1], bFast and BtnOn or BtnOff)
  NovaAPI.SetImageColor(self._mapNode.imgBtnSpeed[2], bFast and BtnOn or BtnOff)
  NovaAPI.SetTMPColor(self._mapNode.txtBtnSpeed, bFast and BtnOn or BtnOff)
  NovaAPI.SetTMPText(self._mapNode.txtBtnSpeed, "<size=32>×</size>" .. self._panel.mapLevel.nSpeed)
end

function PenguinCardFlipCtrl:StartShowAllOn()
  self:StopShowAllOn()
  if self._mapNode.goShowAllOn.activeSelf == true then
    return
  end
  self.timerNextRoundOn = self:AddTimer(1, 3, function()
    self._mapNode.goShowAllOn:SetActive(true)
  end, true, true, true)
end

function PenguinCardFlipCtrl:StopShowAllOn()
  if self.timerNextRoundOn then
    self.timerNextRoundOn:Cancel()
    self.timerNextRoundOn = nil
  end
end

function PenguinCardFlipCtrl:PlayRoundAni()
  for i = 1, 5 do
    self._mapNode.PenguinBaseCard[i]:PlayHideAni()
  end
  self.animator:Play("PengUinCard_Flip_Card_out", 0, 0)
  self._mapNode.aniHandRankBg:Play("PengUinCard_HandRank_Off", 0, 0)
  self:QuitScoreAni()
end

function PenguinCardFlipCtrl:PlayRoundBackAni()
  for i = 1, 5 do
    self._mapNode.PenguinBaseCard[i]:PlayFlipBackAni()
  end
  self._mapNode.aniHandRankBg:Play("PengUinCard_HandRank_Off", 0, 0)
  self._mapNode.imgRoundTitleBg:SetActive(false)
  self:QuitScoreAni()
  self:RefreshRoundScore()
  self._mapNode.aniRoundScoreBaseBg.gameObject:SetActive(false)
  self._mapNode.aniRoundScoreBaseBg.gameObject:SetActive(true)
  self._mapNode.aniRoundScoreRatioBg.gameObject:SetActive(false)
  self._mapNode.aniRoundScoreRatioBg.gameObject:SetActive(true)
end

function PenguinCardFlipCtrl:QuitScoreAni()
  if self.sequence then
    self.sequence:Kill()
    self.sequence = nil
    WwiseManger:PostEvent("Mode_Card_stop")
    if not self.bEndScore and self._panel.mapLevel.nRoundMultiRatio and self._panel.mapLevel.nRoundRatio and self._panel.mapLevel.nRoundValue and self._panel.mapLevel.nRoundScore then
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreBase, self:ThousandsNumber(math.floor(self._panel.mapLevel.nRoundValue)))
      local nRatio = self._panel.mapLevel.nRoundMultiRatio > 0 and self._panel.mapLevel.nRoundRatio * self._panel.mapLevel.nRoundMultiRatio or self._panel.mapLevel.nRoundRatio
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreRatio, math.floor(nRatio * 100) / 100)
      local nRoundScore = math.floor(self._panel.mapLevel.nRoundScore)
      NovaAPI.SetTMPText(self._mapNode.txtRoundScore, self:ThousandsNumber(nRoundScore))
    end
  end
  if self.timerNextRoundOn then
    self.timerNextRoundOn:Cancel()
    self.timerNextRoundOn = nil
  end
end

function PenguinCardFlipCtrl:PlayScoreAni()
  self:QuitScoreAni()
  local bFire = self._panel.mapLevel.nRoundValue >= self.nFireScore
  local nTextTime = bFire and 0.6 / self._panel.mapLevel.nSpeed or 0.4 / self._panel.mapLevel.nSpeed
  self.bEndScore = false
  self.sequence = DOTween.Sequence()
  if self.mapHandRankScore and self.mapHandRankScore.nBeforeValue ~= self.mapHandRankScore.nAfterValue then
    local tw1 = DOTween.To(function()
      return self.mapHandRankScore.nBeforeValue
    end, function(v)
      local nScore = math.floor(v)
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreBase, self:ThousandsNumber(nScore))
    end, self.mapHandRankScore.nAfterValue, nTextTime)
    local tw2 = self._mapNode.trRoundScoreBase:DOScale(1.2, ScaleUpTime / self._panel.mapLevel.nSpeed):SetEase(Ease.OutQuart)
    local tw3 = self._mapNode.trRoundScoreBase:DOScale(1, ScaleDownTime / self._panel.mapLevel.nSpeed):SetEase(Ease.InQuad)
    if bFire then
      self.sequence:AppendCallback(function()
        self:PlayFireAni()
      end)
    end
    self.sequence:AppendCallback(function()
      WwiseManger:PostEvent("Mode_Card_integral")
    end)
    self.sequence:Append(tw2)
    self.sequence:Join(tw1)
    self.sequence:AppendInterval(ScaleUpTime / self._panel.mapLevel.nSpeed)
    self.sequence:Append(tw3)
  end
  if self.mapHandRankScore and self.mapHandRankScore.nBeforeRatio ~= self.mapHandRankScore.nAfterRatio then
    local tw1 = DOTween.To(function()
      return self.mapHandRankScore.nBeforeRatio
    end, function(v)
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreRatio, string.format("%.2f", v))
    end, self.mapHandRankScore.nAfterRatio, nTextTime)
    local tw2 = self._mapNode.trRoundScoreRatio:DOScale(1.2, ScaleUpTime / self._panel.mapLevel.nSpeed):SetEase(Ease.OutQuart)
    local tw3 = self._mapNode.trRoundScoreRatio:DOScale(1, ScaleDownTime / self._panel.mapLevel.nSpeed):SetEase(Ease.InQuad)
    if bFire then
      self.sequence:AppendCallback(function()
        self:PlayFireAni()
      end)
    end
    self.sequence:AppendCallback(function()
      WwiseManger:PostEvent("Mode_Card_integral")
    end)
    self.sequence:Append(tw2)
    self.sequence:Join(tw1)
    self.sequence:AppendInterval(ScaleUpTime / self._panel.mapLevel.nSpeed)
    self.sequence:Append(tw3)
  end
  self.sequence:AppendCallback(function()
    EventManager.Hit("PenguinCardWaitPlay")
  end)
  if self.mapHandRankScore and self.mapHandRankScore.nAfterValue ~= self._panel.mapLevel.nRoundValue then
    local tw1 = DOTween.To(function()
      return self.mapHandRankScore.nAfterValue
    end, function(v)
      local nScore = math.floor(v)
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreBase, self:ThousandsNumber(nScore))
    end, self._panel.mapLevel.nRoundValue, nTextTime)
    local tw2 = self._mapNode.trRoundScoreBase:DOScale(1.2, ScaleUpTime / self._panel.mapLevel.nSpeed):SetEase(Ease.OutQuart)
    local tw3 = self._mapNode.trRoundScoreBase:DOScale(1, ScaleDownTime / self._panel.mapLevel.nSpeed):SetEase(Ease.InQuad)
    if bFire then
      self.sequence:AppendCallback(function()
        self:PlayFireAni()
      end)
    end
    self.sequence:AppendCallback(function()
      WwiseManger:PostEvent("Mode_Card_integral")
    end)
    self.sequence:Append(tw2)
    self.sequence:Join(tw1)
    self.sequence:AppendInterval(ScaleUpTime / self._panel.mapLevel.nSpeed)
    self.sequence:Append(tw3)
  end
  local nRatio = self._panel.mapLevel.nRoundMultiRatio > 0 and self._panel.mapLevel.nRoundRatio * self._panel.mapLevel.nRoundMultiRatio or self._panel.mapLevel.nRoundRatio
  nRatio = math.floor(nRatio * 100) / 100
  if self.mapHandRankScore and self.mapHandRankScore.nAfterRatio ~= nRatio then
    local tw1 = DOTween.To(function()
      return self.mapHandRankScore.nAfterRatio
    end, function(v)
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreRatio, string.format("%.2f", v))
    end, nRatio, nTextTime)
    local tw2 = self._mapNode.trRoundScoreRatio:DOScale(1.2, ScaleUpTime / self._panel.mapLevel.nSpeed):SetEase(Ease.OutQuart)
    local tw3 = self._mapNode.trRoundScoreRatio:DOScale(1, ScaleDownTime / self._panel.mapLevel.nSpeed):SetEase(Ease.InQuad)
    if bFire then
      self.sequence:AppendCallback(function()
        self:PlayFireAni()
      end)
    end
    self.sequence:AppendCallback(function()
      WwiseManger:PostEvent("Mode_Card_integral")
    end)
    self.sequence:Append(tw2)
    self.sequence:Join(tw1)
    self.sequence:AppendInterval(ScaleUpTime / self._panel.mapLevel.nSpeed)
    self.sequence:Append(tw3)
  end
  local callback = dotween_callback_handler(self, function()
    WwiseManger:PostEvent("Mode_Card_coin_stop")
  end)
  local tw1 = DOTween.To(function()
    return 0
  end, function(v)
    local nScore = math.floor(v)
    NovaAPI.SetTMPText(self._mapNode.txtRoundScore, self:ThousandsNumber(nScore))
  end, self._panel.mapLevel.nRoundScore, nTextTime):OnComplete(callback)
  local tw2 = self._mapNode.trRoundScore:DOScale(1.1, ScaleUpTime / self._panel.mapLevel.nSpeed):SetEase(Ease.OutQuart)
  local tw3 = self._mapNode.trRoundScore:DOScale(1, ScaleDownTime / self._panel.mapLevel.nSpeed):SetEase(Ease.InQuad)
  self.sequence:AppendCallback(function()
    WwiseManger:PostEvent("Mode_Card_coin")
  end)
  self.sequence:Append(tw2)
  self.sequence:Join(tw1)
  self.sequence:AppendInterval(ScaleUpTime / self._panel.mapLevel.nSpeed)
  self.sequence:Append(tw3)
  self.sequence:AppendCallback(function()
    self._mapNode.imgRoundTitleBg:SetActive(true)
  end)
  self.sequence:SetUpdate(true)
  local reset = dotween_callback_handler(self, function()
    self.bEndScore = true
    self.timerNextRoundOn = self:AddTimer(1, 3, function()
      self._mapNode.goNextRoundOn:SetActive(true)
    end, true, true, true)
  end)
  self.sequence:OnComplete(reset)
end

function PenguinCardFlipCtrl:PlayOutAni()
  for i = 1, 5 do
    self._mapNode.PenguinBaseCard[i]:PlayHideAni()
  end
  self.animator:Play("PengUinCard_Flip_out", 0, 0)
  self:QuitScoreAni()
end

function PenguinCardFlipCtrl:PlayFireAni()
  self._mapNode.aniRoundScoreBaseBg:Play("PengUinCard_Flip_Score_Hot_01")
  self._mapNode.aniRoundScoreBaseBg.speed = self._panel.mapLevel.nSpeed
  self._mapNode.aniRoundScoreRatioBg:Play("PengUinCard_Flip_Score_Hot_02")
  self._mapNode.aniRoundScoreRatioBg.speed = self._panel.mapLevel.nSpeed
end

function PenguinCardFlipCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
  self.nFireScore = ConfigTable.GetConfigNumber("PenguinCardFeverScore") or 0
end

function PenguinCardFlipCtrl:OnEnable()
end

function PenguinCardFlipCtrl:OnDisable()
end

function PenguinCardFlipCtrl:OnBtnClick_HandRank()
  EventManager.Hit("PenguinCard_OpenHandRank")
end

function PenguinCardFlipCtrl:OnBtnClick_Show(btn, nIndex)
  self._panel.mapLevel:ShowBaseCard(nIndex)
end

function PenguinCardFlipCtrl:OnBtnClick_ShowAll(btn)
  self._panel.mapLevel:ShowBaseCard()
end

function PenguinCardFlipCtrl:OnBtnClick_NextRound(btn)
  self:QuitScoreAni()
  self._panel.mapLevel:NextRound()
end

function PenguinCardFlipCtrl:OnBtnClick_CheckRound(btn)
  local bAble = self._panel.mapLevel:CheckRound()
  if bAble then
    self:QuitScoreAni()
  end
end

function PenguinCardFlipCtrl:OnBtnClick_Auto(btn)
  local bAuto = not self._panel.mapLevel.bAuto
  self._panel.mapLevel:SetAutoState(bAuto)
  if self._panel.mapLevel.bAuto then
    self._panel.mapLevel:PlayAuto(true)
  else
    self._panel.mapLevel:StopAuto()
  end
  self:RefreshAuto()
end

function PenguinCardFlipCtrl:OnBtnClick_Speed(btn)
  local nSpeed = 3 - self._panel.mapLevel.nSpeed
  self._panel.mapLevel:SetAutoSpeed(nSpeed)
  self:RefreshSpeed()
end

function PenguinCardFlipCtrl:OnEvent_ChangeRoundScore(nBeforeValue, nBeforeRatio, nBeforeScore, bFromHandRank)
  if bFromHandRank then
    local nRatio = self._panel.mapLevel.nRoundMultiRatio > 0 and self._panel.mapLevel.nRoundRatio * self._panel.mapLevel.nRoundMultiRatio or self._panel.mapLevel.nRoundRatio
    nRatio = math.floor(nRatio * 100) / 100
    self.mapHandRankScore = {
      nBeforeValue = nBeforeValue,
      nAfterValue = self._panel.mapLevel.nRoundValue,
      nBeforeRatio = nBeforeRatio,
      nAfterRatio = nRatio
    }
    return
  end
  if self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Settlement then
    return
  end
  local bFire = self._panel.mapLevel.nRoundValue >= self.nFireScore
  if bFire then
    self:PlayFireAni()
  end
  local nTextTime = bFire and 0.6 / self._panel.mapLevel.nSpeed or 0.4 / self._panel.mapLevel.nSpeed
  if nBeforeValue ~= self._panel.mapLevel.nRoundValue then
    WwiseManger:PostEvent("Mode_Card_integral")
    DOTween.To(function()
      return nBeforeValue
    end, function(v)
      local nScore = math.floor(v)
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreBase, self:ThousandsNumber(nScore))
    end, self._panel.mapLevel.nRoundValue, nTextTime)
    local callback = dotween_callback_handler(self, function()
      self._mapNode.trRoundScoreBase:DOScale(1, ScaleDownTime / self._panel.mapLevel.nSpeed):SetEase(Ease.InQuad):SetUpdate(true)
    end)
    self._mapNode.trRoundScoreBase:DOScale(1.2, ScaleUpTime / self._panel.mapLevel.nSpeed):SetEase(Ease.OutQuart):SetUpdate(true):OnComplete(callback)
  end
  local nRatio = 0 < self._panel.mapLevel.nRoundMultiRatio and self._panel.mapLevel.nRoundRatio * self._panel.mapLevel.nRoundMultiRatio or self._panel.mapLevel.nRoundRatio
  nRatio = math.floor(nRatio * 100) / 100
  if nBeforeRatio ~= nRatio then
    WwiseManger:PostEvent("Mode_Card_integral")
    DOTween.To(function()
      return nBeforeRatio
    end, function(v)
      NovaAPI.SetTMPText(self._mapNode.txtRoundScoreRatio, string.format("%.2f", v))
    end, nRatio, nTextTime)
    local callback = dotween_callback_handler(self, function()
      self._mapNode.trRoundScoreRatio:DOScale(1, ScaleDownTime / self._panel.mapLevel.nSpeed):SetEase(Ease.InQuad):SetUpdate(true)
    end)
    self._mapNode.trRoundScoreRatio:DOScale(1.2, ScaleUpTime / self._panel.mapLevel.nSpeed):SetEase(Ease.OutQuart):SetUpdate(true):OnComplete(callback)
  end
end

function PenguinCardFlipCtrl:OnEvent_ShowBaseCard(nIndex)
  self:StartShowAllOn()
  if nIndex == nil then
    for i = 1, 5 do
      self._mapNode.PenguinBaseCard[i]:PlayFlipAni()
      self._mapNode.btnShow[i].interactable = false
    end
  else
    self._mapNode.PenguinBaseCard[nIndex]:PlayFlipAni()
    self._mapNode.btnShow[nIndex].interactable = false
  end
end

function PenguinCardFlipCtrl:OnEvent_ReplaceBaseCard(nIndex, bStone)
  self._mapNode.PenguinBaseCard[nIndex]:Refresh(self._panel.mapLevel.tbBaseCardId[nIndex], true)
  self._mapNode.PenguinBaseCard[nIndex]:PlayReplaceAni(bStone)
  self._mapNode.btnShow[nIndex].interactable = false
end

function PenguinCardFlipCtrl:OnEvent_ChangeHp(nChange)
  local bSkipSound = self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Dealing and self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Flip and self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Settlement
  if nChange < 0 then
    for i = self._panel.mapLevel.nHp + 1, self._panel.mapLevel.nHp - nChange do
      self._mapNode.goHp[i]:Play("PenguinCardHp_Del", 0, 0)
      if not bSkipSound then
        WwiseManger:PostEvent("Mode_Card_hurt")
      end
    end
  else
    for i = self._panel.mapLevel.nHp - nChange + 1, self._panel.mapLevel.nHp do
      self._mapNode.goHp[i]:Play("PenguinCardHp_Add")
      if not bSkipSound then
        WwiseManger:PostEvent("Mode_Card_heal")
      end
    end
  end
end

function PenguinCardFlipCtrl:OnEvent_ChangeScore(nBefore)
  if nBefore < self._panel.mapLevel.nScore and self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Settlement then
    WwiseManger:PostEvent("Mode_Card_coin")
  end
  local callback = dotween_callback_handler(self, function()
    if nBefore < self._panel.mapLevel.nScore and self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Settlement then
      WwiseManger:PostEvent("Mode_Card_coin_stop")
    end
  end)
  local nAimScore = self._panel.mapLevel:GetAimScore()
  local sAimScore = self:ThousandsNumber(math.floor(nAimScore))
  local bAim = nAimScore <= self._panel.mapLevel.nScore
  self._mapNode.imgGoalIcon:SetActive(bAim)
  if bAim and nBefore < nAimScore then
    self._mapNode.aniGoalTitleBg:Play("PenguinCard_GoalComplete", 0, 0)
    WwiseManger:PostEvent("Mode_Card_targetcomplete")
  end
  DOTween.To(function()
    return nBefore
  end, function(v)
    local nScore = math.floor(v)
    local sScore = self:ThousandsNumber(nScore)
    if bAim then
      NovaAPI.SetTMPText(self._mapNode.txtLevelAimScore, "<color=#ffde6a>" .. sScore .. "</color>/" .. sAimScore)
    else
      NovaAPI.SetTMPText(self._mapNode.txtLevelAimScore, sScore .. "/" .. sAimScore)
    end
  end, self._panel.mapLevel.nScore, 0.5):OnComplete(callback)
end

function PenguinCardFlipCtrl:OnEvent_ChangeCheckRoundLimit()
  if self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Settlement then
    return
  end
  self:RefreshCheckRoundCount()
end

function PenguinCardFlipCtrl:OnEvent_ChangeRoundLimitInTurn()
  if self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Settlement then
    return
  end
  self:RefreshRoundCount()
end

function PenguinCardFlipCtrl:OnEvent_Pause()
  if self.sequence then
    self.sequence:Pause()
    WwiseManger:PostEvent("Mode_Card_stop")
  end
end

function PenguinCardFlipCtrl:OnEvent_Resume()
  if self.sequence then
    self.sequence:Play()
  end
end

return PenguinCardFlipCtrl
