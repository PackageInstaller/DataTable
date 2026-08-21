local var_0_0 = class("PosterDlcInteractionState", PosterDlcTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.interactionKey = arg_1_2
end

function var_0_0.Enter(arg_2_0)
	var_0_0.super.Enter(arg_2_0)
	arg_2_0.actor:EnableEyeController(false)

	local var_2_0 = arg_2_0.actor:GetInteractionCfg()
	local var_2_1 = var_2_0[arg_2_0.interactionKey]
	local var_2_2 = var_2_0[arg_2_0.interactionKey .. "_talk"]
	local var_2_3 = var_2_0[arg_2_0.interactionKey .. "_delay"]
	local var_2_4 = 1

	if #var_2_1 > 1 then
		if manager.posterGirl.actor == arg_2_0.actor then
			var_2_4 = arg_2_0:RandomIndexOfInteractionType(arg_2_0.interactionKey)
		else
			var_2_4 = manager.posterGirl.actor:GetCurrentState().lastIndex
		end
	end

	local var_2_5 = var_2_1[var_2_4]
	local var_2_6 = var_2_2[var_2_4]
	local var_2_7 = var_2_3[var_2_4]

	if var_2_5 then
		arg_2_0.talking_ = var_2_6

		arg_2_0:PlayAni(var_2_5)

		if var_2_6 and var_2_7 and var_2_7 >= 0 then
			arg_2_0:PlaySpecialTalk(var_2_6, var_2_7)
		end
	end

	if arg_2_0.interactionKey == PosterGirlConst.InteractionKey.mainTouch or arg_2_0.interactionKey == PosterGirlConst.InteractionKey.mainQuickTouch or arg_2_0.interactionKey == PosterGirlConst.InteractionKey.touch2 or arg_2_0.interactionKey == PosterGirlConst.InteractionKey.touch3 then
		PlayerAction.TouchPosterGirl()
	end
end

function var_0_0.RandomIndexOfInteractionType(arg_3_0, arg_3_1)
	arg_3_0.lastIndex = manager.posterGirl:GetForceRandomIndex() or PosterGirlTools.ActorRandomIndexOfInteractionType(arg_3_0.actor, arg_3_1, arg_3_0.lastIndex)

	return arg_3_0.lastIndex
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	var_0_0.super.Exit(arg_4_0, arg_4_1)

	if arg_4_0.talkDelayTimer_ then
		arg_4_0.talkDelayTimer_:Stop()

		arg_4_0.talkDelayTimer_ = nil
	end
end

return var_0_0
