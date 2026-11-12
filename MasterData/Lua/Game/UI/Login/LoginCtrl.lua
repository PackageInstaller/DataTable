local LocalData = require("GameCore.Data.LocalData")
local SDKManager = CS.SDKManager.Instance
local ClientManager = CS.ClientManager
local AgeTipsCN = "zs_login_tip"
local AgeTipsKR = "zs_login_tip_kr"
local AgeTipsTW = "zs_login_tip_tw"
local LoginCtrl = class("LoginCtrl", BaseCtrl)
LoginCtrl._mapNodeConfig = {
  LoginBG = {sComponentName = "Image"},
  SelectServerRoot = {
    sComponentName = "CanvasGroup"
  },
  SelectServerBgBtn = {
    sComponentName = "Button",
    callback = "OnNextBtnClick"
  },
  ServerState = {sComponentName = "Image"},
  ServerName = {sComponentName = "TMP_Text"},
  SwitchServerBtn = {
    sComponentName = "UIButton",
    callback = "OnSwitchServerBtnClick"
  },
  AddressInputField = {sComponentName = "InputField"},
  NextBtn = {
    sComponentName = "UIButton",
    callback = "OnNextBtnClick"
  },
  ServerListRoot = {
    sComponentName = "CanvasGroup"
  },
  ServerScrollView = {
    sComponentName = "LoopScrollView"
  },
  CloseBtn = {
    sComponentName = "UIButton",
    callback = "OnCloseBtnClick"
  },
  ChangeAccountRoot = {
    sComponentName = "CanvasGroup"
  },
  EnterGameBtn = {
    sComponentName = "Button",
    callback = "OnEnterGameBtnClick"
  },
  AccountInputField = {sComponentName = "InputField"},
  PasswordInputField = {sComponentName = "InputField"},
  PrevBtn = {
    sComponentName = "UIButton",
    callback = "OnPrevBtnClick"
  },
  ClickLoginRoot = {
    sComponentName = "CanvasGroup"
  },
  btnClickLogin = {
    sComponentName = "Button",
    callback = "OnBtnClick_ClickLogin"
  },
  btnAgeTip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AgeTip"
  },
  imgAgeTip = {sNodeName = "btnAgeTip", sComponentName = "Image"},
  txtHint = {sComponentName = "TMP_Text", sLanguageId = "Login_Hint"},
  SDKLoginRoot = {
    sComponentName = "CanvasGroup"
  },
  btnSdkLogin = {
    sComponentName = "Button",
    callback = "OnBtnClick_ClickLoginSdk"
  },
  LoginTipsRoot = {
    sComponentName = "CanvasGroup"
  },
  txtLoginTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Login_Click_Tip"
  },
  SkipRoot = {},
  togSkip = {
    nCount = 3,
    sComponentName = "Toggle",
    callback = "OnTogChange_Skip"
  },
  btnQuit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quit"
  },
  TMPQuitBtn = {sComponentName = "TMP_Text", sLanguageId = "Login_Quit"},
  btnSignout = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Signout"
  },
  txtSignout = {
    sComponentName = "TMP_Text",
    sLanguageId = "Login_Signout"
  },
  btnNoticeBoard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoticeBoard"
  },
  txtNoticeBoard = {
    sComponentName = "TMP_Text",
    sLanguageId = "Login_NoticeBoard"
  },
  btnService = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Service"
  },
  txtService = {
    sComponentName = "TMP_Text",
    sLanguageId = "Login_Service"
  },
  btnFixClient = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FixClient"
  },
  txtFixClient = {
    sComponentName = "TMP_Text",
    sLanguageId = "Login_FixClient"
  },
  btnSetting = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Setting"
  },
  txtSetting = {
    sComponentName = "TMP_Text",
    sLanguageId = "Login_Setting"
  },
  btn_RequestPlayerData = {
    sComponentName = "Button",
    callback = "OnBtnClick_RequestPlayerData"
  },
  btn_RequestPlayerData_Dev = {
    sComponentName = "Button",
    callback = "OnBtnClick_RequestPlayerData"
  }
}
LoginCtrl._mapEventConfig = {
  OnSdkLogout = "OnSdkLogout",
  OnSdkInit = "OnSdkInit",
  OnSdkLogin = "OnSdkLogin",
  LoginFailed = "OnEvent_LoginFailed",
  AnnPanelClose = "OpenRequestPlayerData",
  DeviceTrackingID = "OnEvent_DeviceTrackingID"
}
local nMaxUtf8len = 7
local ServerStateEnum = {Down = 0, Running = 1}
local ServerStateColor = {
  [ServerStateEnum.Down] = {
    r = 0.7843137254901961,
    g = 0.8431372549019608,
    b = 0.8980392156862745,
    a = 1
  },
  [ServerStateEnum.Running] = {
    r = 0.7529411764705882,
    g = 0.9098039215686274,
    b = 0.30196078431372547,
    a = 1
  }
}
local ServerTextColor = {
  Choose = {
    r = 0.9803921568627451,
    g = 0.9803921568627451,
    b = 0.9803921568627451,
    a = 1
  },
  NotChoose = {
    r = 0.2901960784313726,
    g = 0.3843137254901961,
    b = 0.47843137254901963,
    a = 1
  }
}

