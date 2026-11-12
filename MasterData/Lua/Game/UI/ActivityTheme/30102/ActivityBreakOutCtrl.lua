local ActivityBreakOutCtrl = class("ActivityBreakOutCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
ActivityBreakOutCtrl._mapNodeConfig = {
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtTime = {sComponentName = "TMP_Text"},
  svReward = {
    sNodeName = "PreviewUpgradeMaterial",
    sComponentName = "LoopScrollView"
  },
  txtAdvanceMat = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Reward"
  },
  txtDate = {sComponentName = "TMP_Text"},
  imgLock = {},
  txtLock = {sComponentName = "TMP_Text"},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  imgEnd = {},
  txtActivityEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgRemaineTime = {},
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoToChallenge"
  },
  imgProgressBg = {
    sNodeName = "imgProgressBg"
  },
  imgFill = {sNodeName = "imgFill"},
  txt_Target = {
    sNodeName = "txt_Target",
    sComponentName = "TMP_Text",
    sLanguageId = "ChallengingGoals"
  },
  txtProgress = {
    sNodeName = "txtProgress",
    sComponentName = "TMP_Text"
  },
  btn_goTaskPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoTaskPanel"
  }
}

function ActivityBreakOutCtrl:Awake()
  self.tbGridCtrl = {}
end

function ActivityBreakOutCtrl:OnDisable()
  self:UnbindCtrl()
end

function ActivityBreakOutCtrl:InitActData(actData)
  self.actData = actData
  self:RefreshLockState()
  self:RefreshDate()
  self:RefreshTimeout()
  self:RefreshReward()
end

function ActivityBreakOutCtrl:UnInit()
  self:UnbindCtrl()
end

function ActivityBreakOutCtrl:UnbindCtrl()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function ActivityBreakOutCtrl:RefreshLockState()
  local IsUnlock, txtLock = self.actData:IsUnlock()
  self._mapNode.imgLock.gameObject:SetActive(not IsUnlock)
  self._mapNode.btnGo.gameObject:SetActive(IsUnlock)
  if not IsUnlock then
    NovaAPI.SetTMPText(self._mapNode.txtLock, txtLock)
  end
end

function ActivityBreakOutCtrl:RefreshTimeout()
  local endTime = self.actData:GetActGroupEndTime()
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  self._mapNode.imgRemaineTime:SetActive(0 < remainTime)
  self._mapNode.imgEnd:SetActive(remainTime <= 0)
  if remainTime < 0 then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
    return
  end
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtTime, sTimeStr)
end

function ActivityBreakOutCtrl:RefreshDate()
  local nOpenMonth, nOpenDay, nEndMonth, nEndDay, nOpenYear, nEndYear = self.actData:GetActGroupDate()
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s/%s ~ %s/%s/%s", nOpenYear, nOpenMonth, strOpenDay, nEndYear, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtDate, dateStr)
end

function ActivityBreakOutCtrl:RefreshReward()
  local actGroupCfg = self.actData:GetActGroupCfgData()
  local rewardData = actGroupCfg.RewardsShow
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.svReward:Init(#rewardData, self, self.RefreshRewardGridItem, self.BtnRewardGridClick)
end

function ActivityBreakOutCtrl:RefreshRewardGridItem(go, index)
  local actGroupCfg = self.actData:GetActGroupCfgData()
  local rewardData = actGroupCfg.RewardsShow
  local rewardId = rewardData[index + 1]
  local nInstanceID = go:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(go, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetItem(rewardId)
end

function ActivityBreakOutCtrl:BtnRewardGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local actGroupCfg = self.actData:GetActGroupCfgData()
  local rewardData = actGroupCfg.RewardsShow
  local item = goGrid.transform:Find("AnimRoot/item")
  UTILS.ClickItemGridWithTips(rewardData[nIndex], item.transform, true, true, false)
end

function ActivityBreakOutCtrl:OnBtnClick_Go()
  local actGroupCfg = self.actData:GetActGroupCfgData()
  if actGroupCfg ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.BreakOutThemePanel_S2, actGroupCfg.Id)
  end
end

function ActivityBreakOutCtrl:OnBtnClick_GoTaskPanel()
  EventManager.Hit(EventId.OpenPanel, PanelId.Task_30102, self.nActTaskId)
end

function ActivityBreakOutCtrl:OnBtnClick_Detail()
  local actGroupCfg = self.actData:GetActGroupCfgData()
  if actGroupCfg == nil then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = actGroupCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function ActivityBreakOutCtrl:ClearActivity()
end

return ActivityBreakOutCtrl
