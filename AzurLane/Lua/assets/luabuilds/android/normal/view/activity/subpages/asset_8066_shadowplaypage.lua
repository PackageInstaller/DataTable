class = var_0_10000

local var_0_0 = "ShadowPlayPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.getBtn = var_1.Find(var_1_1, "AD/get")

	local var_1_2 = arg_1_0._tf

	arg_1_0.gotBtn = var_1.Find(var_1_2, "AD/got")

	local var_1_3 = arg_1_0._tf

	arg_1_0.urlBtn = var_1.Find(var_1_3, "AD/url")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.urlBtn

	local function var_2_2()
		Application = var_2_10000

		local var_3_0 = var_2_10000.OpenURL
		local var_3_1 = arg_2_0.activity

		var_3_0(var_1.getConfig(var_3_1, "config_client"))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	local var_4_0 = arg_4_0.activity
	local var_4_1 = var_1.getConfig(var_4_0, "config_data")[1]

	getProxy = var_4_0
	TaskProxy = var_3

	local var_4_2 = var_4_0(var_3)
	local var_4_3

	if not var_2.getTaskById(var_4_2, var_4_1) and not var_2:getFinishTaskById(var_4_1) then
		Task = var_4_3
		var_4_3 = var_4_3.New({
			id = var_4_1
		})
	end

	local var_4_4 = var_4_3:isFinish()
	local var_4_5 = var_4_3
	local var_4_6 = var_4_3.isReceive(var_4_5)

	setActive = var_4_5

	var_4_5(arg_4_0.getBtn, var_4_3 and var_4_4 and not var_4_6)

	setActive = var_4_5

	var_4_5(arg_4_0.gotBtn, var_4_3 and var_4_6)

	onButton = var_4_5

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.getBtn

	local function var_4_9()
		if var_4_3 and var_4_4 and not var_4_6 then
			local var_5_0 = arg_4_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_5_1(var_5_0, var_2_10002.ON_TASK_SUBMIT, var_4_3)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_4_5(var_4_7, var_4_8, var_4_9, var_1_10010)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
