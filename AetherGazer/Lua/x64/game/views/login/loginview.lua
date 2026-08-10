local var_0_0 = class("LoginRender", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/LoginInterface"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

local var_0_1 = false

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	local var_4_0 = GameToSDK.CURRENT_SERVER

	arg_4_0.isOverSeas_ = var_4_0 ~= nil and var_4_0 ~= "" and var_4_0 ~= "zh_cn"
	arg_4_0.myID = PlayerPrefs.GetString("AccountID")

	arg_4_0:UpdateAccount(arg_4_0.myID)

	_G.isLogining = false
	arg_4_0.serverList_ = {
		{
			port = 8102,
			text = "本地服",
			host = "127.0.0.1"
		}
	}
	arg_4_0.currentServerIndex_ = 1

	if not SDKTools.IsSDK() then
		arg_4_0.serverList_ = require("lua_exclude/innerLoginList"):GetLoginList()

		arg_4_0:AddBtnListener(arg_4_0.btn_innerServer, nil, function()
			gameContext:Go("LoginInnerServer", {
				list = arg_4_0.serverList_
			})
		end)

		arg_4_0.currentServerIndex_ = tonumber(PlayerPrefs.GetString("SelectServer")) or 1

		if not arg_4_0.serverList_[arg_4_0.currentServerIndex_] then
			arg_4_0.currentServerIndex_ = table.keys(arg_4_0.serverList_)[1]
		end

		arg_4_0:UpdateInnerServer()
	end

	arg_4_0:RefreshState()

	arg_4_0.versionName_.text = "VersionName: " .. LuaForUtil.GetResourceVersionName()
	arg_4_0.clientVersion_.text = "ClientVersion: " .. LuaForUtil.GetClientVersion()
	arg_4_0.resourceVersion_.text = "ResourceVersion: " .. LuaForUtil.GetResourceVersion()
	arg_4_0.battleVersion_.text = "BattleVersion: " .. LuaForUtil.GetBattleVersion()
	_G.bulletinInfoGetted = false

	GameToSDK.SendMessage("{\"messageType\" : \"GetAgeTip\"}")
	arg_4_0:WaitForBulletin()

	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player

	local var_4_1 = manager.audio:GetEffectVolume()

	arg_4_0.criplayer_:SetVolume(var_4_1)
	print("server", GameToSDK.CURRENT_SERVER)
	print("serverList", GameToSDK.SERVER_LIST)
	DealAreaDifferenceCfg(GameToSDK.CURRENT_SERVER)

	local var_4_2 = GameToSDK.SERVER_LIST.Length

	SetActive(arg_4_0.selectRegion_.gameObject, var_4_2 > 1)
	arg_4_0:AddOperationListener()
	arg_4_0:AddBtnListenerScale(arg_4_0.startupBtn_, nil, handler(arg_4_0, arg_4_0.TryToLoginIn))
	arg_4_0:AddBtnListener(arg_4_0.deleteFolderBtn_, nil, function()
		if _G.isLogining then
			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("VERIFY_ASSETS_BEFORE_CONFIRM"),
			OkCallback = function()
				JumpTools.OpenPageByJump("repairAssetsView")
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.btn_exit, function()
		ShowQuitConfirm()
	end)
	arg_4_0:AddBtnListener(arg_4_0.levelBtn_, nil, function()
		manager.ui:SetUISeparateRender(false)
		SetActive(arg_4_0.ageLimitGo_, true)
	end)
	arg_4_0:AddBtnListener(arg_4_0.ageLimitOkBtn_, nil, function()
		SetActive(arg_4_0.ageLimitGo_, false)
	end)
	arg_4_0:AddBtnListener(arg_4_0.ageLimitBgBtn_, nil, function()
		SetActive(arg_4_0.ageLimitGo_, false)
	end)

	if SDKTools.GetIsOverSea() then
		SetActive(arg_4_0.appDescBtnClickNode_, false)
	else
		SetActive(arg_4_0.appDescBtnClickNode_, true)
		arg_4_0:AddBtnListener(arg_4_0.appDescBtn_, nil, function()
			OperationAction.OpenNormalUrl(GameSetting.record_miit_url.value[1])
		end)
	end

	if var_4_2 > 1 then
		local var_4_3 = 0

		for iter_4_0 = 0, var_4_2 - 1 do
			if GameToSDK.CURRENT_SERVER == GameToSDK.SERVER_LIST[iter_4_0] then
				var_4_3 = iter_4_0
			end

			local var_4_4 = AreaDifferenceCfg[GameToSDK.SERVER_LIST[iter_4_0]]

			arg_4_0.selectRegion_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_4_4.name))
		end

		arg_4_0.selectRegion_:RefreshShownValue()

		arg_4_0.selectRegion_.value = var_4_3

		arg_4_0.selectRegion_.onValueChanged:AddListener(function(arg_14_0)
			if arg_14_0 ~= var_4_3 then
				ShowMessageBox({
					content = GetTips("CHANGE_SERVER"),
					OkCallback = function()
						PlayerPrefs.SetInt("SERVER_DEFAULT_SELECT_INDEX", arg_14_0)
						Quit()
					end,
					CancelCallback = function()
						arg_4_0.selectRegion_.value = var_4_3
					end
				})
			end
		end)
	end

	arg_4_0.serverMaintainController = arg_4_0.m_controller:GetController("serverMaintain")
	arg_4_0.serverShowController = arg_4_0.m_controller:GetController("serverShow")
	arg_4_0.serverNewTagController = arg_4_0.m_controller:GetController("serverNewTag")

	arg_4_0.serverShowController:SetSelectedIndex(0)
	arg_4_0:AddBtnListener(arg_4_0.m_serverBtn, nil, function()
		JumpTools.OpenPageByJump("loginSeverSelectPop")
	end)
