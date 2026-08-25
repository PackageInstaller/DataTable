local typeof = _ENV.typeof
local InputField = typeof(CS.UnityEngine.UI.InputField)
local GameObject = CS.UnityEngine.GameObject
local UIAnimationController = CS.Z1Client.UIAnimationController
local DivPackageType = CS.ResourceManager.DivPackageType
local PkgDivType = CS.FrameWork.Z1Const.GetPackageDivType()
local LoginPVDataUtils = require("GameScript.Data.LoginPVDataUtils")
local LoginPanel, Super = NewClass("LoginPanel", UIBasePanel)
LoginPanel.uiResCls = UI_LoginResource

function LoginPanel:ctor(isFirstIn)
  Super.ctor(self)
  self.isFirstIn = isFirstIn
  self.triggerLogin = true
end

function LoginPanel:OnBind(binder)
  self.binder = binder
  ResUpdateUtil.Instance:StopAutoCheckResUpdate()
  self.binder:SetButtonInteractable(self.ui.Btn_Enter, true)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.accountInputField = self.ui.InputField_Account:GetComponent(InputField)
  binder:BindToVisible(self.ui.Btn_User, System.fn(self, self.IsShowUserCenter))
  binder:BindToVisible(self.ui.Btn_Deal, System.fn(self, self.IsShowDeal))
  binder:BindToVisible(self.ui.Btn_Service, System.fn(self, self.IsShowService))
  binder:BindButtonClick(self.ui.Btn_Enter, System.fn(self, self.OnClickBtnLogin))
  binder:BindButtonClick(self.ui.Btn_Announcement, System.fn(self, self.OnClickAnnouncement))
  binder:BindButtonClick(self.ui.Btn_Service, System.fn(self, self.OnClickService))
  binder:BindButtonClick(self.ui.Btn_Repair, System.fn(self, self.OnClickRepair))
  binder:BindButtonClick(self.ui.Btn_Deal, System.fn(self, self.OnClickDeal))
  binder:BindButtonClick(self.ui.Btn_User, System.fn(self, self.OnClickUserCenter))
  binder:BindButtonClick(self.ui.Btn_Setting, System.fn(self, self.OnClickBtnSetting))
  binder:BindComponent(UICompRedDotNewVue(self.ui.AnnoncementRedDot, RedDotDefine.DynamicRedDotID.AnnouncementEntrance))
  binder:BindButtonClick(self.ui.Btn_Server, System.fn(self, self.OnBtnServerClick))
  binder:BindToVisible(self.ui.Btn_Server, function()
    if ApplicationUtils.IsEditor() then
      return true
    end
    return ApplicationUtils.is_debug_mode() and not SdkMgr.Instance:IsSdkLogin()
  end)
  binder:BindToVisible(self.ui.InputField_Account, function()
    return not SdkMgr.Instance:IsSdkLogin()
  end)
  binder:BindToInputValueChange(self.ui.InputField_Account, function(text)
    if SdkMgr.Instance:IsSdkLogin() then
      return
    end
    if nil == text then
      return
    end
    LoginMgr.Instance.model:SetAccount(text)
  end)
  binder:BindToVisible(self.ui.Btn_quit, function()
    if SteamSdk.Instance:IsNativeSteamSdk() then
      return
    end
    if LoginMgr.Instance:ExistHistoryLogin() then
      return true
    end
    local isSdkLogin = SdkMgr.Instance:IsSdkLogin()
    return isSdkLogin and LoginMgr.Instance.model.isPlatformLogin
  end)
  binder:BindButtonClick(self.ui.Btn_quit, function()
    if ApplicationUtils.IsWindows() and not SteamSdk.Instance:IsNativeSteamSdk() then
      self.ui.Btn_quit:SetActive(false)
      LoginMgr.Instance:Logout()
      return
    end
    local isSdkLogin = SdkMgr.Instance:IsSdkLogin()
    local hasLoginPlatform = LoginMgr.Instance.model.isPlatformLogin
    if isSdkLogin and hasLoginPlatform then
      LoginMgr.Instance:Logout()
    end
  end)
  binder:BindButtonClick(self.ui.Btn_sweep, function()
  end)
  binder:BindToVisible(self.ui.Btn_sweep, function()
    return false
  end)
  binder:BindToVisible(self.ui.Btn_set, function()
    return false
  end)
  binder:BindButtonClick(self.ui.Btn_set, function()
    SdkMgr.Instance:OpenSdkAgeView()
  end)
  binder:BindToRaw(System.fn(self, self.SetAccountInputInteractable), function()
    do return SdkMgr.Instance.IsSdkLogin end
    return SdkMgr.Instance.IsSdkLogin, SdkMgr.Instance
  end)
  binder:BindToRaw(System.fn(self, self.SetAccountInputText), function()
    if not SdkMgr.Instance:IsSdkLogin() then
      local account = LoginMgr.Instance.model.account
      if nil ~= account then
        do return LT.Text end
        return LT.Text, account
      end
      do return LoginMgr.Instance.model.GetLocalCacheAccount end
      return LoginMgr.Instance.model.GetLocalCacheAccount, LoginMgr.Instance.model
    end
    do return SdkMgr.Instance.GetPid end
    return SdkMgr.Instance.GetPid, SdkMgr.Instance, LoginMgr.Instance.model
  end)
  binder:BindToText(self.accountInputField.placeholder, function()
    do return LT.Text end
    return LT.Text, "Dev_EnterAccount"
  end)
  binder:BindToText(self.ui.Text_ServerName, function()
    local serverName = LoginMgr.Instance.model:GetServerName()
    if nil == serverName then
      if ApplicationUtils.is_editor_mode() then
        serverName = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.ServerName)
        if serverName then
          return serverName
        end
      end
      do return LT.Text end
      return LT.Text, "Dev_SelectServer", cd.LocalSaveKeyCommon.ServerName
    end
    return serverName
  end)
  binder:BindEvent(EventMgr.Instance.OnStoryStart, function()
    self.ui.VideoPlayer:SetActive(false)
  end)
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, function()
    self.ui.VideoPlayer:SetActive(true)
  end)
  binder:BindToRaw(function(_, iconUrl, _)
    if not iconUrl then
      return
    end
    self:_SetAgeTipsIcon(iconUrl)
  end, function()
    return SdkMgr.Instance.model.tipIconUrl
  end)
  self.binder:BindEvent(EventMgr.Instance.LoginErrorEvent, System.fn(self, self.OnLoginErrorEvent))
  self.binder:BindEvent(EventMgr.Instance.OnStartLoginServer, System.fn(self, self.OnStartLoginServerEvent))
  LoginPVDataUtils.loginPVInfo = nil
  FrameWaiter.OnNextFrame(function()
    local music = LoginPVDataUtils.GetLoginMusic()
    AudioManager.Instance:PostSoundEvent(music)
    self:CheckSteamVersion()
  end, 1)
  self:_InitMusicBtn()
  self:PlayLoginVideo()
  self:PlayLoginLogoVideo()
  self.ui.Image_LogoEN:SetActive(false)
  self:_InitDownloadGroup()
