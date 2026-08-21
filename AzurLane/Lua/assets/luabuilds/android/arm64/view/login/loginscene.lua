local var_0_0 = class("LoginScene", import("..base.BaseUI"))
local var_0_1 = 1

function var_0_0.getUIName(arg_1_0)
	return "LoginUI2"
end

function var_0_0.getBGM(arg_2_0)
	if arg_2_0.bgmName and arg_2_0.bgmName ~= "" then
		return arg_2_0.bgmName
	end

	return var_0_0.super.getBGM(arg_2_0)
end

function var_0_0.preload(arg_3_0, arg_3_1)
	arg_3_0.iconSpries = {
		"reources/statu_green",
		"reources/statu_gray",
		"reources/statu_red",
		"reources/statu_org"
	}

	local var_3_0

	if LOGIN_HX then
		var_3_0 = PlayerProxy.GetDeviceMaxPlayerLevel() <= pg.gameset.LOGIN_HX_LV.key_value
	end

	seriesAsync({
		function(arg_4_0)
			arg_3_0.isCriBg, arg_3_0.bgPath, arg_3_0.bgmName, arg_3_0.isOpPlay, arg_3_0.opVersion = getLoginConfig()

			local var_4_0

			if arg_3_0.isCriBg then
				LoadAndInstantiateAsync("effect", arg_3_0.bgPath, function(arg_5_0)
					arg_3_0.criBgGo = arg_5_0

					arg_4_0()

					return
				end)

				goto label_4_0

				var_4_0 = LoadSpriteAsync
			end

			var_4_0((var_3_0 and "loadingbg_hx/" or "loadingbg/") .. arg_3_0.bgPath, function(arg_6_0)
				arg_3_0.staticBgSprite = arg_6_0

				arg_4_0()

				return
			end)

			::label_4_0::

			return
		end
	}, arg_3_1)

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0:setBg()

	arg_7_0.adapt = arg_7_0._tf:Find("adapt")
	arg_7_0.version = arg_7_0.adapt:Find("version")
	arg_7_0.version:GetComponent("Text").text = "ver " .. BundleWizard.Inst:GetGroupMgr("DEFAULT_RES").CurrentVersion:ToString()
	arg_7_0.bgLay = arg_7_0.adapt:Find("bg_lay")
	arg_7_0.accountBtn = arg_7_0.adapt:Find("bg_lay/buttons/account_button")
	arg_7_0.repairBtn = arg_7_0.adapt:Find("btns/repair_button")
	arg_7_0.privateBtn = arg_7_0.adapt:Find("btns/private_btn")
	arg_7_0.licenceBtn = arg_7_0.adapt:Find("btns/Licence_btn")
	arg_7_0.chInfo = arg_7_0._tf:Find("background/info")

	setActive(arg_7_0.chInfo, PLATFORM_CODE == PLATFORM_CH)

	if PLATFORM_CODE == PLATFORM_CH then
		arg_7_0.urlClick = arg_7_0.chInfo:Find("urlClick")

		onButton(arg_7_0, arg_7_0.urlClick, function()
			Application.OpenURL("https://beian.miit.gov.cn/#/home")

			return
		end)
	end

	arg_7_0.pressToLogin = GetOrAddComponent(arg_7_0._tf:Find("background/press_to_login"), "CanvasGroup")

	LeanTween.alphaCanvas(arg_7_0.pressToLogin, 0.25, var_0_1):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

	arg_7_0.currentServer = arg_7_0.adapt:Find("current_server")
	arg_7_0.serviceBtn = arg_7_0.adapt:Find("bg_lay/buttons/service_button")
	arg_7_0.filingBtn = arg_7_0.adapt:Find("filingBtn")

	setActive(arg_7_0.filingBtn, PLATFORM_CODE == PLATFORM_CH)

	arg_7_0.serversPanel = arg_7_0.adapt:Find("servers")
	arg_7_0.servers = arg_7_0.serversPanel:Find("panel/panel/servers/content/server_list")
	arg_7_0.serverTpl = arg_7_0:getTpl("server_tpl")
	arg_7_0.recentTF = arg_7_0.serversPanel:Find("panel/panel/servers/content/advice_panel/recent")
	arg_7_0.adviceTF = arg_7_0.serversPanel:Find("panel/panel/servers/content/advice_panel/advice")
	arg_7_0.userAgreenTF = arg_7_0.adapt:Find("UserAgreement")
	arg_7_0.userAgreenMainTF = arg_7_0.adapt:Find("UserAgreement/window")
	arg_7_0.closeUserAgreenTF = arg_7_0.userAgreenTF:Find("window/close_btn")
	arg_7_0.userAgreenConfirmTF = arg_7_0.adapt:Find("UserAgreement/window/accept_btn")
	arg_7_0.userDisagreeConfirmTF = arg_7_0.adapt:Find("UserAgreement/window/disagree_btn")
	arg_7_0.switchGatewayBtn = SwitchGatewayBtn.New(arg_7_0.adapt:Find("servers/panel/panel/switch_platform"))

	if PLATFORM == PLATFORM_OPENHARMONY then
		arg_7_0.switchGatewayBtn4Oh = SwitchGatewayBtn4OpenHarmony.New(arg_7_0.adapt:Find("servers/panel/panel/switch_platform"))
	end

	setActive(arg_7_0.userAgreenTF, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.userAgreenTF, arg_7_0._tf)

	arg_7_0.opBtn = arg_7_0.adapt:Find("bg_lay/buttons/opBtn")

	if arg_7_0.opBtn then
		setActive(arg_7_0.opBtn, arg_7_0.isOpPlay)
	end

	arg_7_0.airiUidTxt = arg_7_0.adapt:Find("airi_uid")
	arg_7_0.shareData = {}
	arg_7_0.searchAccount = arg_7_0.serversPanel:Find("panel/panel/searchAccount")

	setText(findTF(arg_7_0.searchAccount, "text"), i18n("query_role_button"))

	arg_7_0.serverPanelCanvas = GetComponent(arg_7_0.adapt:Find("servers/panel/panel/servers"), typeof(CanvasGroup))

	onButton(arg_7_0, arg_7_0.searchAccount, function()
		if not arg_7_0.serversDic or arg_7_0.searching then
			return
		end

		arg_7_0:searchAountState(true)

		arg_7_0.serverPanelCanvas.interactable = false

		arg_7_0.event:emit(LoginMediator.ON_SEARCH_ACCOUNT, {
			callback = function()
				arg_7_0.serverPanelCanvas.interactable = true

				arg_7_0:searchAountState(false)

				return
			end,
			update = function(arg_11_0)
				arg_7_0:setServerAccountData(arg_11_0)

				return
			end
		})

		return
	end, SFX_CONFIRM)

	arg_7_0.subViewList = {}
	arg_7_0.loginPanelView = LoginPanelView.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	arg_7_0.loginPanelView:SetShareData(arg_7_0.shareData)

	arg_7_0.registerPanelView = RegisterPanelView.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	arg_7_0.loginPanelView:SetShareData(arg_7_0.shareData)

	arg_7_0.tencentLoginPanelView = TencentLoginPanelView.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	arg_7_0.loginPanelView:SetShareData(arg_7_0.shareData)

	arg_7_0.airiLoginPanelView = nil
	arg_7_0.airiLoginPanelView = PLATFORM_CODE == PLATFORM_US and AiriUSLoginPanelView.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData) or AiriLoginPanelView.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	arg_7_0.loginPanelView:SetShareData(arg_7_0.shareData)

	arg_7_0.transcodeAlertView = TranscodeAlertView.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	arg_7_0.loginPanelView:SetShareData(arg_7_0.shareData)

	arg_7_0.yostarAlertView = YostarAlertView.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	arg_7_0.loginPanelView:SetShareData(arg_7_0.shareData)

	arg_7_0.subViewList[LoginSceneConst.DEFINE.LOGIN_PANEL_VIEW] = arg_7_0.loginPanelView
	arg_7_0.subViewList[LoginSceneConst.DEFINE.REGISTER_PANEL_VIEW] = arg_7_0.registerPanelView
	arg_7_0.subViewList[LoginSceneConst.DEFINE.TENCENT_LOGIN_VIEW] = arg_7_0.tencentLoginPanelView
	arg_7_0.subViewList[LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW] = arg_7_0.airiLoginPanelView
	arg_7_0.subViewList[LoginSceneConst.DEFINE.TRANSCODE_ALERT_VIEW] = arg_7_0.transcodeAlertView
	arg_7_0.subViewList[LoginSceneConst.DEFINE.YOSTAR_ALERT_VIEW] = arg_7_0.yostarAlertView
	arg_7_0.subViewList[LoginSceneConst.DEFINE.PRESS_TO_LOGIN] = arg_7_0.pressToLogin
	arg_7_0.subViewList[LoginSceneConst.DEFINE.BG_LAY] = arg_7_0.bgLay
	arg_7_0.subViewList[LoginSceneConst.DEFINE.SERVER_PANEL] = arg_7_0.serversPanel
	arg_7_0.subViewList[LoginSceneConst.DEFINE.ACCOUNT_BTN] = arg_7_0.accountBtn
	arg_7_0.subViewList[LoginSceneConst.DEFINE.CURRENT_SERVER] = arg_7_0.currentServer
	arg_7_0.age = arg_7_0.adapt:Find("age")

	if PLATFORM_CODE == PLATFORM_CH then
		onButton(arg_7_0, arg_7_0.age, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.cadpa_help.tip,
				title = pg.MsgboxMgr.TITLE_CADPA
			})

			return
		end)
		SetActive(arg_7_0.age, true)
	end

	SetActive(arg_7_0.age, PLATFORM_CODE == PLATFORM_CH)
	setText(findTF(arg_7_0.currentServer, "server_name"), "")
	arg_7_0:switchToServer()
	arg_7_0:initEvents()

	return
