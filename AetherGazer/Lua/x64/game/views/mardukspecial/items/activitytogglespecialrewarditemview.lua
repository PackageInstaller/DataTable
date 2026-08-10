local var_0_0 = import("game.views.mardukSpecial.items.MardukSpecialRewardItemView")
local var_0_1 = class("ActivityToggleSpecialRewardItemView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.items_ = {
		ActivityToggleSpecialRewardConditionItemView.New(arg_1_0.itemGo1_),
		ActivityToggleSpecialRewardConditionItemView.New(arg_1_0.itemGo2_),
		ActivityToggleSpecialRewardConditionItemView.New(arg_1_0.itemGo3_)
	}
end

return var_0_1
