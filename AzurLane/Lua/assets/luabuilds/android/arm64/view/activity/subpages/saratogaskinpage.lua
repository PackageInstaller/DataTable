class = var_0_10000

local var_0_0 = "SaratogaSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.shopBtn = var_1.Find(var_1_0, "btn_list/shop")

	local var_1_1 = arg_1_0.bg

	arg_1_0.fightBtn = var_1.Find(var_1_1, "btn_list/fight")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.shopBtn, function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.GO_SHOPS_LAYER
		local var_3_3 = {}

		NewShopsScene = var_2_10005
		var_3_3.warp = var_2_10005.TYPE_ACTIVITY
		var_3_3.actId = arg_2_0.activity.id

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.fightBtn, function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end)

	return
end

return var_0_1
