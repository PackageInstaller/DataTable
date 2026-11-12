local PeriodicQuestCtrl_cover = class("PeriodicQuestCtrl_cover", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
PeriodicQuestCtrl_cover._mapNodeConfig = {
  goCommon = {
    sNodeName = "---Common---"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  txtActivityTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_CopyMemo"
  },
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"}
}
PeriodicQuestCtrl_cover._mapEventConfig = {
  RefreshPeriodicAct = "OnEvent_RefreshPeriodicAct"
}

function PeriodicQuestCtrl_cover:OnDisable()
  self:UnbindCtrl()
end

function PeriodicQuestCtrl_cover:RefreshActInfo()
  if self.activityCtrl ~= nil then
    self.activityCtrl:RefreshQuestList()
  end
end

function PeriodicQuestCtrl_cover:UnbindCtrl()
  if self.activityCtrl ~= nil then
    self:UnbindCtrlByNode(self.activityCtrl)
    self.activityCtrl = nil
  end
end

function PeriodicQuestCtrl_cover:InitActData(actData, bResetGroup)
  if self.activityCtrl == nil then
    self.activityCtrl = self:BindCtrlByNode(self._mapNode.goCommon, "Game.UI.Activity.PeriodicQuest.PeriodicQuestCtrl")
  end
  self.actData = actData
  self.nActId = actData:GetActId()
  self.activityCtrl:InitActData(actData, bResetGroup)
  self:RefreshActInfo()
  self:SetTime()
end

function PeriodicQuestCtrl_cover:ClearActivity()
  self:UnbindCtrl()
end

function PeriodicQuestCtrl_cover:SetTime()
  local actCfg = self.actData:GetActCfgData()
  if actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.goActTime.gameObject:SetActive(false)
  else
    self._mapNode.goActTime.gameObject:SetActive(true)
    self:RefreshRemainTime()
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
    end
  end
end

function PeriodicQuestCtrl_cover:OnEvent_RefreshPeriodicAct(nActId)
  if nActId == self.nActId then
    self.bQuestAnim = false
    self:RefreshActInfo()
  end
end

function PeriodicQuestCtrl_cover:OnBtnClick_Detail()
  local perQuestActCfg = self.actData:GetPerQuestCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = perQuestActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function PeriodicQuestCtrl_cover:RefreshRemainTime()
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
  NovaAPI.SetTMPText(self._mapNode.txtActivityTime, sTimeStr)
end

return PeriodicQuestCtrl_cover
