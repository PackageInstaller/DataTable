class = var_0_10000

local var_0_0 = "YamaShiroSwimwearPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

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

	_ = var_1_10002
	arg_2_0.taskIDList = var_1_10002.flatten(var_2_1)
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

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.TASK, {
			page = "activity"
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	getActivityTask = var_1_10001

	local var_5_0, var_5_1 = var_1_10001(arg_5_0.activity)

	table = var_3

	local var_5_2 = var_3.indexof(arg_5_0.taskIDList, var_5_0, 1)

	setText = var_1_10004

	var_1_10004(arg_5_0.stepText, var_5_2)

	local var_5_3 = var_5_1:getTaskStatus()

	setActive = var_5

	var_5(arg_5_0.goBtn, var_5_3 == 0 or var_5_3 == 1)

	setActive = var_5

	var_5(arg_5_0.gotBtn, var_5_3 == 2)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
