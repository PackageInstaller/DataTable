local var_0_0 = import("game.views.skinTrialActivity.V2_0.SkinTrialSelectView_2_0")
local var_0_1 = class("SkinTrialSelectView_2_2", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.styleController_ = ControllerUtil.GetController(arg_1_0.transform_, "style")
end

function var_0_1.RefreshUI(arg_2_0)
	var_0_1.super.RefreshUI(arg_2_0)

	if arg_2_0.styleController_ then
		arg_2_0.styleController_:SetSelectedState("V2_2")
	end
end

function var_0_1.SaveRoute(arg_3_0)
	local var_3_0 = {
		name = "skinTrialSelectView_2_2",
		activityID = arg_3_0.activityID_,
		skinTrialID = arg_3_0.skinTrialID_
	}

	SkinTrialData:SaveRoute(var_3_0)
end

return var_0_1
