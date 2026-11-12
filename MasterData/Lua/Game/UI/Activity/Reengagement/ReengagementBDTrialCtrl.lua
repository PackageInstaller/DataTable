local ReengagementBDTrialCtrl = class("ReengagementBDTrialCtrl", BaseCtrl)
local TimerManager = CS.TimerManager.Instance
local ClientManager = CS.ClientManager.Instance
ReengagementBDTrialCtrl._mapNodeConfig = {
  txtActName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_BDTrial_Title"
  },
  txtActValue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_BDTrial_TimeLimit"
  },
  txtBtnTriaDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_BDTrial_Title"
  },
  goInstanceItem = {
    nCount = 6,
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementBDPreviewItemCtrl"
  },
  txtTime = {sComponentName = "TMP_Text"}
}
ReengagementBDTrialCtrl._mapEventConfig = {}

function ReengagementBDTrialCtrl:Refresh(nCurTog)
  if nCurTog ~= AllEnum.ReengagementTog.BDTrial then
    return
  end
  self:RefreshTrialItems()
  self:RefreshRemainTime()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
  end
end

function ReengagementBDTrialCtrl:RefreshTrialItems()
  self.tbBuildIds = PlayerData.Reengagement:GetLimitedTrialBuildList()
  for k, nBuildId in ipairs(self.tbBuildIds) do
    local itemCtrl = self._mapNode.goInstanceItem[k]
    itemCtrl:Refresh(nBuildId)
  end
end

function ReengagementBDTrialCtrl:RefreshRemainTime()
  local endTime = PlayerData.Reengagement:GetReengagementCloseTime()
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
      callbackConfirm = function()
        EventManager.Hit(EventId.ClosePanel, PanelId.ReengagementPanel)
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
  NovaAPI.SetTMPText(self._mapNode.txtTime, sTimeStr)
end

return ReengagementBDTrialCtrl
