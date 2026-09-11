local LoginRender = class("LoginRender", ReduxView)

function LoginRender:UIName()
	return "Widget/System/LoginInterface/LoginInterface"
end

function LoginRender:UIParent()
	return manager.ui.uiMain.transform
end

function LoginRender:Init()
	self:InitUI()
end

local var_0_1 = false

function LoginRender:InitUI()
	self:BindCfgUI()

	local var_4_0 = GameToSDK.CURRENT_SERVER

	self.isOverSeas_ = GameToSDK.CURRENT_SERVER ~= nil and var_4_0 ~= "" and var_4_0 ~= "zh_cn"
	self.myID = PlayerPrefs.GetString("AccountID")

	self:UpdateAccount(self.myID)

	_G.isLogining = false
	self.serverList_ = {
		{
			port = 8102,
			text = "本地服",
			host = "127.0.0.1"
		}
	}
	self.currentServerIndex_ = 1

	if not SDKTools.IsSDK() then
		self.serverList_ = require("lua_exclude/innerLoginList"):GetLoginList()

		self:AddBtnListener(self.btn_innerServer, nil, function()
			gameContext:Go("LoginInnerServer", {
				list = self.serverList_
			})
		end)

		self.currentServerIndex_ = tonumber(PlayerPrefs.GetString("SelectServer")) or 1

		if not self.serverList_[self.currentServerIndex_] then
			self.currentServerIndex_ = table.keys(self.serverList_)[1]
		end

		self:UpdateInnerServer()
	end

	self:RefreshState()

	self.versionName_.text = "VersionName: " .. LuaForUtil.GetResourceVersionName()
	self.clientVersion_.text = "ClientVersion: " .. LuaForUtil.GetClientVersion()
	self.resourceVersion_.text = "ResourceVersion: " .. LuaForUtil.GetResourceVersion()
	self.battleVersion_.text = "BattleVersion: " .. LuaForUtil.GetBattleVersion()
	_G.bulletinInfoGetted = false

	GameToSDK.SendMessage("{\"messageType\" : \"GetAgeTip\"}")
	self:WaitForBulletin()

	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criplayer_:SetVolume((manager.audio:GetEffectVolume()))
	print("server", GameToSDK.CURRENT_SERVER)
	print("serverList", GameToSDK.SERVER_LIST)
	DealAreaDifferenceCfg(GameToSDK.CURRENT_SERVER)

	local var_4_1 = GameToSDK.SERVER_LIST.Length

	SetActive(self.selectRegion_.gameObject, GameToSDK.SERVER_LIST.Length > 1)
	self:AddOperationListener()
	self:AddBtnListenerScale(self.startupBtn_, nil, handler(self, self.TryToLoginIn))
	self:AddBtnListener(self.deleteFolderBtn_, nil, function()
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
	self:AddBtnListener(nil, self.btn_exit, function()
		ShowQuitConfirm()
	end)
	self:AddBtnListener(self.levelBtn_, nil, function()
		manager.ui:SetUISeparateRender(false)
		SetActive(self.ageLimitGo_, true)
	end)
	self:AddBtnListener(self.ageLimitOkBtn_, nil, function()
		SetActive(self.ageLimitGo_, false)
	end)
	self:AddBtnListener(self.ageLimitBgBtn_, nil, function()
		SetActive(self.ageLimitGo_, false)
	end)

	if SDKTools.GetIsOverSea() then
		SetActive(self.appDescBtnClickNode_, false)
	else
		SetActive(self.appDescBtnClickNode_, true)
		self:AddBtnListener(self.appDescBtn_, nil, function()
			OperationAction.OpenNormalUrl(GameSetting.record_miit_url.value[1])
		end)
	end

	if var_4_1 > 1 then
		local var_4_2 = 0

		for iter_4_0 = 0, var_4_1 - 1 do
			if GameToSDK.CURRENT_SERVER == GameToSDK.SERVER_LIST[iter_4_0] then
				var_4_2 = iter_4_0
			end

			self.selectRegion_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(AreaDifferenceCfg[GameToSDK.SERVER_LIST[iter_4_0]].name))
		end

		self.selectRegion_:RefreshShownValue()

		self.selectRegion_.value = var_4_2

		self.selectRegion_.onValueChanged:AddListener(function(arg_14_0)
			if arg_14_0 ~= var_4_2 then
				ShowMessageBox({
					content = GetTips("CHANGE_SERVER"),
					OkCallback = function()
						PlayerPrefs.SetInt("SERVER_DEFAULT_SELECT_INDEX", arg_14_0)
						Quit()
					end,
					CancelCallback = function()
						self.selectRegion_.value = var_4_2
					end
				})
			end
		end)
	end

	self.serverMaintainController = self.m_controller:GetController("serverMaintain")
	self.serverShowController = self.m_controller:GetController("serverShow")
	self.serverNewTagController = self.m_controller:GetController("serverNewTag")

	self.serverShowController:SetSelectedIndex(0)
	self:AddBtnListener(self.m_serverBtn, nil, function()
		JumpTools.OpenPageByJump("loginSeverSelectPop")
	end)
