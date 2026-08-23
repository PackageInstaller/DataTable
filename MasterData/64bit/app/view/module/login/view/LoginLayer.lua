local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.platform.PlatformProxy
local var_0_3 = g.core.network.GameHttpProxy
local var_0_4 = g.core.model.User.annoData
local var_0_5 = g.core.module.ModuleManager
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local LangDownMgr = require("app.view.module.multilingual.control.LangDownMgr")
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local LoginLayer = class("LoginLayer", require("app.fairyGUI.login.UI_LoginLayer"), function()
	return fgui.GComponent:create({
		pkgName = "login",
		isFullScreen = true,
		pkgPath = "ui/login/login",
		resName = "LoginLayer"
	}, ...)
end)

function LoginLayer:ctor(arg_2_1)
	self:addBg("bg/login/bg_dl_main.jpg")

	self._pvPlayStorage = g.core.common.Storage:load("pv_first_play.json", false) or {
		played = false
	}
	self._reLoginType = arg_2_1 or 0
	self._firstReqSerList = self._reLoginType == 0
	self._loginAccount = nil
	self._sdkInited = self._reLoginType == 0 and 0 or 1
	self._getServerList = not device.isSdkEnabled() or self._reLoginType ~= 0

	self.m_levelBtn:addClickListener(handler(self, self._onLevelBtnClick))
	self.m_switchBtn:addClickListener(handler(self, self._onClickUnBind))
	self.m_switchBtn:setVisible(false)

	self._isShowHYTip = false

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		self.m_voiceBtn:setVisible(true)
		self.m_isShowLevelController:setSelectedIndex(1)
	elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
		if tonumber((g.core.platform.PlatformProxy:getOpId())) == 2731 then
			self.m_isShowLevelController:setSelectedIndex(3)
			self.m_oneStoreComp:setVisible(false)
		else
			self.m_isShowLevelController:setSelectedIndex(2)
		end

		self.m_voiceBtn:setVisible(true)
		self.m_levelBtn:setTouchable(false)
		self.m_voiceBtn:setVisible(false)
	else
		self.m_isShowLevelController:setSelectedIndex(0)
		self.m_voiceBtn:setVisible(false)
	end

	self.m_languageBtn:addClickListener(handler(self, self._onChangeLanguageClick))
	self.m_movieBtn:addClickListener(handler(self, self._onPlayMovieClick))
	self.m_voiceBtn:addClickListener(handler(self, self._onVoiceClick))
	self.m_accountBtn:addClickListener(handler(self, self._onLoginAccount))
	self.m_serverBtn:addClickListener(handler(self, self._onServerList))
	self.m_serverTouch:addClickListener(handler(self, self._onServerList))
	self.m_globalLoginComp:addClickListener(handler(self, self._onLogin))
	self.m_compTouch1:addClickListener(handler(self, self._onUserAgreement))
	self.m_compTouch2:addClickListener(handler(self, self._onUserPriv))
	self.m_compTouch3:addClickListener(handler(self, self._onShowChildPrivate))
	self.m_compTouch4:addClickListener(handler(self, self._onShowThirdTip))
	self.m_compTouch5:addClickListener(handler(self, self._onShowPersionPrivate))
	self.m_selectTouch:addClickListener(handler(self, self._onSelectAgreeClick))
	self:addEventListener(fgui.UIEventType.ClickLink, handler(self, self._onBeiAnClick))
	self.m_versionTxt:disableAutoChange()
	require("app.view.module.login.view.LoginLayerExLogic").setExtLogic(self)

	if self.m_specialTxt and config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN then
		self.m_specialTxt:setVisible(config.PCSDK_ENABLED and not g.core.platform.PlatformProxy:isChannelOfEnPC())
	else
		self.m_specialTxt:setVisible(false)
	end

	if (g.core.common.Storage:load("login.json", false) or {}).law then
		self.m_checkBtn:setSelected(true)
	elseif config.SHOW_USER_PROXY then
		self.m_checkBtn:setSelected(false)
	else
		self.m_checkBtn:setSelected(true)
	end

	if device.isWindowsDebug() then
		self.m_checkBtn:setSelected(true)
	end

	self.m_noticeBtn:addClickListener(handler(self, self._onNotice))
	self.m_noticeBtn:setVisible(false)
	self.m_descInitTxt:setText(g.core.lang:get(100026))
	self:_showUpgradeStatus(config.UPGRADE_ENABLED)
	self:_initLoginInfo()
	self:_updateLoginInfo()
	self.m_speedController:addEventListener(fgui.UIEventType.Changed, function()
		local var_3_0 = self:getView():getController("speed")

		cc.Director:getInstance().getScheduler(var_3_0):setTimeScale(var_3_0:getSelectedIndex() + 1)
	end)

	if self.m_clearCacheBtn then
		self.m_clearCacheBtn:setVisible(false)
		self.m_clearCacheBtn:addClickListener(handler(self, self._onClickClearCache))
	end

	self.m_noticeTxt:setText(g.core.lang:get(100057))
	self.m_noticeTxt:setVisible(not config.HIDE_HEALTH_NOTICE)

	if g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.AIMUY then
		config.HIDE_COPYRIGHT = true
	end

	self.m_copyrightTxt:setText("")
	self.m_copyrightTxt:setVisible(not config.HIDE_COPYRIGHT)
	self.m_beianTxt:setVisible(false)

	self._preloadFinish = true
	self._clickCount = 0

	self:_updateVersionInfo()

	if not config.SHOW_USER_PROXY then
		self.m_checkBtn:setVisible(false)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_LOCK_FEEDBACK_POP)
	self:checkShowLangBtn()
	g.core.model.User.homeData:setFirstLoginHome()

	if self.m_logonImg then
		self.m_logonImg:setURL(g.core.common.Path:getLoginLogoByRegionId())
	end

	if g.core.common.DeviceCheck.getDevicePerformanceLv() == 2 and g.core.common.Setting:get(g.core.common.Setting.FUNC_AUTO_SET_FPS) then
		g.core.common.Setting:set(g.core.common.Setting.FUNC_AUTO_SET_FPS, false)
		g.core.common.Setting:set(g.core.common.Setting.FUNC_FPS, 1)
		cc.Director:getInstance():setAnimationInterval(0.016666666666666666)
	else
		local var_2_1 = g.core.common.Setting:getValue(g.core.common.Setting.FUNC_FPS) or 0

		self._fpsIdx = var_2_1

		if var_2_1 == 0 then
			g.core.common.Setting:set(g.core.common.Setting.FUNC_FPS, 0)
			cc.Director:getInstance():setAnimationInterval(0.03333333333333333)
		elseif var_2_1 == 1 then
			g.core.common.Setting:set(g.core.common.Setting.FUNC_FPS, 1)
			cc.Director:getInstance():setAnimationInterval(0.016666666666666666)
		end
	end

	if config.DEBUG_VERSION and not config.SUPERSDK_ENABLED then
		local var_2_2 = g.core.common.Storage:load("gameIdDebug.json", false)

		if var_2_2 and var_2_2.gameId then
			config.SPECIFIC_GAME_ID = var_2_2.gameId
		end
	end

	g.core.common.PackageRes:initPackageResMgr()
