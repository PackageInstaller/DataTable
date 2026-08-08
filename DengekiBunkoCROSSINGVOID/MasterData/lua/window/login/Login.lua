local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")
local Msdk = CS.Msdk
local m_noticeDisplayed = false
local m_isAcceptLicense = false
local m_actorAttrWaitCnt = 0
local m_accountSessionUpdatedCallback
local m_cards = {}
local m_fadeCards = {}
local m_textruePathes = _ENV["!"]({})
local m_textrueIndex = 0
local m_tweenEnter, m_tweenLoop
local m_cityLoaded = false
local m_foreFaded = false
local m_action
local m_autoLogin = false
local m_activeButtons
local m_isFromAuthWindow = false
local m_authFailTimes = 0
local m_reTryTimes = 3
local m_timeoutTimes = 0
local m_endTimeStamp, m_startTime
local m_guestPanel = false
local m_currWolrdData
local m_isSwitchingToCity = false

function SetupWindow()
  math.randomseed(os.time())
  m_startTime = CS.System.DateTime(1970, 1, 1, 0, 0, 0, 0)
  WU.BindButtonEvent(REF.ButtonSwitchAccount, function()
    clickSwitchAccount(true)
  end)
  WU.BindButtonEvent(REF.ButtonReturn, function()
    clickSwitchAccount(false)
  end)
  WU.BindButtonEvent(REF.ButtonAutoLogin, OnAutoLoginClick)
  WU.BindButtonEvent(REF.ButtonAgree, OnAgreeClick)
  WU.BindButtonEvent(REF.ButtonDecline, OnDeclineClick)
  WU.BindButtonEvent(REF.ButtonActivate, OnActivateClick)
  WU.BindButtonEvent(REF.ButtonActivateClose, OnActivateCloseClick)
  WU.BindButtonEvent(REF.ButtonCustomSrv, OnButtonCustomSrv)
  WU.BindButtonEvent(REF.ButtonNotice, OnButtonNotice)
  REF.TutorialPanel.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.ToggleLicense, OnLicenseTick)
  WU.BindButtonEvent(REF.UserProtocolLabel, OnClickUserProtocolLabel)
  WU.BindButtonEvent(REF.PrivacyPolicyLabel, OnClickPrivacyPolicyLabel)
  local switch = this:GetData("AccountSwitch")
  if switch and switch.bulletinSwitch == false then
    REF.ButtonNotice.gameObject:SetActive(false)
    REF.ButtonBottomNotice.gameObject:SetActive(false)
  end
  local tencentLoginQQ, tencentLoginWX, guest
  if switch.qqLoginSwitch then
    tencentLoginQQ = "tencent/login_qq"
  end
  if switch.wxLoginSwitch then
    tencentLoginWX = "tencent/login_wechat"
  end
  local spriteNames = {
    guest,
    tencentLoginWX,
    tencentLoginQQ
  }
  m_activeButtons = {}
  local bottonRoot = REF.LoginButtons
  for i = 1, #bottonRoot do
    local button = bottonRoot[i - 1]["$"]
    local spriteName = spriteNames[i]
    if spriteName ~= nil then
      button.gameObject:SetActive(true)
      button.UISprite.spriteName = spriteName
      button.UISprite:MakePixelPerfect()
      WU.BindButtonEvent(button, _ENV["On" .. button.gameObject.name])
      table.insert(m_activeButtons, button)
    else
      button.gameObject:SetActive(false)
    end
  end
  HideAroundWidget()
  WU.DivideAlign(m_activeButtons, 1500)
end

local m_msdkLoginCallback, m_msdkLoginTimeout

function MsdkLogin(platform, callback)
  m_msdkLoginCallback = callback or function()
    this:BroadcastGameEvent("OnAccountAuthSuccess")
  end
  Msdk.WGPlatform.Instance:WGLogin(platform)
  m_msdkLoginTimeout = this:DelayInvokeInScaledSeconds(20, function()
    local loginRet = Msdk.LoginRet()
    loginRet.flag = -1
    MsdkEventHandler(loginRet)
  end)
end

function MsdkAuth(loginRet)
  UpdateAccountSession(function()
    local accountAuth = {}
    accountAuth.entry = loginRet.open_id
    accountAuth.entryType = "social"
    accountAuth.socialType = "msdk"
    accountAuth.socialPlatform = loginRet.platform
    accountAuth.socialExpire = loginRet:GetTokenExpireByType(loginRet.platform)
    accountAuth.socialToken = loginRet:GetAccessToken()
    accountAuth.deviceType = PB.enum.GamePlatForm.Android
    this:SetData("accountAuth", accountAuth)
    local wireFormatTable = ProtobufT("ApiAuthInfo", accountAuth)
    this:AccountRequest("/Auth/"):AddHeader("Authorization", "AccountToken " .. this:GetData("account/loginAccountToken")):Post(wireFormatTable, function(response)
      local accountCache = this:GetData("accountCache")
      accountCache.accountId = response.accountId
      accountCache.accountEntry = response.socialNickName
      accountCache.entryType = response.entryType
      accountCache.openId = response.openId
      accountCache.accessToken = response.tokenAccess
      accountCache.expireTime = response.createTime + response.expireSeconds
      accountCache.localeId = CS.ConfigDataManager.Instance.CurrentDynamicConfig.Id
      accountCache.socialEntry = loginRet.open_id
      accountCache.socialPlatform = loginRet.platform
      accountCache.realnameFlag = response.realnameFlag
      accountCache.pfKey = loginRet.pf_key
      this:SetData("accountCache", accountCache)
      if response.needPop then
        WU.ShowMessageOK(WU.GetString("Platform_RealNameHint"))
      end
      local appId = fif(U.ToEnum(Msdk.ePlatform, loginRet.platform) == Msdk.ePlatform.ePlatform_QQ, "1106429722", "wx687f4629ba7c3086")
      CS.RecordVideoManager.Instance:RefreshMSDKTicket(appId, loginRet.open_id, loginRet.platform, accountCache.accessToken)
      if m_msdkLoginCallback ~= nil then
        m_msdkLoginCallback()
        m_msdkLoginCallback = nil
      end
    end, OnAccountAuthFailed)
  end)
  S:Get("IAPHandler").UpdateMidasUserInfo(loginRet)
  CS.NativeInterface.External_HTTPDNSSetOpenId(loginRet.open_id)
