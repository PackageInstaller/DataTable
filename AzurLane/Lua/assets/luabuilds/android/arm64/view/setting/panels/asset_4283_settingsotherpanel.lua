class = var_0_10000

local var_0_0 = "SettingsOtherPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

var_0_1.GRAPHI_API_SWITCH_OPTION_TYPE = 3

function var_0_1.GetUIName(arg_1_0)
	return "SettingsOther"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_Other")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / OTHER SETTINGS"
end

function var_0_1.OnInit(arg_4_0, ...)
	UIItemList = var_1_10001

	local var_4_0 = var_1_10001.New
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "options")
	local var_4_3 = arg_4_0._tf

	arg_4_0.uilist = var_4_0(var_4_2, var_4.Find(var_4_3, "options/notify_tpl"))

	local var_4_4 = arg_4_0.uilist

	var_1.make(var_4_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0

			var_3.UpdateItem(var_5_0, arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	PlayerPrefs = var_1

	local var_4_5 = var_1.GetInt("AUTOFIGHT_BATTERY_SAVEMODE", 0)
	local var_4_6 = 0 < var_4_5

	pg = var_2

	local var_4_7 = var_2.BrightnessMgr.GetInstance()
	local var_4_8 = var_2.IsPermissionGranted(var_4_7)

	if var_4_6 and not var_4_8 then
		PlayerPrefs = var_3

		var_3.SetInt("AUTOFIGHT_BATTERY_SAVEMODE", 0)

		PlayerPrefs = var_3

		var_3.Save()
	end

	return
end

function var_0_1.OnUpdate(arg_6_0)
	arg_6_0.list = arg_6_0:GetList()

	local var_6_0 = arg_6_0.uilist

	var_1.align(var_6_0, #arg_6_0.list)

	return
end

function var_0_1.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.list[arg_7_1]
	local var_7_1 = arg_7_2:Find("mask/Text")
	local var_7_2 = var_4.GetComponent(var_7_1, "ScrollText")

	var_4.SetText(var_7_2, var_7_0.title)

	onButton = var_5

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_2
	local var_7_5 = arg_7_2.Find(var_7_4, "mask/Text")

	local function var_7_6()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		NewSettingsMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.SHOW_DESC, var_7_0)

		return
	end

	SFX_PANEL = var_7_4

	var_5(var_7_3, var_7_5, var_7_6, var_7_4)

	removeOnToggle = var_5

	var_5(arg_7_2:Find("on"))

	if arg_7_0:GetDefaultValue(var_7_0) then
		triggerToggle = var_5

		var_5(arg_7_2:Find("on"), true)
	else
		triggerToggle = var_5

		var_5(arg_7_2:Find("off"), true)
	end

	onToggle = var_5

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_2
	local var_7_9 = arg_7_2.Find(var_7_8, "on")

	local function var_7_10(arg_9_0)
		local var_9_0 = arg_7_0

		var_1.OnItemSwitch(var_9_0, var_7_0, arg_9_0)

		return
	end

	SFX_UI_TAG = var_7_8
	SFX_UI_CANCEL = var_11

	var_5(var_7_7, var_7_9, var_7_10, var_7_8, var_11)
	arg_7_0:OnUpdateItem(var_7_0)
	arg_7_0:OnUpdateItemWithTr(var_7_0, arg_7_2)

	return
end

function var_0_1.OnItemSwitch(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1.id == 1 then
		pg = var_3

		local var_10_0 = var_3.PushNotificationMgr.GetInstance()

		var_3.setSwitchShipName(var_10_0, arg_10_2)
	elseif arg_10_1.id == 5 then
		arg_10_0:OnClickEffectItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.id == 9 then
		arg_10_0:OnAutoFightBatterySaveModeItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.id == 10 then
		arg_10_0:OnAutoFightDownFrameItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == 0 then
		arg_10_0:OnCommonLocalItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == 1 then
		arg_10_0:OnCommonServerItemSwitch(arg_10_1, arg_10_2)
	elseif arg_10_1.type == var_0_1.GRAPHI_API_SWITCH_OPTION_TYPE then
		arg_10_0:OnGraphApiItemSwitch(arg_10_1, arg_10_2)
	end

	if arg_10_1.id == 19 then
		local var_10_1 = arg_10_2 and 1 or 0

		pg = var_1_10004

		local var_10_2 = var_1_10004.GameTrackerMgr.GetInstance()
		local var_10_3 = var_4.Record

		GameTrackerBuilder = var_1_10007

		var_10_3(var_10_2, var_1_10007.BuildNewMainUI({
			isLogin = 0,
			isNewMainUI = var_10_1
		}))
	end

	return
end

function var_0_1.OnClickEffectItemSwitch(arg_11_0, arg_11_1, arg_11_2)
	pg = var_1_10003

	if var_1_10003.UIMgr.GetInstance().OverlayEffect then
		setActive = var_1_10004

		var_1_10004(var_3, arg_11_2)
	end

	arg_11_0:OnCommonLocalItemSwitch(arg_11_1, arg_11_2)

	return
end

function var_0_1.OnCommonServerItemSwitch(arg_12_0, arg_12_1, arg_12_2)
	_G = var_1_10003

	local var_12_0 = var_1_10003[arg_12_1.name]

	getProxy = var_4
	PlayerProxy = var_1_10006

	local var_12_1 = var_4(var_1_10006)
	local var_12_2 = var_4.getRawData(var_12_1)
	local var_12_3 = var_4.GetCommonFlag(var_12_2, var_12_0)
	local var_12_4 = not arg_12_2

	if arg_12_1.default == 1 then
		var_12_4 = arg_12_2
	end

	local var_12_6

	if var_12_4 then
		pg = var_12_6

		local var_12_5 = var_12_6.m02

		var_12_6 = var_12_6.sendNotification
		GAME = var_1_10009

		var_12_6(var_12_5, var_1_10009.CANCEL_COMMON_FLAG, {
			flagID = var_12_0
		})
	else
		pg = var_12_6

		local var_12_7 = var_12_6.m02
		local var_12_8 = var_6.sendNotification

		GAME = var_1_10009

		var_12_8(var_12_7, var_1_10009.COMMON_FLAG, {
			flagID = var_12_0
		})
	end

	return
end

function var_0_1.OnAutoFightBatterySaveModeItemSwitch(arg_13_0, arg_13_1, arg_13_2)
	local function var_13_0()
		local var_14_0 = arg_13_0.uilist.container
		local var_14_1 = var_0.GetChild(var_14_0, arg_13_1.id - 1)

		triggerToggle = var_2_10001

		var_2_10001(var_14_1:Find("off"), true)

		return
	end

	pg = var_1_10004

	local var_13_1 = var_1_10004.BrightnessMgr.GetInstance()

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_15_0)
			if arg_13_2 then
				local var_15_0 = var_13_1

				if var_1.IsPermissionGranted(var_15_0) then
					return arg_15_0()
				end

				pg = var_1

				local var_15_1 = var_1.MsgboxMgr.GetInstance()
				local var_15_2 = var_1.ShowMsgBox
				local var_15_3 = {}

				i18n = var_2_10005
				var_15_3.content = var_2_10005("words_autoFight_right")

				function var_15_3.onYes()
					local var_16_0 = var_13_1

					var_0.RequestPremission(var_16_0, function(arg_17_0)
						if arg_17_0 then
							arg_15_0()
						else
							var_13_0()
						end

						return
					end)

					return
				end

				var_15_3.onNo = var_13_0

				var_15_2(var_15_1, var_15_3)

				return
			end
		end,
		function(arg_18_0)
			_G = var_2_10001

			local var_18_0 = var_2_10001[arg_13_1.name]

			PlayerPrefs = var_2

			var_2.SetInt(var_18_0, arg_13_2 and 1 or 0)

			PlayerPrefs = var_2

			var_2.Save()

			local var_18_1 = arg_13_0.uilist.container
			local var_18_2 = var_2.GetChild(var_18_1, arg_13_1.id)

			triggerToggle = var_2_10003

			var_2_10003(var_18_2:Find(arg_13_2 and "on" or "off"), true)
			var_0_1.SetGrayOption(var_18_2, arg_13_2)

			return
		end
	})

	return
