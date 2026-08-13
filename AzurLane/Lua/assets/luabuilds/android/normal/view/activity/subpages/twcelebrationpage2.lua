class = var_0_10000

local var_0_0 = "TWCelebrationPage2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.getBtn = var_1.Find(var_1_1, "AD/get_btn")

	local var_1_2 = arg_1_0._tf

	arg_1_0.gotBtn = var_1.Find(var_1_2, "AD/got_btn")

	local var_1_3 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_3, "AD/battle_btn")

	local var_1_4 = arg_1_0._tf

	arg_1_0.mark = var_1.Find(var_1_4, "AD/mark")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_data")[1]

	getProxy = var_3_0
	TaskProxy = var_3

	local var_3_2 = var_3_0(var_3)
	local var_3_3

	if not var_2.getTaskById(var_3_2, var_3_1) and not var_2:getFinishTaskById(var_3_1) then
		Task = var_3_3
		var_3_3 = var_3_3.New({
			id = var_3_1
		})
	end

	local var_3_4 = var_3_3:isFinish()
	local var_3_5 = var_3_3
	local var_3_6 = var_3_3.isReceive(var_3_5)

	setActive = var_3_5

	var_3_5(arg_3_0.getBtn, var_3_3 and var_3_4 and not var_3_6)

	setActive = var_3_5

	var_3_5(arg_3_0.gotBtn, var_3_3 and var_3_6)

	setActive = var_3_5

	var_3_5(arg_3_0.mark, var_3_3 and var_3_6)

	setActive = var_3_5

	var_3_5(arg_3_0.goBtn, var_3_3 and not var_3_4)

	onButton = var_3_5

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.goBtn

	local function var_3_9()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10010

	var_3_5(var_3_7, var_3_8, var_3_9, var_1_10010)

	onButton = var_3_5

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.getBtn

	local function var_3_12()
		if var_3_3 and var_3_4 and not var_3_6 then
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_5_1(var_5_0, var_2_10002.ON_TASK_SUBMIT, var_3_3)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_3_5(var_3_10, var_3_11, var_3_12, var_1_10010)

	return
end

return var_0_1
