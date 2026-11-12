local ScoreBossLevelInfoCtrl = class("ScoreBossLevelInfoCtrl", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
local texCurScoreText = "{0}/<size=28>{1}</size>"
ScoreBossLevelInfoCtrl._mapNodeConfig = {
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  texStarCount = {sComponentName = "TMP_Text"},
  curScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Cur_Score"
  },
  texCurScore = {sComponentName = "TMP_Text"},
  texSkillScore = {sComponentName = "TMP_Text"},
  cgRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  },
  texCurSkill = {sComponentName = "TMP_Text"},
  skillAni = {
    sNodeName = "texCurSkillDb",
    sComponentName = "Animator"
  }
}
ScoreBossLevelInfoCtrl._mapEventConfig = {
  ScoreBoss_Gameplay_Time = "OnEvent_Time",
  ScoreBoss_Score_Change = "OnEvent_ScoreChange",
  ScoreBoss_Score_SkillChange = "OnEvent_SkillScoreChange",
  InputEnable = "OnEvent_InputEnable",
  ScoreBoss_Restart_Again = "InitMsg"
}

function ScoreBossLevelInfoCtrl:Awake()
  self:InitMsg()
end

function ScoreBossLevelInfoCtrl:InitMsg()
  self.isPlaySkillAni = false
  self.curTotal = 0
  self.maxStarCount = #PlayerData.ScoreBoss.tabScoreNeed
  NovaAPI.SetTMPText(self._mapNode.texStarCount, self.curTotal)
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", PlayerData.ScoreBoss.entryLevelId)
  self.getControl = ConfigTable.GetData("ScoreBossGetControl", bossLevelData.NonDamageScoreGet)
  self.OnceControlScore = self.getControl.OnceScore
  self.MaxSkillScore = math.floor(self.getControl.MaxLimit / self.getControl.OnceScore)
  NovaAPI.SetTMPText(self._mapNode.texSkillScore, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Info_SkillScore"), 0, self.OnceControlScore))
  local nTime = ConfigTable.GetConfigNumber("ScoreBossTimeLimit")
  self:OnEvent_Time(nTime)
  local needData = ConfigTable.GetData("ScoreBossStar", 1)
  NovaAPI.SetTMPText(self._mapNode.texCurScore, orderedFormat(texCurScoreText, 0, needData.ScoreNeed))
  NovaAPI.SetTMPText(self._mapNode.texCurSkill, self.getControl.Name .. "+0")
  self._mapNode.skillAni.gameObject:SetActive(false)
end

function ScoreBossLevelInfoCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
  if nTime <= 15 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
    self._mapNode.animatorTime:Play("BossChallengeTime_show")
  end
end

function ScoreBossLevelInfoCtrl:OnEvent_ScoreChange()
  local totalStar = PlayerData.ScoreBoss:ScoreToStar()
  local totalScore = PlayerData.ScoreBoss:GetTotalScore()
  local tmpLv = totalStar == self.maxStarCount and self.maxStarCount or totalStar + 1
  local needData = ConfigTable.GetData("ScoreBossStar", tmpLv)
  NovaAPI.SetTMPText(self._mapNode.texCurScore, orderedFormat(texCurScoreText, totalScore, needData.ScoreNeed))
  if totalStar > self.curTotal then
    self.curTotal = totalStar
    NovaAPI.SetTMPText(self._mapNode.texStarCount, self.curTotal)
  end
end

function ScoreBossLevelInfoCtrl:OnEvent_SkillScoreChange()
  local bScore, bScoreCount = PlayerData.ScoreBoss:GetBehaviorScore()
  NovaAPI.SetTMPText(self._mapNode.texCurSkill, self.getControl.Name .. "+" .. self.OnceControlScore)
  if bScoreCount < self.MaxSkillScore then
    NovaAPI.SetTMPText(self._mapNode.texSkillScore, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Info_SkillScore"), bScoreCount, self.OnceControlScore))
  else
    NovaAPI.SetTMPText(self._mapNode.texSkillScore, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Info_SkillScoreMax"), bScoreCount, self.OnceControlScore))
  end
  if self.isPlaySkillAni then
    if self.timeAni then
      self.timeAni:Cancel()
      self.timeAni = nil
    end
    if self.timeAniObj then
      self.timeAniObj:Cancel()
      self.timeAniObj = nil
    end
    self._mapNode.skillAni.gameObject:SetActive(true)
    self._mapNode.skillAni:Play("ScoreBossLevel_score_out")
    self:AddTimer(1, 0.167, function()
      self._mapNode.skillAni:Play("ScoreBossLevel_score_in")
      self.timeAniObj = self:AddTimer(1, 0.6, function()
        self._mapNode.skillAni:Play("ScoreBossLevel_score_out")
        self.timeAniObj = nil
      end, true, true, true)
    end, true, true, true)
  else
    self._mapNode.skillAni.gameObject:SetActive(true)
    self._mapNode.skillAni:Play("ScoreBossLevel_score_in")
    self.timeAniObj = self:AddTimer(1, 0.6, function()
      self._mapNode.skillAni:Play("ScoreBossLevel_score_out")
      self.timeAniObj = nil
    end, true, true, true)
  end
  self.isPlaySkillAni = true
  self.timeAni = self:AddTimer(1, 0.767, function()
    self._mapNode.skillAni.gameObject:SetActive(false)
    self.isPlaySkillAni = false
    self.timeAni = nil
  end, true, true, true)
end

function ScoreBossLevelInfoCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgRoot, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, bEnable == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgRoot, bEnable == true)
end

return ScoreBossLevelInfoCtrl