end

function LoginPanel:_InitDownloadGroup()
  self._slider_Download = self.ui.Slider_Download:GetComponent(typeof(CS.UnityEngine.UI.Slider))
  local isUseDelegate = GroupDownloadMgr.Instance:IsUseDownloadDelegate()
  self:_SetDownloadGroupVisible(isUseDelegate)
  self.binder:SetText(self.ui.Text_DownloadTips, LT.Text("InGameDownloadingTips"))
  local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
  if ingameDownloadGroup then
    GroupDownloadMgr.Instance:CancelDownloadMaxBandWidth()
    if isUseDelegate then
      ingameDownloadGroup:SetDelegate(self)
    else
      ingameDownloadGroup:SetDelegate(nil)
    end
  end
  local groupName = GroupDownloadMgr.Instance:GetInGameDownloadGroupName()
  if DivPackageType.InGameDownLoad ~= PkgDivType or GroupDownloadMgr.Instance:IsGroupDownload(groupName) then
    self.binder:SetActive(self.ui.Btn_Download, false)
  else
    LateUpdateBeat.Instance:Add(self._UpdateDownloadSatus, self)
    self.binder:SetActive(self.ui.Btn_Download, true)
    self.binder:SetText(self.ui.Text_Download_Title, LT.Text("InGameDownloadingTitle"))
    self.binder:BindButtonClick(self.ui.Btn_Download, function()
      UIManager.Instance:Reopen(Urls.InGameDownloadPanel)
    end)
  end
