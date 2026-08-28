local View = require("UILogin/UILoginView")
local Net = require("Net/Net")
local DataModel = require("UILogin/UILoginDataModel")
local Controller = require("UILogin/UILoginController")
local QQGroupCtrl = require("UILogin/Controller/UILogin_QQGroupController")
local CtrlDataLink = require("UILogin/Controller/UILogin_DataLinkController")

local function IsValidateInputAccountRegister(input)
  if input:GetLength() == 0 then
    CommonTips.OpenTips(GetText(80600024))
    return false
  end
  if input:GetLength() < 6 then
    CommonTips.OpenTips(GetText(80600027))
    return false
  end
  return true
end

local function IsValidateInputPasswordRegister(input)
  if input:GetLength() == 0 then
    CommonTips.OpenTips(GetText(80600025))
    return false
  end
  if input:GetLength() < 6 then
    CommonTips.OpenTips(GetText(80600028))
    return false
  end
  return true
end

local function IsValidateInputAccountLogin(input)
  if input:GetLength() == 0 then
    CommonTips.OpenTips(GetText(80600024))
    return false
  end
  if PlayerData.ShowCMD(input:GetText()) then
    return false
  end
  if input:GetLength() < 6 then
    CommonTips.OpenTips(GetText(80600030))
    return false
  end
  return true
end

local function IsValidateInputPasswordLogin(input)
  if input:GetLength() == 0 then
    CommonTips.OpenTips(GetText(80600025))
    return false
  end
  if input:GetLength() < 6 then
    CommonTips.OpenTips(GetText(80600030))
    return false
  end
  return true
end

local function LoginOrJoin(isLogin)
  local Group_LoginAndJoin = View.Group_LoginAndJoin
  Group_LoginAndJoin.Group_Login.self:SetActive(isLogin)
  Group_LoginAndJoin.Group_Join.self:SetActive(not isLogin)
  if not isLogin then
    Group_LoginAndJoin.Group_Join.InputField_Account.self:SetText("")
    Group_LoginAndJoin.Group_Join.InputField_Password.self:SetText("")
  end
end

local function SetPlayerPrefs(username, access_token, openid, isVisitor, password)
  local row = {
    username = username,
    access_token = access_token,
    openid = openid,
    password = password or View.Group_LoginAndJoin.Group_Join.InputField_Password:GetText()
  }
  local list = DataModel.GetAccountList()
  if list ~= "" and table.count(list) == DataModel.IsMaxData then
    table.remove(list, DataModel.IsMaxData)
  end
  local setList = {}
  if list ~= "" then
    for k, v in pairs(list) do
      if v.username == username then
        table.remove(list, k)
      end
    end
    table.insert(list, 1, row)
    setList = list
  else
    local accountList = {}
    table.insert(accountList, 1, row)
    setList = accountList
  end
  PlayerPrefs.SetString("AccountList", Json.encode(setList))
  if isVisitor then
    PlayerPrefs.SetString("usernameVisitor", username)
    PlayerPrefs.SetString("access_tokenVisitor", access_token)
    PlayerPrefs.SetString("openidVisitor", openid)
  end
end

local function Enter(username)
  if CBus.currentScene == "Login" then
    View.Btn_Enter.self:SetActive(true)
    local Group_Account = View.Group_Account
    Group_Account.self:SetActive(true)
    View.Group_Account.Btn_Notice.self:SetActive(PlayerData.pid ~= nil)
    if GameSetting.PhoneIDLogin then
      local NewLoginDataModel = require("UINewLogin/UINewLoginDataModel")
      username = NewLoginDataModel.FormatPhoneID(username)
    end
    Group_Account.Group_Text.Txt_Account:SetText(username)
  end
end