function LoginCtrl:Awake()
  self.version = nil
  self.serverState = nil
  self.serverInfoList = nil
  self.maintenanceInfo = nil
  self.maintenanceNotice = nil
  self.selectServerIndex = nil
  self.DeviceTrackingId = NovaAPI.GetDeviceId()
  NovaAPI.SetImageSpriteAsset(self._mapNode.LoginBG, self:GetPngSprite("Image/UIBG/bg_login"))
end

function LoginCtrl:OnEnable()
  self.bNewPlayer = false
  self.bProcessingLogin = false
  self.bClickLogin = false
  self.bOnLogin = false
  self.bAutoOpenedAnn = false
  self.bRequestingPlayerData = false
  self:InitSkip()
  self:InitAccount()
  self:InitServerList()
  self:InitAgeTips()
  self:HideNode(self._mapNode.ClickLoginRoot)
  self:HideNode(self._mapNode.SDKLoginRoot)
  self:HideNode(self._mapNode.LoginTipsRoot)
  self:HideNode(self._mapNode.SelectServerRoot)
  self:HideNode(self._mapNode.ServerListRoot)
  self:HideNode(self._mapNode.ChangeAccountRoot)
  self._mapNode.btnSignout.gameObject:SetActive(false)
  self._mapNode.btnNoticeBoard.gameObject:SetActive(false)
  self._mapNode.btnService.gameObject:SetActive(false)
  self._mapNode.btn_RequestPlayerData.gameObject:SetActive(false)
  self._mapNode.btn_RequestPlayerData_Dev.gameObject:SetActive(false)
  HttpNetHandler.UnsetPingPong()
  local goLaunchUI = GameObject.Find("==== Builtin UI ====/LaunchUI")
  NovaAPI.CloseLaunchInfo(goLaunchUI)
  self:ShowNode(self._mapNode.LoginTipsRoot)
  if SDKManager:IsSDKInit() then
    SDKManager:InitSdk("")
    SDKManager:FetchDeviceTrackingID()
    
    local function waitCallback()
      self:ShowNode(self._mapNode.ClickLoginRoot)
    end
    
    self:HideNode(self._mapNode.ClickLoginRoot)
    self.showLoginNodeTimer = self:AddTimer(1, 1, waitCallback, true, true, true)
  else
    self:ShowNode(self._mapNode.ClickLoginRoot)
  end
end

function LoginCtrl:OnDisable()
end

function LoginCtrl:InitSkip()
  self._mapNode.SkipRoot:SetActive(false)
  EventManager.Hit("ManualJump", self._mapNode.SkipRoot, self._mapNode.togSkip[1], self._mapNode.togSkip[2])
