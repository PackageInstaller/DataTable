class = var_0_10000

local var_0_0 = "LoginScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2 = 1

function var_0_1.getUIName(arg_1_0)
	return "LoginUI2"
end

function var_0_1.getBGM(arg_2_0)
	if arg_2_0.bgmName and arg_2_0.bgmName ~= "" then
		return arg_2_0.bgmName
	end

	return var_0_1.super.getBGM(arg_2_0)
end

function var_0_1.preload(arg_3_0, arg_3_1)
	arg_3_0.iconSpries = {
		"reources/statu_green",
		"reources/statu_gray",
		"reources/statu_red",
		"reources/statu_org"
	}
	LOGIN_HX = var_3_0

	local var_3_0

	if var_3_0 then
		PlayerProxy = var_3_0
		var_3_0 = var_3_0.GetDeviceMaxPlayerLevel()
		pg = var_1_10003
		var_3_0 = var_3_0 <= var_1_10003.gameset.LOGIN_HX_LV.key_value
	end

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_4_0)
			local var_4_0 = arg_3_0
			local var_4_1 = arg_3_0
			local var_4_2 = arg_3_0
			local var_4_3 = arg_3_0
			local var_4_4 = arg_3_0

			getLoginConfig = var_2_10006
			var_4_0.isCriBg, var_4_1.bgPath, var_4_2.bgmName, var_4_3.isOpPlay, var_4_4.opVersion = var_2_10006()

			if arg_3_0.isCriBg then
				LoadAndInstantiateAsync = var_1

				var_1("effect", arg_3_0.bgPath, function(arg_5_0)
					arg_3_0.criBgGo = arg_5_0

					arg_4_0()

					return
				end)
			else
				local var_4_5 = var_3_0 and "loadingbg_hx/" or "loadingbg/"

				LoadSpriteAsync = var_4_1

				var_4_1(var_4_5 .. arg_3_0.bgPath, function(arg_6_0)
					arg_3_0.staticBgSprite = arg_6_0

					arg_4_0()

					return
				end)
			end

			return
		end
	}, arg_3_1)

	return
end

