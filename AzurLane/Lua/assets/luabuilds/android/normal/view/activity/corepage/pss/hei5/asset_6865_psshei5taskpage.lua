class = var_0_10000

local var_0_0 = "PSSHei5TaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PSSHei5TaskPage"
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
		var_2_1 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_PT_HEI5)
	end

	arg_2_0.activity = var_2_1
	pairs = var_2_1

	local var_2_2 = arg_2_0.activity

	for iter_2_0, iter_2_1 in var_2_1(var_3.GetHei5Info(var_2_2)) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	arg_2_0.taskGroupList = {}
	pg = var_2

	local var_2_3 = var_2.TimeMgr.GetInstance()
	local var_2_4 = var_2.GetServerDay
	local var_2_5 = arg_2_0.activity
	local var_2_6 = var_2_4(var_2_3, var_4.getStartTime(var_2_5))

	ipairs = var_2_3

	local var_2_7 = arg_2_0.activity

	for iter_2_2, iter_2_3 in var_2_3(var_4.getConfig(var_2_7, "config_data")) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.black_friday_battlepass_task_group[iter_2_3]
		arg_2_0.taskGroupList[var_1_10008.group_mask] = {
			task_group = var_1_10008.task_group,
			isLock = var_2_6 < var_1_10008.group_mask
		}
	end

	updateCrusingHei5ActivityTask = var_3

	var_3(arg_2_0.activity)

	arg_2_0.finishAll = arg_2_0.phase == #arg_2_0.awardList

	return
end

function var_0_1.initTplVar(arg_3_0)
	arg_3_0.btnGoText = "task_go"
	arg_3_0.btnGetText = "task_get"
	arg_3_0.taskDayText = "blackfriday_cruise_task_day"
	arg_3_0.pticonAtlas = "ui/PSSHei5UI_atlas"
	arg_3_0.pticonName = "battlepass_blackfriday"

	return
end

function var_0_1.OnLoaded(arg_4_0)
	arg_4_0:initTplVar()
	arg_4_0:UpdateActivity()

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "frame")

	arg_4_0.togglesTF = var_1.Find(var_4_1, "week_list")

	local var_4_2 = arg_4_0.togglesTF

	arg_4_0.toggleCount = var_2.Find(var_4_2, "count")

	local var_4_3 = var_1:Find("view/content")
	local var_4_4 = var_2.Find(var_4_3, "tpl")

	setText = var_4_3

	local var_4_5 = var_4_4
	local var_4_6 = var_4_4.Find(var_4_5, "info/go/Text")

	i18n = var_4_5

	var_4_3(var_4_6, var_4_5(arg_4_0.btnGoText))

	setText = var_4_3

	local var_4_7 = var_4_4
	local var_4_8 = var_4_4.Find(var_4_7, "info/get/Text")

	i18n = var_4_7

	var_4_3(var_4_8, var_4_7(arg_4_0.btnGetText))

	setText = var_4_3

	local var_4_9 = var_4_4
	local var_4_10 = var_4_4.Find(var_4_9, "info/got/Text")

	i18n = var_4_9

	var_4_3(var_4_10, var_4_9("task_got"))

	UIItemList = var_4_3
	arg_4_0.taskGroupItemList = var_4_3.New(var_2, var_4_4)

	return
end

function var_0_1.OnInit(arg_5_0)
	local var_5_0 = arg_5_0.taskGroupItemList

	var_1.make(var_5_0, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_5_0

			var_3.UpdateTaskGroup(var_6_0, arg_6_2, arg_5_0.tempTaskGroup[arg_6_1])
		end

		return
	end)

	return
end

