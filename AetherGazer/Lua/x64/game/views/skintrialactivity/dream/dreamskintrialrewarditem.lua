FactorySkinTrialRewardItem = import("game.views.skinTrialActivity.Factory.FactorySkinTrialRewardItem")

local var_0_0 = class("DreamSkinTrialRewardItem", ReduxView)

function var_0_0.SetData(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.popType_ = arg_1_2

	arg_1_0.commonItem_:RefreshData(formatReward(arg_1_1))
	arg_1_0.commonItem_:RegistCallBack(function()
		if arg_1_0.clickCallback_ then
			if arg_1_0.clickCallback_() then
				ShowPopItem(arg_1_0.popType_, arg_1_1)
			end
		else
			ShowPopItem(arg_1_0.popType_, arg_1_1)
		end
	end)

	if arg_1_0.receivedControllerList_ == nil then
		arg_1_0.receivedControllerList_ = ControllerUtil.GetController(arg_1_0.commonItem_.transform_, "received")
	end

	if SkinTrialData:IsCompleted(arg_1_3) then
		arg_1_0.receivedControllerList_:SetSelectedState("true")
	else
		arg_1_0.receivedControllerList_:SetSelectedState("false")
	end

	arg_1_0.commonItem_:Show(true)
end

return var_0_0
