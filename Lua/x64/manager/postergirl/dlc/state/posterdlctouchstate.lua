local var_0_0 = class("PosterDlcTouchState", PosterDlcInteractionState)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, PosterGirlConst.InteractionKey.mainTouch)
end

function var_0_0.Enter(arg_2_0)
	local var_2_0 = arg_2_0.actor:GetViewDirect()

	if PosterGirlConst.ViewDirect.left == var_2_0 then
		arg_2_0.interactionKey = PosterGirlConst.InteractionKey.touch2
	elseif PosterGirlConst.ViewDirect.right == var_2_0 then
		arg_2_0.interactionKey = PosterGirlConst.InteractionKey.touch3
	else
		arg_2_0.interactionKey = PosterGirlConst.InteractionKey.mainTouch
	end

	if arg_2_0.lastInteractionKey ~= arg_2_0.interactionKey then
		arg_2_0.lastInteractionKey = arg_2_0.interactionKey
		arg_2_0.lastIndex = 0
	end

	var_0_0.super.Enter(arg_2_0)
end

return var_0_0
