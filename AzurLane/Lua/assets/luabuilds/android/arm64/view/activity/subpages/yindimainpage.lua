class = var_0_10000

local var_0_0 = "YinDiMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btnList = var_1.Find(var_1_1, "btn_list")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0

	findTF = var_1_10004

	var_1(var_2_0, var_1_10004(arg_2_0.bg, "btn_list/shop"), function()
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

	return
end

return var_0_1