end

function LoginPanel:_UpdateDownloadSatus()
  local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
  local downloadStatus = ingameDownloadGroup and ingameDownloadGroup:GetDownLoadStatus() or GroupDownStatus.Init
  if downloadStatus == GroupDownStatus.Init then
    self.binder:SetActive(self.ui.Group_DownloadProgress, false)
    return
  end
  self.binder:SetActive(self.ui.Group_DownloadProgress, true)
  if downloadStatus == GroupDownStatus.Failed then
    local tipsCfg = DT.TipsType[20189]
    self.binder:SetText(self.ui.Text_DownloadProgress, LT.Text(tipsCfg.Desc))
  end
  if downloadStatus == GroupDownStatus.Successed then
    local tipsCfg = DT.TipsType[20187]
    self.binder:SetText(self.ui.Text_DownloadProgress, LT.Text(tipsCfg.Desc))
    return
  end
  local download_size = ingameDownloadGroup:GetDownloadSize()
  local total_size = ingameDownloadGroup:GetDownloadTotalSize()
  local pb = download_size / math.max(0.001, total_size)
  local pbInt = math.ceil(pb * 100)
  local progressText = string.format("%d%%", pbInt)
  self.binder:SetText(self.ui.Text_DownloadProgress, progressText)
end

function LoginPanel:_InitMusicBtn()
  if IsNil(self.ui.Btn_Music) then
    return
  end
  self.ui.Btn_Music:SetActive(false)
  if ApplicationUtils.IsIOS() and ApplicationUtils.is_tishen_pcode() then
    self.ui.Btn_Music:SetActive(true)
    self.binder:BindButtonClick(self.ui.Btn_Music, function()
      local publish_area = SdkMgr.Instance:GetPublishArea()
      local E = require("ejoysdk_lua.ejoysdk")
      if "hk" == publish_area then
        E.open_webview("https://general-pre.qookkagames.com/prism-ml5028yt")
      else
        E.open_webview("https://general-pre.sialiagamesinc.com.tw/prism-mnsixdqm")
      end
    end)
    return
  end
end

function LoginPanel:ShowAnnouncement()
  self.binder:BindTimer(1, 1, function()
    if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor then
      AnnouncementDataUtils.CheckForcePopAnnouncement()
    end
  end)
end

function LoginPanel:CheckSteamVersion()
  if not SteamSdk.Instance:IsSteam() then
    return
  end
  local E = require("ejoysdk_lua.ejoysdk")
  local bundleVersionCode = tonumber(E.Sysinfo.app_version_code()) or 9999999
  local miniVersion = require("Share.Version.version").GetSteamMiniBundleVersion()
  if bundleVersionCode < miniVersion then
    Alert.Show(100100)
  end
end