local function OpenNewLogin(showPhoneID)
  UIManager:Open("UI/Login/NewLogin", showPhoneID, function()
    local phoneIDList = PlayerPrefs.GetString("PhoneIDList")
    View.Group_Account.Group_Text.Txt_Account:SetText("")
    View.Group_Account.Btn_Notice.self:SetActive(PlayerData.pid ~= nil)
    if phoneIDList ~= "" then
      local phoneIDList = Json.decode(phoneIDList)
      if phoneIDList[1] then
        local NewLoginDataModel = require("UINewLogin/UINewLoginDataModel")
        local username = NewLoginDataModel.FormatPhoneID(phoneIDList[1].username)
        View.Group_Account.Group_Text.Txt_Account:SetText(username)
      end
    end
  end)
end

local function InfoAndIndex(username, isNotUser, autologin)
  View.Group_LoginAndJoin.self:SetActive(isNotUser)
  local info = ProtocolFactory:CreateProtocol(ProtocolType.Info)
  info.accessToken = PlayerData.access_token
  info.openId = PlayerData.pid
  info:SetCallback(function(res3)
    local json3 = Json.decode(res3)
    print_r("ProtocolType.Info")
    print_r(json3)
    PlayerData.ServerData = {}
    PlayerData.ServerData.server_now = json3.server_now
    PlayerData.NoticeAddress = json3.notice_address
    local rc = json3.rc
    if rc and rc ~= "" then
      SdkReporter.TrackLogin(false)
      Controller.Tip2(json3.msg, "80600068", function()
        if GameSetting.PhoneIDLogin then
          OpenNewLogin("showPhoneID")
          return
        end
        CBus:Logout(1)
      end)
      return
    end
    local index = ProtocolFactory:CreateProtocol(ProtocolType.Index)
    PlayerData.serverTimeOffset = TimeTool.UnixTimeStamp() - json3.server_now
    index.accessToken = PlayerData.access_token
    index.openId = PlayerData.pid
    index.timestamp = TimeTool.UnixTimeStamp() - PlayerData.serverTimeOffset
    index.platform = PlayerData.platform
    if UseGSDK then
      index.deviceId = GSDKManager.AppService.DeviceID
    end
    if GameSetting.PhoneIDLogin then
      index.deviceId = DeviceHelper.GetDeviceId()
    end
    index.autoLogin = autologin or 0
    LoginHelper.BeforeSendIndex(index, "oc")
    index:SetCallback(function(res4)
      local json4 = Json.decode(res4)
      Controller:OnRecvIndex(json4)
      print_r("ProtocolType.index")
      print_r(json4)
      rc = json4.rc
      if rc and rc ~= "" then
        SdkReporter.TrackLogin(false)
        Controller.Tip2(json4.msg, "80600068", function()
          if GameSetting.PhoneIDLogin then
            OpenNewLogin("showPhoneID")
            return
          end
          CBus:Logout(1)
        end)
        return
      end
      LoginHelper.AfterRecvIndex(json4, "oc")
      SdkReporter.TrackLogin(true)
      local timezone = string.sub(json4.timezone, 4, 6)
      PlayerData.TimeZone = tonumber(timezone)
      PlayerData.ServerTimeZoneOffset = (PlayerData.TimeZone - TimeUtil:GetLocalTimeZone()) * 3600 or 0
      PlayerData.RemoteId = json4.remote_id
      if UseGSDK then
        PlayerData.pid = json4.pid
      end
      Enter(username)
      if GameSetting.AdministrationsAddictionFeature and table.count(json4.real_info) == 0 then
        CommonTips.OpenAntiAddiction({index = 1})
        return
      end
      if PlayerData:GetNoPrompt("logintNotice", 1, false) == false then
        CommonTips.OpenNoticeLogin()
        PlayerData:SetNoPrompt("logintNotice", 1, true, false)
      end
    end)
    ServerConnectManager:Add(index)
  end)
  ServerConnectManager:Add(info)
end

local isGSDKLogInOver = false

local function GSDKLoginCallback()
  isGSDKLogInOver = true
  local username = PlayerPrefs.GetString("username")
  PlayerData.access_token = PlayerPrefs.GetString(username .. "access_token")
  PlayerData.pid = PlayerPrefs.GetString(username .. "openid")
  InfoAndIndex(username)
