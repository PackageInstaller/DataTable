local ActivityDoubleDrop_103001PopUpCtrl = class("ActivityDoubleDrop_103001PopUpCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local ClientManager = CS.ClientManager.Instance
ActivityDoubleDrop_103001PopUpCtrl._mapNodeConfig = {
  goContent = {
    sNodeName = "---Common---"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_PopUp_Goto_1"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
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
ActivityDoubleDrop_103001PopUpCtrl._mapEventConfig = {}

function ActivityDoubleDrop_103001PopUpCtrl:ShowPopUp(actId, callback, index)
  self.popUpIndex = index
  self.dontShowAgain = false
  self.nCurActId = actId
  self.callback = callback
  self.actCfg = ConfigTable.GetData("Activity", self.nCurActId)
  local actData = PlayerData.Activity:GetActivityDataById(self.nCurActId)
  if actData == nil then
    return
  end
  self.nOpenTime = actData:GetActOpenTime()
  self.nEndTime = actData:GetActEndTime()
  self:RefreshTimeout()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshTimeout", true, true, true)
  end
  self._mapNode.imgDontShow1:SetActive(not self.dontShowAgain)
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function ActivityDoubleDrop_103001PopUpCtrl:PlayOpenAnim()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function ActivityDoubleDrop_103001PopUpCtrl:RefreshTimeout()
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

function ActivityDoubleDrop_103001PopUpCtrl:ClosePopUp(callback)
  if self.anim ~= nil then
    self.anim:Play("close", 0, 0)
    self:AddTimer(1, 0.1, function()
      if callback ~= nil then
        callback()
      end
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  elseif callback ~= nil then
    callback()
  end
end

function ActivityDoubleDrop_103001PopUpCtrl:OnBtnClick_DontShowAgain()
  self.dontShowAgain = not self.dontShowAgain
  self._mapNode.imgDontShow1:SetActive(not self.dontShowAgain)
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
  LocalData.SetPlayerLocalData("Act_PopUp_DontShow" .. self.nCurActId, self.dontShowAgain)
end

function ActivityDoubleDrop_103001PopUpCtrl:OnBtnClick_Close()
  self:ClosePopUp(self.callback)
end

function ActivityDoubleDrop_103001PopUpCtrl:OnBtnClick_Goto()
  local function callback()
    if nil ~= self.nCurActId then
      PopUpManager.InterruptPopUp(self.popUpIndex)
      
      PlayerData.Activity:SendActivityDetailMsg()
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
      EventManager.Hit(EventId.OpenPanel, PanelId.ActivityList, self.nCurActId)
    end
  end
  
  self:ClosePopUp(callback)
end

return ActivityDoubleDrop_103001PopUpCtrl