function LoginPanel:TryDestroyGameUpdateUI()
  local go = GameObject.Find("UIRoot/SafeArea/FixedRoot/Panel_Loading")
  while nil ~= go do
    self:ShowAnnouncement()
    go.transform:SetParent(nil)
    go:SetActive(false)
    GameObject.DestroyImmediate(go)
    go = GameObject.Find("UIRoot/SafeArea/FixedRoot/Panel_Loading")
    local captureScreenImgGo = GameObject.Find("UIRoot/captureScreenImg")
    captureScreenImgGo = captureScreenImgGo or SceneMgr.Instance.captureScreenImgGo
    if captureScreenImgGo then
      GameObject.DestroyImmediate(captureScreenImgGo)
      SceneMgr.Instance.captureScreenImgGo = nil
    end
    ResGcMgr.Instance:Gc()
  end
  CS.Framework.AssetLoadUtil.UnloadAsset("GameUpdate/Res/Panel_Loading.prefab")
  if self.triggerLogin then
    self.triggerLogin = false
    FrameWaiter.OnNextFrame(function()
      LoginMgr.Instance:PreLogin()
      self.binder:BindTimer(0.2, 1, nil, function()
        GroupDownloadMgr.Instance:CheckDownloadIngameGroup()
      end)
    end, 1)
  end
end

function LoginPanel.ReShowUpdateUI()
  local Text = CS.UnityEngine.UI.Text
  local Slider = CS.UnityEngine.UI.Slider
  local LoadAgent = CS.ResourceManager.LoadAgent
  local go = GameObject.Find("UIRoot/SafeArea/FixedRoot/Panel_Loading")
  if go then
    local trans = go.transform
    local Text_Status = trans:Find("Text_Status"):GetComponent(typeof(Text))
    local Text_Tips = trans:Find("Text_Tips"):GetComponent(typeof(Text))
    local Slider_Patch = trans:Find("Slider_Patch"):GetComponent(typeof(Slider))
    local Slider_Text = trans:Find("Slider_Patch/Text_Precent"):GetComponent(typeof(Text))
    local loadAgent = LoadAgent()
    local mainAsset = loadAgent:LoadAsset("GameUpdate/Res/Panel_Loading.prefab", typeof(GameObject))
    local rootNode = GameObject.Instantiate(mainAsset).transform
    rootNode:SetParent(GameObject.Find("UIRoot/SafeArea/FixedRoot").transform, false)
    rootNode:SetAsFirstSibling()
    local new_Text_Status = rootNode:Find("Text_Status"):GetComponent(typeof(Text))
    local new_Text_Tips = rootNode:Find("Text_Tips"):GetComponent(typeof(Text))
    local new_Slider_Patch = rootNode:Find("Slider_Patch"):GetComponent(typeof(Slider))
    local new_Slider_Text = rootNode:Find("Slider_Patch/Text_Precent"):GetComponent(typeof(Text))
    rootNode.name = "Panel_Loading"
    new_Text_Status.text = Text_Status.text
    new_Text_Tips.text = Text_Tips.text
    new_Slider_Patch.value = Slider_Patch.value
    new_Slider_Text.text = Slider_Text.text
    LoginPanel.CheckTextFont(rootNode, DataCenter.gameData.CurrTextLanguage)
    local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
    local captureObjTrans = trans:Find("captureScreenImg")
    if captureObjTrans then
      local rawImgCom = captureObjTrans:GetComponent(TypeRawImage)
      if rawImgCom.texture then
        local tex = rawImgCom.texture
        rawImgCom.texture = nil
        GameObject.Destroy(tex)
      end
    end
    GameObject.DestroyImmediate(go)
  end
end