end

local recordIsLogin = false

local function LoginCancelCallback()
  isGSDKLogInOver = true
  recordIsLogin = false
  View.Group_LoginAndJoin.self:SetActive(false)
  View.Btn_Enter:SetActive(true)
end

local function SetAgree(isAgree)
  local open = 0
  if isAgree then
    open = 1
  end
  PlayerPrefs.SetInt("IsAgree", open)
  View.Group_Toggle.Toggle_Agree.self:SetIsOn(isAgree)
end

local function SetToggle(isActive)
  local toggle = View.Group_Toggle
  toggle.self:SetActive(isActive)
  View.Btn_Enter:SetActive(true)
  if isActive then
    local open = PlayerPrefs.GetInt("IsAgree")
    SetAgree(open == 1)
    if GSDKManager.AppService.ChannelOp == "bsdk" then
      toggle.TextHyperlink_Link:SetText(GetText(80600184) .. " <a href=https://sf3-cdn-tos.douyinstatic.com/obj/ies-hotsoon-draft/GSDK/user_contract_newdomain.html>" .. GetText(80600185) .. "</a> " .. GetText(80600186) .. " <a href=https://lf26-cdn-tos.draftstatic.com/obj/ies-hotsoon-draft/GSDK/e7dd33f3-05c3-47b7-9989-d77b909f67e9.html>" .. GetText(80600187) .. "</a>")
    else
      toggle.TextHyperlink_Link:SetTextCallback(GetText(80600184) .. " <a href=0>" .. GetText(80600185) .. "</a> " .. GetText(80600186) .. " <a href=1>" .. GetText(80600187) .. "</a>", function()
        GSDKManager:GetUserAgreement()
      end, function()
        GSDKManager:GetPrivacyAgreement()
      end)
    end
  end
end

local function Login2Server()
  if GameSetting.IsBanApp then
    CommonTips.OnPromptConfirmOnly(80600026, 80600068, function()
      CS.GameSetting.Quit()
    end)
    return
  end
  local Group_LoginAndJoin = View.Group_LoginAndJoin
  local Group_Account = View.Group_Account
  if Controller:TryLogin() then
    return
  end
  if GameSetting.PhoneIDLogin then
    local phoneIDList = PlayerPrefs.GetString("PhoneIDList")
    recordIsLogin = PlayerPrefs.GetInt("IsAgree") == 1 and phoneIDList ~= ""
    if recordIsLogin == false then
      View.Group_LoginAndJoin:SetActive(false)
      OpenNewLogin()
    else
      local phoneIDList = Json.decode(phoneIDList)
      local account = phoneIDList[1]
      PlayerData.access_token = account.access_token or " "
      PlayerData.pid = account.openid or " "
      InfoAndIndex(account.username, false, 1)
      Group_LoginAndJoin:SetActive(false)
    end
    Group_Account.Btn_UserCenter:SetActive(false)
    Group_Account.Btn_Service:SetActive(false)
    View.Group_Account.Btn_Notice.self:SetActive(PlayerData.pid ~= nil)
    return
  end
  recordIsLogin = not UseGSDK or PlayerPrefs.GetInt("IsAgree") == 1
  if recordIsLogin then
    Group_Account.Btn_UserCenter:SetActive(UseGSDK and GSDKManager:IsAvailable("gsdk_api_open_user_center"))
    Group_Account.Btn_Service:SetActive(UseGSDK)
    if UseGSDK then
      if isGSDKLogInOver == false then
        return
      end
      Group_LoginAndJoin.self:SetActive(true)
      Group_LoginAndJoin.Img_BG.self:SetActive(false)
      Group_LoginAndJoin.Group_Login.self:SetActive(false)
      Group_LoginAndJoin.Group_Join.self:SetActive(false)
      Group_Account.self:SetActive(false)
      View.Btn_Enter:SetActive(false)
      isGSDKLogInOver = false
      GSDKManager:OpenLoginPanel(GSDKLoginCallback, LoginCancelCallback)
      return
    end
    local account = DataModel.GetAccountList(1)
    if account == "" then
      Group_LoginAndJoin.self:SetActive(true)
      Group_LoginAndJoin.Group_Join.self:SetActive(false)
      Group_LoginAndJoin.Group_Login.self:SetActive(true)
      Group_Account.self:SetActive(false)
      View.Btn_Enter.self:SetActive(false)
      View.self:SetRaycastBlock(false)
      View.self:PlayAnim("LoginToUI", function()
        View.self:SetRaycastBlock(true)
      end)
    end
    if account and account ~= "" and account.username ~= "" then
      PlayerData.access_token = account.access_token
      PlayerData.pid = account.openid
      InfoAndIndex(account.username, false, 1)
    end
  elseif UseGSDK then
    Group_LoginAndJoin.self:SetActive(false)
    Group_LoginAndJoin.Img_BG.self:SetActive(false)
    Group_LoginAndJoin.Group_Login.self:SetActive(false)
    Group_LoginAndJoin.Group_Join.self:SetActive(false)
    Group_Account.self:SetActive(false)
  end
