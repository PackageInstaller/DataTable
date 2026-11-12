local LoginRewardPopUpCtrl_01 = class("LoginRewardPopUpCtrl_01", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
LoginRewardPopUpCtrl_01._mapNodeConfig = {
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"},
  btnActivity = {
    sComponentName = "Button",
    callback = "OnBtnClick_Activity"
  },
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_PopUp_Tip"
  },
  goRewardItem = {
    nCount = 7,
    sCtrlName = "Game.UI.Activity.LoginReward.LoginRewardItemCtrl_01"
  },
  imgActor = {nCount = 2, sComponentName = "Image"}
}
LoginRewardPopUpCtrl_01._mapEventConfig = {}
LoginRewardPopUpCtrl_01._mapRedDotConfig = {}

function LoginRewardPopUpCtrl_01:RefreshRemainTime()
  local endTime = self.actData:GetActEndTime()
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    self._mapNode.goActTime.gameObject:SetActive(false)
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

function LoginRewardPopUpCtrl_01:RefreshActData()
  self.nActId = self._panel.nActId
  self.actData = self._panel.actData
  self.remainTimer = nil
  self:RefreshRewardList()
  local actCfg = self.actData:GetActCfgData()
  if actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.goActTime.gameObject:SetActive(false)
  else
    self._mapNode.goActTime.gameObject:SetActive(true)
    self:RefreshRemainTime()
  end
end

function LoginRewardPopUpCtrl_01:RefreshRewardList()
  local tbRewardList = self.actData:GetActLoginRewardList()
  if nil ~= tbRewardList then
    for k, v in ipairs(self._mapNode.goRewardItem) do
      local mapReward = tbRewardList[k]
      v.gameObject:SetActive(mapReward ~= nil)
      if mapReward ~= nil then
        v:SetRewardItem(k, mapReward)
      end
    end
  end
end

function LoginRewardPopUpCtrl_01:PlayOutAnim()
  local nAnimLength = 0
  if self.animRoot ~= nil then
    nAnimLength = NovaAPI.GetAnimClipLength(self.animRoot, {
      "LoginReward_01_out"
    })
    self.animRoot:Play("LoginReward_01_out")
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
  end
  return nAnimLength
end

function LoginRewardPopUpCtrl_01:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function LoginRewardPopUpCtrl_01:OnEnable()
  if self.animRoot ~= nil then
    local nAnimLength = NovaAPI.GetAnimClipLength(self.animRoot, {
      "LoginReward_01_in"
    })
    self.animRoot:Play("LoginReward_01_in")
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
  end
end

function LoginRewardPopUpCtrl_01:OnDisable()
end

function LoginRewardPopUpCtrl_01:OnDestroy()
end

function LoginRewardPopUpCtrl_01:OnBtnClick_Activity()
  local bOpen = self.actData:CheckActivityOpen()
  if not bOpen then
    local function callback()
      EventManager.Hit("RefreshLoginRewardPanel")
    end
    
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_PopUp_Time_Out"),
      callbackConfirm = callback
    })
    return
  end
  local canReceive = self.actData:CheckCanReceive()
  if not canReceive then
    EventManager.Hit("RefreshLoginRewardPanel")
    return
  end
  local tbRewardList = self.actData:GetActLoginRewardList()
  local nReceive = self.actData:GetCanReceive()
  local mapNpc = {
    nNpcId = tbRewardList[nReceive].NpcId,
    nVoiceId = tbRewardList[nReceive].VoiceId
  }
  
  local function callback()
    EventManager.Hit("RefreshLoginRewardPanel")
  end
  
  PlayerData.Activity:SendReceiveLoginRewardMsg(self.nActId, callback)
end

return LoginRewardPopUpCtrl_01