end

function LoginLayer:_addBgCriSprite()
	local var_4_0 = {
		isLoop = true,
		x = 0,
		fullScreenState = 2,
		moduleName = "login",
		y = 0
	}

	var_4_0.movieName = "login03_1840x1200_10000"
	self._perMovie = self.m_bgComp:addCriSprite(var_4_0)
end

function LoginLayer:onLoad(arg_5_1, arg_5_2)
	self.m_noticeBtn:setVisible(false)
	g.core.layer.LayerManager:getFloatLayer():resetAllFloatComp()
	self:_addBgCriSprite()

	self._reLoginType = arg_5_2 or 0

	if config.UPGRADE_ENABLED then
		self._upgradeLayer = var_0_5:pushModule(g.view.entrance.UPGRADE)

		self._upgradeLayer:setVisible(false)
	end

	g.core.event.EventManager:addEventListener("ON_G_TRACKBACK_CALL", self._onErrorMsgCall, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_CREATE_ROLE, self._onCreateRole, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_GAME_LOGIN_ACCOUNT_FINISH, self._onLoginAccountFinish, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_GAME_LOGOUT_ACCOUNT, self._onLogoutAccount, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SUPERSDK_INIT_SUCCESS, self._onSuperSDKInitSuccess, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SUPERSDK_INIT_FAIL, self._onSuperSDKInitFail, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SDK_GET_SERVER_LIST, self._onGetServerList, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SDK_GET_SERVER_LIST_FAIL, self._onGetServerListFail, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SDK_GET_MY_SERVER_LIST, self._onGetMyServerList, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_LOCAL_CHOOSE_SERVER, self._onLocalChooseServer, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_NEW_VERISON, self._onNewVersion, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_GAME_LOGIN_FINISH, self._onLoginFinish, self)

	if var_0_2:init() then
		self:_fixCopyRightTxt()
	end

	if self._reLoginType == 0 and (not config.HIDE_HEALTH_NOTICE or config.PCSDK_ENABLED and config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN) then
		self._preloadFinish = false

		self:_playAntiIndulge((not device.isAndroid() or nil) and config.PCSDK_ENABLED and self._reLoginType == 0)
		self:_preloadEffect()

		self._loginProcessHandler = self:newSchedule(handler(self, self._onLoginProcess))
	else
		self:_addEffectBg()
		self:_onUpgradeEvent()
	end

	local var_5_0 = g.core.common.Storage:load("auto_connect.json", false) or {}
	local var_5_1 = var_5_0.ip or ""

	if var_5_1 == "" then
		-- block empty
	elseif var_5_0.auto then
		local var_5_2 = string.split(var_5_1, ":")

		g.core.service.ServiceManager:getServiceByName("DebuggerService"):start(var_5_2[1], var_5_2[2])

		var_5_0.auto = false

		g.core.common.Storage:save("auto_connect.json", var_5_0, false)
	end

	if not device.isIOS() then
		self:_checkServerList()
	end

	g.core.sound.SoundManager:playMusic(var_0_1.SoundConst.BGM.MUSIC_LOGIN)
end

function LoginLayer:onUnload()
	var_0_3:removeHttpResponse(self)
end

