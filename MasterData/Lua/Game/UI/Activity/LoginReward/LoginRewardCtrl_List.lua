local LoginRewardCtrl_List = class("LoginRewardCtrl_List", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
LoginRewardCtrl_List._mapNodeConfig = {
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"},
  goRewardItem = {
    nCount = 7,
    sCtrlName = "Game.UI.Activity.LoginReward.LoginRewardItemCtrl_01"
  },
  btnRewardItem = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  btnActivity = {
    sComponentName = "Button",
    callback = "OnBtnClick_Activity"
  }
}
LoginRewardCtrl_List._mapEventConfig = {
  ClickLoginRewardTips = "OnEvent_ClickLoginRewardTips"
}

function LoginRewardCtrl_List:RefreshRemainTime()
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

function LoginRewardCtrl_List:RefreshRewardList()
  local tbRewardList = self.actData:GetActLoginRewardList()
  if nil ~= tbRewardList then
    local nReceiveDay = self.actData:GetCanReceive()
    self.nActual = self.actData:GetReceived()
    local canReceive = self.actData:CheckCanReceive()
    if canReceive then
      self.nSelectIndex = self.actData:GetCanReceive()
    else
      self.nSelectIndex = self.nActual
    end
    for k, v in ipairs(self._mapNode.goRewardItem) do
      local mapReward = tbRewardList[k]
      v.gameObject:SetActive(mapReward ~= nil)
      if mapReward ~= nil then
        v:SetRewardItem(k, mapReward, true, nReceiveDay == self.nActual and k == self.nActual + 1, true)
        v:SetSelect(self.nSelectIndex == k)
      end
    end
  end
end

function LoginRewardCtrl_List:RefreshDetail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local bEmpty = mapActCfg.DesText == ""
  self._mapNode.btnDetail.gameObject:SetActive(not bEmpty)
end

function LoginRewardCtrl_List:InitActData(actData)
  self.actData = actData
  self.nNpcId = nil
  self.bPlayVoice = false
  self:RefreshRewardList()
  self:RefreshDetail()
  local canReceive = self.actData:CheckCanReceive()
  self._mapNode.btnActivity.gameObject:SetActive(canReceive)
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

function LoginRewardCtrl_List:Awake()
end

function LoginRewardCtrl_List:OnEnable()
end

function LoginRewardCtrl_List:OnDisable()
end

function LoginRewardCtrl_List:OnDestroy()
end

function LoginRewardCtrl_List:OnBtnClick_Detail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = mapActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function LoginRewardCtrl_List:OnBtnClick_Activity()
  local function callback()
    self._mapNode.btnActivity.gameObject:SetActive(false)
    
    local actData = PlayerData.Activity:GetActivityDataById(self.actData:GetActId())
    self:InitActData(actData)
  end
  
  local canReceive = self.actData:CheckCanReceive()
  if not canReceive then
    callback()
    return
  end
  local tbRewardList = self.actData:GetActLoginRewardList()
  local nReceive = self.actData:GetCanReceive()
  local mapNpc = {
    nNpcId = tbRewardList[nReceive].NpcId,
    nVoiceId = tbRewardList[nReceive].VoiceId
  }
  PlayerData.Activity:SendReceiveLoginRewardMsg(self.actData:GetActId(), callback, mapNpc)
end

function LoginRewardCtrl_List:OnEvent_ClickLoginRewardTips(callback, index)
  callback()
end

function LoginRewardCtrl_List:OnBtnClick_Item(btn, nIndex)
  if nIndex > self.nActual then
    return
  end
  if self.nSelectIndex then
    self._mapNode.goRewardItem[self.nSelectIndex]:SetSelect(false)
  end
  self._mapNode.goRewardItem[nIndex]:SetSelect(true)
  self.nSelectIndex = nIndex
end

return LoginRewardCtrl_List