function var_0_1.init(arg_7_0)
	BundleWizard = var_1_10001

	local var_7_0 = var_1_10001.Inst
	local var_7_1 = var_1.GetGroupMgr(var_7_0, "DEFAULT_RES")

	arg_7_0:setBg()

	local var_7_2 = arg_7_0._tf

	arg_7_0.adapt = var_2.Find(var_7_2, "adapt")

	local var_7_3 = arg_7_0.adapt

	arg_7_0.version = var_2.Find(var_7_3, "version")

	local var_7_4 = arg_7_0.version
	local var_7_5 = var_2.GetComponent(var_7_4, "Text")
	local var_7_6 = "ver "
	local var_7_7 = var_7_1.CurrentVersion

	var_7_5.text = var_7_6 .. var_4.ToString(var_7_7)

	local var_7_8 = arg_7_0.adapt

	arg_7_0.bgLay = var_2.Find(var_7_8, "bg_lay")

	local var_7_9 = arg_7_0.adapt

	arg_7_0.accountBtn = var_2.Find(var_7_9, "bg_lay/buttons/account_button")

	local var_7_10 = arg_7_0.adapt

	arg_7_0.repairBtn = var_2.Find(var_7_10, "btns/repair_button")

	local var_7_11 = arg_7_0.adapt

	arg_7_0.privateBtn = var_2.Find(var_7_11, "btns/private_btn")

	local var_7_12 = arg_7_0.adapt

	arg_7_0.licenceBtn = var_2.Find(var_7_12, "btns/Licence_btn")

	local var_7_13 = arg_7_0._tf

	arg_7_0.chInfo = var_2.Find(var_7_13, "background/info")
	setActive = var_2

	local var_7_14 = arg_7_0.chInfo

	PLATFORM_CODE = var_5
	PLATFORM_CH = var_7_7

	var_2(var_7_14, var_5 == var_7_7)

	PLATFORM_CODE = var_2
	PLATFORM_CH = var_3

	if var_2 == var_3 then
		local var_7_15 = arg_7_0.chInfo

		arg_7_0.urlClick = var_2.Find(var_7_15, "urlClick")
		onButton = var_2

		var_2(arg_7_0, arg_7_0.urlClick, function()
			Application = var_2_10000

			var_2_10000.OpenURL("https://beian.miit.gov.cn/#/home")

			return
		end)
	end

	GetOrAddComponent = var_2

	local var_7_16 = arg_7_0._tf

	arg_7_0.pressToLogin = var_2(var_4.Find(var_7_16, "background/press_to_login"), "CanvasGroup")
	LeanTween = var_2

	local var_7_17 = var_2.alphaCanvas(arg_7_0.pressToLogin, 0.25, var_0_2)
	local var_7_18 = var_2.setFrom(var_7_17, 1)
	local var_7_19 = var_2.setEase

	LeanTweenType = var_5

	local var_7_20 = var_7_19(var_7_18, var_5.easeInOutSine)

	var_2.setLoopPingPong(var_7_20)

	local var_7_21 = arg_7_0.adapt

	arg_7_0.currentServer = var_2.Find(var_7_21, "current_server")

	local var_7_22 = arg_7_0.adapt

	arg_7_0.serviceBtn = var_2.Find(var_7_22, "bg_lay/buttons/service_button")

	local var_7_23 = arg_7_0.adapt

	arg_7_0.filingBtn = var_2.Find(var_7_23, "filingBtn")
	setActive = var_2

	local var_7_24 = arg_7_0.filingBtn

	PLATFORM_CODE = var_5
	PLATFORM_CH = var_6

	var_2(var_7_24, var_5 == var_6)

	local var_7_25 = arg_7_0.adapt

	arg_7_0.serversPanel = var_2.Find(var_7_25, "servers")

	local var_7_26 = arg_7_0.serversPanel

	arg_7_0.servers = var_2.Find(var_7_26, "panel/panel/servers/content/server_list")
	arg_7_0.serverTpl = arg_7_0:getTpl("server_tpl")

	local var_7_27 = arg_7_0.serversPanel

	arg_7_0.recentTF = var_2.Find(var_7_27, "panel/panel/servers/content/advice_panel/recent")

	local var_7_28 = arg_7_0.serversPanel

	arg_7_0.adviceTF = var_2.Find(var_7_28, "panel/panel/servers/content/advice_panel/advice")

	local var_7_29 = arg_7_0.adapt

	arg_7_0.userAgreenTF = var_2.Find(var_7_29, "UserAgreement")

	local var_7_30 = arg_7_0.adapt

	arg_7_0.userAgreenMainTF = var_2.Find(var_7_30, "UserAgreement/window")

	local var_7_31 = arg_7_0.userAgreenTF

	arg_7_0.closeUserAgreenTF = var_2.Find(var_7_31, "window/close_btn")

	local var_7_32 = arg_7_0.adapt

	arg_7_0.userAgreenConfirmTF = var_2.Find(var_7_32, "UserAgreement/window/accept_btn")

	local var_7_33 = arg_7_0.adapt

	arg_7_0.userDisagreeConfirmTF = var_2.Find(var_7_33, "UserAgreement/window/disagree_btn")
	SwitchGatewayBtn = var_2

	local var_7_34 = var_2.New
	local var_7_35 = arg_7_0.adapt

	arg_7_0.switchGatewayBtn = var_7_34(var_4.Find(var_7_35, "servers/panel/panel/switch_platform"))
	PLATFORM = var_7_36
	PLATFORM_OPENHARMONY = var_3

	local var_7_36

	if var_7_36 == var_3 then
		SwitchGatewayBtn4OpenHarmony = var_7_36
		var_7_36 = var_7_36.New

		local var_7_37 = arg_7_0.adapt

		arg_7_0.switchGatewayBtn4Oh = var_7_36(var_4.Find(var_7_37, "servers/panel/panel/switch_platform"))
	end

	setActive = var_7_36

	var_7_36(arg_7_0.userAgreenTF, false)

	pg = var_7_36

	local var_7_38 = var_7_36.UIMgr.GetInstance()

	var_2.UnOverlayPanel(var_7_38, arg_7_0.userAgreenTF, arg_7_0._tf)

	local var_7_39 = arg_7_0.adapt

	arg_7_0.opBtn = var_2.Find(var_7_39, "bg_lay/buttons/opBtn")

	if arg_7_0.opBtn then
		setActive = var_2

		var_2(arg_7_0.opBtn, arg_7_0.isOpPlay)
	end

	local var_7_40 = arg_7_0.adapt

	arg_7_0.airiUidTxt = var_2.Find(var_7_40, "airi_uid")
	arg_7_0.shareData = {}

	local var_7_41 = arg_7_0.serversPanel

	arg_7_0.searchAccount = var_2.Find(var_7_41, "panel/panel/searchAccount")
	setText = var_2
	findTF = var_7_41

	local var_7_42 = var_7_41(arg_7_0.searchAccount, "text")

	i18n = var_5

	var_2(var_7_42, var_5("query_role_button"))

	GetComponent = var_2

	local var_7_43 = arg_7_0.adapt
	local var_7_44 = var_4.Find(var_7_43, "servers/panel/panel/servers")

	typeof = var_5
	CanvasGroup = var_7
	arg_7_0.serverPanelCanvas = var_2(var_7_44, var_5(var_7))
	onButton = var_2

	local var_7_45 = arg_7_0
	local var_7_46 = arg_7_0.searchAccount

	local function var_7_47()
		if not arg_7_0.serversDic or arg_7_0.searching then
			return
		end

		local var_9_0 = arg_7_0

		var_0.searchAountState(var_9_0, true)

		arg_7_0.serverPanelCanvas.interactable = false

		local var_9_1 = arg_7_0.event
		local var_9_2 = var_0.emit

		LoginMediator = var_3

		var_9_2(var_9_1, var_3.ON_SEARCH_ACCOUNT, {
			callback = function()
				arg_7_0.serverPanelCanvas.interactable = true

				local var_10_0 = arg_7_0

				var_0.searchAountState(var_10_0, false)

				return
			end,
			update = function(arg_11_0)
				local var_11_0 = arg_7_0

				var_1.setServerAccountData(var_11_0, arg_11_0)

				return
			end
		})

		return
	end

	SFX_CONFIRM = var_7

	var_2(var_7_45, var_7_46, var_7_47, var_7)

	arg_7_0.subViewList = {}
	LoginPanelView = var_2
	arg_7_0.loginPanelView = var_2.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	local var_7_48 = arg_7_0.loginPanelView

	var_2.SetShareData(var_7_48, arg_7_0.shareData)

	RegisterPanelView = var_2
	arg_7_0.registerPanelView = var_2.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	local var_7_49 = arg_7_0.loginPanelView

	var_2.SetShareData(var_7_49, arg_7_0.shareData)

	TencentLoginPanelView = var_2
	arg_7_0.tencentLoginPanelView = var_2.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	local var_7_50 = arg_7_0.loginPanelView

	var_2.SetShareData(var_7_50, arg_7_0.shareData)

	arg_7_0.airiLoginPanelView = nil
	PLATFORM_CODE = var_2
	PLATFORM_US = var_3

	if var_2 == var_3 then
		AiriUSLoginPanelView = var_2
		arg_7_0.airiLoginPanelView = var_2.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)
	else
		AiriLoginPanelView = var_2
		arg_7_0.airiLoginPanelView = var_2.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)
	end

	local var_7_51 = arg_7_0.loginPanelView

	var_2.SetShareData(var_7_51, arg_7_0.shareData)

	TranscodeAlertView = var_2
	arg_7_0.transcodeAlertView = var_2.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	local var_7_52 = arg_7_0.loginPanelView

	var_2.SetShareData(var_7_52, arg_7_0.shareData)

	YostarAlertView = var_2
	arg_7_0.yostarAlertView = var_2.New(arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

	local var_7_53 = arg_7_0.loginPanelView

	var_2.SetShareData(var_7_53, arg_7_0.shareData)

	local var_7_54 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_54[var_3.DEFINE.LOGIN_PANEL_VIEW] = arg_7_0.loginPanelView

	local var_7_55 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_55[var_3.DEFINE.REGISTER_PANEL_VIEW] = arg_7_0.registerPanelView

	local var_7_56 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_56[var_3.DEFINE.TENCENT_LOGIN_VIEW] = arg_7_0.tencentLoginPanelView

	local var_7_57 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_57[var_3.DEFINE.AIRI_LOGIN_PANEL_VIEW] = arg_7_0.airiLoginPanelView

	local var_7_58 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_58[var_3.DEFINE.TRANSCODE_ALERT_VIEW] = arg_7_0.transcodeAlertView

	local var_7_59 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_59[var_3.DEFINE.YOSTAR_ALERT_VIEW] = arg_7_0.yostarAlertView

	local var_7_60 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_60[var_3.DEFINE.PRESS_TO_LOGIN] = arg_7_0.pressToLogin

	local var_7_61 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_61[var_3.DEFINE.BG_LAY] = arg_7_0.bgLay

	local var_7_62 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_62[var_3.DEFINE.SERVER_PANEL] = arg_7_0.serversPanel

	local var_7_63 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_63[var_3.DEFINE.ACCOUNT_BTN] = arg_7_0.accountBtn

	local var_7_64 = arg_7_0.subViewList

	LoginSceneConst = var_3
	var_7_64[var_3.DEFINE.CURRENT_SERVER] = arg_7_0.currentServer

	local var_7_65 = arg_7_0.adapt

	arg_7_0.age = var_2.Find(var_7_65, "age")
	PLATFORM_CODE = var_2
	PLATFORM_CH = var_3

	if var_2 == var_3 then
		onButton = var_2

		var_2(arg_7_0, arg_7_0.age, function()
			pg = var_2_10000

			local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_12_1 = var_0.ShowMsgBox
			local var_12_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_12_2.type = var_2_10004
			pg = var_2_10004
			var_12_2.helps = var_2_10004.gametip.cadpa_help.tip
			pg = var_4
			var_12_2.title = var_4.MsgboxMgr.TITLE_CADPA

			var_12_1(var_12_0, var_12_2)

			return
		end)

		SetActive = var_2

		var_2(arg_7_0.age, true)
	end

	SetActive = var_2

	local var_7_66 = arg_7_0.age

	PLATFORM_CODE = var_5
	PLATFORM_CH = var_6

	var_2(var_7_66, var_5 == var_6)

	setText = var_2
	findTF = var_7_66

	var_2(var_7_66(arg_7_0.currentServer, "server_name"), "")
	arg_7_0:switchToServer()
	arg_7_0:initEvents()

	return
end

function var_0_1.FlushGateWaySwitchBtn(arg_13_0)
	local var_13_0 = arg_13_0.switchGatewayBtn

	var_1.Flush(var_13_0)

	PLATFORM = var_1
	PLATFORM_OPENHARMONY = var_1_10002

	if var_1 == var_1_10002 then
		local var_13_1 = arg_13_0.switchGatewayBtn4Oh

		var_1.Flush(var_13_1)
	end

	return
end

function var_0_1.setServerAccountData(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.id
	local var_14_1

	for iter_14_0 = 1, #arg_14_0.serversDic do
		if arg_14_0.serversDic[iter_14_0].id == var_14_0 then
			var_14_1 = arg_14_0.serversDic[iter_14_0]

			break
		end
	end

	if not var_14_1 then
		return
	end

	local var_14_2 = var_14_1.tf

	if arg_14_1 and arg_14_1.level then
		setActive = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/charactor"), true)

		setActive = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/level"), true)

		setActive = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/searching"), false)

		setText = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/level"), "lv." .. arg_14_1.level)

		setText = var_5
		findTF = iter_14_0
		iter_14_0 = iter_14_0(var_14_2, "mark/level")
		setColorStr = var_8

		var_5(iter_14_0, var_8("lv." .. arg_14_1.level, "#ffffffff"))

		var_14_1.level = arg_14_1.level
	elseif arg_14_1 and arg_14_1.isFail then
		setActive = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/level"), true)

		setActive = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/searching"), false)

		setActive = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/charactor"), false)

		var_14_1.level = 0
		setText = var_5
		findTF = iter_14_0
		iter_14_0 = iter_14_0(var_14_2, "mark/level")
		setColorStr = var_8
		i18n = var_10

		var_5(iter_14_0, var_8(var_10("query_role_fail"), "#ff9c00ff"))
	else
		setActive = var_5
		findTF = iter_14_0

		var_5(iter_14_0(var_14_2, "mark/level"), true)

		setActive = var_5
		findTF = var_7

		var_5(var_7(var_14_2, "mark/searching"), false)

		setActive = var_5
		findTF = var_7

		var_5(var_7(var_14_2, "mark/charactor"), false)

		var_14_1.level = 0
		setText = var_5
		findTF = var_7

		local var_14_3 = var_7(var_14_2, "mark/level")

		setColorStr = var_8
		i18n = var_10

		var_5(var_14_3, var_8(var_10("query_role_none"), "#d0d0d0FF"))
	end

	return
end

function var_0_1.searchAountState(arg_15_0, arg_15_1)
	arg_15_0.searching = arg_15_1

	for iter_15_0 = 1, #arg_15_0.serversDic do
		local var_15_0 = arg_15_0.serversDic[iter_15_0].tf
		local var_15_1 = arg_15_0.serversDic[iter_15_0].level

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(var_15_0, "mark"), true)

		if arg_15_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(var_15_0, "mark/charactor"), false)

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(var_15_0, "mark/level"), true)

			setText = var_1_10008
			findTF = var_1_10010
			var_1_10010 = var_1_10010(var_15_0, "mark/level")
			setColorStr = var_11
			i18n = var_13

			var_1_10008(var_1_10010, var_11(var_13("query_role"), "#d0d0d0FF"))

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(var_15_0, "mark/searching"), true)
		else
			if not var_15_1 then
				setText = var_1_10008
				findTF = var_1_10010
				var_1_10010 = var_1_10010(var_15_0, "mark/level")
				setColorStr = var_11
				i18n = var_13

				var_1_10008(var_1_10010, var_11(var_13("query_role_fail"), "#d0d0d0FF"))
			end

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(var_15_0, "mark/searching"), false)
		end
	end

	return
