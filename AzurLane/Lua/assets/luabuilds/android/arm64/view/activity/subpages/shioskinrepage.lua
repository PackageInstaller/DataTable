class = var_0_10000

local var_0_0 = "ShioSkinRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.dayTF = var_1.Find(var_1_1, "day")

	local var_1_2 = arg_1_0.bg

	arg_1_0.item1TF = var_1.Find(var_1_2, "item1")

	local var_1_3 = arg_1_0.bg

	arg_1_0.item2TF = var_1.Find(var_1_3, "item2")
	arg_1_0.itemTFList = {
		arg_1_0.item1TF,
		arg_1_0.item2TF
	}

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	arg_3_0.nday = arg_3_0.activity.data3

	local var_3_0 = arg_3_0.activity
	local var_3_1 = #var_1.getConfig(var_3_0, "config_data")

	if arg_3_0.dayTF then
		setText = var_2

		var_2(arg_3_0.dayTF, arg_3_0.nday .. "/" .. var_3_1)
	end

	local var_3_2 = arg_3_0.activity
	local var_3_3 = var_2.getConfig(var_3_2, "config_client").story

	checkExist = var_3_0

	if var_3_0(var_3_3, {
		arg_3_0.nday
	}, {
		1
	}) then
		pg = var_3

		local var_3_4 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_3_4, var_3_3[arg_3_0.nday][1])
	end

	for iter_3_0 = 1, 2 do
		local var_3_5 = arg_3_0.itemTFList[iter_3_0]
		local var_3_6 = iter_3_0
		local var_3_7 = var_3_5:Find("item")
		local var_3_8 = arg_3_0.taskGroup[arg_3_0.nday][iter_3_0]
		local var_3_9 = arg_3_0.taskProxy
		local var_3_11

		if not var_11.getTaskById(var_3_9, var_3_8) then
			local var_3_10 = arg_3_0.taskProxy

			var_3_11 = var_11.getFinishTaskById(var_3_10, var_3_8)
		end

		assert = var_12

		var_12(var_3_11, "without this task by id: " .. var_3_8)

		local var_3_12 = var_3_11:getConfig("award_display")[1]
		local var_3_13 = {
			type = var_3_12[1],
			id = var_3_12[2],
			count = var_3_12[3]
		}

		updateDrop = var_14

		var_14(var_3_7, var_3_13)

		onButton = var_14

		local var_3_14 = arg_3_0
		local var_3_15 = var_3_7

		local function var_3_16()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			BaseUI = var_2_10003

			var_4_1(var_4_0, var_2_10003.ON_DROP, var_3_13)

			return
		end

		SFX_PANEL = var_1_10019

		var_14(var_3_14, var_3_15, var_3_16, var_1_10019)

		local var_3_17 = var_3_11
		local var_3_18 = var_3_11.getProgress(var_3_17)
		local var_3_19 = var_3_11:getConfig("target_num")

		setText = var_3_17

		var_3_17(var_3_5:Find("description"), var_3_11:getConfig("desc"))

		setText = var_3_17

		var_3_17(var_3_5:Find("progressText"), var_3_18 .. "/" .. var_3_19)

		setSlider = var_3_17

		var_3_17(var_3_5:Find("progress"), 0, var_3_19, var_3_18)

		local var_3_20 = var_3_5:Find("go_btn")

		var_1_10019 = var_3_5

		local var_3_21 = var_3_5.Find(var_1_10019, "get_btn")
		local var_3_22 = var_3_5
		local var_3_23 = var_3_5.Find(var_3_22, "got_btn")

		var_1_10019 = var_3_11:getTaskStatus()
		setActive = var_3_22

		var_3_22(var_3_20, var_1_10019 == 0)

		setActive = var_3_22

		var_3_22(var_3_21, var_1_10019 == 1)

		setActive = var_3_22

		var_3_22(var_3_23, var_1_10019 == 2)

		onButton = var_3_22

		local var_3_24 = arg_3_0
		local var_3_25 = var_3_20

		local function var_3_26()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_5_1(var_5_0, var_2_10003.ON_TASK_GO, var_3_11)

			return
		end

		SFX_PANEL = var_1_10025

		var_3_22(var_3_24, var_3_25, var_3_26, var_1_10025)

		onButton = var_3_22

		local var_3_27 = arg_3_0
		local var_3_28 = var_3_21

		local function var_3_29()
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_6_1(var_6_0, var_2_10003.ON_TASK_SUBMIT, var_3_11)

			return
		end

		SFX_PANEL = var_1_10025

		var_3_22(var_3_27, var_3_28, var_3_29, var_1_10025)
	end

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
