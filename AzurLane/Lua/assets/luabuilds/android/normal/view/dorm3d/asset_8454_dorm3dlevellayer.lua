class = var_0_10000

local var_0_0 = "Dorm3dLevelLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.SERVER_TYPE = 1
var_0_1.CLIENT_TYPE = 2
var_0_1.STORY_TYPE = 3
var_0_1.NAME_MIN_SIZE = 4
var_0_1.NAME_SHORT_SIZE = 8
var_0_1.NAME_LONG_SIZE = 14
var_0_1.PLAYERPREFS_KEY = "Dorm3dLayer.playerprefs"

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dLevelUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtLevelPanel = var_1.Find(var_2_0, "panel")
	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "btn_back")

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_1, var_2_3, var_2_4, var_5)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "bg")

	local function var_2_8()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_5, var_2_7, var_2_8, var_5)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.rtLevelPanel
	local var_2_11 = var_3.Find(var_2_10, "bg/bottom/btn_time")

	local function var_2_12()
		getDorm3dGameset = var_2_10000

		local var_5_0 = var_2_10000("drom3d_time_unlock")[1]

		if arg_2_0.apartment.level < var_5_0 then
			pg = var_1

			local var_5_1 = var_1.TipsMgr.GetInstance()
			local var_5_2 = var_1.ShowTips

			i18n = var_2_10003

			var_5_2(var_5_1, var_2_10003("apartment_level_unenough", var_5_0))

			return
		end

		local var_5_3 = arg_2_0

		var_1.ShowTimeSelectWindow(var_5_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_9, var_2_11, var_2_12, var_5)

	local var_2_13 = arg_2_0._tf

	arg_2_0.rtTimeSelectWindow = var_1.Find(var_2_13, "TimeSelectWindow")
	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.rtTimeSelectWindow
	local var_2_16 = var_3.Find(var_2_15, "bg")

	local function var_2_17()
		setActive = var_2_10000

		var_2_10000(arg_2_0.rtTimeSelectWindow, false)

		local var_6_0 = arg_2_0

		var_0.UnOverlayPanel(var_6_0, arg_2_0.rtTimeSelectWindow, arg_2_0._tf)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_14, var_2_16, var_2_17, var_5)

	local var_2_18 = arg_2_0._tf

	arg_2_0.rtRenameWindow = var_1.Find(var_2_18, "RenameWindow")
	onButton = var_1

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.rtLevelPanel
	local var_2_21 = var_3.Find(var_2_20, "bg/left/rot")

	local function var_2_22()
		local var_7_0 = arg_2_0

		var_0.ShowRenameWindow(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_19, var_2_21, var_2_22, var_5)

	local var_2_23 = arg_2_0.rtRenameWindow

	arg_2_0.callInput = var_1.Find(var_2_23, "panel/input/nickname")
	onButton = var_1

	local var_2_24 = arg_2_0
	local var_2_25 = arg_2_0.rtRenameWindow
	local var_2_26 = var_3.Find(var_2_25, "panel/confirm")

	local function var_2_27()
		getInputText = var_2_10000

		if var_2_10000(arg_2_0.callInput) == "" then
			return
		end

		nameValidityCheck = var_1

		if not var_1(var_0, var_0_1.NAME_MIN_SIZE, var_0_1.NAME_LONG_SIZE, {
			"spece_illegal_tip",
			"dorm3d_appellation_waring3",
			"dorm3d_appellation_waring2",
			"dorm3d_appellation_waring1"
		}) then
			setInputText = var_1

			local var_8_0 = arg_2_0.callInput
			local var_8_1 = arg_2_0.apartment

			var_1(var_8_0, var_3.GetCallName(var_8_1))

			return
		end

		local var_8_2 = arg_2_0.apartment

		if var_0 == var_1.GetCallName(var_8_2) then
			return
		end

		local var_8_3 = arg_2_0.apartment

		if var_1.GetSetCallCd(var_8_3) > 0 then
			pg = var_1

			local var_8_4 = var_1.TipsMgr.GetInstance()
			local var_8_5 = var_1.ShowTips

			i18n = var_3

			var_8_5(var_8_4, var_3("dorm3d_appellation_waring4"))

			return
		end

		if arg_2_0.renameReset then
			local var_8_6 = arg_2_0
			local var_8_7 = var_1.emit

			Dorm3dLevelMediator = var_3

			var_8_7(var_8_6, var_3.RENAME_RESET, arg_2_0.apartment.configId)
		else
			local var_8_8 = arg_2_0
			local var_8_9 = var_1.emit

			Dorm3dLevelMediator = var_3

			var_8_9(var_8_8, var_3.RENAME, arg_2_0.apartment.configId, var_0)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_24, var_2_26, var_2_27, var_5)

	onButton = var_1

	local var_2_28 = arg_2_0
	local var_2_29 = arg_2_0.rtRenameWindow
	local var_2_30 = var_3.Find(var_2_29, "panel/cancel")

	local function var_2_31()
		local var_9_0 = arg_2_0

		var_0.CloseRenameWindow(var_9_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_28, var_2_30, var_2_31, var_5)

	onButton = var_1

	local var_2_32 = arg_2_0
	local var_2_33 = arg_2_0.rtRenameWindow

	var_1(var_2_32, var_3.Find(var_2_33, "panel/reset"), function()
		setInputText = var_2_10000

		local var_10_0 = arg_2_0.callInput

		pg = var_2_10002

		var_2_10000(var_10_0, var_2_10002.dorm3d_dorm_template[arg_2_0.apartment.configId].default_appellation)

		arg_2_0.renameReset = true

		return
	end)

	local var_2_34 = arg_2_0.rtLevelPanel

	arg_2_0.nameShort = var_1.Find(var_2_34, "bg/left/rot/short")

	local var_2_35 = arg_2_0.rtLevelPanel

	arg_2_0.nameLong = var_1.Find(var_2_35, "bg/left/rot/long")

	local var_2_36 = arg_2_0._tf

	arg_2_0.blurPanel = var_1.Find(var_2_36, "blur")

	local var_2_37 = arg_2_0.callInput
	local var_2_38 = var_1.GetComponent

	typeof = var_3
	InputField = var_4

	local var_2_39 = var_2_38(var_2_37, var_3(var_4)).onValueChanged

	var_1.AddListener(var_2_39, function()
		arg_2_0.renameReset = false

		return
	end)

	setActive = var_1

	local var_2_40 = arg_2_0.rtLevelPanel

	var_1(var_2.Find(var_2_40, "bg/left/rot"), not var_0_1.IsLockNamed())
	arg_2_0:InitItemList()

	return
