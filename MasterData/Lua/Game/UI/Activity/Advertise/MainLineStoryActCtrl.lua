local MainLineStoryActCtrl = class("MainLineStoryActCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local JumpUtil = require("Game.Common.Utils.JumpUtil")
MainLineStoryActCtrl._mapNodeConfig = {
  txtActTime = {sComponentName = "TMP_Text"},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_MainLine_Goto"
  }
}

function MainLineStoryActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self.AdConfig = ConfigTable.GetData("AdControl", self.nActId)
  self:RefreshAct()
end

function MainLineStoryActCtrl:GetTimeStr(nRemainTime)
  local sTimeStr = ""
  if nRemainTime <= 60 then
    local sec = math.floor(nRemainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < nRemainTime and nRemainTime <= 3600 then
    local min = math.floor(nRemainTime / 60)
    local sec = math.floor(nRemainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < nRemainTime and nRemainTime <= 86400 then
    local hour = math.floor(nRemainTime / 3600)
    local min = math.floor((nRemainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < nRemainTime then
    local day = math.floor(nRemainTime / 86400)
    local hour = math.floor((nRemainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function MainLineStoryActCtrl:RefreshAct()
  local nStartTime = ClientManager:ISO8601StrToTimeStamp(self.AdConfig.StartTime)
  local nCurTime = ClientManager.serverTimeStamp
  local nRemainTime = 0
  local sTime = ""
  
  local function refresh()
    nCurTime = ClientManager.serverTimeStamp
    if nCurTime < nStartTime then
      self._mapNode.btnGo.gameObject:SetActive(false)
      nRemainTime = math.max(nStartTime - nCurTime, 0)
      sTime = self:GetTimeStr(nRemainTime)
      NovaAPI.SetTMPText(self._mapNode.txtActTime, ConfigTable.GetUIText("ActivityAdv_StoryCountDown") .. sTime)
    else
      self._mapNode.btnGo.gameObject:SetActive(true)
      local sStartTime = os.date("%Y/%m/%d", nStartTime)
      NovaAPI.SetTMPText(self._mapNode.txtActTime, sStartTime .. ConfigTable.GetUIText("Activity_MainLine_Story_Open"))
      if self.refreshTimer ~= nil then
        self.refreshTimer:Cancel()
        self.refreshTimer = nil
      end
    end
  end
  
  if self.refreshTimer ~= nil then
    self.refreshTimer:Cancel()
    self.refreshTimer = nil
  end
  refresh()
  self.refreshTimer = self:AddTimer(0, 1, refresh, true, true, true)
end

function MainLineStoryActCtrl:OnBtnClick_Go()
  local nEndTime = self.actData:GetActEndTime()
  local nCurTime = ClientManager.serverTimeStamp
  if nEndTime < nCurTime then
    return
  end
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  local jumpToId = self.AdConfig.JumpTo[1]
  JumpUtil.JumpTo(jumpToId)
end

return MainLineStoryActCtrl