function LoginLayer:_onErrorMsgCall()
	if self.m_clearCacheBtn then
		self.m_clearCacheBtn:setVisible(true)
	end
end

function LoginLayer:_onNewVersion()
	if not config.UPGRADE_ENABLED then
		return
	end

	if self._upgradeLayer == nil then
		self._upgradeLayer = var_0_5:pushModule(g.view.entrance.UPGRADE)

		self._upgradeLayer:setVisible(false)
	end

	var_0_2:resetPatchMd5()
	self:_showUpgradeStatus(true)
	self:_onUpgradeEvent()
end

function LoginLayer:_onClickClearCache()
	var_0_5:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		text = g.core.lang:get(100029),
		text_ok = g.core.lang:get(1153),
		text_cancel = g.core.lang:get(1147),
		handler_ok = function()
			if type(__REMOVE_LOCAL_CACHE__) == "function" then
				__REMOVE_LOCAL_CACHE__()
			end

			device.restartGame()
		end
	}), {
		system = true
	})
end

function LoginLayer:_showUpgradeStatus(arg_11_1)
	self.m_serverBtn:setVisible(not arg_11_1)
	self.m_serverTouch:setVisible(not arg_11_1)
	self.m_accountBtn:setVisible(not arg_11_1 and not config.PCSDK_ENABLED)
	self.m_movieBtn:setVisible((g.core.utils.Rule.isHideLoginPv() or nil) and false)

	if not arg_11_1 == true then
		self:checkShowLangBtn()
	else
		self.m_languageBtn:setVisible(false)
	end

	if arg_11_1 then
		self:hideBottomInfo()
		self.m_noticeBtn:setVisible(false)
	else
		self:showBottomInfo()
	end

	self.m_agreementGroup:setVisible(not arg_11_1 and config.SHOW_USER_PROXY)
	self:updateAgreement()
end

function LoginLayer:checkAndLoadLang()
	if device.isWindowsDebug() then
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs((MultilingualMgr:getMultiLangs())) do
			var_12_0[iter_12_1] = {}
		end

		LangDownMgr:parseAllLangInfo(var_12_0)
	end
end

function LoginLayer:checkShowLangBtn()
	if LangDownMgr:getAllLangUnit() == nil then
		self:_fetchLangTotalInfo()
	elseif #LangDownMgr:getAllLangUnit() <= 1 then
		self.m_languageBtn:setVisible(false)
	else
		self.m_languageBtn:setVisible(true)
	end

	local var_13_0 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION]

	if var_0_2:isChannelOfChina() or var_13_0 and var_13_0.HIDE_LOGIN_LANGUAGE_BTN then
		self.m_languageBtn:setVisible(false)
	end
end

function LoginLayer:_fetchLangTotalInfo()
	local UpgradeOut = require("upgrade.UpgradeOut")
	local var_14_1 = config.LANGMULTI_URL_TEST

	if config.PATCH_URL_ENABLED then
		var_14_1 = device.isIOS() and UpgradeOut.MLANG_TOTAL_URL_I or UpgradeOut.MLANG_TOTAL_URL_A
	end

	if not var_14_1 then
		if not g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] or not g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].MLANG_TOTAL_URL then
			::label_14_0::

			var_14_1 = UpgradeOut.MLANG_TOTAL_JP
		end
	end

	g.core.network.GameHttpProxy:sendHttpRequest(var_14_1 .. "?t=" .. os.time(), "GET", {
		success = handler(self, self._handleFetchLangTotalOK),
		fail = handler(self, self._handleFetchLangTotalErr),
		cancel = handler(self, self._handleFetchLangTotalErr)
	}, self)
end

function LoginLayer:_handleFetchLangTotalOK(arg_15_1)
	local var_15_0 = json.decode(arg_15_1)

	if var_15_0 ~= nil then
		LangDownMgr:parseAllLangInfo(var_15_0)
	end

	self:checkShowLangBtn()
end

function LoginLayer:_handleFetchLangTotalErr()
	self.m_languageBtn:setVisible(false)
end

function LoginLayer:_initLoginInfo()
	if self._reLoginType == 0 or self._reLoginType == 1 then
		self._loginAccount = var_0_2:getAccount()
	end

	self:updateLastLoginServer()
end

function LoginLayer:updateLastLoginServer()
	local var_18_0 = g.core.platform.ServerListProxy:getLastLoginServer()

	if var_18_0 then
		self._selectedServer = var_18_0

		g.core.platform.ServerListProxy:setCurServer(var_18_0)
	end
end

function LoginLayer:_updateLoginInfo()
	self:recheckSelServer()

	if not self._selectedServer then
		return
	end

	local var_19_0 = g.core.platform.ServerListProxy:getBaseMainServer(self._selectedServer.sid)

	self.m_serverBtn:setTitle((var_19_0 or nil) and var_19_0.name)
	self:checkQAServerName(self._selectedServer)
	g.core.log:info("账号-------------------------->", self._loginAccount)
	self.m_serverBtn:setCtrlState("state", {
		index = g.core.platform.ServerListProxy:getServerState(self._selectedServer)
	})
end

