local LoginScene = class("LoginScene", import("..base.BaseUI"))
local var_0_1 = 1

function LoginScene:getUIName()
	return "LoginUI2"
end

function LoginScene:getBGM()
	if self.bgmName and self.bgmName ~= "" then
		return self.bgmName
	end

	return LoginScene.super.getBGM(self)
end

function LoginScene:preload(arg_3_1)
	self.iconSpries = {
		"reources/statu_green",
		"reources/statu_gray",
		"reources/statu_red",
		"reources/statu_org"
	}

	local var_3_0 = LOGIN_HX

	if LOGIN_HX then
		var_3_0 = PlayerProxy.GetDeviceMaxPlayerLevel() <= pg.gameset.LOGIN_HX_LV.key_value
	end

	seriesAsync({
		function(arg_4_0)
			self.isCriBg, self.bgPath, self.bgmName, self.isOpPlay, self.opVersion = getLoginConfig()

			if self.isCriBg then
				LoadAndInstantiateAsync("effect", self.bgPath, function(arg_5_0)
					self.criBgGo = arg_5_0

					arg_4_0()

					return
				end)
			else
				LoadSpriteAsync((var_3_0 and "loadingbg_hx/" or "loadingbg/") .. self.bgPath, function(arg_6_0)
					self.staticBgSprite = arg_6_0

					arg_4_0()

					return
				end)
			end

			return
		end
	}, arg_3_1)

	return
end