end

function var_0_0.AddOperationListener(arg_18_0)
	arg_18_0:AddBtnListener(arg_18_0.suggestBtn_, nil, function()
		if GameToSDK.IsPCPlatform() then
			OperationAction.OpenOperationUrlBeforeLogin("PC_FEEDBACK")
		else
			SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
		end
	end)
	arg_18_0:AddBtnListener(arg_18_0.sdkBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
	end)
	arg_18_0:AddBtnListener(arg_18_0.anncBtn_, nil, function()
		if _G.bulletinInfoGetted then
			arg_18_0:ShowWebView()
		end
	end)
	arg_18_0:AddBtnListener(arg_18_0.forumBtn_, nil, function()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			local var_22_0 = {
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			}

			OperationAction.OpenOperationUrlBeforeLogin("FORUM_URL", var_22_0)
		else
			OperationAction.OpenOperationUrlBeforeLogin("FORUM_URL_HOME")
		end

		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 1
		})
	end)
end

function var_0_0.OnEnter(arg_23_0)
	gameContext:SetSystemLayer("login")

	_G.isLogining = false
	arg_23_0.params_.isAutoLogin = true

	LoadingUIManager.inst:CloseLoadUI()
	Timer.New(function()
		GameToSDK.SendMessage("{\"messageType\" : \"GetBulletin\"}")
	end, 1, 1):Start()
	arg_23_0:RegistEventListener(AGE_TIP_CALLBACK, function(arg_25_0)
		print("AGE_TIP_CALLBACK")

		arg_23_0.ageLimitText_.text = arg_25_0
	end)
end

function var_0_0.OnExit(arg_26_0)
	LuaForCursor.UseSystemCursor(false)
	arg_26_0.selectRegion_.onValueChanged:RemoveAllListeners()
	arg_26_0:RemoveAllEventListener()

	var_0_1 = false
end

function var_0_0.WaitForBulletin(arg_27_0)
	print("WaitForBulletin 开始监听公告信息返回")

	if SDKTools.IsSDK() then
		print("SDK 环境")

		local var_27_0 = 0
		local var_27_1

		var_27_1 = Timer.New(function()
			var_27_0 = var_27_0 + 1

			if _G.bulletinInfoGetted or var_27_0 > 30 then
				var_27_1:Stop()
				Timer.New(function()
					arg_27_0:ShowWebView()
					arg_27_0:SDKLogin()
					arg_27_0:AddUIListener()
				end, 0.6, 1):Start()
			end
		end, 0.1, -1)

		var_27_1:Start()
	end
end

function var_0_0.AddUIListener(arg_30_0)
	arg_30_0:AddBtnListener(arg_30_0.imageBtn_, nil, function()
		if _G.SELECT_REGION_SEVER_ID == nil then
			arg_30_0:QueryRegionSeverInfo()

			return
		end

		if not EvokeGateWayLogin(_G.SELECT_REGION_SEVER_ID) then
			arg_30_0:SDKLogin()
		end
	end)
end