function LoginLayer:recheckSelServer()
	if g.core.model.User.summonOldPlayerData:getLoginNewSvrData() then
		local var_20_0 = g.core.model.User.summonOldPlayerData:getInheritServerId()

		if var_20_0 ~= 0 then
			local var_20_1 = g.core.platform.ServerListProxy:getServerById(var_20_0)

			if var_20_1 then
				self._selectedServer = var_20_1

				g.core.platform.ServerListProxy:setCurServer(var_20_1)
			end
		else
			local var_20_2 = g.core.platform.ServerListProxy:getRecommendServerList()

			if next(var_20_2) then
				self._selectedServer = var_20_2[1]

				g.core.platform.ServerListProxy:setSummonServer(var_20_2[1])
			end
		end
	end
end

function LoginLayer:checkQAServerName(arg_21_1)
	if type(arg_21_1.name) == "string" and not config.PATCH_URL_ENABLED and config.SERVER_JSON_ENABLED then
		if arg_21_1.region then
			config.PUBLISH_REGION = arg_21_1.region
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[arg_21_1.region].GAME_SECRET

			return
		end

		if string.match(arg_21_1.name, "国服") then
			config.PUBLISH_REGION = var_0_1.PlatformConst.REGION.CHINA
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[1].GAME_SECRET
		elseif string.match(arg_21_1.name, "东南亚") then
			config.PUBLISH_REGION = var_0_1.PlatformConst.REGION.SEA
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[3].GAME_SECRET
		elseif string.match(arg_21_1.name, "港澳台") then
			config.PUBLISH_REGION = var_0_1.PlatformConst.REGION.TW
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[4].GAME_SECRET
		elseif string.match(arg_21_1.name, "欧美") then
			config.PUBLISH_REGION = var_0_1.PlatformConst.REGION.EN
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[5].GAME_SECRET
		elseif string.match(arg_21_1.name, "韩国") then
			config.PUBLISH_REGION = var_0_1.PlatformConst.REGION.KR
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[6].GAME_SECRET
		elseif string.match(arg_21_1.name, "日本") then
			config.PUBLISH_REGION = var_0_1.PlatformConst.REGION.JAPAN
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[2].GAME_SECRET
		else
			config.PUBLISH_REGION = var_0_1.PlatformConst.REGION.CHINA
			config.GAME_SECRET = var_0_1.PlatformConst.REGION_CFG[1].GAME_SECRET
		end

		if device.checkRegionConfig then
			device.checkRegionConfig()

			g.core.config._cfgCache = {}
			g.core.config._cfgRef = {}
		end
	end
end

function LoginLayer:_showAntiComp(arg_22_1, arg_22_2, arg_22_3)
	arg_22_2:setSize(display.width, display.height)
	self:addChild(arg_22_2)

	local function var_22_0()
		arg_22_2:removeFromParent()
	end

	local function var_22_1(arg_24_0)
		arg_22_3(arg_24_0)
		arg_22_2:getTransition("out"):play(var_22_0)
	end

	arg_22_2:getTransition("in"):play((handler(self, function(arg_25_0)
		g.core.common.Scheduler:newScheduleOnce(handler(arg_25_0, function(arg_26_0)
			var_22_1(arg_26_0)
		end), arg_22_1)
	end)))
end

function LoginLayer:_playAntiIndulge(arg_27_1)
	local var_27_0 = handler(self, function(arg_28_0)
		arg_28_0:_addEffectBg()
		arg_28_0.m_enterTransition:play(handler(arg_28_0, arg_28_0._playLoopAnim))
	end)

	if g.core.platform.PlatformProxy:isChannelOfChina() and config.PCSDK_ENABLED == false then
		local var_27_1 = handler(self, function(arg_29_0)
			arg_29_0:_showAntiComp(arg_27_1 and 3 or 1, fgui.UIPackage:createObject("login", "LoginAntiIndulgeComp"), var_27_0)
		end)
		local var_27_2 = fgui.UIPackage:createObject("login", "LoginAntiIndulgePreComp")

		var_27_2:setIcon("bg/login/junior_logo_bg.jpg")

		local var_27_3 = var_27_2:getChild("icon")
		local var_27_4 = var_27_3:getContentSize()
		local var_27_5 = math.max(display.size.width / var_27_4.width, display.size.height / var_27_4.height)

		if var_27_5 > 1 then
			var_27_3:setSize(var_27_4.width * var_27_5, var_27_4.height * var_27_5)
		else
			var_27_3:setSize(var_27_4.width, var_27_4.height)
		end

		self:_showAntiComp(arg_27_1 and 3 or 1, var_27_2, var_27_1)
	else
		self:_showAntiComp(arg_27_1 and 3 or 1, fgui.UIPackage:createObject("login", "LoginAntiIndulgeComp"), var_27_0)
	end
end

function LoginLayer:_playLoopAnim()
	self.m_loopTransition:play()
end

function LoginLayer:_preloadEffect()
	g.core.resource.ResourceManager:loadKnightSpinePngAsync({}, function()
		self._preloadFinish = true
	end)
end

function LoginLayer:_onLocalChooseServer(arg_33_1, arg_33_2, arg_33_3)
	self:_onSelectedServer(arg_33_2, arg_33_3)
end