end

function LoginCtrl:InitAccount()
  local lastAccount = LocalData.GetLocalData("LoginUIData", "LastUserName")
  if type(lastAccount) == "string" then
    NovaAPI.SetInputFieldText(self._mapNode.AccountInputField, lastAccount)
  else
    NovaAPI.SetInputFieldText(self._mapNode.AccountInputField, "")
  end
end

function LoginCtrl:InitServerList()
  local CSServerListInfo = NovaAPI.ServerListInfo
  self.version = CSServerListInfo.V
  self.serverState = CSServerListInfo.M
  self.maintenanceInfo = CSServerListInfo.S
  self.maintenanceNotice = CSServerListInfo.N
  self.serverInfoList = {}
  local CSServerList = CSServerListInfo.A
  local reportUrl = self:TransStrToUrl(CSServerListInfo.R)
  NovaAPI.SetReportUrl(reportUrl)
  for index = 0, CSServerList.Length - 1 do
    local CSServerInfo = CSServerList[index]
    local serverInfo = {}
    serverInfo.name = CSServerInfo.N
    serverInfo.address = CSServerInfo.A
    serverInfo.address = self:TransStrToUrl(serverInfo.address)
    serverInfo.state = CSServerInfo.S
    serverInfo.zone = CSServerInfo.Z
    table.insert(self.serverInfoList, serverInfo)
  end
  EventManager.Hit("LoginServerList", self)
  if #self.serverInfoList > 0 then
    self.selectServerIndex = tonumber(LocalData.GetLocalData("LoginUIData", "LastSrvIndex")) or 1
    local serverInfo = self.serverInfoList[self.selectServerIndex]
    if not serverInfo then
      serverInfo = self.serverInfoList[1]
      self.selectServerIndex = 1
    end
    NovaAPI.SetImageColor(self._mapNode.ServerState, ServerStateColor[serverInfo.state])
    NovaAPI.SetTMPText(self._mapNode.ServerName, serverInfo.name)
    self._mapNode.ServerScrollView:Init(#self.serverInfoList, self, self.OnRefreshServerCell, self.OnClickServerCell)
    self._mapNode.ServerScrollView.gameObject:SetActive(true)
  else
    self._mapNode.ServerScrollView.gameObject:SetActive(false)
  end
end

function LoginCtrl:OnRefreshServerCell(cellObj)
  local State = cellObj.transform:Find("ChooseBtn/AnimRoot/State"):GetComponent("Image")
  local ChooseBg = cellObj.transform:Find("ChooseBtn/AnimRoot/ChooseBg")
  local Name = cellObj.transform:Find("ChooseBtn/AnimRoot/Name"):GetComponent("TMP_Text")
  local index = tonumber(cellObj.name) + 1
  local serverInfo = self.serverInfoList[index]
  NovaAPI.SetImageColor(State, ServerStateColor[serverInfo.state])
  NovaAPI.SetTMPText(Name, serverInfo.name)
  NovaAPI.SetTMPColor(Name, index == self.selectServerIndex and ServerTextColor.Choose or ServerTextColor.NotChoose)
  ChooseBg.gameObject:SetActive(index == self.selectServerIndex)
end

function LoginCtrl:OnClickServerCell(cellObj)
  local index = tonumber(cellObj.name) + 1
  local serverInfo = self.serverInfoList[index]
  NovaAPI.SetImageColor(self._mapNode.ServerState, ServerStateColor[serverInfo.state])
  NovaAPI.SetTMPText(self._mapNode.ServerName, serverInfo.name)
  self.selectServerIndex = index
  self._mapNode.ServerScrollView:ForceRefresh()
  self:HideNode(self._mapNode.ServerListRoot)
end

function LoginCtrl:ShowNode(canvasGroup)
  NovaAPI.SetCanvasGroupAlpha(canvasGroup, 1)
  NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, true)
end

