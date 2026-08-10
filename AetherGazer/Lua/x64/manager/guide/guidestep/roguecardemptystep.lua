local var_0_0 = class("RogueCardEmptyStep", BaseStep)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0._eventName = GuideStepCfg[arg_1_0._stepId].params[1]
end

function var_0_0.Play(arg_2_0)
	if arg_2_0._stepId == 24705 or arg_2_0._stepId == 24707 then
		RogueCard.RogueCardGameMain.Instance:ShowJokerSellGo(arg_2_0._stepId == 24705)
		arg_2_0:OnStepEnd()

		return
	end
end

return var_0_0
