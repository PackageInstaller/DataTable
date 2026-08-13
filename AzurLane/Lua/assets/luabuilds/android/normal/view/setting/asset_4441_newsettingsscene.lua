class = var_0_10000

local var_0_0 = "NewSettingsScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.PAGE_OTHER = 1
var_0_1.PAGE_OPTION = 2
var_0_1.PAGE_BATTLE = 3
var_0_1.PAGE_RES = 4
var_0_1.PAGE_3D = 5

function var_0_1.getUIName(arg_1_0)
	return "NewSettingsUI"
end

function var_0_1.OnShowDescWindow(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.descWindow

	var_2.ExecuteAction(var_2_0, "Show", arg_2_1.desc, arg_2_1.alignment)

	return
end

function var_0_1.OnClearExchangeCode(arg_3_0)
	if arg_3_0.pages and arg_3_0.pages[1] then
		local var_3_0 = arg_3_0.pages[1]

		if var_1.GetLoaded(var_3_0) then
			local var_3_1 = arg_3_0.pages[1]

			var_1.OnClearExchangeCode(var_3_1)
		end
	end

	return
end

function var_0_1.OnShowTranscode(arg_4_0, arg_4_1)
	if arg_4_0.pages and arg_4_0.pages[1] then
		local var_4_0 = arg_4_0.pages[1]

		if var_2.GetLoaded(var_4_0) then
			local var_4_1 = arg_4_0.pages[1]

			var_2.OnShowTranscode(var_4_1, arg_4_1)
		end
	end

	return
end

function var_0_1.OnCheckAllAccountState(arg_5_0)
	if arg_5_0.pages and arg_5_0.pages[1] then
		local var_5_0 = arg_5_0.pages[1]

		if var_1.GetLoaded(var_5_0) then
			local var_5_1 = arg_5_0.pages[1]

			var_1.OnCheckAllAccountState(var_5_1)
		end
	end

	return
end

function var_0_1.OnSecondPwdStateChange(arg_6_0)
	if arg_6_0.pages and arg_6_0.pages[1] then
		local var_6_0 = arg_6_0.pages[1]

		if var_1.GetLoaded(var_6_0) then
			local var_6_1 = arg_6_0.pages[1]

			var_1.OnSecondPwdStateChange(var_6_1)
		end
	end

	return
end

function var_0_1.OnRandomFlagShipModeUpdate(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.emit

	SettingsRandomFlagShipAndSkinPanel = var_1_10003

	var_7_1(var_7_0, var_1_10003.EVT_UPDTAE)

	return
end

function var_0_1.OnSelectGraphicSettingLevel(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.emit

	SettingsOtherGraphicsPanle = var_1_10003

	var_8_1(var_8_0, var_1_10003.EVT_UPDTAE)

	return
end

function var_0_1.OnSelectCustomGraphicSetting(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	SettingsGraphicsPanle = var_1_10003

	var_9_1(var_9_0, var_1_10003.EVT_UPDTAE)

	return
end

function var_0_1.OnApplicationPause(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.emit

	SettingsNotificationPanel = var_1_10003

	var_10_1(var_10_0, var_1_10003.UPDATE_ALARM_PANEL)

	return
end

function var_0_1.GetPage(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.pages) do
		isa = var_1_10007

		if var_1_10007(iter_11_1, arg_11_1) then
			return iter_11_1
		end
	end

	return
end

function var_0_1.init(arg_12_0)
	local var_12_0 = arg_12_0._tf

	arg_12_0.backBtn = var_1.Find(var_12_0, "blur_panel/adapt/top/back_btn")

	local var_12_1 = arg_12_0._tf
	local var_12_2 = var_1.Find(var_12_1, "pages")
	local var_12_3 = {}

	SettingsOtherPage = var_3
	var_12_3[1] = var_3.New(var_12_2, arg_12_0.event, arg_12_0.contextData)
	SettingsOptionPage = var_3
	var_12_3[2] = var_3.New(var_12_2, arg_12_0.event, arg_12_0.contextData)
	SettingsBattlePage = var_3
	var_12_3[3] = var_3.New(var_12_2, arg_12_0.event, arg_12_0.contextData)
	SettingsResPage = var_3
	var_12_3[4] = var_3.New(var_12_2, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.pages = var_12_3

	local var_12_4 = {}
	local var_12_5 = arg_12_0._tf

	var_12_4[1] = var_3.Find(var_12_5, "blur_panel/adapt/left_length/other")

	local var_12_6 = arg_12_0._tf

	var_12_4[2] = var_3.Find(var_12_6, "blur_panel/adapt/left_length/options")

	local var_12_7 = arg_12_0._tf

	var_12_4[3] = var_3.Find(var_12_7, "blur_panel/adapt/left_length/battle_ui")

	local var_12_8 = arg_12_0._tf

	var_12_4[4] = var_3.Find(var_12_8, "blur_panel/adapt/left_length/resources")
	arg_12_0.toggles = var_12_4

	local var_12_9 = arg_12_0.toggles[1]

	arg_12_0.otherTip = var_2.Find(var_12_9, "tip")

	local var_12_10 = arg_12_0._tf

	arg_12_0.logoutBtn = var_2.Find(var_12_10, "blur_panel/adapt/left_length/logout")

	local var_12_11 = arg_12_0._tf

	arg_12_0.helpBtn = var_2.Find(var_12_11, "blur_panel/adapt/left_length/help_us")
	SettingsMsgBosPage = var_2
	arg_12_0.descWindow = var_2.New(arg_12_0._tf, arg_12_0.event)
	setActive = var_2

	local var_12_12 = arg_12_0._tf

	var_2(var_3.Find(var_12_12, "blur_panel/adapt/left_length/threeD"), false)

	return
end

function var_0_1.didEnter(arg_13_0)
	onButton = var_1_10001

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.backBtn

	local function var_13_2()
		local var_14_0 = arg_13_0

		var_0.closeView(var_14_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_13_0, var_13_1, var_13_2, var_1_10005)

	onButton = var_1_10001

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.logoutBtn

	local function var_13_5()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		i18n = var_2_10003
		var_15_2.content = var_2_10003("main_settingsScene_quest_exist")

		function var_15_2.onYes()
			local var_16_0 = arg_13_0
			local var_16_1 = var_0.emit

			NewSettingsMediator = var_3_10002

			var_16_1(var_16_0, var_3_10002.ON_LOGOUT)

			return
		end

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_13_3, var_13_4, var_13_5, var_1_10005)

	PLATFORM_CODE = var_1_10001
	PLATFORM_US = var_13_3

	if var_1_10001 == var_13_3 then
		setActive = var_1_10001

		var_1_10001(arg_13_0.helpBtn, true)

		onButton = var_1_10001
		var_13_3 = arg_13_0

		local var_13_6 = arg_13_0.helpBtn

		local function var_13_7()
			pg = var_2_10000

			local var_17_0 = var_2_10000.SdkMgr.GetInstance()

			var_0.OpenYostarHelp(var_17_0)

			return
		end

		SFX_PANEL = var_1_10005

		var_1_10001(var_13_3, var_13_6, var_13_7, var_1_10005)
	else
		PLATFORM_CODE = var_1_10001
		PLATFORM_KR = var_13_3

		if var_1_10001 == var_13_3 then
			setActive = var_1_10001

			var_1_10001(arg_13_0.helpBtn, true)

			onButton = var_1_10001

			local var_13_8 = arg_13_0
			local var_13_9 = arg_13_0.helpBtn

			local function var_13_10()
				pg = var_2_10000

				local var_18_0 = var_2_10000.SdkMgr.GetInstance()

				var_0.BugReport(var_18_0)

				return
			end

			SFX_CANCEL = var_1_10005

			var_1_10001(var_13_8, var_13_9, var_13_10, var_1_10005)

			local var_13_11 = arg_13_0.helpBtn

			var_1_10001.SetAsFirstSibling(var_13_11)
		end
	end

	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.toggles) do
		onToggle = var_1_10006

		local var_13_12 = arg_13_0
		local var_13_13 = iter_13_1

		local function var_13_14(arg_19_0)
			if arg_19_0 then
				local var_19_0 = arg_13_0

				var_1.SwitchPage(var_19_0, iter_13_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_13_12, var_13_13, var_13_14, var_1_10010)
	end

	setActive = var_1

	local var_13_15 = arg_13_0.otherTip

	PlayerPrefs = var_3

	var_1(var_13_15, var_3.GetInt("firstIntoOtherPanel", 0) == 0)
	arg_13_0:EnterDefaultPage()

	return
end

function var_0_1.EnterDefaultPage(arg_20_0)
	local var_20_0

	if arg_20_0.contextData.toggle then
		type = var_1_10003

		if var_1_10003(var_2) == "string" then
			if var_2 == "sound" or var_2 == "res" then
				var_20_0 = var_0_1.PAGE_RES
			else
				table = var_3
				var_20_0 = var_3.indexof({
					"other",
					"options",
					"interface",
					"res"
				}, var_2)
			end
		end
	end

	local var_20_1

	if not arg_20_0.contextData.page then
		var_20_1 = var_20_0 or var_0_1.PAGE_RES
	end

	triggerToggle = var_1_10004

	var_1_10004(arg_20_0.toggles[var_20_1], true)

	return
end

function var_0_1.SwitchPage(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.pages[arg_21_1]

	if arg_21_0.page and arg_21_0.page ~= var_21_0 then
		local var_21_1 = arg_21_0.page

		if var_3.GetLoaded(var_21_1) then
			local var_21_2 = arg_21_0.page

			var_3.Hide(var_21_2)
		end
	end

	var_21_0:ExecuteAction("Show")

	arg_21_0.page = var_21_0
	isa = var_3

	local var_21_3 = var_21_0

	Settings3DPage = var_5

	if var_3(var_21_3, var_5) then
		arg_21_0.hasShow3d = true
	end

	isa = var_3

	local var_21_4 = var_21_0

	SettingsOtherPage = var_5

	if var_3(var_21_4, var_5) then
		isActive = var_3

		if var_3(arg_21_0.otherTip) then
			setActive = var_3

			var_3(arg_21_0.otherTip, false)
		end
	end

	return
end

function var_0_1.OpenYostarAlertView(arg_22_0)
	YostarAlertView = var_1_10001
	arg_22_0.yostarAlertView = var_1_10001.New(arg_22_0._tf, arg_22_0.event, {
		isLinkMode = true,
		isDestroyOnClose = true
	})

	local var_22_0 = arg_22_0.yostarAlertView

	var_1.Load(var_22_0)

	local var_22_1 = arg_22_0.yostarAlertView

	var_1.ActionInvoke(var_22_1, "Show")

	return
end

function var_0_1.CloseYostarAlertView(arg_23_0)
	if arg_23_0.yostarAlertView then
		local var_23_0 = arg_23_0.yostarAlertView
		local var_23_1 = var_1.CheckState

		BaseSubView = var_1_10003

		if var_23_1(var_23_0, var_1_10003.STATES.INITED) then
			local var_23_2 = arg_23_0.yostarAlertView

			var_1.Destroy(var_23_2)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.CriMgr.GetInstance()
	local var_24_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_24_1(var_24_0, var_1_10003)

	GameObject = var_24_1

	local var_24_2 = var_24_1.Find("OverlayCamera/Overlay/UIMain/DialogPanel")

	isActive = var_2

	if var_2(var_24_2) then
		triggerButton = var_2

		local var_24_3 = var_24_2.transform

		var_2(var_3.Find(var_24_3, "dialog/title/back"))

		return
	end

	arg_24_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_25_0)
	if arg_25_0.hasShow3d then
		GraphicSettingConst = var_1

		var_1.SettingQuality()
	end

	pairs = var_1

	for iter_25_0, iter_25_1 in var_1(arg_25_0.pages) do
		iter_25_1:Destroy()
	end

	if arg_25_0.descWindow then
		local var_25_0 = arg_25_0.descWindow

		var_1.Destroy(var_25_0)

		arg_25_0.descWindow = nil
	end

	arg_25_0.page = nil
	arg_25_0.pages = nil

	return
end

return var_0_1