end

function var_0_1.SetApartment(arg_12_0, arg_12_1)
	arg_12_0.apartment = arg_12_1

	return
end

function var_0_1.InitItemList(arg_13_0)
	local var_13_0 = arg_13_0.rtLevelPanel

	arg_13_0.rtLevelContainer = var_1.Find(var_13_0, "bg/awards/content")
	UIItemList = var_1

	local var_13_1 = var_1.New
	local var_13_2 = arg_13_0.rtLevelContainer
	local var_13_3 = arg_13_0.rtLevelContainer

	arg_13_0.levelItemList = var_13_1(var_13_2, var_3.Find(var_13_3, "tpl"))

	local var_13_4 = arg_13_0.levelItemList

	var_1.make(var_13_4, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_14_1 + 1
		local var_14_1 = arg_13_0.apartment
		local var_14_2 = var_4.getFavorConfig(var_14_1, "levelup_item", var_14_0)
		local var_14_3 = arg_13_0.apartment
		local var_14_4 = var_5.getFavorConfig(var_14_3, "levelup_client_item", var_14_0)
		local var_14_5 = arg_14_2:Find("items")
		local var_14_6 = {}

		pairs = var_8

		for iter_14_0, iter_14_1 in var_8(var_14_2) do
			table = var_2_10013

			var_2_10013.insert(var_14_6, {
				type = var_0_1.SERVER_TYPE,
				data = iter_14_1
			})
		end

		local var_14_7 = false

		pairs = var_9

		for iter_14_2, iter_14_3 in var_9(var_14_4) do
			local var_14_8 = iter_14_3[1]

			Dorm3dIconHelper = var_2_10015

			if var_14_8 == var_2_10015.DORM_STORY then
				table = var_14_8

				var_14_8.insert(var_14_6, {
					type = var_0_1.STORY_TYPE,
					data = iter_14_3
				})

				var_14_7 = true
			else
				table = var_14_8

				var_14_8.insert(var_14_6, {
					type = var_0_1.CLIENT_TYPE,
					data = iter_14_3
				})
			end
		end

		UIItemList = var_9

		local var_14_9

		if arg_14_0 == var_9.EventInit then
			setActive = var_14_9

			var_14_9(arg_14_2:Find("bg/normal"), not var_14_7)

			setActive = var_14_9

			var_14_9(arg_14_2:Find("bg/special"), var_14_7)

			function var_14_9(arg_15_0)
				local var_15_0 = var_14_5
				local var_15_1 = var_1.GetChild(var_15_0, arg_15_0 - 1)
				local var_15_2 = var_1.Find(var_15_1, "item")
				local var_15_3 = var_2.Find(var_15_2, "Dorm3dIconTpl")

				if arg_15_0 <= #var_14_6 then
					switch = var_4

					var_4(var_14_6[arg_15_0].type, {
						[var_0_1.SERVER_TYPE] = function()
							setActive = var_4_10000

							local var_16_0 = var_15_3

							var_4_10000(var_1.Find(var_16_0, "count"), true)

							Drop = var_4_10000

							local var_16_1 = var_4_10000.Create(var_14_6[arg_15_0].data)

							updateCustomDrop = var_1

							var_1(var_15_3, var_16_1, {
								style = "dorm"
							})

							onButton = var_1

							local var_16_2 = arg_13_0
							local var_16_3 = var_0

							local function var_16_4()
								local var_17_0 = arg_13_0
								local var_17_1 = var_0.emit

								BaseUI = var_5_10002

								var_17_1(var_17_0, var_5_10002.ON_NEW_DROP, {
									style = "dorm",
									drop = var_16_1
								})

								return
							end

							SFX_PANEL = var_4_10005

							var_1(var_16_2, var_16_3, var_16_4, var_4_10005)

							return
						end,
						[var_0_1.CLIENT_TYPE] = function()
							setActive = var_4_10000

							local var_18_0 = var_15_3

							var_4_10000(var_1.Find(var_18_0, "count"), true)

							Dorm3dIconHelper = var_4_10000

							var_4_10000.UpdateDorm3dIcon(var_15_3, var_14_6[arg_15_0].data)

							Dorm3dIconHelper = var_0

							local var_18_1 = var_0.Data2Config(var_14_6[arg_15_0].data)

							onButton = var_1

							local var_18_2 = arg_13_0
							local var_18_3 = var_0

							local function var_18_4()
								local var_19_0 = arg_13_0
								local var_19_1 = var_0.emit

								Dorm3dLevelMediator = var_5_10002

								var_19_1(var_19_0, var_5_10002.ON_DROP_CLIENT, {
									data = var_14_6[arg_15_0].data
								})

								return
							end

							SFX_PANEL = var_4_10005

							var_1(var_18_2, var_18_3, var_18_4, var_4_10005)

							return
						end,
						[var_0_1.STORY_TYPE] = function()
							Dorm3dIconHelper = var_4_10000

							local var_20_0 = var_4_10000.Data2Config(var_14_6[arg_15_0].data)

							setActive = var_1

							local var_20_1 = var_0

							var_1(var_2.Find(var_20_1, "sp"), true)

							setActive = var_1

							local var_20_2 = var_0

							var_1(var_2.Find(var_20_2, "story"), true)

							onButton = var_1

							local var_20_3 = arg_13_0
							local var_20_4 = var_0

							local function var_20_5()
								local var_21_0 = arg_13_0
								local var_21_1 = var_0.emit

								Dorm3dLevelMediator = var_5_10002

								var_21_1(var_21_0, var_5_10002.ON_DROP_CLIENT, {
									data = var_14_6[arg_15_0].data
								})

								return
							end

							SFX_PANEL = var_4_10005

							var_1(var_20_3, var_20_4, var_20_5, var_4_10005)

							Dorm3dIconHelper = var_1

							var_1.UpdateDorm3dIcon(var_15_3, var_14_6[arg_15_0].data)

							setText = var_1

							local var_20_6 = var_0
							local var_20_7 = var_2.Find(var_20_6, "story/Text")

							i18n = var_20_6

							var_1(var_20_7, var_20_6("dorm3d_favor_level_story"))

							return
						end
					})
				else
					setActive = var_4

					var_4(var_2, false)

					setActive = var_4

					var_4(var_1:Find("empty"), true)
				end

				return
			end

			for iter_14_4 = 1, var_14_5.childCount do
				var_14_9(iter_14_4)
			end
		else
			UIItemList = var_14_9

			if arg_14_0 == var_14_9.EventUpdate then
				local var_14_10 = var_14_0 <= arg_13_0.apartment.level

				setActive = var_10

				var_10(arg_14_2:Find("unlock"), var_14_10)

				setText = var_10

				local var_14_11 = arg_14_2
				local var_14_12 = arg_14_2.Find(var_14_11, "number")

				string = var_14_11

				var_10(var_14_12, var_14_11.format("<color=%s>%02d</color>", var_14_7 and "#FFFFFF" or var_14_10 and "#b6b1b7" or "#827d82", var_14_0))

				if var_14_10 then
					setGray = var_10

					var_10(arg_14_2:Find("items"), true, true)
				end
			end
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_22_0)
	local var_22_0 = arg_22_0.apartment
	local var_22_1, var_22_2 = var_1.getFavor(var_22_0)
	local var_22_3 = arg_22_0.apartment
	local var_22_4 = var_3.isMaxFavor(var_22_3)

	setText = var_22_3

	local var_22_5 = arg_22_0.rtLevelPanel
	local var_22_6 = var_5.Find(var_22_5, "bg/favor/level")

	string = var_22_5

	var_22_3(var_22_6, var_22_5.format("Lv.%d : ", arg_22_0.apartment.level))

	if var_22_4 then
		setText = var_22_3

		local var_22_7 = arg_22_0.rtLevelPanel

		var_22_3(var_5.Find(var_22_7, "bg/favor/level/Text"), "MAX")
	else
		setText = var_22_3

		local var_22_8 = arg_22_0.rtLevelPanel
		local var_22_9 = var_5.Find(var_22_8, "bg/favor/level/Text")

		string = var_22_8

		var_22_3(var_22_9, var_22_8.format("%d/%d", var_22_1, var_22_2))
	end

	setSlider = var_22_3

	local var_22_10 = arg_22_0.rtLevelPanel

	var_22_3(var_5.Find(var_22_10, "bg/favor/progressBg/progress"), 0, var_22_2, var_22_1)

	local var_22_11 = arg_22_0.levelItemList
	local var_22_12 = var_4.align

	getDorm3dGameset = var_6

	var_22_12(var_22_11, var_6("favor_level")[1])

	local var_22_13 = arg_22_0.rtLevelContainer
	local var_22_14 = var_4.GetComponent

	typeof = var_6
	ScrollRect = var_7
	var_22_14(var_22_13, var_6(var_7)).horizontalNormalizedPosition = 0

	local var_22_15 = arg_22_0.apartment.level

	getDorm3dGameset = var_5

	local var_22_16 = var_5("drom3d_time_unlock")[1] <= var_22_15

	setImageAlpha = var_5

	local var_22_17 = arg_22_0.rtLevelPanel

	var_5(var_6.Find(var_22_17, "bg/bottom/btn_time"), not var_22_16 and 0.2 or 1)

	setActive = var_5

	local var_22_18 = arg_22_0.rtLevelPanel

	var_5(var_6.Find(var_22_18, "bg/bottom/btn_time/lock"), not var_22_16)

	setText = var_5

	local var_22_19 = arg_22_0.rtLevelPanel
	local var_22_20 = var_6.Find(var_22_19, "bg/left/rot/Text")

	i18n = var_22_19

	var_5(var_22_20, var_22_19("dorm3d_appellation_title"))

	setText = var_5

	local var_22_21 = arg_22_0.rtRenameWindow
	local var_22_22 = var_6.Find(var_22_21, "panel/cancel/Text")

	i18n = var_22_21

	var_5(var_22_22, var_22_21("word_cancel"))

	setText = var_5

	local var_22_23 = arg_22_0.rtRenameWindow
	local var_22_24 = var_6.Find(var_22_23, "panel/confirm/Text")

	i18n = var_22_23

	var_5(var_22_24, var_22_23("word_ok"))
	arg_22_0:UpdateName()
	arg_22_0:UpdateRed()

	return
