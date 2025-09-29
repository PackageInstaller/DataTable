-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginView.lua

module("logic.extensions.login.view.LoginView", package.seeall)

local OPEN_LIST_ANI = "open_list"
local OPEN_LOGO_ANI = "dl_logo"
local CLOSE_LIST_ANI = "close_list"
local LOGO_END_ANI = "on_enter_finish"
local kFailWaitTime = 3
local kRequestRemoteVersionTime = 1
local kRequestRemoteVersionMaxTime = 5
local kDelayShowLoginWinTime = 0.2
local M = class("LoginView", ViewComponent)

function M:ctor()
	self._serverName = nil
	self._btnServerBtn = nil
	self._btnEnterGame = nil
	self._isStartEnter = false
end

function M:buildUI()
	BootstrapLauncher.instance:destroyFlow()

	self._goServerRoot = goutil.findChild(self.mainGO, "later_panel/serverSelect").gameObject
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._goSdkLoginMask = self:getGo("login_start_view_1502373948")
	self._serverName = self:getText("login_start_view_98792471")
	self._serverStaticName = self:getText("login_start_view_-843984228")
	self._txtVersion = self:getText("login_start_view_1588693849")
	self._txtProtocol = self:getText("login_start_view_-1116230380")
	self._btnServerBtn = self:getBtn("login_start_view_272324106")
	self._btnEnterGame = self:getBtn("login_start_view_-716104025")
	self._btnEnterGameFullScreen = self:getBtn("login_start_view_-473518350")
	self._btnRepair = self:getBtn("login_start_view_-1141788511")
	self._btnAccount = self:getBtn("login_start_view_-1986343621")
	self._btnExitAccount = self:getBtn("login_start_view_-1033277740")
	self._btnNotice = self:getBtn("login_start_view_660487623")
	self._btnProtocol = self:getBtn("login_start_view_1118499356")
	self._btnPrivacy = self:getBtn("login_start_view_-186513761")
	self._btnHeath = self:getBtn("login_start_view_1389810079")
	self._toggleAgree = self:getUIComponent("login_start_view_-1593313873", UIComponentType.SpaceXToggle)
end

function M:onEnter()
	self:setEvent(true)
	self:initViewState()
	self:addHotUpdateListener()
	self:playEnterBGM()

	self._inEnterAni = true

	settimer(0, function()
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(OPEN_LOGO_ANI)
		settimer(kDelayShowLoginWinTime, self._delayGetSessionId, self, false)
	end, self, false)
end

local kShowTipsTime = 0

function M:showTempTips()
	if DeviceUtil.isEmulator() and kShowTipsTime == 0 then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), "模拟器版本暂不稳定，建议使用移动端进行体验。")

		dialog:setConfirmButtonText(lang("tip_common_sure"))

		kShowTipsTime = kShowTipsTime + 1

		return true
	end

	return false
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.LOGIN_GET_SERVER_LIST_EVENT, self._dealGetServerList, self)
		GlobalDispatcher:addEventListener(EventType.LOGIN_SDK_WINDOW_SHOW, self._dealSdkLoginWindowChange, self)
		KeycodeListener.instance:addEventListener(UnityEngine.KeyCode.Return, self._onKeyEnter, self)
		self._btnEnterGame:AddClickListener(self._dealEnterGame, self)
		self._btnEnterGameFullScreen:AddClickListener(self._dealEnterGame, self)
	else
		GlobalDispatcher:removeEventListener(EventType.LOGIN_GET_SERVER_LIST_EVENT, self._dealGetServerList, self)
		GlobalDispatcher:removeEventListener(EventType.LOGIN_SDK_WINDOW_SHOW, self._dealSdkLoginWindowChange, self)
		KeycodeListener.instance:removeEventListener(UnityEngine.KeyCode.Return, self._onKeyEnter, self)
		self._btnEnterGame:RemoveClickListener()
		self._btnEnterGameFullScreen:RemoveClickListener()
	end
end

