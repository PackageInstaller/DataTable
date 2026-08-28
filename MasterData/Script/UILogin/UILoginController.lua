local View = require("UILogin/UILoginView")
local DataModel = require("UILogin/UILoginDataModel")
local Controller = {}
local CtrlAccountDestroy = require("UILogin/Controller/UILogin_AccountDestroyController")
local CtrlQQGroup = require("UILogin/Controller/UILogin_QQGroupController")
local CtrlDataLink = require("UILogin/Controller/UILogin_DataLinkController")
local CtrlLogout = require("UILogin/Controller/UILogin_LogoutController")

function Controller:InitView(ViewFunction)
  self.ViewFunction = ViewFunction
  local isCN = SdkRuntimeSetting.IsRegionCN()
  local isKR = SdkRuntimeSetting.IsRegionKR()
  local isDmm = SdkHelper.IsChannelDmm()
  local isPC = PlatformHelper.IsPC()
  if isPC and not isDmm then
    local nowX1 = View.Group_Account.Btn_Logout:GetAnchoredPositionX()
    local nowX2 = View.Group_Account.Btn_Notice:GetAnchoredPositionX()
    local nowX3 = View.Group_Account.Btn_Restore:GetAnchoredPositionX()
    local nowX4 = View.Group_Account.Btn_Link:GetAnchoredPositionX()
    local nowX5 = View.Group_Account.Btn_QQ:GetAnchoredPositionX()
  end
  View.Btn_AgeTip:SetActive(isCN or isKR)
  View.Txt_Tips:SetActive(isCN)
  CtrlAccountDestroy:InitView()
  CtrlQQGroup:InitView()
  CtrlDataLink:InitView()
  CtrlLogout:InitView()
  self:InitBtnLogout()
  self:InitBtnCommunity()
  self:InitBtnCustomerService()
  self:HandleKRFeature()
end

function Controller:InitBtnLogout()
  if SdkChannelHelper.IsCurSteam() then
    View.Group_Account.Btn_Logout:SetActive(false)
  end
end

function Controller:HandleKRFeature()
  if SdkRegionHelper.IsRegionKR() == false then
    return
  end
  SdkReporter.TrackAppAgree()
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.SetCallbackSdkViewShownChanged, function(isShown)
    self:OnSdkViewShownChanged(isShown)
  end)
end

function Controller:OnSdkViewShownChanged(isShown)
  local btnShow = not isShown
  View.Group_Account.Btn_Logout:SetActive(btnShow)
  View.Group_Account.Btn_Notice:SetActive(btnShow)
  View.Group_Account.Btn_Community:SetActive(btnShow)
  View.Group_Account.Btn_CustomerService:SetActive(btnShow)
end

function Controller.Tip1(contentID, yesTxtID, noTxtID, yesFunc, noFunc)
  local tip = View.Group_Tip1
  tip.Txt_Prompt:SetText(GetText(contentID))
  tip.Btn_Confirm.Txt_Confirm:SetText(GetText(yesTxtID))
  tip.Btn_Cancel.Txt_Cancel:SetText(GetText(noTxtID))
  DataModel.yesFunc = yesFunc
  DataModel.noFunc = noFunc
  
  function DataModel.CloseTip()
    tip:SetActive(false)
  end
  
  tip:SetActive(true)
end

function Controller.Tip2(content, yesTxtID, yesFunc)
  local tip = View.Group_Tip2
  tip.Txt_Prompt:SetText(content)
  tip.Btn_Confirm.Txt_Confirm:SetText(GetText(yesTxtID))
  DataModel.yesFunc = yesFunc
  
  function DataModel.CloseTip()
    tip:SetActive(false)
  end
  
  tip:SetActive(true)
end

local function Callback2Main()
  MapNeedleData.SetNeedleData()
  MapNeedleEventData.SetEventData()
  if MapNeedleEventData.IsLoginChangeNeedleEventScene() then
    MapSessionManager:InvokeNeedleEvent(MapNeedleEventData.event)
    return
  end
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.FirstLogin)
  CommonTips.OpenLoadingCB(function()
    CBus:ChangeScene("Main")
  end)
end

local UIDownloadDataModel

local function SetDownloadingState(IsDownloading, IsRetry)
  if UIDownloadDataModel == nil then
    UIDownloadDataModel = require("UIDownload/UIDownloadDataModel")
  end
  if UIDownloadDataModel ~= nil then
    UIDownloadDataModel.IsDownloading = IsDownloading
    UIDownloadDataModel.IsRetry = IsRetry
  end
end

