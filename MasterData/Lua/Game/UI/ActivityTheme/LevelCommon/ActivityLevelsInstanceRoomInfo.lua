local ActivityLevelsInstanceRoomInfo = class("ActivityLevelsInstanceRoomInfo", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
ActivityLevelsInstanceRoomInfo._mapNodeConfig = {
  BossChallenge = {
    sCtrlName = "Game.UI.DailyInstanceRoomInfo.DailyInstanceExp.DailyInstanceExp"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
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
  AnimatorInfo = {sNodeName = "rtnfo", sComponentName = "Animator"},
  AnimatorRoot = {
    sNodeName = "BossChallenge",
    sComponentName = "Animator"
  }
}
ActivityLevelsInstanceRoomInfo._mapEventConfig = {
  OpenActivityLevelsInstanceRoomInfo = "OnEvent_OpenUI",
  ActivityLevelsInstanceLevelEnd = "OnEvent_CloseUI",
  InputEnable = "OnEvent_InputEnable",
  ActivityLevelsInstanceBattleEnd = "OnEvent_BattleEnd",
  ActivityLevels_Instance_Gameplay_Time = "OnEvent_SpecialMode_Count"
}

function ActivityLevelsInstanceRoomInfo:Awake()
end

function ActivityLevelsInstanceRoomInfo:FadeIn()
end

function ActivityLevelsInstanceRoomInfo:FadeOut()
end

function ActivityLevelsInstanceRoomInfo:OnEnable()
  self.bBattleEnd = false
end

function ActivityLevelsInstanceRoomInfo:OnDisable()
end

function ActivityLevelsInstanceRoomInfo:OnDestroy()
end

function ActivityLevelsInstanceRoomInfo:OnRelease()
end

function ActivityLevelsInstanceRoomInfo:OnEvent_OpenUI(nLevelId, totalT)
  self._mapNode.BossChallenge.gameObject:SetActive(true)
  self:StartEvent(1, nLevelId, totalT)
end

function ActivityLevelsInstanceRoomInfo:OnEvent_CloseUI()
  self:LevelEnd()
end

function ActivityLevelsInstanceRoomInfo:OnEvent_InputEnable(bEnable)
  if self.bBattleEnd == true then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
end

function ActivityLevelsInstanceRoomInfo:OnEvent_BattleEnd()
  self.bBattleEnd = true
end

function ActivityLevelsInstanceRoomInfo:StartEvent(nWaitTime, nLevelId, totalT)
  self.mapLevelCfgData = ConfigTable.GetData("ActivityLevelsLevel", nLevelId)
  self.tbTime = {
    self.mapLevelCfgData.ThreeStarCondition[1],
    self.mapLevelCfgData.TwoStarCondition[1],
    self.mapLevelCfgData.OneStarCondition[1]
  }
  self.totalTime = self.mapLevelCfgData.OneStarCondition[1]
  self.nState = 1
  self.bEnd = false
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  self._mapNode.TMPDesc.gameObject:SetActive(false)
  self:SetTime(self.totalTime - totalT)
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
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
  
  local function waitCallback()
    self._mapNode.rtnfo:SetActive(true)
    self._mapNode.rtChallengeTime:SetActive(true)
    self._mapNode.TMPDesc.gameObject:SetActive(true)
  end
  
  self:AddTimer(1, nWaitTime, waitCallback, true, true, false)
end

function ActivityLevelsInstanceRoomInfo:OnEvent_SpecialMode_Count(nTime)
  if self.tbTime[self.nState] ~= nil then
    if self.tbTime[self.nState] - nTime <= 5 then
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
      self._mapNode.animatorTime:Play("BossChallengeTime_show")
    else
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
    end
    if self.tbTime[self.nState] - nTime == 5 then
      self._mapNode.AnimatorRoot:Play("BossChallenge_" .. 4 - self.nState)
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

function ActivityLevelsInstanceRoomInfo:StageChange()
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

function ActivityLevelsInstanceRoomInfo:SetTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function ActivityLevelsInstanceRoomInfo:LevelEnd()
  self._mapNode.AnimatorInfo:Play("FRRoomInfo_rtnfo_out")
  
  local function close()
    self.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.35, close, true, true, true)
end

return ActivityLevelsInstanceRoomInfo