function LoginScene:init()
	self:setBg()

	self.adapt = self._tf:Find("adapt")
	self.version = self.adapt:Find("version")
	self.version:GetComponent("Text").text = "ver " .. BundleWizard.Inst:GetGroupMgr("DEFAULT_RES").CurrentVersion:ToString()
	self.bgLay = self.adapt:Find("bg_lay")
	self.accountBtn = self.adapt:Find("bg_lay/buttons/account_button")
	self.repairBtn = self.adapt:Find("btns/repair_button")
	self.privateBtn = self.adapt:Find("btns/private_btn")
	self.licenceBtn = self.adapt:Find("btns/Licence_btn")
	self.chInfo = self._tf:Find("background/info")

	setActive(self.chInfo, PLATFORM_CODE == PLATFORM_CH)

	if PLATFORM_CODE == PLATFORM_CH then
		self.urlClick = self.chInfo:Find("urlClick")

		onButton(self, self.urlClick, function()
			Application.OpenURL("https://beian.miit.gov.cn/#/home")

			return
		end)
	end

	self.pressToLogin = GetOrAddComponent(self._tf:Find("background/press_to_login"), "CanvasGroup")

	LeanTween.alphaCanvas(self.pressToLogin, 0.25, var_0_1):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

	self.currentServer = self.adapt:Find("current_server")
	self.serviceBtn = self.adapt:Find("bg_lay/buttons/service_button")
	self.filingBtn = self.adapt:Find("filingBtn")

	setActive(self.filingBtn, PLATFORM_CODE == PLATFORM_CH)

	self.serversPanel = self.adapt:Find("servers")
	self.servers = self.serversPanel:Find("panel/panel/servers/content/server_list")
	self.serverTpl = self:getTpl("server_tpl")
	self.recentTF = self.serversPanel:Find("panel/panel/servers/content/advice_panel/recent")
	self.adviceTF = self.serversPanel:Find("panel/panel/servers/content/advice_panel/advice")
	self.userAgreenTF = self.adapt:Find("UserAgreement")
	self.userAgreenMainTF = self.adapt:Find("UserAgreement/window")
	self.closeUserAgreenTF = self.userAgreenTF:Find("window/close_btn")
	self.userAgreenConfirmTF = self.adapt:Find("UserAgreement/window/accept_btn")
	self.userDisagreeConfirmTF = self.adapt:Find("UserAgreement/window/disagree_btn")
	self.switchGatewayBtn = SwitchGatewayBtn.New(self.adapt:Find("servers/panel/panel/switch_platform"))

	if PLATFORM == PLATFORM_OPENHARMONY then
		self.switchGatewayBtn4Oh = SwitchGatewayBtn4OpenHarmony.New(self.adapt:Find("servers/panel/panel/switch_platform"))
	end

	setActive(self.userAgreenTF, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.userAgreenTF, self._tf)

	self.opBtn = self.adapt:Find("bg_lay/buttons/opBtn")

	if self.opBtn then
		setActive(self.opBtn, self.isOpPlay)
	end

	self.airiUidTxt = self.adapt:Find("airi_uid")
	self.shareData = {}
	self.searchAccount = self.serversPanel:Find("panel/panel/searchAccount")

	setText(findTF(self.searchAccount, "text"), i18n("query_role_button"))

	self.serverPanelCanvas = GetComponent(self.adapt:Find("servers/panel/panel/servers"), typeof(CanvasGroup))

	onButton(self, self.searchAccount, function()
		if not self.serversDic or self.searching then
			return
		end

		self:searchAountState(true)

		self.serverPanelCanvas.interactable = false

		self.event:emit(LoginMediator.ON_SEARCH_ACCOUNT, {
			callback = function()
				self.serverPanelCanvas.interactable = true

				self:searchAountState(false)

				return
			end,
			update = function(arg_11_0)
				self:setServerAccountData(arg_11_0)

				return
			end
		})

		return
	end, SFX_CONFIRM)

	self.subViewList = {}
	self.loginPanelView = LoginPanelView.New(self._tf, self.event, self.contextData)

	self.loginPanelView:SetShareData(self.shareData)

	self.registerPanelView = RegisterPanelView.New(self._tf, self.event, self.contextData)

	self.loginPanelView:SetShareData(self.shareData)

	self.tencentLoginPanelView = TencentLoginPanelView.New(self._tf, self.event, self.contextData)

	self.loginPanelView:SetShareData(self.shareData)

	self.airiLoginPanelView = nil
	self.airiLoginPanelView = PLATFORM_CODE == PLATFORM_US and AiriUSLoginPanelView.New(self._tf, self.event, self.contextData) or AiriLoginPanelView.New(self._tf, self.event, self.contextData)

	self.loginPanelView:SetShareData(self.shareData)

	self.transcodeAlertView = TranscodeAlertView.New(self._tf, self.event, self.contextData)

	self.loginPanelView:SetShareData(self.shareData)

	self.yostarAlertView = YostarAlertView.New(self._tf, self.event, self.contextData)

	self.loginPanelView:SetShareData(self.shareData)

	self.subViewList[LoginSceneConst.DEFINE.LOGIN_PANEL_VIEW] = self.loginPanelView
	self.subViewList[LoginSceneConst.DEFINE.REGISTER_PANEL_VIEW] = self.registerPanelView
	self.subViewList[LoginSceneConst.DEFINE.TENCENT_LOGIN_VIEW] = self.tencentLoginPanelView
	self.subViewList[LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW] = self.airiLoginPanelView
	self.subViewList[LoginSceneConst.DEFINE.TRANSCODE_ALERT_VIEW] = self.transcodeAlertView
	self.subViewList[LoginSceneConst.DEFINE.YOSTAR_ALERT_VIEW] = self.yostarAlertView
	self.subViewList[LoginSceneConst.DEFINE.PRESS_TO_LOGIN] = self.pressToLogin
	self.subViewList[LoginSceneConst.DEFINE.BG_LAY] = self.bgLay
	self.subViewList[LoginSceneConst.DEFINE.SERVER_PANEL] = self.serversPanel
	self.subViewList[LoginSceneConst.DEFINE.ACCOUNT_BTN] = self.accountBtn
	self.subViewList[LoginSceneConst.DEFINE.CURRENT_SERVER] = self.currentServer
	self.age = self.adapt:Find("age")

	if PLATFORM_CODE == PLATFORM_CH then
		onButton(self, self.age, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.cadpa_help.tip,
				title = pg.MsgboxMgr.TITLE_CADPA
			})

			return
		end)
		SetActive(self.age, true)
	end

	SetActive(self.age, PLATFORM_CODE == PLATFORM_CH)
	setText(findTF(self.currentServer, "server_name"), "")
	self:switchToServer()
	self:initEvents()

	return