end

function var_0_0.FlushGateWaySwitchBtn(arg_13_0)
	arg_13_0.switchGatewayBtn:Flush()

	if PLATFORM == PLATFORM_OPENHARMONY then
		arg_13_0.switchGatewayBtn4Oh:Flush()
	end

	return
end

function var_0_0.setServerAccountData(arg_14_0, arg_14_1)
	local var_14_0

	for iter_14_0 = 1, #arg_14_0.serversDic do
		if arg_14_0.serversDic[iter_14_0].id == arg_14_1.id then
			var_14_0 = arg_14_0.serversDic[iter_14_0]

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

function var_0_0.searchAountState(arg_15_0, arg_15_1)
	arg_15_0.searching = arg_15_1

	for iter_15_0 = 1, #arg_15_0.serversDic do
		setActive(findTF(arg_15_0.serversDic[iter_15_0].tf, "mark"), true)

		if arg_15_1 then
			setActive(findTF(arg_15_0.serversDic[iter_15_0].tf, "mark/charactor"), false)
			setActive(findTF(arg_15_0.serversDic[iter_15_0].tf, "mark/level"), true)
			setText(findTF(arg_15_0.serversDic[iter_15_0].tf, "mark/level"), setColorStr(i18n("query_role"), "#d0d0d0FF"))
			setActive(findTF(arg_15_0.serversDic[iter_15_0].tf, "mark/searching"), true)
		else
			if not arg_15_0.serversDic[iter_15_0].level then
				setText(findTF(arg_15_0.serversDic[iter_15_0].tf, "mark/level"), setColorStr(i18n("query_role_fail"), "#d0d0d0FF"))
			end

			setActive(findTF(arg_15_0.serversDic[iter_15_0].tf, "mark/searching"), false)
		end
	end

	return