end

function var_0_1.OnAutoFightDownFrameItemSwitch(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0

	if not arg_19_0.GetDefaultValue(var_19_0, arg_19_0.list[9]) and arg_19_2 then
		pg = var_1_10004

		local var_19_1 = var_1_10004.TipsMgr.GetInstance()

		var_1_10004 = var_1_10004.ShowTips
		i18n = var_1_10007

		var_1_10004(var_19_1, var_1_10007("words_autoFight_tips"))

		local var_19_2 = arg_19_0.uilist.container

		var_1_10004 = var_1_10004.GetChild(var_19_2, arg_19_1.id - 1)
		triggerToggle = var_19_0

		var_19_0(var_1_10004:Find("off"), true)

		return
	end

	_G = var_1_10004

	local var_19_3 = var_1_10004[arg_19_1.name]

	PlayerPrefs = var_5

	var_5.SetInt(var_19_3, arg_19_2 and 1 or 0)

	PlayerPrefs = var_5

	var_5.Save()

	return
end

function var_0_1.SetGrayOption(arg_20_0, arg_20_1)
	setGray = var_1_10002

	var_1_10002(arg_20_0:Find("on"), not arg_20_1)

	setGray = var_1_10002

	var_1_10002(arg_20_0:Find("off"), not arg_20_1)

	return
end

function var_0_1.OnCommonLocalItemSwitch(arg_21_0, arg_21_1, arg_21_2)
	_G = var_1_10003

	local var_21_0 = var_1_10003[arg_21_1.name]

	PlayerPrefs = var_4

	var_4.SetInt(var_21_0, arg_21_2 and 1 or 0)

	PlayerPrefs = var_4

	var_4.Save()

	return
end

function var_0_1.OnGraphApiItemSwitch(arg_22_0, arg_22_1, arg_22_2)
	local function var_22_0()
		local var_23_0 = arg_22_0.uilist.container
		local var_23_1 = var_0.GetChild(var_23_0, #arg_22_0.list - 1)

		triggerToggle = var_2_10001

		var_2_10001(var_23_1:Find("off"), true)

		GraphApiHelper = var_2_10001

		local var_23_2 = var_2_10001.SetForceGraphApi

		GraphApiHelper = var_3

		var_23_2(var_3.Api.Force_OpenGLES)

		return
	end

	local function var_22_1()
		local var_24_0 = arg_22_0.uilist.container
		local var_24_1 = var_0.GetChild(var_24_0, #arg_22_0.list - 1)

		triggerToggle = var_2_10001

		var_2_10001(var_24_1:Find("on"), true)

		GraphApiHelper = var_2_10001

		local var_24_2 = var_2_10001.SetForceGraphApi

		GraphApiHelper = var_3

		var_24_2(var_3.Api.Force_Vulkan)

		return
	end

	if arg_22_2 == false then
		GraphApiHelper = var_1_10005

		if var_1_10005.IsUsingVulkan() then
			if arg_22_2 == true then
				GraphApiHelper = var_1_10005

				if var_1_10005.IsUsingVulkan() then
					return
				end
			end

			if arg_22_2 then
				pg = var_1_10005

				local var_22_2 = var_1_10005.MsgboxMgr.GetInstance()

				var_1_10005 = var_1_10005.ShowMsgBox

				local var_22_3 = {}

				i18n = var_1_10009
				var_22_3.content = var_1_10009("graphi_api_switch_vulkan")

				function var_22_3.onYes()
					var_22_1()

					Application = var_0

					var_0.Quit()

					return
				end

				var_22_3.onNo = var_22_0

				var_1_10005(var_22_2, var_22_3)
			else
				pg = var_1_10005

				local var_22_4 = var_1_10005.MsgboxMgr.GetInstance()
				local var_22_5 = var_5.ShowMsgBox
				local var_22_6 = {}

				i18n = var_1_10009
				var_22_6.content = var_1_10009("graphi_api_switch_opengl")

				function var_22_6.onYes()
					var_22_0()

					Application = var_0

					var_0.Quit()

					return
				end

				var_22_6.onNo = var_22_1

				var_22_5(var_22_4, var_22_6)
			end

			return
		end
	end
end

function var_0_1.OnUpdateItem(arg_27_0, arg_27_1)
	if arg_27_1.id == 10 then
		local var_27_0 = arg_27_0.uilist.container
		local var_27_1 = var_2.GetChild(var_27_0, arg_27_1.id - 1)

		var_0_1.SetGrayOption(var_27_1, arg_27_0:GetDefaultValue(arg_27_0.list[9]))
	end

	return
end

function var_0_1.OnUpdateItemWithTr(arg_28_0, arg_28_1, arg_28_2)
	findTF = var_1_10003

	local var_28_0 = var_1_10003(arg_28_2, "mask/tip")

	setActive = var_1_10004

	var_1_10004(var_28_0, false)

	if arg_28_1.id == 18 then
		onButton = var_4

		local var_28_1 = arg_28_0
		local var_28_2 = var_28_0

		local function var_28_3()
			pg = var_2_10000

			local var_29_0 = var_2_10000.m02
			local var_29_1 = var_0.sendNotification

			NewSettingsMediator = var_2_10003

			var_29_1(var_29_0, var_2_10003.SHOW_DESC, arg_28_1)

			return
		end

		SFX_PANEL = var_1_10009

		var_4(var_28_1, var_28_2, var_28_3, var_1_10009)

		setActive = var_4

		var_4(var_28_0, true)
	end

	return
end

function var_0_1.GetDefaultValue(arg_30_0, arg_30_1)
	if arg_30_1.id == 1 then
		pg = var_2
		var_1_10004 = var_2.PushNotificationMgr.GetInstance()

		return var_2.isEnableShipName(var_1_10004)
	elseif arg_30_1.id == 17 then
		getProxy = var_2
		SettingsProxy = var_1_10004
		var_1_10004 = var_2(var_1_10004)

		return var_2.IsDisplayResultPainting(var_1_10004)
	elseif arg_30_1.type == 0 then
		PlayerPrefs = var_2

		local var_30_0 = var_2.GetInt

		_G = var_1_10004
		var_1_10004 = var_1_10004[arg_30_1.name]

		if not arg_30_1.default then
			var_1_10005 = 0
		end

		return var_30_0(var_1_10004, var_1_10005) > 0
	elseif arg_30_1.type == 1 then
		getProxy = var_2
		PlayerProxy = var_1_10004

		local var_30_1 = var_2(var_1_10004)
		local var_30_2 = var_2.getRawData(var_30_1)
		local var_30_3 = var_2.GetCommonFlag

		_G = var_1_10005

		local var_30_4 = var_30_3(var_30_2, var_1_10005[arg_30_1.name])

		if arg_30_1.default == 1 then
			return not var_30_4
		else
			return var_30_4
		end
	elseif arg_30_1.type == var_0_1.GRAPHI_API_SWITCH_OPTION_TYPE then
		GraphApiHelper = var_2

		return var_2.IsUsingVulkan()
	end

	return
end

function var_0_1.GetList(arg_31_0)
	local var_31_0 = {}
	local var_31_1

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_31_0, iter_31_1 in var_1_10003(var_1_10005.settings_other_template.all) do
		LOCK_BATTERY_SAVEMODE = var_1_10008

		if var_1_10008 and (iter_31_1 == 9 or iter_31_1 == 10) then
			-- block empty
		else
			LOCK_L2D_GYRO = var_1_10008

			if var_1_10008 and iter_31_1 == 15 then
				-- block empty
			else
				pg = var_1_10008

				if var_1_10008.settings_other_template[iter_31_1].type == var_0_1.GRAPHI_API_SWITCH_OPTION_TYPE then
					PermissionHelper = var_1_10008

					if var_1_10008.IsAndroid() then
						pg = var_1_10008
						var_31_1 = var_1_10008.settings_other_template[iter_31_1]
					end
				else
					table = var_1_10008
					var_1_10008 = var_1_10008.insert

					local var_31_2 = var_31_0

					pg = var_1_10011

					var_1_10008(var_31_2, var_1_10011.settings_other_template[iter_31_1])
				end
			end
		end
	end

	if var_31_1 then
		table = var_3

		var_3.insert(var_31_0, var_31_1)
	end

	return var_31_0
end

return var_0_1