function LoginCtrl:HideNode(canvasGroup)
  NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, false)
end

function LoginCtrl:OnNextBtnClick()
  self:HideNode(self._mapNode.SelectServerRoot)
  self:ShowNode(self._mapNode.ChangeAccountRoot)
end

function LoginCtrl:OnPrevBtnClick()
  self:HideNode(self._mapNode.ChangeAccountRoot)
  self:ShowNode(self._mapNode.SelectServerRoot)
end

function LoginCtrl:OnSwitchServerBtnClick()
  self:ShowNode(self._mapNode.ServerListRoot)
end

function LoginCtrl:OnCloseBtnClick()
  self:HideNode(self._mapNode.ServerListRoot)
end

function LoginCtrl:OnEnterGameBtnClick()
  self.bOnLogin = true
  self:RequestIke()
end

function LoginCtrl:OnBtnClick_ClickLogin()
  CS.WwiseAudioManager.Instance:PlaySound("ui_common_feedback_success")
  if SDKManager:IsSDKInit() then
    SDKManager:InitSdk("")
    if self.nUid ~= nil then
      self.bClickLogin = true
    end
  else
    self:HideNode(self._mapNode.ClickLoginRoot)
    self:HideNode(self._mapNode.LoginTipsRoot)
    self:ShowNode(self._mapNode.SelectServerRoot)
  end
end

function LoginCtrl:OnBtnClick_ClickLoginSdk()
  self.bOnLogin = true
  self:RequestIke()
  self:HideNode(self._mapNode.ClickLoginRoot)
  self:HideNode(self._mapNode.SDKLoginRoot)
end

function LoginCtrl:OnBtnClick_AgeTip()
  SDKManager:ShowCADPA()
end

function LoginCtrl:OnBtnClick_Quit()
  if self.bOnLogin then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Login_QuitTips"),
    callbackConfirm = function()
      local UIGameSystemSetup = CS.UIGameSystemSetup
      UIGameSystemSetup.Instance:KillApplication()
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function LoginCtrl:RequestIke()
  if self.bProcessingLogin then
    self.bOnLogin = false
    return
  end
  self.bProcessingLogin = true
  NovaAPI.ResetIke()
  if #self.serverInfoList <= 0 then
    printError("没有区服数据")
    self.bOnLogin = false
    return
  end
  if not self.selectServerIndex then
    printError("没有选择区服")
    self.bOnLogin = false
    return
  end
  local msgSend = {}
  local url = ""
  if SDKManager:IsSDKInit() then
    url = self.serverInfoList[self.selectServerIndex].address
  else
    local serverAddress = NovaAPI.GetInputFieldText(self._mapNode.AddressInputField)
    url = self:TransStrToUrl(serverAddress)
    url = url ~= "" and url or self.serverInfoList[self.selectServerIndex].address
  end
  msgSend.PubKey = NovaAPI.GetPubKey()
  msgSend.ProtoVersion = 1
  msgSend.ClinetTs = CS.ClientManager.Instance.clientTimeStamp
  
  local function func_Callback()
    if SDKManager:IsSDKInit() then
      self:RequestLoginSDK()
    else
      self:RequestLogin()
    end
  end
  
  print("LoginURL=" .. url)
  HttpNetHandler.SendMsg(NetMsgId.Id.ike_req, msgSend, url, func_Callback)
end

