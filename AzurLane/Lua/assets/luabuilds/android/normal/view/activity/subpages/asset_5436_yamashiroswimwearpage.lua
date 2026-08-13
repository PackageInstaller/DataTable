class = var_0_10000

local var_0_0 = "YamaShiroSwimwearPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_1, "GoBtn")

	local var_1_2 = arg_1_0._tf

	arg_1_0.gotBtn = var_1.Find(var_1_2, "GotBtn")

	local var_1_3 = arg_1_0._tf

	arg_1_0.stepText = var_1.Find(var_1_3, "Step")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_data")

	_ = var_2_0
	arg_2_0.taskIDList = var_2_0.flatten(var_2_1)
	updateActivityTaskStatus = var_2

	return var_2(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.goBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.TASK, {
			page = "activity"
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	getActivityTask = var_1_10001

	local var_5_0, var_5_1 = var_1_10001(arg_5_0.activity)

	table = var_1_10003

	local var_5_2 = var_1_10003.indexof(arg_5_0.taskIDList, var_5_0, 1)

	setText = var_4

	var_4(arg_5_0.stepText, var_5_2)

	local var_5_3 = var_5_1
	local var_5_4 = var_5_1.getTaskStatus(var_5_3)

	setActive = var_5_3

	var_5_3(arg_5_0.goBtn, var_5_4 == 0 or var_5_4 == 1)

	setActive = var_5_3

	var_5_3(arg_5_0.gotBtn, var_5_4 == 2)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