end

function LoginScene:FlushGateWaySwitchBtn()
	self.switchGatewayBtn:Flush()

	if PLATFORM == PLATFORM_OPENHARMONY then
		self.switchGatewayBtn4Oh:Flush()
	end

	return
end

function LoginScene:setServerAccountData(arg_14_1)
	local var_14_0

	for iter_14_0 = 1, #self.serversDic do
		if self.serversDic[iter_14_0].id == arg_14_1.id then
			var_14_0 = self.serversDic[iter_14_0]

			break
		end
	end

	if not var_14_0 then
		return
	end

	local var_14_1 = var_14_0.tf

	if arg_14_1 and arg_14_1.level then
		setActive(findTF(var_14_1, "mark/charactor"), true)
		setActive(findTF(var_14_1, "mark/level"), true)
		setActive(findTF(var_14_1, "mark/searching"), false)
		setText(findTF(var_14_1, "mark/level"), "lv." .. arg_14_1.level)
		setText(findTF(var_14_1, "mark/level"), setColorStr("lv." .. arg_14_1.level, "#ffffffff"))

		var_14_0.level = arg_14_1.level
	elseif arg_14_1 and arg_14_1.isFail then
		setActive(findTF(var_14_1, "mark/level"), true)
		setActive(findTF(var_14_1, "mark/searching"), false)
		setActive(findTF(var_14_1, "mark/charactor"), false)

		var_14_0.level = 0

		setText(findTF(var_14_1, "mark/level"), setColorStr(i18n("query_role_fail"), "#ff9c00ff"))
	else
		setActive(findTF(var_14_1, "mark/level"), true)
		setActive(findTF(var_14_1, "mark/searching"), false)
		setActive(findTF(var_14_1, "mark/charactor"), false)

		var_14_0.level = 0

		setText(findTF(var_14_1, "mark/level"), setColorStr(i18n("query_role_none"), "#d0d0d0FF"))
	end

	return
end

function LoginScene:searchAountState(arg_15_1)
	self.searching = arg_15_1

	for iter_15_0 = 1, #self.serversDic do
		setActive(findTF(self.serversDic[iter_15_0].tf, "mark"), true)

		if arg_15_1 then
			setActive(findTF(self.serversDic[iter_15_0].tf, "mark/charactor"), false)
			setActive(findTF(self.serversDic[iter_15_0].tf, "mark/level"), true)
			setText(findTF(self.serversDic[iter_15_0].tf, "mark/level"), setColorStr(i18n("query_role"), "#d0d0d0FF"))
			setActive(findTF(self.serversDic[iter_15_0].tf, "mark/searching"), true)
		else
			if not self.serversDic[iter_15_0].level then
				setText(findTF(self.serversDic[iter_15_0].tf, "mark/level"), setColorStr(i18n("query_role_fail"), "#d0d0d0FF"))
			end

			setActive(findTF(self.serversDic[iter_15_0].tf, "mark/searching"), false)
		end
	end

	return
end

function LoginScene:initEvents()
	self:bind(LoginSceneConst.SWITCH_SUB_VIEW, function(arg_17_0, arg_17_1)
		self:switchSubView(arg_17_1)

		return
	end)
	self:bind(LoginSceneConst.CLEAR_REGISTER_VIEW, function(arg_18_0)
		self.registerPanelView:ActionInvoke("Clear")

		return
	end)

	return
end