function var_0_1.Flush(arg_7_0, arg_7_1)
	if arg_7_1 then
		var_1_10003 = arg_7_0

		arg_7_0.UpdateActivity(var_1_10003, arg_7_1)
	end

	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)

	pairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.taskGroupList) do
		local var_7_1

		if iter_7_0 == 0 then
			local var_7_2 = arg_7_0._tf

			var_7_1 = var_9.Find(var_7_2, "frame/" .. iter_7_0)
		else
			local var_7_3 = arg_7_0.toggleCount

			var_7_1 = var_9.Find(var_7_3, iter_7_0)
		end

		if 0 < iter_7_0 then
			setText = var_9
			var_1_10011 = var_7_1

			local var_7_4 = var_7_1.Find(var_1_10011, "off/Text")

			i18n = var_1_10011

			var_9(var_7_4, var_1_10011(arg_7_0.taskDayText, iter_7_0))

			setText = var_9
			var_1_10011 = var_7_1

			local var_7_5 = var_7_1.Find(var_1_10011, "on/Text")

			i18n = var_1_10011

			var_9(var_7_5, var_1_10011(arg_7_0.taskDayText, iter_7_0))
		end

		setActive = var_9
		var_1_10011 = var_7_1

		local var_7_6 = var_7_1.Find(var_1_10011, "tip")

		if not iter_7_1.isLock then
			PlayerPrefs = var_1_10011
			var_1_10011 = var_1_10011.GetInt
			string = var_1_10012

			if var_1_10011(var_1_10012.format("cursing_%d_task_week_%d", arg_7_0.activity.id, iter_7_0), 0) ~= 0 then
				var_1_10011 = false
			else
				var_1_10011 = true
			end

			var_9(var_7_6, var_1_10011)

			onToggle = var_9

			local var_7_7 = arg_7_0

			var_1_10011 = var_7_1

			function var_1_10012(arg_8_0)
				if arg_8_0 then
					setActive = var_2_10001

					local var_8_0 = var_7_1

					var_2_10001(var_2.Find(var_8_0, "tip"), false)

					PlayerPrefs = var_2_10001

					local var_8_1 = var_2_10001.SetInt

					string = var_2

					var_8_1(var_2.format("cursing_%d_task_week_%d", arg_7_0.activity.id, iter_7_0), 1)

					arg_7_0.weekToggle = iter_7_0
					arg_7_0.contextData.weekToggle = iter_7_0

					local var_8_2 = arg_7_0

					underscore = var_2
					var_8_2.tempTaskGroup = var_2.map(iter_7_1.task_group, function(arg_9_0)
						underscore = var_3_10001

						return var_3_10001.map(arg_9_0, function(arg_10_0)
							assert = var_4_10001

							local var_10_0 = var_7_0

							var_4_10001(var_2.getTaskVO(var_10_0, arg_10_0), "without this task:" .. arg_10_0)

							local var_10_1 = var_7_0

							return var_1.getTaskVO(var_10_1, arg_10_0)
						end)
					end)
					table = var_8_2

					local var_8_3 = var_8_2.sort
					local var_8_4 = arg_7_0.tempTaskGroup

					CompareFuncs = var_3

					var_8_3(var_8_4, var_3({
						function(arg_11_0)
							underscore = var_3_10001

							return var_3_10001.all(arg_11_0, function(arg_12_0)
								return arg_12_0:isReceive()
							end) and 1 or 0
						end,
						function(arg_13_0)
							return arg_13_0[1].id
						end
					}))

					local var_8_5 = arg_7_0.taskGroupItemList

					var_1.align(var_8_5, #arg_7_0.tempTaskGroup)
				end

				return
			end

			SFX_PANEL = var_1_10013

			var_9(var_7_7, var_1_10011, var_1_10012, var_1_10013)

			if var_7_1:Find("mask") then
				setActive = var_9
				var_1_10011 = var_7_1

				var_9(var_7_1.Find(var_1_10011, "mask"), iter_7_1.isLock)
			end
		end
	end

	underscore = var_3

	local var_7_8 = var_3.keys(arg_7_0.taskGroupList)

	table = var_4

	var_4.sort(var_7_8, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	local var_7_9

	if arg_7_0.contextData.weekToggle and not arg_7_0.taskGroupList[arg_7_0.contextData.weekToggle].isLock then
		arg_7_0.weekToggle = arg_7_0.contextData.weekToggle
		var_7_9 = arg_7_0.contextData
		var_7_9.weekToggle = nil
	else
		table = var_7_9
		arg_7_0.weekToggle = var_7_9.remove(var_7_8, 1)
		ipairs = var_4

		for iter_7_2, iter_7_3 in var_4(var_7_8) do
			if arg_7_0.taskGroupList[iter_7_3].isLock then
				break
			else
				underscore = var_10

				local var_7_10 = var_10.any

				underscore = var_1_10011

				if var_7_10(var_1_10011.flatten(var_9.task_group), function(arg_15_0)
					local var_15_0 = var_7_0
					local var_15_1

					var_15_1 = var_1.getTaskVO(var_15_0, arg_15_0) and not var_1:isReceive()

					return var_15_1
				end) then
					arg_7_0.weekToggle = iter_7_3

					break
				end
			end
		end
	end

	if arg_7_0.weekToggle == 0 then
		triggerToggle = var_4

		local var_7_11 = arg_7_0._tf

		var_4(var_5.Find(var_7_11, "frame/0"), true)
	else
		triggerToggle = var_4

		local var_7_12 = arg_7_0.toggleCount

		var_4(var_5.Find(var_7_12, arg_7_0.weekToggle), true)
	end

	ipairs = var_4

	for iter_7_4, iter_7_5 in var_4(arg_7_0.taskGroupList) do
		local var_7_13 = arg_7_0.toggleCount
		local var_7_14 = var_9.Find(var_7_13, iter_7_4)

		SetCompomentEnabled = var_7_13

		local var_7_15 = var_7_14

		typeof = var_1_10012
		Toggle = var_1_10013

		var_7_13(var_7_15, var_1_10012(var_1_10013), not iter_7_5.isLock)

		if not iter_7_5.isLock then
			setGray = var_10

			local var_7_16 = var_7_14

			underscore = var_1_10012
			var_1_10012 = var_1_10012.all
			underscore = var_1_10013

			var_10(var_7_16, var_1_10012(var_1_10013.flatten(iter_7_5.task_group), function(arg_16_0)
				local var_16_0 = var_7_0
				local var_16_1

				var_16_1 = var_1.getTaskVO(var_16_0, arg_16_0) and var_1:isReceive()

				return var_16_1
			end))
		end
	end

	arg_7_0:Show()

	return
end

function var_0_1.UpdateTaskGroup(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Find("info")
	local var_17_1 = {}

	ipairs = var_5

	for iter_17_0, iter_17_1 in var_5(arg_17_2) do
		if not iter_17_1:isReceive() then
			table = var_10

			var_10.insert(var_17_1, iter_17_1)
		end
	end

	if #var_17_1 > 0 then
		table = var_5

		local var_17_2

		if not var_5.remove(var_17_1, 1) then
			var_17_2 = arg_17_2[#arg_17_2]
		end

		arg_17_0:UpdateTaskDisplay(var_17_0, var_17_2)

		return
	end
end

function var_0_1.UpdateTaskDisplay(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:getProgress()
	local var_18_1 = arg_18_2
	local var_18_2 = arg_18_2.getConfig(var_18_1, "target_num")

	setText = var_18_1

	local var_18_3 = arg_18_1
	local var_18_4 = arg_18_1.Find(var_18_3, "desc")

	string = var_18_3

	var_18_1(var_18_4, var_18_3.format("%s(%d/%d)", arg_18_2:getConfig("desc"), var_18_0, var_18_2))

	Drop = var_18_1

	local var_18_5 = var_18_1.Create
	local var_18_6 = arg_18_2
	local var_18_7 = var_18_5(arg_18_2.getConfig(var_18_6, "award_display")[1])
	local var_18_8

	if arg_18_0.finishAll then
		var_18_8 = 2
	else
		var_18_6 = arg_18_2
		var_18_8 = arg_18_2.getTaskStatus(var_18_6)
	end

	setActive = var_18_6

	var_18_6(arg_18_1:Find("go"), var_18_8 == 0)

	setActive = var_18_6

	var_18_6(arg_18_1:Find("get"), var_18_8 == 1)

	setActive = var_18_6

	var_18_6(arg_18_1:Find("got"), var_18_8 == 2)

	setText = var_18_6

	local var_18_9 = arg_18_1
	local var_18_10 = arg_18_1.Find(var_18_9, "go/Text")

	i18n = var_18_9

	var_18_6(var_18_10, var_18_9("island_word_go"))

	setText = var_18_6

	local var_18_11 = arg_18_1
	local var_18_12 = arg_18_1.Find(var_18_11, "get/Text")

	i18n = var_18_11

	var_18_6(var_18_12, var_18_11("handbook_research_final_task_btn_claim"))

	setText = var_18_6

	local var_18_13 = arg_18_1
	local var_18_14 = arg_18_1.Find(var_18_13, "got/Text")

	i18n = var_18_13

	var_18_6(var_18_14, var_18_13("handbook_research_final_task_btn_finished"))

	Drop = var_18_6

	local var_18_15 = var_18_6.Create(arg_18_2:getConfig("award_display")[1])

	setText = var_8

	var_8(arg_18_1:Find("icon/num"), "X" .. arg_18_2:getConfig("award_display")[1][3])

	if arg_18_0.pticonAtlas and arg_18_0.pticonName then
		setImageSprite = var_8

		local var_18_16 = arg_18_1
		local var_18_17 = arg_18_1.Find(var_18_16, "icon")

		LoadSprite = var_18_16

		var_8(var_18_17, var_18_16("ui/PSSHei5UI_atlas", "battlepass_blackfriday"), false)
	end

	onButton = var_8

	local var_18_18 = arg_18_0
	local var_18_19 = arg_18_1:Find("icon")

	local function var_18_20()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.emit

		BaseUI = var_2_10002

		var_19_1(var_19_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_18_15
		})

		return
	end

	SFX_PANEL = var_12

	var_8(var_18_18, var_18_19, var_18_20, var_12)

	onButton = var_8

	local var_18_21 = arg_18_0
	local var_18_22 = arg_18_1:Find("go")

	local function var_18_23()
		local var_20_0 = arg_18_0
		local var_20_1 = var_0.emit

		PSSHei5Mediator = var_2_10002

		var_20_1(var_20_0, var_2_10002.ON_TASK_GO, arg_18_2)

		return
	end

	SFX_PANEL = var_12

	var_8(var_18_21, var_18_22, var_18_23, var_12)

	onButton = var_8

	local var_18_24 = arg_18_0
	local var_18_25 = arg_18_1:Find("get")

	local function var_18_26()
		local var_21_0 = arg_18_0
		local var_21_1 = var_0.emit

		PSSHei5Mediator = var_2_10002

		var_21_1(var_21_0, var_2_10002.ON_TASK_SUBMIT, arg_18_2)

		return
	end

	SFX_CONFIRM = var_12

	var_8(var_18_24, var_18_25, var_18_26, var_12)

	return
end

function var_0_1.OnDestroy(arg_22_0)
	return
end

return var_0_1
