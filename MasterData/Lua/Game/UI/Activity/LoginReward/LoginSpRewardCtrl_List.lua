local LoginSpRewardCtrl_List = class("LoginSpRewardCtrl_List", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local PlayerVoiceData = PlayerData.Voice
LoginSpRewardCtrl_List._mapNodeConfig = {
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
    sCtrlName = "Game.UI.Activity.LoginReward.LoginSpRewardItemCtrl"
  },
  btnRewardItem = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  btnActivity = {
    sComponentName = "Button",
    callback = "OnBtnClick_Activity"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  animActorL2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "Animator"
  },
  animActor2D = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Animator"
  },
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  },
  btnActor2D = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Actor2D"
  }
}
LoginSpRewardCtrl_List._mapEventConfig = {
  ClickLoginRewardTips = "OnEvent_ClickLoginRewardTips",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  ActivityListChangeTab = "OnEvent_ActivityListChangeTab",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}

function LoginSpRewardCtrl_List:RefreshRemainTime()
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

function LoginSpRewardCtrl_List:RefreshRewardList()
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

function LoginSpRewardCtrl_List:StopVoice()
  self.bPlayVoice = false
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:ClearTimer()
  PlayerVoiceData:StopCharVoice()
  if self.timer then
    self.timer:Cancel()
    self.timer = nil
  end
end

function LoginSpRewardCtrl_List:RefreshNPC2D(bSwitch)
  local tbRewardList = self.actData:GetActLoginRewardList()
  local nNpcId = tbRewardList[self.nSelectIndex].NpcId
  if nNpcId ~= self.nNpcId then
    self.nNpcId = nNpcId
    local bUseL2D = LocalSettingData.mapData.UseLive2D
    self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
    self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
    if bUseL2D == true then
      Actor2DManager.SetBoardNPC2D(PanelId.LoginSpReward_301011, self._mapNode.rawImgActor2D, self.nNpcId)
    else
      Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, PanelId.LoginSpReward_301011, self.nNpcId)
    end
    self._mapNode.animActor2D:Play("Actor2D_PNG_right_middle_in", 0, 0)
    self._mapNode.animActorL2D:Play("Actor2D_PNG_right_middle_in", 0, 0)
  end
  if bSwitch and self.bPlayVoice then
    self:StopVoice()
  else
    self:PlayVoice()
  end
end

function LoginSpRewardCtrl_List:PlayVoice()
  if self.bPlayVoice then
    return
  end
  local tbRewardList = self.actData:GetActLoginRewardList()
  local nVoiceId = tbRewardList[self.nSelectIndex].VoiceId
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nVoiceId)
  if not mapVoDirectoryData then
    return
  end
  local vo = PlayerVoiceData:PlayCharVoice(mapVoDirectoryData.votype, self.nNpcId, nil, true)
  if vo == 0 then
    return
  end
end

function LoginSpRewardCtrl_List:RefreshDetail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local bEmpty = mapActCfg.DesText == ""
  self._mapNode.btnDetail.gameObject:SetActive(not bEmpty)
end

function LoginSpRewardCtrl_List:InitActData(actData)
  self.actData = actData
  self.nNpcId = nil
  self.bPlayVoice = false
  self.bChangeTabStop = true
  self:RefreshRewardList()
  self:RefreshNPC2D()
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

function LoginSpRewardCtrl_List:Awake()
end

function LoginSpRewardCtrl_List:OnEnable()
end

function LoginSpRewardCtrl_List:OnDisable()
  Actor2DManager.UnsetBoardNPC2D()
  self:StopVoice()
end

function LoginSpRewardCtrl_List:OnDestroy()
end

function LoginSpRewardCtrl_List:OnBtnClick_Detail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = mapActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function LoginSpRewardCtrl_List:OnBtnClick_Actor2D()
  self:PlayVoice()
end

function LoginSpRewardCtrl_List:OnBtnClick_Activity()
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

function LoginSpRewardCtrl_List:OnEvent_ClickLoginRewardTips(callback, index)
  callback()
end

function LoginSpRewardCtrl_List:OnBtnClick_Item(btn, nIndex)
  if nIndex > self.nActual then
    return
  end
  if self.nSelectIndex == nIndex then
    self:RefreshNPC2D()
    return
  end
  if self.nSelectIndex then
    self._mapNode.goRewardItem[self.nSelectIndex]:SetSelect(false)
  end
  self._mapNode.goRewardItem[nIndex]:SetSelect(true)
  self.nSelectIndex = nIndex
  self:RefreshNPC2D(true)
end

function LoginSpRewardCtrl_List:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  if nNpcId ~= self.nNpcId then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
  local nTime = BubbleVoiceManager.GetVoResLen(mapVoDirectoryData.voResource)
  if 0 < nTime then
    self.bPlayVoice = true
    self.timer = self:AddTimer(1, nTime, function()
      self.bPlayVoice = false
    end, true, true, true)
  end
end

function LoginSpRewardCtrl_List:OnEvent_ActivityListChangeTab(nId)
  if nId == self.actData:GetActId() then
    self.bChangeTabStop = true
  elseif nId ~= self.actData:GetActId() and self.bChangeTabStop then
    self.bChangeTabStop = false
    self:StopVoice()
  end
end

function LoginSpRewardCtrl_List:OnEvent_ClosePanel(nPanelId)
  if nPanelId == PanelId.DiscSample then
    self.bPlayVoice = false
    self:PlayVoice()
  end
end

return LoginSpRewardCtrl_List
