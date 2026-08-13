class = var_0_10000

local var_0_0 = "UrExchangeTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	UIItemList = var_1_10001

	local var_1_0 = var_1_10001.New
	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_3.Find(var_1_1, "AD/task_list/content")
	local var_1_3 = arg_1_0._tf

	arg_1_0.uilist = var_1_0(var_1_2, var_4.Find(var_1_3, "AD/task_list/content/tpl"))

	local var_1_4 = arg_1_0._tf

	arg_1_0.getBtn = var_1.Find(var_1_4, "AD/get_btn")

	local var_1_5 = arg_1_0._tf

	arg_1_0.gotBtn = var_1.Find(var_1_5, "AD/got_btn")

	local var_1_6 = arg_1_0._tf

	arg_1_0.unfinishBtn = var_1.Find(var_1_6, "AD/unfinish_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_data")[1][1]

	if not arg_2_0:GetTaskById(var_2_1) then
		pg = var_5

		local var_2_2 = var_5.m02
		local var_2_3 = var_5.sendNotification

		GAME = var_1_10008

		var_2_3(var_2_2, var_1_10008.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = var_1.id
		})

		return true
	else
		return false
	end

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_data")[1]

	_ = var_1_10003

	local var_3_2 = var_1_10003.map(var_3_1, function(arg_4_0)
		local var_4_0 = arg_3_0

		return var_1.GetTaskById(var_4_0, arg_4_0)
	end)

	table = var_3_0

	local var_3_3 = var_3_0.remove(var_3_2, #var_3_2)

	local function var_3_4(arg_5_0)
		if arg_5_0:isFinish() and not arg_5_0:isReceive() then
			return 0
		elseif arg_5_0:isReceive() then
			return 2
		else
			return 1
		end

		return
	end

	table = var_6

	var_6.sort(var_3_2, function(arg_6_0, arg_6_1)
		return var_3_4(arg_6_0) < var_3_4(arg_6_1)
	end)

	local var_3_5 = arg_3_0.uilist

	var_6.make(var_3_5, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_3_0

			var_3.UpdateTask(var_7_0, arg_7_2, var_3_2[arg_7_1 + 1])
		end

		return
	end)

	local var_3_6 = arg_3_0.uilist

	var_6.align(var_3_6, #var_3_2)

	local var_3_7 = var_3_3
	local var_3_8 = var_3_3.isFinish(var_3_7)
	local var_3_9 = var_3_3:isReceive()

	_ = var_3_7

	local var_3_10 = var_3_7.all(var_3_2, function(arg_8_0)
		local var_8_0

		if arg_8_0:isFinish() then
			var_8_0 = arg_8_0:isReceive()
		end

		return var_8_0
	end)
	local var_3_11 = var_3_8 and not var_3_9 and var_3_10

	onButton = var_10

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.getBtn

	local function var_3_14()
		if var_3_11 then
			local var_9_0 = arg_3_0
			local var_9_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_9_1(var_9_0, var_2_10003.ON_TASK_SUBMIT, var_3_3)
		end

		return
	end

	SFX_PANEL = var_1_10015

	var_10(var_3_12, var_3_13, var_3_14, var_1_10015)

	setActive = var_10

	var_10(arg_3_0.getBtn, var_3_11)

	setActive = var_10

	var_10(arg_3_0.unfinishBtn, not var_3_11 and not var_3_9)

	setActive = var_10

	var_10(arg_3_0.gotBtn, var_3_9)

	return
end

function var_0_1.GetTaskById(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_10_0 = var_1_10002(var_1_10004)
	local var_10_2

	if not var_2.getTaskById(var_10_0, arg_10_1) then
		getProxy = var_10_2
		TaskProxy = var_10_0

		local var_10_1 = var_10_2(var_10_0)

		var_10_2 = var_10_2.getFinishTaskById(var_10_1, arg_10_1)
	end

	return var_10_2
end

function var_0_1.UpdateTask(arg_11_0, arg_11_1, arg_11_2)
	assert = var_1_10003

	var_1_10003(arg_11_2)

	setText = var_1_10003

	var_1_10003(arg_11_1:Find("Text"), arg_11_2:getConfig("desc"))

	local var_11_0 = arg_11_2:getConfig("award_display")[1]

	assert = var_1_10004

	var_1_10004(var_11_0, arg_11_2.id)

	assert = var_1_10004

	var_1_10004(var_11_0)

	local var_11_1 = {
		type = var_11_0[1],
		id = var_11_0[2],
		count = var_11_0[3]
	}
	local var_11_2 = arg_11_1:Find("item")

	updateDrop = var_6

	var_6(var_11_2, var_11_1)

	onButton = var_6

	local var_11_3 = arg_11_0
	local var_11_4 = var_11_2

	local function var_11_5()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10003

		var_12_1(var_12_0, var_2_10003.ON_DROP, var_11_1)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_11_3, var_11_4, var_11_5, var_1_10011)

	local var_11_6 = arg_11_2
	local var_11_7 = arg_11_2.isFinish(var_11_6)
	local var_11_8 = arg_11_2:isReceive()

	setActive = var_11_6

	var_11_6(arg_11_1:Find("mark"), var_11_7 and not var_11_8)

	if var_11_7 and not var_11_8 then
		onButton = var_11_6

		local var_11_9 = arg_11_0
		local var_11_10 = arg_11_1

		local function var_11_11()
			local var_13_0 = arg_11_0
			local var_13_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_13_1(var_13_0, var_2_10003.ON_TASK_SUBMIT, arg_11_2)

			return
		end

		SFX_PANEL = var_13

		var_11_6(var_11_9, var_11_10, var_11_11, var_13)
	else
		removeOnButton = var_11_6

		var_11_6(arg_11_1)
	end

	setActive = var_11_6

	var_11_6(arg_11_1:Find("progress_finish"), var_11_7 and var_11_8)

	local var_11_12 = arg_11_2
	local var_11_13 = arg_11_2.getProgress(var_11_12)
	local var_11_14 = arg_11_2
	local var_11_15 = arg_11_2.getConfig(var_11_14, "target_num")

	setSlider = var_11_12

	var_11_12(arg_11_1:Find("progress"), 0, 1, var_11_13 / var_11_15)

	local var_11_16 = var_11_7 and "" or var_11_13 .. "/" .. var_11_15

	setText = var_11_14

	var_11_14(arg_11_1:Find("progress/Text"), var_11_16)

	return
end

return var_0_1