end

function MsdkEventHandler(loginRet)
  if m_msdkLoginTimeout ~= nil then
    this:StopCoroutine(m_msdkLoginTimeout)
    m_msdkLoginTimeout = nil
  end
  WU.SetLockFlag(PB.enum.LockInputFlag.NetworkLoading, false)
  if loginRet.flag == Msdk.eFlag.eFlag_Succ then
    WU.ShowHintText(WU.GetString("WindowLogin_LoginSucceed"))
    this:SetData("SocialOpenId", loginRet.open_id)
    
    function m_msdkLoginCallback()
      SetInitUI()
    end
    
    MsdkAuth(loginRet)
    this:DelayInvokeInSeconds(0.5, function()
      local reachability = CS.UnityEngine.Application.internetReachability
      if reachability == CS.UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
        CS.NativeInterface.External_CheckKingCardStatus()
      end
    end)
  else
    if loginRet.flag == Msdk.eFlag.eFlag_QQ_UserCancel then
      WU.ShowHintText(WU.GetString("Window_CancelQQLogin"))
      return
    end
    this:SetData("accountCache", {})
    if loginRet.flag == Msdk.eFlag.eFlag_QQ_NetworkErr then
      CS.PlatformManager.IsNeedWXAutoLogin = false
      CS.PlatformManager.IsNeedQQAutoLogin = false
      WU.ShowHintText(WU.GetString("Platform_NetworkError"))
    elseif loginRet.flag ~= Msdk.eFlag.eFlag_Local_Invalid and loginRet.flag ~= Msdk.eFlag.eFlag_Need_Realname_Auth and loginRet.flag ~= -1 then
      CS.PlatformManager.IsNeedWXAutoLogin = false
      CS.PlatformManager.IsNeedQQAutoLogin = false
      WU.ShowHintText(WU.GetString("WindowLogin_LoginFailed_wechat"))
    end
    SetInitUI()
  end
end

function UninitWindow()
  if Msdk.MsdkEvent.Instance ~= nil then
    Msdk.MsdkEvent.Instance:LoginEvent("-", MsdkEventHandler)
  end
end

function canAuthLogin()
  if 0 < m_endTimeStamp then
    local nowSpan = CS.System.DateTime.UtcNow - m_startTime
    if nowSpan.TotalSeconds < m_endTimeStamp then
      local tick = math.floor(m_endTimeStamp - nowSpan.TotalSeconds)
      WU.ShowHintText(WU.GetString("Platform_Tips4", WU.RenderCountDownTime(tick, 38)))
      return false
    end
  end
  return true
end

function SaveTimeoutRecord(bClear)
  if bClear then
    m_endTimeStamp = 0
    m_timeoutTimes = 0
    m_authFailTimes = 0
  end
  local data = {}
  data.endTimeStamp = m_endTimeStamp
  data.timeoutTimes = m_timeoutTimes
  data.authFailTimes = m_authFailTimes
  WU.SetGameDataCache("CheckAuthFailTimeOut", data)
end

function CheckAuthFailTimeOut()
  m_authFailTimes = 0
  m_endTimeStamp = 0
  local data = WU.GetGameDataCache("CheckAuthFailTimeOut")
  if data then
    m_endTimeStamp = data.endTimeStamp
    m_timeoutTimes = data.timeoutTimes
    m_authFailTimes = data.authFailTimes
  end
  this:RepeatInvokeInSeconds(1, function()
    if 0 < m_endTimeStamp then
      local nowSpan = CS.System.DateTime.UtcNow - m_startTime
      local nowSec = nowSpan.TotalSeconds
      if nowSec >= m_endTimeStamp then
        m_endTimeStamp = 0
        m_authFailTimes = 0
        SaveTimeoutRecord()
      end
    end
  end)
end

function LoginRetry()
  REF.LoginBar.gameObject:SetActive(true)
  REF.Start.gameObject:SetActive(false)
  REF.ButtonSwitchAccount.gameObject:SetActive(false)
  REF.ButtonReturn.gameObject:SetActive(true)
  REF.Agreement.gameObject:SetActive(false)
  WU.ShowHintText(WU.GetString("Error_LoginFaild"))
  OnAccountAuthFailed()
end

function OnPlatformWakeup(launchfrom, ret)
  warning("Debug", "Lua OnPlatformWakeup:" .. launchfrom)
  if ret.flag ~= Msdk.eFlag.eFlag_NeedSelectAccount then
    if launchfrom == "wx_gamecenter" or launchfrom == "wx_share" then
      OnButtonAuth2()
    elseif launchfrom == "sq_gamecenter" or launchfrom == "qq_share" then
      OnButtonAuth3()
    end
  end
end

function OnNeedSelectAccount(launchfrom)
  if launchfrom == "wx_gamecenter" then
    OnButtonAuth2()
  end