function LoginLayer:_onSelectedServer(arg_34_1, arg_34_2)
	self._selectedServer = arg_34_1

	g.core.platform.ServerListProxy:setSelectedServerWithAddress(arg_34_1.sid, arg_34_1.address)
	self:_updateLoginInfo()
end

function LoginLayer:_onLogin()
	if device.platform == "ios" then
		local UpgradeSilent = require("upgrade.UpgradeSilent")

		if UpgradeSilent.isNeedUpgrade() then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
				type = 0,
				title = g.core.lang:get(100003),
				text = g.core.lang:get(100059),
				text_cancel = g.core.lang:get(100006),
				text_ok = g.core.lang:get(1147),
				handler_cancel = function()
					fgui.UIPackage:addPackage("ui/upgrade/upgrade")

					local var_36_0 = fgui.UIPackage:createObject("upgrade", "SilentIosProg")

					g.core.layer.LayerManager:setIosDownObj(var_36_0)
					UpgradeSilent.start(handler(var_36_0, var_36_0.updateFuncCallBack))
					self:onCheckSilentOpeFinish()
				end,
				handler_ok = function()
					return
				end
			}), {
				ignoreTouch = true
			})

			return
		end
	end

	g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_SUPERSDK_STATS, false, {
		event_id = var_0_1.SuperSdkConst.CLICK_ENTER_GAME_BTN
	})
	g.core.sound.SoundManager:playSound(var_0_1.SoundConst.Sound.LOGIN_ENTER_GAME)

	if self.m_checkBtn:isSelected() == false then
		var_0_5:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(100054),
			onConfirm = handler(self, function()
				self.m_checkBtn:setSelected(true)
				g.core.common.Storage:save("login.json", {
					law = true
				}, false)
			end)
		}))

		return
	else
		g.core.common.Storage:save("login.json", {
			law = true
		}, false)
	end

	if device.isOHOS() and config.SUPERSDK_ENABLED and not var_0_2:getCollectionData() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1237))

		return
	end

	if not var_0_2:isLogined() then
		var_0_2:login()
	else
		if var_0_2:isAntiLogout() then
			var_0_5:tip(g.core.lang:get(101558))

			return
		end

		if var_0_2:getFlrState() == "26" then
			var_0_5:tip(g.core.lang:get(102410))

			return
		end

		if not self._isShowHYTip and g.core.platform.PlatformProxy:checkHYExchange(handler(self, self._onHYConfirm)) then
			return
		end

		if self._selectedServer then
			if device.isOHOS() then
				self:_preloadLargeConfig()
			else
				self:_doLogin()
			end
		else
			var_0_5:tip(g.core.lang:get(100030))
		end
	end
end

function LoginLayer:_preloadLargeConfig()
	local var_39_0 = g.core.service.ServiceManager:getServiceByName("LoopService")

	var_39_0:addToLoopFuncList(function()
		g.core.config.skin_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.avata_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.avatar_frame_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.presetmail_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.talk_show_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.title_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.transformation_card_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.activity_theme_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.dress_compose_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.dress_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.knight_info.getLength()
	end)
	var_39_0:addToLoopFuncList(function()
		g.core.config.share_res_info.getLength()
	end)
	var_39_0:addToLoopFuncList(handler(self, function(arg_52_0)
		g.core.module.ModuleManager:showLoading(false)
		arg_52_0:_doLogin()
	end))
	g.core.module.ModuleManager:showLoading(true)
end

function LoginLayer:_doLogin()
	g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_SUPERSDK_STATS, false, {
		event_id = var_0_1.SuperSdkConst.CONNECT_SERVER
	})

	if g.core.platform.ServerListProxy:isMyServer(self._selectedServer) then
		g.core.platform.ServerListProxy:saveLastServer(self._selectedServer)
	end

	g.core.network.GameNetProxy:connect(self._selectedServer.address, self._selectedServer.port)
end

function LoginLayer:_onHYConfirm()
	self._isShowHYTip = true

	self:_onLogin()
end

function LoginLayer:_onChangeLanguageClick()
	var_0_5:pushPopup((require("app.view.module.login.view.LoginLanguagePop").new()))
end

function LoginLayer:_onPlayMovieClick()
	if config.FORCE_SKIP_BATTLE then
		g.core.common.Storage:save("battle_skip_open.json", {
			open = true
		}, false)
	end

	if g.core.utils.Rule.isHideLoginPv() then
		var_0_5:tip(g.core.lang:get(303026))

		return
	end

	g.core.sound.SoundManager:playSound(var_0_1.SoundConst.Sound.BUTTON_NORMAL)
	self.m_bgComp:removeAllCriSprite()
	var_0_5:pushPopup(require("app.view.module.login.view.PvPlayLayer").new({
		pvName = "pv2new_1920x1080_92300",
		localName = "pv_first_play",
		zimuName = "pv2zimu_1920x1080x1_92300",
		bgPVSound = g.core.const.ConstMgr.SoundConst.Sound.BG_PV_FIRST
	}))
end

function LoginLayer:_onVoiceClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.login.view.LoginVoicePop").new())
end

function LoginLayer:_onLoginAccount()
	if not config.DEBUG_VERSION and self._sdkInited ~= 1 then
		return
	end

	if var_0_2:isLogined() and checkbool(config.SUPERSDK_ENABLED) then
		var_0_2:logout()
	else
		var_0_2:login()
	end