function M:bindEvents()
	self._btnServerBtn:AddClickListener(self._dealSelectServer, self)
	self._btnAccount:AddClickListener(self._onClickAccount, self)
	self._btnExitAccount:AddClickListener(self._onClickExitAccount, self)
	self._btnNotice:AddClickListener(self._onClickNotice, self)
	self._btnRepair:AddClickListener(self._onClickRepair, self)
	self._btnProtocol:AddClickListener(self._onClickProtocol, self)
	self._btnPrivacy:AddClickListener(self._onClickPrivacy, self)
	self._btnHeath:AddClickListener(self._onClickHeath, self)
	self._toggleAgree:AddListener(self._onToggleAgree, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
	GlobalDispatcher:addEventListener(EventType.LOGIN_UPDATE_SELECT_EVENT, self._updateSelectServer, self)
end

function M:unbindEvents()
	self._btnServerBtn:RemoveClickListener()
	self._btnAccount:RemoveClickListener()
	self._btnExitAccount:RemoveClickListener()
	self._btnNotice:RemoveClickListener()
	self._btnRepair:RemoveClickListener()
	self._btnProtocol:RemoveClickListener()
	self._btnPrivacy:RemoveClickListener()
	self._btnHeath:RemoveClickListener()
	self._toggleAgree:RemoveListener()
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
	GlobalDispatcher:removeEventListener(EventType.LOGIN_UPDATE_SELECT_EVENT, self._updateSelectServer, self)
end

function M:_onHandleOnApplication()
	GlobalDispatcher:removeEventListener(EventType.APPLICATION_QUIT, self._onHandleOnApplication, self)
end

function M:onExit()
	self:setEvent(false)

	self._inEnterAni = false
	self._isStartEnter = false

	if self._isInRequestRemoteVersion then
		removetimer(self._delayShowRemoteVersionWaiting, self)
		removetimer(self._delayAsyncRemoteVersionWaiting, self)
	end

	self._isInRequestRemoteVersion = false
	self._isAreadyEnter = false

	FrameUpdate:removeListener(self)
	removetimer(self._delaySyncData, self)
	removetimer(self._delayGetSessionId, self)
	Astral.GameUpdateHelper.Instance:ClearListeners()
	goutil.setActive(self._goSdkLoginMask, false)
end

function M:onExitFinished()
	local go = UnityEngine.GameObject.Find("bootstrap_bk")

	if go then
		go:SetActive(false)
	end

	if LoginModel.instance:getCurServerState() then
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_CONNECT_SERVER_EVENT)
	end
end

function M:initViewState()
	self._serverStaticName.text = lang("txt_static_server_name")
	self._txtVersion.text = string.format("App:%s Res:%s %s", UnityEngine.Application.version, BootstrapUtil.getGameHotUpdateVersionCode(), SpaceX.EngineVersionCode.Version)
	self._toggleAgree.IsOn = self:getIsAgree()

	goutil.setActive(self._btnAccount.gameObject, SDKManager.getSDKInstacne():isShowUserCenterButton() or Astral.GameConstParser.Instance.enableSDKLogin and Astral.OSDef.RunOS == Astral.OSDef.Win32 and not Astral.OSDef.isEditor)
	goutil.setActive(self._btnExitAccount.gameObject, false)
	goutil.setActive(self._goServerRoot, enableDebug)
	goutil.setActive(self._btnEnterGame.gameObject, false)
	goutil.setActive(self._btnNotice.gameObject, not BootstrapGameConfigMgr.getIsReview())

	local isExistProtocol, protocolName = SDKManager.getSDKInstacne():getProtocolName()

	if isExistProtocol then
		local isExitPrivacy, privacyName = SDKManager.getSDKInstacne():getPrivacyName()
	end
end

function M:playEnterBGM()
	CriwareAudioFacade.instance:stopBgm()
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.music_main_denglu)
end

function M:addHotUpdateListener()
	local helper = Astral.GameUpdateHelper.Instance

	helper:ClearListeners()
	helper:AddListener(Astral.HotUpdateEventType.RequestRemoteVersionFail, self.onRequestRemoteVersionFail, self)
	helper:AddListener(Astral.HotUpdateEventType.RequestRemoteVersionSuccess, self.onRequestRemoteVersionSuccess, self)
end

function M:onRequestRemoteVersionFail()
	forcePrint("请求回来的最新版本号=,===请求失败")

	self._isInRequestRemoteVersion = false

	LoadingFacade.instance:hideLoading()
	LoginController.instance:onReset()
	LoginController.instance.webHandler:beginGetSessionId()

	local dialog = Dialog.showNotifyMessage(lang("tip_title"), BootstrapLanguage.getTipsTextByKey("a5"))

	dialog:setConfirmButtonText(lang("tip_common_sure"))
end

function M:onRequestRemoteVersionSuccess(gameHotUpdateVersionCode)
	forcePrint("再次检查资源版本号，当前版本号=，请求回来的最新版本号=", BootstrapUtil.getGameHotUpdateVersionCode(), gameHotUpdateVersionCode)

	self._isInRequestRemoteVersion = false

	LoadingFacade.instance:hideLoading()

	if gameHotUpdateVersionCode ~= "0.0.0" and not self:_checkAgainHotUpdateVersion(gameHotUpdateVersionCode) and Astral.GameConstParser.Instance.gameOpenHotUpdate then
		forcePrint("请求回来的最新版本号=,come here ...")

		local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("客户端已更新，请重新启动游戏"))

		dialog:setConfirmListener(self.confirmExit, self)
		dialog:setCancelListener(self.confirmExit, self)

		return
	end

	self:_realonClickLogin()
