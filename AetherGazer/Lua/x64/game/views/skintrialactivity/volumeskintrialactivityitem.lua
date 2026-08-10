SkinTrialActivityItem = import("game.views.skinTrialActivity.SkinTrialActivityItem")

local var_0_0 = class("VolumeSkinTrialActivityItem", SkinTrialActivityItem)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.activityID_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = ControllerUtil.GetController(arg_1_0.transform_, "state")

	arg_1_0:SetSkinTrialID(arg_1_2)
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.RefreshUI(arg_2_0)
	if SkinTrialData:IsCompleted(arg_2_0.skinTrialID_) then
		arg_2_0.stateController_:SetSelectedState("true")
	end
end

return var_0_0