end

function LoginLayer:_onNotice()
	if device.isWindowsDebug() then
		var_0_5:tip(g.core.lang:get(100536))
	else
		self:_onOpenAnnoMainPop()
	end
end

function LoginLayer:_onServerList()
	var_0_5:pushPopup(require("app.view.module.login.view.LoginServerListPop").new())
end

function LoginLayer:_onUserAgreement()
	if config.SHOW_USER_PROXY then
		var_0_2:openUserService()
	end
end

function LoginLayer:_onUserPriv()
	if config.SHOW_USER_PROXY then
		var_0_2:openPrivPolicy()
	end
end

function LoginLayer:_onLoginAccountFinish(arg_63_1, arg_63_2)
	self._loginAccount = arg_63_2

	self:_updateLoginInfo()

	if device.isWindowsDebug() then
		self.m_noticeBtn:setVisible(true)
	elseif var_0_4:isShowAnnouncement() then
		self:_onOpenAnnoMainPop()
	end
end

function LoginLayer:_onOpenAnnoMainPop()
	self:addPopup(require("app.view.module.announcement.view.AnnoMainPop").new(), device.isWindows() and {
		withoutAni = true
	} or nil)
end

function LoginLayer:_reqWebList()
	self.m_globalLoginComp:setTouchable(false)
	var_0_3:sendHttpRequest(var_0_4:getWebListUrl(), "GET", {
		success = handler(self, self._onAnnoWebListRequestSucc),
		fail = handler(self, self._onAnnoWebListRequestFail),
		cancel = handler(self, self._onAnnoWebListRequestCancel)
	}, self)
end

function LoginLayer:_onAnnoWebListRequestSucc(arg_66_1)
	var_0_4:onWebListRequestSuccess(arg_66_1)
	self.m_noticeBtn:setVisible(true)
	self.m_globalLoginComp:setTouchable(true)
end

function LoginLayer:_onAnnoWebListRequestFail(arg_67_1)
	var_0_4:onWebListRequestFailed()
	self.m_noticeBtn:setVisible(true)
	self.m_globalLoginComp:setTouchable(true)
	g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_SUPERSDK_STATS, false, {
		event_id = var_0_1.SuperSdkConst.SHOW_NOTICE_LAYER_FAILY
	})
end

function LoginLayer:_onAnnoWebListRequestCancel(arg_68_1)
	var_0_4:onWebListRequestCancel()
	self.m_noticeBtn:setVisible(true)
	self.m_globalLoginComp:setTouchable(true)
end

function LoginLayer:_onLogoutAccount()
	self._loginAccount = nil

	if self._updateLoginInfo then
		self:_updateLoginInfo()
	end
end

function LoginLayer:_onLoginFinish()
	g.core.sound.SoundManager:setCurrentGender(g.core.model.User:isBoy())
	KnightVoiceCommon.playLoginVoice()
end

function LoginLayer:_onCreateRole(arg_71_1, arg_71_2, arg_71_3)
	if arg_71_3.need_activate then
		-- block empty
	end
end

function LoginLayer:_addEffectBg()
	self._preload = true
end

function LoginLayer:receiveCompEvent(arg_73_1)
	if arg_73_1 == "server" then
		self:_onSelectedServer(...)
	elseif arg_73_1 == "account" then
		-- block empty
	elseif arg_73_1 == "txt_pop_cancel" then
		local var_73_0 = ({
			...
		})[1]

		if var_73_0 == "sdk_init_fail" then
			cc.Director:getInstance():endToLua()
		elseif var_73_0 == self then
			var_0_2:reqServerList()
		end
	elseif arg_73_1 == "debugger_pop_confirm" then
		local var_73_1 = ({
			...
		})[1].text

		if var_73_1 == "" then
			var_0_5:tip(g.core.lang:get(100040))
		else
			local var_73_2 = g.core.service.ServiceManager:getServiceByName("DebuggerService")
			local var_73_3 = string.split(var_73_1, ":")

			var_73_2:start(var_73_3[1], var_73_3[2])
			var_0_5:popComponent()
		end
	end
end

function LoginLayer:_onSuperSDKInitSuccess()
	self._sdkInited = 1

	self:_fixCopyRightTxt()

	if self.m_checkBtn:isSelected() then
		var_0_2:getCollectionData()
	end
end

function LoginLayer:_fixCopyRightTxt()
	if var_0_2:isYOOZOOPackageEntity() then
		self.m_copyrightTxt:setText(g.core.lang:get(102405))
		self.m_entryTypeController:setSelectedIndex(0)
	else
		self.m_copyrightTxt:setText(g.core.lang:get(102406))
		self.m_entryTypeController:setSelectedIndex(1)
	end

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		self.m_beianTxt:setVisible(true)

		if self.m_beianClickLoader and not self._initBeiAnClick then
			self._initBeiAnClick = true

			self.m_beianClickLoader:setVisible(true)
			self.m_beianClickLoader:addClickListener(handler(self, self._onBeiAnLoaderClick))
		end
	end
end

function LoginLayer:_onSuperSDKInitFail()
	self._sdkInited = 2
end

