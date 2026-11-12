local ActivityMiningCtrl = class("ActivityMiningCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
local axeItemId = 0
local barMinX = -365
local barMaxX = 0
ActivityMiningCtrl._mapNodeConfig = {
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_Go"
  },
  txtBtnActDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_ActDetail"
  },
  btnActDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtAdvanceMat = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_RewardPre"
  },
  svItem = {
    sNodeName = "PreviewUpgradeMaterial",
    sComponentName = "LoopScrollView"
  },
  txt_quest = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_QuestTitle"
  },
  redDotQuest = {},
  btn_quest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txt_mainProcess = {sComponentName = "TMP_Text"},
  imgMainBarFill = {
    sComponentName = "RectTransform"
  }
}
ActivityMiningCtrl._mapEventConfig = {
  MiningQuestUpdate = "InitQuest",
  MiningCloseQuestPanel = "OnEvent_CloseQuestPanel"
}
ActivityMiningCtrl._mapRedDotConfig = {
  [RedDotDefine.Activity_Mining_AllQuest] = {
    sNodeName = "redDotQuest"
  }
}

function ActivityMiningCtrl:OnDestroy(...)
end

function ActivityMiningCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = self.actData:GetActId()
  self:ShowAddAxeCount()
  self:RefreshTimeout()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshTimeout", true, true, false)
  end
  self:InitItem()
  self:InitQuest()
end

function ActivityMiningCtrl:InitItem()
  local config = ConfigTable.GetData("MiningControl", self.nActId)
  if config == nil then
    return
  end
  local rewardData = config.RewardsShow
  self.tbReward = decodeJson(rewardData)
  self.tbItemIns = {}
  self._mapNode.svItem:Init(#self.tbReward, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function ActivityMiningCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  local goItem = go.transform:Find("AnimRoot/item").gameObject
  local instanceId = goItem:GetInstanceID()
  if self.tbItemIns[instanceId] == nil then
    self.tbItemIns[instanceId] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbItemIns[instanceId]:SetItem(itemId)
end

function ActivityMiningCtrl:OnGridBtnClick(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  UTILS.ClickItemGridWithTips(itemId, go.transform:Find("AnimRoot/item"), true, true, false)
end

function ActivityMiningCtrl:InitQuest()
  local allCount = self.actData:GetAllQuestCount()
  local receivedCount = self.actData:GetAllReceivedCount()
  NovaAPI.SetTMPText(self._mapNode.txt_mainProcess, receivedCount .. "/" .. allCount)
  self._mapNode.imgMainBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (receivedCount / allCount), self._mapNode.imgMainBarFill.anchoredPosition.y)
end

function ActivityMiningCtrl:RefreshTimeout()
  local endTime = self.actData:GetActEndTime()
  local curTime = ClientManager.serverTimeStamp
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
    return
  end
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
  NovaAPI.SetTMPText(self._mapNode.txtTime, sTimeStr)
end

function ActivityMiningCtrl:ShowAddAxeCount()
  local nActId = self.actData:GetActId()
  local data = PlayerData.Activity:GetActivityDataById(nActId)
  local nAddAxeCount = data:GetAddAxeCount()
  if 0 < nAddAxeCount then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Item,
      tbItem = {
        [1] = {nTid = axeItemId, nCount = nAddAxeCount}
      }
    })
    data:ResetAddAxeCount()
  end
end

function ActivityMiningCtrl:OnBtnClick_Go()
  local config = ConfigTable.GetData("MiningControl", self.nActId)
  if config == nil then
    return
  end
  
  local function callback()
    EventManager.Hit(EventId.OpenPanel, config.GamePanelId, self.nActId)
  end
  
  self.actData:RequestLevelData(0, callback)
end

function ActivityMiningCtrl:OnBtnClick_Quest()
  local config = ConfigTable.GetData("MiningControl", self.nActId)
  if config == nil then
    return
  end
  EventManager.Hit(EventId.OpenPanel, config.QuestPanelId, self.nActId)
end

function ActivityMiningCtrl:OnBtnClick_Detail()
  local config = ConfigTable.GetData("MiningControl", self.nActId)
  if config == nil then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Desc,
    sContent = config.Desc,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  })
end

function ActivityMiningCtrl:ClearActivity()
  if self.tbItemIns ~= nil then
    for _, ctrl in pairs(self.tbItemIns) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbItemIns = {}
end

return ActivityMiningCtrl
