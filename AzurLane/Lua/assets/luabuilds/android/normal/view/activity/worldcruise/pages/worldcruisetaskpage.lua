class = var_0_10000

local var_0_0 = "WorldCruiseTaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldCruiseTaskPage"
end

function var_0_1.UpdateActivity(arg_2_0, arg_2_1)
	local var_2_1

	if not arg_2_1 then
		::label_2_0::

		getProxy = var_2_1
		ActivityProxy = var_1_10003

		local var_2_0 = var_2_1(var_1_10003)

		var_2_1 = var_2_1.getAliveActivityByType
		ActivityConst = var_1_10004
		var_2_1 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_PT_CRUSING)
	end

	arg_2_0.activity = var_2_1
	pairs = var_2_1

	local var_2_2 = arg_2_0.activity

	for iter_2_0, iter_2_1 in var_2_1(var_3.GetCrusingInfo(var_2_2)) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	arg_2_0.taskGroupList = {}
	pg = var_2

	local var_2_3 = var_2.TimeMgr.GetInstance()
	local var_2_4 = var_2.GetServerOverWeek
	local var_2_5 = arg_2_0.activity
	local var_2_6 = var_2_4(var_2_3, var_4.getStartTime(var_2_5))

	ipairs = var_2_3

	local var_2_7 = arg_2_0.activity

	for iter_2_2, iter_2_3 in var_2_3(var_4.getConfig(var_2_7, "config_data")) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.battlepass_task_group[iter_2_3]
		arg_2_0.taskGroupList[var_1_10008.group_mask] = {
			task_group = var_1_10008.task_group,
			isLock = var_2_6 < var_1_10008.group_mask
		}
	end

	updateCrusingActivityTask = var_3

	var_3(arg_2_0.activity)

	arg_2_0.finishAll = arg_2_0.phase == #arg_2_0.awardList

	return
end

function var_0_1.OnLoaded(arg_3_0)
	arg_3_0:UpdateActivity()

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "frame")

	arg_3_0.togglesTF = var_1.Find(var_3_1, "week_list")

	local var_3_2 = var_1:Find("view/content")
	local var_3_3 = var_2.Find(var_3_2, "tpl")

	setText = var_3_2

	local var_3_4 = var_3_3
	local var_3_5 = var_3_3.Find(var_3_4, "info/go/Text")

	i18n = var_3_4

	var_3_2(var_3_5, var_3_4("task_go"))

	setText = var_3_2

	local var_3_6 = var_3_3
	local var_3_7 = var_3_3.Find(var_3_6, "info/get/Text")

	i18n = var_3_6

	var_3_2(var_3_7, var_3_6("task_get"))

	setText = var_3_2

	local var_3_8 = var_3_3
	local var_3_9 = var_3_3.Find(var_3_8, "info/got/Image/Text")

	i18n = var_3_8

	var_3_2(var_3_9, var_3_8("task_got"))

	local var_3_10 = var_3_3
	local var_3_11 = var_3_3.Find(var_3_10, "content/extend_tpl")

	setText = var_3_10

	local var_3_12 = var_3_11
	local var_3_13 = var_3_11.Find(var_3_12, "go/Text")

	i18n = var_3_12

	var_3_10(var_3_13, var_3_12("task_go"))

	setText = var_3_10

	local var_3_14 = var_3_11
	local var_3_15 = var_3_11.Find(var_3_14, "get/Text")

	i18n = var_3_14

	var_3_10(var_3_15, var_3_14("task_get"))

	setText = var_3_10

	local var_3_16 = var_3_11
	local var_3_17 = var_3_11.Find(var_3_16, "got/Image/Text")

	i18n = var_3_16

	var_3_10(var_3_17, var_3_16("task_got"))

	UIItemList = var_3_10
	arg_3_0.taskGroupItemList = var_3_10.New(var_2, var_3_3)

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0.taskGroupItemList

	var_1.make(var_4_0, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0

			var_3.UpdateTaskGroup(var_5_0, arg_5_2, arg_4_0.tempTaskGroup[arg_5_1])
		end

		return
	end)

	return
end

