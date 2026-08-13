class = var_0_10000

local var_0_0 = "ChargeAwardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf

	arg_1_0.charge = var_1.Find(var_1_1, "charge")

	local var_1_2 = arg_1_0._tf

	arg_1_0.take = var_1.Find(var_1_2, "take")

	local var_1_3 = arg_1_0._tf

	arg_1_0.finish = var_1.Find(var_1_3, "finish")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.charge, function()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_4_3 = var_2_10004.CHARGE
		local var_4_4 = {}

		ChargeScene = var_2_10006
		var_4_4.wrap = var_2_10006.TYPE_DIAMOND

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.take, function()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0.charge, arg_6_0.activity.data2 == 0 and arg_6_0.activity.data1 == 0)

	setButtonEnabled = var_1_10001

	var_1_10001(arg_6_0.take, arg_6_0.activity.data2 == 0)

	setActive = var_1_10001

	var_1_10001(arg_6_0.take, arg_6_0.activity.data1 > 0)

	setActive = var_1_10001

	var_1_10001(arg_6_0.finish, arg_6_0.activity.data2 == 1)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	clearImageSprite = var_1_10001

	var_1_10001(arg_7_0.bg)

	return
end

return var_0_1