end

function var_0_1.IsLockNamed()
	PLATFORM_CODE = var_1_10000
	PLATFORM_CH = var_1_10001
	var_1_10000 = var_1_10000 ~= var_1_10001 and var_1_10000

	return var_1_10000
end

function var_0_1.IsShowRed()
	if var_0_1.IsLockNamed() then
		return false
	end

	PlayerPrefs = var_0

	return var_0.GetInt(var_0_1.PLAYERPREFS_KEY, 0) == 0
end

function var_0_1.UpdateRed(arg_25_0)
	setActive = var_1_10001

	local var_25_0 = arg_25_0.rtLevelPanel

	var_1_10001(var_2.Find(var_25_0, "bg/left/rot/red"), var_0_1.IsShowRed())

	local var_25_1 = arg_25_0
	local var_25_2 = arg_25_0.emit

	Dorm3dLevelMediator = var_3

	var_25_2(var_25_1, var_3.UPDATE_FAVOR_DISPLAY)

	return
end

function var_0_1.UpdateName(arg_26_0)
	local var_26_0 = arg_26_0.apartment
	local var_26_1 = var_1.GetCallName(var_26_0)

	utf8_to_unicode = var_26_0

	local var_26_2, var_26_3 = var_26_0(var_26_1)
	local var_26_4 = var_26_3 <= var_0_1.NAME_SHORT_SIZE

	setActive = var_1_10005

	var_1_10005(arg_26_0.nameShort, var_26_4)

	setActive = var_1_10005

	var_1_10005(arg_26_0.nameLong, not var_26_4)

	setText = var_1_10005

	if var_26_4 then
		local var_26_5 = arg_26_0.nameShort
		local var_26_7

		if not var_6.Find(var_26_5, "Text") then
			local var_26_6 = arg_26_0.nameLong

			var_26_7 = var_6.Find(var_26_6, "Text")
		end

		var_1_10005(var_26_7, var_26_1)

		return
	end
