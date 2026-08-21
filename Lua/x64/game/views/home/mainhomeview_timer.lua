local var_0_0 = partialClass("MainHomeView", ReduxView)

function var_0_0.StartRefreshUITimer(arg_1_0)
	if arg_1_0.updateTimer == nil then
		arg_1_0.updateTimer = Timer.New(function()
			arg_1_0:RefreshRealtimeUI()
		end, 1, -1)
	end

	arg_1_0.updateTimer:Start()
end

function var_0_0.StartShowTimer(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and #arg_3_1 > 0

	if arg_3_0.showTimer_ or not var_3_0 then
		return
	end

	local var_3_1 = Timer.New(function()
		arg_3_0.showTimer_ = nil

		if manager.guide:IsPlaying() then
			return
		end

		if arg_3_1 then
			arg_3_1[1]()

			return
		end
	end, 1, 1)

	arg_3_0.showTimer_ = var_3_1

	var_3_1:Start()
end

function var_0_0.ClearMsgTimer(arg_5_0)
	if arg_5_0.msgTimer_ then
		arg_5_0.msgTimer_:Stop()

		arg_5_0.msgTimer_ = nil
	end
end

function var_0_0.StartViewHideTimer(arg_6_0)
	arg_6_0:StopViewHideTimer()
	arg_6_0:SetPureModeBtnActive(true, true)

	arg_6_0.viewHideTimer_ = Timer.New(function()
		arg_6_0:StopViewHideTimer()
		arg_6_0:SetPureModeBtnActive(false, true)
	end, 3, 1)

	arg_6_0.viewHideTimer_:Start()
end

function var_0_0.StopViewHideTimer(arg_8_0)
	if arg_8_0.viewHideTimer_ then
		arg_8_0.viewHideTimer_:Stop()

		arg_8_0.viewHideTimer_ = nil
	end
end

function var_0_0.StopAllTimers(arg_9_0)
	arg_9_0:ClearMsgTimer()
	arg_9_0:StopViewHideTimer()

	if arg_9_0.updateTimer then
		arg_9_0.updateTimer:Stop()

		arg_9_0.updateTimer = nil
	end

	if arg_9_0.showTimer_ then
		arg_9_0.showTimer_:Stop()

		arg_9_0.showTimer_ = nil
	end

	if arg_9_0.activiteTime_ then
		arg_9_0.activiteTime_:Stop()

		arg_9_0.activiteTime_ = nil
	end

	if arg_9_0.multiTouchTimer_ then
		arg_9_0.multiTouchTimer_:Stop()

		arg_9_0.multiTouchTimer_ = nil
	end
end
