class = var_0_10000

local var_0_0 = "MainLeftPanel4Mellow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.MainFdConcealablePanel"))

function var_0_1.GetBtns(arg_1_0)
	local var_1_0 = {}

	MainCommissionBtn4Mellow = var_1_10002

	local var_1_1 = var_1_10002.New

	findTF = var_1_10003
	var_1_0[1] = var_1_1(var_1_10003(arg_1_0._tf, "extend"), arg_1_0.event, 0.5)
	MainHideBtn = var_2

	local var_1_2 = var_2.New

	findTF = var_3
	var_1_0[2] = var_1_2(var_3(arg_1_0._tf, "btns/eye"), arg_1_0.event)
	MainCameraBtn = var_2

	local var_1_3 = var_2.New

	findTF = var_3
	var_1_0[3] = var_1_3(var_3(arg_1_0._tf, "btns/cam"), arg_1_0.event)
	MainWordBtn = var_2

	local var_1_4 = var_2.New

	findTF = var_3
	var_1_0[4] = var_1_4(var_3(arg_1_0._tf, "btns/word"), arg_1_0.event)
	MainChangeSkinBtn = var_2

	local var_1_5 = var_2.New

	findTF = var_3
	var_1_0[5] = var_1_5(var_3(arg_1_0._tf, "btns/change"), arg_1_0.event)
	MainResetL2dBtn = var_2

	local var_1_6 = var_2.New

	findTF = var_3
	var_1_0[6] = var_1_6(var_3(arg_1_0._tf, "btns/l2d"), arg_1_0.event)
	MainL2dBoundBtn = var_2

	local var_1_7 = var_2.New

	findTF = var_3
	var_1_0[7] = var_1_7(var_3(arg_1_0._tf, "btns/l2d_bound"), arg_1_0.event)

	return var_1_0
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001(-1, 0)
end

function var_0_1.CalcLayout(arg_3_0)
	return
end

return var_0_1