end

function InitWindow()
  m_currWolrdData = nil
  REF.NormalRightButtons.gameObject:SetActive(false)
  CS.PlatformManager.Instance.IsNeedResetGame = false
  m_isSwitchingToCity = false
  CheckAuthFailTimeOut()
  m_isAcceptLicense = m_configDataManager.GetPreferences().isAcceptLicense
  Msdk.MsdkEvent.Instance:LoginEvent("+", MsdkEventHandler)
  REF.LabelVersion.UILabel.text = WU.GetString("TXVersion", m_configDataManager.FullVersion())
  CS.SoundManager.Instance:PlayMusic("MusicPatch")
  this:RegisterGameEvent("OnWebViewBack", OnSignupBackEvent)
  this:RegisterGameEvent("OnSignupSuccess", OnSignupSuccessEvent)
  this:RegisterGameEvent("OnAccountAuthSuccess", OnAccountAuthSuccessEvent)
  this:RegisterGameEvent("UI/WindowInited", OnWindowInited)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:RegisterGameEvent("SceneAwake", OnSceneAwake)
  this:RegisterGameEvent("ShowActivationCode", OnShowActivationCode)
  this:RegisterGameEvent("LoginPushEnd", OnLoginPushEnd)
  this:RegisterGameEvent("NetworkErrorNotResetGame", LoginRetry)
  this:RegisterGameEvent("PlatformWakeup", OnPlatformWakeup)
  this:RegisterGameEvent("NeedSelectAccount", OnNeedSelectAccount)
  this:RegisterGameEvent("ChangeAccount", onChangeAccount)
  this:RegisterGameEvent("GetKingCardStatus", OnGetKingCardStatus)
  this:Bind("CurrentWorld", OnSetCurrentWorld)
  this:Bind("UserAgreement", OnSetUserAgreement)
  REF.LoginBar.gameObject:SetActive(true)
  REF.LanguageRoot.gameObject:SetActive(false)
  REF.Agreement.gameObject:SetActive(false)
  REF.ActivationCode.gameObject:SetActive(false)
  WU.TraverseChildren(REF.LoginBar, function(g)
    g.gameObject:SetActive(false)
  end)
  BuildRoleList()
  WU.PreloadWindow("City")
  CS.BuglyAgent.AddSceneData("FullVersion", m_configDataManager.FullVersion())
end

function onChangeAccount(result, launchfrom)
  if result == "YES" then
    if launchfrom == "wx_gamecenter" or launchfrom == "wx_share" then
      OnButtonAuth2()
    elseif launchfrom == "sq_gamecenter" or launchfrom == "qq_share" then
      OnButtonAuth3()
    end
  end
end

function OnButtonNotice()
  CS.SceneBaseImpl.CurrentScene:OpenNotify("/beforelogin?source=SceneLogin")
end

function OnButtonCustomSrv()
  local url = WU.GetClientUrlParam(PB.all("MsdkUrl")[1].LoginCS)
  WU.OpenUrl(url)
end

function IsNeedAutoLogin()
  local accountCache = this:GetData("accountCache")
  return CS.ConfigDataManager.Instance.CurrentDynamicConfig.Id == accountCache.localeId
end

function CheckMsdkNoticeIsStop()
  local scene = "733"
  local noticeData = CS.Msdk.WGPlatform.Instance:WGGetNoticeData(scene)
  if noticeData then
    local list = _ENV["!"](noticeData:ToArray())
    if table.empty(list) then
      return false
    end
    local notice = list[1]
    if notice.content_type ~= 0 then
      Msdk.WGPlatform.Instance:WGShowNotice(scene)
    else
      WU.ShowMessageOK(notice.msg_content, function()
        CS.GameGlobal.Instance:ResetGame()
      end)
    end
    return true
  else
    return false
  end
end