function LoginLayer:_onLoginProcess()
	if not self._preload then
		return
	end

	if self._sdkInited == 1 then
		self.m_descInitTxt:setVisible(false)
		self:_onUpgradeEvent()

		if self._loginProcessHandler then
			self:cancelSchedule(self._loginProcessHandler)

			self._loginProcessHandler = nil
		end
	elseif self._sdkInited == 0 then
		self.m_descInitTxt:setVisible(true)
	else
		self.m_descInitTxt:setVisible(false)
		self:_showSDKInitFailPop()

		if self._loginProcessHandler then
			self:cancelSchedule(self._loginProcessHandler)

			self._loginProcessHandler = nil
		end
	end
end

function LoginLayer:_onUpgradeEvent(arg_78_1)
	if arg_78_1 == nil then
		arg_78_1 = true
	end

	if self._upgradeLayer then
		self._upgradeLayer:setVisible(true)
		var_0_2:delayCallCheckAndDoAdActive()
		g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_SUPERSDK_STATS, false, {
			event_id = var_0_1.SuperSdkConst.SHOW_UPGRADE_LAYER
		})
		var_0_2:sendAdvStartUpdate()
		self._upgradeLayer:start(function(arg_79_0)
			var_0_2:sendAdvUpdateDone()
			self._upgradeLayer:removeFromParent()

			self._upgradeLayer = nil

			if arg_79_0 then
				self:removeFromParent()

				return
			elseif not device.isWindowsDebug() then
				self:_reqWebList()

				if self._reLoginType == 0 then
					if not self._getServerList then
						self:_checkServerList()
					elseif not var_0_2:isLogined() then
						var_0_2:login()
					end
				end
			end

			if device.platform == "ios" then
				local UpgradeSilent = require("upgrade.UpgradeSilent")

				if UpgradeSilent.isNeedUpgrade() then
					g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
						type = 0,
						title = g.core.lang:get(100003),
						text = g.core.lang:get(100059),
						text_cancel = g.core.lang:get(100006),
						text_ok = g.core.lang:get(1147),
						handler_cancel = function()
							fgui.UIPackage:addPackage("ui/upgrade/upgrade")

							local var_80_0 = fgui.UIPackage:createObject("upgrade", "SilentIosProg")

							g.core.layer.LayerManager:setIosDownObj(var_80_0)
							UpgradeSilent.start(handler(var_80_0, var_80_0.updateFuncCallBack))
							self:onCheckSilentOpeFinish()
						end,
						handler_ok = function()
							return
						end
					}), {
						ignoreTouch = true
					})
				else
					self:onCheckSilentOpeFinish()
					g.core.common.PackageRes:doRequestPackageInfo()
				end
			else
				require("upgrade.UpgradeSilent").start()
				self:onCheckSilentOpeFinish()
				g.core.common.Scheduler:newScheduleOnce(function()
					if g.core.utils.Tools.checkSilentFull() == 0 then
						g.core.common.PackageRes:doRequestPackageInfo()
					end
				end, 1)
			end
		end)
	elseif not device.isWindowsDebug() then
		self:_reqWebList()

		if not config.DEBUG_VERSION and not self._getServerList then
			self:_checkServerList()
		elseif self._reLoginType == 0 and arg_78_1 then
			-- block empty
		end

		var_0_2:openLoginPage()

		if not config.UPGRADE_ENABLED then
			self.m_globalLoginComp:setTouchable(true)
		end
	else
		self._getServerList = true

		if not self._pvPlayStorage.played then
			self.m_bgComp:removeAllCriSprite()
			var_0_5:pushPopup(require("app.view.module.login.view.PvPlayLayer").new({
				pvName = "pv2new_1920x1080_92300",
				localName = "pv_first_play",
				zimuName = "pv2zimu_1920x1080x1_92300",
				bgPVSound = g.core.const.ConstMgr.SoundConst.Sound.BG_PV_FIRST
			}))
		end
	end
end

function LoginLayer:onCheckSilentOpeFinish()
	self:_showUpgradeStatus(false)
	var_0_2:openLoginPage()

	if not self._pvPlayStorage.played then
		self.m_bgComp:removeAllCriSprite()
		var_0_5:pushPopup(require("app.view.module.login.view.PvPlayLayer").new({
			pvName = "pv2new_1920x1080_92300",
			localName = "pv_first_play",
			zimuName = "pv2zimu_1920x1080x1_92300",
			bgPVSound = g.core.const.ConstMgr.SoundConst.Sound.BG_PV_FIRST
		}))
	end
end

function LoginLayer:hideBottomInfo()
	self.m_group1:setVisible(false)
	self:getChild("n94"):setVisible(false)
end

function LoginLayer:showBottomInfo()
	self.m_group1:setVisible(true)
	self:getChild("n94"):setVisible(true)
end

function LoginLayer:_showSDKInitFailPop()
	var_0_5:pushPopup(require("app.view.base.component.BaseTxtPopComp").new({
		style = 0,
		info = "sdk_init_fail",
		text = g.core.lang:get(100031),
		text_cancel = g.core.lang:get(100006)
	}), {
		system = true
	})
end

