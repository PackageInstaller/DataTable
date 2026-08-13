class = var_0_10000

local var_0_0 = "DoaMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.charactorTf = var_1.Find(var_1_0, "charactor")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bg

	var_1(var_2_0, var_4.Find(var_2_1, "btnMiniGame"), function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.DOALINK_ISLAND)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	math = var_1_10001

	local var_4_0 = var_1_10001.random(1, 9)

	for iter_4_0 = 1, 9 do
		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(arg_4_0.charactorTf, "charactor" .. iter_4_0), var_4_0 == iter_4_0)
	end

	return
end

return var_0_1
