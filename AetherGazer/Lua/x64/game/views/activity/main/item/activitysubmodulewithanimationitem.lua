ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local var_0_0 = class("ActivitySubmoduleWithAnimationItem", ActivitySubmoduleItem)

function var_0_0.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.button_, nil, function()
		if manager.time:GetServerTime() < arg_1_0.startTime_ then
			local var_2_0 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_2_0, manager.time:GetLostTimeStr(arg_1_0.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_1_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		manager.notify:Invoke(ACTIVITY_MAIN_CLICK_BTN)
		LeanTween.delayedCall(0.6, System.Action(function()
			ActivityTools.JumpToSubmodulePage(arg_1_0.activityId_)
		end))
	end)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