end

function var_0_1.ShowRenameWindow(arg_27_0)
	setActive = var_1_10001

	local var_27_0 = arg_27_0._tf

	var_1_10001(var_2.Find(var_27_0, "bg"), false)

	setActive = var_1_10001

	local var_27_1 = arg_27_0._tf

	var_1_10001(var_2.Find(var_27_1, "btn_back"), false)

	setActive = var_1_10001

	var_1_10001(arg_27_0.rtLevelPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_27_0.rtRenameWindow, true)

	setActive = var_1_10001

	var_1_10001(arg_27_0.blurPanel, true)
	arg_27_0:OverlayPanel(arg_27_0.blurPanel, {
		groupDelta = 1,
		pbList = {
			arg_27_0.blurPanel
		}
	})
	arg_27_0:OverlayPanel(arg_27_0.rtRenameWindow, {
		groupDelta = 1
	})

	setInputText = var_1

	local var_27_2 = arg_27_0.callInput
	local var_27_3 = arg_27_0.apartment

	var_1(var_27_2, var_3.GetCallName(var_27_3))

	local var_27_4 = arg_27_0.apartment
	local var_27_5 = var_1.GetSetCallCd(var_27_4)
	local var_27_6
	local var_27_7

	if 3600 < var_27_5 then
		math = var_27_7
		var_27_7 = var_27_7.floor(var_27_5 / 16)
		i18n = var_27_3
		var_27_6 = var_27_7 .. var_27_3("word_hour")
	elseif 60 < var_27_5 then
		math = var_27_7
		var_27_7 = var_27_7.floor(var_27_5 / 60)
		i18n = var_27_3
		var_27_6 = var_27_7 .. var_27_3("word_minute")
	else
		var_27_7 = var_27_5
		i18n = var_27_3
		var_27_6 = var_27_7 .. var_27_3("word_second")
	end

	setText = var_27_7

	local var_27_8 = arg_27_0.rtRenameWindow
	local var_27_9 = var_4.Find(var_27_8, "panel/time")

	if var_27_5 == 0 then
		i18n = var_27_8

		if not var_27_8("dorm3d_appellation_interval") then
			i18n = var_27_8
			var_27_8 = var_27_8("dorm3d_appellation_cd", var_27_6)
		end

		var_27_7(var_27_9, var_27_8)

		PlayerPrefs = var_27_7

		var_27_7.SetInt(var_0_1.PLAYERPREFS_KEY, 1)
		arg_27_0:UpdateRed()

		return
	end
