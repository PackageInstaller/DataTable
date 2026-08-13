class = var_0_10000

local var_0_0 = "TechnologyScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.PageBase = 1
var_0_1.PageQueue = 2
var_0_1.rarityColor = {
	["1"] = {
		"#4B7BC6FF",
		{
			0.06274509803921569,
			0.29411764705882354,
			0.8745098039215686,
			0.6705882352941176
		}
	},
	["2"] = {
		"#776AB0FF",
		{
			0.29411764705882354,
			0.23529411764705882,
			0.5764705882352941,
			0.6705882352941176
		}
	},
	["3"] = {
		"#B76642FF",
		{
			0.7490196078431373,
			0.28627450980392155,
			0.06274509803921569,
			0.6705882352941176
		}
	},
	["4"] = {
		"#368B78FF",
		{
			0.12941176470588237,
			0.4980392156862745,
			0.5019607843137255,
			0.6705882352941176
		}
	}
}

function var_0_1.getUIName(arg_1_0)
	return "TechnologyUI"
end

function var_0_1.onBackPressed(arg_2_0)
	if arg_2_0.contextData.selectedIndex then
		arg_2_0:cancelSelected()

		return
	end

	if arg_2_0.contextData.page == var_0_1.PageQueue then
		arg_2_0:setPage(var_0_1.PageBase)

		return
	end

	var_0_1.super.onBackPressed(arg_2_0)

	return
end

function var_0_1.ResUISettings(arg_3_0)
	return true
end

