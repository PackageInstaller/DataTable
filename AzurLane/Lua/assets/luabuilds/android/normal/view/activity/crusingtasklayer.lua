class = var_0_10000

local var_0_0 = "CrusingTaskLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CrusingTaskUI"
end

function var_0_1.tempCache(arg_2_0)
	return true
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtBg = var_1.Find(var_3_0, "bg")

	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_1.Find(var_3_1, "window")

	arg_3_0.itemQuick = var_1.Find(var_3_2, "item_quick")
	arg_3_0.btnBack = var_1:Find("btn_back")
	arg_3_0.btnHelp = var_1:Find("btn_help")
	arg_3_0.textPhase = var_1:Find("text_phase")
	arg_3_0.sliderPt = var_1:Find("Slider")
	arg_3_0.textComplete = var_1:Find("text_complete")

	local var_3_3 = var_1
	local var_3_4 = var_1.Find(var_3_3, "view/content")

	UIItemList = var_3_3
	arg_3_0.taskGroupItemList = var_3_3.New(var_3_4, var_3_4:Find("tpl"))

	local var_3_5 = arg_3_0.taskGroupItemList

	var_3.make(var_3_5, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0

			var_3.updateTaskGroup(var_4_0, arg_4_2, arg_3_0.tempTaskGroup[arg_4_1])
		end

		return
	end)

	arg_3_0.rtWeekToggles = var_1:Find("week_list")

	return
end

