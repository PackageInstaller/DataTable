local TraceHuntLevelInfoCtrl = class("TraceHuntLevelInfoCtrl", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
local texCurScoreText = "{0}/<size=28>{1}</size>"
TraceHuntLevelInfoCtrl._mapNodeConfig = {
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  texStarCount = {sComponentName = "TMP_Text"},
  curScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Cur_Score"
  },
  texCurScore = {sComponentName = "TMP_Text"},
  cgRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  },
  goTips = {},
  animatorTips = {sNodeName = "goTips", sComponentName = "Animator"},
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_MaxStarWin"
  }
}
TraceHuntLevelInfoCtrl._mapEventConfig = {
  TraceHunt_Gameplay_Time = "OnEvent_Time",
  TraceHunt_Score_Change = "OnEvent_ScoreChange",
  InputEnable = "OnEvent_InputEnable",
  TraceHunt_Restart_Again = "InitMsg",
  TraceHunt_MaxStar = "OnEvent_MaxStar"
}

function TraceHuntLevelInfoCtrl:Awake()
  self:InitMsg()
end

function TraceHuntLevelInfoCtrl:InitMsg()
  self.curTotal = 0
  self.maxStarCount = PlayerData.TraceHunt:GetMaxStar()
  NovaAPI.SetTMPText(self._mapNode.texStarCount, self.curTotal)
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  local nTime = PlayerData.TraceHunt:GetBossTimeLimit()
  self:OnEvent_Time(nTime)
  local need = PlayerData.TraceHunt:GetStarScore(1)
  NovaAPI.SetTMPText(self._mapNode.texCurScore, orderedFormat(texCurScoreText, 0, need))
  self._mapNode.goTips:SetActive(false)
end

function TraceHuntLevelInfoCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
  if nTime <= 15 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
    self._mapNode.animatorTime:Play("BossChallengeTime_show")
  end
end

function TraceHuntLevelInfoCtrl:OnEvent_ScoreChange()
  local totalStar = PlayerData.TraceHunt:ScoreToStar()
  local totalScore = PlayerData.TraceHunt:GetTotalScore()
  local tmpLv = totalStar == self.maxStarCount and self.maxStarCount or totalStar + 1
  local need = PlayerData.TraceHunt:GetStarScore(tmpLv)
  NovaAPI.SetTMPText(self._mapNode.texCurScore, orderedFormat(texCurScoreText, totalScore, need))
  if totalStar > self.curTotal then
    self.curTotal = totalStar
    NovaAPI.SetTMPText(self._mapNode.texStarCount, self.curTotal)
  end
end

function TraceHuntLevelInfoCtrl:OnEvent_MaxStar()
  self._mapNode.goTips:SetActive(true)
  self._mapNode.animatorTips:Play("FRRoomInfo_rtnfo_in", 0, 0)
  self:AddTimer(1, 1.5, function()
    self._mapNode.animatorTips:Play("FRRoomInfo_rtnfo_out", 0, 0)
  end, true, true, true)
end

function TraceHuntLevelInfoCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgRoot, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, bEnable == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgRoot, bEnable == true)
end

return TraceHuntLevelInfoCtrl
