class = var_0_10000

local var_0_0 = "BlackFridaySalesTaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BlackFridaySalesTaskPage"
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
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10003

	local var_3_2 = var_3_1(var_3_0, var_1_10003.ACTIVITY_TYPE_TASKS)

	ipairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_3_2) do
		if iter_3_1:getConfig("config_client").blackFriday then
			arg_3_0.activity = iter_3_1

			break
		end
	end

	local var_3_3 = arg_3_0.activity

	arg_3_0.taskGroupList = var_2.getConfig(var_3_3, "config_client").taskGroup
	getProxy = var_2
	TaskProxy = var_3_3
	arg_3_0.taskProxy = var_2(var_3_3)
	arg_3_0.page = var_0_1.TYPE_ALL

	return
end

function var_0_1.initUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.getAllBtn = var_1.Find(var_4_0, "get_all")

	local var_4_1 = arg_4_0._tf

	arg_4_0.extendTpl = var_1.Find(var_4_1, "extend_tpl")

	local var_4_2 = arg_4_0._tf

	arg_4_0.content = var_1.Find(var_4_2, "view/content")
	UIItemList = var_1

	local var_4_3 = var_1.New
	local var_4_4 = arg_4_0.content
	local var_4_5 = arg_4_0.content

	arg_4_0.taskGroupItemList = var_4_3(var_4_4, var_3.Find(var_4_5, "tpl"))
	setActive = var_1

	var_1(arg_4_0.getAllBtn, false)

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getAllBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BlackFridaySalesMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.TASK_SUBMIT_ONESTEP, arg_5_0.finishVOList)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

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

	return
end

