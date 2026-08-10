local var_0_0 = import("game.views.mardukSpecial.items.MardukSpecialRewardConditionItemView")
local var_0_1 = class("ActivityToggleSpecialRewardConditionItemView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.indexItem), arg_1_0.uilistGo_, CommonItem)
end

function var_0_1.indexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:RefreshData(formatReward(arg_2_0.cfg_.reward_item_list[arg_2_1]))
	arg_2_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, arg_2_0.cfg_.reward_item_list[arg_2_1])
	end)
end

return var_0_1