end

function var_0_1.initEvents(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.bind

	LoginSceneConst = var_1_10004

	var_16_1(var_16_0, var_1_10004.SWITCH_SUB_VIEW, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0

		var_2.switchSubView(var_17_0, arg_17_1)

		return
	end)

	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_0.bind

	LoginSceneConst = var_4

	var_16_3(var_16_2, var_4.CLEAR_REGISTER_VIEW, function(arg_18_0)
		local var_18_0 = arg_16_0.registerPanelView

		var_1.ActionInvoke(var_18_0, "Clear")

		return
	end)

	return
end

function var_0_1.switchSubView(arg_19_0, arg_19_1)
	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.subViewList) do
		isa = var_1_10007

		local var_19_0 = iter_19_1

		BaseSubView = var_1_10010

		if var_1_10007(var_19_0, var_1_10010) then
			table = var_1_10007

			if var_1_10007.contains(arg_19_1, iter_19_0) then
				iter_19_1:CallbackInvoke(function()
					local var_20_0 = arg_19_0.repairBtn

					var_0.SetAsLastSibling(var_20_0)

					return
				end)
				iter_19_1:Load()
				iter_19_1:ActionInvoke("Show")
			else
				iter_19_1:ActionInvoke("Hide")
			end
		else
			setActive = var_1_10007

			local var_19_1 = iter_19_1

			table = var_1_10010

			var_1_10007(var_19_1, var_1_10010.contains(arg_19_1, iter_19_0))
		end
	end

	table = var_2

	local var_19_2 = var_2.contains
	local var_19_3 = arg_19_1

	LoginSceneConst = iter_19_0

	if not var_19_2(var_19_3, iter_19_0.DEFINE.SERVER_PANEL) then
		pg = var_2

		local var_19_4 = var_2.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_19_4, arg_19_0.serversPanel, arg_19_0._tf)
	end

	table = var_2

	local var_19_5 = var_2.contains
	local var_19_6 = arg_19_1

	LoginSceneConst = var_5

	if var_19_5(var_19_6, var_5.DEFINE.AIRI_LOGIN_PANEL_VIEW) then
		setActive = var_2

		var_2(arg_19_0.airiUidTxt, false)
	end

	local var_19_7 = arg_19_0.userAgreenTF

	var_2.SetAsLastSibling(var_19_7)

	local var_19_8 = arg_19_0.repairBtn

	var_2.SetAsLastSibling(var_19_8)

	return
end

function var_0_1.onBackPressed(arg_21_0)
	if arg_21_0.searching then
		return
	end

	pg = var_1

	local var_21_0 = var_1.CriMgr.GetInstance()
	local var_21_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_21_1(var_21_0, var_1_10004)

	isActive = var_21_1

	if var_21_1(arg_21_0.serversPanel) then
		pg = var_1

		local var_21_2 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_21_2, arg_21_0.serversPanel, arg_21_0._tf)

		setActive = var_1

		var_1(arg_21_0.serversPanel, false)

		return
	end

	isActive = var_1

	if var_1(arg_21_0.userAgreenTF) then
		setActive = var_1

		var_1(arg_21_0.userAgreenTF, false)

		pg = var_1

		local var_21_3 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_21_3, arg_21_0.userAgreenTF, arg_21_0._tf)

		return
	end

	pg = var_1

	local var_21_4 = var_1.SdkMgr.GetInstance()

	var_1.OnAndoridBackPress(var_21_4)

	return
end

function var_0_1.setUserData(arg_22_0, arg_22_1)
	setActive = var_1_10002

	var_1_10002(arg_22_0.airiUidTxt, true)

	setText = var_1_10002

	var_1_10002(arg_22_0.airiUidTxt, "uid: " .. arg_22_1.arg2)

	return
