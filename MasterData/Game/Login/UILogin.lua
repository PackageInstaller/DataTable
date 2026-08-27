local UILogin = class("UILogin", UIBaseWindow)
local base = UIBaseWindow
local CS_Resources = CS.UnityEngine.Resources
local CS_NetworkManager = CS.NetworkManager.Instance
local CS_PlayerPrefs = CS.UnityEngine.PlayerPrefs
local CS_PlayerPrefsExtension = CS.PlayerPrefsExtension
local CS_HotUpdateController = CS.HotUpdateController
local CS_ClientConsts = CS.ClientConsts
local CS_LanguageGlobal = CS.LanguageGlobal
local CS_MicaSDKManager_Ins = CS.MicaSDKManager.Instance
local isUseSDK = CS_MicaSDKManager_Ins:IsUseSdk()
local PlayerPrefsConsts = require("Game.Login.PlayerPrefsEnum")
local UINLoginLoading = require("Game.Login.UINLoginLoading")

function UILogin:OnInit()
  self.ui.tex_Version:SetIndex(0, CS_ClientConsts.GameVersionStr)
  self.__OnSdkLogoutFunc = BindCallback(self, self.__OnSdkLogout)
  self.__OnSdkLoginFunc = BindCallback(self, self.__OnSdkLogin)
  self.ui.obj_createUser:SetActive(false)
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.base)
  math.randomseed(os.time())
  local roleId = ConfigData.hero_data.totalVoiceHeroIdList[math.random(#ConfigData.hero_data.totalVoiceHeroIdList)]
  local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.title, nil, roleId)
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(roleId, voiceId)
  self.serverConfigAsset = CS_Resources.Load("ServerConfigs")
  local listString = CS.System.Collections.Generic.List(CS.System.String)
  self.serverList = listString()
  for i = 0, self.serverConfigAsset.ServerConfigs.Length - 1 do
    local config = self.serverConfigAsset.ServerConfigs[i]
    self.serverList:Add(config.ServerName .. " - " .. config.IP .. ":" .. config.Port)
  end
  self.ui.serverDropdown:ClearOptions()
  self.ui.serverDropdown:AddOptions(self.serverList)
  self.ui.searchField.onValueChanged:AddListener(BindCallback(self, self._sortServerData))
  UIUtil.AddButtonListener(self.ui.btn_SwitchAccount, self, self.AccountSwitch)
  UIUtil.AddButtonListener(self.ui.btn_CustomerService, self, self._OnClickCustomerService)
  UIUtil.AddButtonListener(self.ui.btnLogin, self, self.OnClickLogin)
  UIUtil.AddButtonListener(self.ui.btnSkipLogin, self, self.OnClickSkipLogin)
  UIUtil.AddButtonListener(self.ui.btn_CADPA, self, self.OnClickCADPAWarring)
  UIUtil.AddButtonListener(self.ui.btn_ResVerify, self, self._OnClickResVerify)
  UIUtil.AddValueChangedListener(self.ui.tog_Mode, self, self.OnServerModeChange)
  self.ui.tog_Mode.isOn = CS_PlayerPrefsExtension.GetBool(PlayerPrefsConsts.CustomServerMode)
  self.ui.iptServer.text = CS_PlayerPrefs.GetString(PlayerPrefsConsts.CustomServerStr)
  self.ui.serverDropdown.value = CS_PlayerPrefs.GetInt(PlayerPrefsConsts.ServerId)
  self.ui.iptAcount.text = CS_PlayerPrefs.GetString(PlayerPrefsConsts.UserName)
  self.ui.iptPassword.text = CS_PlayerPrefs.GetString(PlayerPrefsConsts.UserPassword)
  self.LoginNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Login)
  self.__onConnectComplete = BindCallback(self, self.OnConnectComplete)
  CS_NetworkManager:onConnectComplete("+", self.__onConnectComplete)
  self.__onRecvUserData = BindCallback(self, self.OnRecvUserData)
  MsgCenter:AddListener(eMsgEventId.SyncUserData, self.__onRecvUserData)
  if isEditorMode and CS.GMController.Instance.battleShortcut then
    self:OnClickLogin()
  end
  self.serverId = CS.FilePathHelper.Instance:ReadServerId()
  if self.serverId ~= nil and self.serverId ~= -1 then
    self.ui.selectServer:SetActive(false)
  else
    self.ui.selectServer:SetActive(true)
  end
  if isUseSDK then
    self.ui.loginInfo:SetActive(false)
  end
  self.loadingNode = UINLoginLoading.New()
  self.loadingNode:Init(self.ui.obj_enterTheGame)
  self:SwitchSpringBG(true)
  local showCustomerService = Consts.GameChannelType.IsPnSdk() and not CS_ClientConsts.IsAudit
  self.ui.btn_CustomerService.gameObject:SetActive(showCustomerService)
  self:_InitBg()
end

