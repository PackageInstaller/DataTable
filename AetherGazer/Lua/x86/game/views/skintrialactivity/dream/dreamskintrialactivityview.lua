local var_0_0 = import("game.views.skinTrialActivity.FactorySkinTrialActivityView")
local var_0_1 = class("DreamSkinTrialActivityView", var_0_0)

function var_0_1.UIName(arg_1_0)
	if arg_1_0.params_.activityID == ActivityConst.THOR_SKIN_TRIAL then
		return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialMainUI_1"
	else
		return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialMainUI_2"
	end
end

function var_0_1.GetItemClass(arg_2_0)
	return DreamSkinTrialActivityItem
end

return var_0_1