function var_0_0.SDKLogin(arg_32_0)
	if _G.isLogining or _G.clickCDing_ then
		return
	end

	_G.clickCDing_ = true

	Debug.Log("唤起SDK登录")
	GameToSDK.Login("{}")
	SendMessageManagerToSDK("SDKLogin")
	TimeTools.StartAfterSeconds(5, function()
		_G.clickCDing_ = false
	end, {})
	LuaForCursor.UseSystemCursor(true)
end

function var_0_0.QueryRegionSeverInfo(arg_34_0)
	if var_0_1 then
		print("RegionServerLog QueryRegionSeverInfo fail by repeat")

		return
	end

	var_0_1 = true

	print("RegionServerLog QueryRegionSeverInfo start")
	RegionServerMgr.instance:UpdateRegionServerInfo(_G.TMP_ACCOUNT_ID or "", function(arg_35_0, arg_35_1)
		var_0_1 = false

		if arg_35_0 then
			print("RegionServerLog QueryRegionSeverInfo success")

			if isNil(arg_34_0.gameObject_) then
				return
			end

			arg_34_0:UpdateRegionServer()
		else
			print("RegionServerLog QueryRegionSeverInfo fail")
			ShowTips(arg_35_1)
		end
	end)
end

function var_0_0.UpdateRegionServer(arg_36_0)
	local var_36_0 = RegionServerMgr.instance:GetRegionServerInfoList()
	local var_36_1 = var_36_0.Count

	if var_36_1 == 0 then
		arg_36_0.serverShowController:SetSelectedIndex(0)
		Debug.LogError("RegionServerLog server list count = 0")

		return
	end

	if _G.SELECT_REGION_SEVER_ID and isNil(RegionServerMgr.instance:GetRegionServerInfo(_G.SELECT_REGION_SEVER_ID)) then
		_G.SELECT_REGION_SEVER_ID = nil
	end

	if var_36_1 == 1 then
		_G.SELECT_REGION_SEVER_ID = var_36_0[0].serverId

		arg_36_0.serverShowController:SetSelectedIndex(0)
	else
		if GetSDKLoginInfo() == nil then
			arg_36_0.serverShowController:SetSelectedIndex(0)
		else
			arg_36_0.serverShowController:SetSelectedIndex(1)
		end

		if _G.SELECT_REGION_SEVER_ID == nil then
			local var_36_2 = PlayerPrefs.GetString("RegionServerId", "")

			if var_36_2 == "" or isNil(RegionServerMgr.instance:GetRegionServerInfo(var_36_2)) then
				local var_36_3
				local var_36_4
				local var_36_5 = RegionServerMgr.instance:GetRegionServerInfoList()
				local var_36_6 = var_36_5.Count

				for iter_36_0 = 0, var_36_6 - 1 do
					local var_36_7 = var_36_5[iter_36_0]
					local var_36_8 = var_36_7.serverId
					local var_36_9 = var_36_7.newServerFlag

					if var_36_7.gameUserInfoList.Count > 0 then
						var_36_4 = var_36_8
					end

					if var_36_9 == 1 then
						var_36_3 = var_36_8
					end
				end

				if var_36_4 ~= nil then
					_G.SELECT_REGION_SEVER_ID = var_36_4
				elseif var_36_3 ~= nil then
					_G.SELECT_REGION_SEVER_ID = var_36_3
				else
					_G.SELECT_REGION_SEVER_ID = var_36_5[0].serverId
				end
			else
				_G.SELECT_REGION_SEVER_ID = var_36_2
			end
		end
	end

	local var_36_10 = RegionServerMgr.instance:GetRegionServerInfo(_G.SELECT_REGION_SEVER_ID)

	arg_36_0.m_serverName.text = var_36_10 and var_36_10.serverName or "null"

	if var_36_10 and not var_36_10.maintain then
		arg_36_0.serverMaintainController:SetSelectedIndex(0)
	else
		arg_36_0.serverMaintainController:SetSelectedIndex(1)
	end

	if var_36_10 and var_36_10.newServerFlag ~= 1 then
		arg_36_0.serverNewTagController:SetSelectedIndex(0)
	else
		arg_36_0.serverNewTagController:SetSelectedIndex(1)
	end
end

function var_0_0.ShowWebView(arg_37_0)
	return
end