function LoginPanel.CheckTextFont(panelObj, langCode)
  if not panelObj or not langCode then
    return
  end
  local uiExport = panelObj:GetComponent(typeof(CS.FrameWork.UIExport))
  if not uiExport then
    return
  end
  local langResList = uiExport:GetLangResList()
  if not langResList then
    return
  end
  local TMP_Text = CS.TMPro.TMP_Text
  local Text = CS.UnityEngine.UI.Text
  for i = 0, langResList.Count - 1 do
    local langRes = langResList[i]
    if not (langRes and langRes.gameObject) or not langRes.langArr then
    else
      local resPathStr
      for j = 0, langRes.langArr.Count - 1 do
        if string.contains(langRes.langArr[j], langCode) then
          resPathStr = langRes.langArr[j]
          break
        end
      end
      if not resPathStr then
      elseif "Text" == langRes.compType then
        local textComp = langRes.gameObject:GetComponent(typeof(Text))
        textComp = textComp or langRes.gameObject:GetComponent(typeof(TMP_Text))
        if not textComp then
        elseif textComp.font and not string.contains(textComp.font.name, "Empty_Font") then
        else
          local resName, resPath = LangManager.GetResInfo(resPathStr, DataCenter.gameData.CurrTextLanguage)
          local fontLangRes = LangManager.Instance:GetFontLangRes(resName, langCode, resPath)
          if fontLangRes and fontLangRes.font then
            textComp.font = fontLangRes.font
          end
        end
      end
    end
  end
end

function LoginPanel:PlayLoginVideo()
  if ApplicationUtils.is_editor_mode() and CS.Z1Client.LuaBehaviour.disable_login_video then
    self:TryDestroyGameUpdateUI()
    return
  end
  self.videoPlayer = GameVideoPlayer(self.ui.VideoPlayer, self.ui.VideoPlayerBak)
  local videoName = LoginPVDataUtils.GetLoginVideo()
  
  local function onLoginStarted()
    LoginPVDataUtils.deferredTryClearPlayedVideo = videoName
    FrameWaiter.OnNextFrame(function()
      self:TryDestroyGameUpdateUI()
      self.uiAnimController:PlayState("UI_Login_Main_Group_Open")
    end, 2)
  end
  
  local function onLoginPrepareCompleted()
    self.videoPlayer:Play()
  end
  
  self.videoPlayer:SetLooping(true)
  self.videoPlayer.preparedCallback = onLoginPrepareCompleted
  self.videoPlayer.startedCallabck = onLoginStarted
  self.videoPlayer:OpenMedia(videoName)
  self.binder:BindTimer(2, 0, nil, function()
    self:TryDestroyGameUpdateUI()
  end)
end

function LoginPanel:SetLogoImage()
  local lang = DataCenter.gameData.CurrTextLanguage
  local logoRes = CommonRes.LogoEn
  if lang == cd.Lang.CN then
    logoRes = CommonRes.LogoCn
  elseif lang == cd.Lang.TW then
    logoRes = CommonRes.LogoTw
  end
  self.binder:SetImage(self.ui.Logo_Title, logoRes)
end

function LoginPanel:PlayLoginLogoVideo()
  if ApplicationUtils.is_editor_mode() and CS.Z1Client.LuaBehaviour.disable_login_video then
    self:TryDestroyGameUpdateUI()
    return
  end
  local logoVideo, logoAlphaVideo = LoginPVDataUtils.GetLogoVideo()
  if not logoVideo or not logoAlphaVideo then
    self:TryDestroyGameUpdateUI()
    return
  end
  if self.ui.Logo_Title then
    self.binder:SetActive(self.ui.Logo_Title, false)
  end
  if "Logo/Video_Logo_Rgb.mp4" == logoVideo then
    self.ui.Logo.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 175)
    self.ui.Logo.transform.sizeDelta = CS.UnityEngine.Vector2(1500, 720)
  else
    self.ui.Logo.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 200)
    self.ui.Logo.transform.sizeDelta = CS.UnityEngine.Vector2(1920, 1080)
  end
  self.binder:SetActive(self.ui.Logo, false)
  self.binder:SetActive(self.ui.Logo_New, false)
  self.logoVideoPlayer = AVProAlphaVideoPlayer(self.ui.LogoVideoPlayer, self.ui.LogoVideoPlayerBak, self.ui.LogoAlphaVideoPlayer, self.ui.LogoAlphaPlayerBak)
  self.logoVideoPlayer.autoPlayed = true
  
  function self.logoVideoPlayer.preparedCallback()
    self.ui.Logo:SetActive(true)
    self.displayLogoLastFrameTimer = TimerManager.Instance:CreateTimer(5.5, 0, nil, function()
      if self.displayLogoLastFrameTimer then
        TimerManager.Instance:StopTimer(self.displayLogoLastFrameTimer)
        self.displayLogoLastFrameTimer = nil
      end
      if self.logoVideoPlayer then
        self.logoVideoPlayer:Pause()
      end
    end)
  end
  
  self.logoVideoPlayer:SetUseSmoothTime(true)
  self.logoVideoPlayer:SetMaxSeekTime(5.5)
  self.logoVideoPlayer:SetRawImage(self.ui.Logo)
  self.logoVideoPlayer:OpenMedia(logoVideo, logoAlphaVideo)
