local InfinityTowerBattleMsgCtrl = class("InfinityTowerBattleMsgCtrl", BaseCtrl)
local BarHeight = 40
local BarWidth = 816
InfinityTowerBattleMsgCtrl._mapNodeConfig = {
  TimeRoot = {},
  EscapeRoot = {},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Task_Target"
  },
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  rtMonsterCount = {},
  imgMonsterCountFill = {
    sComponentName = "HpBarRectTransform"
  },
  texMonsterRemaining = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_MonsterRemaining"
  },
  imgMonsterCountRecoverLight = {}
}
InfinityTowerBattleMsgCtrl._mapEventConfig = {
  Infinity_Tower_RunTime = "OnEvent_RunTime",
  Infinity_Tower_StartTime = "OnEvent_StartTime",
  Infinity_Hide_Time = "OnEvent_HideTime",
  Infinity_Refresh_Msg = "OnEvent_RefreshMsg",
  InputEnable = "OnEvent_InputEnable",
  Infinity_RefreshCountRemaining = "OnEvent_RefreshMonsterCountFill",
  InteractiveBtnClick = "OnEvent_InteractiveBtnClick"
}

function InfinityTowerBattleMsgCtrl:Awake()
  self.str_1 = "<color=#ffffff>%s:%s</color>"
  self.str_2 = "<color=#D85054>%s:%s</color>"
end

function InfinityTowerBattleMsgCtrl:FadeIn()
end

function InfinityTowerBattleMsgCtrl:FadeOut()
end

function InfinityTowerBattleMsgCtrl:OnEnable()
  self._mapNode.TimeRoot:SetActive(false)
  self._mapNode.rtMonsterCount:SetActive(false)
  self._mapNode.EscapeRoot:SetActive(true)
  self:InitMsg()
end

function InfinityTowerBattleMsgCtrl:OnDisable()
end

function InfinityTowerBattleMsgCtrl:OnDestroy()
end

function InfinityTowerBattleMsgCtrl:OnRelease()
end

function InfinityTowerBattleMsgCtrl:InitMsg()
  local lvId = PlayerData.InfinityTower:GetCurrentLv()
  local lvData = ConfigTable.GetData("InfinityTowerLevel", lvId)
  local diffData = ConfigTable.GetData("InfinityTowerDifficulty", lvData.DifficultyId)
  local towerId = diffData.TowerId
  local diffSort = diffData.Sort
  local data = PlayerData.InfinityTower:GetTowerDiffData(towerId, diffSort)
  local dataLv = data.level
  local firstFloor = data.firstFloor
  local endFloor = data.endFloor
  local indexlvCount = 0
  for i = firstFloor, endFloor do
    local tmpData = dataLv[i]
    indexlvCount = indexlvCount + 1
    if tmpData.Id == lvId then
      break
    end
  end
  local strIndex = indexlvCount
  if indexlvCount < 10 then
    strIndex = "0" .. indexlvCount
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, string.format(ConfigTable.GetUIText("Infinity_Diff_Lv"), diffSort, strIndex))
  self:InitMonsterCountFill()
end

function InfinityTowerBattleMsgCtrl:OnEvent_StartTime()
  self._mapNode.TimeRoot:SetActive(true)
  local lvId = PlayerData.InfinityTower:GetCurrentLv()
  local lvData = ConfigTable.GetData("InfinityTowerLevel", lvId)
  local floorId = lvData.FloorId
  local floorData = ConfigTable.GetData("InfinityTowerFloor", floorId)
  self.totalTime = floorData.LimitTime
  self:OnEvent_RunTime(0)
  self._mapNode.rtMonsterCount:SetActive(floorData.FloorFunc == GameEnum.fixedRoguelikeFunc0.Battle)
end

function InfinityTowerBattleMsgCtrl:OnEvent_RunTime(rTime)
  local remainingT = self.totalTime - rTime
  local min = math.floor(remainingT / 60)
  local sec = remainingT - min * 60
  local strMin = tostring(min)
  if min < 10 then
    strMin = "0" .. strMin
  end
  local strSec = tostring(sec)
  if sec < 10 then
    strSec = "0" .. strSec
  end
  if 10 < remainingT then
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format(self.str_1, strMin, strSec))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format(self.str_2, strMin, strSec))
    self._mapNode.animatorTime:Play("BossChallengeTime_show")
  end
end

function InfinityTowerBattleMsgCtrl:OnEvent_HideTime()
  self._mapNode.TimeRoot:SetActive(false)
  self._mapNode.rtMonsterCount:SetActive(false)
end

function InfinityTowerBattleMsgCtrl:OnEvent_RefreshMsg()
  self:InitMsg()
end

function InfinityTowerBattleMsgCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
end

function InfinityTowerBattleMsgCtrl:InitMonsterCountFill()
  self._mapNode.imgMonsterCountFill:SetTarget(Vector2(BarWidth, BarHeight), 0)
  self._mapNode.imgMonsterCountRecoverLight:SetActive(false)
end

function InfinityTowerBattleMsgCtrl:OnEvent_RefreshMonsterCountFill(count, maxCount)
  self._mapNode.imgMonsterCountRecoverLight:SetActive(true)
  local nWidth = 1 <= count / maxCount and BarWidth or count / maxCount * BarWidth
  self._mapNode.imgMonsterCountFill:SetTarget(Vector2(nWidth, BarHeight), 0)
end

function InfinityTowerBattleMsgCtrl:OnEvent_InteractiveBtnClick()
  PlayerData.InfinityTower:OnEvent_PlayTwinEffect()
end

return InfinityTowerBattleMsgCtrl