function LoginCtrl:RequestLogin()
  if #self.serverInfoList <= 0 then
    printError("没有区服数据")
    self.bOnLogin = false
    return
  end
  if not self.selectServerIndex then
    printError("没有选择区服")
    self.bOnLogin = false
    return
  end
  local account = NovaAPI.GetInputFieldText(self._mapNode.AccountInputField)
  local password = NovaAPI.GetInputFieldText(self._mapNode.PasswordInputField)
  local serverAddress = NovaAPI.GetInputFieldText(self._mapNode.AddressInputField)
  local url = self:TransStrToUrl(serverAddress)
  url = url == "" and self.serverInfoList[self.selectServerIndex].address or url
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  if NovaAPI.IsDirtyString(account) then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Login_DirtyWords")
    })
    return
  end
  local msgSend = {}
  local Account = {}
  Account.Name = account
  Account.Pass = password
  if Account.Pass == "" then
    Account.Pass = "123456"
  end
  local curPlatform = CS.ClientManager.Instance.Platform
  if curPlatform == "ios" or curPlatform == "mac" then
    msgSend.Platform = 1
  elseif curPlatform == "android" then
    msgSend.Platform = 2
  elseif curPlatform == "windows" then
    msgSend.Platform = 3
  end
  msgSend.Account = Account
  msgSend.Language = Settings.sCurrentTxtLanguage
  msgSend.Channel = NovaAPI.GetServerLoginName()
  msgSend.Device = NovaAPI.GetDeviceId()
  msgSend.Version = NovaAPI.GetClientVersion()
  print("Device:" .. (msgSend.Device == nil and "" or msgSend.Device))
  
  local function func_Callback()
    LocalData.SetLocalData("LoginUIData", "LastSrvIndex", tostring(self.selectServerIndex))
    LocalData.SetLocalData("LoginUIData", "LastUserName", account)
    LocalData.SetLocalData("LoginUIData", "LastUserName_All", account .. msgSend.Channel .. self.selectServerIndex)
    self:AutoOpenAnnPanel()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_login_req, msgSend, url, func_Callback)
end

function LoginCtrl:RequestLoginSDK()
  if #self.serverInfoList <= 0 then
    printError("没有区服数据")
    self.bOnLogin = false
    return
  end
  if not self.selectServerIndex then
    printError("没有选择区服")
    self.bOnLogin = false
    return
  end
  local msgSend = {}
  local curPlatform = CS.ClientManager.Instance.Platform
  if curPlatform == "ios" or curPlatform == "mac" then
    msgSend.Platform = 1
  elseif curPlatform == "android" then
    msgSend.Platform = 2
  elseif curPlatform == "windows" then
    msgSend.Platform = 3
  end
  if self.nLoginProtoType == 1 then
    msgSend.Official = {
      Uid = self.nUid,
      Token = self.sToken
    }
  elseif self.nLoginProtoType == 2 then
    msgSend.OfficialOverseas = {
      Uid = self.nUid,
      Token = self.sToken
    }
  else
    msgSend.Official = {
      Uid = self.nUid,
      Token = self.sToken
    }
  end
  msgSend.Language = Settings.sCurrentTxtLanguage
  msgSend.Channel = NovaAPI.GetServerLoginName()
  msgSend.Device = self.DeviceTrackingId
  msgSend.Version = NovaAPI.GetClientVersion()
  print("Device:" .. (msgSend.Device == nil and "" or msgSend.Device))
  
  local function func_Callback()
    LocalData.SetLocalData("LoginUIData", "LastSrvIndex", tostring(self.selectServerIndex))
    LocalData.SetLocalData("LoginUIData", "LastUserName", self.nUid)
    LocalData.SetLocalData("LoginUIData", "LastUserName_All", self.nUid .. msgSend.Channel .. self.selectServerIndex)
    self:AutoOpenAnnPanel()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_login_req, msgSend, nil, func_Callback)
end

function LoginCtrl:RequestPlayerData()
  if self.bRequestingPlayerData then
    return
  end
  self.bRequestingPlayerData = true
  self.bOnLogin = true
  self._mapNode.btn_RequestPlayerData.gameObject:SetActive(false)
  self._mapNode.btn_RequestPlayerData_Dev.gameObject:SetActive(false)
  local msgSend = {}
  
  local function func_Callback(sendMsg)
    self:OnServerCallBack(sendMsg)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_data_req, msgSend, nil, func_Callback)
end

