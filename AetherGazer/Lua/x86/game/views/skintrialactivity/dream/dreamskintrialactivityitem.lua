FactorySkinTrialActivityItem = import("game.views.skinTrialActivity.Factory.FactorySkinTrialActivityItem")

local var_0_0 = class("DreamSkinTrialActivityItem", FactorySkinTrialActivityItem)

function var_0_0.RefreshTime(arg_1_0)
	if manager.time:GetServerTime() < arg_1_0.startTime_ then
		SetActive(arg_1_0.gameObject_, false)

		return
	end

	if manager.time:GetServerTime() >= arg_1_0.stopTime_ then
		arg_1_0.textTime_.text = GetTips("TIME_OVER")

		SetActive(arg_1_0.gameObject_, false)

		return
	end

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.textTime_.text = manager.time:GetLostTimeStr(arg_1_0.stopTime_)
end

return var_0_0
