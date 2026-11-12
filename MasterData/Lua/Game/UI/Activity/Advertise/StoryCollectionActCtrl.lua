local StoryCollectionActCtrl = class("StoryCollectionActCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local JumpUtil = require("Game.Common.Utils.JumpUtil")
StoryCollectionActCtrl._mapNodeConfig = {
  txtActTime = {sComponentName = "TMP_Text"},
  btn_Go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  btn_Wait = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Wait"
  },
  txtBtn_GoRead = {
    sComponentName = "TMP_Text",
    sLanguageId = "ActivityAdv_StoryRead_Go"
  },
  txtBtn_Wait = {
    sComponentName = "TMP_Text",
    sLanguageId = "ActivityAdv_StoryRead_Wait"
  }
}
StoryCollectionActCtrl._mapEventConfig = {}

function StoryCollectionActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self.AdConfig = ConfigTable.GetData("AdControl", self.nActId)
  self:StartActTimer()
end

function StoryCollectionActCtrl:ClearActivity()
end

function StoryCollectionActCtrl:OnDisable()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  self.timer = nil
end

function StoryCollectionActCtrl:StartActTimer()
  local startTime = self.AdConfig.StartTime
  local nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(startTime)
  local nEndTime = self.actData:GetActEndTime()
  
  local function refreshTime()
    local nCurTime = ClientManager.serverTimeStamp
    local nRemainTime = 0
    local isOpen = false
    local sTime = ""
    if nCurTime < nStartTime then
      isOpen = false
      nRemainTime = math.max(nStartTime - nCurTime, 0)
      sTime = self:GetTimeStr(nRemainTime)
      NovaAPI.SetTMPText(self._mapNode.txtActTime, ConfigTable.GetUIText("ActivityAdv_StoryCountDown") .. sTime)
    elseif nCurTime >= nStartTime then
      isOpen = true
      local sStartTime = os.date("%Y/%m/%d", nStartTime)
      NovaAPI.SetTMPText(self._mapNode.txtActTime, sStartTime .. ConfigTable.GetUIText("ActivityAdv_StoryUpdate"))
      if self.timer ~= nil then
        self.timer:Cancel()
        self.timer = nil
      end
    end
    self._mapNode.btn_Go.gameObject:SetActive(isOpen)
    self._mapNode.btn_Wait.gameObject:SetActive(not isOpen)
  end
  
  refreshTime()
  self.timer = self:AddTimer(0, 1, refreshTime, true, true, true)
end

function StoryCollectionActCtrl:GetTimeStr(nRemainTime)
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

function StoryCollectionActCtrl:OnBtnClick_Go()
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

function StoryCollectionActCtrl:OnBtnClick_Wait()
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("ActivityAdv_StoryWait_Tip"))
end

return StoryCollectionActCtrl