function var_0_1.Flush(arg_6_0, arg_6_1)
	if arg_6_1 then
		var_1_10003 = arg_6_0

		arg_6_0.UpdateActivity(var_1_10003, arg_6_1)
	end

	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_6_0 = var_1_10002(var_1_10003)

	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.taskGroupList) do
		local var_6_1 = arg_6_0.togglesTF
		local var_6_2 = var_8.Find(var_6_1, iter_6_0)

		if 0 < iter_6_0 then
			setText = var_9
			var_1_10011 = var_6_2

			local var_6_3 = var_6_2.Find(var_1_10011, "off/Text")

			i18n = var_1_10011

			var_9(var_6_3, var_1_10011("cruise_task_week", iter_6_0))

			setText = var_9
			var_1_10011 = var_6_2

			local var_6_4 = var_6_2.Find(var_1_10011, "on/Text")

			i18n = var_1_10011

			var_9(var_6_4, var_1_10011("cruise_task_week", iter_6_0))
		end

		setActive = var_9
		var_1_10011 = var_6_2

		local var_6_5 = var_6_2.Find(var_1_10011, "tip")

		if not iter_6_1.isLock then
			PlayerPrefs = var_1_10011
			var_1_10011 = var_1_10011.GetInt
			string = var_1_10012

			if var_1_10011(var_1_10012.format("cursing_%d_task_week_%d", arg_6_0.activity.id, iter_6_0), 0) ~= 0 then
				var_1_10011 = false
			else
				var_1_10011 = true
			end

			var_9(var_6_5, var_1_10011)

			onToggle = var_9

			local var_6_6 = arg_6_0

			var_1_10011 = var_6_2

			function var_1_10012(arg_7_0)
				if arg_7_0 then
					setActive = var_2_10001

					local var_7_0 = var_6_2

					var_2_10001(var_2.Find(var_7_0, "tip"), false)

					PlayerPrefs = var_2_10001

					local var_7_1 = var_2_10001.SetInt

					string = var_2

					var_7_1(var_2.format("cursing_%d_task_week_%d", arg_6_0.activity.id, iter_6_0), 1)

					arg_6_0.weekToggle = iter_6_0
					arg_6_0.contextData.weekToggle = iter_6_0

					local var_7_2 = arg_6_0

					underscore = var_2
					var_7_2.tempTaskGroup = var_2.map(iter_6_1.task_group, function(arg_8_0)
						underscore = var_3_10001

						return var_3_10001.map(arg_8_0, function(arg_9_0)
							assert = var_4_10001

							local var_9_0 = var_6_0

							var_4_10001(var_2.getTaskVO(var_9_0, arg_9_0), "without this task:" .. arg_9_0)

							local var_9_1 = var_6_0

							return var_1.getTaskVO(var_9_1, arg_9_0)
						end)
					end)
					table = var_7_2

					local var_7_3 = var_7_2.sort
					local var_7_4 = arg_6_0.tempTaskGroup

					CompareFuncs = var_3

					var_7_3(var_7_4, var_3({
						function(arg_10_0)
							underscore = var_3_10001

							return var_3_10001.all(arg_10_0, function(arg_11_0)
								return arg_11_0:isReceive()
							end) and 1 or 0
						end,
						function(arg_12_0)
							return arg_12_0[1].id
						end
					}))

					local var_7_5 = arg_6_0.taskGroupItemList

					var_1.align(var_7_5, #arg_6_0.tempTaskGroup)
				end

				return
			end

			SFX_PANEL = var_1_10013

			var_9(var_6_6, var_1_10011, var_1_10012, var_1_10013)

			if var_6_2:Find("mask") then
				setActive = var_9
				var_1_10011 = var_6_2

				var_9(var_6_2.Find(var_1_10011, "mask"), iter_6_1.isLock)
			end
		end
	end

	underscore = var_3

	local var_6_7 = var_3.keys(arg_6_0.taskGroupList)

	table = var_4

	var_4.sort(var_6_7, function(arg_13_0, arg_13_1)
		return arg_13_0 < arg_13_1
	end)

	local var_6_8

	if arg_6_0.contextData.weekToggle and not arg_6_0.taskGroupList[arg_6_0.contextData.weekToggle].isLock then
		arg_6_0.weekToggle = arg_6_0.contextData.weekToggle
		var_6_8 = arg_6_0.contextData
		var_6_8.weekToggle = nil
	else
		table = var_6_8
		arg_6_0.weekToggle = var_6_8.remove(var_6_7, 1)
		ipairs = var_6_8

		for iter_6_2, iter_6_3 in var_6_8(var_6_7) do
			if arg_6_0.taskGroupList[iter_6_3].isLock then
				break
			else
				underscore = var_10

				local var_6_9 = var_10.any

				underscore = var_1_10011

				if var_6_9(var_1_10011.flatten(var_9.task_group), function(arg_14_0)
					local var_14_0 = var_6_0
					local var_14_1

					var_14_1 = var_1.getTaskVO(var_14_0, arg_14_0) and not var_1:isReceive()

					return var_14_1
				end) then
					arg_6_0.weekToggle = iter_6_3

					break
				end
			end
		end
	end

	triggerToggle = var_6_8

	local var_6_10 = arg_6_0.togglesTF

	var_6_8(var_5.Find(var_6_10, arg_6_0.weekToggle), true)

	ipairs = var_6_8

	for iter_6_4, iter_6_5 in var_6_8(arg_6_0.taskGroupList) do
		local var_6_11 = arg_6_0.togglesTF
		local var_6_12 = var_9.Find(var_6_11, iter_6_4)

		SetCompomentEnabled = var_6_11

		local var_6_13 = var_6_12

		typeof = var_1_10012
		Toggle = var_1_10013

		var_6_11(var_6_13, var_1_10012(var_1_10013), not iter_6_5.isLock)

		if not iter_6_5.isLock then
			setGray = var_10

			local var_6_14 = var_6_12

			underscore = var_1_10012
			var_1_10012 = var_1_10012.all
			underscore = var_1_10013

			var_10(var_6_14, var_1_10012(var_1_10013.flatten(iter_6_5.task_group), function(arg_15_0)
				local var_15_0 = var_6_0
				local var_15_1

				var_15_1 = var_1.getTaskVO(var_15_0, arg_15_0) and var_1:isReceive()

				return var_15_1
			end))
		end
	end

	arg_6_0:Show()

	return
end

function var_0_1.UpdateTaskGroup(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_1.Find(var_16_0, "info")

	LoadImageSpriteAtlasAsync = var_16_0

	local var_16_2 = "ui/worldcruiseui_atlas"

	tostring = var_1_10006

	var_16_0(var_16_2, var_1_10006(arg_16_0.weekToggle), var_16_1:Find("week"), true)

	local var_16_3 = {}

	ipairs = var_16_2

	for iter_16_0, iter_16_1 in var_16_2(arg_16_2) do
		if not iter_16_1:isReceive() then
			table = var_10

			var_10.insert(var_16_3, iter_16_1)
		end
	end

	triggerToggle = var_5

	var_5(var_16_1, false)

	local var_16_4 = #var_16_3

	if 0 < var_16_4 then
		table = var_16_4

		local var_16_5

		if not var_16_4.remove(var_16_3, 1) then
			var_16_5 = arg_16_2[#arg_16_2]
		end

		SetCompomentEnabled = var_6

		local var_16_6 = var_16_1

		typeof = iter_16_0
		Toggle = iter_16_1

		var_6(var_16_6, iter_16_0(iter_16_1), #var_16_3 > 0)
		arg_16_0:UpdateTaskDisplay(var_16_1, var_16_5)

		setActive = var_6

		var_6(var_16_1:Find("quick"), var_16_5:getConfig("quick_finish") > 0 and var_16_5:getTaskStatus() == 0)

		onButton = var_6

		local var_16_7 = arg_16_0
		local var_16_8 = var_16_1:Find("quick")

		local function var_16_9()
			local var_17_0 = arg_16_0

			var_0.OnQuickClick(var_17_0, var_16_5)

			return
		end

		SFX_CONFIRM = var_10

		var_6(var_16_7, var_16_8, var_16_9, var_10)

		setActive = var_6

		var_6(var_16_1:Find("toggle_mark"), #var_16_3 > 0)

		if #var_16_3 > 0 then
			local var_16_10 = arg_16_1
			local var_16_11 = arg_16_1.Find(var_16_10, "content")

			UIItemList = var_16_10

			local var_16_12 = var_16_10.New(var_16_11, var_16_11:Find("extend_tpl"))

			var_7.make(var_16_12, function(arg_18_0, arg_18_1, arg_18_2)
				arg_18_1 = arg_18_1 + 1
				UIItemList = var_2_10003

				if arg_18_0 == var_2_10003.EventUpdate then
					local var_18_0 = arg_16_0

					var_3.UpdateTaskDisplay(var_18_0, arg_18_2, var_16_3[arg_18_1])
				end

				return
			end)
			var_7:align(#var_16_3)
		end

		return
	end
end

function var_0_1.UpdateTaskDisplay(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2:getProgress()
	local var_19_1 = arg_19_2
	local var_19_2 = arg_19_2.getConfig(var_19_1, "target_num")

	setSlider = var_19_1

	var_19_1(arg_19_1:Find("Slider"), 0, var_19_2, var_19_0)

	setText = var_19_1

	local var_19_3 = arg_19_1
	local var_19_4 = arg_19_1.Find(var_19_3, "desc")

	string = var_19_3

	var_19_1(var_19_4, var_19_3.format("%s(%d/%d)", arg_19_2:getConfig("desc"), var_19_0, var_19_2))

	Drop = var_19_1

	local var_19_5 = var_19_1.Create(arg_19_2:getConfig("award_display")[1])

	updateDrop = var_6

	var_6(arg_19_1:Find("outline/mask/IconTpl"), var_19_5)

	onButton = var_6

	local var_19_6 = arg_19_0
	local var_19_7 = arg_19_1:Find("outline/mask/IconTpl")

	local function var_19_8()
		local var_20_0 = arg_19_0
		local var_20_1 = var_0.emit

		BaseUI = var_2_10002

		var_20_1(var_20_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_19_5
		})

		return
	end

	SFX_PANEL = var_10

	var_6(var_19_6, var_19_7, var_19_8, var_10)

	local var_19_9

	if arg_19_0.finishAll then
		var_19_9 = 2
	else
		var_19_6 = arg_19_2
		var_19_9 = arg_19_2.getTaskStatus(var_19_6)
	end

	setActive = var_19_6

	var_19_6(arg_19_1:Find("go"), var_19_9 == 0)

	setActive = var_19_6

	var_19_6(arg_19_1:Find("get"), var_19_9 == 1)

	setActive = var_19_6

	var_19_6(arg_19_1:Find("got"), var_19_9 == 2)

	setActive = var_19_6

	var_19_6(arg_19_1:Find("outline/mask/IconTpl/mask"), var_19_9 == 2)

	onButton = var_19_6

	local var_19_10 = arg_19_0
	local var_19_11 = arg_19_1:Find("go")

	local function var_19_12()
		local var_21_0 = arg_19_0
		local var_21_1 = var_0.emit

		WorldCruiseMediator = var_2_10002

		var_21_1(var_21_0, var_2_10002.ON_TASK_GO, arg_19_2)

		return
	end

	SFX_PANEL = var_11

	var_19_6(var_19_10, var_19_11, var_19_12, var_11)

	onButton = var_19_6

	local var_19_13 = arg_19_0
	local var_19_14 = arg_19_1:Find("get")

	local function var_19_15()
		local var_22_0 = arg_19_0
		local var_22_1 = var_0.emit

		WorldCruiseMediator = var_2_10002

		var_22_1(var_22_0, var_2_10002.ON_TASK_SUBMIT, arg_19_2)

		return
	end

	SFX_CONFIRM = var_11

	var_19_6(var_19_13, var_19_14, var_19_15, var_11)

	setActive = var_19_6

	var_19_6(arg_19_1:Find("quick"), arg_19_2:getConfig("quick_finish") > 0 and arg_19_2:getTaskStatus() == 0)

	onButton = var_19_6

	local var_19_16 = arg_19_0
	local var_19_17 = arg_19_1:Find("quick")

	local function var_19_18()
		local var_23_0 = arg_19_0

		var_0.OnQuickClick(var_23_0, arg_19_2)

		return
	end

	SFX_CONFIRM = var_11

	var_19_6(var_19_16, var_19_17, var_19_18, var_11)

	return
end

function var_0_1.OnQuickClick(arg_24_0, arg_24_1)
	getProxy = var_1_10002
	BagProxy = var_1_10003

	local var_24_0 = var_1_10002(var_1_10003)
	local var_24_1 = var_2.getItemCountById

	Item = var_1_10004

	local var_24_2 = var_24_1(var_24_0, var_1_10004.QUICK_TASK_PASS_TICKET_ID)
	local var_24_3 = arg_24_1

	if var_24_2 < arg_24_1.getConfig(var_24_3, "quick_finish") then
		pg = var_24_3

		local var_24_4 = var_24_3.NewStyleMsgboxMgr.GetInstance()

		var_24_3 = var_24_3.Show
		pg = var_1_10006
		var_1_10006 = var_1_10006.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX

		local var_24_5 = {}

		i18n = var_1_10008
		var_24_5.contentText = var_1_10008("battlepass_task_quickfinish2", var_3 - var_24_2)

		function var_24_5.onConfirm()
			shoppingBatchNewStyle = var_2_10000
			Goods = var_2_10001

			local var_25_0 = var_2_10001.CRUISE_QUICK_TASK_TICKET_ID
			local var_25_1 = {}

			Item = var_2_10003
			var_25_1.id = var_2_10003.QUICK_TASK_PASS_TICKET_ID

			var_2_10000(var_25_0, var_25_1, 20, "build_ship_quickly_buy_stone")

			return
		end

		var_24_3(var_24_4, var_1_10006, var_24_5)
	else
		pg = var_24_3

		local var_24_6 = var_24_3.NewStyleMsgboxMgr.GetInstance()
		local var_24_7 = var_4.Show

		pg = var_1_10006

		local var_24_8 = var_1_10006.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
		local var_24_9 = {}

		i18n = var_1_10008
		var_24_9.contentText = var_1_10008("battlepass_task_quickfinish1", var_3, var_24_2)

		function var_24_9.onConfirm()
			local var_26_0 = arg_24_0
			local var_26_1 = var_0.emit

			WorldCruiseMediator = var_2_10002

			var_26_1(var_26_0, var_2_10002.ON_TASK_QUICK_SUBMIT, arg_24_1)

			return
		end

		var_24_7(var_24_6, var_24_8, var_24_9)
	end

	return
end

function var_0_1.OnDestroy(arg_27_0)
	return
end

return var_0_1