end

function M:_realonClickLogin()
	if not self._isStartEnter then
		self._isStartEnter = true

		settimer(kFailWaitTime, self._delaySyncData, self, false)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(CLOSE_LIST_ANI)
		self:close()
	end
end

function M:_delaySyncData()
	self._isStartEnter = false
end

function M:confirmExit()
	SystemUtil.Quit()
end

function M:_checkAgainHotUpdateVersion(gameHotUpdateVersionCode)
	local remoteVersion = string.split(gameHotUpdateVersionCode, ".")
	local bigVersion = checknumber(remoteVersion[1])
	local midVersion = checknumber(remoteVersion[2])
	local smallVerion = checknumber(remoteVersion[3])
	local localVersion = string.split(BootstrapUtil.getGameHotUpdateVersionCode(), ".")
	local localbigVersion = checknumber(localVersion[1])
	local localMidVersion = checknumber(localVersion[2])
	local localsmallVersion = checknumber(localVersion[3])

	if localbigVersion < bigVersion then
		forcePrint("服务器资源版本号 大包版本号 大于 本地，需要整包")

		return false
	elseif bigVersion == localbigVersion and midVersion == localMidVersion and localsmallVersion < smallVerion then
		forcePrint("服务器资源版本号 小包版本号 大于 本地，需要热更新")

		return false
	end

	return true
end

function M:_dealGetServerList(e, isSuccess, resultCode)
	if not self._isGetServerList then
		return
	end

	self._isGetServerList = false

	if isSuccess then
		ViewMgr.instance:open(ViewName.SelectServer, LoginModel.instance:getServerListData())
	else
		printWarn("获取服务器列表失败")
	end
end

function M:_dealSdkLoginWindowChange(e, isShow)
	if BootstrapHelper.getIsBtChannel() then
		goutil.setActive(self._goSdkLoginMask, isShow)
	end
end

function M:_updateSelectServer(e, serverName, serverIp)
	goutil.setActive(self._goSdkLoginMask, false)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click, nil, nil, nil)

	self._serverName.text = StringUtil.getServerName(serverName, serverIp)

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(OPEN_LIST_ANI)

	self._isAreadyEnter = true

	goutil.setActive(self._btnEnterGame.gameObject, true)
end

function M:_dealSelectServer()
	if self._inEnterAni then
		return
	end

	if self._isStartEnter then
		return
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click, nil, nil, nil)

	if LoginModel.instance.sessionId then
		LoginController.instance.webHandler:sendHttpGetServerListRequest({
			debug = false,
			sessionId = LoginModel.instance.sessionId
		})
	else
		if Astral.GameConstParser.Instance.enableSDKLogin and not Astral.OSDef.isEditor then
			return
		end

		local accountName = "accountName"
		local defualtName = "t1"
		local account = Astral.LocalStorage.Instance:GetString(accountName, defualtName)

		LoginController.instance.webHandler:sendHttpGetServerListRequest({
			debug = true,
			account = account
		})
	end

	self._isGetServerList = true
end

function M:_dealEnterGame()
	if self._inEnterAni or self:showTempTips() then
		return
	end

	if not self._toggleAgree.IsOn and not SDKManager.isXmSdk() then
		FloatWordMgr.instance:show(lang("tip_agree_login"))

		return
	end

	if LoginFacade.instance:checkShowConfidentialityTip() then
		return
	end

	if LoginModel.instance:getCurServerState() then
		if Astral.GameConstParser.Instance.gameOpenHotUpdate then
			if self._isInRequestRemoteVersion then
				return
			end

			local deviceType = BootstrapUtil.getHotUpdateDeviceType()

			if Astral.OSDef.isEditor then
				local isOpenPcHotUpdate = Astral.LocalStorage.Instance:GetInt(BootstrapConst.kOpenPcHotdate, 0) == 1

				if isOpenPcHotUpdate then
					local deviceTypeIndex = Astral.LocalStorage.Instance:GetInt(BootstrapConst.kDeviceType, 1)

					deviceType = BootstrapConst.HOTUPDATE_DEVIVE_TYPE[deviceTypeIndex]

					HotUpdateUtil.RequestRemoteVersion(BootstrapGameConfigMgr.getHotUpdateInfoUrl(), BootstrapGameConfigMgr.getHotUpdateAppCode(), deviceType, tostring(BootstrapUtil.getPlatformId()), BootstrapUtil.getGameVersionCode(), BootstrapUtil.getGamePackageName())
				else
					self:_realonClickLogin()
				end
			else
				HotUpdateUtil.RequestRemoteVersion(BootstrapGameConfigMgr.getHotUpdateInfoUrl(), BootstrapGameConfigMgr.getHotUpdateAppCode(), deviceType, tostring(BootstrapUtil.getPlatformId()), BootstrapUtil.getGameVersionCode(), BootstrapUtil.getGamePackageName())

				self._isInRequestRemoteVersion = true

				removetimer(self._delayShowRemoteVersionWaiting, self)
				removetimer(self._delayAsyncRemoteVersionWaiting, self)
				settimer(kRequestRemoteVersionTime, self._delayShowRemoteVersionWaiting, self, false)
				settimer(kRequestRemoteVersionMaxTime, self._delayAsyncRemoteVersionWaiting, self, false)
			end
		else
			self:_realonClickLogin()
		end
	else
		LoginController.instance:requestServerListAgain(function(isSuccess)
			if not LoginModel.instance:getCurServerState() then
				FloatWordMgr.instance:show(lang("tip_server_not_open"))
			else
				self:_dealEnterGame()
			end
		end)
	end