end

local function Register(name, password, isVisitor)
  local username = name
  local passwd = password
  local register
  if isVisitor then
    register = ProtocolFactory:CreateProtocol(ProtocolType.VisitorAccount)
  else
    register = ProtocolFactory:CreateProtocol(ProtocolType.Register)
  end
  username = string.lower(username)
  if not isVisitor then
    View.Group_LoginAndJoin.Group_Login.InputField_Account.self:SetText(username)
  end
  register.username = username
  register.password1 = passwd
  register.password2 = passwd
  register:SetCallback(function(res1)
    local json1 = Json.decode(res1)
    local isFailed = json1.rc and json1.rc ~= ""
    SdkHelper.TrackRegister2(nil, SdkConst.default, not isFailed)
    if json1.rc and json1.rc ~= "" then
      CommonTips.OpenTips(json1.msg)
      return
    end
    PlayerData.access_token = json1.access_token
    PlayerData.pid = json1.openid
    local login
    if isVisitor then
      login = ProtocolFactory:CreateProtocol(ProtocolType.VisitorLogin)
      username = json1.username
      passwd = "000000"
    else
      login = ProtocolFactory:CreateProtocol(ProtocolType.Login)
    end
    login.username = username
    login.password = passwd
    login:SetCallback(function(res2)
      local json2 = Json.decode(res2)
      local isFailed = json1.rc and json1.rc ~= ""
      SdkHelper.TrackLogin2(nil, SdkConst.default, not isFailed)
      if json2.rc and json2.rc ~= "" then
        CommonTips.OpenTips(json2.msg)
        return
      end
      
      local function cbLanguageOptions()
        InfoAndIndex(username, true)
        SetPlayerPrefs(username, json2.access_token, json2.openid, isVisitor, password)
        View.Btn_Login.self:SetActive(false)
        View.self:SetRaycastBlock(false)
        View.self:PlayAnim("LoginToUI1", function()
          View.Group_LoginAndJoin.self:SetActive(false)
          View.self:SetRaycastBlock(true)
        end)
      end
      
      cbLanguageOptions()
    end)
    ServerConnectManager:Add(login)
  end)
  ServerConnectManager:Add(register)
end