function SetInitUI()
  REF.BottomBG.gameObject:SetActive(true)
  local accountCache = this:GetData("accountCache")
  local isNotSameLocaledConfigUrl = CS.ConfigDataManager.Instance.CurrentDynamicConfig.Id ~= accountCache.localeId
  if isNotSameLocaledConfigUrl then
    accountCache = {}
    clearAccountCache()
  end
  if accountCache.accountEntry ~= nil then
    CS.PlatformManager.IsNeedWXAutoLogin = false
    CS.PlatformManager.IsNeedQQAutoLogin = false
    RequestDir(function(response)
      if os.time() + 3600 <= accountCache.expireTime then
        local type = WU.GetString("WindowLogin_Player")
        local name = accountCache.accountEntry
        if name ~= "" then
          if accountCache.entryType == "guest" then
            name = string.sub(accountCache.openId, 5)
            type = WU.GetString("WindowLogin_Guest")
          elseif accountCache.entryType == "email" then
            local index = string.find(accountCache.accountEntry, "@")
            name = string.gsub(accountCache.accountEntry, string.sub(accountCache.accountEntry, 3, index - 1), string.rep("*", index - 3))
          end
        end
        local worldName = ""
        if response.dirWorld then
          local currentWorld = response.dirWorld.worldInfo
          if currentWorld and currentWorld.worldName then
            worldName = currentWorld.worldName
            this:SetData("WorldName", worldName)
          end
        end
        REF.LabelLastAccount.UIHtmlLabel.text = WU.GetString("WindowLogin_LoginInfo", type, name, worldName)
        REF.LastAccount.gameObject:SetActive(true)
        REF.LastAccount.UIPlayTween:Play(true)
        REF.SwitchAccount.gameObject:SetActive(false)
        REF.ButtonSwitchAccount.gameObject:SetActive(true)
        REF.ButtonReturn.gameObject:SetActive(false)
        REF.ButtonCustomSrv.gameObject:SetActive(this:GetData("AccountSwitch").customService)
        this:DelayInvokeInScaledSeconds(1.5, function()
          REF.LastAccount.UIPlayTween:Play(false)
          this:DelayInvokeInScaledSeconds(0.35, function()
            if not REF.SwitchAccount.gameObject.activeSelf then
              REF.Start.gameObject:SetActive(true)
              ShowAroundWidget()
            end
          end)
        end)
      else
        REF.LastAccount.gameObject:SetActive(false)
        REF.SwitchAccount.gameObject:SetActive(true)
        REF.ButtonSwitchAccount.gameObject:SetActive(false)
        REF.ButtonReturn.gameObject:SetActive(false)
        REF.ButtonCustomSrv.gameObject:SetActive(false)
        ShowAroundWidget()
        if accountCache.entryType ~= "guest" then
          ShowAccountAuthWindow(accountCache.accountEntry, accountCache.entryType, nil, nil, nil)
        end
      end
      REF.NormalRightButtons.UIGrid:Reposition()
    end)
  else
    REF.LastAccount.gameObject:SetActive(false)
    REF.Start.gameObject:SetActive(false)
    REF.SwitchAccount.gameObject:SetActive(true)
    REF.ButtonSwitchAccount.gameObject:SetActive(false)
    REF.ButtonReturn.gameObject:SetActive(false)
    REF.ButtonCustomSrv.gameObject:SetActive(false)
    ShowAroundWidget()
    if CS.PlatformManager.IsNeedWXAutoLogin then
      CS.PlatformManager.IsNeedWXAutoLogin = false
      OnButtonAuth2()
    elseif CS.PlatformManager.IsNeedQQAutoLogin then
      CS.PlatformManager.IsNeedQQAutoLogin = false
      OnButtonAuth3()
    end
    REF.NormalRightButtons.UIGrid:Reposition()
  end
  if not m_noticeDisplayed then
    ShowNotice("1")
    m_noticeDisplayed = true
  end
  if not m_isAcceptLicense then
    ShowLicense()
  end
end

function ProcessLogin()
  if IsNeedAutoLogin() then
    MsdkLogin(Msdk.ePlatform.ePlatform_None, SetInitUI)
  else
    SetInitUI()
  end
end

function Shuffle(array)
  local n = #array + 1
  while 1 < n do
    n = n - 1
    local k = math.random(1, n + 1)
    local tmp = array[k]
    array[k] = array[n]
    array[n] = tmp
  end
end

function BuildRoleList()
  for i = 1, #REF.LoopRoleList do
    local card = REF.LoopRoleList[i - 1]
    WU.RestartTween(card.Texture:query(typeof(CS.UITweener), function(comp)
      return comp.tweenGroup == 0
    end))
    m_cards[i] = card
  end
  m_tweenEnter = REF.LoopRoleList:query(typeof(CS.UITweener), function(comp)
    return comp.tweenGroup == 0
  end)
  m_tweenEnter.enabled = true
  m_tweenEnter:SetOnFinished(function()
    LoopRoleList()
    ProcessLogin()
  end)
  m_tweenLoop = REF.LoopRoleList:query(typeof(CS.UITweener), function(comp)
    return comp.tweenGroup == 1
  end)
  m_tweenLoop.enabled = false
  m_tweenLoop:SetOnFinished(LoopRoleList)
  local resPathList = PB.all("ActorConfig"):where(function(k, v)
    return v.showInLogin
  end):select(function(config)
    return config.animRes
  end):toarray():distinct()
  for i = 1, #resPathList do
    m_textruePathes[i] = "Texture/ActorGroup/selectteam_" .. resPathList[i]
  end
  Shuffle(m_textruePathes)
  for i = 1, #REF.FadeRoleList do
    m_fadeCards[i] = REF.FadeRoleList[i - 1]
  end
  m_textrueIndex = 0
  UpdateRoleList()
end

function UpdateRoleList()
  for i = 1, #m_cards do
    local card = m_cards[i]
    local nextIndex = (m_textrueIndex + i) % #m_textruePathes + 1
    card.Texture.UITexture.mainTexturePath = m_textruePathes[nextIndex]
  end
  m_textrueIndex = m_textrueIndex + 1
end

function LoopRoleList()
  m_tweenLoop.enabled = true
  m_tweenLoop:ResetToBeginning()
  UpdateRoleList()
end

function OnSceneAwake(scene)
  if scene == "SceneCity" then
    WU.BringToFront(this, 9999)
  end
end

function OnWindowInited(window)
  if window.name == "City" then
    m_cityLoaded = true
    ForeFadeOut()
  elseif window.name == "Auth" or window.name == "GMAuth" or window.name == "World" then
    REF.LoginBar.gameObject:SetActive(false)
  end
end

function OnWindowUninited(window)
  if window.name ~= "Auth" and window.name ~= "GMAuth" and window.name ~= "World" or WU.IsRenderingWithName("Auth") or WU.IsRenderingWithName("GMAuth") or WU.IsRenderingWithName("World") then
  else
    REF.LoginBar.gameObject:SetActive(true)
  end
end