function var_0_1.didEnter(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_0, arg_5_0._tf)

	onButton = var_1

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.rtBg

	local function var_5_3()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		CrusingTaskMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_EXIT)

		local var_6_2 = arg_5_0

		var_0.closeView(var_6_2)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_5_1, var_5_2, var_5_3, var_1_10005)

	onButton = var_1

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.btnBack

	local function var_5_6()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		CrusingTaskMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.ON_EXIT)

		local var_7_2 = arg_5_0

		var_0.closeView(var_7_2)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_5_4, var_5_5, var_5_6, var_1_10005)

	onButton = var_1

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.btnHelp

	local function var_5_9()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		i18n = var_2_10003

		local var_8_3 = "cruise_task_help_"

		pg = var_2_10005
		var_8_2.helps = var_2_10003(var_8_3 .. var_2_10005.battlepass_event_pt[arg_5_0.activity.id].map_name)

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_7, var_5_8, var_5_9, var_1_10005)

	getProxy = var_1
	TaskProxy = var_5_7

	local var_5_10 = var_1(var_5_7)

	pairs = var_5_7

	for iter_5_0, iter_5_1 in var_5_7(arg_5_0.taskGroupList) do
		local var_5_11 = arg_5_0.rtWeekToggles
		local var_5_12 = var_7.Find(var_5_11, iter_5_0)

		if 0 < iter_5_0 then
			setText = var_8
			var_1_10010 = var_5_12

			local var_5_13 = var_5_12.Find(var_1_10010, "off/Text")

			i18n = var_1_10010

			var_8(var_5_13, var_1_10010("cruise_task_week", iter_5_0))

			setText = var_8
			var_1_10010 = var_5_12

			local var_5_14 = var_5_12.Find(var_1_10010, "on/Text")

			i18n = var_1_10010

			var_8(var_5_14, var_1_10010("cruise_task_week", iter_5_0))
		end

		setActive = var_8
		var_1_10010 = var_5_12

		local var_5_15 = var_5_12.Find(var_1_10010, "tip")

		if not iter_5_1.isLock then
			PlayerPrefs = var_1_10010
			var_1_10010 = var_1_10010.GetInt
			string = var_1_10011

			if var_1_10010(var_1_10011.format("cursing_%d_task_week_%d", arg_5_0.activity.id, iter_5_0), 0) ~= 0 then
				var_1_10010 = false
			else
				var_1_10010 = true
			end

			var_8(var_5_15, var_1_10010)

			onToggle = var_8

			local var_5_16 = arg_5_0

			var_1_10010 = var_5_12

			function var_1_10011(arg_9_0)
				if arg_9_0 then
					setActive = var_2_10001

					local var_9_0 = var_5_12

					var_2_10001(var_2.Find(var_9_0, "tip"), false)

					PlayerPrefs = var_2_10001

					local var_9_1 = var_2_10001.SetInt

					string = var_2

					var_9_1(var_2.format("cursing_%d_task_week_%d", arg_5_0.activity.id, iter_5_0), 1)

					arg_5_0.weekToggle = iter_5_0
					arg_5_0.contextData.weekToggle = iter_5_0

					local var_9_2 = arg_5_0

					underscore = var_2
					var_9_2.tempTaskGroup = var_2.map(iter_5_1.task_group, function(arg_10_0)
						underscore = var_3_10001

						return var_3_10001.map(arg_10_0, function(arg_11_0)
							assert = var_4_10001

							local var_11_0 = var_5_10

							var_4_10001(var_2.getTaskVO(var_11_0, arg_11_0), "without this task:" .. arg_11_0)

							local var_11_1 = var_5_10

							return var_1.getTaskVO(var_11_1, arg_11_0)
						end)
					end)
					table = var_9_2

					local var_9_3 = var_9_2.sort
					local var_9_4 = arg_5_0.tempTaskGroup

					CompareFuncs = var_3

					var_9_3(var_9_4, var_3({
						function(arg_12_0)
							underscore = var_3_10001

							return var_3_10001.all(arg_12_0, function(arg_13_0)
								return arg_13_0:isReceive()
							end) and 1 or 0
						end,
						function(arg_14_0)
							return arg_14_0[1].id
						end
					}))

					local var_9_5 = arg_5_0.taskGroupItemList

					var_1.align(var_9_5, #arg_5_0.tempTaskGroup)

					local var_9_6 = arg_5_0

					var_1.updateTaskInfo(var_9_6)
				end

				return
			end

			SFX_PANEL = var_1_10012

			var_8(var_5_16, var_1_10010, var_1_10011, var_1_10012)

			if var_5_12:Find("mask") then
				setActive = var_8
				var_1_10010 = var_5_12

				var_8(var_5_12.Find(var_1_10010, "mask"), iter_5_1.isLock)
			end
		end
	end

	underscore = var_2

	local var_5_17 = var_2.keys(arg_5_0.taskGroupList)

	table = var_3

	var_3.sort(var_5_17, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)

	local var_5_18

	if arg_5_0.contextData.weekToggle and not arg_5_0.taskGroupList[arg_5_0.contextData.weekToggle].isLock then
		arg_5_0.weekToggle = arg_5_0.contextData.weekToggle
		var_5_18 = arg_5_0.contextData
		var_5_18.weekToggle = nil
	else
		table = var_5_18
		arg_5_0.weekToggle = var_5_18.remove(var_5_17, 1)
		ipairs = var_5_18

		for iter_5_2, iter_5_3 in var_5_18(var_5_17) do
			if arg_5_0.taskGroupList[iter_5_3].isLock then
				break
			else
				underscore = var_9

				local var_5_19 = var_9.any

				underscore = var_1_10010

				if var_5_19(var_1_10010.flatten(var_8.task_group), function(arg_16_0)
					local var_16_0 = var_5_10
					local var_16_1

					var_16_1 = var_1.getTaskVO(var_16_0, arg_16_0) and not var_1:isReceive()

					return var_16_1
				end) then
					arg_5_0.weekToggle = iter_5_3

					break
				end
			end
		end
	end

	triggerToggle = var_5_18

	local var_5_20 = arg_5_0.rtWeekToggles

	var_5_18(var_4.Find(var_5_20, arg_5_0.weekToggle), true)

	ipairs = var_5_18

	for iter_5_4, iter_5_5 in var_5_18(arg_5_0.taskGroupList) do
		local var_5_21 = arg_5_0.rtWeekToggles
		local var_5_22 = var_8.Find(var_5_21, iter_5_4)

		SetCompomentEnabled = var_5_21

		local var_5_23 = var_5_22

		typeof = var_1_10011
		Toggle = var_1_10012

		var_5_21(var_5_23, var_1_10011(var_1_10012), not iter_5_5.isLock)

		if not iter_5_5.isLock then
			setGray = var_9

			local var_5_24 = var_5_22

			underscore = var_1_10011
			var_1_10011 = var_1_10011.all
			underscore = var_1_10012

			var_9(var_5_24, var_1_10011(var_1_10012.flatten(iter_5_5.task_group), function(arg_17_0)
				local var_17_0 = var_5_10
				local var_17_1

				var_17_1 = var_1.getTaskVO(var_17_0, arg_17_0) and var_1:isReceive()

				return var_17_1
			end))
		end
	end

	local var_5_25 = arg_5_0

	arg_5_0.updatePhaseInfo(var_5_25)

	LoadImageSpriteAtlasAsync = var_3
	Drop = var_5_25

	local var_5_26 = var_5_25.New
	local var_5_27 = {}

	DROP_TYPE_VITEM = iter_5_4
	var_5_27.type = iter_5_4
	var_5_27.id = arg_5_0.ptId

	local var_5_28 = var_5_26(var_5_27)
	local var_5_29 = var_4.getIcon(var_5_28)
	local var_5_30 = ""
	local var_5_31 = arg_5_0.sliderPt

	var_3(var_5_29, var_5_30, var_6.Find(var_5_31, "icon"), true)

	onButton = var_3

	local var_5_32 = arg_5_0
	local var_5_33 = arg_5_0.itemQuick

	local function var_5_34()
		local var_18_0 = arg_5_0
		local var_18_1 = var_0.emit
		local var_18_2 = var_0_1.ON_DROP
		local var_18_3 = {
			count = 1
		}

		DROP_TYPE_ITEM = var_2_10004
		var_18_3.type = var_2_10004
		Item = var_2_10004
		var_18_3.id = var_2_10004.QUICK_TASK_PASS_TICKET_ID

		var_18_1(var_18_0, var_18_2, var_18_3)

		return
	end

	SFX_PANEL = var_7

	var_3(var_5_32, var_5_33, var_5_34, var_7)

	LoadImageSpriteAtlasAsync = var_3
	Drop = var_5_32

	local var_5_35 = var_5_32.New
	local var_5_36 = {}

	DROP_TYPE_ITEM = var_5_34
	var_5_36.type = var_5_34
	Item = var_5_34
	var_5_36.id = var_5_34.QUICK_TASK_PASS_TICKET_ID

	local var_5_37 = var_5_35(var_5_36)
	local var_5_38 = var_4.getIcon(var_5_37)
	local var_5_39 = ""
	local var_5_40 = arg_5_0.itemQuick

	var_3(var_5_38, var_5_39, var_6.Find(var_5_40, "icon"), true)

	onButton = var_3

	local var_5_41 = arg_5_0
	local var_5_42 = arg_5_0.itemQuick

	var_3(var_5_41, var_5.Find(var_5_42, "plus"), function()
		shoppingBatch = var_2_10000

		local var_19_0 = 61017
		local var_19_1 = {}

		Item = var_2_10003
		var_19_1.id = var_2_10003.QUICK_TASK_PASS_TICKET_ID

		var_2_10000(var_19_0, var_19_1, 20, "build_ship_quickly_buy_stone")

		return
	end)
	arg_5_0:updateItemInfo()

	setText = var_3

	local var_5_43 = arg_5_0.textComplete
	local var_5_44 = var_4.Find(var_5_43, "Text")

	i18n = var_5_43

	var_3(var_5_44, var_5_43("cruise_task_tips"))

	return
end

function var_0_1.willExit(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0._tf)

	return
end

function var_0_1.setActivity(arg_21_0, arg_21_1)
	arg_21_0.activity = arg_21_1
	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_1:GetCrusingInfo()) do
		arg_21_0[iter_21_0] = iter_21_1
	end

	arg_21_0.taskGroupList = {}
	pg = var_2

	local var_21_0 = var_2.TimeMgr.GetInstance()
	local var_21_1 = var_2.GetServerOverWeek(var_21_0, arg_21_1:getStartTime())

	ipairs = var_21_0

	for iter_21_2, iter_21_3 in var_21_0(arg_21_1:getConfig("config_data")) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.battlepass_task_group[iter_21_3]
		arg_21_0.taskGroupList[var_1_10008.group_mask] = {
			task_group = var_1_10008.task_group,
			isLock = var_21_1 < var_1_10008.group_mask
		}
	end

	return