function UILogin:_sortServerData(newValue)
  self.sortServerListIndex = {}
  local listString = CS.System.Collections.Generic.List(CS.System.String)
  self.sortList = listString()
  self.ui.serverDropdown:ClearOptions()
  for i = 0, self.serverList.Count - 1 do
    local pos = string.find(string.lower(self.serverList[i]), string.lower(newValue))
    if pos ~= nil then
      table.insert(self.sortServerListIndex, i)
      self.sortList:Add(self.serverList[i])
    end
  end
  self.ui.serverDropdown:AddOptions(self.sortList)
  self.ui.serverDropdown.value = 0
end

function UILogin:_InitBg()
  local languageInt = CS_LanguageGlobal.GetLanguageInt()
  local texture = self.ui.loginBgList[languageInt + 1]
  if IsNull(texture) then
    error(string.format("Login background texture %s is null", CS_LanguageGlobal.GetLanguageStr()))
  end
  self.ui.rawBackground.texture = texture
end

function UILogin:OnServerModeChange(value)
  self.ui.obj_server:SetActive(not value)
  self.ui.obj_customServer:SetActive(value)
end

function UILogin:AccountSwitch()
  if not isUseSDK then
    return
  end
  CS_MicaSDKManager_Ins:AccountSwitch(self.__OnSdkLoginFunc, self.__OnSdkLogoutFunc)
end

function UILogin:_OnClickCustomerService()
  CS_MicaSDKManager_Ins:EnterCustomService()
end

function UILogin:OnClickLogin()
  if self.sortServerListIndex ~= nil then
    CS_PlayerPrefs.SetInt(PlayerPrefsConsts.ServerId, self.sortServerListIndex[self.ui.serverDropdown.value + 1])
  else
    CS_PlayerPrefs.SetInt(PlayerPrefsConsts.ServerId, self.ui.serverDropdown.value)
  end
  local userName = self.ui.iptAcount.text
  CS_PlayerPrefs.SetString(PlayerPrefsConsts.UserName, userName)
  CS_PlayerPrefs.SetString(PlayerPrefsConsts.UserPassword, self.ui.iptPassword.text)
  CS_PlayerPrefsExtension.SetBool(PlayerPrefsConsts.CustomServerMode, self.ui.tog_Mode.isOn)
  CS_PlayerPrefs.SetString(PlayerPrefsConsts.CustomServerStr, self.ui.iptServer.text)
  if not isUseSDK then
    if string.IsNullOrEmpty(userName) then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.login_NoticeUserName))
      return
    end
    self:StartConnect()
  else
    CS_MicaSDKManager_Ins:StartLogin(self.__OnSdkLoginFunc, self.__OnSdkLogoutFunc)
  end
end

function UILogin:__OnSdkLogin()
  CS_HotUpdateController.TryCheckNewResVersion(function(hasNewVersion)
    self:__OnCheckVersionComplete(hasNewVersion)
  end)
end

function UILogin:__OnSdkLogout()
  NetworkManager.luaNetworkAgent:LogoutToLogin(false)
end

function UILogin:__OnCheckVersionComplete(hasNewVersion)
  if hasNewVersion then
    CS.MessageCommon.ShowMessageBoxConfirm(ConfigData:GetTipContent(TipContent.HasNewVersionToUpdate), function()
      CS.UnityEngine.Application.Quit()
    end)
  else
    self:StartConnectFromSDK()
  end
end

function UILogin:_TryCustomConnect()
  if CS_ClientConsts.CustomVersionInfo ~= nil and not string.IsNullOrEmpty(CS_ClientConsts.CustomVersionInfo.CustomGateAddress) then
    local gateInfo = CS_ClientConsts.CustomVersionInfo.CustomGateAddress
    if not string.IsNullOrEmpty(gateInfo) then
      local tab = string.split(gateInfo, ":")
      if #tab == 2 then
        local ip = tab[1]
        local port = tonumber(tab[2])
        self:_StartConectIpPort(ip, port)
        return true
      end
    end
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.login_IllegalServer))
  end
  return false
end

function UILogin:StartConnectFromSDK()
  if self:_TryCustomConnect() then
    return
  end
  CS.WaitNetworkResponse.Instance:StartWaitOrigin(eCustomWaitType.WaitGateInfo, eCustomWaitType.WaitGateInfo)
  CS_MicaSDKManager_Ins:GetGateInfo(function(success)
    CS.WaitNetworkResponse.Instance:RemoveWait(eCustomWaitType.WaitGateInfo)
    if not success then
      CS.MessageCommon.ShowMessageBoxConfirm(ConfigData:GetTipContent(TipContent.not_get_gateinfo), function()
        self:StartConnectFromSDK()
      end)
    else
      local ok, gateInfo = CS_MicaSDKManager_Ins:TryRandomGateInfo()
      if ok then
        if isUseSDK then
          if not string.IsNullOrEmpty(gateInfo) then
            local tab = string.split(gateInfo, ":")
            if #tab == 2 then
              local ip = tab[1]
              local port = tonumber(tab[2])
              self:_StartConectIpPort(ip, port)
              return
            end
          end
          warn("MicaSDK gateInfo error, gateInfo:" .. gateInfo)
          CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.login_IllegalServer))
          return
        end
      else
        self:StartConnectFromSDK()
      end
    end
  end)
