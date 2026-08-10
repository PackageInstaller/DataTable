local var_0_0 = class("WaitBattleResultStep", BaseStep)

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0._failSteps = GuideStepCfg[arg_1_0._stepId].params
end

function var_0_0.BattleFinish(arg_2_0, arg_2_1)
	if not isSuccess(arg_2_1) then
		arg_2_0._guide:AddSteps(arg_2_0._failSteps)

		if arg_2_0._isFinish then
			arg_2_0._isFinish = false
		end
	end

	arg_2_0:OnStepEnd()
end

function var_0_0.IsFinish(arg_3_0)
	return arg_3_0._isFinish
end

return var_0_0
