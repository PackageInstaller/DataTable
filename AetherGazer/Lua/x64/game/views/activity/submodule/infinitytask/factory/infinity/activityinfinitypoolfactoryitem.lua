ActivityInfinityPoolBaseItem = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseItem")

local var_0_0 = class("ActivityInfinityPoolFactoryItem", ActivityInfinityPoolBaseItem)

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.unLockController_ = ControllerUtil.GetController(arg_1_0.transform_, "unlock")
end

function var_0_0.RefreshUI(arg_2_0)
	var_0_0.super.RefreshUI(arg_2_0)
	arg_2_0:RefreshRewardPanel()
end

function var_0_0.RefreshRewardPanel(arg_3_0)
	local var_3_0 = arg_3_0.poolID_
	local var_3_1 = arg_3_0.index_

	if OsirisInfinityPoolData:GetPoolData(var_3_0).openBoxList[var_3_1] then
		arg_3_0.unLockController_:SetSelectedState("on")
	else
		arg_3_0.unLockController_:SetSelectedState("off")
	end
end

function var_0_0.GetRewardItem(arg_4_0, arg_4_1)
	return RewardPoolFactoryItem.New(arg_4_0.goItemParent_, arg_4_1, true)
end

return var_0_0
