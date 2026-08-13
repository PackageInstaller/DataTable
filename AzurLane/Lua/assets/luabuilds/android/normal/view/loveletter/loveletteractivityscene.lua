class = var_0_10000

local var_0_0 = "LoveLetterActivityScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LoveLetterActivityUI"
end

var_0_1.optionsPath = {}

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.rtSlider
	local var_2_1 = var_2.Find(var_2_0, "Text")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("loveactivity_ui_1"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.textDailyTitle

	i18n = var_3

	var_1_10001(var_2_2, var_3("mail_boxtitle_information"))

	setText = var_1_10001

	local var_2_3 = arg_2_0.btnDaily
	local var_2_4 = var_2.Find(var_2_3, "content/Text")

	i18n = var_2_3

	var_1_10001(var_2_4, var_2_3("loveactivity_ui_2"))

	setText = var_1_10001

	local var_2_5 = arg_2_0.btnGift
	local var_2_6 = var_2.Find(var_2_5, "Text")

	i18n = var_2_5

	var_1_10001(var_2_6, var_2_5("loveactivity_ui_3"))

	setText = var_1_10001

	local var_2_7 = arg_2_0.textUITitle

	i18n = var_3

	var_1_10001(var_2_7, var_3("activity_ninjia_main_title"))

	setText = var_1_10001

	local var_2_8 = arg_2_0.btnDailyConfirm
	local var_2_9 = var_2.Find(var_2_8, "Text")

	i18n = var_2_8

	var_1_10001(var_2_9, var_2_8("mail_box_confirm"))

	onButton = var_1_10001

	local var_2_10 = arg_2_0

	findTF = var_3

	local var_2_11 = var_3(arg_2_0._tf, "adapt/TopPage/top/deco/btn_help")

	local function var_2_12()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_3_2.type = var_2_10003
		pg = var_2_10003
		var_3_2.helps = var_2_10003.gametip.loveactivity_help_tips.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_2_10, var_2_11, var_2_12, var_5)

	onButton = var_1_10001

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.btnBack

	local function var_2_15()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_2_13, var_2_14, var_2_15, var_5)

	onButton = var_1_10001

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.btnHome

	local function var_2_18()
		local var_5_0 = arg_2_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_16, var_2_17, var_2_18, var_5)

	onButton = var_1_10001

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.btnSwitch

	local function var_2_21()
		local var_6_0 = arg_2_0.activity
		local var_6_1, var_6_2 = var_0.GetChangeCount(var_6_0)

		if var_6_1 < var_6_2 then
			local var_6_3 = arg_2_0

			var_2_10002 = var_2_10002.emit
			LoveLetterActivityMediator = var_2_10004

			var_2_10002(var_6_3, var_2_10004.ON_SELECT_GROUP, arg_2_0.activity.id)
		else
			pg = var_2_10002

			local var_6_4 = var_2_10002.TipsMgr.GetInstance()
			local var_6_5 = var_2.ShowTips

			i18n = var_2_10004

			var_6_5(var_6_4, var_2_10004("common_count_noenough"))
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_19, var_2_20, var_2_21, var_5)

	onButton = var_1_10001

	local var_2_22 = arg_2_0
	local var_2_23 = arg_2_0.btnDaily
	local var_2_24 = var_3.Find(var_2_23, "content")

	local function var_2_25()
		local var_7_0 = arg_2_0

		var_0.ShowDailyPanel(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_22, var_2_24, var_2_25, var_5)

	onButton = var_1_10001

	local var_2_26 = arg_2_0
	local var_2_27 = arg_2_0.btnDailyConfirm

	local function var_2_28()
		local var_8_0 = arg_2_0.dailyActivity
		local var_8_1 = var_0.getNDay(var_8_0)

		for iter_8_0 = 1, var_8_1 do
			local var_8_2 = arg_2_0.dailyActivity

			if var_5.getConfig(var_8_2, "config_data")[iter_8_0] then
				getProxy = var_8_2
				TaskProxy = var_7

				local var_8_3 = var_8_2(var_7)
				local var_8_4

				if not var_6.getTaskVO(var_8_3, var_5) then
					var_8_4 = nil
				end

				if var_8_4 and var_8_4:getTaskStatus() == 1 then
					local var_8_5 = arg_2_0
					local var_8_6 = var_7.emit

					LoveLetterActivityMediator = var_2_10009

					var_8_6(var_8_5, var_2_10009.ON_DAILY_LOGIN_REWARD, var_5)

					return
				end
			end
		end

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_2_26, var_2_27, var_2_28, var_5)

	onButton = var_1_10001

	local var_2_29 = arg_2_0
	local var_2_30 = arg_2_0.btnDailyClose

	local function var_2_31()
		local var_9_0 = arg_2_0

		var_0.HideDailyPanel(var_9_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_2_29, var_2_30, var_2_31, var_5)

	onButton = var_1_10001

	local var_2_32 = arg_2_0
	local var_2_33 = arg_2_0.btnGift

	local function var_2_34()
		local var_10_0 = arg_2_0
		local var_10_1 = var_0.emit

		LoveLetterActivityMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.ON_GO_COLLECTION)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_32, var_2_33, var_2_34, var_5)

	return