end

function UILogin:StartConnect(gateInfo)
  if self:_TryCustomConnect() then
    return
  end
  if not self.ui.tog_Mode.isOn then
    local serverId
    if self.serverId ~= nil and self.serverId ~= -1 then
      serverId = self.serverId
    elseif self.sortServerListIndex ~= nil then
      serverId = self.sortServerListIndex[self.ui.serverDropdown.value + 1]
    else
      serverId = self.ui.serverDropdown.value
    end
    local ip, port = self.serverConfigAsset:GetIpAndPort(serverId)
    self:_StartConectIpPort(ip, port)
  else
    local customServer = self.ui.iptServer.text
    if not string.IsNullOrEmpty(customServer) then
      local tab = string.split(customServer, ":")
      if #tab == 2 then
        local ip = tab[1]
        local port = tonumber(tab[2])
        self:_StartConectIpPort(ip, port)
        return
      end
    end
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.login_IllegalServer))
  end
end

function UILogin:OnConnectComplete()
  if CS_ClientConsts.CustomVersionInfo ~= nil and not string.IsNullOrEmpty(CS_ClientConsts.CustomVersionInfo.CustomUserName) and not string.IsNullOrEmpty(CS_ClientConsts.CustomVersionInfo.CustomToken) then
    self.LoginNetworkCtrl:CS_Login(CS_ClientConsts.CustomVersionInfo.CustomUserName, CS_ClientConsts.CustomVersionInfo.CustomToken, CS_ClientConsts.GameVersionStr)
    return
  end
  if isUseSDK then
    self.LoginNetworkCtrl:CS_Login(CS_MicaSDKManager_Ins.openId, CS_MicaSDKManager_Ins.accessToken, CS_ClientConsts.GameVersionStr)
    self:GetGameResUrls()
  else
    self.LoginNetworkCtrl:CS_Login(self.ui.iptAcount.text, nil, CS_ClientConsts.GameVersionStr)
  end
end

function UILogin:GetGameResUrls()
  CS_MicaSDKManager_Ins:GetGameResUrls(function()
    require("Game.Home.Banner.HomeBannerManager"):OnResUrlLoadOver()
  end)
end

function UILogin:OnRecvUserData()
  ControllerManager:GetController(ControllerTypeId.Login, true):OnLoginUserDataComplete(true)
end

function UILogin:GengrateRandomName()
  local famulyName = require("LuaConfigs.player_familyName")
  local firstName = require("LuaConfigs.player_firstName")
  math.randomseed(os.time())
  local num1 = math.random(#famulyName)
  local num2 = math.random(#firstName)
  local arg1 = LanguageUtil.GetLocaleText(famulyName[num1].family_name)
  local arg2 = LanguageUtil.GetLocaleText(firstName[num2].first_name)
  return arg1 .. arg2
end

function UILogin:HideCreateUser()
  self.ui.obj_createUser:SetActive(false)
end

function UILogin:OnclickRandomNameBtn()
  self.ui.inputField_createUser.text = self:GengrateRandomName()
end

function UILogin:OnClickSkipLogin()
  self:OnLoginComplete()
end

function UILogin:ShowLoading()
  self.ui.obj_login:SetActive(false)
  self.loadingNode:Show()
  self.loadingNode:InitLoginLoading()
  self:SwitchSpringBG(false)
end

function UILogin:OnClickCADPAWarring()
  UIManager:ShowWindowAsync(UIWindowTypeID.CADPAWarring)
end

function UILogin:SwitchSpringBG(active)
  self.ui.obj_rawBackground:SetActive(active)
  self.ui.obj_shadow:SetActive(not active)
  self.ui.obj_CubeAnima:SetActive(not active)
  self.ui.img_orignBg.enabled = not active
end

function UILogin:_StartConectIpPort(ip, port)
  if isGameDev then
    print("[Dev]server:", ip, port)
  end
  CS.NetworkEntry.Instance:StartConnect(ip, port)
end

function UILogin:_OnClickResVerify()
  if not isUseSDK then
    return
  end
  CS_HotUpdateController.TryCheckNewResVersion(function(hasNewVersion)
    if hasNewVersion then
      CS.MessageCommon.ShowMessageBoxConfirm(ConfigData:GetTipContent(TipContent.HasNewVersionToUpdate), function()
        CS.UnityEngine.Application.Quit()
      end)
      return
    end
    CS.HotResVerify.ResVerify()
  end)
end

function UILogin:OnDelete()
  self.loadingNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.SyncUserData, self.__onRecvUserData)
  CS_NetworkManager:onConnectComplete("-", self.__onConnectComplete)
  CS_Resources.UnloadAsset(self.serverConfigAsset)
  base.OnDelete(self)
end

return UILogin
