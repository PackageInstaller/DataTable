local var_0_0 = class("PosterDlcMid2LeftState", PosterDlcTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.oldDirect = arg_1_2
	arg_1_0.newDiect = arg_1_3
	arg_1_0.clipName = arg_1_0:GetAnimaName(arg_1_2, arg_1_3)

	var_0_0.super.Ctor(arg_1_0, arg_1_1)
end

function var_0_0.GetAnimaName(arg_2_0, arg_2_1, arg_2_2)
	if PosterGirlConst.ViewDirect.center == arg_2_1 and PosterGirlConst.ViewDirect.left == arg_2_2 then
		return "enter2"
	elseif PosterGirlConst.ViewDirect.center == arg_2_1 and PosterGirlConst.ViewDirect.right == arg_2_2 then
		return "enter3"
	elseif PosterGirlConst.ViewDirect.left == arg_2_1 and PosterGirlConst.ViewDirect.center == arg_2_2 then
		return "return2"
	else
		return "return3"
	end
end

function var_0_0.Enter(arg_3_0)
	var_0_0.super.Enter(arg_3_0)
	arg_3_0:PlayAniWithParams(arg_3_0.clipName)
	arg_3_0.actor:MuteCamera(true)

	local var_3_0 = arg_3_0.oldDirect
	local var_3_1 = arg_3_0.newDiect
	local var_3_2, var_3_3, var_3_4 = PosterGirlTools.GetLoadLightEffect(var_3_0, var_3_1)

	if var_3_2 then
		if var_3_4 and var_3_4 > 0 then
			arg_3_0.loadEffectTimer_ = Timer.New(function()
				manager.ui:SetSceneLightEffect(var_3_3)
			end, var_3_4)

			arg_3_0.loadEffectTimer_:Start()
		else
			manager.ui:SetSceneLightEffect(var_3_3)
		end
	else
		manager.ui:SetSceneLightEffect(nil)
	end

	PlayerAction.TouchPosterGirl()
end

function var_0_0.Exit(arg_5_0, arg_5_1)
	arg_5_0.actor:MuteCamera(false)

	if arg_5_0.loadEffectTimer_ then
		arg_5_0.loadEffectTimer_:Stop()

		arg_5_0.loadEffectTimer_ = nil
	end

	var_0_0.super.Exit(arg_5_0, arg_5_1)
	arg_5_0.actor:UpdateCameraParams()
end

return var_0_0