function ForeFadeOut()
  if m_foreFaded and m_cityLoaded then
    WU.ToggleRendering(REF.ForeEffectIn, false)
    WU.RestartTween(REF.FadeRoleList:query(typeof(CS.UITweener), function(comp)
      return comp.tweenGroup == 1
    end))
    for i = 1, #m_fadeCards do
      local card = m_fadeCards[i]
      WU.RestartTween(card.Texture:query(typeof(CS.UITweener), function(comp)
        return comp.tweenGroup == 1
      end))
    end
    local effect = REF.ForeEffectOut.EffectGenerator
    effect:Play(function()
      ShowNotice("2")
      WU.DestroyWindow(this)
      _ENV["$"](WU.FindWindow("Resource"))["$UILuaWindow"]:PlayUITweener()
      _ENV["$"](WU.FindWindow("Messenger"))["$UILuaWindow"]:PlayUITweener()
      CS.UIWindowManager.Instance:ReleaseUnusedWindows()
    end)
  end
end

function PlayGameStartVoice()
  local actorConfig = PB.all("ActorConfig"):where(function(k, v)
    return v.enableGameStartVoice
  end):toarray()
  if actorConfig == nil then
    return
  end
  local selected = actorConfig[math.random(1, #actorConfig)]
  CS.SoundManager.Instance:PlaySound("Voice/" .. selected.voiceRes .. "/Event/Gamestart", 1.0)
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GameStart01")
end

function ForeFadeIn()
  local curveUpdater = REF.LoopRoleList.CurveUpdater
  curveUpdater:OnEvaludate("+", function(value)
    m_tweenLoop.localTimeScale = 1 + value
  end)
  curveUpdater.enabled = true
  curveUpdater:ResetToBeginning()
  WU.RestartTween(REF.FadeRoleList:query(typeof(CS.UITweener), function(comp)
    return comp.tweenGroup == 0
  end))
  for i = 1, #m_fadeCards do
    local card = m_fadeCards[i]
    WU.RestartTween(card.Texture:query(typeof(CS.UITweener), function(comp)
      return comp.tweenGroup == 0
    end))
  end
  PlayGameStartVoice()
  local effect = REF.ForeEffectIn.EffectGenerator
  effect:Play(function()
    WU.ToggleRendering(REF.BackEffect, false)
    WU.ToggleRendering(REF.Controls, false)
    m_foreFaded = true
    if WU.TutorialFight() then
      this:SetData("TutorialSign", 1)
      CS.UIBaseProcess.Instance:FadeIn(EnterCity)
    else
      EnterCity()
    end
  end)
  for i = 1, #m_cards do
    local card = m_cards[i]
    WU.RestartTween(card.Texture:query(typeof(CS.UITweener), function(comp)
      return comp.tweenGroup == 1
    end))
  end
end

function EnterCity()
  CS.PlatformManager.Instance.IsNeedResetGame = true
  CS.GameGlobal.Instance:ChangeLevel("SceneCity", CS.GameGlobal.ResetLevel.None, false)
  m_isSwitchingToCity = true
end

function clickSwitchAccount(on)
  REF.Start.gameObject:SetActive(not on)
  REF.ButtonSwitchAccount.gameObject:SetActive(not on)
  REF.SwitchAccount.gameObject:SetActive(on)
  REF.ButtonReturn.gameObject:SetActive(on)
  m_currWolrdData = nil
end

function OnAutoLoginClick()
  if not canAuthLogin() then
    return
  end
  if not m_isAcceptLicense then
    ShowLicenseNotAgree()
    return
  end
  m_autoLogin = true
  local accountCache = this:GetData("accountCache")
  if accountCache.accountEntry and accountCache.entryType == "guest" then
    m_guestPanel = false
    RequestAccountAuth(accountCache.accountEntry, "guest", "")
  else
    ShowWorldWindow()
  end
end

function OnButtonAuth1()
  if not canAuthLogin() then
    return
  end
  
  local function SetAuthWindow()
    local accountCache = this:GetData("accountCache")
    if accountCache then
      if accountCache.expireTime and os.time() + 60 <= accountCache.expireTime then
        ShowAccountAuthWindow(accountCache.accountEntry, accountCache.entryType, nil, accountCache.accessToken, accountCache.openId)
      else
        ShowAccountAuthWindow(accountCache.accountEntry, accountCache.entryType, nil, nil, accountCache.openId)
      end
    else
      ShowAccountAuthWindow("", "", nil, nil, nil)
    end
  end
  
  if not m_isAcceptLicense then
    ShowLicenseNotAgree()
    return
  end
  WU.AcquireWindowAsync("GuestLoginPrompt")
end

function ShowAccountAuthWindow(entry_, entryType_, password_, accessToken_, openId_)
end

function OnButtonAuth2()
  if not canAuthLogin() then
    return
  end
  if not m_isAcceptLicense then
    ShowLicenseNotAgree()
    return
  end
  WU.SetLockFlag(PB.enum.LockInputFlag.NetworkLoading, true)
  local platform = Msdk.ePlatform.ePlatform_Weixin
  local isInstalled = Msdk.WGPlatform.Instance:WGIsPlatformInstalled(platform)
  if isInstalled then
    MsdkLogin(platform)
  else
    Msdk.WGPlatform.Instance:WGQrCodeLogin(platform)
  end
end

function OnButtonAuth3()
  if not canAuthLogin() then
    return
  end
  if not m_isAcceptLicense then
    ShowLicenseNotAgree()
    return
  end
  MsdkLogin(Msdk.ePlatform.ePlatform_QQ)
  WU.SetLockFlag(PB.enum.LockInputFlag.NetworkLoading, true)
end

function ShowAgreement()
  REF.LoginBar.gameObject:SetActive(false)
  REF.Agreement.gameObject:SetActive(true)
  REF.LabelAgreement.UILabel:ResizeCollider()
end

function OnAgreeClick()
  if m_action == "registerAccount" then
    CS.SceneLogin.Instance:OnOpenRegisterPage()
    REF.Agreement.gameObject:SetActive(false)
  elseif m_action == "guestLogin" then
    m_guestPanel = true
    GuestSignup()
  end
end

function OnDeclineClick()
  REF.Agreement.gameObject:SetActive(false)
  REF.LoginBar.gameObject:SetActive(true)
end

function UpdateAccountSession(callback)
  m_accountSessionUpdatedCallback = callback
  local luaTable = S:Get("ConfigDataManager").ClientBasicInfo()
  local wireFormatTable = ProtobufT("ApiAccountSession", luaTable)
  this:AccountRequest("/AccountSession/"):Post(wireFormatTable, OnAccountSessionResponse, SetTimeoutCheck)
end

function OnAccountSessionResponse(response)
  this:SetData("account/loginAccountToken", response.accountToken)
  m_accountSessionUpdatedCallback()
end

function GuestSignup()
  UpdateAccountSession(function()
    this:AccountRequest("/EntryReg/"):AddHeader("Authorization", "AccountToken " .. this:GetData("account/loginAccountToken")):Post({entryType = "guest"}, OnaccountEntryRegResponse)
  end)
end

function OnaccountEntryRegResponse(message)
  this:AccountRequest("/Account/"):AddHeader("Authorization", "AccountToken " .. this:GetData("account/loginAccountToken")):Post({entryType = "guest"}, OnAccountRegResponse)
end

function OnAccountRegResponse(response)
  RequestAccountAuth(response.entry.entry, "guest", "")
end

function RequestAccountAuth(entry_, entryType_, password_)
  UpdateAccountSession(function()
    local accountAuth = {
      entry = entry_,
      entryType = entryType_,
      password = password_
    }
    this:SetData("accountAuth", accountAuth)
    local wireFormatTable = ProtobufT("ApiAuthInfo", accountAuth)
    this:AccountRequest("/Auth/"):AddHeader("Authorization", "AccountToken " .. this:GetData("account/loginAccountToken")):Post(wireFormatTable, OnAccountAuthResponse)
  end)
end

function OnAccountAuthResponse(response)
  if m_guestPanel then
    REF.Agreement.gameObject:SetActive(false)
  end
  print("Account", response.tokenAccess)
  local accountCache = this:GetData("accountCache")
  local accountAuth = this:GetData("accountAuth")
  accountCache.accountEntry = accountAuth.entry
  accountCache.entryType = accountAuth.entryType
  accountCache.accountId = response.accountId
  accountCache.openId = response.openId
  accountCache.accessToken = response.tokenAccess
  accountCache.expireTime = response.createTime + response.expireSeconds
  accountCache.localeId = CS.ConfigDataManager.Instance.CurrentDynamicConfig.Id
  if accountAuth.entryType == "guest" then
    accountCache.guestEntry = accountAuth.entry
  end
  this:SetData("accountCache", accountCache)
  this:BroadcastGameEvent("OnAccountAuthSuccess")
end

function ShowAroundWidget()
  REF.BottomLayer.gameObject:SetActive(true)
  REF.LabelVersion.gameObject:SetActive(true)
  UpdateLicenseTick()
  REF.NormalRightButtons.gameObject:SetActive(true)
end

function HideAroundWidget()
  REF.BottomLayer.gameObject:SetActive(false)
  REF.LabelVersion.gameObject:SetActive(false)
  REF.ToggleLicense.gameObject:SetActive(false)
  REF.NormalRightButtons.gameObject:SetActive(false)
end

function OnSignupSuccessEvent(message)
  ShowAccountAuthWindow(message.entry, message.entryType, message.pwd, nil, nil)
end

function OnSignupBackEvent(message)
  REF.LoginBar.gameObject:SetActive(true)
  if WU.IsRenderingWithName("Auth") then
    WU.RecycleWindow("Auth")
  end
end

function OnAccountAuthSuccessEvent(param)
  local accountCache = this:GetData("accountCache")
  ShowWorldWindow(function()
    REF.LoginBar.gameObject:SetActive(false)
  end)
  if REF.SwitchAccount.gameObject.activeSelf then
    REF.ButtonReturn.gameObject:SetActive(true)
  end
end

function RequestDir(callback)
  local param = S:Get("ConfigDataManager").ClientBasicInfo()
  local accountCache = this:GetData("accountCache")
  local name = accountCache.accountEntry
  if accountCache.entryType == "guest" then
    param.playerType = PB.enum.PlayerType.Guest
  elseif accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ or accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    param.playerType = PB.enum.PlayerType.Sqwx
  else
    param.playerType = PB.enum.PlayerType.Guest
  end
  local wireFormatTable = ProtobufT("ReqDir", param)
  this:DirRequest("/dirsvr/Dir/"):Post(wireFormatTable, function(response)
    UpdateCurrentWorld(response.dirWorld.worldInfo)
    if response.dirStat.stat == PB.enum.ServerOpenStatus.OpenSoon then
      local time = WU.RenderTime(response.dirStat.dirOpenTime)
      WU.ShowMessageOK(WU.GetString("Window_ServerOpenStatusOpenSoon", time), function()
        CS.GameGlobal.Instance:ResetGame()
      end)
    elseif response.dirStat.stat == PB.enum.ServerOpenStatus.Maintenance then
      local time = WU.RenderTime(response.dirStat.dirOpenTime)
      WU.ShowMessageOK(WU.GetString("Window_ServerOpenStatusMaintenance", time), function()
        CS.GameGlobal.Instance:ResetGame()
      end)
    elseif response.dirStat.stat == PB.enum.ServerOpenStatus.Closed then
      WU.ShowMessageOK(WU.GetString("Window_ServerOpenStatusClosed"), function()
        CS.GameGlobal.Instance:ResetGame()
      end)
    else
      m_currWolrdData = response.dirWorld.worldInfo
      callback(response)
    end
  end, function(response)
    SetTimeoutCheck()
  end)
end

function ShowWorldWindow(successCallback)
  local function call()
    HideAroundWidget()
    
    if successCallback ~= nil then
      successCallback()
    end
    this:SetData("CurrentWorld", m_currWolrdData)
  end
  
  if m_currWolrdData == nil then
    RequestDir(call)
  else
    call()
  end
end

function UpdateCurrentWorld(world)
  if world then
    if m_autoLogin then
      m_autoLogin = false
    end
    this:SetData("worldId", world.worldId)
    CS.NativeInterface.External_ReportWorldId(world.worldId)
    CS.Restifizer.RestifizerManager.Instance.GameServerUrl = world.fciUrl
    CS.Restifizer.RestifizerManager.Instance.PushServerUrl = world.pushUrl
    if world.matchUrl then
      CS.Restifizer.RestifizerManager.Instance.MatchServerUrl = world.matchUrl
    end
    if world.gmUrl then
      CS.Restifizer.RestifizerManager.Instance.GmServerUrl = world.gmUrl
    end
  end
end

function OnSetCurrentWorld(world)
  if world then
    UpdateCurrentWorld(world)
    local accountCache = this:GetData("accountCache")
    local socialEntry = ""
    if accountCache.socialEntry ~= nil then
      socialEntry = accountCache.socialEntry
    end
    local socialPlatform = 0
    if accountCache.socialPlatform ~= nil then
      socialPlatform = accountCache.socialPlatform
    end
    local clientBasicInfo = S:Get("ConfigDataManager").ClientBasicInfo()
    local loginData = _ENV["!"]({
      socialEntry = socialEntry,
      socialPlatform = socialPlatform,
      device = clientBasicInfo.device,
      deviceId = clientBasicInfo.deviceId,
      deviceType = clientBasicInfo.deviceType,
      channel = clientBasicInfo.channel,
      clientVersion = clientBasicInfo.clientVersion,
      systemSoftware = CS.UnityEngine.SystemInfo.operatingSystem
    })
    local wg = Msdk.WGPlatform.Instance
    loginData.installChannel = wg:WGGetChannelId()
    loginData.registerChannel = wg:WGGetRegisterChannelId()
    loginData.socialType = "msdk"
    loginData.realImei = CS.NativeInterface.External_GetIMEI()
    local reachability = CS.UnityEngine.Application.internetReachability
    if reachability == CS.UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
      loginData.network = "Cellular"
    end
    if reachability == CS.UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
      loginData.network = "WiFi"
    end
    loginData.telecom_oper = CS.NativeInterface.External_GetCarrier()
    loginData.token = CS.Restifizer.RestifizerManager.Instance:GetAccessToken()
    S:Get("PushService").LoginPushBegin(loginData, OnLoginPushEnd)
  end
end

function OnLoginPushEnd(succeed)
  if succeed then
    CS.PlatformManager.IsNeedWXAutoLogin = false
    CS.PlatformManager.IsNeedQQAutoLogin = false
    S:Get("IAPHandler").Refresh()
    REF.LoginBar.gameObject:SetActive(false)
    SaveTimeoutRecord(true)
    ForeFadeIn()
    this:BroadcastGameEvent("OnLoginNotify")
  else
    WU.ShowHintText(WU.GetString("WindowLogin_LoginFailed"))
    local accountCache = this:GetData("accountCache")
    ShowAccountAuthWindow(accountCache.accountEntry, accountCache.entryType, nil, nil, nil)
  end
end

function OnSetUserAgreement(agreement)
  REF.LabelAgreement.UILabel.text = agreement
end

function ShowActivationCode()
  REF.LoginBar.gameObject:SetActive(false)
  REF.ActivationCode.gameObject:SetActive(true)
end

function OnActivateClick()
  local activationCode = REF.ActivationCodeInput.UIInput.value
  if activationCode == nil or U.trim(activationCode) == "" then
    WU.ShowHintText(WU.GetString("Window_ActivateInputError"))
    return
  end
  local accountAuth = this:GetData("accountAuth")
  accountAuth.cdkey = activationCode
  local wireFormatTable = ProtobufT("ApiAuthInfo", accountAuth)
  this:AccountRequest("/Auth/"):AddHeader("Authorization", "AccountToken " .. this:GetData("account/loginAccountToken")):Post(wireFormatTable, OnAccountActivateResponse, OnAccountActivateFailed)
end

function OnActivateCloseClick()
  REF.ActivationCode.gameObject:SetActive(false)
  clearAccountCache()
  REF.LoginBar.gameObject:SetActive(true)
  REF.LastAccount.gameObject:SetActive(false)
  REF.SwitchAccount.gameObject:SetActive(true)
  REF.ButtonReturn.gameObject:SetActive(false)
end

function is_active(result, err_code)
  local errorCode = result[err_code] and result[err_code].code
  if errorCode ~= nil and errorCode == "Error_CDKEYNotActivation" then
    return true
  end
  return false
end

function OnAccountAuthFailed(result)
  if result ~= nil and (is_active(result, "error") or is_active(result, "notify")) then
    ShowActivationCode()
  end
  SetTimeoutCheck()
  clearAccountCache()
  SetInitUI()
  return false
end

function clearAccountCache()
  local accountCache = {}
  this:SetData("accountCache", accountCache)
  m_currWolrdData = nil
end

function SetTimeoutCheck()
  m_authFailTimes = m_authFailTimes + 1
  if m_authFailTimes >= m_reTryTimes then
    m_timeoutTimes = m_timeoutTimes + 1
    local sec = 10
    if 1 < m_timeoutTimes then
      sec = 300
    end
    local nowSpan = CS.System.DateTime.UtcNow - m_startTime
    m_endTimeStamp = nowSpan.TotalSeconds + sec
    SaveTimeoutRecord()
  end
end

function OnShowActivationCode(param)
  m_isFromAuthWindow = true
  ShowActivationCode()
end

function OnAccountActivateResponse(response)
  local accountCache = this:GetData("accountCache")
  local accountAuth = this:GetData("accountAuth")
  accountCache.accountId = response.accountId
  accountCache.openId = response.openId
  accountCache.accessToken = response.tokenAccess
  accountCache.expireTime = response.createTime + response.expireSeconds
  accountCache.localeId = CS.ConfigDataManager.Instance.CurrentDynamicConfig.Id
  if m_isFromAuthWindow then
    accountCache.accountEntry = accountAuth.entry
    accountCache.entryType = accountAuth.entryType
    this:SetData("accountCache", accountCache)
    this:BroadcastGameEvent("OnAccountAuthSuccess")
  else
    accountCache.accountEntry = response.socialNickName
    accountCache.entryType = response.entryType
    accountCache.socialEntry = accountAuth.entry
    accountCache.socialPlatform = accountAuth.socialPlatform
    accountCache.realnameFlag = response.realnameFlag
    this:SetData("accountCache", accountCache)
    if response.needPop then
      WU.ShowMessageOK(WU.GetString("Platform_RealNameHint"))
    end
    if m_msdkLoginCallback ~= nil then
      m_msdkLoginCallback()
      m_msdkLoginCallback = nil
    end
  end
  m_isFromAuthWindow = false
  REF.ActivationCode.gameObject:SetActive(false)
  WU.ShowHintText(WU.GetString("Window_ActivateSuccess"))
end

function OnAccountActivateFailed(result)
  if result ~= nil and (is_active(result, "error") or is_active(result, "notify")) then
    WU.ShowHintText(WU.GetString("Error_YouMustInputExistCDKey"))
  end
  return false
end

function ShowNotice(scene)
  local noticeData = Msdk.WGPlatform.Instance:WGGetNoticeData(scene)
  if noticeData == nil then
    TryPopDeviceMemoryHint()
    return
  end
  local list = _ENV["!"](noticeData:ToArray())
  if table.empty(list) then
    TryPopDeviceMemoryHint()
    return
  end
  local notice = list[1]
  if notice == nil then
    TryPopDeviceMemoryHint()
    return
  end
  if notice.content_type ~= 0 then
    Msdk.WGPlatform.Instance:WGShowNotice(scene)
    return
  end
  WU.AcquireWindowAsync("NoticeMessage", function(ui)
    _ENV["$"](ui)["$$ShowNotice"](notice.msg_title, notice.msg_content)
    _ENV["$"](ui)["$$SetDestoryCallback"](function()
      TryPopDeviceMemoryHint()
    end)
  end)
end

function ShowLicense()
  WU.AcquireWindowAsync("LicenseMessage", function(window)
    _ENV["$"](window)["$$SetDestoryCallback"](function()
      m_isAcceptLicense = m_configDataManager.GetPreferences().isAcceptLicense
      UpdateLicenseTick()
    end)
  end)
end

function ShowLicenseNotAgree()
  WU.ShowHintText(WU.GetString("TXLicense_is_not_ticked"))
end

function UpdateLicenseTick()
  REF.ToggleLicense.gameObject:SetActive(true)
  if m_isAcceptLicense then
    REF.ToggleLicense.UISprite.spriteName = "checkbox_s"
  else
    REF.ToggleLicense.UISprite.spriteName = "checkbox_n"
  end
end

function OnLicenseTick()
  m_isAcceptLicense = not m_isAcceptLicense
  local preferences = m_configDataManager.GetPreferences()
  preferences.isAcceptLicense = m_isAcceptLicense
  m_configDataManager.SetPreferences(preferences)
  UpdateLicenseTick()
end

function OnClickUserProtocolLabel()
  local contractUrl = PB.all("MsdkUrl"):first().UserProtocol
  WU.OpenUrl(contractUrl)
end

function OnClickPrivacyPolicyLabel()
  local contractUrl = PB.all("MsdkUrl"):first().PrivacyPolicyUrlGuide
  WU.OpenUrl(contractUrl)
end

function TryPopDeviceMemoryHint()
  local preferences = m_configDataManager.GetPreferences()
  local hasCheckMemory = preferences.hasCheckMemory
  if hasCheckMemory then
    return
  end
  local ram = CS.NativeInterface.External_GetDeviceMemory()
  info("Detecting device RAM", ram)
  if ram < 1600000000 then
    WU.ShowMessageWithNoButton(WU.GetString("System_Low_Memory_Device_Android"))
    return
  end
  if ram < 2800000000 then
    WU.ShowMessageOK(WU.GetString("System_Low_Memory_Device"))
  end
  preferences.hasCheckMemory = true
  m_configDataManager.SetPreferences(preferences)
end

function OnGetKingCardStatus(isKingCard)
  if not m_isSwitchingToCity and isKingCard then
    WU.ShowHintText(WU.GetString("Platform_IsKingCard"))
  end
end