end

function var_0_1.showUserAgreement(arg_23_0, arg_23_1)
	local var_23_0

	PLATFORM_CODE = var_1_10003
	PLATFORM_CH = var_1_10004

	if var_1_10003 == var_1_10004 then
		local var_23_1 = arg_23_0.userAgreenConfirmTF

		var_1_10003 = var_1_10003.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_1_10003 = var_1_10003(var_23_1, var_1_10006(var_1_10008))
		Color = var_1_10004
		var_1_10003.color = var_1_10004.New(0.7843137254901961, 0.7843137254901961, 0.7843137254901961, 0.5019607843137255)
	else
		var_23_0 = true
	end

	require = var_1_10003

	local var_23_2 = var_1_10003("ShareCfg.UserAgreement")

	setActive = var_1_10004

	var_1_10004(arg_23_0.userAgreenTF, true)

	pg = var_1_10004

	local var_23_3 = var_1_10004.UIMgr.GetInstance()

	var_4.BlurPanel(var_23_3, arg_23_0.userAgreenTF)

	setText = var_4

	local var_23_4 = arg_23_0.userAgreenTF

	var_4(var_6.Find(var_23_4, "window/container/scrollrect/content/Text"), var_23_2.content)

	onButton = var_4

	var_4(arg_23_0, arg_23_0.userAgreenConfirmTF, function()
		if var_23_0 then
			setActive = var_0

			var_0(arg_23_0.userAgreenTF, false)

			pg = var_0

			local var_24_0 = var_0.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_24_0, arg_23_0.userAgreenTF, arg_23_0._tf)

			if arg_23_1 then
				arg_23_1()
			end
		else
			pg = var_0

			local var_24_1 = var_0.TipsMgr.GetInstance()
			local var_24_2 = var_0.ShowTips

			i18n = var_2_10003

			var_24_2(var_24_1, var_2_10003("read_the_user_agreement"))
		end

		return
	end)

	onScroll = var_4

	local var_23_5 = arg_23_0
	local var_23_6 = arg_23_0.userAgreenTF

	var_4(var_23_5, var_7.Find(var_23_6, "window/container/scrollrect"), function(arg_25_0)
		if arg_25_0.y <= 0.01 and not var_23_0 then
			var_23_0 = true
			PLATFORM_CODE = var_1
			PLATFORM_CH = var_2

			if var_1 == var_2 then
				local var_25_0 = arg_23_0.userAgreenConfirmTF
				local var_25_1 = var_1.GetComponent

				typeof = var_2_10004
				Image = var_2_10006

				local var_25_2 = var_25_1(var_25_0, var_2_10004(var_2_10006))

				Color = var_2
				var_25_2.color = var_2.New(1, 1, 1, 1)
			end
		end

		return
	end)

	return
end

function var_0_1.setBg(arg_26_0)
	local var_26_0 = arg_26_0._tf
	local var_26_1 = var_1.Find(var_26_0, "background/bg")
	local var_26_2 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_26_0.bgImg = var_26_2(var_26_1, var_4(var_1_10006))

	if not arg_26_0.isCriBg then
		setImageSprite = var_1

		var_1(arg_26_0.bgImg, arg_26_0.staticBgSprite)
	else
		arg_26_0.bgImg.enabled = false

		local var_26_3 = arg_26_0.criBgGo.transform

		var_1.SetParent(var_26_3, arg_26_0.bgImg.transform, false)
		var_1:SetAsFirstSibling()

		local var_26_4 = arg_26_0.criBgGo

		if var_2.GetComponent(var_26_4, "AspectRatioFitter") then
			var_2.enabled = true
		end
	end

	return
end

function var_0_1.setLastLogin(arg_27_0, arg_27_1)
	arg_27_0.shareData.lastLoginUser = arg_27_1

	return
end

function var_0_1.setAutoLogin(arg_28_0)
	arg_28_0.shareData.autoLoginEnabled = true

	return
end

function var_0_1.setLastLoginServer(arg_29_0, arg_29_1)
	if not arg_29_1 then
		setText = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_29_0.currentServer, "server_name"), "")

		var_1_10002 = arg_29_0.shareData
		var_1_10002.lastLoginServer = nil
		var_1_10004 = arg_29_0

		arg_29_0.updateAdviceServer(var_1_10004)

		return
	end

	setText = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_29_0.currentServer, "server_name"), arg_29_1.name)

	arg_29_0.shareData.lastLoginServer = arg_29_1

	return
end