end

function var_0_0.initEvents(arg_16_0)
	arg_16_0:bind(LoginSceneConst.SWITCH_SUB_VIEW, function(arg_17_0, arg_17_1)
		arg_16_0:switchSubView(arg_17_1)

		return
	end)
	arg_16_0:bind(LoginSceneConst.CLEAR_REGISTER_VIEW, function(arg_18_0)
		arg_16_0.registerPanelView:ActionInvoke("Clear")

		return
	end)

	return
end

function var_0_0.switchSubView(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.subViewList) do
		if isa(iter_19_1, BaseSubView) then
			if table.contains(arg_19_1, iter_19_0) then
				iter_19_1:CallbackInvoke(function()
					arg_19_0.repairBtn:SetAsLastSibling()

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
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_19_0.serversPanel, arg_19_0._tf)
	end

	if table.contains(arg_19_1, LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW) then
		setActive(arg_19_0.airiUidTxt, false)
	end

	arg_19_0.userAgreenTF:SetAsLastSibling()
	arg_19_0.repairBtn:SetAsLastSibling()

	return
end

function var_0_0.onBackPressed(arg_21_0)
	if arg_21_0.searching then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(arg_21_0.serversPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0.serversPanel, arg_21_0._tf)
		setActive(arg_21_0.serversPanel, false)

		return
	end

	if isActive(arg_21_0.userAgreenTF) then
		setActive(arg_21_0.userAgreenTF, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0.userAgreenTF, arg_21_0._tf)

		return
	end

	pg.SdkMgr.GetInstance():OnAndoridBackPress()

	return
