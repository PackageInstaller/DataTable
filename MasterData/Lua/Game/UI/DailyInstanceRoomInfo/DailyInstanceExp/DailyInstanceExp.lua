local DailyInstanceExp = class("DailyInstanceExp", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
DailyInstanceExp._mapNodeConfig = {
  rtnfo = {},
  TMPTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstanceExp_SubTitle"
  },
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  btnStar = {sComponentName = "Button", nCount = 3},
  rtChallengeTime = {},
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  },
  AnimatorInfo = {sNodeName = "rtnfo", sComponentName = "Animator"}
}
DailyInstanceExp._mapEventConfig = {}
local tbDescName = {
  [1] = "ThreeStarDesc",
  [2] = "TwoStarDesc",
  [3] = "OneStarDesc"
}

function DailyInstanceExp:Awake()
  self.AnimatorRoot = self.gameObject:GetComponent("Animator")
end

function DailyInstanceExp:FadeIn()
end

function DailyInstanceExp:FadeOut()
end

function DailyInstanceExp:OnEnable()
end

function DailyInstanceExp:OnDisable()
end

function DailyInstanceExp:OnDestroy()
  EventManager.Remove("Daily_Instance_Gameplay_Time", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
end

function DailyInstanceExp:OnRelease()
end

function DailyInstanceExp:SetTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function DailyInstanceExp:StartEvent(nFloorId, nWaitTime, nLevelId)
  local mapFloorCfgData = ConfigTable.GetData("DailyInstanceFloor", nFloorId)
  self.mapLevelCfgData = ConfigTable.GetData("DailyInstance", nLevelId)
  self.tbTime = {
    mapFloorCfgData.ThreeStarCondition,
    mapFloorCfgData.TwoStarCondition,
    mapFloorCfgData.OneStarCondition
  }
  self.totalTime = mapFloorCfgData.LevelTotalTime
  self.nState = 1
  self.bEnd = false
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  self._mapNode.TMPDesc.gameObject:SetActive(false)
  self:SetTime(self.totalTime)
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, self.mapLevelCfgData.ThreeStarDesc)
  local nStateDesc = 3 - #self.tbTime > 0 and 3 - #self.tbTime or 1
  if nStateDesc < 3 then
    local nextStateTime = self.totalTime - self.tbTime[nStateDesc]
    if 0 < nextStateTime then
      NovaAPI.SetTMPText(self._mapNode.TMPDesc, orderedFormat(ConfigTable.GetUIText("DailyInstanceExp_SubTips"), nextStateTime, tostring(4 - nStateDesc)))
    else
      NovaAPI.SetTMPText(self._mapNode.TMPDesc, ConfigTable.GetUIText("DailyInstanceExp_SubTips_Zero"))
    end
  else
    NovaAPI.SetTMPText(self._mapNode.TMPDesc, ConfigTable.GetUIText("DailyInstanceExp_SubTips_Zero"))
  end
  for i = 1, 3 do
    self._mapNode.btnStar[i].interactable = true
  end
  EventManager.Add("Daily_Instance_Gameplay_Time", self, self.OnEvent_SpecialMode_Count)
  EventManager.Add("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
  
  local function waitCallback()
    self._mapNode.rtnfo:SetActive(true)
    self._mapNode.TMPDesc.gameObject:SetActive(true)
  end
  
  self:AddTimer(1, nWaitTime, waitCallback, true, true, false)
  if nStateDesc < 3 then
    return orderedFormat(ConfigTable.GetUIText("FRBattleInfo_BossChallenge_Title"), self.tbTime[self.nState], ConfigTable.GetUIText("FRBattleInfo_Box" .. nStateDesc))
  else
    return ConfigTable.GetUIText("FRBattleInfo_BossChallenge_Min")
  end
end

function DailyInstanceExp:OnEvent_SpecialMode_Count(nTime)
  if self.tbTime[self.nState] ~= nil then
    if self.tbTime[self.nState] - nTime <= 5 then
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
      self._mapNode.animatorTime:Play("BossChallengeTime_show")
    else
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
    end
    if self.tbTime[self.nState] - nTime == 5 then
      self.AnimatorRoot:Play("BossChallenge_" .. 4 - self.nState)
    end
    if nTime >= self.tbTime[self.nState] then
      self:StageChange()
    end
  else
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  end
  local RemainingT = self.totalTime - nTime
  if 0 <= RemainingT then
    self:SetTime(RemainingT)
  end
end

function DailyInstanceExp:StageChange()
  if self.bEnd then
    return
  end
  self.nState = self.nState + 1
  
  local function failedCallback()
    if self.bEnd then
      self._mapNode.TMPDesc.gameObject:SetActive(false)
      return
    end
    local nStateDesc = 3 - #self.tbTime + self.nState > 0 and 3 - #self.tbTime + self.nState or 1
    if nStateDesc < 3 then
      local nextStateTime = self.totalTime - self.tbTime[nStateDesc]
      if 0 < nextStateTime then
        NovaAPI.SetTMPText(self._mapNode.TMPDesc, orderedFormat(ConfigTable.GetUIText("DailyInstanceExp_SubTips"), nextStateTime, tostring(4 - nStateDesc)))
      else
        NovaAPI.SetTMPText(self._mapNode.TMPDesc, ConfigTable.GetUIText("DailyInstanceExp_SubTips_Zero"))
      end
      for i = 1, 3 do
        if i <= 4 - nStateDesc then
          self._mapNode.btnStar[i].interactable = true
        else
          self._mapNode.btnStar[i].interactable = false
        end
      end
    else
      NovaAPI.SetTMPText(self._mapNode.TMPDesc, ConfigTable.GetUIText("DailyInstanceExp_SubTips_Zero"))
      self._mapNode.btnStar[1].interactable = true
      self._mapNode.btnStar[2].interactable = false
      self._mapNode.btnStar[3].interactable = false
    end
  end
  
  failedCallback()
end

function DailyInstanceExp:Success()
  self._mapNode.TMPDesc.gameObject:SetActive(false)
  self.bEnd = true
  
  local function playIconCallback()
  end
  
  local function playWinCallback()
  end
  
  local function closeWin()
    self._mapNode.rtChallengeTime:SetActive(false)
  end
  
  self:AddTimer(1, 0.6, playWinCallback, true, true, true)
  self:AddTimer(1, 2, closeWin, true, true, true)
end

function DailyInstanceExp:ShowRtChallengeTime()
  self._mapNode.rtChallengeTime:SetActive(true)
end

function DailyInstanceExp:LevelEnd()
  EventManager.Remove("Daily_Instance_Gameplay_Time", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
  self._mapNode.AnimatorInfo:Play("FRRoomInfo_rtnfo_out")
  
  local function close()
    self.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.35, close, true, true, true)
end

return DailyInstanceExp
