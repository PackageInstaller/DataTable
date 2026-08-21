local var_0_0 = class("PosterDlcViewPointState", PosterDlcTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.newDiect = arg_1_2
	arg_1_0.clipName = arg_1_0:GetAnimaNameByViewPoint(arg_1_2)

	var_0_0.super.Ctor(arg_1_0, arg_1_1)
end

function var_0_0.GetAnimaNameByViewPoint(arg_2_0, arg_2_1)
	if PosterGirlConst.ViewDirect.left == arg_2_1 then
		return "action1_1"
	elseif PosterGirlConst.ViewDirect.right == arg_2_1 then
		return "action1_2"
	elseif PosterGirlConst.ViewDirect.center == arg_2_1 then
		return "action1_3"
	else
		return "action1_1"
	end
end

function var_0_0.Enter(arg_3_0)
	var_0_0.super.Enter(arg_3_0)
	arg_3_0:PlayAniWithParams(arg_3_0.clipName)
	arg_3_0.actor:MuteCamera(true)
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	arg_4_0.actor:MuteCamera(false)
	arg_4_0.actor:UpdateCameraParams()
end

return var_0_0