end

function var_0_0.setUserData(arg_22_0, arg_22_1)
	setActive(arg_22_0.airiUidTxt, true)
	setText(arg_22_0.airiUidTxt, "uid: " .. arg_22_1.arg2)

	return
end

function var_0_0.showUserAgreement(arg_23_0, arg_23_1)
	local var_23_0

	if PLATFORM_CODE == PLATFORM_CH then
		arg_23_0.userAgreenConfirmTF:GetComponent(typeof(Image)).color = Color.New(0.7843137254901961, 0.7843137254901961, 0.7843137254901961, 0.5019607843137255)
	else
		var_23_0 = true
	end

	local var_23_1 = require("ShareCfg.UserAgreement")

	setActive(arg_23_0.userAgreenTF, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_23_0.userAgreenTF)
	setText(arg_23_0.userAgreenTF:Find("window/container/scrollrect/content/Text"), var_23_1.content)
	onButton(arg_23_0, arg_23_0.userAgreenConfirmTF, function()
		if var_23_0 then
			setActive(arg_23_0.userAgreenTF, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_23_0.userAgreenTF, arg_23_0._tf)

			if arg_23_1 then
				arg_23_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("read_the_user_agreement"))
		end

		return
	end)
	onScroll(arg_23_0, arg_23_0.userAgreenTF:Find("window/container/scrollrect"), function(arg_25_0)
		if arg_25_0.y <= 0.01 and not var_23_0 then
			var_23_0 = true

			if PLATFORM_CODE == PLATFORM_CH then
				arg_23_0.userAgreenConfirmTF:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)
			end
		end

		return
	end)

	return
end

function var_0_0.setBg(arg_26_0)
	arg_26_0.bgImg = arg_26_0._tf:Find("background/bg"):GetComponent(typeof(Image))

	if not arg_26_0.isCriBg then
		setImageSprite(arg_26_0.bgImg, arg_26_0.staticBgSprite)
	else
		arg_26_0.bgImg.enabled = false

		arg_26_0.criBgGo.transform:SetParent(arg_26_0.bgImg.transform, false)
		arg_26_0.criBgGo.transform:SetAsFirstSibling()

		local var_26_0 = arg_26_0.criBgGo:GetComponent("AspectRatioFitter")

		if var_26_0 then
			var_26_0.enabled = true
		end
	end

	return
end

function var_0_0.setLastLogin(arg_27_0, arg_27_1)
	arg_27_0.shareData.lastLoginUser = arg_27_1

	return
end

function var_0_0.setAutoLogin(arg_28_0)
	arg_28_0.shareData.autoLoginEnabled = true

	return
end

function var_0_0.setLastLoginServer(arg_29_0, arg_29_1)
	if not arg_29_1 then
		setText(findTF(arg_29_0.currentServer, "server_name"), "")

		arg_29_0.shareData.lastLoginServer = nil

		arg_29_0:updateAdviceServer()

		return
	end

	setText(findTF(arg_29_0.currentServer, "server_name"), arg_29_1.name)

	arg_29_0.shareData.lastLoginServer = arg_29_1

	return
end