function LoginCtrl:RequestCreatePlayer(nickName)
  local msgPlayerReg = {}
  msgPlayerReg.Nickname = nickName
  msgPlayerReg.Gender = false
  
  local function func_Callback(sendMsg)
    self:OnServerCallBack(sendMsg)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_reg_req, msgPlayerReg, nil, func_Callback)
end

function LoginCtrl:OnServerCallBack(sendMsg)
  self.bOnLogin = false
  self.bRequestingPlayerData = false
  local goLaunchUI = GameObject.Find("==== Builtin UI ====/LaunchUI")
  if sendMsg.receiveMsgId == NetMsgId.Id.player_data_succeed_ack then
    HttpNetHandler.SetPingPong()
    self.bMainMenuModule = PlayerData.Guide:GetGuideNewbie(1) ~= 0
    EventManager.Hit("LoginNextModule", self)
    if self.bMainMenuModule then
      local function func_EnterMainMenuModule()
        GameObject.Destroy(goLaunchUI)
        
        NovaAPI.EnterModule("MainMenuModuleScene", true)
      end
      
      PlayerData.Phone:PreloadPhoneAvgDataBeforeMain(func_EnterMainMenuModule)
    else
      GameObject.Destroy(goLaunchUI)
      PlayerData.StarTower:EnterTowerPrologue()
    end
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "personality_id",
      PlayerData.Avg:GetPersonalityId()
    })
    NovaAPI.UserEventUpload("role_login", tab)
    NovaAPI.SetBuglyPlayerUid(tostring(PlayerData.Base._nPlayerId))
    NovaAPI.TryUploadFile()
  elseif sendMsg.receiveMsgId == NetMsgId.Id.player_new_notify then
    GameObject.Destroy(goLaunchUI)
    CS.WwiseAudioManager.Instance:SetState("system", "None")
    self.gameObject:SetActive(false)
    EventManager.Hit(EventId.OpenPanel, PanelId.CreatePlayer)
  end
end

function LoginCtrl:TransStrToUrl(str)
  local url = ""
  if str == nil or type(str) ~= "string" or str == "" then
    return url
  end
  url = str
  if not string.find(str, "http://", 1) and not string.find(str, "https://", 1) then
    url = "http://" .. str
  end
  return url
end

function LoginCtrl:OnTogChange_Skip(tog, nIndex, bIsOn)
  EventManager.Hit("ChangeJump", nIndex, bIsOn)
end

function LoginCtrl:OnSdkLogin(uid, token, code, msg, nType)
  if code ~= 0 then
    self.bClickLogin = false
    self:ShowNode(self._mapNode.ClickLoginRoot)
    return
  end
  if self.showLoginNodeTimer ~= nil then
    self.showLoginNodeTimer:Cancel()
  end
  if nType == nil then
    nType = 1
  end
  self.nLoginProtoType = nType
  self.nUid = uid
  self.sToken = token
  if self.bClickLogin then
    self:RequestIke()
    self:HideNode(self._mapNode.ClickLoginRoot)
    self:HideNode(self._mapNode.SDKLoginRoot)
  else
    self:HideNode(self._mapNode.ClickLoginRoot)
    self:ShowNode(self._mapNode.SDKLoginRoot)
  end
  self._mapNode.btnSignout.gameObject:SetActive(true)
  self._mapNode.btnNoticeBoard.gameObject:SetActive(true)
  self._mapNode.btnService.gameObject:SetActive(true)
end

function LoginCtrl:OnSdkInit(code, msg)
  print("OnSdkInit lua")
  if code ~= 0 then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = msg
    })
    self:ShowNode(self._mapNode.ClickLoginRoot)
    return
  end
  if SDKManager:IsSDKInit() then
    SDKManager:Login()
  end
end

function LoginCtrl:OnEvent_LoginFailed()
  if NovaAPI.IsServerMaintained() then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = NovaAPI.GetServerMaintainedInfo()
    })
  end
  self.bProcessingLogin = false
  self.bOnLogin = false
  self.bClickLogin = false
  self.bRequestingPlayerData = false
  self:ShowNode(self._mapNode.ClickLoginRoot)
  self:HideNode(self._mapNode.SelectServerRoot)
  self:HideNode(self._mapNode.ChangeAccountRoot)