end

function LoginPanel:SetAccountInputInteractable(_, isSdkLogin)
  if nil == isSdkLogin then
    return
  end
  self.accountInputField.interactable = not isSdkLogin
end

function LoginPanel:SetAccountInputText(_, account)
  PlayerDataUtils.SetAccountName(account)
  self.accountInputField.text = account
end

function LoginPanel:OnBtnServerClick()
  UIManager.Instance:Reopen(Urls.ServerSelect)
end

function LoginPanel:OpenAgeTipsPanel()
  local text = SdkMgr.Instance.model.tipAgeText
  UIManager.Instance:Reopen(Urls.CommonillustrateView, "适龄提示", text)
end

function LoginPanel:_SetAgeTipsIcon(iconUrl)
  if not iconUrl then
    return
  end
end

function LoginPanel:OnClickBtnLogin()
  if self.isLogining then
    return
  end
  DataCenter.gameData.EnterMockDemo = false
  self.binder:SetButtonInteractable(self.ui.Btn_Enter, false)
  TimerManager.Instance:StopTimer(self.loginTimer)
  self.loginTimer = TimerManager.Instance:CreateTimer(2, 0, nil, function()
    if self.binder and self.ui and self.ui.Btn_Enter then
      self.binder:SetButtonInteractable(self.ui.Btn_Enter, true)
    end
  end)
  local account = self.accountInputField.text
  LoginMgr.Instance:StartLogin(account)
end

function LoginPanel:PlayEnterAnim()
  self.uiAnimController:PlayState("UI_Login_Main_Group_Close")
end

function LoginPanel:PlayResetAnimation()
  print("[Login] Play Reset Anim")
  self.uiAnimController:PlayState("UI_Login_Main_Group_Loop")
end

function LoginPanel:OnClickAnnouncement()
  AnnouncementDataUtils.OpenAnnouncementPanel()
end

function LoginPanel:OnClickService()
  SdkMgr.Instance.GetCustomerService()
end