function var_0_0.didEnter(arg_30_0)
	onButton(arg_30_0, arg_30_0.closeUserAgreenTF, function()
		if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
			setActive(arg_30_0.userAgreenTF, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0.userAgreenTF, arg_30_0._tf)
		else
			setActive(arg_30_0.userAgreenMainTF, false)
			onNextTick(function()
				setActive(arg_30_0.userAgreenMainTF, true)

				return
			end)
		end

		return
	end, SFX_CANCEL)
	onButton(arg_30_0, arg_30_0.privateBtn, function()
		pg.SdkMgr.GetInstance():ShowPrivate()

		return
	end, SFX_PANEL)
	onButton(arg_30_0, arg_30_0.licenceBtn, function()
		pg.SdkMgr.GetInstance():ShowLicence()

		return
	end, SFX_PANEL)
	setActive(arg_30_0.privateBtn, PLATFORM_CODE == PLATFORM_CH)
	setActive(arg_30_0.licenceBtn, PLATFORM_CODE == PLATFORM_CH)

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		onButton(arg_30_0, arg_30_0.userDisagreeConfirmTF, function()
			setActive(arg_30_0.userAgreenTF, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0.userAgreenTF, arg_30_0._tf)

			return
		end)
	end

	setActive(arg_30_0.serviceBtn, PLATFORM_CODE == PLATFORM_KR)
	onButton(arg_30_0, arg_30_0.serviceBtn, function()
		if PLATFORM_CODE == PLATFORM_KR then
			pg.SdkMgr.GetInstance():UserCenter()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_systemClose"))
		end

		return
	end, SFX_MAIN)
	onButton(arg_30_0, arg_30_0.accountBtn, function()
		local var_37_0 = pg.SdkMgr.GetInstance():GetLoginType() ~= LoginType.PLATFORM_INNER

		if not var_37_0 then
			arg_30_0:switchToLogin()
		elseif var_37_0 and PLATFORM_KR == PLATFORM_CODE then
			pg.SdkMgr.GetInstance():SwitchAccount()
		end

		return
	end, SFX_MAIN)
	onButton(arg_30_0, arg_30_0.repairBtn, function()
		pg.RepairResMgr.GetInstance():Repair()

		return
	end)

	local function var_30_0()
		local var_39_0 = pg.SdkMgr.GetInstance():GetLoginType()

		if var_39_0 == LoginType.PLATFORM then
			pg.SdkMgr.GetInstance():LoginSdk()
		elseif var_39_0 == LoginType.PLATFORM_TENCENT then
			arg_30_0:switchToTencentLogin()
		elseif var_39_0 == LoginType.PLATFORM_INNER then
			arg_30_0:switchToLogin()
		end

		return
	end

	onButton(arg_30_0, arg_30_0.filingBtn, function()
		Application.OpenURL("http://sq.ccm.gov.cn:80/ccnt/sczr/service/business/emark/gameNetTag/4028c08b58bd467b0158bd8bd80d062a")

		return
	end, SFX_PANEL)
	onButton(arg_30_0, arg_30_0.currentServer, function()
		local var_41_0 = arg_30_0.serverList or {}

		if table.getCount(var_41_0) == 0 then
			var_30_0()
		else
			pg.UIMgr.GetInstance():BlurPanel(arg_30_0.serversPanel)
			setActive(arg_30_0.serversPanel, true)
		end

		return
	end, SFX_PANEL)
	onButton(arg_30_0, arg_30_0.serversPanel, function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0.serversPanel, arg_30_0._tf)
		setActive(arg_30_0.serversPanel, false)

		return
	end, SFX_CANCEL)
	onButton(arg_30_0, arg_30_0._tf:Find("background"), function()
		if pg.CpkPlayMgr.GetInstance():OnPlaying() then
			return
		end

		if not arg_30_0.initFinished then
			return
		end

		if arg_30_0.isNeedResCheck then
			arg_30_0.event:emit(LoginMediator.CHECK_RES)

			return
		end

		local var_43_0 = getProxy(SettingsProxy)

		if var_43_0:CheckNeedUserAgreement() then
			arg_30_0.event:emit(LoginMediator.ON_LOGIN_PROCESS)

			return
		end

		if go(arg_30_0.pressToLogin).activeSelf then
			local var_43_1 = arg_30_0.serverList or {}

			if table.getCount(var_43_1) == 0 then
				var_30_0()

				return
			end

			if not arg_30_0.shareData.lastLoginServer then
				pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_choiseServer"))

				return
			end

			if arg_30_0.shareData.lastLoginServer.status == Server.STATUS.VINDICATE or arg_30_0.shareData.lastLoginServer.status == Server.STATUS.FULL then
				ServerStateChecker.New():Execute(function(arg_44_0)
					if arg_44_0 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_server_disabled"))
					else
						arg_30_0.event:emit(LoginMediator.ON_SERVER, arg_30_0.shareData.lastLoginServer)
						pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
					end

					return
				end)

				return
			end

			arg_30_0.event:emit(LoginMediator.ON_SERVER, arg_30_0.shareData.lastLoginServer)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CONFIRM)
		end

		return
	end)

	if arg_30_0.isOpPlay then
		onButton(arg_30_0, arg_30_0.opBtn, function()
			if arg_30_0.initFinished then
				if not pg.CpkPlayMgr.GetInstance():OnPlaying() then
					arg_30_0:playOpening()
				end
			end

			return
		end)

		if PLATFORM_CODE ~= PLATFORM_JP and PlayerPrefs.GetString("op_ver", "") ~= arg_30_0.opVersion then
			arg_30_0:playOpening(function()
				PlayerPrefs.SetString("op_ver", arg_30_0.opVersion)
				arg_30_0:playExtraVoice()

				arg_30_0.initFinished = true

				arg_30_0.event:emit(LoginMediator.ON_LOGIN_PROCESS)

				return
			end)

			return
		end

		arg_30_0.event:emit(LoginMediator.ON_LOGIN_PROCESS)
	else
		arg_30_0.event:emit(LoginMediator.ON_LOGIN_PROCESS)
	end

	arg_30_0:playExtraVoice()

	arg_30_0.initFinished = true

	arg_30_0:InitPrivateAndLicence()

	return
