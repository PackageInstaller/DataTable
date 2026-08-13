class = var_0_10000

local var_0_0 = "DaFengJKSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_1, "available")

	local var_1_2 = arg_1_0.bg

	arg_1_0.unavailableTF = var_1.Find(var_1_2, "unavailable")

	local var_1_3 = arg_1_0.bg

	arg_1_0.phaseTF = var_1.Find(var_1_3, "phase")

	local var_1_4 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_4, "item")

	local var_1_5 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_5, "items")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1_10001(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskList = var_1.getConfig(var_2_0, "config_data")[1]
	arg_2_0.submitVO = nil

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.item, false)

	local var_3_0 = arg_3_0.itemList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		local var_4_0 = arg_3_0.taskList[arg_4_1]
		local var_4_1 = arg_3_0.taskProxy
		local var_4_3

		if not var_4.getTaskById(var_4_1, var_4_0) then
			local var_4_2 = arg_3_0.taskProxy

			var_4_3 = var_4.getFinishTaskById(var_4_2, var_4_0)
		end

		assert = var_2_10005

		var_2_10005(var_4_3, "without this task by id: " .. var_4_0)

		UIItemList = var_2_10005

		local var_4_4

		if arg_4_0 == var_2_10005.EventInit then
			var_4_4 = arg_4_2:Find("item")

			local var_4_5 = var_4_3:getConfig("award_display")[1]
			local var_4_6 = {
				type = var_4_5[1],
				id = var_4_5[2],
				count = var_4_5[3]
			}

			updateDrop = var_8

			var_8(var_4_4, var_4_6)

			onButton = var_8

			local var_4_7 = arg_3_0
			local var_4_8 = arg_4_2

			local function var_4_9()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_DROP, var_4_6)

				return
			end

			SFX_PANEL = var_2_10013

			var_8(var_4_7, var_4_8, var_4_9, var_2_10013)
		else
			UIItemList = var_4_4

			if arg_4_0 == var_4_4.EventUpdate then
				local var_4_10 = var_4_3
				local var_4_11 = var_4_3.getTaskStatus(var_4_10)
				local var_4_12 = arg_4_2:Find("got")

				setActive = var_4_10

				var_4_10(var_4_12, var_4_11 == 2)
			end
		end

		return
	end)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.getBtn

	local function var_3_3()
		if arg_3_0.submitVO then
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_6_1(var_6_0, var_2_10003.ON_TASK_SUBMIT, arg_3_0.submitVO)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_1, var_3_2, var_3_3, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = 0

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.taskList) do
		local var_7_2 = arg_7_0.taskProxy
		local var_7_4

		if not var_8.getTaskById(var_7_2, iter_7_1) then
			local var_7_3 = arg_7_0.taskProxy

			var_7_4 = var_8.getFinishTaskById(var_7_3, iter_7_1)
		end

		assert = var_1_10009

		var_1_10009(var_7_4, "without this task by id: " .. iter_7_1)

		if var_7_4:getTaskStatus() == 1 then
			var_7_0 = var_7_0 + 1

			if not arg_7_0.submitVO then
				arg_7_0.submitVO = var_7_4
			end
		end

		if var_7_4:getTaskStatus() == 2 then
			var_7_1 = var_7_1 + 1
		end
	end

	setActive = var_3

	var_3(arg_7_0.getBtn, var_7_0 > 0)

	setActive = var_3

	var_3(arg_7_0.unavailableTF, var_7_0 <= 0)

	eachChild = var_3

	var_3(arg_7_0.phaseTF, function(arg_8_0)
		setActive = var_2_10001

		local var_8_0 = arg_8_0

		tonumber = var_2_10004

		var_2_10001(var_8_0, var_2_10004(arg_8_0.name) <= var_7_0 + var_7_1)

		return
	end)

	local var_7_5 = arg_7_0.itemList

	var_3.align(var_7_5, #arg_7_0.taskList)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
