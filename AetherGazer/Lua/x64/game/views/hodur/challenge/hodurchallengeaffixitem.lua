local var_0_0 = import("game.views.hodur.challenge.HodurChallengeSelectAffixItem")
local var_0_1 = class("HodurChallengeAffixItem", var_0_0)

function var_0_1.SetSelected(arg_1_0, arg_1_1)
	arg_1_0.selected_ = arg_1_1

	arg_1_0.selectController_:SetSelectedState(arg_1_1 and "select" or "Default")
	arg_1_0:RefreshUI()
end

return var_0_1