end

function LoginRender:AddOperationListener()
	self:AddBtnListener(self.suggestBtn_, nil, function()
		if GameToSDK.IsPCPlatform() then
			OperationAction.OpenOperationUrlBeforeLogin("PC_FEEDBACK")
		else
			SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
		end
	end)
	self:AddBtnListener(self.sdkBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
	end)
	self:AddBtnListener(self.anncBtn_, nil, function()
		if _G.bulletinInfoGetted then
			self:ShowWebView()
		end
	end)
	self:AddBtnListener(self.forumBtn_, nil, function()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			OperationAction.OpenOperationUrlBeforeLogin("FORUM_URL", {
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			})
		else
			OperationAction.OpenOperationUrlBeforeLogin("FORUM_URL_HOME")
		end

		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 1
		})
	end)
end

function LoginRender:OnEnter()
	gameContext:SetSystemLayer("login")

	_G.isLogining = false
	self.params_.isAutoLogin = true

	LoadingUIManager.inst:CloseLoadUI()
	Timer.New(function()
		GameToSDK.SendMessage("{\"messageType\" : \"GetBulletin\"}")
	end, 1, 1):Start()
	self:RegistEventListener(AGE_TIP_CALLBACK, function(arg_25_0)
		print("AGE_TIP_CALLBACK")

		self.ageLimitText_.text = arg_25_0
	end)
end

function LoginRender:OnExit()
	LuaForCursor.UseSystemCursor(false)
	self.selectRegion_.onValueChanged:RemoveAllListeners()
	self:RemoveAllEventListener()

	var_0_1 = false
end

function LoginRender:WaitForBulletin()
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
					self:ShowWebView()
					self:SDKLogin()
					self:AddUIListener()
				end, 0.6, 1):Start()
			end
		end, 0.1, -1)

		;(nil):Start()
	end
end

function LoginRender:AddUIListener()
	self:AddBtnListener(self.imageBtn_, nil, function()
		if _G.SELECT_REGION_SEVER_ID == nil then
			self:QueryRegionSeverInfo()

			return
		end

		if not EvokeGateWayLogin(_G.SELECT_REGION_SEVER_ID) then
			self:SDKLogin()
		end
	end)
end

function LoginRender:SDKLogin()
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

function LoginRender:QueryRegionSeverInfo()
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

			if isNil(self.gameObject_) then
				return
			end

			self:UpdateRegionServer()
		else
			print("RegionServerLog QueryRegionSeverInfo fail")
			ShowTips(arg_35_1)
		end
	end)
end

function LoginRender:UpdateRegionServer()
	local var_36_0 = RegionServerMgr.instance:GetRegionServerInfoList()

	if var_36_0.Count == 0 then
		self.serverShowController:SetSelectedIndex(0)
		Debug.LogError("RegionServerLog server list count = 0")

		return
	end

	if _G.SELECT_REGION_SEVER_ID and isNil(RegionServerMgr.instance:GetRegionServerInfo(_G.SELECT_REGION_SEVER_ID)) then
		_G.SELECT_REGION_SEVER_ID = nil
	end

	if var_36_0.Count == 1 then
		_G.SELECT_REGION_SEVER_ID = var_36_0[0].serverId

		self.serverShowController:SetSelectedIndex(0)
	else
		if GetSDKLoginInfo() == nil then
			self.serverShowController:SetSelectedIndex(0)
		else
			self.serverShowController:SetSelectedIndex(1)
		end

		if _G.SELECT_REGION_SEVER_ID == nil then
			local var_36_1 = PlayerPrefs.GetString("RegionServerId", "")

			if var_36_1 == "" or isNil(RegionServerMgr.instance:GetRegionServerInfo(var_36_1)) then
				local var_36_2
				local var_36_3
				local var_36_4 = RegionServerMgr.instance:GetRegionServerInfoList()

				for iter_36_0 = 0, var_36_4.Count - 1 do
					if var_36_4[iter_36_0].gameUserInfoList.Count > 0 then
						var_36_3 = var_36_4[iter_36_0].serverId
					end

					if var_36_4[iter_36_0].newServerFlag == 1 then
						var_36_2 = var_36_4[iter_36_0].serverId
					end
				end

				_G.SELECT_REGION_SEVER_ID = var_36_3 ~= nil and var_36_3 or var_36_2 ~= nil and var_36_2 or var_36_4[0].serverId
			else
				_G.SELECT_REGION_SEVER_ID = var_36_1
			end
		end
	end

	local var_36_5 = RegionServerMgr.instance:GetRegionServerInfo(_G.SELECT_REGION_SEVER_ID)

	if var_36_5 then
		self.m_serverName.text = var_36_5.serverName or "null"
	end

	if var_36_5 and not var_36_5.maintain then
		self.serverMaintainController:SetSelectedIndex(0)
	else
		self.serverMaintainController:SetSelectedIndex(1)
	end

	if var_36_5 and var_36_5.newServerFlag ~= 1 then
		self.serverNewTagController:SetSelectedIndex(0)
	else
		self.serverNewTagController:SetSelectedIndex(1)
	end
