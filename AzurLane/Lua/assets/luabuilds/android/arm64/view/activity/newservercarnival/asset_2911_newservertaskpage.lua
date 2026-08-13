class = var_0_10000

local var_0_0 = "NewServerTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewServerTaskPage"
end

var_0_1.TYPE_ALL = 1
var_0_1.TYPE_DAILY = 2
var_0_1.TYPE_TARGET = 3
var_0_1.TXT_DESC = 1
var_0_1.TXT_CURRENT_NUM = 2
var_0_1.TXT_TARGET_NUM = 3

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:onUpdateTask()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_3_0.activity = var_3_1(var_3_0, var_1_10004.ACTIVITY_TYPE_NEWSERVER_TASK)

	local var_3_2 = arg_3_0.activity

	arg_3_0.taskGroupList = var_1.getConfig(var_3_2, "config_data")
	getProxy = var_1
	TaskProxy = var_3_2
	arg_3_0.taskProxy = var_1(var_3_2)
	arg_3_0.page = var_0_1.TYPE_ALL

	return
end

function var_0_1.initUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.getAllBtn = var_1.Find(var_4_0, "get_all")

	local var_4_1 = arg_4_0._tf

	arg_4_0.extendTpl = var_1.Find(var_4_1, "extend_tpl")

	local var_4_2 = {}
	local var_4_3 = arg_4_0._tf

	var_4_2[1] = var_2.Find(var_4_3, "types/all")

	local var_4_4 = arg_4_0._tf

	var_4_2[2] = var_2.Find(var_4_4, "types/daily")

	local var_4_5 = arg_4_0._tf

	var_4_2[3] = var_2.Find(var_4_5, "types/target")
	arg_4_0.typeToggles = var_4_2

	local var_4_6 = arg_4_0._tf

	arg_4_0.content = var_1.Find(var_4_6, "view/content")
	UIItemList = var_1

	local var_4_7 = var_1.New
	local var_4_8 = arg_4_0.content
	local var_4_9 = arg_4_0.content

	arg_4_0.taskGroupItemList = var_4_7(var_4_8, var_4.Find(var_4_9, "tpl"))

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getAllBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		NewServerCarnivalMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.TASK_SUBMIT_ONESTEP, arg_5_0.finishVOList)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	local var_5_3 = arg_5_0.taskGroupItemList

	var_1.make(var_5_3, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_5_0

			var_3.updateTaskGroup(var_7_0, arg_7_2, arg_7_1)
		end

		return
	end)

	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(arg_5_0.typeToggles) do
		onToggle = var_1_10006

		var_1_10006(arg_5_0, iter_5_1, function(arg_8_0)
			if arg_8_0 then
				if iter_5_0 == var_0_1.TYPE_ALL then
					local var_8_0 = arg_5_0

					var_1.filterAll(var_8_0)
				elseif iter_5_0 == var_0_1.TYPE_DAILY then
					local var_8_1 = arg_5_0

					var_1.filterDaily(var_8_1)
				elseif iter_5_0 == var_0_1.TYPE_TARGET then
					local var_8_2 = arg_5_0

					var_1.filterTarget(var_8_2)
				end

				arg_5_0.page = iter_5_0
			end

			local var_8_3 = arg_5_0

			var_1.updataTaskList(var_8_3)

			return
		end)
	end

	return
end

