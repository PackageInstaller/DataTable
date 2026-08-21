local var_0_0 = class("PosterGirlAnimatorState", PosterGirlBaseState)
local var_0_1 = 0.4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.clipName = arg_1_2
	arg_1_0.animator = arg_1_0.actor:GetAnimator()
end

function var_0_0.PlayAni(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.animator
	local var_2_1 = false
	local var_2_2 = not var_2_0:GetCurrentAnimatorStateInfo(0):IsName("ui_stand") and arg_2_0.clipName ~= "ui_stand"

	var_2_0.speed = 1

	if var_2_2 then
		local var_2_3 = var_2_0:GetCurrentAnimatorStateInfo(0).length
		local var_2_4 = var_0_1 / var_2_3

		var_2_0:CrossFade(arg_2_1, var_2_4, 0)
	else
		var_2_0:Play(arg_2_1)
	end

	arg_2_0.timer = Timer.New(function()
		local var_3_0 = var_2_0:GetCurrentAnimatorStateInfo(0)
		local var_3_1 = var_3_0.length
		local var_3_2 = (var_2_2 and var_0_1 or 0) / var_3_1

		if var_3_0:IsName(arg_2_1) and var_3_0.normalizedTime >= 1 - var_3_2 then
			if arg_2_0.timer ~= nil then
				arg_2_0.timer:Stop()

				arg_2_0.timer = nil
			end

			arg_2_0:AnimationEndCall()
		end
	end, 0.033, -1)

	arg_2_0.timer:Start()
end

function var_0_0.AnimationEndCall(arg_4_0)
	arg_4_0.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function var_0_0.Exit(arg_5_0)
	if arg_5_0.timer ~= nil then
		arg_5_0.timer:Stop()

		arg_5_0.timer = nil
	end

	arg_5_0.actor:ResetBlendShapes()
end

return var_0_0