function var_0_1.didEnter(arg_30_0)
	onButton = var_1_10001

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.closeUserAgreenTF

	local function var_30_2()
		PLATFORM_CODE = var_2_10000
		PLATFORM_JP = var_2_10001

		if var_2_10000 ~= var_2_10001 then
			PLATFORM_CODE = var_2_10000
			PLATFORM_US = var_2_10001

			if var_2_10000 == var_2_10001 then
				setActive = var_2_10000

				var_2_10000(arg_30_0.userAgreenTF, false)

				pg = var_2_10000

				local var_31_0 = var_2_10000.UIMgr.GetInstance()

				var_2_10000.UnOverlayPanel(var_31_0, arg_30_0.userAgreenTF, arg_30_0._tf)
			else
				setActive = var_2_10000

				var_2_10000(arg_30_0.userAgreenMainTF, false)

				onNextTick = var_2_10000

				var_2_10000(function()
					setActive = var_3_10000

					var_3_10000(arg_30_0.userAgreenMainTF, true)

					return
				end)
			end

			return
		end
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_30_0, var_30_1, var_30_2, var_1_10006)

	onButton = var_1_10001

	local var_30_3 = arg_30_0
	local var_30_4 = arg_30_0.privateBtn

	local function var_30_5()
		pg = var_2_10000

		local var_33_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.ShowPrivate(var_33_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_30_3, var_30_4, var_30_5, var_1_10006)

	onButton = var_1_10001

	local var_30_6 = arg_30_0
	local var_30_7 = arg_30_0.licenceBtn

	local function var_30_8()
		pg = var_2_10000

		local var_34_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.ShowLicence(var_34_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_30_6, var_30_7, var_30_8, var_1_10006)

	setActive = var_1_10001

	local var_30_9 = arg_30_0.privateBtn

	PLATFORM_CODE = var_30_7
	PLATFORM_CH = var_30_8

	var_1_10001(var_30_9, var_30_7 == var_30_8)

	setActive = var_1_10001

	local var_30_10 = arg_30_0.licenceBtn

	PLATFORM_CODE = var_4
	PLATFORM_CH = var_30_8

	var_1_10001(var_30_10, var_4 == var_30_8)

	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CODE = var_1_10001
		PLATFORM_US = var_1_10002

		if var_1_10001 == var_1_10002 then
			onButton = var_1_10001

			var_1_10001(arg_30_0, arg_30_0.userDisagreeConfirmTF, function()
				setActive = var_2_10000

				var_2_10000(arg_30_0.userAgreenTF, false)

				pg = var_2_10000

				local var_35_0 = var_2_10000.UIMgr.GetInstance()

				var_0.UnOverlayPanel(var_35_0, arg_30_0.userAgreenTF, arg_30_0._tf)

				return
			end)
		end

		setActive = var_1_10001

		local var_30_11 = arg_30_0.serviceBtn

		PLATFORM_CODE = var_4
		PLATFORM_KR = var_30_8

		var_1_10001(var_30_11, var_4 == var_30_8)

		onButton = var_1_10001

		local var_30_12 = arg_30_0
		local var_30_13 = arg_30_0.serviceBtn

		local function var_30_14()
			PLATFORM_CODE = var_2_10000
			PLATFORM_KR = var_2_10001

			if var_2_10000 == var_2_10001 then
				pg = var_2_10000

				local var_36_0 = var_2_10000.SdkMgr.GetInstance()

				var_2_10000.UserCenter(var_36_0)
			else
				pg = var_2_10000

				local var_36_1 = var_2_10000.TipsMgr.GetInstance()
				local var_36_2 = var_0.ShowTips

				i18n = var_2_10003

				var_36_2(var_36_1, var_2_10003("word_systemClose"))
			end

			return
		end

		SFX_MAIN = var_1_10006

		var_1_10001(var_30_12, var_30_13, var_30_14, var_1_10006)

		onButton = var_1_10001

		local var_30_15 = arg_30_0
		local var_30_16 = arg_30_0.accountBtn

		local function var_30_17()
			pg = var_2_10000

			local var_37_0 = var_2_10000.SdkMgr.GetInstance()
			local var_37_1 = var_0.GetLoginType(var_37_0)

			LoginType = var_2_10001

			if not (var_37_1 ~= var_2_10001.PLATFORM_INNER) then
				local var_37_2 = arg_30_0

				var_37_0.switchToLogin(var_37_2)
			elseif var_1 then
				PLATFORM_KR = var_37_0
				PLATFORM_CODE = var_2_10003

				if var_37_0 == var_2_10003 then
					pg = var_37_0

					local var_37_3 = var_37_0.SdkMgr.GetInstance()

					var_2.SwitchAccount(var_37_3)
				end
			end

			return
		end

		SFX_MAIN = var_1_10006

		var_1_10001(var_30_15, var_30_16, var_30_17, var_1_10006)

		onButton = var_1_10001

		var_1_10001(arg_30_0, arg_30_0.repairBtn, function()
			pg = var_2_10000

			local var_38_0 = var_2_10000.RepairResMgr.GetInstance()

			var_0.Repair(var_38_0)

			return
		end)

		local function var_30_18()
			pg = var_2_10000

			local var_39_0 = var_2_10000.SdkMgr.GetInstance()
			local var_39_1 = var_0.GetLoginType(var_39_0)

			LoginType = var_2_10001

			if var_39_1 == var_2_10001.PLATFORM then
				pg = var_1

				local var_39_2 = var_1.SdkMgr.GetInstance()

				var_1.LoginSdk(var_39_2)
			else
				LoginType = var_1

				if var_39_1 == var_1.PLATFORM_TENCENT then
					local var_39_3 = arg_30_0

					var_1.switchToTencentLogin(var_39_3)
				else
					LoginType = var_1

					if var_39_1 == var_1.PLATFORM_INNER then
						local var_39_4 = arg_30_0

						var_1.switchToLogin(var_39_4)
					end
				end
			end

			return
		end

		onButton = var_1_10002

		local var_30_19 = arg_30_0
		local var_30_20 = arg_30_0.filingBtn

		local function var_30_21()
			Application = var_2_10000

			var_2_10000.OpenURL("http://sq.ccm.gov.cn:80/ccnt/sczr/service/business/emark/gameNetTag/4028c08b58bd467b0158bd8bd80d062a")

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10002(var_30_19, var_30_20, var_30_21, var_1_10007)

		onButton = var_1_10002

		local var_30_22 = arg_30_0
		local var_30_23 = arg_30_0.currentServer

		local function var_30_24()
			table = var_2_10000

			local var_41_0 = var_2_10000.getCount
			local var_41_1

			if not arg_30_0.serverList then
				var_41_1 = {}
			end

			if var_41_0(var_41_1) == 0 then
				var_30_18()
			else
				pg = var_0

				local var_41_2 = var_0.UIMgr.GetInstance()

				var_0.BlurPanel(var_41_2, arg_30_0.serversPanel)

				setActive = var_0

				var_0(arg_30_0.serversPanel, true)
			end

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10002(var_30_22, var_30_23, var_30_24, var_1_10007)

		onButton = var_1_10002

		local var_30_25 = arg_30_0
		local var_30_26 = arg_30_0.serversPanel

		local function var_30_27()
			pg = var_2_10000

			local var_42_0 = var_2_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_42_0, arg_30_0.serversPanel, arg_30_0._tf)

			setActive = var_0

			var_0(arg_30_0.serversPanel, false)

			return
		end

		SFX_CANCEL = var_1_10007

		var_1_10002(var_30_25, var_30_26, var_30_27, var_1_10007)

		onButton = var_1_10002

		local var_30_28 = arg_30_0
		local var_30_29 = arg_30_0._tf

		var_1_10002(var_30_28, var_5.Find(var_30_29, "background"), function()
			pg = var_2_10000

			local var_43_0 = var_2_10000.CpkPlayMgr.GetInstance()

			if var_0.OnPlaying(var_43_0) then
				return
			end

			if not arg_30_0.initFinished then
				return
			end

			local var_43_1

			if arg_30_0.isNeedResCheck then
				var_43_0 = arg_30_0.event
				var_43_1 = var_43_1.emit
				LoginMediator = var_2_10003

				var_43_1(var_43_0, var_2_10003.CHECK_RES)

				return
			end

			getProxy = var_43_1
			SettingsProxy = var_43_0

			local var_43_2 = var_43_1(var_43_0)
			local var_43_4

			if var_0.CheckNeedUserAgreement(var_43_2) then
				local var_43_3 = arg_30_0.event

				var_43_4 = var_43_4.emit
				LoginMediator = var_2_10004

				var_43_4(var_43_3, var_2_10004.ON_LOGIN_PROCESS)

				return
			end

			go = var_43_4

			if var_43_4(arg_30_0.pressToLogin).activeSelf then
				table = var_1

				local var_43_5 = var_1.getCount
				local var_43_6

				if not arg_30_0.serverList then
					var_43_6 = {}
				end

				if var_43_5(var_43_6) == 0 then
					var_30_18()

					return
				end

				if not arg_30_0.shareData.lastLoginServer then
					pg = var_1

					local var_43_7 = var_1.TipsMgr.GetInstance()
					local var_43_8 = var_1.ShowTips

					i18n = var_2_10004

					var_43_8(var_43_7, var_2_10004("login_loginScene_choiseServer"))

					return
				end

				local var_43_9 = arg_30_0.shareData.lastLoginServer.status

				Server = var_43_0

				if var_43_9 ~= var_43_0.STATUS.VINDICATE then
					var_43_9 = arg_30_0.shareData.lastLoginServer.status
					Server = var_2

					if var_43_9 == var_2.STATUS.FULL then
						ServerStateChecker = var_43_9

						local var_43_10 = var_43_9.New()

						var_1.Execute(var_43_10, function(arg_44_0)
							if arg_44_0 then
								pg = var_3_10001

								local var_44_0 = var_3_10001.TipsMgr.GetInstance()
								local var_44_1 = var_1.ShowTips

								i18n = var_3_10004

								var_44_1(var_44_0, var_3_10004("login_loginScene_server_disabled"))
							else
								local var_44_2 = arg_30_0.event
								local var_44_3 = var_1.emit

								LoginMediator = var_3_10004

								var_44_3(var_44_2, var_3_10004.ON_SERVER, arg_30_0.shareData.lastLoginServer)

								pg = var_44_3

								local var_44_4 = var_44_3.CriMgr.GetInstance()
								local var_44_5 = var_1.PlaySoundEffect_V3

								SFX_CONFIRM = var_4

								var_44_5(var_44_4, var_4)
							end

							return
						end)

						return
					end

					local var_43_11 = arg_30_0.event
					local var_43_12 = var_1.emit

					LoginMediator = var_2_10004

					var_43_12(var_43_11, var_2_10004.ON_SERVER, arg_30_0.shareData.lastLoginServer)

					pg = var_43_12

					local var_43_13 = var_43_12.CriMgr.GetInstance()
					local var_43_14 = var_1.PlaySoundEffect_V3

					SFX_CONFIRM = var_4

					var_43_14(var_43_13, var_4)

					return
				end
			end
		end)

		if arg_30_0.isOpPlay then
			onButton = var_2

			var_2(arg_30_0, arg_30_0.opBtn, function()
				if arg_30_0.initFinished then
					pg = var_0

					local var_45_0 = var_0.CpkPlayMgr.GetInstance()

					if not var_0.OnPlaying(var_45_0) then
						local var_45_1 = arg_30_0

						var_0.playOpening(var_45_1)
					end
				end

				return
			end)

			PLATFORM_CODE = var_2
			PLATFORM_JP = var_3

			if var_2 ~= var_3 then
				PlayerPrefs = var_2

				if var_2.GetString("op_ver", "") ~= arg_30_0.opVersion then
					arg_30_0:playOpening(function()
						PlayerPrefs = var_2_10000

						var_2_10000.SetString("op_ver", arg_30_0.opVersion)

						local var_46_0 = arg_30_0

						var_0.playExtraVoice(var_46_0)

						arg_30_0.initFinished = true

						local var_46_1 = arg_30_0.event
						local var_46_2 = var_0.emit

						LoginMediator = var_3

						var_46_2(var_46_1, var_3.ON_LOGIN_PROCESS)

						return
					end)

					return
				end
			end

			local var_30_30 = arg_30_0.event
			local var_30_31 = var_2.emit

			LoginMediator = var_5

			var_30_31(var_30_30, var_5.ON_LOGIN_PROCESS)
		else
			local var_30_32 = arg_30_0.event
			local var_30_33 = var_2.emit

			LoginMediator = var_5

			var_30_33(var_30_32, var_5.ON_LOGIN_PROCESS)
		end

		arg_30_0:playExtraVoice()

		arg_30_0.initFinished = true

		arg_30_0:InitPrivateAndLicence()

		return
	end