function LoginScene:switchSubView(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self.subViewList) do
		if isa(iter_19_1, BaseSubView) then
			if table.contains(arg_19_1, iter_19_0) then
				iter_19_1:CallbackInvoke(function()
					self.repairBtn:SetAsLastSibling()

					return
				end)
				iter_19_1:Load()
				iter_19_1:ActionInvoke("Show")
			else
				iter_19_1:ActionInvoke("Hide")
			end
		else
			setActive(iter_19_1, table.contains(arg_19_1, iter_19_0))
		end
	end

	if not table.contains(arg_19_1, LoginSceneConst.DEFINE.SERVER_PANEL) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.serversPanel, self._tf)
	end

	if table.contains(arg_19_1, LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW) then
		setActive(self.airiUidTxt, false)
	end

	self.userAgreenTF:SetAsLastSibling()
	self.repairBtn:SetAsLastSibling()

	return
end

function LoginScene:onBackPressed()
	if self.searching then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self.serversPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.serversPanel, self._tf)
		setActive(self.serversPanel, false)

		return
	end

	if isActive(self.userAgreenTF) then
		setActive(self.userAgreenTF, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.userAgreenTF, self._tf)

		return
	end

	pg.SdkMgr.GetInstance():OnAndoridBackPress()

	return
end

function LoginScene:setUserData(arg_22_1)
	setActive(self.airiUidTxt, true)
	setText(self.airiUidTxt, "uid: " .. arg_22_1.arg2)

	return
end

function LoginScene:showUserAgreement(arg_23_1)
	local var_23_0

	if PLATFORM_CODE == PLATFORM_CH then
		self.userAgreenConfirmTF:GetComponent(typeof(Image)).color = Color.New(0.7843137254901961, 0.7843137254901961, 0.7843137254901961, 0.5019607843137255)
	else
		var_23_0 = true
	end

	local UserAgreement = require("ShareCfg.UserAgreement")

	setActive(self.userAgreenTF, true)
	pg.UIMgr.GetInstance():BlurPanel(self.userAgreenTF)
	setText(self.userAgreenTF:Find("window/container/scrollrect/content/Text"), UserAgreement.content)
	onButton(self, self.userAgreenConfirmTF, function()
		if var_23_0 then
			setActive(self.userAgreenTF, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.userAgreenTF, self._tf)

			if arg_23_1 then
				arg_23_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("read_the_user_agreement"))
		end

		return
	end)
	onScroll(self, self.userAgreenTF:Find("window/container/scrollrect"), function(arg_25_0)
		if arg_25_0.y <= 0.01 and not var_23_0 then
			var_23_0 = true

			if PLATFORM_CODE == PLATFORM_CH then
				self.userAgreenConfirmTF:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)
			end
		end

		return
	end)

	return
end

function LoginScene:setBg()
	self.bgImg = self._tf:Find("background/bg"):GetComponent(typeof(Image))

	if not self.isCriBg then
		setImageSprite(self.bgImg, self.staticBgSprite)
	else
		self.bgImg.enabled = false

		self.criBgGo.transform:SetParent(self.bgImg.transform, false)
		self.criBgGo.transform:SetAsFirstSibling()

		local var_26_0 = self.criBgGo:GetComponent("AspectRatioFitter")

		if var_26_0 then
			var_26_0.enabled = true
		end
	end

	return
end

function LoginScene:setLastLogin(arg_27_1)
	self.shareData.lastLoginUser = arg_27_1

	return
end

function LoginScene:setAutoLogin()
	self.shareData.autoLoginEnabled = true

	return
end

function LoginScene:setLastLoginServer(arg_29_1)
	if not arg_29_1 then
		setText(findTF(self.currentServer, "server_name"), "")

		self.shareData.lastLoginServer = nil

		self:updateAdviceServer()

		return
	end

	setText(findTF(self.currentServer, "server_name"), arg_29_1.name)

	self.shareData.lastLoginServer = arg_29_1

	return
end

