local StarTowerBossChallenge = class("StarTowerBossChallenge", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
StarTowerBossChallenge._mapNodeConfig = {
  rtnfo = {},
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  rtChallengeTime = {},
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  },
  AnimatorInfo = {sNodeName = "rtnfo", sComponentName = "Animator"}
}
StarTowerBossChallenge._mapEventConfig = {}

function StarTowerBossChallenge:Awake()
  self.AnimatorRoot = self.gameObject:GetComponent("Animator")
end

function StarTowerBossChallenge:FadeIn()
end

function StarTowerBossChallenge:FadeOut()
end

function StarTowerBossChallenge:OnEnable()
end

function StarTowerBossChallenge:OnDisable()
end

function StarTowerBossChallenge:OnDestroy()
  EventManager.Remove("StarTower_Start_Battle", self, self.OnEvent_StartBattle)
  EventManager.Remove("Roguelike_BossMonster_CountUp", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
end

function StarTowerBossChallenge:OnRelease()
end

function StarTowerBossChallenge:SetTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function StarTowerBossChallenge:StartEvent(tbTime)
  self.tbTime = tbTime
  self.nState = 1
  self.nAllState = #tbTime
  self.maxRewardTime = tbTime[self.nAllState]
  self.bEnd = false
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  self._mapNode.TMPDesc.gameObject:SetActive(false)
  self._mapNode.TMPComplete.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, "00:00")
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  local nStateDesc = 1
  local nextStateTime = self.tbTime[self.nState]
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, orderedFormat(ConfigTable.GetUIText("StarTower_BossChallenge"), nextStateTime, ConfigTable.GetUIText("FRBattleInfo_Box" .. nStateDesc)))
  EventManager.Add("StarTower_Start_Battle", self, self.OnEvent_StartBattle)
  EventManager.Add("Roguelike_BossMonster_CountUp", self, self.OnEvent_SpecialMode_Count)
  EventManager.Add("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
end

function StarTowerBossChallenge:OnEvent_StartBattle()
  self._mapNode.rtnfo:SetActive(true)
  self._mapNode.TMPDesc.gameObject:SetActive(true)
end

function StarTowerBossChallenge:OnEvent_SpecialMode_Count(nTime)
  local nCurTime = nTime
  local nextStateTime = 0
  if self.tbTime[self.nState] then
    nextStateTime = self.tbTime[self.nState]
  end
  if 0 < nextStateTime and nextStateTime - nCurTime <= 5 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
    self._mapNode.animatorTime:Play("BossChallengeTime_show")
  else
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  end
  if nCurTime == nextStateTime then
    self:StageChange()
  end
  if 0 <= nCurTime then
    self:SetTime(nCurTime)
  else
    self._mapNode.rtChallengeTime:SetActive(false)
  end
end

function StarTowerBossChallenge:StageChange()
  if self.bEnd then
    return
  end
  self.nState = self.nState + 1
  
  local function callback()
    if self.bEnd then
      self._mapNode.TMPDesc.gameObject:SetActive(false)
      self._mapNode.TMPComplete.gameObject:SetActive(true)
      return
    end
    self._mapNode.AnimatorInfo:Play("StarTowerRoomInfoBossRtnfo_switch", 0, 0)
    if self.nState > self.nAllState then
      NovaAPI.SetTMPText(self._mapNode.TMPDesc, ConfigTable.GetUIText("StarTower_BossChallenge_Min"))
    else
      local nextStateTime = self.tbTime[self.nState]
      local nStateDesc = 2
      NovaAPI.SetTMPText(self._mapNode.TMPDesc, orderedFormat(ConfigTable.GetUIText("StarTower_BossChallenge_Zero"), nextStateTime, ConfigTable.GetUIText("StarTower_RoomInfo_Box" .. nStateDesc)))
    end
    self._mapNode.TMPDesc.gameObject:SetActive(true)
    self.AnimatorRoot:Play("StarTowerBossChallenge_trail")
  end
  
  self:AddTimer(1, 0.7, callback, true, true, true)
end

function StarTowerBossChallenge:Success()
  self._mapNode.TMPDesc.gameObject:SetActive(false)
  self._mapNode.TMPComplete.gameObject:SetActive(true)
  self.bEnd = true
  self._mapNode.rtChallengeTime:SetActive(false)
  self._mapNode.AnimatorInfo:Play("StarTowerRoomInfoBossRtnfo_Finish", 0, 0)
  self:AddTimer(1, 3, function()
    self:EventEnd()
  end, true, true, true)
end

function StarTowerBossChallenge:EventEnd()
  EventManager.Remove("StarTower_Start_Battle", self, self.OnEvent_StartBattle)
  EventManager.Remove("Roguelike_BossMonster_CountUp", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.AnimatorInfo, {
    "StarTowerRoomInfoBossRtnfo_out"
  })
  self._mapNode.AnimatorInfo:Play("StarTowerRoomInfoBossRtnfo_out", 0, 0)
  self:AddTimer(1, nAnimLength, function()
    self.gameObject:SetActive(false)
  end, true, true, true)
end

function StarTowerBossChallenge:ShowRtChallengeTime()
  self._mapNode.rtChallengeTime:SetActive(true)
end

return StarTowerBossChallenge
