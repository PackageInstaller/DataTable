class = var_0_10000

local var_0_0 = "LevelOpenActPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "AD/task_list/content")

	UIItemList = var_1_0
	arg_1_0.uiList = var_1_0.New(var_1_1, var_1_1:Find("tpl"))

	local var_1_2 = arg_1_0.uiList

	var_2.make(var_1_2, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateTask(var_2_0, arg_2_2, arg_1_0.taskVOs[arg_2_1 + 1])
		end

		return
	end)

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_data")[1][1]

	getProxy = var_4
	TaskProxy = var_1_10005

	local var_3_2 = var_4(var_1_10005)

	if not var_4.getTaskVO(var_3_2, var_3_1) then
		pg = var_3_2

		local var_3_3 = var_3_2.m02
		local var_3_4 = var_5.sendNotification

		GAME = var_1_10007

		var_3_4(var_3_3, var_1_10007.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = var_1.id
		})

		return true
	else
		return false
	end

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	underscore = var_1_10002

	local var_4_1 = var_1_10002.map
	local var_4_2 = arg_4_0.activity

	arg_4_0.taskVOs = var_4_1(var_3.getConfig(var_4_2, "config_data")[1], function(arg_5_0)
		local var_5_0 = var_4_0

		return var_1.getTaskVO(var_5_0, arg_5_0)
	end)
	table = var_2

	local var_4_3 = var_2.sort
	local var_4_4 = arg_4_0.taskVOs

	CompareFuncs = var_4

	var_4_3(var_4_4, var_4({
		function(arg_6_0)
			if arg_6_0:isReceive() then
				return 2
			elseif arg_6_0:isFinish() then
				return 0
			else
				return 1
			end

			return
		end
	}))

	local var_4_5 = arg_4_0.uiList

	var_2.align(var_4_5, #arg_4_0.taskVOs)

	return
end

function var_0_1.UpdateTask(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2
	local var_7_1 = arg_7_2.getTaskStatus(var_7_0)

	setImageAlpha = var_7_0

	var_7_0(arg_7_1:Find("bg"), var_7_1 == 2 and 0.5 or 1)

	eachChild = var_7_0

	var_7_0(arg_7_1:Find("status"), function(arg_8_0)
		setActive = var_2_10001

		var_2_10001(arg_8_0, arg_8_0:GetSiblingIndex() == var_7_1)

		return
	end)

	local var_7_2 = arg_7_1
	local var_7_3 = arg_7_1.Find(var_7_2, "canvas")

	setCanvasGroupAlpha = var_7_2

	var_7_2(var_7_3, var_7_1 == 2 and 0.2 or 1)

	local var_7_4 = arg_7_2
	local var_7_5 = arg_7_2.getConfig(var_7_4, "desc")

	if var_7_1 == 2 then
		setSlider = var_7_4

		var_7_4(var_7_3:Find("progress"), 0, 1, 1)
	else
		var_7_4 = arg_7_2:getProgress()

		local var_7_6 = arg_7_2:getConfig("target_num")
		local var_7_7 = var_7_5
		local var_7_8 = " "

		setColorStr = var_1_10010

		local var_7_9 = "(" .. var_7_4 .. "/" .. var_7_6 .. ")"

		COLOR_RED = var_1_10012
		var_7_5 = var_7_7 .. var_7_8 .. var_1_10010(var_7_9, var_1_10012)
		setSlider = var_7_7

		var_7_7(var_7_3:Find("progress"), 0, var_7_6, var_7_4)
	end

	setText = var_7_4

	var_7_4(arg_7_1:Find("canvas/Text"), var_7_5)

	underscore = var_7_4

	local var_7_10 = var_7_4.rest(arg_7_2:getConfig("award_display"), 1)

	while #var_7_10 > 3 do
		table = var_7

		var_7.remove(var_7_10)
	end

	UIItemList = var_7

	local var_7_11 = var_7.New(var_7_3:Find("items"), var_7_3:Find("items/IconTpl"))

	var_7.make(var_7_11, function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_1 = arg_9_1 + 1
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = var_7_10[arg_9_1]
			local var_9_1 = {
				type = var_9_0[1],
				id = var_9_0[2],
				count = var_9_0[3]
			}

			updateDrop = var_5

			var_5(arg_9_2, var_9_1)

			onButton = var_5

			local var_9_2 = arg_7_0
			local var_9_3 = arg_9_2

			local function var_9_4()
				local var_10_0 = arg_7_0
				local var_10_1 = var_0.emit

				BaseUI = var_3_10002

				var_10_1(var_10_0, var_3_10002.ON_DROP, var_9_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_9_2, var_9_3, var_9_4, var_2_10009)
		end

		return
	end)
	var_7:align(#var_7_10)

	if var_7_1 == 2 then
		removeOnButton = var_8

		var_8(arg_7_1)
	elseif var_7_1 == 1 then
		onButton = var_8

		local var_7_12 = arg_7_0
		local var_7_13 = arg_7_1

		local function var_7_14()
			local var_11_0 = arg_7_0
			local var_11_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_11_1(var_11_0, var_2_10002.ON_TASK_SUBMIT, arg_7_2)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_7_12, var_7_13, var_7_14, var_1_10012)
	elseif var_7_1 == 0 then
		onButton = var_8

		local var_7_15 = arg_7_0
		local var_7_16 = arg_7_1

		local function var_7_17()
			local var_12_0 = arg_7_0
			local var_12_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_12_1(var_12_0, var_2_10002.ON_TASK_GO, arg_7_2)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_7_15, var_7_16, var_7_17, var_1_10012)
	else
		assert = var_8

		var_8(false, "task status error:" .. arg_7_2.id)
	end

	return
end

return var_0_1