function LoginLayer:_updateVersionInfo()
	self.m_versionTxt:setText((g.core.utils.Tools.getVersionInfos()))

	local var_87_0 = g.core.platform.PlatformProxy:getCurChannel()

	if var_87_0.name == require("app.core.platform.const.ChannelConst").ChannelNames.YOOZOO then
		if var_87_0.subInfo and var_87_0.subInfo == "iOS" then
			config.SHOW_ERROR_POP = false
		end
	end
end

function LoginLayer:_onGetMyServerList()
	self:updateLastLoginServer()
	self:_updateLoginInfo()

	if device.isOHOS() then
		g.core.platform.PlatformProxy:isShowUnbind(handler(self, function(arg_89_0, arg_89_1)
			arg_89_0.m_switchBtn:setVisible(arg_89_1)
		end))
	end
end

function LoginLayer:_onGetServerList()
	self._getServerList = true

	self:updateLastLoginServer()
	self:_updateLoginInfo()
	self.m_descInitTxt:setVisible(false)

	self._firstReqSerList = false

	if not var_0_2:isLogined() then
		var_0_2:login()
	end

	var_0_2:openLoginPage()

	if device.isOHOS() then
		g.core.platform.PlatformProxy:isShowUnbind(handler(self, function(arg_91_0, arg_91_1)
			arg_91_0.m_switchBtn:setVisible(arg_91_1)
		end))
	end
end

function LoginLayer:_onGetServerListFail()
	self._getServerList = false
end

function LoginLayer:_checkServerList()
	if self._sdkInited == 1 and not self._getServerList then
		self.m_descInitTxt:setVisible(true)
		self.m_descInitTxt:setText(g.core.lang:get(100033))
		var_0_2:reqServerList()
	end
end

function LoginLayer:_onSelectAgreeClick()
	self.m_checkBtn:setSelected(not self.m_checkBtn:isSelected())

	if self.m_checkBtn:isSelected() then
		g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_SUPERSDK_STATS, false, {
			event_id = var_0_1.SuperSdkConst.CONFIRM_USER_PRIVATE_TIP
		})
		var_0_2:getCollectionData()
	end
end

function LoginLayer:updateAgreement()
	local var_95_0 = g.core.platform.PlatformProxy:isChannelOfChina()

	self.m_agreementText4:setVisible(var_95_0)
	self.m_agreementText5:setVisible(var_95_0)
	self.m_agreementText6:setVisible(var_95_0)
	self.m_compTouch3:setVisible(var_95_0)
	self.m_compTouch4:setVisible(var_95_0)
	self.m_compTouch5:setVisible(var_95_0)

	local var_95_1 = require("app.core.lang.MultilingualMgr"):getUseLang()

	if var_95_1 == "jp" then
		self.m_agreementText1:setText((self.m_agreementText2:getText()))
		self.m_agreementText2:setText((self.m_agreementText3:getText()))
		self.m_agreementText3:setText((self.m_agreementText1:getText()))
	end

	if not var_95_0 then
		local var_95_2 = self.m_selectTouch:getSize().width
		local var_95_3 = self.m_textStartNode:getPosition().x

		for iter_95_0, iter_95_1 in ipairs({
			self.m_agreementText1,
			self.m_agreementText2,
			self.m_agreementText3
		}) do
			local var_95_4 = iter_95_1:getPosition()

			var_95_4.x = var_95_3

			iter_95_1:setPosition(var_95_4)

			local var_95_5 = iter_95_1:getSize().width

			var_95_3 = var_95_3 + var_95_5 + 5
			var_95_2 = var_95_2 + var_95_5
		end

		if var_95_1 == "jp" then
			local var_95_6 = self.m_compTouch1:getPosition()

			var_95_6.x = self.m_agreementText1:getPosition().x

			self.m_compTouch1:setPosition(var_95_6)

			local var_95_7 = self.m_compTouch2:getPosition()

			var_95_7.x = self.m_agreementText2:getPosition().x

			self.m_compTouch2:setPosition(var_95_7)
		end

		self.m_agreementGroup:setX((display.width - var_95_2) / 2)
	end
end

function LoginLayer:_onLevelBtnClick()
	var_0_5:pushPopup((require("app.view.module.login.view.LoginStageLevelPop").new()))
end

function LoginLayer:_onClickUnBind()
	g.core.platform.PlatformProxy:isShowUnbind(handler(self, function(arg_98_0, arg_98_1)
		if arg_98_1 then
			g.core.platform.PlatformProxy:doUnbind()
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(202064))
		end
	end))
end

function LoginLayer:_onBeiAnLoaderClick()
	g.core.platform.PlatformProxy:openURL("https://beian.miit.gov.cn")
end

function LoginLayer:_onShowChildPrivate()
	if config.SUPERSDK_ENABLED then
		g.core.platform.PlatformProxy:openChildPrivate()
	end
end

function LoginLayer:_onShowThirdTip()
	if config.SUPERSDK_ENABLED then
		g.core.platform.PlatformProxy:openThridTip()
	end
end

function LoginLayer:_onBeiAnClick(arg_102_1)
	g.core.platform.PlatformProxy:openURL("https://beian.miit.gov.cn")
end

function LoginLayer:_onShowPersionPrivate()
	if config.SUPERSDK_ENABLED then
		g.core.platform.PlatformProxy:openOpenPersonalPrivacy()
	end
end

return LoginLayer
