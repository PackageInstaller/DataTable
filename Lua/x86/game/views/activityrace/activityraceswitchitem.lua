local var_0_0 = class("ActivityRaceSwitchItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.scoreController_ = ControllerUtil.GetController(arg_1_0.transform_, "score")

	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		if arg_2_0.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_2_0.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_2_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceData:SetSelectActivityID(arg_2_0.activityID_)
		arg_2_0:Go("/activityRaceSwitch", {
			activityID = arg_2_0.activityID_,
			mainActivityID = arg_2_0.mainActivityID_
		})
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.redPointStr_ = string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, arg_4_1, arg_4_2)

	manager.redPoint:bindUIandKey(arg_4_0.transform_, arg_4_0.redPointStr_)

	arg_4_0.activityID_ = arg_4_2
	arg_4_0.mainActivityID_ = arg_4_1
	arg_4_0.startTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).startTime
	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).stopTime

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.isLock_ = manager.time:GetServerTime() < arg_5_0.startTime_

	arg_5_0.lockController_:SetSelectedState(tostring(arg_5_0.isLock_))

	arg_5_0.mapNameText_.text = GetI18NText(ActivityRaceCfg[arg_5_0.activityID_].map_name)

	arg_5_0:RefreshScore()
	arg_5_0:RefreshCompleted()
end

function var_0_0.RefreshScore(arg_6_0)
	local var_6_0 = ActivityRaceData:GetStateList()

	if var_6_0[arg_6_0.activityID_] then
		arg_6_0.score_ = var_6_0[arg_6_0.activityID_].score
	else
		arg_6_0.scoreController_:SetSelectedState("false")
	end

	if arg_6_0.score_ and arg_6_0.score_ ~= 0 then
		arg_6_0.scoreController_:SetSelectedState("true")

		arg_6_0.scoreText_.text = arg_6_0.score_
	end
end

function var_0_0.RefreshCompleted(arg_7_0)
	return
end

function var_0_0.RefreshLock(arg_8_0)
	if arg_8_0.isLock_ == false then
		return
	end

	arg_8_0.isLock_ = manager.time:GetServerTime() < arg_8_0.startTime_

	if arg_8_0.isLock_ == true then
		arg_8_0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_8_0.startTime_))
	else
		arg_8_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.transform_, arg_9_0.redPointStr_)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.gameObject_ = nil
	arg_10_0.transform_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