function LoginScene:didEnter()
	onButton(self, self.closeUserAgreenTF, function()
		if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
			setActive(self.userAgreenTF, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.userAgreenTF, self._tf)
		else
			setActive(self.userAgreenMainTF, false)
			onNextTick(function()
				setActive(self.userAgreenMainTF, true)

				return
			end)
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.privateBtn, function()
		pg.SdkMgr.GetInstance():ShowPrivate()

		return
	end, SFX_PANEL)
	onButton(self, self.licenceBtn, function()
		pg.SdkMgr.GetInstance():ShowLicence()

		return
	end, SFX_PANEL)
	setActive(self.privateBtn, PLATFORM_CODE == PLATFORM_CH)
	setActive(self.licenceBtn, PLATFORM_CODE == PLATFORM_CH)

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		onButton(self, self.userDisagreeConfirmTF, function()
			setActive(self.userAgreenTF, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.userAgreenTF, self._tf)

			return
		end)
	end

	setActive(self.serviceBtn, PLATFORM_CODE == PLATFORM_KR)
	onButton(self, self.serviceBtn, function()
		if PLATFORM_CODE == PLATFORM_KR then
			pg.SdkMgr.GetInstance():UserCenter()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_systemClose"))
		end

		return
	end, SFX_MAIN)
	onButton(self, self.accountBtn, function()
		local var_37_0 = pg.SdkMgr.GetInstance():GetLoginType() ~= LoginType.PLATFORM_INNER

		if not var_37_0 then
			self:switchToLogin()
		elseif var_37_0 and PLATFORM_KR == PLATFORM_CODE then
			pg.SdkMgr.GetInstance():SwitchAccount()
		end

		return
	end, SFX_MAIN)
	onButton(self, self.repairBtn, function()
		pg.RepairResMgr.GetInstance():Repair()

		return
	end)

	local function var_30_0()
		local var_39_0 = pg.SdkMgr.GetInstance():GetLoginType()

		if var_39_0 == LoginType.PLATFORM then
			pg.SdkMgr.GetInstance():LoginSdk()
		elseif var_39_0 == LoginType.PLATFORM_TENCENT then
			self:switchToTencentLogin()
		elseif var_39_0 == LoginType.PLATFORM_INNER then
			self:switchToLogin()
		end

		return
	end

	onButton(self, self.filingBtn, function()
		Application.OpenURL("http://sq.ccm.gov.cn:80/ccnt/sczr/service/business/emark/gameNetTag/4028c08b58bd467b0158bd8bd80d062a")

		return
	end, SFX_PANEL)
	onButton(self, self.currentServer, function()
		if table.getCount(self.serverList or {}) == 0 then
			var_30_0()
		else
			pg.UIMgr.GetInstance():BlurPanel(self.serversPanel)
			setActive(self.serversPanel, true)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.serversPanel, function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.serversPanel, self._tf)
		setActive(self.serversPanel, false)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("background"), function()
		if pg.CpkPlayMgr.GetInstance():OnPlaying() then
			return
		end

		if not self.initFinished then
			return
		end

		if self.isNeedResCheck then
			self.event:emit(LoginMediator.CHECK_RES)

			return
		end

		if getProxy(SettingsProxy):CheckNeedUserAgreement() then
			self.event:emit(LoginMediator.ON_LOGIN_PROCESS)

			return
		end

		if go(self.pressToLogin).activeSelf then
			if table.getCount(self.serverList or {}) == 0 then
				var_30_0()

				return
			end

			if not self.shareData.lastLoginServer then
				pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_choiseServer"))

				return
			end

			if self.shareData.lastLoginServer.status == Server.STATUS.VINDICATE or self.shareData.lastLoginServer.status == Server.STATUS.FULL then
				ServerStateChecker.New():Execute(function(arg_44_0)
					if arg_44_0 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_server_disabled"))
					else
						self.event:emit(LoginMediator.ON_SERVER, self.shareData.lastLoginServer)
						pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
					end

					return
				end)

				return
			end

			self.event:emit(LoginMediator.ON_SERVER, self.shareData.lastLoginServer)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		end

		return
	end)

	if self.isOpPlay then
		onButton(self, self.opBtn, function()
			if self.initFinished then
				if not pg.CpkPlayMgr.GetInstance():OnPlaying() then
					self:playOpening()
				end
			end

			return
		end)

		if PLATFORM_CODE ~= PLATFORM_JP and PlayerPrefs.GetString("op_ver", "") ~= self.opVersion then
			self:playOpening(function()
				PlayerPrefs.SetString("op_ver", self.opVersion)
				self:playExtraVoice()

				self.initFinished = true

				self.event:emit(LoginMediator.ON_LOGIN_PROCESS)

				return
			end)

			return
		end

		self.event:emit(LoginMediator.ON_LOGIN_PROCESS)
	else
		self.event:emit(LoginMediator.ON_LOGIN_PROCESS)
	end

	self:playExtraVoice()

	self.initFinished = true

	self:InitPrivateAndLicence()

	return
