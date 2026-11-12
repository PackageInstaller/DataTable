local LoginRewardPopUpCtrl_01 = class("LoginRewardPopUpCtrl_01", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
LoginRewardPopUpCtrl_01._mapNodeConfig = {
  imgActivity = {sComponentName = "Image"},
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
  sv = {
    sComponentName = "LoopScrollView"
  },
  imgActor = {sComponentName = "Image"},
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  }
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
  self:RefreshNPC2D()
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
    local nMaxDay = #tbRewardList
    local nActual = self.actData:GetReceived()
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self._mapNode.sv:SetAnim(0.06)
    self._mapNode.sv:Init(nMaxDay, self, self.OnGridRefresh)
    self._mapNode.sv:SetScrollGridPos(nActual - 1, 0)
  end
end

function LoginRewardPopUpCtrl_01:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local tbRewardList = self.actData:GetActLoginRewardList()
  local mapReward = tbRewardList[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Activity.LoginReward.LoginSpRewardItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetRewardItem(nIndex, mapReward)
end

function LoginRewardPopUpCtrl_01:RefreshNPC2D()
  local tbRewardList = self.actData:GetActLoginRewardList()
  local nReceive = self.actData:GetCanReceive()
  local nNpcId = tbRewardList[nReceive].NpcId
  local sPath = "LoginNpc_" .. nNpcId
  self:SetActivityAtlasSprite(self._mapNode.imgActor, "_" .. self.nActId, sPath)
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
  self.tbGridCtrl = {}
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
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
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
  
  PlayerData.Activity:SendReceiveLoginRewardMsg(self.nActId, callback, mapNpc)
end

return LoginRewardPopUpCtrl_01
