class = var_0_10000

local var_0_0 = "RyzaCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "RyzaCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	pg = var_1

	local var_2_0 = var_1.CameraFixMgr.GetInstance()
	local var_2_1 = var_1.bind

	pg = var_3
	arg_2_0.camEventId = var_2_1(var_2_0, var_3.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.UpdateAdapt(var_3_0)

		return
	end)

	arg_2_0:UpdateAdapt()

	return
end

function var_0_1.didEnter(arg_4_0)
	var_0_1.super.didEnter(arg_4_0)

	return
end

function var_0_1.UpdateAdapt(arg_5_0)
	local var_5_0 = 1.3333333333333333
	local var_5_1 = 2.1666666666666665

	pg = var_1_10003

	local var_5_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_5_3 = var_5.clamp(var_5_2, var_5_0, var_5_1)
	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8
	var_5_5(var_5_4, var_7(var_8)).aspectRatio = var_5_3

	return
end

function var_0_1.willExit(arg_6_0)
	var_0_1.super.willExit(arg_6_0)

	if arg_6_0.camEventId then
		pg = var_1

		local var_6_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_6_0, arg_6_0.camEventId)

		arg_6_0.camEventId = nil
	end

	return
end

return var_0_1