end

function var_0_1.updatePhaseInfo(arg_22_0)
	setText = var_1_10001

	local var_22_0 = arg_22_0.textPhase

	i18n = var_1_10003

	var_1_10001(var_22_0, var_1_10003("cruise_task_phase", arg_22_0.phase))

	local var_22_1

	if arg_22_0.phase < #arg_22_0.awardList then
		var_22_1 = arg_22_0.phase == 0 and 0 or arg_22_0.awardList[arg_22_0.phase].pt

		local var_22_2 = arg_22_0.pt - var_22_1
		local var_22_3 = arg_22_0.awardList[arg_22_0.phase + 1].pt - var_22_1

		setSlider = var_4

		var_4(arg_22_0.sliderPt, 0, var_22_3, var_22_2)

		setText = var_4

		local var_22_4 = arg_22_0.sliderPt

		var_4(var_5.Find(var_22_4, "Text"), var_22_2 .. "/" .. var_22_3)
	else
		setSlider = var_22_1

		var_22_1(arg_22_0.sliderPt, 0, 1, 1)

		setText = var_22_1

		local var_22_5 = arg_22_0.sliderPt

		var_22_1(var_2.Find(var_22_5, "Text"), "MAX")
	end

	return
end

function var_0_1.updateTaskInfo(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = 0

	underscore = var_1_10003

	var_1_10003.each(arg_23_0.tempTaskGroup, function(arg_24_0)
		underscore = var_2_10001

		var_2_10001.each(arg_24_0, function(arg_25_0)
			var_23_1 = var_23_1 + 1

			if arg_25_0:isReceive() then
				var_23_0 = var_23_0 + 1
			end

			return
		end)

		return
	end)

	setText = var_3

	var_3(arg_23_0.textComplete, var_23_0 .. "/" .. var_23_1)

	return
end

function var_0_1.updateItemInfo(arg_26_0)
	setText = var_1_10001

	local var_26_0 = arg_26_0.itemQuick

	getProxy = var_1_10003
	BagProxy = var_1_10004

	local var_26_1 = var_1_10003(var_1_10004)
	local var_26_2 = var_3.getItemCountById

	Item = var_1_10005

	var_1_10001(var_26_0, var_26_2(var_26_1, var_1_10005.QUICK_TASK_PASS_TICKET_ID))

	return
end

function var_0_1.updateTaskGroup(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1
	local var_27_1 = arg_27_1.Find(var_27_0, "info")

	LoadImageSpriteAtlasAsync = var_27_0

	local var_27_2 = "ui/crusingtaskui_atlas"

	tostring = var_1_10006

	var_27_0(var_27_2, var_1_10006(arg_27_0.weekToggle), var_27_1:Find("week"), true)

	local var_27_3 = {}

	ipairs = var_27_2

	for iter_27_0, iter_27_1 in var_27_2(arg_27_2) do
		if not iter_27_1:isReceive() then
			table = var_10

			var_10.insert(var_27_3, iter_27_1)
		end
	end

	triggerToggle = var_5

	var_5(var_27_1, false)

	local var_27_4 = #var_27_3

	if 0 < var_27_4 then
		table = var_27_4

		local var_27_5

		if not var_27_4.remove(var_27_3, 1) then
			var_27_5 = arg_27_2[#arg_27_2]
		end

		SetCompomentEnabled = var_6

		local var_27_6 = var_27_1

		typeof = iter_27_0
		Toggle = iter_27_1

		var_6(var_27_6, iter_27_0(iter_27_1), #var_27_3 > 0)
		arg_27_0:updateTaskDisplay(var_27_1, var_27_5)

		setActive = var_6

		var_6(var_27_1:Find("quick"), var_27_5:getConfig("quick_finish") > 0 and var_27_5:getTaskStatus() == 0)

		onButton = var_6

		local var_27_7 = arg_27_0
		local var_27_8 = var_27_1:Find("quick")

		local function var_27_9()
			getProxy = var_2_10000
			BagProxy = var_2_10001

			local var_28_0 = var_2_10000(var_2_10001)
			local var_28_1 = var_0.getItemCountById

			Item = var_2_10002

			local var_28_2 = var_28_1(var_28_0, var_2_10002.QUICK_TASK_PASS_TICKET_ID)
			local var_28_3 = var_27_5

			if var_28_2 < var_1.getConfig(var_28_3, "quick_finish") then
				pg = var_28_3

				local var_28_4 = var_28_3.MsgboxMgr.GetInstance()

				var_28_3 = var_28_3.ShowMsgBox

				local var_28_5 = {}

				i18n = var_2_10005
				var_28_5.content = var_2_10005("battlepass_task_quickfinish2", var_1 - var_28_2)

				function var_28_5.onYes()
					shoppingBatch = var_3_10000

					local var_29_0 = 61017
					local var_29_1 = {}

					Item = var_3_10003
					var_29_1.id = var_3_10003.QUICK_TASK_PASS_TICKET_ID

					var_3_10000(var_29_0, var_29_1, 20, "build_ship_quickly_buy_stone")

					return
				end

				var_28_3(var_28_4, var_28_5)
			else
				pg = var_28_3

				local var_28_6 = var_28_3.MsgboxMgr.GetInstance()
				local var_28_7 = var_2.ShowMsgBox
				local var_28_8 = {}

				i18n = var_2_10005
				var_28_8.content = var_2_10005("battlepass_task_quickfinish1", var_1, var_28_2)

				function var_28_8.onYes()
					local var_30_0 = arg_27_0
					local var_30_1 = var_0.emit

					CrusingTaskMediator = var_3_10002

					var_30_1(var_30_0, var_3_10002.ON_TASK_QUICK_SUBMIT, var_27_5)

					return
				end

				var_28_7(var_28_6, var_28_8)
			end

			return
		end

		SFX_CONFIRM = var_10

		var_6(var_27_7, var_27_8, var_27_9, var_10)

		setActive = var_6

		var_6(var_27_1:Find("toggle_mark"), #var_27_3 > 0)

		if #var_27_3 > 0 then
			local var_27_10 = arg_27_1
			local var_27_11 = arg_27_1.Find(var_27_10, "content")

			UIItemList = var_27_10

			local var_27_12 = var_27_10.New(var_27_11, var_27_11:Find("extend_tpl"))

			var_7.make(var_27_12, function(arg_31_0, arg_31_1, arg_31_2)
				arg_31_1 = arg_31_1 + 1
				UIItemList = var_2_10003

				if arg_31_0 == var_2_10003.EventUpdate then
					local var_31_0 = arg_27_0

					var_3.updateTaskDisplay(var_31_0, arg_31_2, var_27_3[arg_31_1])
				end

				return
			end)
			var_7:align(#var_27_3)
		end

		return
	end
end

function var_0_1.updateTaskDisplay(arg_32_0, arg_32_1, arg_32_2)
	setText = var_1_10003

	var_1_10003(arg_32_1:Find("desc"), arg_32_2:getConfig("desc"))

	local var_32_0 = arg_32_2:getProgress()
	local var_32_1 = arg_32_2
	local var_32_2 = arg_32_2.getConfig(var_32_1, "target_num")

	setSlider = var_32_1

	var_32_1(arg_32_1:Find("Slider"), 0, var_32_2, var_32_0)

	setText = var_32_1

	var_32_1(arg_32_1:Find("Slider/Text"), var_32_0 .. "/" .. var_32_2)

	local var_32_3 = arg_32_2:getConfig("award_display")[1]
	local var_32_4 = {
		type = var_32_3[1],
		id = var_32_3[2],
		count = var_32_3[3]
	}

	updateDrop = var_6

	var_6(arg_32_1:Find("IconTpl"), var_32_4)

	onButton = var_6

	local var_32_5 = arg_32_0
	local var_32_6 = arg_32_1:Find("IconTpl")

	local function var_32_7()
		local var_33_0 = arg_32_0

		var_0.emit(var_33_0, var_0_1.ON_DROP, var_32_4)

		return
	end

	SFX_PANEL = var_10

	var_6(var_32_5, var_32_6, var_32_7, var_10)

	local var_32_8 = arg_32_2
	local var_32_9 = arg_32_2.getTaskStatus(var_32_8)

	setActive = var_32_8

	var_32_8(arg_32_1:Find("go"), var_32_9 == 0)

	setActive = var_32_8

	var_32_8(arg_32_1:Find("get"), var_32_9 == 1)

	setActive = var_32_8

	var_32_8(arg_32_1:Find("got"), var_32_9 == 2)

	setActive = var_32_8

	var_32_8(arg_32_1:Find("IconTpl/mask"), var_32_9 == 2)

	setActive = var_32_8

	var_32_8(arg_32_1:Find("IconTpl/mark"), var_32_9 == 2)

	onButton = var_32_8

	local var_32_10 = arg_32_0
	local var_32_11 = arg_32_1:Find("go")

	local function var_32_12()
		local var_34_0 = arg_32_0
		local var_34_1 = var_0.emit

		CrusingTaskMediator = var_2_10002

		var_34_1(var_34_0, var_2_10002.ON_TASK_GO, arg_32_2)

		return
	end

	SFX_PANEL = var_11

	var_32_8(var_32_10, var_32_11, var_32_12, var_11)

	onButton = var_32_8

	local var_32_13 = arg_32_0
	local var_32_14 = arg_32_1:Find("get")

	local function var_32_15()
		local var_35_0 = arg_32_0
		local var_35_1 = var_0.emit

		CrusingTaskMediator = var_2_10002

		var_35_1(var_35_0, var_2_10002.ON_TASK_SUBMIT, arg_32_2)

		return
	end

	SFX_CONFIRM = var_11

	var_32_8(var_32_13, var_32_14, var_32_15, var_11)

	return
end

function var_0_1.updateCurrentTaskGroup(arg_36_0)
	triggerToggle = var_1_10001

	local var_36_0 = arg_36_0.rtWeekToggles

	var_1_10001(var_2.Find(var_36_0, arg_36_0.weekToggle), true)

	return
end

return var_0_1