local ViewFunction = {
  Login_Btn_Login_Click = function(btn, str)
    Debug.Log("[Login]Login_Btn_Login_Click")
    DataModel.IsDown = true
    DataModel.ChangeButtonState()
    SetToggle(UseGSDK or false)
    isGSDKLogInOver = true
    PlayerData.GetNotice(function()
      Login2Server()
    end)
  end,
  Login_Group_LoginAndJoin_Group_Login_Btn_Login_Click = function(btn, str)
    local InputField_Account = View.Group_LoginAndJoin.Group_Login.InputField_Account.self
    local InputField_Password = View.Group_LoginAndJoin.Group_Login.InputField_Password.self
    if IsValidateInputAccountLogin(InputField_Account) and IsValidateInputPasswordLogin(InputField_Password) then
      local login = ProtocolFactory:CreateProtocol(ProtocolType.Login)
      local username = InputField_Account:GetText()
      username = string.lower(username)
      InputField_Account:SetText(username)
      login.username = username
      login.password = InputField_Password:GetText()
      print_r("ProtocolType.Login")
      login:SetCallback(function(res2)
        local json2 = Json.decode(res2)
        if json2.rc and json2.rc ~= "" then
          CommonTips.OpenTips(json2.msg)
          return
        end
        PlayerData.access_token = json2.access_token
        PlayerData.pid = json2.openid
        InfoAndIndex(username, true)
        SetPlayerPrefs(username, json2.access_token, json2.openid, false, InputField_Password:GetText())
        DataModel.IsDown = true
        DataModel.ChangeButtonState()
        View.Btn_Login.self:SetActive(false)
        View.self:SetRaycastBlock(false)
        View.self:PlayAnim("LoginToUI1", function()
          View.Group_LoginAndJoin.self:SetActive(false)
          View.self:SetRaycastBlock(true)
        end)
      end)
      ServerConnectManager:Add(login)
    end
  end,
  Login_Group_LoginAndJoin_Group_Login_Btn_Join_Click = function(btn, str)
    LoginOrJoin(false)
  end,
  Login_Group_LoginAndJoin_Group_Join_Btn_Join_Click = function(btn, str)
    local InputField_Account = View.Group_LoginAndJoin.Group_Join.InputField_Account.self
    local InputField_Password = View.Group_LoginAndJoin.Group_Join.InputField_Password.self
    if IsValidateInputAccountRegister(InputField_Account) and IsValidateInputPasswordRegister(InputField_Password) then
      local username = InputField_Account:GetText()
      local passwd = InputField_Password:GetText()
      Register(username, passwd, false)
    end
  end,
  Login_Group_LoginAndJoin_Group_Join_Btn_Back_Click = function(btn, str)
    LoginOrJoin(true)
  end,
  Login_Group_Account_Btn_Logout_Click = function(btn, str)
    Debug.Log("[Login]Login_Group_Account_Btn_Logout_Click")
    LoginHelper.BeforeLogoutInLogin()
    if Controller:TryLogout() then
      return
    end
    SdkReporter.TrackLogout()
    if GameSetting.PhoneIDLogin then
      View.Group_LoginAndJoin:SetActive(false)
      OpenNewLogin()
      return
    end
    if UseGSDK then
      PlayerData:Logout()
      return
    end
    local Group_LoginAndJoin = View.Group_LoginAndJoin
    Group_LoginAndJoin.self:SetActive(true)
    Group_LoginAndJoin.Group_Join.self:SetActive(false)
    Group_LoginAndJoin.Group_Login.self:SetActive(true)
    View.Group_Account.self:SetActive(false)
    View.Btn_Enter.self:SetActive(false)
    View.self:SetRaycastBlock(false)
    View.self:PlayAnim("LoginToUI", function()
      View.self:SetRaycastBlock(true)
    end)
    local account = DataModel.GetAccountList(1)
    if account and account.username ~= "" then
      Group_LoginAndJoin.Group_Login.InputField_Account.self:SetText(account.username)
    end
    DataModel.IsDown = true
    DataModel.ChangeButtonState()
  end,
  Login_Btn_Enter_Click = function(btn, str)
    Debug.Log("[Login]Login_Btn_Enter_Click")
    if Controller:TryEnterGame() then
      return
    end
    if UseGSDK and View.Group_Toggle.Toggle_Agree.self:IsOn() == false then
      CommonTips.OpenTips(80600188, false)
      return
    end
    if GameSetting.PhoneIDLogin then
      local phoneIDList = PlayerPrefs.GetString("PhoneIDList")
      if phoneIDList == "" or PlayerData.pid == " " then
        Login2Server()
        return
      end
    end
    local isSelectPrivacy = recordIsLogin
    if LoginHelper.IsSelectPrivacy() then
      isSelectPrivacy = true
    end
    if isSelectPrivacy == false then
      Login2Server()
      return
    end
    local main = ProtocolHelper.CreateProtocolMainIndex()
    main:SetCallback(function(res)
      local json = Json.decode(res)
      PlayerData.MultiMissionRefreshAll = true
      PlayerData.RechargeGoods = nil
      print_r("main.index")
      print_r(json)
      if json.rc and json.rc ~= "" and (json.rc ~= "80610000" and json.rc ~= "80610001" or not GameSetting.AdministrationsAddictionFeature) then
        Controller.Tip2(json.msg, "80600068", function()
          if GameSetting.PhoneIDLogin then
            OpenNewLogin("showPhoneID")
          else
            CBus:Logout(1)
          end
        end)
        return
      end
      if Controller:OnRecvMainIndexCheck(json) == false then
        return
      end
      json.rc = nil
      PlayerData.ServerData = json
      if json.material_num then
        local UIBattle_MaterialDataModel = require("UIBattle_Material/UIBattle_MaterialDataModel")
        UIBattle_MaterialDataModel:SetCurrentNum(json.material_num)
      end
      if json.equip_day_num then
        local UIBattle_EquipmentDayDataModel = require("UIBattle_EquipmentDay/UIBattle_EquipmentDayDataModel")
        UIBattle_EquipmentDayDataModel:SetCurrentNum(json.equip_day_num)
      end
      if json.equip_week_num then
        local UIBattle_EquipmentWeekDataModel = require("UIBattle_EquipmentWeek/UIBattle_EquipmentWeekDataModel")
        UIBattle_EquipmentWeekDataModel:SetCurrentNum(json.equip_week_num)
      end
      if json.pollute_areas then
        PlayerData:RefrshPolluteLines(json.pollute_areas)
      end
      if json.multi_battle_pass then
        PlayerData:RefreshCurrentMultiBattleIds()
      end
      local time = TimeUtil:GetFutureTime(0, 20)
      PlayerData.online_time = json.server_now - time
      local grow = 0
      if GameSetting.AdministrationsAddictionFeature then
        if table.count(PlayerData:GetUserInfo().real_info) == 0 then
          CommonTips.OpenAntiAddiction({index = 1})
          return
        end
        grow = PlayerData:IsCheckYearOld(PlayerData:GetUserInfo().real_info.id_card)
        local time = tonumber(os.date("%H", TimeUtil:GetServerTimeStamp()))
        local date_time = tostring(os.date("%Y-%m-%d", TimeUtil:GetServerTimeStamp()))
        PlayerData.AdministrationsAddictionHolidays = false
        for k, v in pairs(PlayerData:GetFactoryData(99900013).holidayList) do
          if date_time == v.day then
            PlayerData.AdministrationsAddictionHolidays = true
          end
        end
        if grow < 18 then
          if PlayerData.AdministrationsAddictionHolidays == true then
            if 21 <= time or time < 20 then
              CommonTips.OpenAntiAddiction({index = 3})
              return
            else
              local residue_time
              residue_time = 3600 - PlayerData.online_time
              if 0 < residue_time then
                CommonTips.OpenAntiAddiction({index = 4, time = residue_time}, function()
                  Controller.ChangeScene2Main()
                  require("UIAntiAddiction/AntiaddictionTime").AddOnSecondEvent()
                end)
              end
              if residue_time <= 0 then
                CommonTips.OpenAntiAddiction({index = 6}, function()
                  CBus:NewLogout()
                end)
                return
              end
            end
          else
            CommonTips.OpenAntiAddiction({index = 3})
            return
          end
        end
      end
      PlayerData:GetAllRoleAwakeRed()
      PlayerData:GetAwakeEquipRed()
      Net.Callback(res, nil)
      PlayerData:ResetTempCache()
      local coachInfos = PlayerData:GetHomeInfo().coach_template
      PlayerData:GetHomeInfo().coach = {}
      for k, v in pairs(coachInfos) do
        local uid = v
        local coachInfo = PlayerData:GetHomeInfo().coach_store[uid]
        table.insert(PlayerData:GetHomeInfo().coach, coachInfo)
      end
      PlayerData:SetPanelTriggerGuide()
      QuestTrace.AddOpenPanelCallBack()
      PlayerData.HandleMainIndex()
      PlayerData:SetChapterLevelTable()
      PlayerData:SetSortChapterLevelTable()
      GameSetting:LoadPlayerSetting()
      DataModel.SetSoundLanguage()
      Controller:OnRecvMainIndex(json)
      if UseGSDK then
        local info = PlayerData:GetGameUploadInfo()
        GSDKManager:EnterGameUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
        local order = tonumber(PlayerData:GetUserInfo().older or 1)
        local is_user_first = 0
        if order == 0 then
          local info = PlayerData:GetGameUploadInfo()
          GSDKManager:CreateNewRoleUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
          is_user_first = 1
        end
      end
      if UseGSDK and GSDKManager.AppService.ChannelOp == "bsdk" then
        PlayerData:VerifyRealName(function()
          Controller.ChangeScene2Main()
        end)
      end
      if not GameSetting.AdministrationsAddictionFeature or 18 <= grow then
        Controller.ChangeScene2Main()
      end
      return
    end)
    ServerConnectManager:Add(main)
  end,
  Login_Btn_AgeTip_Click = function(btn, str)
    Controller:OnBtnAgeTip()
  end,
  Login_Group_AgeTip_Btn_BG_Click = function(btn, str)
    View.Group_AgeTip.self:SetActive(false)
  end,
  Login_Group_AgeTip_Btn_Confirm_Click = function(btn, str)
    View.Group_AgeTip.self:SetActive(false)
  end,
  Login_Group_Account_Btn_UserCenter_Click = function(btn, str)
    Controller:OpenUserCenter()
  end,
  Login_Group_Tip1_Btn_BG_Click = function(btn, str)
  end,
  Login_Group_Tip1_Btn_Confirm_Click = function(btn, str)
    if DataModel.yesFunc then
      DataModel.yesFunc()
      DataModel.CloseTip()
    end
  end,
  Login_Group_Tip1_Btn_Cancel_Click = function(btn, str)
    if DataModel.noFunc then
      DataModel.noFunc()
      DataModel.CloseTip()
    end
  end,
  Login_Group_Tip2_Btn_BG_Click = function(btn, str)
  end,
  Login_Group_Tip2_Btn_Confirm_Click = function(btn, str)
    if DataModel.yesFunc then
      DataModel.yesFunc()
      DataModel.CloseTip()
    end
  end,
  Login_Group_Toggle_Toggle_Agree_Toggle = function(toggle, value)
    local open = 0
    if value then
      open = 1
    end
    PlayerPrefs.SetInt("IsAgree", open)
  end,
  Login_Video_Login_Skip_Click = function(btn, str)
  end,
  Login_Group_LoginAndJoin_Img_BG_Btn_Visitor_Click = function(btn, str)
    local username = PlayerPrefs.GetString("usernameVisitor")
    if username ~= "" then
      PlayerData.access_token = PlayerPrefs.GetString("access_tokenVisitor")
      PlayerData.pid = PlayerPrefs.GetString("openidVisitor")
      SetPlayerPrefs(username, PlayerData.access_token, PlayerData.pid)
      InfoAndIndex(username)
    else
      Register("", "", true)
    end
  end,
  Login_Group_LoginAndJoin_Group_Login_Btn_Down_Click = function(btn, str)
    DataModel.IsDown = false
    DataModel.ChangeButtonState()
  end,
  Login_Group_LoginAndJoin_Group_Login_Btn_Up_Click = function(btn, str)
    DataModel.IsDown = true
    DataModel.ChangeButtonState()
  end,
  Login_Group_LoginAndJoin_Group_Login_ScrollGrid_AccountList_SetGrid = function(element, elementIndex)
    local row = DataModel.GetAccountList(elementIndex)
    element.Btn_Bg.Txt_Name:SetText(row.username)
    element.Btn_Bg:SetClickParam(elementIndex)
    element.Btn_Close:SetClickParam(elementIndex)
  end,
  Login_Group_LoginAndJoin_Group_Login_ScrollGrid_AccountList_Group_Item_Btn_Bg_Click = function(btn, str)
    local row = DataModel.GetAccountList()
    local now = DataModel.GetAccountList(tonumber(str))
    local InputField_Account = View.Group_LoginAndJoin.Group_Login.InputField_Account.self
    local InputField_Password = View.Group_LoginAndJoin.Group_Login.InputField_Password.self
    local username = InputField_Account:GetText()
    if username ~= now.username then
      InputField_Account:SetText(now.username)
      InputField_Password:SetText(now.password)
      table.remove(row, tonumber(str))
      table.insert(row, 1, now)
      PlayerPrefs.SetString("AccountList", Json.encode(row))
    end
    DataModel.IsDown = true
    DataModel.ChangeButtonState()
  end,
  Login_Group_LoginAndJoin_Group_Login_ScrollGrid_AccountList_Group_Item_Btn_Close_Click = function(btn, str)
    local row = DataModel.GetAccountList()
    local now = DataModel.GetAccountList(tonumber(str))
    table.remove(row, tonumber(str))
    PlayerPrefs.SetString("AccountList", Json.encode(row))
    local InputField_Account = View.Group_LoginAndJoin.Group_Login.InputField_Account.self
    local InputField_Password = View.Group_LoginAndJoin.Group_Login.InputField_Password.self
    local username = InputField_Account:GetText()
    if username == now.username then
      InputField_Account:SetText("")
      InputField_Password:SetText("")
    end
    DataModel.IsDown = true
    DataModel.ChangeButtonState()
  end,
  Login_Group_LoginAndJoin_Group_Login_Btn_CloseUp_Click = function(btn, str)
    DataModel.IsDown = true
    DataModel.ChangeButtonState()
  end,
  Login_Group_Account_Btn_Service_Click = function(btn, str)
    Controller:OpenServices()
  end,
  Login_Group_Account_Btn_Restore_Click = function(btn, str)
    CommonTips.OnPrompt(80602000, 80600068, 80600067, function()
      CBus:Restore()
    end, nil, false)
  end,
  Login_Group_Account_Btn_Cancel_Click = function(btn, str)
    Controller.OnBtnAccountUnregister()
  end,
  Login_Group_Account_Btn_Notice_Click = function(btn, str)
    CommonTips.OpenNoticeLogin()
  end,
  Login_Group_Account_Btn_QQ_Click = function(btn, str)
    QQGroupCtrl:OpenView()
  end,
  Login_Group_QQ_Btn_Close_Click = function(btn, str)
    QQGroupCtrl:CloseView()
  end,
  Login_Group_QQ_ScrollGrid_QQ_SetGrid = function(element, elementIndex)
    QQGroupCtrl:OnSetGrid(element, elementIndex)
  end,
  Login_Group_QQ_ScrollGrid_QQ_Group_Item_Btn_Join_Click = function(btn, str)
    QQGroupCtrl:OnItemClick(btn, str)
  end,
  Login_Group_LoginAndJoin_Img_BG_Btn_Restore_Click = function(btn, str)
    CommonTips.OnPrompt(80602000, 80600068, 80600067, function()
      CBus:Restore()
    end, nil, false)
  end,
  Login_Group_Account_Btn_Link_Click = function(btn, str)
    CtrlDataLink:OpenDataLink()
  end,
  Login_Group_Account_Btn_Community_Click = function(btn, str)
    Controller:OnBtnCommunity()
  end,
  Login_Group_Account_Btn_CustomerService_Click = function(btn, str)
    Controller:OnBtnCustomerService()
  end
}
return ViewFunction