function LoginPanel:OnClickRepair()
  LoginMgr.Instance:SetExistHistoryLogin(false)
  
  local function cancelFunc()
    UIManager.Instance:CloseByUrl(Urls.PopMsgPanel)
  end
  
  local function confirmFunc()
    local panel = UIManager.Instance:GetWindow(Urls.AlertConfirm2Panel)
    panel:SetOnDestroyCallback(function()
      local ingameDownloadName = GroupDownloadMgr.Instance:GetInGameDownloadGroupName()
      if GroupDownloadMgr.Instance:IsGroupDownload(ingameDownloadName) then
        GroupDownloadMgr.Instance:SaveDownLoadSize(0)
      end
      Utils.SetClearResTag(true)
      Utils.ClearQzVersionCache()
      CS.ResourceManager.Runtime.ResourceUpdateHelper.ClearDownloadingDir()
      Utils.SetClearResTag(false)
      Utils.SetHasCheckInComplete(false)
      Alert.Show(20240, nil, function()
        ApplicationUtils.ExitGame()
      end)
    end)
  end
  
  local versionCode = CS.FrameWork.Z1Const.GetVersionCode()
  local buildNum = CS.FrameWork.Z1Const.GetBuildVerion()
  local PatchConst = require("GameLauncher.PatchConst")
  local patchResVersion = PatchConst.GetPatchVersion()
  local svnVersion = PatchConst.GetSvnVersion()
  local developVersionShowText = LT.Textf("DevelopVersionShowText", versionCode, buildNum, patchResVersion, svnVersion)
  local tipsTitle = LT.Text("RepairTipsTitle")
  local tipsContent = LT.Text("RepairTipsContent") .. "\n" .. developVersionShowText
  local archive_name = Utils.GetArchiveName()
  if archive_name then
    tipsContent = tipsContent .. string.format("[%s]", archive_name)
  end
  Alert.Show(20002, cancelFunc, confirmFunc, tipsTitle, tipsContent)
end

function LoginPanel:OnClickDeal()
  SdkMgr.Instance:ShowUserAgreement()
end

function LoginPanel:OnClickUserCenter()
  if SdkMgr.Instance:IsSdkLogin() and not LoginMgr.Instance.model.isPlatformLogin then
    LoginMgr.Instance:_Login(function()
      SdkMgr.Instance:OpenUserCenter()
    end)
  else
    SdkMgr.Instance:OpenUserCenter()
  end
end

function LoginPanel:OnClickBtnSetting()
  UIManager.Instance:Reopen(Urls.SettingMainPanel)
end

function LoginPanel:IsShowUserCenter()
  do return self.GetPlatformEntryVisiable end
  return self.GetPlatformEntryVisiable, self
end

function LoginPanel:IsShowService()
  if SdkMgr:IsXiao7() then
    return false
  end
  do return self.GetPlatformEntryVisiable end
  return self.GetPlatformEntryVisiable, self
end

function LoginPanel:GetPlatformEntryVisiable()
  if SdkMgr.Instance:IsSdkLogin() then
    return LoginMgr.Instance.model.isPlatformLogin
  end
  return false
end

function LoginPanel:IsShowDeal()
  return SdkMgr.Instance:IsSdkLogin() and not SteamSdk.Instance:IsSteam()
end

function LoginPanel:OnLoginErrorEvent()
  self.isLogining = false
  print("[Login] LoginErrorEvent Callback")
  self:PlayResetAnimation()
  self.binder:SetButtonInteractable(self.ui.Btn_Enter, true)
end

function LoginPanel:OnStartLoginServerEvent()
  if self.isLogining then
    return
  end
  self.isLogining = true
  self:PlayEnterAnim()
end

function LoginPanel:OnUnbind()
  LateUpdateBeat.Instance:Remove(self._UpdateDownloadSatus, self)
  self:_RestoreFps()
  local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
  if ingameDownloadGroup then
    ingameDownloadGroup:SetDelegate(nil)
    GroupDownloadMgr.Instance:EnableDownloadMaxBandWidth()
  end
  GroupDownloadMgr.Instance:SetUseDownloadDelegate(false)
  if self.ui and not IsNil(self.ui.Logo) then
    self.ui.Logo:SetActive(false)
  end
  if self.displayLogoLastFrameTimer then
    TimerManager.Instance:StopTimer(self.displayLogoLastFrameTimer)
    self.displayLogoLastFrameTimer = nil
  end
  if self.logoVideoPlayer then
    self.logoVideoPlayer:Dispose()
    self.logoVideoPlayer = nil
  end
  if self.videoPlayer then
    self.videoPlayer:Dispose()
    self.videoPlayer = nil
  end
  if self.loginTimer then
    TimerManager.Instance:StopTimer(self.loginTimer)
    self.loginTimer = nil
  end
  if UIManager.Instance:GetWindow(Urls.AnnouncementPanel) then
    UIManager.Instance:CloseByUrl(Urls.AnnouncementPanel)
  end
  self:TryDestroyGameUpdateUI()