end

function var_0_0.InitPrivateAndLicence(arg_47_0)
	local var_47_0 = PLATFORM_CODE == PLATFORM_CH or IsUnityEditor

	setActive(arg_47_0.privateBtn, PLATFORM_CODE == PLATFORM_CH or IsUnityEditor)
	setActive(arg_47_0.licenceBtn, var_47_0)

	if var_47_0 then
		onButton(arg_47_0, arg_47_0.privateBtn, function()
			pg.SdkMgr.GetInstance():ShowPrivate()

			return
		end, SFX_PANEL)
		onButton(arg_47_0, arg_47_0.licenceBtn, function()
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

function var_0_0.GetExtraVoiceSheetAndCue(arg_52_0)
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

function var_0_0.playExtraVoice(arg_53_0)
	local var_53_0, var_53_1 = arg_53_0:GetExtraVoiceSheetAndCue()

	if var_53_0 and var_53_1 then
		arg_53_0.loginCueSheet = var_53_0

		pg.CriMgr.GetInstance():PlayCV_V3(var_53_0, var_53_1)
	end

	return
end

function var_0_0.unloadExtraVoice(arg_54_0)
	if arg_54_0.loginCueSheet then
		pg.CriMgr.GetInstance():UnloadCueSheet(arg_54_0.loginCueSheet)

		arg_54_0.loginCueSheet = nil
	end

	return
end

function var_0_0.autoLogin(arg_55_0)
	if arg_55_0.shareData.lastLoginUser then
		if arg_55_0.shareData.autoLoginEnabled then
			arg_55_0.event:emit(LoginMediator.ON_LOGIN, arg_55_0.shareData.lastLoginUser)
		end

		if arg_55_0.loginPanelView:GetLoaded() then
			if arg_55_0.shareData.lastLoginUser.type == 1 then
				arg_55_0.loginPanelView:ActionInvoke("SetContent", arg_55_0.shareData.lastLoginUser.arg2, arg_55_0.shareData.lastLoginUser.arg3)
			elseif arg_55_0.shareData.lastLoginUser.type == 2 then
				arg_55_0.loginPanelView:ActionInvoke("SetContent", arg_55_0.shareData.lastLoginUser.arg1, arg_55_0.shareData.lastLoginUser.arg2)
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

function var_0_0.updateServerTF(arg_56_0, arg_56_1, arg_56_2)
	setText(findTF(arg_56_1, "name"), "-  " .. arg_56_2.name .. "  -")
	arg_56_0:setSpriteTo(arg_56_0.iconSpries[arg_56_2.status + 1], findTF(arg_56_1, "statu"), true)

	findTF(arg_56_1, "statu_1"):GetComponent("Image").color = Color.New(var_0_4[arg_56_2.status + 1][1], var_0_4[arg_56_2.status + 1][2], var_0_4[arg_56_2.status + 1][3], var_0_4[arg_56_2.status + 1][4])

	setActive(findTF(arg_56_1, "mark"), arg_56_2.isLogined)
	setActive(arg_56_1:Find("tag_new"), arg_56_2.isNew)
	setActive(arg_56_1:Find("tag_hot"), arg_56_2.isHot)
	onButton(arg_56_0, arg_56_1, function()
		if arg_56_2.status == Server.STATUS.VINDICATE then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_server_vindicate"))

			return
		end

		if arg_56_2.status == Server.STATUS.FULL then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_server_full"))

			return
		end

		arg_56_0:setLastLoginServer(arg_56_2)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_56_0.serversPanel, arg_56_0._tf)
		setActive(arg_56_0.serversPanel, false)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.updateAdviceServer(arg_58_0)
	if not arg_58_0.recentTF or not arg_58_0.adviceTF then
		return
	end

	setActive(arg_58_0.recentTF, arg_58_0.shareData.lastLoginServer)

	if arg_58_0.shareData.lastLoginServer then
		arg_58_0:updateServerTF(findTF(arg_58_0.recentTF, "server"), arg_58_0.shareData.lastLoginServer)
	end

	local var_58_0 = getProxy(ServerProxy).firstServer

	setActive(arg_58_0.adviceTF, var_58_0)

	if var_58_0 then
		arg_58_0:updateServerTF(findTF(arg_58_0.adviceTF, "server"), var_58_0)
	end

	return
end

function var_0_0.updateServerList(arg_59_0, arg_59_1)
	arg_59_0.serverList = arg_59_1

	local var_59_0 = _.sort(_.values(arg_59_1), function(arg_60_0, arg_60_1)
		return arg_60_0.sortIndex < arg_60_1.sortIndex
	end)

	removeAllChildren(arg_59_0.servers)

	if IsUnityEditor then
		table.sort(var_59_0, function(arg_61_0, arg_61_1)
			return string.byte(string.lower(arg_61_0.name), 1) > string.byte(string.lower(arg_61_1.name), 1)
		end)
	end

	arg_59_0.serversDic = {}

	for iter_59_0, iter_59_1 in pairs(var_59_0) do
		local var_59_1 = cloneTplTo(arg_59_0.serverTpl, arg_59_0.servers)

		arg_59_0:updateServerTF(var_59_1, iter_59_1)
		table.insert(arg_59_0.serversDic, {
			server = iter_59_1,
			tf = var_59_1,
			id = iter_59_1.id
		})
	end

	return
end

function var_0_0.fillterRefundServer(arg_62_0)
	local var_62_0 = getProxy(UserProxy)
	local var_62_1 = {}

	if var_62_0.data.limitServerIds and #var_62_0.data.limitServerIds > 0 and arg_62_0.serverList and #arg_62_0.serverList > 0 then
		local var_62_2

		for iter_62_0, iter_62_1 in pairs(arg_62_0.serverList) do
			for iter_62_2, iter_62_3 in pairs(var_62_0.data.limitServerIds) do
				local var_62_3

				if var_62_0.data.limitServerIds[iter_62_2] == iter_62_1.id and not false then
					var_62_2 = not var_62_2 and "\n" .. iter_62_1.name or var_62_2 .. "," .. iter_62_1.name

					table.insert(var_62_1, iter_62_1)

					var_62_3 = true
				end
			end
		end

		arg_62_0:updateServerList(var_62_1)
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

function var_0_0.switchToTencentLogin(arg_64_0)
	arg_64_0:switchSubView({
		LoginSceneConst.DEFINE.TENCENT_LOGIN_VIEW
	})

	return
end

function var_0_0.switchToAiriLogin(arg_65_0)
	arg_65_0:switchSubView({
		LoginSceneConst.DEFINE.AIRI_LOGIN_PANEL_VIEW,
		LoginSceneConst.DEFINE.PRESS_TO_LOGIN
	})

	return
end

function var_0_0.switchToLogin(arg_66_0)
	arg_66_0:switchSubView({
		LoginSceneConst.DEFINE.LOGIN_PANEL_VIEW
	})

	return
end

function var_0_0.switchToRegister(arg_67_0)
	arg_67_0:switchSubView({
		LoginSceneConst.DEFINE.REGISTER_PANEL_VIEW
	})

	return
end

function var_0_0.switchToServer(arg_68_0)
	arg_68_0:updateAdviceServer()

	local var_68_0 = pg.SdkMgr.GetInstance()

	if var_68_0:GetLoginType() ~= LoginType.PLATFORM_INNER and PLATFORM_CODE ~= PLATFORM_KR then
		arg_68_0:switchSubView({
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN,
			LoginSceneConst.DEFINE.CURRENT_SERVER,
			LoginSceneConst.DEFINE.BG_LAY
		})
	else
		arg_68_0:switchSubView({
			LoginSceneConst.DEFINE.ACCOUNT_BTN,
			LoginSceneConst.DEFINE.PRESS_TO_LOGIN,
			LoginSceneConst.DEFINE.CURRENT_SERVER,
			LoginSceneConst.DEFINE.BG_LAY
		})
	end

	return
end

function var_0_0.SwitchToWaitPanel(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0.adapt:Find("Msgbox")
	local var_69_1 = var_69_0:Find("window/content")

	arg_69_0.waitTimer = nil

	local var_69_3 = arg_69_1

	arg_69_0.waitTimer = Timer.New(function()
		setText(var_69_1, i18n("login_wait_tip", var_69_3))

		arg_69_1 = arg_69_1 - 1

		if math.random(0, 1) == 1 then
			var_69_3 = arg_69_1
		end

		if arg_69_1 <= 0 then
			triggerButton(arg_69_0._tf:Find("background"))
			arg_69_0.waitTimer:Stop()

			arg_69_0.waitTimer = nil
		end

		return
	end, 1, -1)

	arg_69_0.waitTimer:Start()
	arg_69_0.waitTimer.func()
	setActive(var_69_0, true)

	return
end

function var_0_0.willExit(arg_71_0)
	if arg_71_0.waitTimer then
		arg_71_0.waitTimer:Stop()

		arg_71_0.waitTimer = nil
	end

	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()
	arg_71_0.loginPanelView:Destroy()
	arg_71_0.registerPanelView:Destroy()
	arg_71_0.tencentLoginPanelView:Destroy()
	arg_71_0.airiLoginPanelView:Destroy()
	arg_71_0.transcodeAlertView:Destroy()
	arg_71_0.yostarAlertView:Destroy()
	arg_71_0.switchGatewayBtn:Dispose()

	if PLATFORM == PLATFORM_OPENHARMONY then
		arg_71_0.switchGatewayBtn4Oh:Dispose()
	end

	arg_71_0.iconSpries = nil

	return
end

function var_0_0.playOpening(arg_72_0, arg_72_1)
	pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
		arg_72_0.cg = arg_72_0.cg or GetOrAddComponent(arg_72_0._tf, "CanvasGroup")
		arg_72_0.cg.alpha = 0

		return
	end, function()
		arg_72_0.cg.alpha = 1

		if arg_72_1 then
			arg_72_1()
		end

		return
	end, "ui", "opening", true, false)

	arg_72_0.onPlayingOP = true

	return
end

function var_0_0.closeYostarAlertView(arg_75_0)
	if arg_75_0.yostarAlertView and arg_75_0.yostarAlertView:CheckState(BaseSubView.STATES.INITED) then
		arg_75_0.yostarAlertView:Destroy()
	end

	return
end

function var_0_0.onLoadDataDone(arg_76_0)
	arg_76_0:unloadExtraVoice()

	if getProxy(PlayerProxy) then
		getProxy(PlayerProxy):setFlag("login", true)
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.MAINUI, {
			isFromLogin = true
		})
	end

	return
end

return var_0_0
