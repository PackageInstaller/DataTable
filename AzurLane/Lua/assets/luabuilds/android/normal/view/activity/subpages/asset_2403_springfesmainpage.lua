class = var_0_10000

local var_0_0 = "SpringFesMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.go1 = var_1.Find(var_1_1, "1")

	local var_1_2 = arg_1_0.bg

	arg_1_0.go2 = var_1.Find(var_1_2, "2")

	local var_1_3 = arg_1_0.bg

	arg_1_0.go3 = var_1.Find(var_1_3, "3")

	local var_1_4 = arg_1_0.bg

	arg_1_0.go4 = var_1.Find(var_1_4, "4")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.go1, function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_3_1(var_3_0, var_2_10002.SELECT_ACTIVITY, 470)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.go2, function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.COLORING)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.go3, function()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_5_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.CHARGE, {
			wrap = 4
		})

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.go4, function()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.SELECT_ACTIVITY, 473)

		return
	end)

	return
end

return var_0_1