function var_0_1.updateTaskGroup(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.showVOGroup[arg_9_2]
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.Find(var_9_1, "info")
	local var_9_3 = {}

	ipairs = var_9_1

	for iter_9_0, iter_9_1 in var_9_1(var_9_0) do
		var_1_10013 = iter_9_1

		if not iter_9_1.isReceive(var_1_10013) then
			table = var_11

			var_11.insert(var_9_3, iter_9_1)
		end
	end

	triggerToggle = var_6

	var_6(var_9_2, false)

	local var_9_4 = #var_9_3

	if 0 < var_9_4 then
		table = var_9_4

		local var_9_5

		if not var_9_4.remove(var_9_3, 1) then
			var_9_5 = var_9_0[#var_9_0]
		end

		SetCompomentEnabled = var_7

		local var_9_6 = var_9_2

		typeof = iter_9_1
		Toggle = var_1_10012

		var_7(var_9_6, iter_9_1(var_1_10012), #var_9_3 > 0)
		arg_9_0:updateTaskDisplay(var_9_2, var_9_5)

		setActive = var_7

		local var_9_7 = var_9_2:Find("toggle_mark")
		local var_9_8 = #var_9_3

		var_7(var_9_7, 0 < var_9_8)

		local var_9_9 = var_9_5:getTaskStatus()

		GetOrAddComponent = var_8

		local var_9_10 = arg_9_1

		typeof = var_11
		CanvasGroup = var_1_10013
		var_8(var_9_10, var_11(var_1_10013)).alpha = var_9_9 == 2 and 0.5 or 1
		setActive = var_9

		var_9(var_9_2:Find("mask"), var_9_9 == 2)

		setActive = var_9

		var_9(var_9_2:Find("bg/receive"), var_9_9 == 1)

		setActive = var_9

		local var_9_11 = var_9_2
		local var_9_12 = var_9_2.Find(var_9_11, "tag/tag_daily")
		local var_9_13 = var_9_5:getConfig("type")

		Task = var_9_11

		var_9(var_9_12, var_9_13 == var_9_11.TYPE_ACTIVITY_ROUTINE)

		setActive = var_9

		local var_9_14 = var_9_2
		local var_9_15 = var_9_2.Find(var_9_14, "tag/tag_target")
		local var_9_16 = var_9_5:getConfig("type")

		Task = var_9_14

		var_9(var_9_15, var_9_16 ~= var_9_14.TYPE_ACTIVITY_ROUTINE)

		onToggle = var_9

		var_9(arg_9_0, var_9_2, function(arg_10_0)
			if arg_10_0 then
				local var_10_0 = arg_9_1

				var_2_10001 = var_2_10001.Find(var_10_0, "content")
				UIItemList = var_2_10002

				local var_10_1 = var_2_10002.New(var_2_10001, arg_9_0.extendTpl)

				var_2.make(var_10_1, function(arg_11_0, arg_11_1, arg_11_2)
					arg_11_1 = arg_11_1 + 1
					UIItemList = var_3_10003

					if arg_11_0 == var_3_10003.EventUpdate then
						local var_11_0 = arg_9_0

						var_3.updateTaskDisplay(var_11_0, arg_11_2, var_9_3[arg_11_1])
					end

					return
				end)
				var_2:align(#var_9_3)

				scrollTo = var_3

				var_3(arg_9_0.content, 0, 1 - (arg_9_2 - 1) / (#arg_9_0.showVOGroup + #var_9_3 - 4))
			else
				removeAllChildren = var_2_10001

				local var_10_2 = arg_9_1

				var_2_10001(var_3.Find(var_10_2, "content"))
			end

			return
		end)

		return
	end
end

function var_0_1.updateTaskDisplay(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2
	local var_12_1 = arg_12_2.getProgress(var_12_0)
	local var_12_2 = arg_12_2:getConfig("target_num")

	setSlider = var_12_0

	var_12_0(arg_12_1:Find("Slider"), 0, var_12_2, var_12_1)

	local var_12_3 = arg_12_2:getConfig("award_display")[1]
	local var_12_4 = {
		type = var_12_3[1],
		id = var_12_3[2],
		count = var_12_3[3]
	}

	updateDrop = var_6

	var_6(arg_12_1:Find("IconTpl"), var_12_4)

	onButton = var_6

	local var_12_5 = arg_12_0
	local var_12_6 = arg_12_1
	local var_12_7 = arg_12_1.Find(var_12_6, "IconTpl")

	local function var_12_8()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_12_4)

		return
	end

	SFX_PANEL = var_12_6

	var_6(var_12_5, var_12_7, var_12_8, var_12_6)

	local var_12_9 = arg_12_2:getTaskStatus()

	setActive = var_7

	var_7(arg_12_1:Find("go"), var_12_9 == 0)

	setActive = var_7

	var_7(arg_12_1:Find("get"), var_12_9 == 1)

	setActive = var_7

	var_7(arg_12_1:Find("got"), var_12_9 == 2)

	setText = var_7

	local var_12_10 = arg_12_1:Find("desc")

	setColorStr = var_10

	var_7(var_12_10, var_10(arg_12_2:getConfig("desc"), arg_12_0:getColor(var_0_1.TXT_DESC, var_12_9)))

	setText = var_7

	local var_12_11 = arg_12_1
	local var_12_12 = arg_12_1.Find(var_12_11, "Slider/Text")

	setColorStr = var_10

	local var_12_13 = var_10(var_12_1, arg_12_0:getColor(var_0_1.TXT_CURRENT_NUM, var_12_9))

	setColorStr = var_12_11

	var_7(var_12_12, var_12_13 .. var_12_11("/" .. var_12_2, arg_12_0:getColor(var_0_1.TXT_TARGET_NUM, var_12_9)))

	onButton = var_7

	local var_12_14 = arg_12_0
	local var_12_15 = arg_12_1
	local var_12_16 = arg_12_1.Find(var_12_15, "go")

	local function var_12_17()
		local var_14_0 = arg_12_0
		local var_14_1 = var_0.emit

		NewServerCarnivalMediator = var_2_10003

		var_14_1(var_14_0, var_2_10003.TASK_GO, arg_12_2)

		return
	end

	SFX_PANEL = var_12_15

	var_7(var_12_14, var_12_16, var_12_17, var_12_15)

	onButton = var_7

	local var_12_18 = arg_12_0
	local var_12_19 = arg_12_1
	local var_12_20 = arg_12_1.Find(var_12_19, "get")

	local function var_12_21()
		local var_15_0 = arg_12_0
		local var_15_1 = var_0.emit

		NewServerCarnivalMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.TASK_SUBMIT, arg_12_2)

		return
	end

	SFX_CONFIRM = var_12_19

	var_7(var_12_18, var_12_20, var_12_21, var_12_19)

	return
end

function var_0_1.getColor(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == var_0_1.TXT_DESC then
		return arg_16_2 == 1 and "#63573c" or "#a1976e"
	elseif arg_16_1 == var_0_1.TXT_CURRENT_NUM then
		return arg_16_2 == 1 and "#219215" or "#65D559"
	elseif arg_16_1 == var_0_1.TXT_TARGET_NUM then
		return arg_16_2 == 1 and "#5c4212" or "#ae9363"
	end

	return
end

function var_0_1.filterAll(arg_17_0)
	underscore = var_1_10001
	arg_17_0.taskVOGroup = var_1_10001.map(arg_17_0.taskGroupList, function(arg_18_0)
		underscore = var_2_10001

		return var_2_10001.map(arg_18_0, function(arg_19_0)
			assert = var_3_10001

			local var_19_0 = arg_17_0.taskProxy

			var_3_10001(var_3.getTaskVO(var_19_0, arg_19_0), "without this task:" .. arg_19_0)

			local var_19_1 = arg_17_0.taskProxy

			return var_1.getTaskVO(var_19_1, arg_19_0)
		end)
	end)
	arg_17_0.showVOGroup = arg_17_0.taskVOGroup

	return
end

function var_0_1.filterDaily(arg_20_0)
	underscore = var_1_10001
	arg_20_0.taskVOGroup = var_1_10001.map(arg_20_0.taskGroupList, function(arg_21_0)
		underscore = var_2_10001

		return var_2_10001.map(arg_21_0, function(arg_22_0)
			assert = var_3_10001

			local var_22_0 = arg_20_0.taskProxy

			var_3_10001(var_3.getTaskVO(var_22_0, arg_22_0), "without this task:" .. arg_22_0)

			local var_22_1 = arg_20_0.taskProxy

			return var_1.getTaskVO(var_22_1, arg_22_0)
		end)
	end)
	arg_20_0.showVOGroup = {}
	ipairs = var_1

	for iter_20_0, iter_20_1 in var_1(arg_20_0.taskVOGroup) do
		local var_20_0 = iter_20_1[1]
		local var_20_1 = var_6.getConfig(var_20_0, "type")

		Task = var_1_10007

		if var_20_1 == var_1_10007.TYPE_ACTIVITY_ROUTINE then
			table = var_20_1

			var_20_1.insert(arg_20_0.showVOGroup, iter_20_1)
		end
	end

	return
end

function var_0_1.filterTarget(arg_23_0)
	underscore = var_1_10001
	arg_23_0.taskVOGroup = var_1_10001.map(arg_23_0.taskGroupList, function(arg_24_0)
		underscore = var_2_10001

		return var_2_10001.map(arg_24_0, function(arg_25_0)
			assert = var_3_10001

			local var_25_0 = arg_23_0.taskProxy

			var_3_10001(var_3.getTaskVO(var_25_0, arg_25_0), "without this task:" .. arg_25_0)

			local var_25_1 = arg_23_0.taskProxy

			return var_1.getTaskVO(var_25_1, arg_25_0)
		end)
	end)
	arg_23_0.showVOGroup = {}
	ipairs = var_1

	for iter_23_0, iter_23_1 in var_1(arg_23_0.taskVOGroup) do
		local var_23_0 = iter_23_1[1]
		local var_23_1 = var_6.getConfig(var_23_0, "type")

		Task = var_1_10007

		if var_23_1 ~= var_1_10007.TYPE_ACTIVITY_ROUTINE then
			table = var_23_1

			var_23_1.insert(arg_23_0.showVOGroup, iter_23_1)
		end
	end

	return
end

function var_0_1.updataTaskList(arg_26_0)
	table = var_1_10001

	local var_26_0 = var_1_10001.sort
	local var_26_1 = arg_26_0.showVOGroup

	CompareFuncs = var_1_10004

	var_26_0(var_26_1, var_1_10004({
		function(arg_27_0)
			ipairs = var_2_10001

			for iter_27_0, iter_27_1 in var_2_10001(arg_27_0) do
				if iter_27_1:getTaskStatus() == 1 then
					return 0
				end
			end

			underscore = var_1

			return var_1.all(arg_27_0, function(arg_28_0)
				return arg_28_0:isReceive()
			end) and 2 or 1
		end,
		function(arg_29_0)
			local var_29_0 = arg_29_0[1]
			local var_29_1 = var_1.getConfig(var_29_0, "type")

			Task = var_2_10002

			return var_29_1 ~= var_2_10002.TYPE_ACTIVITY_ROUTINE and 1 or 0
		end,
		function(arg_30_0)
			return arg_30_0[1].id
		end
	}))

	local var_26_2 = arg_26_0.taskGroupItemList

	var_1.align(var_26_2, #arg_26_0.showVOGroup)

	return
end

function var_0_1.onUpdateTask(arg_31_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_31_0.typeToggles[arg_31_0.page], true)
	arg_31_0:updataGetAllBtn()

	return
end

function var_0_1.updataGetAllBtn(arg_32_0)
	arg_32_0.finishVOList = {}
	ipairs = var_1

	for iter_32_0, iter_32_1 in var_1(arg_32_0.taskVOGroup) do
		ipairs = var_1_10006

		for iter_32_2, iter_32_3 in var_1_10006(iter_32_1) do
			if iter_32_3:getTaskStatus() == 1 then
				table = var_11

				var_11.insert(arg_32_0.finishVOList, iter_32_3)
			end
		end
	end

	setActive = var_1

	var_1(arg_32_0.getAllBtn, #arg_32_0.finishVOList > 0)

	return
end

function var_0_1.isTip(arg_33_0)
	local var_33_0

	if arg_33_0.finishVOList then
		var_33_0 = #arg_33_0.finishVOList > 0

		return var_33_0
	else
		getProxy = var_33_0
		ActivityProxy = var_1_10003

		local var_33_1 = var_33_0(var_1_10003)
		local var_33_2 = var_1.getActivityByType

		ActivityConst = var_1_10004

		if var_33_2(var_33_1, var_1_10004.ACTIVITY_TYPE_NEWSERVER_TASK) then
			local var_33_3 = var_1

			if not var_1.isEnd(var_33_3) then
				getProxy = var_2
				TaskProxy = var_33_3

				local var_33_4 = var_2(var_33_3)
				local var_33_5 = var_1:getConfig("config_data")

				ipairs = var_33_3

				for iter_33_0, iter_33_1 in var_33_3(var_33_5) do
					ipairs = var_1_10009

					for iter_33_2, iter_33_3 in var_1_10009(iter_33_1) do
						assert = var_1_10014

						var_1_10014(var_33_4:getTaskVO(iter_33_3), "without this task:" .. iter_33_3)

						local var_33_6 = var_33_4:getTaskVO(iter_33_3)

						if var_1_10014.getTaskStatus(var_33_6) == 1 then
							return true
						end
					end
				end
			end
		end

		return false
	end

	return
end

function var_0_1.OnDestroy(arg_34_0)
	return
end

return var_0_1