end

function var_0_1.SetActivity(arg_11_0, arg_11_1)
	arg_11_0.activity = arg_11_1
	getProxy = var_1_10002
	LoveLetterProxy = var_1_10003

	local var_11_0 = var_1_10002(var_1_10003)
	local var_11_1 = var_2.GetGroupData
	local var_11_2 = arg_11_0.activity

	arg_11_0.ll = var_11_1(var_11_0, var_4.GetTargetGroupId(var_11_2))
	setText = var_2

	local var_11_3 = arg_11_0.rtDailyPanel
	local var_11_4 = var_3.Find(var_11_3, "panel/Text")

	string = var_11_3

	var_2(var_11_4, var_11_3.format("are you sure to add extra exp to character:%d ?", arg_11_0.ll.groupId))

	return
end

function var_0_1.SetDailyActivity(arg_12_0, arg_12_1)
	arg_12_0.dailyActivity = arg_12_1

	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.readyToAchieve(var_12_0)

	setActive = var_12_0

	local var_12_2 = arg_12_0.btnDaily

	var_12_0(var_4.Find(var_12_2, "got"), not var_12_1)

	Color = var_12_0

	local var_12_3 = var_12_0.NewHex("393939")

	var_12_3.a = 0.8
	setBlackMask = var_4

	local var_12_4 = arg_12_0.btnDaily

	var_4(var_5.Find(var_12_4, "content"), not var_12_1, {
		color = var_12_3
	})

	setActive = var_4

	local var_12_5 = arg_12_0.btnDaily

	var_4(var_5.Find(var_12_5, "pick_up"), var_12_1)

	return
end

function var_0_1.didEnter(arg_13_0)
	arg_13_0:UpdateSlider()
	arg_13_0:UpdatePainting()

	local var_13_0 = arg_13_0

	arg_13_0.UpdateLoveLetterMedal(var_13_0)

	local var_13_1 = {}

	pg = var_13_0

	local var_13_2 = var_13_0.NewStoryMgr.GetInstance()
	local var_13_3 = arg_13_0.activity
	local var_13_4 = var_3.getNDay(var_13_3)

	ipairs = var_13_3

	local var_13_5 = arg_13_0.activity

	for iter_13_0, iter_13_1 in var_13_3(var_5.GetConfigClientSetting(var_13_5, "story")) do
		if iter_13_0 <= var_13_4 and not var_13_2:IsPlayed(iter_13_1[1]) then
			table = var_9

			var_9.insert(var_13_1, function(arg_14_0)
				local var_14_0 = var_13_2

				var_1.Play(var_14_0, iter_13_1[1], arg_14_0)

				return
			end)
		end
	end

	seriesAsync = var_4

	var_4(var_13_1, function()
		local var_15_0

		if not arg_13_0.contextData.checkRalizeGift then
			var_15_0 = arg_13_0.contextData
			var_15_0.checkRalizeGift = true
			getProxy = var_15_0
			LoveLetterProxy = var_1

			local var_15_1 = var_15_0(var_1)

			if var_15_0.IsTipRealizeGift(var_15_1) then
				local var_15_2 = arg_13_0

				var_15_0 = var_15_0.emit
				LoveLetterActivityMediator = var_2_10002

				var_15_0(var_15_2, var_2_10002.ON_REALIZE_GIFT)
			end
		end

		checkFirstHelpShow = var_15_0

		var_15_0("loveactivity_help_tips")

		return
	end)

	return