end

function var_0_1.InitPrivateAndLicence(arg_47_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002
	var_1_10001 = var_1_10001 == var_1_10002 or var_1_10001
	setActive = var_1_10002

	var_1_10002(arg_47_0.privateBtn, var_1_10001)

	setActive = var_1_10002

	var_1_10002(arg_47_0.licenceBtn, var_1_10001)

	if var_1_10001 then
		onButton = var_1_10002

		local var_47_0 = arg_47_0
		local var_47_1 = arg_47_0.privateBtn

		local function var_47_2()
			pg = var_2_10000

			local var_48_0 = var_2_10000.SdkMgr.GetInstance()

			var_0.ShowPrivate(var_48_0)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10002(var_47_0, var_47_1, var_47_2, var_1_10007)

		onButton = var_1_10002

		local var_47_3 = arg_47_0
		local var_47_4 = arg_47_0.licenceBtn

		local function var_47_5()
			pg = var_2_10000

			local var_49_0 = var_2_10000.SdkMgr.GetInstance()

			var_0.ShowLicence(var_49_0)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10002(var_47_3, var_47_4, var_47_5, var_1_10007)
	end

	return
end

local function var_0_3()
	pg = var_1_10000

	if var_1_10000.gameset.login_extra_voice.description and #var_0 > 0 then
		math = var_1

		local var_50_0 = var_1.clamp

		math = var_1_10003

		local var_50_1 = var_1_10003.floor

		math = var_1_10005

		local var_50_2 = var_0[var_50_0(var_50_1(var_1_10005.random() * #var_0) + 1, 1, #var_0)]

		return "cv-" .. var_50_2, "extra"
	end

	return nil, nil
end

local function var_0_4(arg_51_0)
	local var_51_0 = arg_51_0.description[1]
	local var_51_1 = arg_51_0.description[2]
	local var_51_2 = arg_51_0.description[3]

	pg = var_1_10004

	local var_51_3 = var_1_10004.TimeMgr.GetInstance()

	if var_4.inTime(var_51_3, var_51_1) then
		math = var_4

		local var_51_4 = var_4.random(1, var_51_2)

		return var_51_0, "extra" .. var_51_4
	end

	return nil, nil
end

function var_0_1.GetExtraVoiceSheetAndCue(arg_52_0)
	local var_52_0
	local var_52_1

	pg = var_1_10003

	if var_1_10003.gameset.new_login_extra_voice then
		var_52_0, var_52_1 = var_0_4(var_3)
	end

	if not var_52_0 or not var_52_1 then
		var_52_0, var_52_1 = var_0_3()
	end

	return var_52_0, var_52_1
end

function var_0_1.playExtraVoice(arg_53_0)
	local var_53_0 = arg_53_0
	local var_53_1, var_53_2 = arg_53_0.GetExtraVoiceSheetAndCue(var_53_0)

	if var_53_1 and var_53_2 then
		arg_53_0.loginCueSheet = var_53_1
		pg = var_53_0

		local var_53_3 = var_53_0.CriMgr.GetInstance()

		var_3.PlayCV_V3(var_53_3, var_53_1, var_53_2)
	end

	return
end

function var_0_1.unloadExtraVoice(arg_54_0)
	if arg_54_0.loginCueSheet then
		pg = var_1

		local var_54_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadCueSheet(var_54_0, arg_54_0.loginCueSheet)

		arg_54_0.loginCueSheet = nil
	end

	return
end

function var_0_1.autoLogin(arg_55_0)
	if arg_55_0.shareData.lastLoginUser then
		if arg_55_0.shareData.autoLoginEnabled then
			local var_55_0 = arg_55_0.event
			local var_55_1 = var_1.emit

			LoginMediator = var_1_10004

			var_55_1(var_55_0, var_1_10004.ON_LOGIN, arg_55_0.shareData.lastLoginUser)
		end

		local var_55_2 = arg_55_0.loginPanelView

		if var_1.GetLoaded(var_55_2) then
			if arg_55_0.shareData.lastLoginUser.type == 1 then
				local var_55_3 = arg_55_0.loginPanelView

				var_1.ActionInvoke(var_55_3, "SetContent", arg_55_0.shareData.lastLoginUser.arg2, arg_55_0.shareData.lastLoginUser.arg3)
			elseif arg_55_0.shareData.lastLoginUser.type == 2 then
				local var_55_4 = arg_55_0.loginPanelView

				var_1.ActionInvoke(var_55_4, "SetContent", arg_55_0.shareData.lastLoginUser.arg1, arg_55_0.shareData.lastLoginUser.arg2)
			end
		end
	end

	return
end

local var_0_5 = {
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

function var_0_1.updateServerTF(arg_56_0, arg_56_1, arg_56_2)
	setText = var_1_10003
	findTF = var_1_10005

	var_1_10003(var_1_10005(arg_56_1, "name"), "-  " .. arg_56_2.name .. "  -")

	local var_56_0 = arg_56_0
	local var_56_1 = arg_56_0.setSpriteTo
	local var_56_2 = arg_56_0.iconSpries[arg_56_2.status + 1]

	findTF = var_7

	var_56_1(var_56_0, var_56_2, var_7(arg_56_1, "statu"), true)

	findTF = var_56_1

	local var_56_3 = var_56_1(arg_56_1, "statu_1")
	local var_56_4 = var_3.GetComponent(var_56_3, "Image")

	Color = var_1_10004
	var_56_4.color = var_1_10004.New(var_0_5[arg_56_2.status + 1][1], var_0_5[arg_56_2.status + 1][2], var_0_5[arg_56_2.status + 1][3], var_0_5[arg_56_2.status + 1][4])
	setActive = var_56_4
	findTF = var_56_3

	var_56_4(var_56_3(arg_56_1, "mark"), arg_56_2.isLogined)

	setActive = var_56_4

	var_56_4(arg_56_1:Find("tag_new"), arg_56_2.isNew)

	setActive = var_56_4

	var_56_4(arg_56_1:Find("tag_hot"), arg_56_2.isHot)

	onButton = var_56_4

	local var_56_5 = arg_56_0
	local var_56_6 = arg_56_1

	local function var_56_7()
		local var_57_0 = arg_56_2.status

		Server = var_2_10001

		if var_57_0 == var_2_10001.STATUS.VINDICATE then
			pg = var_57_0

			local var_57_1 = var_57_0.TipsMgr.GetInstance()
			local var_57_2 = var_0.ShowTips

			i18n = var_2_10003

			var_57_2(var_57_1, var_2_10003("login_loginScene_server_vindicate"))

			return
		end

		local var_57_3 = arg_56_2.status

		Server = var_1

		if var_57_3 == var_1.STATUS.FULL then
			pg = var_57_3

			local var_57_4 = var_57_3.TipsMgr.GetInstance()
			local var_57_5 = var_0.ShowTips

			i18n = var_2_10003

			var_57_5(var_57_4, var_2_10003("login_loginScene_server_full"))

			return
		end

		local var_57_6 = arg_56_0

		var_0.setLastLoginServer(var_57_6, arg_56_2)

		pg = var_0

		local var_57_7 = var_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_57_7, arg_56_0.serversPanel, arg_56_0._tf)

		setActive = var_0

		var_0(arg_56_0.serversPanel, false)

		return
	end

	SFX_CONFIRM = var_8

	var_56_4(var_56_5, var_56_6, var_56_7, var_8)

	return
end

function var_0_1.updateAdviceServer(arg_58_0)
	if not arg_58_0.recentTF or not arg_58_0.adviceTF then
		return
	end

	setActive = var_1

	var_1(arg_58_0.recentTF, arg_58_0.shareData.lastLoginServer)

	local var_58_0

	if arg_58_0.shareData.lastLoginServer then
		findTF = var_58_0
		var_58_0 = var_58_0(arg_58_0.recentTF, "server")

		arg_58_0:updateServerTF(var_58_0, arg_58_0.shareData.lastLoginServer)
	end

	getProxy = var_58_0
	ServerProxy = var_3

	local var_58_1 = var_58_0(var_3).firstServer

	setActive = var_1_10002

	var_1_10002(arg_58_0.adviceTF, var_58_1)

	if var_58_1 then
		findTF = var_1_10002

		local var_58_2 = var_1_10002(arg_58_0.adviceTF, "server")

		arg_58_0:updateServerTF(var_58_2, var_58_1)
	end

	return
end

function var_0_1.updateServerList(arg_59_0, arg_59_1)
	arg_59_0.serverList = arg_59_1
	_ = var_1_10002

	local var_59_0 = var_1_10002.sort

	_ = var_1_10004

	local var_59_1 = var_59_0(var_1_10004.values(arg_59_1), function(arg_60_0, arg_60_1)
		return arg_60_0.sortIndex < arg_60_1.sortIndex
	end)

	removeAllChildren = var_1_10003

	var_1_10003(arg_59_0.servers)

	IsUnityEditor = var_1_10003

	if var_1_10003 then
		table = var_1_10003

		var_1_10003.sort(var_59_1, function(arg_61_0, arg_61_1)
			string = var_2_10002

			local var_61_0 = var_2_10002.lower(arg_61_0.name)

			string = var_2_10003

			local var_61_1 = var_2_10003.lower(arg_61_1.name)

			string = var_4

			local var_61_2 = var_4.byte(var_61_0, 1)

			string = var_5

			return var_61_2 > var_5.byte(var_61_1, 1)
		end)
	end

	arg_59_0.serversDic = {}
	pairs = var_3

	for iter_59_0, iter_59_1 in var_3(var_59_1) do
		cloneTplTo = var_1_10008
		var_1_10008 = var_1_10008(arg_59_0.serverTpl, arg_59_0.servers)

		arg_59_0:updateServerTF(var_1_10008, iter_59_1)

		table = var_9

		var_9.insert(arg_59_0.serversDic, {
			server = iter_59_1,
			tf = var_1_10008,
			id = iter_59_1.id
		})
	end

	return
end

function var_0_1.fillterRefundServer(arg_62_0)
	getProxy = var_1_10001
	UserProxy = var_1_10003

	local var_62_0 = var_1_10001(var_1_10003)
	local var_62_1 = {}

	if var_62_0.data.limitServerIds and #var_62_0.data.limitServerIds > 0 and arg_62_0.serverList and #arg_62_0.serverList > 0 then
		local var_62_2 = var_62_0.data.limitServerIds
		local var_62_3

		pairs = var_1_10005

		for iter_62_0, iter_62_1 in var_1_10005(arg_62_0.serverList) do
			local var_62_4 = iter_62_1.id
			local var_62_5 = false

			pairs = var_1_10012

			for iter_62_2, iter_62_3 in var_1_10012(var_62_2) do
				if var_62_2[iter_62_2] == var_62_4 and not var_62_5 then
					if not var_62_3 then
						var_62_3 = "\n" .. iter_62_1.name
					else
						var_62_3 = var_62_3 .. "," .. iter_62_1.name
					end

					table = var_17

					var_17.insert(var_62_1, iter_62_1)

					var_62_5 = true
				end
			end
		end

		arg_62_0:updateServerList(var_62_1)

		pg = var_5

		local var_62_6 = var_5.MsgboxMgr.GetInstance()
		local var_62_7 = var_5.ShowMsgBox
		local var_62_8 = {
			modal = true,
			hideNo = true,
			hideClose = true
		}

		i18n = iter_62_1
		var_62_8.content = iter_62_1("login_arrears_tips", var_62_3)

		function var_62_8.onYes()
			return
		end

		var_62_7(var_62_6, var_62_8)
	end

	return
end

function var_0_1.switchToTencentLogin(arg_64_0)
	local var_64_0 = arg_64_0
	local var_64_1 = arg_64_0.switchSubView
	local var_64_2 = {}

	LoginSceneConst = var_1_10005
	var_64_2[1] = var_1_10005.DEFINE.TENCENT_LOGIN_VIEW

	var_64_1(var_64_0, var_64_2)

	return
end

function var_0_1.switchToAiriLogin(arg_65_0)
	local var_65_0 = arg_65_0
	local var_65_1 = arg_65_0.switchSubView
	local var_65_2 = {}

	LoginSceneConst = var_1_10005
	var_65_2[1] = var_1_10005.DEFINE.AIRI_LOGIN_PANEL_VIEW
	LoginSceneConst = var_5
	var_65_2[2] = var_5.DEFINE.PRESS_TO_LOGIN

	var_65_1(var_65_0, var_65_2)

	return
end

function var_0_1.switchToLogin(arg_66_0)
	local var_66_0 = arg_66_0
	local var_66_1 = arg_66_0.switchSubView
	local var_66_2 = {}

	LoginSceneConst = var_1_10005
	var_66_2[1] = var_1_10005.DEFINE.LOGIN_PANEL_VIEW

	var_66_1(var_66_0, var_66_2)

	return
end

function var_0_1.switchToRegister(arg_67_0)
	local var_67_0 = arg_67_0
	local var_67_1 = arg_67_0.switchSubView
	local var_67_2 = {}

	LoginSceneConst = var_1_10005
	var_67_2[1] = var_1_10005.DEFINE.REGISTER_PANEL_VIEW

	var_67_1(var_67_0, var_67_2)

	return
end

function var_0_1.switchToServer(arg_68_0)
	arg_68_0:updateAdviceServer()

	pg = var_1

	local var_68_0 = var_1.SdkMgr.GetInstance()
	local var_68_1 = var_1.GetLoginType(var_68_0)

	LoginType = var_1_10002

	if var_68_1 ~= var_1_10002.PLATFORM_INNER then
		PLATFORM_CODE = var_68_0
		PLATFORM_KR = var_1_10004

		if var_68_0 ~= var_1_10004 then
			local var_68_2 = arg_68_0
			local var_68_3 = arg_68_0.switchSubView
			local var_68_4 = {}

			LoginSceneConst = var_1_10007
			var_68_4[1] = var_1_10007.DEFINE.PRESS_TO_LOGIN
			LoginSceneConst = var_1_10007
			var_68_4[2] = var_1_10007.DEFINE.CURRENT_SERVER
			LoginSceneConst = var_1_10007
			var_68_4[3] = var_1_10007.DEFINE.BG_LAY

			var_68_3(var_68_2, var_68_4)

			goto label_68_0
		end
	end

	do
		local var_68_5 = arg_68_0
		local var_68_6 = arg_68_0.switchSubView
		local var_68_7 = {}

		LoginSceneConst = var_1_10007
		var_68_7[1] = var_1_10007.DEFINE.ACCOUNT_BTN
		LoginSceneConst = var_7
		var_68_7[2] = var_7.DEFINE.PRESS_TO_LOGIN
		LoginSceneConst = var_7
		var_68_7[3] = var_7.DEFINE.CURRENT_SERVER
		LoginSceneConst = var_7
		var_68_7[4] = var_7.DEFINE.BG_LAY

		var_68_6(var_68_5, var_68_7)
	end

	::label_68_0::

	return
end

function var_0_1.SwitchToWaitPanel(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0.adapt
	local var_69_1 = var_2.Find(var_69_0, "Msgbox")
	local var_69_2 = var_2.Find(var_69_1, "window/content")

	arg_69_0.waitTimer = nil

	local var_69_3 = 0
	local var_69_4 = arg_69_1

	Timer = var_6
	arg_69_0.waitTimer = var_6.New(function()
		setText = var_2_10000

		local var_70_0 = var_69_2

		i18n = var_2_10003

		var_2_10000(var_70_0, var_2_10003("login_wait_tip", var_69_4))

		arg_69_1 = arg_69_1 - 1
		math = var_0

		if var_0.random(0, 1) == 1 then
			var_69_4 = arg_69_1
		end

		if arg_69_1 <= 0 then
			triggerButton = var_0

			local var_70_1 = arg_69_0._tf

			var_0(var_2.Find(var_70_1, "background"))

			local var_70_2 = arg_69_0.waitTimer

			var_0.Stop(var_70_2)

			arg_69_0.waitTimer = nil
		end

		return
	end, 1, -1)

	local var_69_5 = arg_69_0.waitTimer

	var_6.Start(var_69_5)
	arg_69_0.waitTimer.func()

	setActive = var_6

	var_6(var_2, true)

	return
end

function var_0_1.willExit(arg_71_0)
	if arg_71_0.waitTimer then
		local var_71_0 = arg_71_0.waitTimer

		var_1.Stop(var_71_0)

		arg_71_0.waitTimer = nil
	end

	pg = var_1

	local var_71_1 = var_1.CpkPlayMgr.GetInstance()

	var_1.DisposeCpkMovie(var_71_1)

	local var_71_2 = arg_71_0.loginPanelView

	var_1.Destroy(var_71_2)

	local var_71_3 = arg_71_0.registerPanelView

	var_1.Destroy(var_71_3)

	local var_71_4 = arg_71_0.tencentLoginPanelView

	var_1.Destroy(var_71_4)

	local var_71_5 = arg_71_0.airiLoginPanelView

	var_1.Destroy(var_71_5)

	local var_71_6 = arg_71_0.transcodeAlertView

	var_1.Destroy(var_71_6)

	local var_71_7 = arg_71_0.yostarAlertView

	var_1.Destroy(var_71_7)

	local var_71_8 = arg_71_0.switchGatewayBtn

	var_1.Dispose(var_71_8)

	PLATFORM = var_1
	PLATFORM_OPENHARMONY = var_1_10002

	if var_1 == var_1_10002 then
		local var_71_9 = arg_71_0.switchGatewayBtn4Oh

		var_1.Dispose(var_71_9)
	end

	arg_71_0.iconSpries = nil

	return
end

function var_0_1.playOpening(arg_72_0, arg_72_1)
	pg = var_1_10002

	local var_72_0 = var_1_10002.CpkPlayMgr.GetInstance()

	var_2.PlayCpkMovie(var_72_0, function()
		if not arg_72_0.cg then
			local var_73_0 = arg_72_0

			GetOrAddComponent = var_2_10001
			var_73_0.cg = var_2_10001(arg_72_0._tf, "CanvasGroup")
		end

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

function var_0_1.closeYostarAlertView(arg_75_0)
	if arg_75_0.yostarAlertView then
		local var_75_0 = arg_75_0.yostarAlertView
		local var_75_1 = var_1.CheckState

		BaseSubView = var_1_10004

		if var_75_1(var_75_0, var_1_10004.STATES.INITED) then
			local var_75_2 = arg_75_0.yostarAlertView

			var_1.Destroy(var_75_2)
		end
	end

	return
end

function var_0_1.onLoadDataDone(arg_76_0)
	local var_76_0 = arg_76_0

	arg_76_0.unloadExtraVoice(var_76_0)

	getProxy = var_1
	PlayerProxy = var_76_0

	if var_1(var_76_0) then
		getProxy = var_1_10002
		PlayerProxy = var_1_10004

		local var_76_1 = var_1_10002(var_1_10004)

		var_2.setFlag(var_76_1, "login", true)

		pg = var_2

		local var_76_2 = var_2.m02
		local var_76_3 = var_2.sendNotification

		GAME = var_5

		local var_76_4 = var_5.GO_SCENE

		SCENE = var_6

		var_76_3(var_76_2, var_76_4, var_6.MAINUI, {
			isFromLogin = true
		})
	end

	return
end

return var_0_1
