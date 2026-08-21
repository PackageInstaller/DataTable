local var_0_0 = class("RyzaCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "RyzaCoreActivityUI"
end

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)

	arg_2_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_3_0, arg_3_1)
		arg_2_0:UpdateAdapt()

		return
	end)

	arg_2_0:UpdateAdapt()

	return
end

function var_0_0.didEnter(arg_4_0)
	var_0_0.super.didEnter(arg_4_0)

	return
end

function var_0_0.UpdateAdapt(arg_5_0)
	local var_5_0 = pg.CameraFixMgr.GetInstance()

	arg_5_0._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_5_0.currentWidth / var_5_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	return
end

function var_0_0.willExit(arg_6_0)
	var_0_0.super.willExit(arg_6_0)

	if arg_6_0.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(arg_6_0.camEventId)

		arg_6_0.camEventId = nil
	end

	return
end

return var_0_0