end

function LoginPanel:OnStartDownLoadRequest()
  self:_SetDownloadGroupVisible(true)
  self.binder:SetText(self.ui.Text_DownloadPrecent, LT.Text("InGameDownloadReady"))
  self._slider_Download.value = 0
end

function LoginPanel:OnNetCarrierData(cb)
end

function LoginPanel:OnConfirmDownload(isComfirm)
  if not isComfirm then
    self:_SetDownloadGroupVisible(false)
  end
end

function LoginPanel:OnDownloadProgressing(download_size, total_size)
  self:_SetDownloadGroupVisible(true)
  local pb = download_size / math.max(0.001, total_size)
  local pbInt = math.ceil(pb * 100)
  local progressText = string.format("(%s/%s)", DownLoadGroup.GetSizeFmt(download_size), DownLoadGroup.GetSizeFmt(total_size))
  self.binder:SetText(self.ui.Text_DownloadPrecent, LT.Textf("InGameDownloadingProg", string.format("%d%%%s", pbInt, progressText)))
  self._slider_Download.value = pb
end

function LoginPanel:OnDownloadGroupSuccess()
  if not UIManager.Instance:GetWindow(Urls.InGameDownloadPanel) then
    Alert.Show(20187)
  end
  self:_SetDownloadGroupVisible(false)
end

function LoginPanel:OnDownloadGroupFailed(err_code, err_msg)
  self:_SetDownloadGroupVisible(false)
  if 7011015 ~= err_code then
    Alert.Show(20189, function()
      ApplicationUtils.ExitGame()
    end, function()
      local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
      if ingameDownloadGroup then
        ingameDownloadGroup:RequestDownLoadGroup()
      else
        GroupDownloadMgr.Instance:DownloadIngameGroup(true)
      end
    end)
  end
end

function LoginPanel:_RestoreFps()
  local fps = SettingManager.Instance:GetLocalSaveValue(CommonDefine.SettingUniqueName.FPSLimit)
  fps = fps or 30
  ApplicationUtils.SetFPS(0 == fps and 30 or fps)
end

function LoginPanel:_SetDownloadGroupVisible(visible)
  self.ui.Main_Group:SetActive(not visible)
  self.ui.DownLoadGroup:SetActive(visible)
  if visible then
    ApplicationUtils.SetFPS(24)
  else
    self:_RestoreFps()
  end
end

function LoginPanel:OnApplyResStart()
  self:_SetDownloadGroupVisible(true)
  self.binder:SetText(self.ui.Text_DownloadPrecent, LT.Text("InGameDownloadUnzipStart"))
end

function LoginPanel:OnApplyResComplete()
end

function LoginPanel:OnApplyPatchingRes(percent)
  percent = percent or 0
  self:_SetDownloadGroupVisible(true)
  self.binder:SetText(self.ui.Text_DownloadPrecent, LT.Textf("InGameDownloadUnziping", math.ceil(percent)))
end

function LoginPanel:OnApplyCheckingResMD5(percent)
  percent = percent or 0
  self:_SetDownloadGroupVisible(true)
  self.binder:SetText(self.ui.Text_DownloadPrecent, LT.Textf("InGameDownloadChecking", math.ceil(percent)))
end

function LoginPanel:OnApplyResRedownload(percent)
  percent = percent or 0
  self:_SetDownloadGroupVisible(true)
  self.binder:SetText(self.ui.Text_DownloadPrecent, LT.Textf("InGameDownloadRedownloading", math.ceil(percent)))
end

function LoginPanel:OnApplyResFailed()
  self:_SetDownloadGroupVisible(true)
end

return LoginPanel
