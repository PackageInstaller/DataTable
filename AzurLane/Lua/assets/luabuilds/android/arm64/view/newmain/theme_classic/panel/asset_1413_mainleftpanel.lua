class = var_0_10000

local var_0_0 = "MainLeftPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainConcealablePanel"))

function var_0_1.GetBtns(arg_1_0)
	local var_1_0 = {}

	MainCommissionBtn = var_1_10002

	local var_1_1 = var_1_10002.New

	findTF = var_1_10004
	var_1_0[1] = var_1_1(var_1_10004(arg_1_0._tf, "commissionButton"), arg_1_0.event)
	MainHideBtn = var_2

	local var_1_2 = var_2.New

	findTF = var_4
	var_1_0[2] = var_1_2(var_4(arg_1_0._tf, "hideButton"), arg_1_0.event)
	MainCameraBtn = var_2

	local var_1_3 = var_2.New

	findTF = var_4
	var_1_0[3] = var_1_3(var_4(arg_1_0._tf, "cameraButton"), arg_1_0.event)
	MainWordBtn = var_2

	local var_1_4 = var_2.New

	findTF = var_4
	var_1_0[4] = var_1_4(var_4(arg_1_0._tf, "wordBtn"), arg_1_0.event)
	MainChangeSkinBtn = var_2

	local var_1_5 = var_2.New

	findTF = var_4
	var_1_0[5] = var_1_5(var_4(arg_1_0._tf, "changeBtn"), arg_1_0.event)
	MainL2dBoundBtn = var_2

	local var_1_6 = var_2.New

	findTF = var_4
	var_1_0[6] = var_1_6(var_4(arg_1_0._tf, "l2d_bound"), arg_1_0.event)

	return var_1_0
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001(-1, 0)
end

return var_0_1
