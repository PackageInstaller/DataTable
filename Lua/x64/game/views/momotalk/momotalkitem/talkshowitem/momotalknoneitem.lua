local var_0_0 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBaseItemView")
local var_0_1 = class("MomoTalkNoneItem", var_0_0)
local var_0_2 = "end"

function var_0_1.EnsureStateController(arg_1_0)
	if not arg_1_0.stateController_ and arg_1_0.controller_ then
		arg_1_0.stateController_ = arg_1_0.controller_:GetController("state")
	end
end

function var_0_1.OnReset(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:EnsureStateController()

	if arg_2_0.stateController_ then
		local var_2_0 = arg_2_2 and arg_2_2.noneState or var_0_2

		arg_2_0.stateController_:SetSelectedState(var_2_0)
	end
end

return var_0_1