end

function M:_delayShowRemoteVersionWaiting()
	if self._isInRequestRemoteVersion then
		LoadingFacade.instance:showWaiting(nil, true)
	end
end

function M:_delayAsyncRemoteVersionWaiting()
	if self._isInRequestRemoteVersion then
		self._isInRequestRemoteVersion = false

		LoadingFacade.instance:hideLoading()
	end
end

function M:_onKeyEnter(keyCode, isOn)
	if isOn then
		self:_dealEnterGame()
	end
end

function M:_onClickAccount()
	if self._inEnterAni then
		return
	end

	if self._isStartEnter then
		return
	end

	SDKManager.getSDKInstacne():showUserCenter()
end

function M:_onClickExitAccount()
	if self._inEnterAni then
		return
	end

	if Astral.GameConstParser.Instance.enableSDKLogin then
		SDKManager.getSDKInstacne():logout()
	end

	LoginController.instance.webHandler:beginGetSessionId()
end

function M:_onClickNotice()
	if self._inEnterAni then
		return
	end

	NewNoticeController.instance:openNoticeView(true)
end

function M:_onClickRepair()
	if self._inEnterAni then
		return
	end

	local dialog = Dialog.showMessage(lang("tip_repair_game_title"), lang("tip_repair_game_content"))

	dialog:setConfirmListener(self.confirmRepair, self)
	GlobalDispatcher:dispatchEvent(EventType.RESET_REMOTE_TOOL_PASSARD)
end

function M:confirmRepair()
	UnityEngine.Caching.ClearCache()
	Astral.FileUtils.Instance:DeleteDirectory(Astral.FileUtils.Instance.LocalResRootPath)

	local unityCacheDataPath = UnityEngine.Application.persistentDataPath .. "/UnityCache/"

	Astral.FileUtils.Instance:DeleteDirectory(unityCacheDataPath)
	self:_applicationQuit()
end

function M:_applicationQuit()
	forcePrint("_applicationQuit===========,come here ...")
	SystemUtil.Quit()
end

function M:_onClickProtocol()
	if self._inEnterAni then
		return
	end

	local isExist = SDKManager.getSDKInstacne():showProtocolView()

	if not isExist then
		print("当前平台不支持调起服务协议页面，使用浏览器打开")

		local url = string.format(GameRequestUrl.URL_USER_PROTOCAL, os.time())

		UnityEngine.Application.OpenURL(url)
	end
end

function M:_onClickPrivacy()
	if self._inEnterAni then
		return
	end

	local isExist = SDKManager.getSDKInstacne():showPrivacyView()

	if not isExist then
		print("当前平台不支持调起隐私政策链接页面，使用浏览器打开")

		local url = string.format(GameRequestUrl.URL_USER_PRIVATE, os.time())

		UnityEngine.Application.OpenURL(url)
	end
end

function M:_onClickHeath()
	local dialog = Dialog.showNotifyMessage(lang("tip_title"), LoginEnum.HeathTips)

	dialog:setConfirmButtonText(lang("tip_common_sure"))
	dialog:setContentAlignment(TMPro.TextAlignmentOptions.MidlineLeft)
end

local kAgreeKey = "kAgreeKey"

function M:_onToggleAgree(tog, isOn)
	Astral.LocalStorage.Instance:SetInt(kAgreeKey, isOn and 1 or 0)
end

function M:getIsAgree()
	return Astral.LocalStorage.Instance:GetInt(kAgreeKey, 0) == 1
end

function M:_dealTimelineListener(key, tagName, reason)
	if tagName == LOGO_END_ANI then
		LoginController.instance.webHandler:beginGetSessionId()
	end
end

function M:_delayGetSessionId()
	self._inEnterAni = false

	LoginController.instance.webHandler:beginGetSessionId()
end

return M