function var_0_1.updateTaskGroup(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.showVOGroup[arg_8_2]
	local var_8_1 = arg_8_1:Find("info")
	local var_8_2 = {}

	ipairs = var_6

	for iter_8_0, iter_8_1 in var_6(var_8_0) do
		if not iter_8_1:isReceive() then
			table = var_11

			var_11.insert(var_8_2, iter_8_1)
		end
	end

	triggerToggle = var_6

	var_6(var_8_1, false)

	local var_8_3 = #var_8_2

	if 0 < var_8_3 then
		table = var_8_3

		local var_8_4

		if not var_8_3.remove(var_8_2, 1) then
			var_8_4 = var_8_0[#var_8_0]
		end

		SetCompomentEnabled = var_7

		local var_8_5 = var_8_1

		typeof = iter_8_0
		Toggle = iter_8_1

		local var_8_6 = iter_8_0(iter_8_1)
		local var_8_7 = #var_8_2

		var_7(var_8_5, var_8_6, 0 < var_8_7)
		arg_8_0:updateTaskDisplay(var_8_1, var_8_4)

		setActive = var_7

		local var_8_8 = var_8_1:Find("toggle_mark")
		local var_8_9 = #var_8_2

		var_7(var_8_8, 0 < var_8_9)

		local var_8_10 = var_8_4
		local var_8_11 = var_8_4.getTaskStatus(var_8_10)

		GetOrAddComponent = var_8_10

		local var_8_12 = arg_8_1

		typeof = var_10
		CanvasGroup = var_11
		var_8_10(var_8_12, var_10(var_11)).alpha = var_8_11 == 2 and 0.5 or 1
		setActive = var_9

		var_9(var_8_1:Find("mask"), var_8_11 == 2)

		setActive = var_9

		var_9(var_8_1:Find("bg/receive"), var_8_11 == 1)

		onToggle = var_9

		var_9(arg_8_0, var_8_1, function(arg_9_0)
			if arg_9_0 then
				local var_9_0 = arg_8_1

				var_2_10001 = var_2_10001.Find(var_9_0, "content")
				UIItemList = var_9_0

				local var_9_1 = var_9_0.New(var_2_10001, arg_8_0.extendTpl)

				var_2.make(var_9_1, function(arg_10_0, arg_10_1, arg_10_2)
					arg_10_1 = arg_10_1 + 1
					UIItemList = var_3_10003

					if arg_10_0 == var_3_10003.EventUpdate then
						local var_10_0 = arg_8_0

						var_3.updateTaskDisplay(var_10_0, arg_10_2, var_8_2[arg_10_1])
					end

					return
				end)
				var_2:align(#var_8_2)

				scrollTo = var_3

				var_3(arg_8_0.content, 0, 1 - (arg_8_2 - 1) / (#arg_8_0.showVOGroup + #var_8_2 - 4))
			else
				removeAllChildren = var_2_10001

				local var_9_2 = arg_8_1

				var_2_10001(var_2.Find(var_9_2, "content"))
			end

			return
		end)

		return
	end
end

function var_0_1.updateTaskDisplay(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getProgress()
	local var_11_1 = arg_11_2
	local var_11_2 = arg_11_2.getConfig(var_11_1, "target_num")

	setSlider = var_11_1

	var_11_1(arg_11_1:Find("Slider"), 0, var_11_2, var_11_0)

	local var_11_3 = arg_11_2:getConfig("award_display")[1]
	local var_11_4 = {
		type = var_11_3[1],
		id = var_11_3[2],
		count = var_11_3[3]
	}

	updateDrop = var_6

	var_6(arg_11_1:Find("IconTpl"), var_11_4)

	onButton = var_6

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_1:Find("IconTpl")

	local function var_11_7()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_DROP, var_11_4)

		return
	end

	SFX_PANEL = var_10

	var_6(var_11_5, var_11_6, var_11_7, var_10)

	local var_11_8 = arg_11_2
	local var_11_9 = arg_11_2.getTaskStatus(var_11_8)

	setActive = var_11_8

	var_11_8(arg_11_1:Find("go"), var_11_9 == 0)

	setActive = var_11_8

	var_11_8(arg_11_1:Find("get"), var_11_9 == 1)

	setActive = var_11_8

	var_11_8(arg_11_1:Find("got"), var_11_9 == 2)

	setText = var_11_8

	local var_11_10 = arg_11_1
	local var_11_11 = arg_11_1.Find(var_11_10, "desc")

	setColorStr = var_11_10

	var_11_8(var_11_11, var_11_10(arg_11_2:getConfig("desc"), arg_11_0:getColor(var_0_1.TXT_DESC, var_11_9)))

	setText = var_11_8

	local var_11_12 = arg_11_1
	local var_11_13 = arg_11_1.Find(var_11_12, "Slider/Text")

	setColorStr = var_11_12

	local var_11_14 = var_11_12(var_11_0, arg_11_0:getColor(var_0_1.TXT_CURRENT_NUM, var_11_9))

	setColorStr = var_10

	var_11_8(var_11_13, var_11_14 .. var_10("/" .. var_11_2, arg_11_0:getColor(var_0_1.TXT_TARGET_NUM, var_11_9)))

	onButton = var_11_8

	local var_11_15 = arg_11_0
	local var_11_16 = arg_11_1:Find("go")

	local function var_11_17()
		local var_13_0 = arg_11_0
		local var_13_1 = var_0.emit

		BlackFridaySalesMediator = var_2_10002

		var_13_1(var_13_0, var_2_10002.TASK_GO, arg_11_2)

		return
	end

	SFX_PANEL = var_11

	var_11_8(var_11_15, var_11_16, var_11_17, var_11)

	onButton = var_11_8

	local var_11_18 = arg_11_0
	local var_11_19 = arg_11_1:Find("get")

	local function var_11_20()
		local var_14_0 = arg_11_0
		local var_14_1 = var_0.emit

		BlackFridaySalesMediator = var_2_10002

		var_14_1(var_14_0, var_2_10002.TASK_SUBMIT, arg_11_2)

		return
	end

	SFX_CONFIRM = var_11

	var_11_8(var_11_18, var_11_19, var_11_20, var_11)

	return
end

function var_0_1.getColor(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == var_0_1.TXT_DESC then
		return arg_15_2 == 1 and "#393a3c" or "#ffffff"
	elseif arg_15_1 == var_0_1.TXT_CURRENT_NUM then
		return "#30ec80"
	elseif arg_15_1 == var_0_1.TXT_TARGET_NUM then
		return "#393a3c"
	end

	return
end

function var_0_1.filterAll(arg_16_0)
	underscore = var_1_10001
	arg_16_0.taskVOGroup = var_1_10001.map(arg_16_0.taskGroupList, function(arg_17_0)
		underscore = var_2_10001

		return var_2_10001.map(arg_17_0, function(arg_18_0)
			assert = var_3_10001

			local var_18_0 = arg_16_0.taskProxy

			var_3_10001(var_2.getTaskVO(var_18_0, arg_18_0), "without this task:" .. arg_18_0)

			local var_18_1 = arg_16_0.taskProxy

			return var_1.getTaskVO(var_18_1, arg_18_0)
		end)
	end)
	arg_16_0.showVOGroup = arg_16_0.taskVOGroup

	return
end

function var_0_1.updataTaskList(arg_19_0)
	table = var_1_10001

	local var_19_0 = var_1_10001.sort
	local var_19_1 = arg_19_0.showVOGroup

	CompareFuncs = var_1_10003

	var_19_0(var_19_1, var_1_10003({
		function(arg_20_0)
			ipairs = var_2_10001

			for iter_20_0, iter_20_1 in var_2_10001(arg_20_0) do
				if iter_20_1:getTaskStatus() == 1 then
					return 0
				end
			end

			underscore = var_1

			return var_1.all(arg_20_0, function(arg_21_0)
				return arg_21_0:isReceive()
			end) and 2 or 1
		end,
		function(arg_22_0)
			return arg_22_0[1].id
		end
	}))

	local var_19_2 = arg_19_0.taskGroupItemList

	var_1.align(var_19_2, #arg_19_0.showVOGroup)

	return
end

function var_0_1.onUpdateTask(arg_23_0)
	arg_23_0:filterAll()
	arg_23_0:updataTaskList()
	arg_23_0:updataGetAllBtn()

	return
end

function var_0_1.updataGetAllBtn(arg_24_0)
	return
end

function var_0_1.isTip(arg_25_0)
	if arg_25_0.finishVOList then
		local var_25_0 = #arg_25_0.finishVOList

		return 0 < var_25_0
	else
		local var_25_1

		getProxy = var_1_10002
		ActivityProxy = var_1_10003

		local var_25_2 = var_1_10002(var_1_10003)
		local var_25_3 = var_2.getActivitiesByType

		ActivityConst = var_1_10004

		local var_25_4 = var_25_3(var_25_2, var_1_10004.ACTIVITY_TYPE_TASKS)

		ipairs = var_25_2

		for iter_25_0, iter_25_1 in var_25_2(var_25_4) do
			if iter_25_1:getConfig("config_client").blackFriday then
				var_25_1 = iter_25_1

				break
			end
		end

		if var_25_1 then
			local var_25_5 = var_25_1

			if not var_25_1.isEnd(var_25_5) then
				getProxy = var_3
				TaskProxy = var_25_5

				local var_25_6 = var_3(var_25_5)
				local var_25_7 = var_25_1
				local var_25_8 = var_25_1.getConfig(var_25_7, "config_client").taskGroup

				ipairs = var_25_7

				for iter_25_2, iter_25_3 in var_25_7(var_25_8) do
					ipairs = var_1_10010

					for iter_25_4, iter_25_5 in var_1_10010(iter_25_3) do
						assert = var_1_10015

						var_1_10015(var_25_6:getTaskVO(iter_25_5), "without this task:" .. iter_25_5)

						local var_25_9 = var_25_6:getTaskVO(iter_25_5)

						if var_1_10015.getTaskStatus(var_25_9) == 1 then
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

function var_0_1.OnDestroy(arg_26_0)
	return
end

return var_0_1
