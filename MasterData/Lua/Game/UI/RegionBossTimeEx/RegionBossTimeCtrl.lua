local RegionBossTimeCtrl = class("RegionBossTimeCtrl", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
RegionBossTimeCtrl._mapNodeConfig = {
  TMPTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegionBossTime_SubTitle"
  },
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  btnStar = {sComponentName = "Button", nCount = 3},
  animatorRoot = {
    sNodeName = "BossChallenge",
    sComponentName = "Animator"
  },
  rtChallengeTime = {},
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  },
  AnimatorInfo = {sNodeName = "rtnfo", sComponentName = "Animator"},
  cgRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  }
}
RegionBossTimeCtrl._mapEventConfig = {
  RegionBoss_Time_CountUp = "OnEvent_SpecialMode_Count",
  RegionBoss_StartTime = "StartTime",
  RegionBoss_CloseTime = "CloseTime",
  InputEnable = "OnEvent_InputEnable"
}

function RegionBossTimeCtrl:SetTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function RegionBossTimeCtrl:OnEnable()
  local isWeeklyCopies = PlayerData.RogueBoss:GetIsWeeklyCopies()
  if isWeeklyCopies then
    self._mapNode.AnimatorInfo.gameObject:SetActive(false)
    self:SetTime(0)
  else
    local selLvId = PlayerData.RogueBoss:GetSelLvId()
    local lvMsg = ConfigTable.GetData("RegionBossLevel", selLvId)
    if lvMsg ~= nil then
      self.RegionType = lvMsg.RegionType
    end
    if self.RegionType == GameEnum.RegionType.NormalRegion then
      local star2 = decodeJson(lvMsg.TwoStarCondition)
      local star3 = decodeJson(lvMsg.ThreeStarCondition)
      self.bEnd = false
      self.totalTime = star2[2]
      self.tbTime = {
        star2[2],
        star2[2] - star3[2],
        0
      }
      self:SetTime(self.totalTime)
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
      self.nState = 1
      self:SetSubMsg()
    else
      self._mapNode.AnimatorInfo.gameObject:SetActive(false)
      self:SetTime(0)
    end
  end
  self._mapNode.rtChallengeTime.gameObject:SetActive(false)
end

function RegionBossTimeCtrl:SetSubMsg()
  if self.nState < 3 then
    if self.nState == 1 then
      NovaAPI.SetTMPText(self._mapNode.TMPDesc, orderedFormat(ConfigTable.GetUIText("RegionBossTime_SubTipsThreeStar"), self.tbTime[2]))
      for i = 1, 3 do
        self._mapNode.btnStar[i].interactable = true
      end
    else
      NovaAPI.SetTMPText(self._mapNode.TMPDesc, ConfigTable.GetUIText("RegionBossTime_SubTipsTwoStar"))
      self._mapNode.btnStar[3].interactable = false
    end
  else
    NovaAPI.SetTMPText(self._mapNode.TMPDesc, ConfigTable.GetUIText("RegionBossTime_SubTipsOneStar"))
    self._mapNode.btnStar[2].interactable = false
  end
end

function RegionBossTimeCtrl:OnEvent_SpecialMode_Count(nTime)
  if self.RegionType == GameEnum.RegionType.NormalRegion then
    local RemainingT = self.totalTime - nTime
    if self.tbTime[self.nState + 1] ~= nil then
      if RemainingT - self.tbTime[self.nState + 1] <= 5 then
        NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
        self._mapNode.animatorTime:Play("BossChallengeTime_show")
      else
        NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
      end
      if RemainingT - self.tbTime[self.nState + 1] == 5 then
        self._mapNode.animatorRoot:Play("BossChallenge_" .. 4 - self.nState)
      end
      if RemainingT == self.tbTime[self.nState + 1] then
        self:StageChange()
      end
    else
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
    end
    if 0 <= RemainingT then
      self:SetTime(RemainingT)
    else
      self:CloseTime()
    end
  else
    self:SetTime(nTime)
  end
end

function RegionBossTimeCtrl:StageChange()
  if self.bEnd then
    return
  end
  self.nState = self.nState + 1
  self:SetSubMsg()
end

function RegionBossTimeCtrl:StartTime()
  self._mapNode.rtChallengeTime.gameObject:SetActive(true)
end

function RegionBossTimeCtrl:CloseTime()
  self._mapNode.rtChallengeTime.gameObject:SetActive(false)
end

function RegionBossTimeCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgRoot, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, bEnable == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgRoot, bEnable == true)
end

return RegionBossTimeCtrl
