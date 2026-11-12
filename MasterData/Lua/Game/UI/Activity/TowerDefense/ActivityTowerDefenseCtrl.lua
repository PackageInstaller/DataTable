local ActivityTowerDefenseCtrl = class("ActivityTowerDefenseCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local barMinX = -365
local barMaxX = 0
local panelType = {
  Default = 1,
  QuestPanel = 2,
  StoryPanel = 3,
  DesPanel = 4
}
ActivityTowerDefenseCtrl._mapNodeConfig = {
  svItem = {
    sComponentName = "LoopScrollView"
  },
  txt_time = {sComponentName = "TMP_Text"},
  txt_des = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_ActivityDes"
  },
  btn_des = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txt_quest = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_QuestTitle"
  },
  redDotQuest = {},
  btn_quest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txt_mainProcess = {sComponentName = "TMP_Text"},
  imgMainBarFill = {
    sComponentName = "RectTransform"
  },
  txt_go = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_EnterActivity"
  },
  btn_go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  go_nextLevel = {},
  txt_nextLevelTime = {sComponentName = "TMP_Text"},
  txtRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_RewardPre"
  }
}
ActivityTowerDefenseCtrl._mapEventConfig = {
  TowerDefenseQuestUpdate = "InitQuest",
  TowerDefenseCloseQuestPanel = "OnEvent_CloseQuestPanel"
}
ActivityTowerDefenseCtrl._mapRedDotConfig = {
  [RedDotDefine.Activity_TowerDefense_AllQuest] = {
    sNodeName = "redDotQuest"
  }
}

function ActivityTowerDefenseCtrl:Awake()
end

function ActivityTowerDefenseCtrl:RefreshRemainTime()
  if self.actData.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.txt_time.transform.parent.gameObject:SetActive(false)
  else
    local endTime = self.actData:GetActEndTime()
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = endTime - curTime
    if remainTime < 0 then
      TimerManager.Remove(self.remainTimer)
      self.remainTimer = nil
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
        callbackConfirm = function()
          EventManager.Hit(EventId.ClosePanel, PanelId.ActivityList)
        end
      })
    end
    local sTimeStr = self:GetTimeText(remainTime)
    NovaAPI.SetTMPText(self._mapNode.txt_time, orderedFormat(ConfigTable.GetUIText("PerActivity_Remain_Time") or "", sTimeStr))
  end
  local nextLevelTime = self.actData:GetNextLevelUnlockTime()
  if nextLevelTime == 0 then
    self._mapNode.go_nextLevel:SetActive(false)
  else
    self._mapNode.go_nextLevel:SetActive(true)
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local nextLevelRemainTime = nextLevelTime - curTime
    local sNextLevelTime = self:GetTimeText(nextLevelRemainTime)
    NovaAPI.SetTMPText(self._mapNode.txt_nextLevelTime, orderedFormat(ConfigTable.GetUIText("TowerDef_LevelPreTime") or "", sNextLevelTime))
  end
end

function ActivityTowerDefenseCtrl:GetTimeText(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function ActivityTowerDefenseCtrl:InitItem()
  local rewardData = ConfigTable.GetData("TowerDefenseControl", self.nActId)
  if rewardData == nil then
    return
  end
  local rewardData = rewardData.RewardsShow
  self.tbReward = decodeJson(rewardData)
  self.tbItemIns = {}
  self._mapNode.svItem:Init(#self.tbReward, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function ActivityTowerDefenseCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  local goItem = go.transform:Find("btnGrid/AnimRoot/tcItem").gameObject
  local instanceId = goItem:GetInstanceID()
  if self.tbItemIns[instanceId] == nil then
    self.tbItemIns[instanceId] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbItemIns[instanceId]:SetItem(itemId)
end

function ActivityTowerDefenseCtrl:OnGridBtnClick(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  UTILS.ClickItemGridWithTips(itemId, go.transform:Find("btnGrid"), true, true, false)
end

function ActivityTowerDefenseCtrl:InitQuest()
  local allCount = self.actData:GetAllQuestCount()
  local receivedCount = self.actData:GetAllReceivedCount()
  NovaAPI.SetTMPText(self._mapNode.txt_mainProcess, receivedCount .. "/" .. allCount)
  self._mapNode.imgMainBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (receivedCount / allCount), self._mapNode.imgMainBarFill.anchoredPosition.y)
end

function ActivityTowerDefenseCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self:RefreshRemainTime()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
  end
  self:InitItem()
  self:InitQuest()
end

function ActivityTowerDefenseCtrl:ClearActivity()
  if self.tbItemIns ~= nil then
    for _, ctrl in pairs(self.tbItemIns) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbItemIns = {}
end

function ActivityTowerDefenseCtrl:OnBtnClick_Detail()
  local config = ConfigTable.GetData("TowerDefenseControl", self.nActId)
  if config == nil then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Desc,
    sContent = config.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  })
end

function ActivityTowerDefenseCtrl:OnBtnClick_Quest()
  EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseQuest, self.nActId)
end

function ActivityTowerDefenseCtrl:OnBtnClick_Go()
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseSelectPanel, self.nActId)
end

return ActivityTowerDefenseCtrl