end

function var_0_1.CloseRenameWindow(arg_28_0)
	setActive = var_1_10001

	local var_28_0 = arg_28_0._tf

	var_1_10001(var_2.Find(var_28_0, "bg"), true)

	setActive = var_1_10001

	local var_28_1 = arg_28_0._tf

	var_1_10001(var_2.Find(var_28_1, "btn_back"), true)

	setActive = var_1_10001

	var_1_10001(arg_28_0.rtLevelPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_28_0.rtRenameWindow, false)

	setActive = var_1_10001

	var_1_10001(arg_28_0.blurPanel, false)
	arg_28_0:UnOverlayPanel(arg_28_0.blurPanel, arg_28_0._tf)
	arg_28_0:UnOverlayPanel(arg_28_0.rtRenameWindow, arg_28_0._tf)
	arg_28_0:UpdateName()

	return
end

function var_0_1.ShowTimeSelectWindow(arg_29_0)
	local var_29_0 = arg_29_0.rtTimeSelectWindow
	local var_29_1 = var_1.Find(var_29_0, "panel")

	setText = var_29_0

	local var_29_2 = var_29_1
	local var_29_3 = var_29_1.Find(var_29_2, "title")

	i18n = var_29_2

	var_29_0(var_29_3, var_29_2("dorm3d_time_choose"))

	ipairs = var_29_0

	for iter_29_0, iter_29_1 in var_29_0({
		"day",
		"night"
	}) do
		local var_29_4 = var_29_1
		local var_29_5 = var_29_1.Find(var_29_4, "content/" .. iter_29_1)

		setText = var_29_4

		local var_29_6 = var_29_5
		local var_29_7 = var_29_5.Find(var_29_6, "now/Text")

		i18n = var_29_6

		var_29_4(var_29_7, var_29_6("dorm3d_now_time"))

		setActive = var_29_4

		var_29_4(var_29_5:Find("now"), iter_29_0 == arg_29_0.contextData.timeIndex)

		onToggle = var_29_4

		local var_29_8 = arg_29_0
		local var_29_9 = var_29_5

		local function var_29_10(arg_30_0)
			if arg_30_0 == true then
				var_2_10001 = arg_29_0
				var_2_10001.selectTimeIndex = iter_29_0
			end

			quickPlayAnimation = var_2_10001

			var_2_10001(var_29_5, arg_30_0 and "anim_dorm3d_timeselect_click" or "anim_dorm3d_timeselect_unclick")

			return
		end

		SFX_PANEL = var_1_10012

		var_29_4(var_29_8, var_29_9, var_29_10, var_1_10012)
	end

	triggerToggle = var_2

	local var_29_11 = var_29_1:Find("content")

	var_2(var_3.GetChild(var_29_11, arg_29_0.contextData.timeIndex - 1), true)

	setText = var_2

	local var_29_12 = var_29_1
	local var_29_13 = var_29_1.Find(var_29_12, "bottom/toggle_lock/Text")

	i18n = var_29_12

	var_2(var_29_13, var_29_12("dorm3d_is_auto_time"))

	onToggle = var_2

	local var_29_14 = arg_29_0
	local var_29_15 = var_29_1:Find("bottom/toggle_lock")

	local function var_29_16(arg_31_0)
		if arg_31_0 then
			PlayerPrefs = var_2_10001
			var_2_10001 = var_2_10001.SetInt
			ApartmentProxy = var_2_10002

			var_2_10001(var_2_10002.GetTimePPName(arg_29_0.contextData.roomId), 0)
		else
			PlayerPrefs = var_2_10001
			var_2_10001 = var_2_10001.SetInt
			ApartmentProxy = var_2_10002

			var_2_10001(var_2_10002.GetTimePPName(arg_29_0.contextData.roomId), arg_29_0.contextData.timeIndex)
		end

		quickPlayAnimation = var_2_10001

		local var_31_0 = var_29_1

		var_2_10001(var_2.Find(var_31_0, "bottom/toggle_lock"), arg_31_0 and "anim_dorm3d_timeselect_bottom_on" or "anim_dorm3d_timeselect_bottom_off")

		return
	end

	SFX_PANEL = var_6

	var_2(var_29_14, var_29_15, var_29_16, var_6)

	triggerToggle = var_2

	local var_29_17 = var_29_1
	local var_29_18 = var_29_1.Find(var_29_17, "bottom/toggle_lock")

	PlayerPrefs = var_29_17

	local var_29_19 = var_29_17.GetInt

	ApartmentProxy = var_5

	var_2(var_29_18, var_29_19(var_5.GetTimePPName(arg_29_0.contextData.roomId), 1) == 0)

	onButton = var_2

	local var_29_20 = arg_29_0
	local var_29_21 = var_29_1:Find("bottom/btn_confirm")

	local function var_29_22()
		warning = var_2_10000

		var_2_10000(arg_29_0.contextData.timeIndex, arg_29_0.selectTimeIndex)

		pg = var_2_10000

		local var_32_0 = var_2_10000.TipsMgr.GetInstance()
		local var_32_1 = var_0.ShowTips

		i18n = var_2

		var_32_1(var_32_0, var_2("dorm3d_day_night_switching" .. arg_29_0.selectTimeIndex))

		if arg_29_0.contextData.timeIndex == arg_29_0.selectTimeIndex then
			return
		else
			PlayerPrefs = var_0

			local var_32_2 = var_0.GetInt

			ApartmentProxy = var_1

			local var_32_3

			if var_32_2(var_1.GetTimePPName(arg_29_0.contextData.roomId), 1) ~= 0 then
				PlayerPrefs = var_32_3
				var_32_3 = var_32_3.SetInt
				ApartmentProxy = var_1

				var_32_3(var_1.GetTimePPName(arg_29_0.contextData.roomId), arg_29_0.selectTimeIndex)
			end

			triggerButton = var_32_3

			local var_32_4 = arg_29_0.rtTimeSelectWindow

			var_32_3(var_1.Find(var_32_4, "bg"))

			local var_32_5 = arg_29_0
			local var_32_6 = var_0.emit

			Dorm3dLevelMediator = var_32_4

			var_32_6(var_32_5, var_32_4.CHAMGE_TIME, arg_29_0.selectTimeIndex)
		end

		return
	end

	SFX_CONFIRM = var_6

	var_2(var_29_20, var_29_21, var_29_22, var_6)

	setActive = var_2

	var_2(arg_29_0.rtTimeSelectWindow, true)
	arg_29_0:OverlayPanel(arg_29_0.rtTimeSelectWindow)

	return
end

function var_0_1.onBackPressed(arg_33_0)
	isActive = var_1_10001

	if var_1_10001(arg_33_0.rtTimeSelectWindow) then
		triggerButton = var_1

		local var_33_0 = arg_33_0.rtTimeSelectWindow

		var_1(var_2.Find(var_33_0, "bg"))
	else
		isActive = var_1

		if var_1(arg_33_0.rtRenameWindow) then
			triggerButton = var_1

			local var_33_1 = arg_33_0.rtRenameWindow

			var_1(var_2.Find(var_33_1, "panel/cancel"))
		else
			var_0_1.super.onBackPressed(arg_33_0)
		end
	end

	return
end

function var_0_1.willExit(arg_34_0)
	return
end

return var_0_1