function var_0_1.setTechnologys(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.technologyVOs = arg_4_1
	arg_4_0.technologyQueue = arg_4_2

	return
end

function var_0_1.setRefreshFlag(arg_5_0, arg_5_1)
	arg_5_0.flag = arg_5_1

	return
end

function var_0_1.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.backBtn = var_1.Find(var_7_0, "blur_panel/adapt/top/back")

	local var_7_1 = arg_7_0._tf

	arg_7_0.basePage = var_1.Find(var_7_1, "main/base_page")

	local var_7_2 = arg_7_0.basePage

	arg_7_0.srcollView = var_1.Find(var_7_2, "srcoll_rect/content")

	local var_7_3 = arg_7_0.srcollView
	local var_7_4 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_7_0.srcollViewCG = var_7_4(var_7_3, var_4(var_1_10006))

	local var_7_5 = arg_7_0.basePage

	arg_7_0.helpBtn = var_1.Find(var_7_5, "help_btn")

	local var_7_6 = arg_7_0.basePage

	arg_7_0.refreshBtn = var_1.Find(var_7_6, "refresh_btn")
	setText = var_1

	local var_7_7 = arg_7_0.refreshBtn
	local var_7_8 = var_3.Find(var_7_7, "Text")

	i18n = var_4

	var_1(var_7_8, var_4("technology_daily_refresh"))

	local var_7_9 = arg_7_0.basePage

	arg_7_0.settingsBtn = var_1.Find(var_7_9, "settings_btn")

	local var_7_10 = arg_7_0.basePage

	arg_7_0.selectetPanel = var_1.Find(var_7_10, "selecte_panel")
	setActive = var_1

	var_1(arg_7_0.selectetPanel, false)

	setText = var_1

	local var_7_11 = arg_7_0.selectetPanel
	local var_7_12 = var_3.Find(var_7_11, "consume_panel/bg/label/Text")

	i18n = var_4

	var_1(var_7_12, var_4("technology_consume"))

	setText = var_1

	local var_7_13 = arg_7_0.selectetPanel
	local var_7_14 = var_3.Find(var_7_13, "consume_panel/bg/task_panel/label/Text")

	i18n = var_4

	var_1(var_7_14, var_4("technology_request"))

	local var_7_15 = arg_7_0.selectetPanel

	arg_7_0.arrLeftBtn = var_1.Find(var_7_15, "left_arr_btn")

	local var_7_16 = arg_7_0.selectetPanel

	arg_7_0.arrRightBtn = var_1.Find(var_7_16, "right_arr_btn")

	local var_7_17 = arg_7_0.selectetPanel

	arg_7_0.technologyTpl = var_1.Find(var_7_17, "technology_card")

	local var_7_18 = arg_7_0.selectetPanel
	local var_7_19 = var_1.Find(var_7_18, "desc/bg/Text")
	local var_7_20 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_7_0.descTxt = var_7_20(var_7_19, var_4(var_6))

	local var_7_21 = arg_7_0.selectetPanel
	local var_7_22 = var_1.Find(var_7_21, "timer/bg/Text")
	local var_7_23 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_7_0.timerTxt = var_7_23(var_7_22, var_4(var_6))

	local var_7_24 = arg_7_0.selectetPanel

	arg_7_0.itemContainer = var_1.Find(var_7_24, "consume_panel/bg/container")

	local var_7_25 = arg_7_0.itemContainer

	arg_7_0.itemTpl = var_1.Find(var_7_25, "item_tpl")

	local var_7_26 = arg_7_0.selectetPanel

	arg_7_0.emptyTF = var_1.Find(var_7_26, "consume_panel/bg/empty")

	local var_7_27 = arg_7_0.selectetPanel

	arg_7_0.taskPanel = var_1.Find(var_7_27, "consume_panel/bg/task_panel")

	local var_7_28 = arg_7_0.taskPanel
	local var_7_29 = var_1.Find(var_7_28, "slider")
	local var_7_30 = var_1.GetComponent

	typeof = var_4
	Slider = var_6
	arg_7_0.taskSlider = var_7_30(var_7_29, var_4(var_6))

	local var_7_31 = arg_7_0.taskPanel
	local var_7_32 = var_1.Find(var_7_31, "slider/Text")
	local var_7_33 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_7_0.taskDesc = var_7_33(var_7_32, var_4(var_6))

	local var_7_34 = arg_7_0.selectetPanel
	local var_7_35 = var_1.Find(var_7_34, "desc/bg")
	local var_7_36 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	arg_7_0.descBG = var_7_36(var_7_35, var_4(var_6))

	local var_7_37 = arg_7_0._tf

	arg_7_0.queuePage = var_1.Find(var_7_37, "main/queue_page")

	local var_7_38 = arg_7_0.queuePage

	arg_7_0.queueView = var_1.Find(var_7_38, "queue_rect/content")

	local var_7_39 = arg_7_0._tf
	local var_7_40 = var_1.Find(var_7_39, "blur_panel/adapt/right")

	arg_7_0.btnAwardQueue = var_1.Find(var_7_40, "btn_award")
	setText = var_2

	local var_7_41 = arg_7_0.btnAwardQueue
	local var_7_42 = var_4.Find(var_7_41, "Text")

	i18n = var_5

	var_2(var_7_42, var_5("technology_queue_getaward"))

	arg_7_0.btnAwardQueueDisable = var_1:Find("btn_award_disable")
	setText = var_2

	local var_7_43 = arg_7_0.btnAwardQueueDisable
	local var_7_44 = var_4.Find(var_7_43, "Text")

	i18n = var_5

	var_2(var_7_44, var_5("technology_queue_getaward"))

	local var_7_45 = arg_7_0._tf

	arg_7_0.btnQueue = var_2.Find(var_7_45, "blur_panel/adapt/left/btn_queue")
	arg_7_0.cardtimer = {}
	arg_7_0.queueTimer = {}
	arg_7_0.queueCardTimer = {}

	return
end

function var_0_1.updateSettingsBtn(arg_8_0)
	local var_8_0 = arg_8_0.settingsBtn
	local var_8_1 = var_1.Find(var_8_0, "RedPoint")
	local var_8_2 = arg_8_0.settingsBtn
	local var_8_3

	var_8_3, setText = var_2.Find(var_8_2, "TipText"), var_8_0
	i18n = var_1_10006

	var_8_0(var_8_3, var_1_10006("tec_settings_btn_word"))

	local var_8_4 = arg_8_0.settingsBtn
	local var_8_5 = var_3.Find(var_8_4, "TargetCatchup")
	local var_8_6 = var_3.Find(var_8_5, "Selected")
	local var_8_7 = arg_8_0.settingsBtn
	local var_8_8 = var_5.Find(var_8_7, "ActCatchup")
	local var_8_9 = arg_8_0

	arg_8_0.updateSettingBtnVersion(var_8_9)

	local var_8_10 = false

	getProxy = var_8_7
	ActivityProxy = var_1_10009

	local var_8_11 = var_8_7(var_1_10009)
	local var_8_12 = var_7.getActivityByType

	ActivityConst = var_1_10010

	if var_8_12(var_8_11, var_1_10010.ACTIVITY_TYPE_BLUEPRINT_CATCHUP) then
		local var_8_13 = var_7

		if not var_7.isEnd(var_8_13) then
			var_8_9 = var_7.data1

			local var_8_14 = var_7
			local var_8_15 = var_7.getConfig(var_8_14, "config_id")

			pg = var_8_13

			local var_8_16 = var_8_13.activity_event_blueprint_catchup[var_8_15].char_choice

			pg = var_8_14

			if var_8_9 < var_8_14.activity_event_blueprint_catchup[var_8_15].obtain_max then
				local var_8_17 = var_8_8
				local var_8_18

				var_8_18, setImageSprite = var_8_8.Find(var_8_17, "Selected/CharImg"), var_1_10013
				LoadSprite = var_1_10016

				local var_8_19 = "TecCatchup/QChar" .. var_8_16

				tostring = var_19

				var_1_10013(var_8_18, var_1_10016(var_8_19, var_19(var_8_16)))

				local var_8_20 = var_8_8
				local var_8_21 = var_8_8.Find(var_8_20, "Selected/ProgressText")

				setText = var_8_17

				var_8_17(var_8_21, var_8_9 .. "/" .. var_11)

				local var_8_22 = var_7.stopTime

				pg = var_8_20

				local var_8_23 = var_8_20.TimeMgr.GetInstance()
				local var_8_24 = var_8_22 - var_15.GetServerTime(var_8_23)

				if arg_8_0.actCatchupTimer then
					local var_8_25 = arg_8_0.actCatchupTimer

					var_15.Stop(var_8_25)

					arg_8_0.actCatchupTimer = nil
				end

				local var_8_26 = var_8_8:Find("TimeLeft/Day")
				local var_8_27 = var_8_8:Find("TimeLeft/Hour")
				local var_8_28 = var_8_8:Find("TimeLeft/Min")

				var_1_10020 = var_8_8

				local var_8_29 = var_8_8.Find(var_1_10020, "TimeLeft/NumText")

				local function var_8_30()
					pg = var_2_10000

					local var_9_0 = var_2_10000.TimeMgr.GetInstance()
					local var_9_1, var_9_2, var_9_3, var_9_4 = var_0.parseTimeFrom(var_9_0, var_8_24)

					var_8_24 = var_8_24 - 1

					if 1 <= var_9_1 then
						setActive = var_4

						var_4(var_8_26, true)

						setActive = var_4

						var_4(var_8_27, false)

						setActive = var_4

						var_4(var_8_28, false)

						setText = var_4

						var_4(var_8_29, var_9_1)
					elseif var_9_1 <= 0 and 0 < var_9_2 then
						setActive = var_4

						var_4(var_8_26, false)

						setActive = var_4

						var_4(var_8_27, true)

						setActive = var_4

						var_4(var_8_28, false)

						setText = var_4

						var_4(var_8_29, var_9_2)
					elseif var_9_1 <= 0 and var_9_2 <= 0 and (0 < var_9_3 or 0 < var_9_4) then
						setActive = var_4

						var_4(var_8_26, false)

						setActive = var_4

						var_4(var_8_27, false)

						setActive = var_4

						var_4(var_8_28, true)

						setText = var_4

						local var_9_5 = var_8_29

						math = var_7

						var_4(var_9_5, var_7.max(var_9_3, 1))
					elseif var_9_1 <= 0 and var_9_2 <= 0 and var_9_3 <= 0 and var_9_4 <= 0 and arg_8_0.actCatchupTimer then
						local var_9_6 = arg_8_0.actCatchupTimer

						var_4.Stop(var_9_6)

						local var_9_7 = arg_8_0

						var_9_7.actCatchupTimer = nil
						setActive = var_9_7

						var_9_7(var_8_8, false)
					end

					return
				end

				Timer = var_1_10020
				arg_8_0.actCatchupTimer = var_1_10020.New(var_8_30, 1, -1, 1)

				local var_8_31 = arg_8_0.actCatchupTimer

				var_1_10020.Start(var_8_31)
				arg_8_0.actCatchupTimer.func()

				var_8_10 = true
			end
		end
	end

	setActive = var_8_9

	var_8_9(var_8_8, var_8_10)

	setActive = var_8_9

	var_8_9(var_3, true)

	getProxy = var_8_9
	TechnologyProxy = var_10

	local var_8_32 = var_8_9(var_10)
	local var_8_33 = var_8.isOpenTargetCatchup(var_8_32)
	local var_8_34 = var_8:isOnCatchup()

	if var_8_33 then
		if not var_8_34 then
			setActive = var_8_32

			var_8_32(var_8_6, false)

			setActive = var_8_32

			var_8_32(var_8_1, true)

			goto label_8_0
		end

		local var_8_35 = var_8:getCurCatchupTecInfo().tecID
		local var_8_36 = var_8_32.groupID
		local var_8_37 = var_8_32.printNum
		local var_8_38 = var_8
		local var_8_39 = var_8.getCatchupData(var_8_38, var_8_35)

		if var_15.isUr(var_8_39, var_8_36) then
			pg = var_8_38

			if not var_8_38.technology_catchup_template[var_8_35].obtain_max_per_ur then
				pg = var_8_38
				var_8_38 = var_8_38.technology_catchup_template[var_8_35].obtain_max
			end

			if var_8_38 <= var_8_37 then
				setActive = var_19

				var_19(var_8_6, false)

				setActive = var_19

				var_19(var_8_1, false)
			else
				setActive = var_19

				var_19(var_8_6, true)

				setActive = var_19

				var_19(var_8_1, false)

				local var_8_40 = var_8_6
				local var_8_41

				var_8_41, setImageSprite = var_8_6.Find(var_8_40, "CharImg"), var_1_10020
				LoadSprite = var_1_10023

				local var_8_42 = "TecCatchup/QChar" .. var_8_36

				tostring = var_26

				var_1_10020(var_8_41, var_1_10023(var_8_42, var_26(var_8_36)))

				local var_8_43 = var_8_6:Find("ProgressText")

				setText = var_8_40

				var_8_40(var_8_43, var_8_37 .. "/" .. var_8_38)
			end

			if false then
				setActive = var_8_32

				var_8_32(var_8_6, false)

				setActive = var_8_32

				var_8_32(var_8_1, false)
			end

			::label_8_0::

			return
		end
	end
end

function var_0_1.updateSettingBtnVersion(arg_10_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)
	local var_10_1 = var_1.getTendency(var_10_0, 2)
	local var_10_2 = arg_10_0.settingsBtn
	local var_10_3 = var_2.Find(var_10_2, "tag")

	setActive = var_10_0

	var_10_0(var_10_3, var_10_1 > 0)

	if 0 < var_10_1 then
		GetImageSpriteFromAtlasAsync = var_3

		var_3("technologycard", "version_" .. var_10_1, var_10_3:Find("Image"), true)
	end

	return
end

function var_0_1.setPage(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.contextData

	var_11_0.page = arg_11_1
	setActive = var_11_0

	var_11_0(arg_11_0.basePage, arg_11_1 == var_0_1.PageBase)

	setActive = var_11_0

	var_11_0(arg_11_0.queuePage, arg_11_1 == var_0_1.PageQueue)

	setActive = var_11_0

	local var_11_1 = arg_11_0._tf

	var_11_0(var_4.Find(var_11_1, "blur_panel/adapt/top/title"), arg_11_1 == var_0_1.PageBase)

	setActive = var_11_0

	local var_11_2 = arg_11_0._tf

	var_11_0(var_4.Find(var_11_2, "blur_panel/adapt/left"), arg_11_1 == var_0_1.PageBase)

	setActive = var_11_0

	local var_11_3 = arg_11_0._tf

	var_11_0(var_4.Find(var_11_3, "blur_panel/adapt/top/title_queue"), arg_11_1 == var_0_1.PageQueue)

	setActive = var_11_0

	local var_11_4 = arg_11_0._tf

	var_11_0(var_4.Find(var_11_4, "blur_panel/adapt/right"), arg_11_1 == var_0_1.PageQueue)

	if arg_11_1 == var_0_1.PageBase then
		ipairs = var_2

		for iter_11_0, iter_11_1 in var_2(arg_11_0.technologyVOs) do
			if iter_11_1:isActivate() then
				if arg_11_0.enhancelTimer then
					local var_11_5 = arg_11_0.enhancelTimer

					var_7.Stop(var_11_5)
				end

				Timer = var_7
				arg_11_0.enhancelTimer = var_7.New(function()
					local var_12_0 = arg_11_0.srcollView
					local var_12_1 = var_0.GetComponent(var_12_0, "EnhancelScrollView")
					local var_12_2 = var_0.SetHorizontalTargetItemIndex
					local var_12_3 = arg_11_0.technologyCards[iter_11_0]

					var_12_2(var_12_1, var_3.GetComponent(var_12_3, "EnhanceItem").scrollViewItemIndex)

					arg_11_0.enhancelTimer = nil

					return
				end, 0.35, 1)

				local var_11_6 = arg_11_0.enhancelTimer

				var_7.Start(var_11_6)

				break
			end
		end
	end

	return
end

function var_0_1.didEnter(arg_13_0)
	arg_13_0:initTechnologys()
	arg_13_0:initQueue()

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.setPage
	local var_13_2

	if not arg_13_0.contextData.page then
		var_13_2 = var_0_1.PageBase
	end

	var_13_1(var_13_0, var_13_2)

	onButton = var_13_1

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.helpBtn

	local function var_13_5()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_14_2.type = var_2_10004
		pg = var_2_10004
		var_14_2.helps = var_2_10004.gametip.technology_help_text.tip

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_13_1(var_13_3, var_13_4, var_13_5, var_1_10006)

	onButton = var_13_1

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.refreshBtn

	local function var_13_8()
		tobool = var_2_10000
		getProxy = var_2_10002
		TechnologyProxy = var_2_10004

		local var_15_0 = var_2_10002(var_2_10004)
		local var_15_2

		if var_2_10000(var_2.getActivateTechnology(var_15_0)) then
			pg = var_15_2

			local var_15_1 = var_15_2.MsgboxMgr.GetInstance()

			var_15_2 = var_15_2.ShowMsgBox

			local var_15_3 = {}

			i18n = var_15_0
			var_15_3.content = var_15_0("technology_canot_refresh")

			var_15_2(var_15_1, var_15_3)

			return
		end

		pg = var_15_2

		local var_15_4 = var_15_2.MsgboxMgr.GetInstance()
		local var_15_5 = var_0.ShowMsgBox
		local var_15_6 = {}

		i18n = var_15_0
		var_15_6.content = var_15_0("technology_refresh_tip")

		function var_15_6.onYes()
			local var_16_0 = arg_13_0
			local var_16_1 = var_0.emit

			TechnologyMediator = var_3_10003

			var_16_1(var_16_0, var_3_10003.ON_REFRESH)

			return
		end

		var_15_5(var_15_4, var_15_6)

		return
	end

	SFX_PANEL = var_1_10006

	var_13_1(var_13_6, var_13_7, var_13_8, var_1_10006)

	getProxy = var_13_1
	TechnologyProxy = var_13_6

	local var_13_9 = var_13_1(var_13_6)
	local var_13_10 = var_1.getConfigMaxVersion(var_13_9)

	onButton = var_1_10002

	local var_13_11 = arg_13_0
	local var_13_12 = arg_13_0.settingsBtn

	local function var_13_13()
		local var_17_0 = arg_13_0
		local var_17_1 = var_0.emit

		TechnologyMediator = var_2_10003

		var_17_1(var_17_0, var_2_10003.ON_CLICK_SETTINGS_BTN)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_13_11, var_13_12, var_13_13, var_1_10007)

	onButton = var_1_10002

	local var_13_14 = arg_13_0
	local var_13_15 = arg_13_0.backBtn

	local function var_13_16()
		local var_18_0 = arg_13_0

		var_0.onBackPressed(var_18_0)

		return
	end

	SOUND_BACK = var_1_10007

	var_1_10002(var_13_14, var_13_15, var_13_16, var_1_10007)

	onButton = var_1_10002

	local var_13_17 = arg_13_0
	local var_13_18 = arg_13_0.selectetPanel

	local function var_13_19()
		local var_19_0 = arg_13_0

		var_0.cancelSelected(var_19_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_13_17, var_13_18, var_13_19, var_1_10007)
	arg_13_0:updateRefreshBtn(arg_13_0.flag)
	arg_13_0:updateSettingsBtn()

	return
end

function var_0_1.initTechnologys(arg_20_0)
	arg_20_0.technologyCards = {}

	local var_20_0

	if not arg_20_0.lastButtonListener then
		var_20_0 = {}
	end

	arg_20_0.lastButtonListener = var_20_0

	if not arg_20_0.itemList then
		UIItemList = var_1

		local var_20_1 = var_1.New
		local var_20_2 = arg_20_0.srcollView
		local var_20_3 = arg_20_0.srcollView

		arg_20_0.itemList = var_20_1(var_20_2, var_4.GetChild(var_20_3, 0))

		local var_20_4 = arg_20_0.itemList

		var_1.make(var_20_4, function(arg_21_0, arg_21_1, arg_21_2)
			arg_21_1 = arg_21_1 + 1
			UIItemList = var_2_10003

			if arg_21_0 == var_2_10003.EventUpdate then
				arg_21_2.name = arg_21_1
				arg_20_0.technologyCards[arg_21_1] = arg_21_2

				local var_21_0 = arg_20_0

				var_3.updateTechnologyTF(var_21_0, arg_21_2, arg_21_1, "base")

				GetOrAddComponent = var_3

				local var_21_1 = arg_21_2

				typeof = var_6
				Button = var_8

				local var_21_2 = var_3(var_21_1, var_6(var_8)).onClick

				if arg_20_0.lastButtonListener[arg_21_2] then
					var_21_2:RemoveListener(arg_20_0.lastButtonListener[arg_21_2])
				end

				arg_20_0.lastButtonListener[arg_21_2] = function()
					pg = var_3_10000

					local var_22_0 = var_3_10000.CriMgr.GetInstance()
					local var_22_1 = var_0.PlaySoundEffect_V3

					SFX_PANEL = var_3_10003

					var_22_1(var_22_0, var_3_10003)

					local var_22_2 = arg_20_0.technologyVOs[arg_21_1]

					if var_0.isCompleted(var_22_2) then
						local var_22_3 = arg_20_0
						local var_22_4 = var_0.emit

						TechnologyMediator = var_3_10003

						var_22_4(var_22_3, var_3_10003.ON_FINISHED, {
							id = arg_20_0.technologyVOs[arg_21_1].id,
							pool_id = arg_20_0.technologyVOs[arg_21_1].poolId
						})
					else
						local var_22_5 = arg_20_0

						var_0.onSelected(var_22_5, arg_21_2, arg_21_1)
					end

					return
				end

				var_21_2:AddListener(arg_20_0.lastButtonListener[arg_21_2])
			end

			return
		end)
	end

	local var_20_5 = arg_20_0.itemList

	var_1.align(var_20_5, #arg_20_0.technologyVOs)

	setActive = var_1

	var_1(arg_20_0.srcollView, true)

	return
end

function var_0_1.initQueue(arg_23_0)
	if not arg_23_0.queueItemList then
		UIItemList = var_1

		local var_23_0 = var_1.New
		local var_23_1 = arg_23_0.btnQueue

		var_1_10006 = arg_23_0.btnQueue
		arg_23_0.queueItemList = var_23_0(var_23_1, var_1_10004.GetChild(var_1_10006, 0))

		local var_23_2 = arg_23_0.queueItemList

		var_1.make(var_23_2, function(arg_24_0, arg_24_1, arg_24_2)
			arg_24_1 = arg_24_1 + 1
			UIItemList = var_2_10003

			if arg_24_0 == var_2_10003.EventUpdate then
				arg_24_2.name = arg_24_1

				if arg_23_0.queueTimer[arg_24_1] then
					var_2_10005 = arg_23_0.queueTimer[arg_24_1]

					var_3.Stop(var_2_10005)

					arg_23_0.queueTimer[arg_24_1] = nil
				end

				local var_24_0 = {}

				if not arg_23_0.technologyQueue[arg_24_1] then
					var_24_0.empty = true
				else
					pg = var_2_10005

					local var_24_1 = var_2_10005.TimeMgr.GetInstance()

					var_2_10005 = var_2_10005.GetServerTime(var_24_1)

					local var_24_2 = var_4.time
					local var_24_3 = var_4

					if var_2_10005 < var_24_2 - var_4.getConfig(var_24_3, "time") then
						var_24_0.waiting = true
					elseif var_2_10005 < var_24_2 then
						var_24_0.doing = true

						local var_24_4 = arg_23_0.queueTimer

						Timer = var_24_3
						var_24_4[arg_24_1] = var_24_3.New(function()
							pg = var_3_10000

							local var_25_0 = var_3_10000.TimeMgr.GetInstance()

							if var_0.GetServerTime(var_25_0) < var_24_2 then
								setSlider = var_1

								local var_25_1 = arg_24_2

								var_1(var_3.Find(var_25_1, "doing"), 0, var_0, var_0 - var_24_2 + var_0)
							else
								local var_25_2 = arg_23_0

								var_1.updateQueueChange(var_25_2)
							end

							return
						end, 1, -1)

						local var_24_5 = arg_23_0.queueTimer[arg_24_1]

						var_8.Start(var_24_5)
						arg_23_0.queueTimer[arg_24_1].func()
					else
						var_24_0.complete = true
					end
				end

				eachChild = var_2_10005

				var_2_10005(arg_24_2, function(arg_26_0)
					setActive = var_3_10001

					var_3_10001(arg_26_0, var_24_0[arg_26_0.name])

					return
				end)
			end

			return
		end)
	end

	local var_23_3 = arg_23_0.queueItemList
	local var_23_4 = var_1.align

	TechnologyConst = var_1_10004

	var_23_4(var_23_3, var_1_10004.QUEUE_TOTAL_COUNT)

	onButton = var_23_4

	local var_23_5 = arg_23_0
	local var_23_6 = arg_23_0.btnQueue

	local function var_23_7()
		local var_27_0 = arg_23_0

		var_0.setPage(var_27_0, var_0_1.PageQueue)

		return
	end

	SFX_PANEL = var_1_10006

	var_23_4(var_23_5, var_23_6, var_23_7, var_1_10006)

	if not arg_23_0.queueCardItemList then
		UIItemList = var_1

		local var_23_8 = var_1.New
		local var_23_9 = arg_23_0.queueView

		var_1_10006 = arg_23_0.queueView
		arg_23_0.queueCardItemList = var_23_8(var_23_9, var_23_6.GetChild(var_1_10006, 0))

		local var_23_10 = arg_23_0.queueCardItemList

		var_1.make(var_23_10, function(arg_28_0, arg_28_1, arg_28_2)
			arg_28_1 = arg_28_1 + 1
			UIItemList = var_2_10003

			if arg_28_0 == var_2_10003.EventUpdate then
				arg_28_2.name = arg_28_1

				local var_28_0 = arg_23_0

				var_3.updateTechnologyTF(var_28_0, arg_28_2, arg_28_1, "queue")
			end

			return
		end)
	end

	local var_23_11 = arg_23_0.queueCardItemList
	local var_23_12 = var_1.align

	TechnologyConst = var_23_6

	var_23_12(var_23_11, var_23_6.QUEUE_TOTAL_COUNT)

	onButton = var_23_12

	local var_23_13 = arg_23_0
	local var_23_14 = arg_23_0.btnAwardQueue

	local function var_23_15()
		if arg_23_0.technologyQueue[1] then
			local var_29_0 = arg_23_0.technologyQueue[1]

			if var_0.isCompleted(var_29_0) then
				local var_29_1 = arg_23_0
				local var_29_2 = var_0.emit

				TechnologyMediator = var_2_10003

				var_29_2(var_29_1, var_2_10003.ON_FINISH_QUEUE)
			end
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_23_12(var_23_13, var_23_14, var_23_15, var_1_10006)

	setActive = var_23_12

	local var_23_16 = arg_23_0.btnAwardQueue
	local var_23_18

	if arg_23_0.technologyQueue[1] then
		local var_23_17 = arg_23_0.technologyQueue[1]

		var_23_18 = var_4.isCompleted(var_23_17)
	end

	var_23_12(var_23_16, var_23_18)

	setActive = var_23_12

	local var_23_19 = arg_23_0.btnAwardQueueDisable

	isActive = var_23_18

	var_23_12(var_23_19, not var_23_18(arg_23_0.btnAwardQueue))

	return
end

function var_0_1.updateRefreshBtn(arg_30_0, arg_30_1)
	setButtonEnabled = var_1_10002

	var_1_10002(arg_30_0.refreshBtn, arg_30_1 == 0)

	return
end

function var_0_1.onSelected(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_2 then
		return
	end

	if not arg_31_0.technologyVOs[arg_31_2] then
		return
	end

	arg_31_0.contextData.selectedIndex = arg_31_2

	arg_31_0:updateTechnologyTF(arg_31_0.technologyTpl, arg_31_2, "desc")

	local var_31_0 = arg_31_0.srcollViewCG

	var_31_0.alpha = 0.3
	setActive = var_31_0

	var_31_0(arg_31_1, false)

	setActive = var_31_0

	var_31_0(arg_31_0.selectetPanel, true)

	local var_31_1 = {}

	eachChild = var_4

	var_4(arg_31_0.srcollView, function(arg_32_0)
		local var_32_0 = var_31_1

		tonumber = var_2_10002
		var_32_0[var_2_10002(arg_32_0.name)] = arg_32_0

		return
	end)

	local function var_31_2(arg_33_0, arg_33_1)
		local var_33_0 = {}
		local var_33_1 = arg_33_0
		local var_33_2 = var_31_1[arg_33_0].localPosition.x

		ipairs = var_2_10005

		for iter_33_0, iter_33_1 in var_2_10005(var_31_1) do
			var_33_0[iter_33_0] = var_31_1[iter_33_0].localPosition.x - var_33_2
		end

		ipairs = var_5

		for iter_33_2, iter_33_3 in var_5(var_33_0) do
			if iter_33_3 ~= 0 and (var_33_0[var_33_1] == 0 or arg_33_1 and (iter_33_3 > 0 and var_33_0[var_33_1] > 0 and iter_33_3 > var_33_0[var_33_1] or iter_33_3 < 0 and (var_33_0[var_33_1] > 0 or iter_33_3 > var_33_0[var_33_1])) or not arg_33_1 and (iter_33_3 < 0 and var_33_0[var_33_1] < 0 and iter_33_3 < var_33_0[var_33_1] or iter_33_3 > 0 and (var_33_0[var_33_1] < 0 or iter_33_3 < var_33_0[var_33_1]))) then
				var_33_1 = iter_33_2
			end
		end

		return var_31_1[var_33_1]
	end

	onButton = var_5

	local var_31_3 = arg_31_0
	local var_31_4 = arg_31_0.arrLeftBtn

	local function var_31_5()
		if arg_31_0.inAnim then
			return
		end

		local var_34_0 = arg_31_0

		var_0.cancelSelected(var_34_0)

		triggerButton = var_0

		var_0(var_31_2(arg_31_2, true))

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_31_3, var_31_4, var_31_5, var_1_10010)

	onButton = var_5

	local var_31_6 = arg_31_0
	local var_31_7 = arg_31_0.arrRightBtn

	local function var_31_8()
		if arg_31_0.inAnim then
			return
		end

		local var_35_0 = arg_31_0

		var_0.cancelSelected(var_35_0)

		triggerButton = var_0

		var_0(var_31_2(arg_31_2, false))

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_31_6, var_31_7, var_31_8, var_1_10010)

	return
end

function var_0_1.cancelSelected(arg_36_0)
	local var_36_0 = arg_36_0.technologyVOs
	local var_36_1

	if not arg_36_0.contextData.selectedIndex then
		var_36_1 = 0
	end

	if not var_36_0[var_36_1] then
		return
	end

	local var_36_2 = arg_36_0.technologyCards[arg_36_0.contextData.selectedIndex]
	local var_36_3 = arg_36_0.contextData

	var_36_3.selectedIndex = nil
	setActive = var_36_3

	var_36_3(var_36_2, true)

	removeOnButton = var_36_3

	var_36_3(arg_36_0.arrLeftBtn)

	removeOnButton = var_36_3

	var_36_3(arg_36_0.arrRightBtn)

	setActive = var_36_3

	var_36_3(arg_36_0.selectetPanel, false)

	arg_36_0.srcollViewCG.alpha = 1
	arg_36_0.inAnim = true

	if arg_36_0.timer then
		local var_36_4 = arg_36_0.timer

		var_3.Stop(var_36_4)

		arg_36_0.timer = nil
	end

	Timer = var_3
	arg_36_0.timer = var_3.New(function()
		arg_36_0.inAnim = nil

		return
	end, 0.2, 1)

	local var_36_5 = arg_36_0.timer

	var_3.Start(var_36_5)

	if arg_36_0.extraTimer then
		local var_36_6 = arg_36_0.extraTimer

		var_3.Stop(var_36_6)

		arg_36_0.extraTimer = nil
	end

	return
end

function var_0_1.updateTechnology(arg_38_0, arg_38_1)
	local var_38_0

	ipairs = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10003(arg_38_0.technologyVOs) do
		if iter_38_1.id == arg_38_1.id then
			arg_38_0.technologyVOs[iter_38_0] = arg_38_1
			var_38_0 = iter_38_0

			break
		end
	end

	local var_38_1 = arg_38_0.technologyCards[var_38_0]

	arg_38_0:updateTechnologyTF(var_38_1, var_38_0, "base")

	if arg_38_0.contextData.selectedIndex and arg_38_0.technologyVOs[arg_38_0.contextData.selectedIndex].id == arg_38_1.id then
		arg_38_0:updateTechnologyTF(arg_38_0.technologyTpl, var_38_0, "desc")
	end

	return
end

function var_0_1.updateQueueChange(arg_39_0)
	local var_39_0 = arg_39_0.queueItemList

	var_1.align(var_39_0, #arg_39_0.technologyQueue)

	local var_39_1 = arg_39_0.queueCardItemList
	local var_39_2 = var_1.align

	TechnologyConst = var_4

	var_39_2(var_39_1, var_4.QUEUE_TOTAL_COUNT)

	setActive = var_39_2

	local var_39_3 = arg_39_0.btnAwardQueue
	local var_39_5

	if arg_39_0.technologyQueue[1] then
		local var_39_4 = arg_39_0.technologyQueue[1]

		var_39_5 = var_4.isCompleted(var_39_4)
	end

	var_39_2(var_39_3, var_39_5)

	setActive = var_39_2

	local var_39_6 = arg_39_0.btnAwardQueueDisable

	isActive = var_39_5

	var_39_2(var_39_6, not var_39_5(arg_39_0.btnAwardQueue))

	getProxy = var_39_2
	TechnologyProxy = var_39_6

	local var_39_7 = var_39_2(var_39_6)

	if var_1.getActivateTechnology(var_39_7) then
		arg_39_0:updateTechnology(var_1)
	end

	return
end

function var_0_1.updateTechnologyTF(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0

	if arg_40_3 == "queue" then
		var_40_0 = arg_40_0.technologyQueue[arg_40_2]
		tobool = var_5

		local var_40_1 = not var_5(var_40_0)

		setActive = var_1_10006

		var_1_10006(arg_40_1:Find("frame"), not var_40_1)

		setActive = var_1_10006

		var_1_10006(arg_40_1:Find("empty"), var_40_1)

		if var_40_1 then
			return
		end
	else
		var_40_0 = arg_40_0.technologyVOs[arg_40_2]
	end

	arg_40_0:updateInfo(arg_40_1, var_40_0, arg_40_3)
	arg_40_0:updateInfoVersionPickUp(arg_40_1, var_40_0)

	local var_40_2 = var_40_0:getConfig("time")

	pg = var_1_10006

	local var_40_3 = var_1_10006.TimeMgr.GetInstance()
	local var_40_4 = var_6.GetServerTime(var_40_3)
	local var_40_5 = var_40_0.time

	switch = var_40_3

	var_40_3(arg_40_3, {
		base = function()
			if arg_40_0.cardtimer[arg_40_2] then
				local var_41_0 = arg_40_0.cardtimer[arg_40_2]

				var_0.Stop(var_41_0)

				arg_40_0.cardtimer[arg_40_2] = nil
			end

			local var_41_1 = arg_40_1
			local var_41_2 = var_0.Find(var_41_1, "frame/marks/time")
			local var_41_3 = arg_40_1
			local var_41_4 = var_1.Find(var_41_3, "frame/marks/Text")
			local var_41_5 = var_0_1.rarityColor
			local var_41_6 = var_40_0
			local var_41_7 = var_41_5[var_3.getConfig(var_41_6, "bg")]

			GetComponent = var_3

			local var_41_8 = var_3(var_41_2, "Shadow")

			Color = var_4

			local var_41_9 = var_4.New

			unpack = var_6
			var_41_8.effectColor = var_41_9(var_6(var_41_7[2]))

			local var_41_10 = {}
			local var_41_13, var_41_18

			if var_40_5 <= 0 then
				var_41_10.blue = true
				setText = var_41_18

				local var_41_11 = var_41_4

				setColorStr = var_41_13
				i18n = var_2_10010

				var_41_18(var_41_11, var_41_13(var_2_10010("technology_detail"), var_41_7[1]))

				setText = var_41_18

				local var_41_12 = var_41_2

				pg = var_41_13
				var_2_10010 = var_41_13.TimeMgr.GetInstance()
				var_41_13 = var_41_13.DescCDTime

				local var_41_14 = var_40_0

				var_41_18(var_41_12, var_41_13(var_2_10010, var_11.getConfig(var_41_14, "time")))
			elseif var_40_4 < var_40_5 - var_40_2 then
				var_41_10.blue = true
				setText = var_41_18

				local var_41_15 = var_41_4

				setColorStr = var_41_13
				i18n = var_2_10010

				var_41_18(var_41_15, var_41_13(var_2_10010("technology_queue_waiting"), var_41_7[1]))

				setText = var_41_18

				local var_41_16 = var_41_2

				pg = var_41_13
				var_2_10010 = var_41_13.TimeMgr.GetInstance()
				var_41_13 = var_41_13.DescCDTime

				local var_41_17 = var_40_0

				var_41_18(var_41_16, var_41_13(var_2_10010, var_11.getConfig(var_41_17, "time")))

				var_41_18 = arg_40_0.cardtimer

				local var_41_19 = arg_40_2

				Timer = var_41_16
				var_41_18[var_41_19] = var_41_16.New(function()
					local var_42_0 = arg_40_0

					var_0.updateTechnology(var_42_0, var_40_0)

					return
				end, var_40_5 - var_40_2 - var_40_4)

				local var_41_20 = arg_40_0.cardtimer[arg_40_2]

				var_41_18.Start(var_41_20)
			elseif var_40_4 < var_40_5 then
				var_41_10.blue = true
				setText = var_41_18

				local var_41_21 = var_41_4

				setColorStr = var_41_13
				i18n = var_2_10010

				var_41_18(var_41_21, var_41_13(var_2_10010("technology_queue_processing"), var_41_7[1]))

				var_41_18 = arg_40_0.cardtimer

				local var_41_22 = arg_40_2

				Timer = var_41_21
				var_41_18[var_41_22] = var_41_21.New(function()
					local var_43_0 = var_40_0.time

					pg = var_3_10001

					local var_43_1 = var_3_10001.TimeMgr.GetInstance()

					if var_1.GetServerTime(var_43_1) < var_43_0 then
						setText = var_3_10002

						local var_43_2 = var_41_2

						pg = var_3_10005

						local var_43_3 = var_3_10005.TimeMgr.GetInstance()

						var_3_10002(var_43_2, var_5.DescCDTime(var_43_3, var_43_0 - var_1))
					else
						local var_43_4 = arg_40_0

						var_2.updateTechnology(var_43_4, var_40_0)
					end

					return
				end, 1, -1)

				local var_41_23 = arg_40_0.cardtimer[arg_40_2]

				var_41_18.Start(var_41_23)
				arg_40_0.cardtimer[arg_40_2].func()
			else
				var_41_10.green = true

				local var_41_24 = var_40_0

				if var_41_18.isCompleted(var_41_24) then
					setText = var_41_18

					local var_41_25 = var_41_4

					setColorStr = var_41_13
					i18n = var_2_10010

					var_41_18(var_41_25, var_41_13(var_2_10010("technology_queue_complete"), var_41_7[1]))
				else
					setText = var_41_18

					local var_41_26 = var_41_4

					setColorStr = var_41_13
					i18n = var_2_10010

					var_41_18(var_41_26, var_41_13(var_2_10010("technology_mission_unfinish"), var_41_7[1]))
				end

				setText = var_41_18

				var_41_18(var_41_2, "00:00:00")
			end

			eachChild = var_41_18

			local var_41_27 = arg_40_1

			var_41_18(var_7.Find(var_41_27, "frame/marks/line"), function(arg_44_0)
				setActive = var_3_10001

				var_3_10001(arg_44_0, var_41_10[arg_44_0.name])

				return
			end)

			return
		end,
		queue = function()
			if arg_40_0.queueCardTimer[arg_40_2] then
				local var_45_0 = arg_40_0.queueCardTimer[arg_40_2]

				var_0.Stop(var_45_0)

				arg_40_0.queueCardTimer[arg_40_2] = nil
			end

			local var_45_1 = arg_40_1
			local var_45_2 = var_0.Find(var_45_1, "frame/marks/time")
			local var_45_3 = arg_40_1
			local var_45_4 = var_1.Find(var_45_3, "frame/marks/Text")
			local var_45_5 = var_0_1.rarityColor
			local var_45_6 = var_40_0
			local var_45_7 = var_45_5[var_3.getConfig(var_45_6, "bg")]

			GetComponent = var_3

			local var_45_8 = var_3(var_45_2, "Shadow")

			Color = var_4

			local var_45_9 = var_4.New

			unpack = var_6
			var_45_8.effectColor = var_45_9(var_6(var_45_7[2]))

			local var_45_10 = {}
			local var_45_16

			if var_40_5 <= 0 then
				assert = var_45_16

				var_45_16(false, "error queue")
			else
				local var_45_13

				if var_40_4 < var_40_5 - var_40_2 then
					var_45_10.blue = true
					setText = var_45_16

					local var_45_11 = var_45_4

					setColorStr = var_45_13
					i18n = var_2_10010

					var_45_16(var_45_11, var_45_13(var_2_10010("technology_queue_waiting"), var_45_7[1]))

					setText = var_45_16

					local var_45_12 = var_45_2

					pg = var_45_13
					var_2_10010 = var_45_13.TimeMgr.GetInstance()
					var_45_13 = var_45_13.DescCDTime

					local var_45_14 = var_40_0

					var_45_16(var_45_12, var_45_13(var_2_10010, var_11.getConfig(var_45_14, "time")))
				elseif var_40_4 < var_40_5 then
					var_45_10.blue = true
					setText = var_45_16

					local var_45_15 = var_45_4

					setColorStr = var_45_13
					i18n = var_2_10010

					var_45_16(var_45_15, var_45_13(var_2_10010("technology_queue_processing"), var_45_7[1]))

					var_45_16 = arg_40_0.queueCardTimer

					local var_45_17 = arg_40_2

					Timer = var_45_15
					var_45_16[var_45_17] = var_45_15.New(function()
						local var_46_0 = var_40_0.time

						pg = var_3_10001

						local var_46_1 = var_3_10001.TimeMgr.GetInstance()

						if var_1.GetServerTime(var_46_1) < var_46_0 then
							setText = var_3_10002

							local var_46_2 = var_45_2

							pg = var_3_10005

							local var_46_3 = var_3_10005.TimeMgr.GetInstance()

							var_3_10002(var_46_2, var_5.DescCDTime(var_46_3, var_46_0 - var_1))
						end

						return
					end, 1, -1)

					local var_45_18 = arg_40_0.queueCardTimer[arg_40_2]

					var_45_16.Start(var_45_18)
					arg_40_0.queueCardTimer[arg_40_2].func()
				else
					var_45_10.green = true
					setText = var_45_16

					local var_45_19 = var_45_4

					setColorStr = var_45_13
					i18n = var_2_10010

					var_45_16(var_45_19, var_45_13(var_2_10010("technology_queue_complete"), var_45_7[1]))

					setText = var_45_16

					var_45_16(var_45_2, "00:00:00")
				end
			end

			eachChild = var_45_16

			local var_45_20 = arg_40_1

			var_45_16(var_7.Find(var_45_20, "frame/marks/line"), function(arg_47_0)
				setActive = var_3_10001

				var_3_10001(arg_47_0, var_45_10[arg_47_0.name])

				return
			end)

			setActive = var_45_16

			local var_45_21 = arg_40_1

			var_45_16(var_7.Find(var_45_21, "frame/mask"), var_40_5 > 0 and var_40_4 < var_40_5 - var_40_2)

			return
		end,
		desc = function()
			local var_48_0 = arg_40_0.descTxt
			local var_48_1 = var_40_0

			var_48_0.text = var_1.getConfig(var_48_1, "desc")

			local var_48_2 = arg_40_0.descBG

			GetSpriteFromAtlas = var_1

			local var_48_3 = "ui/TechnologyUI_atlas"
			local var_48_4 = var_40_0

			var_48_2.sprite = var_1(var_48_3, var_4.getConfig(var_48_4, "rarity"))

			local var_48_5 = var_40_0
			local var_48_6 = var_0.getConfig(var_48_5, "consume")

			UIItemList = var_1

			local var_48_7 = var_1.New(arg_40_0.itemContainer, arg_40_0.itemTpl)

			var_1.make(var_48_7, function(arg_49_0, arg_49_1, arg_49_2)
				arg_49_1 = arg_49_1 + 1
				UIItemList = var_3_10003

				if arg_49_0 == var_3_10003.EventUpdate then
					local var_49_0 = arg_40_0

					var_3.updateItem(var_49_0, arg_49_2, var_40_0, var_48_6[arg_49_1])

					setActive = var_3

					local var_49_1 = arg_49_2:Find("check")
					local var_49_2 = var_40_0

					var_3(var_49_1, var_6.isActivate(var_49_2))

					setActive = var_3

					local var_49_3 = arg_49_2:Find("icon_bg/count")
					local var_49_4 = var_40_0

					var_3(var_49_3, not var_6.isActivate(var_49_4))
				end

				return
			end)
			var_1:align(#var_48_6)

			setActive = var_2

			var_2(arg_40_0.emptyTF, not var_48_6 or #var_48_6 <= 0)

			local var_48_8 = var_40_0
			local var_48_9 = var_2.getConfig(var_48_8, "condition")

			if 0 < var_48_9 then
				getProxy = var_3
				TaskProxy = var_5

				local var_48_10 = var_3(var_5)
				local var_48_11

				if not var_3.getTaskById(var_48_10, var_48_9) then
					Task = var_48_11
					var_48_11 = var_48_11.New({
						id = var_48_9
					})
				end

				var_48_8 = arg_40_0.taskSlider
				var_48_8.value = var_48_11.progress / var_48_11:getConfig("target_num")
				var_48_8 = arg_40_0.taskDesc

				local var_48_12 = var_48_11:getConfig("desc")
				local var_48_13 = "("
				local var_48_14 = var_48_11.progress
				local var_48_15 = "/"

				var_2_10011 = var_48_11
				var_48_8.text = var_48_12 .. var_48_13 .. var_48_14 .. var_48_15 .. var_48_11.getConfig(var_2_10011, "target_num") .. ")"
			else
				local var_48_16 = arg_40_0.taskDesc

				i18n = var_48_8
				var_48_16.text = var_48_8("technology_task_none_tip")
				arg_40_0.taskSlider.value = 0
			end

			if arg_40_0.extraTimer then
				local var_48_17 = arg_40_0.extraTimer

				var_3.Stop(var_48_17)

				arg_40_0.extraTimer = nil
			end

			local var_48_18 = {}
			local var_48_19

			if var_40_5 <= 0 then
				var_48_18.start_btn = true
				var_48_19 = arg_40_0.timerTxt
				pg = var_5

				local var_48_20 = var_5.TimeMgr.GetInstance()

				var_48_19.text = var_5.DescCDTime(var_48_20, var_40_2)
			elseif var_40_4 < var_40_5 - var_40_2 then
				var_48_18.stop_btn = true

				local var_48_21 = var_40_0

				var_48_18.join_btn = var_48_19.finishCondition(var_48_21)
				var_48_18.lock_join_btn = not var_48_18.join_btn
				var_48_19 = arg_40_0.timerTxt
				pg = var_5

				local var_48_22 = var_5.TimeMgr.GetInstance()

				var_48_19.text = var_5.DescCDTime(var_48_22, var_40_2)
			elseif var_40_4 < var_40_5 then
				var_48_18.stop_btn = true

				local var_48_23 = var_40_0

				var_48_18.join_btn = var_48_19.finishCondition(var_48_23)
				var_48_18.lock_join_btn = not var_48_18.join_btn
				var_48_19 = arg_40_0
				Timer = var_5
				var_48_19.extraTimer = var_5.New(function()
					pg = var_3_10000

					local var_50_0 = var_3_10000.TimeMgr.GetInstance()

					if var_0.GetServerTime(var_50_0) < var_40_5 then
						local var_50_1 = arg_40_0.timerTxt

						pg = var_50_0

						local var_50_2 = var_50_0.TimeMgr.GetInstance()

						var_50_1.text = var_2.DescCDTime(var_50_2, var_40_5 - var_0)
					end

					return
				end, 1, -1)

				local var_48_24 = arg_40_0.extraTimer

				var_48_19.Start(var_48_24)
				arg_40_0.extraTimer.func()
			else
				local var_48_25 = var_40_0

				if var_48_19.isCompleted(var_48_25) then
					var_48_18.finish_btn = true
				else
					var_48_18.stop_btn = true
					var_48_18.lock_join_btn = true
				end

				var_48_19 = arg_40_0.timerTxt
				var_48_19.text = "00:00:00"
			end

			eachChild = var_48_19

			local var_48_26 = arg_40_1

			var_48_19(var_6.Find(var_48_26, "frame/btns"), function(arg_51_0)
				setActive = var_3_10001

				var_3_10001(arg_51_0, var_48_18[arg_51_0.name])

				return
			end)

			local var_48_27 = arg_40_1
			local var_48_28 = var_4.Find(var_48_27, "frame/btns/start_btn")

			onButton = var_5

			local var_48_29 = arg_40_0
			local var_48_30 = var_48_28

			local function var_48_31()
				getProxy = var_3_10000
				TechnologyProxy = var_3_10002

				local var_52_0 = var_3_10000(var_3_10002)

				if var_0.getActivateTechnology(var_52_0) then
					pg = var_0

					local var_52_1 = var_0.TipsMgr.GetInstance()
					local var_52_2 = var_0.ShowTips

					i18n = var_3_10003

					var_52_2(var_52_1, var_3_10003("technology_is_actived"))

					return
				end

				local var_52_3 = var_40_0
				local var_52_4 = #var_0.getConfig(var_52_3, "consume")

				if 0 < var_52_4 then
					getDropInfo = var_52_4

					local var_52_5 = var_52_4(var_0)

					pg = var_2
					var_3_10004 = var_2.MsgboxMgr.GetInstance()

					local var_52_6 = var_2.ShowMsgBox
					local var_52_7 = {}

					i18n = var_3_10006
					var_52_7.content = var_3_10006("technology_task_build_tip", var_52_5)

					function var_52_7.onYes()
						local var_53_0 = arg_40_0
						local var_53_1 = var_0.emit

						TechnologyMediator = var_4_10003

						var_53_1(var_53_0, var_4_10003.ON_START, {
							id = var_40_0.id,
							pool_id = var_40_0.poolId
						})

						return
					end

					var_52_6(var_3_10004, var_52_7)
				else
					local var_52_8 = arg_40_0
					local var_52_9 = var_1.emit

					TechnologyMediator = var_3_10004

					var_52_9(var_52_8, var_3_10004.ON_START, {
						id = var_40_0.id,
						pool_id = var_40_0.poolId
					})
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_48_29, var_48_30, var_48_31, var_2_10010)

			setButtonEnabled = var_5

			local var_48_32 = var_48_28
			local var_48_33 = var_40_0

			var_5(var_48_32, var_8.hasResToStart(var_48_33))

			local var_48_34 = arg_40_1
			local var_48_35 = var_5.Find(var_48_34, "frame/btns/stop_btn")

			onButton = var_48_27

			local var_48_36 = arg_40_0
			local var_48_37 = var_48_35

			local function var_48_38()
				local var_54_0 = var_40_0

				if not var_0.isActivate(var_54_0) then
					return
				end

				pg = var_0

				local var_54_1 = var_0.MsgboxMgr.GetInstance()
				local var_54_2 = var_0.ShowMsgBox
				local var_54_3 = {}

				i18n = var_3_10004
				var_54_3.content = var_3_10004("technology_stop_tip")

				function var_54_3.onYes()
					local var_55_0 = arg_40_0
					local var_55_1 = var_0.emit

					TechnologyMediator = var_4_10003

					var_55_1(var_55_0, var_4_10003.ON_STOP, {
						id = var_40_0.id,
						pool_id = var_40_0.poolId
					})

					return
				end

				var_54_2(var_54_1, var_54_3)

				return
			end

			SFX_PANEL = var_2_10011

			var_48_27(var_48_36, var_48_37, var_48_38, var_2_10011)

			local var_48_39 = arg_40_1
			local var_48_40 = var_6.Find(var_48_39, "frame/btns/join_btn")

			onButton = var_48_34

			local var_48_41 = arg_40_0
			local var_48_42 = var_48_40

			local function var_48_43()
				local var_56_0 = #arg_40_0.technologyQueue

				TechnologyConst = var_3_10001

				if var_56_0 == var_3_10001.QUEUE_TOTAL_COUNT then
					pg = var_56_0

					local var_56_1 = var_56_0.TipsMgr.GetInstance()

					var_56_0 = var_56_0.ShowTips
					i18n = var_3_10003

					var_56_0(var_56_1, var_3_10003("technology_queue_full"))

					return
				end

				pg = var_56_0

				local var_56_2 = var_56_0.MsgboxMgr.GetInstance()
				local var_56_3 = var_0.ShowMsgBox
				local var_56_4 = {}

				i18n = var_3_10004
				var_56_4.content = var_3_10004("technology_queue_in_doublecheck")

				function var_56_4.onYes()
					local var_57_0 = arg_40_0
					local var_57_1 = var_0.emit

					TechnologyMediator = var_4_10003

					var_57_1(var_57_0, var_4_10003.ON_JOIN_QUEUE, {
						id = var_40_0.id,
						pool_id = var_40_0.poolId
					})

					return
				end

				var_56_3(var_56_2, var_56_4)

				return
			end

			SFX_PANEL = var_2_10012

			var_48_34(var_48_41, var_48_42, var_48_43, var_2_10012)

			local var_48_44 = arg_40_1
			local var_48_45 = var_7.Find(var_48_44, "frame/btns/lock_join_btn")

			onButton = var_48_39

			local var_48_46 = arg_40_0
			local var_48_47 = var_48_45

			local function var_48_48()
				pg = var_3_10000

				local var_58_0 = var_3_10000.TipsMgr.GetInstance()
				local var_58_1 = var_0.ShowTips

				i18n = var_3_10003

				var_58_1(var_58_0, var_3_10003("technology_queue_in_mission_incomplete"))

				return
			end

			SFX_PANEL = var_2_10013

			var_48_39(var_48_46, var_48_47, var_48_48, var_2_10013)

			local var_48_49 = arg_40_1
			local var_48_50 = var_8.Find(var_48_49, "frame/btns/finish_btn")

			onButton = var_48_44

			local var_48_51 = arg_40_0
			local var_48_52 = var_48_50

			local function var_48_53()
				local var_59_0 = arg_40_0
				local var_59_1 = var_0.emit

				TechnologyMediator = var_3_10003

				var_59_1(var_59_0, var_3_10003.ON_FINISHED, {
					id = var_40_0.id,
					pool_id = var_40_0.poolId
				})

				return
			end

			SFX_PANEL = var_2_10014

			var_48_44(var_48_51, var_48_52, var_48_53, var_2_10014)

			return
		end
	})

	return
end

function var_0_1.dfs(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_1.name ~= "item_tpl" then
		for iter_60_0 = 1, arg_60_1.childCount do
			arg_60_0:dfs(arg_60_1:GetChild(iter_60_0 - 1), arg_60_2)
		end
	else
		arg_60_2(arg_60_1)
	end

	return
end

local var_0_2 = {
	tag_red = "F15F34FF",
	tag_blue = "2541E3FF"
}

function var_0_1.updateInfo(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	setImageSprite = var_1_10004

	local var_61_0 = arg_61_1:Find("frame")

	GetSpriteFromAtlas = var_1_10007

	var_1_10004(var_61_0, var_1_10007("technologycard", arg_61_2:getConfig("bg") .. (arg_61_3 == "desc" and "_l" or "")))

	setImageSprite = var_1_10004

	local var_61_1 = arg_61_1:Find("frame/icon_mask/icon")

	GetSpriteFromAtlas = var_7

	var_1_10004(var_61_1, var_7("technologyshipicon/" .. arg_61_2:getConfig("bg_icon"), arg_61_2:getConfig("bg_icon")), true)

	setImageSprite = var_1_10004

	local var_61_2 = arg_61_1:Find("frame/top/label")

	GetSpriteFromAtlas = var_7

	var_1_10004(var_61_2, var_7("technologycard", arg_61_2:getConfig("label")))

	setImageSprite = var_1_10004

	local var_61_3 = arg_61_1:Find("frame/top/label/text")

	GetSpriteFromAtlas = var_7

	var_1_10004(var_61_3, var_7("technologycard", arg_61_2:getConfig("label_color")), true)

	setImageSprite = var_1_10004

	local var_61_4 = arg_61_1:Find("frame/top/label/version")

	GetSpriteFromAtlas = var_7

	var_1_10004(var_61_4, var_7("technologycard", "version_" .. arg_61_2:getConfig("blueprint_version")), true)

	setImageColor = var_1_10004

	local var_61_5 = arg_61_1:Find("frame/top/pick_up")

	Color = var_7

	var_1_10004(var_61_5, var_7.NewHex(var_0_2[arg_61_2:getConfig("label")]))

	setText = var_1_10004

	var_1_10004(arg_61_1:Find("frame/name_bg/Text"), arg_61_2:getConfig("name"))

	setText = var_1_10004

	local var_61_6 = arg_61_1:Find("frame/sub_name")
	local var_61_7

	if not arg_61_2:getConfig("sub_name") then
		var_61_7 = ""
	end

	var_1_10004(var_61_6, var_61_7)

	local var_61_8 = arg_61_2:getConfig("drop_client")
	local var_61_9 = arg_61_1:Find("frame/item_container")
	local var_61_10 = 0

	arg_61_0:dfs(var_61_9, function(arg_62_0)
		var_61_10 = var_61_10 + 1
		setActive = var_1

		var_1(arg_62_0, var_61_10 <= #var_61_8)

		if var_61_10 <= #var_61_8 then
			local var_62_0 = arg_61_0

			var_1.updateItem(var_62_0, arg_62_0, arg_61_2, var_61_8[var_61_10])
		end

		return
	end)

	switch = var_7

	var_7(arg_61_3, {
		desc = function()
			return
		end
	}, function()
		setActive = var_2_10000

		local var_64_0 = var_61_9

		var_2_10000(var_2.GetChild(var_64_0, 1), #var_61_8 > 2)

		local var_64_1 = var_61_9
		local var_64_2 = var_0.GetChild(var_64_1, 0)

		var_0.GetComponent(var_64_2, "HorizontalLayoutGroup").padding.right = #var_61_8 == 4 and 25 or 0

		local var_64_3 = var_61_9
		local var_64_4 = var_0.GetChild(var_64_3, 1)

		var_0.GetComponent(var_64_4, "HorizontalLayoutGroup").padding.left = #var_61_8 == 4 and 25 or 0

		return
	end)

	return
end

function var_0_1.updateInfoVersionPickUp(arg_65_0, arg_65_1, arg_65_2)
	getProxy = var_1_10003
	TechnologyProxy = var_1_10005

	local var_65_0 = var_1_10003(var_1_10005)
	local var_65_1 = var_3.getTendency(var_65_0, 2)

	setActive = var_1_10004

	var_1_10004(arg_65_1:Find("frame/top/pick_up"), var_65_1 == arg_65_2:getConfig("blueprint_version"))

	return
end

function var_0_1.updateItem(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	Drop = var_1_10004

	local var_66_0 = var_1_10004.Create(arg_66_3)

	updateDrop = var_1_10005

	local var_66_1 = arg_66_1

	setmetatable = var_1_10008

	var_1_10005(var_66_1, var_1_10008({
		count = 0
	}, {
		__index = var_66_0
	}))

	local var_66_2 = arg_66_1:Find("icon_bg/count")

	IsNil = var_6

	local var_66_4

	if not var_6(var_66_2) then
		setColorCount = var_6

		local var_66_3 = var_66_2

		var_66_4 = var_66_0

		var_6(var_66_3, var_66_0.getOwnedCount(var_66_4), var_66_0.count)
	end

	onButton = var_6

	local var_66_5 = arg_66_0
	local var_66_6 = arg_66_1

	local function var_66_7()
		local var_67_0 = var_66_0
		local var_67_1

		if not var_0.getConfig(var_67_0, "display_icon") then
			var_67_1 = {}
		end

		local var_67_2 = #var_67_1

		if 0 < var_67_2 then
			local var_67_3 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2
			var_67_3.type = var_2
			_ = var_2
			var_67_3.items = var_2.map(var_67_1, function(arg_68_0)
				return {
					type = arg_68_0[1],
					id = arg_68_0[2]
				}
			end)

			local var_67_4 = var_66_0

			var_67_3.content = var_2.getConfig(var_67_4, "display")

			function var_67_3.itemFunc(arg_69_0)
				local var_69_0 = arg_66_0

				var_1.emit(var_69_0, var_0_1.ON_DROP, arg_69_0, function()
					pg = var_4_10000

					local var_70_0 = var_4_10000.MsgboxMgr.GetInstance()

					var_0.ShowMsgBox(var_70_0, var_67_3)

					return
				end)

				return
			end

			pg = var_2

			local var_67_5 = var_2.MsgboxMgr.GetInstance()

			var_2.ShowMsgBox(var_67_5, var_67_3)
		else
			local var_67_6 = arg_66_0

			var_1.emit(var_67_6, var_0_1.ON_DROP, var_66_0)
		end

		return
	end

	SFX_PANEL = var_66_4

	var_6(var_66_5, var_66_6, var_66_7, var_66_4)

	return
end

function var_0_1.updatePickUpVersionChange(arg_71_0)
	arg_71_0:updateSettingBtnVersion()

	ipairs = var_1

	for iter_71_0, iter_71_1 in var_1(arg_71_0.technologyCards) do
		arg_71_0:updateInfoVersionPickUp(iter_71_1, arg_71_0.technologyVOs[iter_71_0])
	end

	ipairs = var_1

	for iter_71_2, iter_71_3 in var_1(arg_71_0.technologyQueue) do
		local var_71_0 = arg_71_0
		local var_71_1 = arg_71_0.updateInfoVersionPickUp
		local var_71_2 = arg_71_0.queueCardItemList.container

		var_71_1(var_71_0, var_9.GetChild(var_71_2, iter_71_2 - 1), iter_71_3)
	end

	return
end

function var_0_1.clearTimer(arg_72_0, ...)
	if arg_72_0.timer then
		local var_72_0 = arg_72_0.timer

		var_1.Stop(var_72_0)

		arg_72_0.timer = nil
	end

	if arg_72_0.extraTimer then
		local var_72_1 = arg_72_0.extraTimer

		var_1.Stop(var_72_1)

		arg_72_0.extraTimer = nil
	end

	if arg_72_0.enhancelTimer then
		local var_72_2 = arg_72_0.enhancelTimer

		var_1.Stop(var_72_2)

		arg_72_0.enhancelTimer = nil
	end

	pairs = var_1

	for iter_72_0, iter_72_1 in var_1(arg_72_0.cardtimer) do
		iter_72_1:Stop()
	end

	arg_72_0.cardtimer = {}
	pairs = var_1

	for iter_72_2, iter_72_3 in var_1(arg_72_0.queueTimer) do
		iter_72_3:Stop()
	end

	arg_72_0.queueTimer = {}
	pairs = var_1

	for iter_72_4, iter_72_5 in var_1(arg_72_0.queueCardTimer) do
		iter_72_5:Stop()
	end

	arg_72_0.queueCardTimer = {}

	if arg_72_0.actCatchupTimer then
		local var_72_3 = arg_72_0.actCatchupTimer

		var_1.Stop(var_72_3)

		arg_72_0.actCatchupTimer = nil
	end

	return
end

function var_0_1.willExit(arg_73_0)
	arg_73_0:clearTimer()

	arg_73_0.cardtimer = nil
	arg_73_0.queueTimer = nil
	arg_73_0.queueCardTimer = nil

	return
end

return var_0_1