end

function var_0_1.UpdateSlider(arg_16_0)
	local var_16_0 = arg_16_0.activity
	local var_16_1, var_16_2 = var_1.GetDailyProgress(var_16_0)

	setText = var_1_10003

	local var_16_3 = arg_16_0.rtSlider

	var_1_10003(var_4.Find(var_16_3, "Slider/progress"), var_16_1 .. "/" .. var_16_2)

	setSlider = var_1_10003

	local var_16_4 = arg_16_0.rtSlider

	var_1_10003(var_4.Find(var_16_4, "Slider"), 0, var_16_2, var_16_1)

	local var_16_5 = arg_16_0.ll
	local var_16_6, var_16_7 = var_3.GetDisplayExp(var_16_5)

	if var_16_7 == 0 then
		setSlider = var_5

		local var_16_8 = arg_16_0.rtNow

		var_5(var_6.Find(var_16_8, "Slider"), 0, 1, 1)
	else
		setSlider = var_5

		local var_16_9 = arg_16_0.rtNow

		var_5(var_6.Find(var_16_9, "Slider"), 0, var_16_7, var_16_6)
	end

	setText = var_5

	local var_16_10 = arg_16_0.rtNow
	local var_16_11 = var_6.Find(var_16_10, "Text")

	string = var_16_10

	local var_16_12 = var_16_10.format

	setColorStr = var_8

	var_5(var_16_11, var_16_12(var_8("%d", "#CF90A8") .. "/%d", var_16_6, var_16_7))

	return
end

function var_0_1.UpdatePainting(arg_17_0)
	local var_17_0 = arg_17_0.activity
	local var_17_1, var_17_2 = var_1.GetChangeCount(var_17_0)

	setText = var_1_10003

	local var_17_3 = arg_17_0.btnSwitch
	local var_17_4 = var_4.Find(var_17_3, "Text")

	string = var_17_3

	var_1_10003(var_17_4, var_17_3.format("%d/%d", var_17_2 - var_17_1, var_17_2))

	local var_17_5 = arg_17_0.ll
	local var_17_6 = var_3.GetPainting(var_17_5)

	if arg_17_0.paint == var_17_6 then
		return
	end

	if arg_17_0.paint then
		retPaintingPrefab = var_4

		var_4(arg_17_0.rtPainting, arg_17_0.paint)

		arg_17_0.paint = nil
	end

	arg_17_0.paint = var_17_6
	setPaintingPrefabAsync = var_4

	var_4(arg_17_0.rtPainting, arg_17_0.paint, "mainNormal")

	return
end

function var_0_1.UpdateLoveLetterMedal(arg_18_0, arg_18_1)
	setActive = var_1_10002

	local var_18_0 = arg_18_0.btnGift
	local var_18_1 = var_3.Find(var_18_0, "tip")

	getProxy = var_18_0
	LoveLetterProxy = var_5

	local var_18_2 = var_18_0(var_5)

	var_1_10002(var_18_1, var_4.IsTipRealizeGift(var_18_2))

	if not arg_18_1 then
		local var_18_3 = arg_18_0.rtNow

		arg_18_1 = var_1_10002.Find(var_18_3, "medal")
	end

	setLoveLetterMedal = var_1_10002

	local var_18_4 = arg_18_1
	local var_18_5 = arg_18_0.ll
	local var_18_6 = {}
	local var_18_7 = arg_18_0.ll
	local var_18_10

	if var_6.CanLevelUp(var_18_7) then
		local var_18_8 = arg_18_0.ll.level
		local var_18_9 = arg_18_0.ll

		var_18_10 = var_18_8 < var_7.GetMaxLevel(var_18_9)
	end

	var_18_6.showPickUp = var_18_10

	var_1_10002(var_18_4, var_18_5, var_18_6)

	onButton = var_1_10002

	local var_18_11 = arg_18_0
	local var_18_12 = arg_18_0.rtNow

	local function var_18_13()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.emit

		LoveLetterActivityMediator = var_2_10002

		var_19_1(var_19_0, var_2_10002.ON_GO_TROPHY)

		return
	end

	SFX_PANEL = var_18_10

	var_1_10002(var_18_11, var_18_12, var_18_13, var_18_10)

	return