end

function LoginRender:ShowWebView()
	return
end

function LoginRender:RefreshState()
	local var_38_0 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV

	SetActive(self.btn_server_, GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV)
	SetActive(self.btn_account_, var_38_0)
	SetActive(self.btn_start_, var_38_0)

	local var_38_1 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 0 or _G.CHANNEL_MASTER_ID == 15

	if self.isOverSeas_ then
		SetActive(self.levelBtn_.gameObject, false)
		SetActive(self.forumGo_, true)

		if SDKTools.GetIsThisServer({
			"tw",
			"jp",
			"en"
		}) then
			SetActive(self.forumGo_, false)
		end

		if SDKTools.GetIsThisServer({
			"tw"
		}) then
			-- block empty
		end
	else
		SetActive(self.levelBtn_.gameObject, true)
		SetActive(self.suggestGo_, var_38_1)
		SetActive(self.sdkGo_, var_38_1)
		SetActive(self.forumGo_, var_38_1)
	end

	SetActive(self.deleteFolderGo_, false)
end

function LoginRender:TryToLoginIn()
	if string.len((tostring(self:GetAccount()))) < 1 then
		ShowTips("IF_ACCOUNT_NIL")

		return
	end

	GATEWAY_ADDR = self.serverList_[self.currentServerIndex_].ip
	GATEWAY_PORT = self.serverList_[self.currentServerIndex_].port

	PlayerPrefs.SetString("SelectServer", self.currentServerIndex_)
	PlayerPrefs.SetString("AccountID", self:GetAccount())
	CheckVersion(function()
		manager.net.gateWayConnection_.netStatus = "none"

		LoginAction.GateWayLogin(self:GetAccount(), self:GetPassword())
	end)
end

function LoginRender:PlayOut()
	manager.audio:StopEffect()
	manager.messageBox:HideAll()
	self:CheckDefaultSetting()
end

function LoginRender:SetSDKId()
	if self.isOverSeas_ and _G.TMP_ACCOUNT_ID then
		self.sdkIdText_.text = "SDKID:" .. _G.TMP_ACCOUNT_ID
	end

	LuaForCursor.UseSystemCursor(false)
	print("RegionServerLog query info")
	self:QueryRegionSeverInfo()
end

function LoginRender:CheckDefaultSetting()
	PlayerTools.UpdateRandomDataAfterLogin(HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN)

	if SettingData:NewDevice() then
		self:Go("/graphicRecommend", {
			callback = handler(self, self.OnGraphicQualitySelect)
		})
	else
		self:AwakeName()
	end
end

function LoginRender:OnGraphicQualitySelect(arg_44_1, arg_44_2)
	SettingData:SetQualitied()
	SettingAction.ChangePicSetting("picOptionId", arg_44_2)
	self:AwakeName()
end

function LoginRender:AwakeName()
	CheckNewGuide()
	manager.uiTime:StartUITimer()
end

function LoginRender:UpdateAccount(arg_46_1, arg_46_2)
	self.txtAccount_.text = arg_46_1
	self.pwd_ = arg_46_2
end

function LoginRender:GetAccount()
	return self.txtAccount_.text
end

function LoginRender:GetPassword()
	return self.pwd_ or PlayerPrefs.GetString("UserPwd")
end

function LoginRender:UpdateInnerServer()
	self.m_innerServerLab.text = self.serverList_[self.currentServerIndex_] ~= nil and self.serverList_[self.currentServerIndex_] ~= false and (self.serverList_[self.currentServerIndex_].name == "本地服务器" and self.serverList_[self.currentServerIndex_].name or self.serverList_[self.currentServerIndex_].name .. "（" .. self.serverList_[self.currentServerIndex_].branch .. "）") or self.serverList_[self.currentServerIndex_]
end

function LoginRender:Cacheable()
	return false
end

function LoginRender:Dispose()
	self:RemoveAllListeners()

	var_0_1 = false

	LoginRender.super.Dispose(self)
end

function LoginRender:OnExitInput()
	if GameToSDK.IsPCPlatform() and GameToSDK.IsSDKUIShowing() then
		return false
	end

	ShowQuitConfirm()

	return true
end

function LoginRender:OnLoginSeverUpdate()
	self:UpdateRegionServer()
end

return LoginRender