end

function LoginScene:InitPrivateAndLicence()
	local var_47_0 = PLATFORM_CODE == PLATFORM_CH or IsUnityEditor

	setActive(self.privateBtn, PLATFORM_CODE == PLATFORM_CH or IsUnityEditor)
	setActive(self.licenceBtn, var_47_0)

	if var_47_0 then
		onButton(self, self.privateBtn, function()
			pg.SdkMgr.GetInstance():ShowPrivate()

			return
		end, SFX_PANEL)
		onButton(self, self.licenceBtn, function()
			pg.SdkMgr.GetInstance():ShowLicence()

			return
		end, SFX_PANEL)
	end

	return
end

local function var_0_2()
	if pg.gameset.login_extra_voice.description and #pg.gameset.login_extra_voice.description > 0 then
		return "cv-" .. pg.gameset.login_extra_voice.description[math.clamp(math.floor(math.random() * #pg.gameset.login_extra_voice.description) + 1, 1, #pg.gameset.login_extra_voice.description)], "extra"
	end

	return nil, nil
end

local function var_0_3(arg_51_0)
	if pg.TimeMgr.GetInstance():inTime(arg_51_0.description[2]) then
		return arg_51_0.description[1], "extra" .. math.random(1, arg_51_0.description[3])
	end

	return nil, nil
end

function LoginScene:GetExtraVoiceSheetAndCue()
	local var_52_0
	local var_52_1

	if pg.gameset.new_login_extra_voice then
		var_52_0, var_52_1 = var_0_3(pg.gameset.new_login_extra_voice)
	end

	if not var_52_0 or not var_52_1 then
		var_52_0, var_52_1 = var_0_2()
	end

	return var_52_0, var_52_1
end

function LoginScene:playExtraVoice()
	local var_53_0, var_53_1 = self:GetExtraVoiceSheetAndCue()

	if var_53_0 and var_53_1 then
		self.loginCueSheet = var_53_0

		pg.CriMgr.GetInstance():PlayCV_V3(var_53_0, var_53_1)
	end

	return
end

function LoginScene:unloadExtraVoice()
	if self.loginCueSheet then
		pg.CriMgr.GetInstance():UnloadCueSheet(self.loginCueSheet)

		self.loginCueSheet = nil
	end

	return
end

function LoginScene:autoLogin()
	if self.shareData.lastLoginUser then
		if self.shareData.autoLoginEnabled then
			self.event:emit(LoginMediator.ON_LOGIN, self.shareData.lastLoginUser)
		end

		if self.loginPanelView:GetLoaded() then
			if self.shareData.lastLoginUser.type == 1 then
				self.loginPanelView:ActionInvoke("SetContent", self.shareData.lastLoginUser.arg2, self.shareData.lastLoginUser.arg3)
			elseif self.shareData.lastLoginUser.type == 2 then
				self.loginPanelView:ActionInvoke("SetContent", self.shareData.lastLoginUser.arg1, self.shareData.lastLoginUser.arg2)
			end
		end
	end

	return
end

local var_0_4 = {
	{
		0.403921568627451,
		1,
		0.2196078431372549,
		0.6274509803921569
	},
	{
		0.6078431372549019,
		0.6078431372549019,
		0.6078431372549019,
		0.6274509803921569
	},
	{
		1,
		0.3607843137254902,
		0.2196078431372549,
		0.6274509803921569
	},
	{
		1,
		0.6588235294117647,
		0.2196078431372549,
		0.6274509803921569
	}
}

function LoginScene:updateServerTF(arg_56_1, arg_56_2)
	setText(findTF(arg_56_1, "name"), "-  " .. arg_56_2.name .. "  -")
	self:setSpriteTo(self.iconSpries[arg_56_2.status + 1], findTF(arg_56_1, "statu"), true)

	findTF(arg_56_1, "statu_1"):GetComponent("Image").color = Color.New(var_0_4[arg_56_2.status + 1][1], var_0_4[arg_56_2.status + 1][2], var_0_4[arg_56_2.status + 1][3], var_0_4[arg_56_2.status + 1][4])

	setActive(findTF(arg_56_1, "mark"), arg_56_2.isLogined)
	setActive(arg_56_1:Find("tag_new"), arg_56_2.isNew)
	setActive(arg_56_1:Find("tag_hot"), arg_56_2.isHot)
	onButton(self, arg_56_1, function()
		if arg_56_2.status == Server.STATUS.VINDICATE then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_server_vindicate"))

			return
		end

		if arg_56_2.status == Server.STATUS.FULL then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_server_full"))

			return
		end

		self:setLastLoginServer(arg_56_2)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.serversPanel, self._tf)
		setActive(self.serversPanel, false)

		return
	end, SFX_CONFIRM)

	return
end

function LoginScene:updateAdviceServer()
	if not self.recentTF or not self.adviceTF then
		return
	end

	setActive(self.recentTF, self.shareData.lastLoginServer)

	if self.shareData.lastLoginServer then
		self:updateServerTF(findTF(self.recentTF, "server"), self.shareData.lastLoginServer)
	end

	local var_58_0 = getProxy(ServerProxy).firstServer

	setActive(self.adviceTF, var_58_0)

	if var_58_0 then
		self:updateServerTF(findTF(self.adviceTF, "server"), var_58_0)
	end

	return
end

function LoginScene:updateServerList(arg_59_1)
	self.serverList = arg_59_1

	local var_59_0 = _.sort(_.values(arg_59_1), function(arg_60_0, arg_60_1)
		return arg_60_0.sortIndex < arg_60_1.sortIndex
	end)

	removeAllChildren(self.servers)

	if IsUnityEditor then
		table.sort(var_59_0, function(arg_61_0, arg_61_1)
			return string.byte(string.lower(arg_61_0.name), 1) > string.byte(string.lower(arg_61_1.name), 1)
		end)
	end

	self.serversDic = {}

	for iter_59_0, iter_59_1 in pairs(var_59_0) do
		local var_59_1 = cloneTplTo(self.serverTpl, self.servers)

		self:updateServerTF(var_59_1, iter_59_1)
		table.insert(self.serversDic, {
			server = iter_59_1,
			tf = var_59_1,
			id = iter_59_1.id
		})
	end

	return
end

function LoginScene:fillterRefundServer()
	local var_62_0 = getProxy(UserProxy)
	local var_62_1 = {}

	if var_62_0.data.limitServerIds and #var_62_0.data.limitServerIds > 0 and self.serverList and #self.serverList > 0 then
		local var_62_2

		for iter_62_0, iter_62_1 in pairs(self.serverList) do
			for iter_62_2, iter_62_3 in pairs(var_62_0.data.limitServerIds) do
				if var_62_0.data.limitServerIds[iter_62_2] == iter_62_1.id and not false then
					var_62_2 = not var_62_2 and "\n" .. iter_62_1.name or var_62_2 .. "," .. iter_62_1.name

					table.insert(var_62_1, iter_62_1)
				end
			end
		end

		self:updateServerList(var_62_1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			hideClose = true,
			content = i18n("login_arrears_tips", var_62_2),
			onYes = function()
				return
			end
		})
	end

	return
end

function LoginScene:switchToTencentLogin()
	self:switchSubView({
		LoginSceneConst.DEFINE.TENCENT_LOGIN_VIEW
	})

	return
end

function LoginScene:switchToAiriLogin()
	self:switchSubView({
		LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
		LoginSceneConst.DEFINE.PRESS_TO_LOGIN
	})

	return
end

function LoginScene:switchToLogin()
	self:switchSubView({
		LoginSceneConst.DEFINE.LOGIN_PANEL_VIEW
	})

	return
end

function LoginScene:switchToRegister()
	self:switchSubView({
		LoginSceneConst.DEFINE.REGISTER_PANEL_VIEW
	})

	return
end

function LoginScene:switchToServer()
	self:updateAdviceServer()

	if pg.SdkMgr.GetInstance():GetLoginType() ~= LoginType.PLATFORM_INNER and PLATFORM_CODE ~= PLATFORM_KR then
		self:switchSubView({
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN,
			LoginSceneConst.DEFINE.CURRENT_SERVER,
			LoginSceneConst.DEFINE.BG_LAY
		})
	else
		self:switchSubView({
			LoginSceneConst.DEFINE.ACCOUNT_BTN,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN,
			LoginSceneConst.DEFINE.CURRENT_SERVER,
			LoginSceneConst.DEFINE.BG_LAY
		})
	end

	return
end

function LoginScene:SwitchToWaitPanel(arg_69_1)
	local var_69_0 = self.adapt:Find("Msgbox")
	local var_69_1 = var_69_0:Find("window/content")

	self.waitTimer = nil

	local var_69_3 = arg_69_1

	self.waitTimer = Timer.New(function()
		setText(var_69_1, i18n("login_wait_tip", var_69_3))

		arg_69_1 = arg_69_1 - 1

		if math.random(0, 1) == 1 then
			var_69_3 = arg_69_1
		end

		if arg_69_1 <= 0 then
			triggerButton(self._tf:Find("background"))
			self.waitTimer:Stop()

			self.waitTimer = nil
		end

		return
	end, 1, -1)

	self.waitTimer:Start()
	self.waitTimer.func()
	setActive(var_69_0, true)

	return
end

function LoginScene:willExit()
	if self.waitTimer then
		self.waitTimer:Stop()

		self.waitTimer = nil
	end

	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()
	self.loginPanelView:Destroy()
	self.registerPanelView:Destroy()
	self.tencentLoginPanelView:Destroy()
	self.airiLoginPanelView:Destroy()
	self.transcodeAlertView:Destroy()
	self.yostarAlertView:Destroy()
	self.switchGatewayBtn:Dispose()

	if PLATFORM == PLATFORM_OPENHARMONY then
		self.switchGatewayBtn4Oh:Dispose()
	end

	self.iconSpries = nil

	return
end

function LoginScene:playOpening(arg_72_1)
	pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
		self.cg = self.cg or GetOrAddComponent(self._tf, "CanvasGroup")
		self.cg.alpha = 0

		return
	end, function()
		self.cg.alpha = 1

		if arg_72_1 then
			arg_72_1()
		end

		return
	end, "ui", "opening", true, false)

	self.onPlayingOP = true

	return
end

function LoginScene:closeYostarAlertView()
	if self.yostarAlertView and self.yostarAlertView:CheckState(BaseSubView.STATES.INITED) then
		self.yostarAlertView:Destroy()
	end

	return
end

function LoginScene:onLoadDataDone()
	self:unloadExtraVoice()

	if getProxy(PlayerProxy) then
		getProxy(PlayerProxy):setFlag("login", true)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.MAINUI, {
			isFromLogin = true
		})
	end

	return
end

return LoginScene