function Controller.ChangeScene2Main()
  local IsGuideAsset = GameSetting.IsGuideAsset ~= nil and DownloadAndPlayController.IsGuideAsset
  if IsGuideAsset and GameSetting.GuideAssetVersion ~= nil and GameSetting.GuideAssetVersion == "2" then
    local tConfig = CS.SplitPackageController.ReadHotfixConfigBinary()
    local networkState = DownloadAndPlayController.GetNetworkState()
    if tConfig ~= nil then
      local tab = {}
      for key, value in pairs(tConfig) do
        tab[key] = value
      end
      tConfig = tab
    end
    if tConfig ~= nil and tConfig.IsDownloading ~= nil then
      if tConfig.IsDownloading and networkState == 2 then
        DownloadAndPlayController.Init()
        
        function DownloadAndPlayController.failCallback()
          SetDownloadingState(false, true)
        end
        
        DownloadAndPlayController.CompareFile()
        DownloadAndPlayController.StartDownload(function()
        end)
        SetDownloadingState(true, false)
        Callback2Main()
      else
        DownloadAndPlayController.SetDownloadingValue(false)
        SetDownloadingState(false, false)
        Callback2Main()
      end
    else
      if networkState == 0 then
        SetDownloadingState(false, false)
        Callback2Main()
        return
      end
      DownloadAndPlayController.Init()
      
      function DownloadAndPlayController.failCallback()
        SetDownloadingState(false, true)
      end
      
      local msg = DownloadAndPlayController.CompareFile()
      msg = string.gsub(DownloadAndPlayController.GetText(30), "%%d", msg)
      if networkState == 1 then
        msg = msg .. "\\n<color=red>" .. DownloadAndPlayController.GetText(31) .. "</color>"
      end
      CommonTips.OnPrompt(msg, DownloadAndPlayController.GetText(6), DownloadAndPlayController.GetText(7), function()
        DownloadAndPlayController.StartDownload(function()
        end)
        SetDownloadingState(true, false)
        Callback2Main()
      end, function()
        DownloadAndPlayController.SetDownloadingValue(false)
        SetDownloadingState(false, false)
        Callback2Main()
      end)
    end
  else
    if GameSetting.IsGuideAsset ~= nil then
      SetDownloadingState(false, false)
    end
    Callback2Main()
  end
end

function Controller.Enter(username)
  if CBus.currentScene == "Login" then
    View.Btn_Enter.self:SetActive(true)
    local Group_Account = View.Group_Account
    Group_Account.self:SetActive(true)
    Group_Account.Group_Text.Txt_Account:SetText(username)
  end
end

function Controller.SetBtnUserCenterAndServices(active)
  View.Group_Account.Btn_UserCenter:SetActive(active)
  View.Group_Account.Btn_Service:SetActive(active)
end

function Controller:SetActiveBtnUserCenter(active)
  View.Group_Account.Btn_UserCenter:SetActive(active)
end

function Controller:SetActiveBtnServices(active)
  View.Group_Account.Btn_Service:SetActive(active)
end

function Controller:OpenServices()
  SdkHelper.Services("not logged in", nil)
end

function Controller:OpenUserCenter()
  SdkHelper.UserCenter("not logged in", nil)
end

function Controller:GetPlayerUID()
  return PlayerData:GetUserInfo().uid
end

function Controller:TryLogin()
  if DataLinkLoginHelper.IsUseDataLinkLogin() then
    View.Group_LoginAndJoin:SetActive(false)
    DataLinkLoginHelper.TryAutoDataLinkLoginNormal()
    return true
  end
  if EmailLoginHelper.IsUseEmailLogin() then
    View.Group_LoginAndJoin:SetActive(false)
    EmailLoginHelper.TryEmailLogin()
    return true
  end
  if LoginHelper.IsUseChannelLogin() then
    LoginHelper.ReqChannelInfoIndex()
    return true
  end
  return false
end

function Controller:TryEnterGame()
  if EmailLoginHelper.IsUseEmailLogin() or DataLinkLoginHelper.IsUseDataLinkLogin() then
    LoginHelper.ReqMainIndex()
    return true
  end
  if LoginHelper.IsUseChannelLogin() then
    LoginHelper.ReqChannelMainIndex()
    return true
  end
  return false
end

function Controller:TryLogout()
  if DataLinkLoginHelper.IsUseDataLinkLogin() then
    DataLinkLoginHelper.DataLinkLogout()
  end
  if EmailLoginHelper.IsUseEmailLogin() then
    EmailLoginHelper.Logout()
    View.Group_Account.Group_Text.Txt_Account:SetText("")
    return true
  end
  if LoginHelper.IsUseChannelLogin() then
    if SdkHelper.IsChannelUjoy() then
      SdkHelper.TryLogout()
    end
    LoginHelper.Logout()
    View.Group_Account.Group_Text.Txt_Account:SetText("")
    if PlatformHelper.IsPC() and SdkChannelHelper.IsCurHaoplay() then
      LoginHelper.StartChannelLogin()
    end
    return true
  end
  return false
end

function Controller:StartOfficialLogin()
  if self.ViewFunction ~= nil then
    self.ViewFunction.Login_Btn_Login_Click()
  end
end

function Controller:ClickLoginBtnEnter()
  if self.ViewFunction ~= nil then
    self.ViewFunction.Login_Btn_Enter_Click()
  end
