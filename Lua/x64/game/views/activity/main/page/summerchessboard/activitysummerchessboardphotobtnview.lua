local var_0_0 = class("ActivitySummerChessBoardPhotoBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.activityID_ = arg_1_2
	arg_1_0.updateActivityHandler_ = handler(arg_1_0, arg_1_0.RefreshUI)
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:AddPhotoTimer()
	arg_2_0:BindRedPoint()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopPhotoTimer()
	arg_3_0:UnbindRedPoint()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.updateActivityHandler_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.BindRedPoint(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.transform_, RedPointConst.CAPTURE_GAME_UNLOCK_ROOT)
end

function var_0_0.UnbindRedPoint(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.transform_)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/captureGameActivityMain")
	end)
end

function var_0_0.RefreshTimeText(arg_9_0, arg_9_1)
	arg_9_0.timeText_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_9_1, true))
end

function var_0_0.AddPhotoTimer(arg_10_0)
	arg_10_0:StopPhotoTimer()

	local var_10_0 = ActivityData:GetActivityData(arg_10_0.activityID_)
	local var_10_1 = manager.time:GetServerTime()

	if var_10_1 >= var_10_0.stopTime then
		SetActive(arg_10_0.gameObject_, false)

		return
	end

	if var_10_1 >= var_10_0.startTime then
		SetActive(arg_10_0.gameObject_, false)
	else
		SetActive(arg_10_0.gameObject_, true)
		arg_10_0:RefreshTimeText(var_10_0.stopTime)
	end

	arg_10_0:RefreshTime()

	arg_10_0.photoTimer_ = Timer.New(function()
		arg_10_0:RefreshTime()
	end, 1, -1)

	arg_10_0.photoTimer_:Start()
end

function var_0_0.RefreshTime(arg_12_0)
	local var_12_0 = ActivityData:GetActivityData(arg_12_0.activityID_)
	local var_12_1 = manager.time:GetServerTime()

	if var_12_1 >= var_12_0.stopTime then
		arg_12_0:StopPhotoTimer()
		SetActive(arg_12_0.gameObject_, false)

		return
	end

	if var_12_1 > var_12_0.startTime then
		if arg_12_0.gameObject_.activeSelf == false then
			SetActive(arg_12_0.gameObject_, true)
		end

		arg_12_0:RefreshTimeText(var_12_0.stopTime)
	end
end

function var_0_0.StopPhotoTimer(arg_13_0)
	if arg_13_0.photoTimer_ then
		arg_13_0.photoTimer_:Stop()

		arg_13_0.photoTimer_ = nil
	end
end

return var_0_0
