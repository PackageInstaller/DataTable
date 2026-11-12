local ActivityChristmas_20101PopUpCtrl = class("ActivityChristmas_20101PopUpCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local ClientManager = CS.ClientManager.Instance
ActivityChristmas_20101PopUpCtrl._mapNodeConfig = {
  goContent = {
    sNodeName = "---Common---"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_PopUp_Goto"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtDate = {sComponentName = "TMP_Text"},
  txtTime = {sComponentName = "TMP_Text"},
  btnDontShow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DontShowAgain"
  },
  imgDontShow1 = {},
  imgDontShow2 = {},
  txtDontShow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_DontShow_PopUp_Again"
  }
}
ActivityChristmas_20101PopUpCtrl._mapEventConfig = {}

function ActivityChristmas_20101PopUpCtrl:ShowPopUp(actId, callback, index)
  self.popUpIndex = index
  self.dontShowAgain = false
  self.nCurActId = actId
  self.callback = callback
  self.actGroupCfg = ConfigTable.GetData("ActivityGroup", self.nCurActId)
  self.nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.StartTime)
  self.nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.EndTime)
  self:RefreshTimeout()
  self:RefreshDate()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshTimeout", true, true, true)
  end
  self._mapNode.imgDontShow1:SetActive(not self.dontShowAgain)
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function ActivityChristmas_20101PopUpCtrl:PlayOpenAnim()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function ActivityChristmas_20101PopUpCtrl:RefreshDate()
  local nOpenMonth = tonumber(os.date("%m", self.nOpenTime))
  local nOpenDay = tonumber(os.date("%d", self.nOpenTime))
  local nEndMonth = tonumber(os.date("%m", self.nEndTime))
  local nEndDay = tonumber(os.date("%d", self.nEndTime))
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s ~ %s/%s", nOpenMonth, strOpenDay, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtDate, dateStr)
end

function ActivityChristmas_20101PopUpCtrl:RefreshTimeout()
  local endTime = self.nEndTime
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    if self.remainTimer ~= nil then
      self.remainTimer:Cancel()
      self.remainTimer = nil
    end
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

function ActivityChristmas_20101PopUpCtrl:OnBtnClick_DontShowAgain()
  self.dontShowAgain = not self.dontShowAgain
  self._mapNode.imgDontShow1:SetActive(not self.dontShowAgain)
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
  LocalData.SetPlayerLocalData("Act_PopUp_DontShow" .. self.nCurActId, self.dontShowAgain)
end

function ActivityChristmas_20101PopUpCtrl:OnBtnClick_Close()
  if self.callback ~= nil then
    if self.anim then
      self.anim:Play("close")
      self:AddTimer(1, 0.2, function()
        self.callback()
      end, true, true, true)
    else
      self.callback()
    end
  end
end

function ActivityChristmas_20101PopUpCtrl:OnBtnClick_Goto()
  if nil ~= self.nCurActId then
    PopUpManager.InterruptPopUp(self.popUpIndex)
    PlayerData.Activity:SendActivityDetailMsg()
    self.anim:Play("close")
    self:AddTimer(1, 0.2, function()
      local endTime = self.nEndTime
      local curTime = ClientManager.serverTimeStamp
      local remainTime = endTime - curTime
      if remainTime <= 0 then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
        if self.callback ~= nil then
          self.callback()
        end
        return
      end
      EventManager.Hit(EventId.ClosePanel, PanelId.ActivityPopUp)
      if self.actGroupCfg.TransitionId ~= nil and 0 < self.actGroupCfg.TransitionId then
        local function callback()
          EventManager.Hit(EventId.OpenPanel, self.actGroupCfg.PanelId, self.actGroupCfg.Id)
        end
        
        EventManager.Hit(EventId.SetTransition, self.actGroupCfg.TransitionId, callback)
      else
        EventManager.Hit(EventId.OpenPanel, self.actGroupCfg.PanelId, self.actGroupCfg.Id)
      end
    end, true, true, true)
  end
end

return ActivityChristmas_20101PopUpCtrl