end

function LoginCtrl:OnEvent_DeviceTrackingID(sId)
  self.DeviceTrackingId = sId
end

function LoginCtrl:InitAgeTips()
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if clientPublishRegion == CS.ClientPublishRegion.CN then
    self:SetAtlasSprite(self._mapNode.imgAgeTip, "10_ico", AgeTipsCN)
    self._mapNode.btnAgeTip.enabled = true
  elseif clientPublishRegion == CS.ClientPublishRegion.TW then
    self:SetAtlasSprite(self._mapNode.imgAgeTip, "10_ico", AgeTipsTW)
    self._mapNode.btnAgeTip.enabled = false
  elseif clientPublishRegion == CS.ClientPublishRegion.KR then
    self:SetAtlasSprite(self._mapNode.imgAgeTip, "10_ico", AgeTipsKR)
    self._mapNode.btnAgeTip.enabled = false
  else
    self._mapNode.imgAgeTip.gameObject:SetActive(false)
    self._mapNode.btnAgeTip.enabled = false
  end
  NovaAPI.SetImageNativeSize(self._mapNode.imgAgeTip)
end

function LoginCtrl:OnSdkLogout(code, msg)
  if self.showLoginNodeTimer ~= nil then
    self.showLoginNodeTimer:Cancel()
  end
end

function LoginCtrl:OnBtnClick_Signout(...)
  if self.bOnLogin then
    return
  end
  SDKManager:SwitchAccount()
end

function LoginCtrl:OnBtnClick_NoticeBoard()
  if self.bOnLogin then
    return
  end
  
  local function callback(...)
    if PlayerData.AnnouncementData:HasAnnouncement() then
      EventManager.Hit("AnnInit")
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end
  
  PlayerData.AnnouncementData:SendAllDataQuest(callback)
end

function LoginCtrl:OnBtnClick_Service()
  if self.bOnLogin then
    return
  end
  if SDKManager:IsSDKInit() then
    local channelName = CS.ClientConfig.ClientPublishChannelName
    if channelName == "Bilibili" then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Service_Bilibili_Tips")
      })
    else
      SDKManager.SDK:ShowCS(tostring(PlayerData.Base._nPlayerId), PlayerData.Base._sPlayerNickName)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
  end
end

function LoginCtrl:OnBtnClick_FixClient()
  if self.bOnLogin then
    return
  end
  
  local function callback()
    NovaAPI.OpenBooterRepairResourceMode()
    NovaAPI.ExitGame()
  end
  
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Login_FixClientConfirm"),
    callbackConfirm = callback
  })
end

function LoginCtrl:OnBtnClick_Setting()
  if self.bOnLogin then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.LoginSetting)
end

function LoginCtrl:AutoOpenAnnPanel()
  self.bRequestingPlayerData = false
  
  local function callback()
    if PlayerData.AnnouncementData:HasAnnouncement() then
      if PlayerData.AnnouncementData:GetIsNeedAutoOpen() then
        self.bOnLogin = false
        self.bAutoOpenedAnn = true
        EventManager.Hit("AnnInit")
      else
        self:RequestPlayerData()
      end
    else
      self:RequestPlayerData()
    end
  end
  
  PlayerData.AnnouncementData:SendAllDataQuest(callback)
end

function LoginCtrl:OpenRequestPlayerData()
  if not self.bAutoOpenedAnn then
    return
  end
  if SDKManager:IsSDKInit() then
    self._mapNode.btn_RequestPlayerData.gameObject:SetActive(true)
  else
    self._mapNode.btn_RequestPlayerData_Dev.gameObject:SetActive(true)
  end
end

function LoginCtrl:OnBtnClick_RequestPlayerData()
  self:RequestPlayerData()
end

return LoginCtrl
