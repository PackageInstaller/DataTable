local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeItemWithCD", var_0_0)

function var_0_1.AddCountdown(arg_1_0)
	arg_1_0:RefreshTimeText()
	arg_1_0:RemoveCountdown()

	arg_1_0.timer_ = Timer.New(function()
		arg_1_0:RefreshTimeText()
	end, 1, -1)

	arg_1_0.timer_:Start()
end

function var_0_1.RefreshTimeText(arg_3_0)
	local var_3_0 = arg_3_0.isLock_

	arg_3_0:IsLock()

	if arg_3_0.isLock_ ~= var_3_0 then
		arg_3_0:RefreshLock()
		manager.notify:Invoke(CHALLENGE_CONTENT_REFRESH)
	end

	if arg_3_0.isLock_ then
		arg_3_0.timeText_.text = ""

		arg_3_0.timeController_:SetSelectedState("state1")
	else
		arg_3_0.timeController_:SetSelectedState("state0")

		arg_3_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr(arg_3_0:GetLostTime(), nil, true))
	end
end

return var_0_1