function var_0_0.RefreshState(arg_38_0)
	local var_38_0 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV

	SetActive(arg_38_0.btn_server_, var_38_0)
	SetActive(arg_38_0.btn_account_, var_38_0)
	SetActive(arg_38_0.btn_start_, var_38_0)

	local var_38_1 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 0 or _G.CHANNEL_MASTER_ID == 15

	if arg_38_0.isOverSeas_ then
		SetActive(arg_38_0.levelBtn_.gameObject, false)
		SetActive(arg_38_0.forumGo_, true)

		if SDKTools.GetIsThisServer({
			"tw",
			"jp",
			"en"
		}) then
			SetActive(arg_38_0.forumGo_, false)
		end

		if SDKTools.GetIsThisServer({
			"tw"
		}) then
			-- block empty
		end
	else
		SetActive(arg_38_0.levelBtn_.gameObject, true)
		SetActive(arg_38_0.suggestGo_, var_38_1)
		SetActive(arg_38_0.sdkGo_, var_38_1)
		SetActive(arg_38_0.forumGo_, var_38_1)
	end

	SetActive(arg_38_0.deleteFolderGo_, false)
end

function var_0_0.TryToLoginIn(arg_39_0)
	local var_39_0 = tostring(arg_39_0:GetAccount())

	if string.len(var_39_0) < 1 then
		ShowTips("IF_ACCOUNT_NIL")

		return
	end

	GATEWAY_ADDR = arg_39_0.serverList_[arg_39_0.currentServerIndex_].ip
	GATEWAY_PORT = arg_39_0.serverList_[arg_39_0.currentServerIndex_].port

	PlayerPrefs.SetString("SelectServer", arg_39_0.currentServerIndex_)
	PlayerPrefs.SetString("AccountID", arg_39_0:GetAccount())
	CheckVersion(function()
		manager.net.gateWayConnection_.netStatus = "none"

		LoginAction.GateWayLogin(arg_39_0:GetAccount(), arg_39_0:GetPassword())
	end)
end

function var_0_0.PlayOut(arg_41_0)
	manager.audio:StopEffect()
	manager.messageBox:HideAll()
	arg_41_0:CheckDefaultSetting()
end

function var_0_0.SetSDKId(arg_42_0)
	if arg_42_0.isOverSeas_ and _G.TMP_ACCOUNT_ID then
		arg_42_0.sdkIdText_.text = "SDKID:" .. _G.TMP_ACCOUNT_ID
	end

	LuaForCursor.UseSystemCursor(false)
	print("RegionServerLog query info")
	arg_42_0:QueryRegionSeverInfo()
end

function var_0_0.CheckDefaultSetting(arg_43_0)
	PlayerTools.UpdateRandomDataAfterLogin(HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN)

	if SettingData:NewDevice() then
		arg_43_0:Go("/graphicRecommend", {
			callback = handler(arg_43_0, arg_43_0.OnGraphicQualitySelect)
		})
	else
		arg_43_0:AwakeName()
	end
end

function var_0_0.OnGraphicQualitySelect(arg_44_0, arg_44_1, arg_44_2)
	SettingData:SetQualitied()
	SettingAction.ChangePicSetting("picOptionId", arg_44_2)
	arg_44_0:AwakeName()
end

function var_0_0.AwakeName(arg_45_0)
	CheckNewGuide()
	manager.uiTime:StartUITimer()
end

function var_0_0.UpdateAccount(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0.txtAccount_.text = arg_46_1
	arg_46_0.pwd_ = arg_46_2
end

function var_0_0.GetAccount(arg_47_0)
	return arg_47_0.txtAccount_.text
end

function var_0_0.GetPassword(arg_48_0)
	return arg_48_0.pwd_ or PlayerPrefs.GetString("UserPwd")
end

function var_0_0.UpdateInnerServer(arg_49_0)
	local var_49_0 = arg_49_0.serverList_[arg_49_0.currentServerIndex_]

	if var_49_0 ~= nil and var_49_0 ~= false then
		if var_49_0.name == "本地服务器" then
			arg_49_0.m_innerServerLab.text = var_49_0.name
		else
			arg_49_0.m_innerServerLab.text = var_49_0.name .. "（" .. var_49_0.branch .. "）"
		end
	else
		arg_49_0.m_innerServerLab.text = var_49_0
	end
end

function var_0_0.Cacheable(arg_50_0)
	return false
end

function var_0_0.Dispose(arg_51_0)
	arg_51_0:RemoveAllListeners()

	var_0_1 = false

	var_0_0.super.Dispose(arg_51_0)
end

function var_0_0.OnExitInput(arg_52_0)
	if GameToSDK.IsPCPlatform() and GameToSDK.IsSDKUIShowing() then
		return false
	end

	ShowQuitConfirm()

	return true
end

function var_0_0.OnLoginSeverUpdate(arg_53_0)
	arg_53_0:UpdateRegionServer()
end

return var_0_0