end

function Controller.OnBtnAccountUnregister()
  CommonTips.OnPrompt(80602043, 80600068, 80600067, function()
    LoginHelper.RegAccountUnregister()
  end, nil, false)
end

function Controller:OnRecvIndex(json)
  local isFail = json.rc and json.rc ~= ""
  if isFail then
    return
  end
  if json.is_register and json.is_register == 1 then
    SdkHelper.IsNeedReportRegister = true
    if LoginViewHelper.IsShowChannelLoginLanguageOptions() then
      UIManager:Open("UI/Setting/LanguageOptions", nil)
    end
  end
end

function Controller:OnRecvMainIndexCheck(json)
  if json.server_close and json.server_close == 1 then
    CommonTips.OpenTips(json.msg)
    return false
  end
  if Net.CheckClientVersionWithRepJson(json) == false then
    return false
  end
  PlayerData.ServerData = json
  local questDownload = PlayerData:GetFactoryData(99900001).questDownload
  local IsGuideAsset = GameSetting.IsGuideAsset ~= nil and DownloadAndPlayController.IsGuideAsset
  if IsGuideAsset and questDownload ~= nil and questDownload ~= "" and PlayerData.GetQuestState(questDownload) == EnumDefine.EQuestState.Receive then
    UIManager:Open("UI/Download/Download", Json.encode({IsGameIn = false}))
    return false
  end
  return true
end

function Controller:OnRecvMainIndex(json)
  local isFailed = json.rc and json.rc ~= ""
  if isFailed then
    return
  end
  local StoreDataModel = require("UIStore/UIStoreDataModel")
  StoreDataModel.SetStoreRedState()
  local uid = self:GetPlayerUID()
  SdkReporter.TrackEnterGame(uid)
  SdkHelper.TrackRegister3({
    propertiesDict = nil,
    registerType = SdkConst.default,
    isSuccess = not isFailed,
    account = uid
  })
  SdkHelper.TrackLogin3({
    propertiesDict = nil,
    loginType = SdkConst.default,
    isSuccess = not isFailed,
    account = uid
  })
  PayHelper.InitCsMgr()
  LoginHelper.OnEnterGame()
  local UIMainUIDataModel = require("UIMainUI/UIMainUIDataModel")
  UIMainUIDataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
  local HomeMapDataModel = require("UIHome/UIHomeMapDataModel")
  HomeMapDataModel.InitLineInfo()
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  TradeDataModel.lastStopDistance = TradeDataModel.GetRemainDistanceStop()
  local repeatData = {}
  local totalValue = 0
  for k, v in pairs(PlayerData.CaptainSkinSystem:GetAllSkinData()) do
    if not repeatData[v.id] then
      repeatData[v.id] = true
      local skinCfg = PlayerData:GetFactoryData(v.id, "HomeCharacterSkinFactory")
      totalValue = totalValue + skinCfg.fashion
    end
  end
  PlayerData:GetUserInfo().fashion = totalValue
end

function Controller:TryFixPCMonitorGuideClickProblem()
  if not PlatformHelper.IsPC() then
    return
  end
  local playerLevel = PlayerData:GetPlayerLevel()
  local forceGuideLevel = 11
  if playerLevel == nil or playerLevel >= forceGuideLevel then
    return
  end
  GraphicsHelper.SetDefaultScreenResolutionWithFullscreen()
end

function Controller:OnBtnAgeTip()
  local isKR = SdkRegionHelper.IsRegionKR()
  if isKR then
    return
  end
  View.Group_AgeTip.self:SetActive(true)
end

function Controller:GetBtnCommunity()
  return View.Group_Account.Btn_Community
end

function Controller:InitBtnCommunity()
  local isShow = self:IsKR() or SdkRegionHelper.IsRegionUS()
  if not isShow then
    return
  end
  local Btn_Community = self:GetBtnCommunity()
  if Btn_Community == nil then
    return
  end
  Btn_Community:SetActive(true)
  if self:IsPC() then
    local nowX = Btn_Community:GetAnchoredPositionX()
  end
end

function Controller:OnBtnCommunity()
  SdkHelper.Community()
end

function Controller:GetBtnCustomerService()
  return View.Group_Account.Btn_CustomerService
end

function Controller:InitBtnCustomerService()
  local isShow = self:IsKR() or SdkRegionHelper.IsRegionUS()
  if not isShow then
    return
  end
  local Btn_CustomerService = self:GetBtnCustomerService()
  if Btn_CustomerService == nil then
    return
  end
  Btn_CustomerService:SetActive(true)
  if self:IsPC() then
    local nowX = Btn_CustomerService:GetAnchoredPositionX()
  end
end

function Controller:OnBtnCustomerService()
  SdkHelper.Services()
end

function Controller:IsKR()
  return SdkRegionHelper.IsRegionKR()
end

function Controller:IsPC()
  return PlatformHelper.IsPC()
end

return Controller
