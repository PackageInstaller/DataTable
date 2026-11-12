local LoginSkinRewardCtrl_01 = class("LoginSkinRewardCtrl_01", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
LoginSkinRewardCtrl_01._mapNodeConfig = {
  btnDetail = {
    sNodeName = "btnActDetail",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnActDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  goActTime = {
    sNodeName = "imgRemaineTime"
  },
  imgEnd = {},
  txtActivityTime = {sNodeName = "txtTime", sComponentName = "TMP_Text"},
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Activity"
  },
  btnUnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Activity"
  },
  txtAdvanceMat = {sComponentName = "TMP_Text"},
  txtBtnReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  txtBtnUnReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Received"
  }
}
LoginSkinRewardCtrl_01._mapEventConfig = {
  ClickLoginRewardTips = "OnEvent_ClickLoginRewardTips"
}

function LoginSkinRewardCtrl_01:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self:RefreshDetail()
  local canReceive = self.actData:CheckCanReceive()
  self._mapNode.btnReward.gameObject:SetActive(canReceive)
  self._mapNode.btnUnReward.gameObject:SetActive(not canReceive)
  self._mapNode.imgEnd.gameObject:SetActive(false)
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

function LoginSkinRewardCtrl_01:RefreshRemainTime()
  local endTime = self.actData:GetActEndTime()
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  self._mapNode.goActTime.gameObject:SetActive(0 < remainTime)
  self._mapNode.imgEnd.gameObject:SetActive(remainTime <= 0)
  if remainTime < 0 then
    if self.remainTimer then
      TimerManager.Remove(self.remainTimer)
      self.remainTimer = nil
    end
    if self._bEndPopped then
      return
    end
    self._bEndPopped = true
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

function LoginSkinRewardCtrl_01:RefreshDetail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local bEmpty = mapActCfg.DesText == ""
  self._mapNode.btnDetail.gameObject:SetActive(not bEmpty)
  local sTips = ConfigTable.GetUIText("LoginSkinRewardTips1_301053") .. "\n" .. ConfigTable.GetUIText("LoginSkinRewardTips2_301053")
  NovaAPI.SetTMPText(self._mapNode.txtAdvanceMat, sTips)
end

function LoginSkinRewardCtrl_01:OnBtnClick_Detail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = mapActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function LoginSkinRewardCtrl_01:OnBtnClick_Activity()
  local function callback()
    self._mapNode.btnReward.gameObject:SetActive(false)
    
    local actData = PlayerData.Activity:GetActivityDataById(self.actData:GetActId())
    PlayerData.CharSkin:TryOpenSkinShowPanel()
    self:InitActData(actData)
  end
  
  local canReceive = self.actData:CheckCanReceive()
  if not canReceive then
    return
  end
  PlayerData.Activity:SendReceiveLoginRewardMsg(self.actData:GetActId(), callback)
  RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, false)
end

function LoginSkinRewardCtrl_01:OnEvent_ClickLoginRewardTips(callback, index)
  callback()
end

function LoginSkinRewardCtrl_01:OnBtnClick_Reward()
end

function LoginSkinRewardCtrl_01:OnDisable()
  if self.remainTimer then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
  end
end

return LoginSkinRewardCtrl_01