end

function var_0_1.ShowDailyPanel(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.rtDailyPanel, true)

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.UpdateLoveLetterMedal
	local var_20_2 = arg_20_0.rtDailyNow

	var_20_1(var_20_0, var_3.Find(var_20_2, "medal"))

	local var_20_3 = arg_20_0.ll
	local var_20_4, var_20_5 = var_1.GetDisplayExp(var_20_3)

	if var_20_5 == 0 then
		setSlider = var_3

		local var_20_6 = arg_20_0.rtDailyNow

		var_3(var_4.Find(var_20_6, "Slider"), 0, 1, 1)
	else
		setSlider = var_3

		local var_20_7 = arg_20_0.rtDailyNow

		var_3(var_4.Find(var_20_7, "Slider"), 0, var_20_5, var_20_4)
	end

	setText = var_3

	local var_20_8 = arg_20_0.rtDailyNow
	local var_20_9 = var_4.Find(var_20_8, "Text")

	string = var_20_8

	local var_20_10 = var_20_8.format

	setColorStr = var_6

	var_3(var_20_9, var_20_10(var_6("%d", "#CF90A8") .. "/%d", var_20_4, var_20_5))

	local var_20_11 = arg_20_0.dailyActivity
	local var_20_12 = var_3.getNDay(var_20_11)
	local var_20_13 = 1

	for iter_20_0 = 1, var_20_12 do
		local var_20_14 = arg_20_0.dailyActivity

		if var_9.getConfig(var_20_14, "config_data")[iter_20_0] then
			getProxy = var_20_14
			TaskProxy = var_11

			local var_20_15 = var_20_14(var_11)
			local var_20_16

			if not var_10.getTaskVO(var_20_15, var_9) then
				var_20_16 = nil
			end

			if var_20_16 and var_20_16:getTaskStatus() == 1 then
				var_20_13 = iter_20_0

				break
			end
		end
	end

	setText = var_5

	local var_20_17 = arg_20_0.textDailyContent

	i18n = var_7

	local var_20_18 = "loveactivity_ui_4_" .. var_20_13
	local var_20_19 = arg_20_0.ll
	local var_20_20 = var_9.GetName(var_20_19)
	local var_20_21 = arg_20_0.dailyActivity

	var_5(var_20_17, var_7(var_20_18, var_20_20, var_10.GetConfigClientSetting(var_20_21, "exp")))
	arg_20_0:BlurPanel(arg_20_0.rtDailyPanel)

	return
end

function var_0_1.HideDailyPanel(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.rtDailyPanel, false)
	arg_21_0:UnOverlayPanel(arg_21_0.rtDailyPanel)

	return
end

function var_0_1.onBackPressed(arg_22_0)
	isActive = var_1_10001

	if var_1_10001(arg_22_0.rtDailyPanel) then
		arg_22_0:HideDailyPanel()
	else
		var_0_1.super.onBackPressed(arg_22_0)
	end

	return
end

function var_0_1.willExit(arg_23_0)
	if arg_23_0.paint then
		retPaintingPrefab = var_1

		var_1(arg_23_0.rtPainting, arg_23_0.paint)

		arg_23_0.paint = nil
	end

	local var_23_0 = arg_23_0.rtNow

	if var_1.Find(var_23_0, "medal").childCount > 0 then
		eachChild = var_1

		local var_23_1 = arg_23_0.rtNow

		var_1(var_2.Find(var_23_1, "medal"), function(arg_24_0, arg_24_1)
			returnLoveLetterMedal = var_2_10002

			var_2_10002(arg_24_0)

			return
		end)
	end

	return
end

return var_0_1
