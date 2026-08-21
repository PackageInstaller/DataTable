local var_0_0 = class("SoloChallengeSwitchItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")

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

		SoloChallengeData:SetSelectActivityID(arg_2_0.mainActivityID_, arg_2_0.activityID_)

		if arg_2_0.callBack_ then
			arg_2_0.callBack_()
		end
	end)
end

function var_0_0.SetActivityID(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.activityID_ == nil then
		local var_4_0 = string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_4_2, arg_4_1)

		manager.redPoint:bindUIandKey(arg_4_0.transformBtn_, var_4_0)
	elseif arg_4_0.activityID_ ~= arg_4_1 then
		local var_4_1 = string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_4_2, arg_4_0.activityID_)

		manager.redPoint:unbindUIandKey(arg_4_0.transformBtn_, var_4_1)

		local var_4_2 = string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_4_2, arg_4_1)

		manager.redPoint:bindUIandKey(arg_4_0.transformBtn_, var_4_2)
	end

	arg_4_0.activityID_ = arg_4_1
	arg_4_0.mainActivityID_ = arg_4_2
	arg_4_0.startTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).startTime
	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).stopTime

	local var_4_3 = ActivityCfg[arg_4_0.mainActivityID_].sub_activity_list

	arg_4_0.index_ = table.keyof(var_4_3, arg_4_0.activityID_) or 1

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.isLock_ = manager.time:GetServerTime() < arg_5_0.startTime_

	if arg_5_0.isLock_ == true then
		arg_5_0.lockController_:SetSelectedState("true")

		arg_5_0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_5_0.startTime_))
	else
		arg_5_0.lockController_:SetSelectedState("false")
	end

	arg_5_0:RefreshImage()
	arg_5_0:RefreshTitle()
	arg_5_0:RefreshCompleted()
end

function var_0_0.RefreshCompleted(arg_6_0)
	if arg_6_0.completedImageGo_ ~= nil then
		local var_6_0 = #ActivitySoloChallengeCfg[arg_6_0.activityID_].stage_id
		local var_6_1 = SoloChallengeData:GetCompletedActivityList()
		local var_6_2 = var_6_1[arg_6_0.activityID_] and #var_6_1[arg_6_0.activityID_] > 0

		SetActive(arg_6_0.completedImageGo_, var_6_2)
	end
end

function var_0_0.RefreshImage(arg_7_0)
	arg_7_0.icon_.sprite = getSprite("Atlas/SummerUI", ActivitySoloChallengeCfg[arg_7_0.activityID_].option_bg)
end

function var_0_0.RefreshTitle(arg_8_0)
	arg_8_0.titleText_.text = GetI18NText(ActivitySoloChallengeCfg[arg_8_0.activityID_].name)
end

function var_0_0.RegisterClickListener(arg_9_0, arg_9_1)
	arg_9_0.callBack_ = arg_9_1
end

function var_0_0.OnSelect(arg_10_0, arg_10_1)
	if arg_10_0.activityID_ == arg_10_1 then
		arg_10_0.selectController_:SetSelectedState("select")
	else
		arg_10_0.selectController_:SetSelectedState("no")
	end
end

function var_0_0.RefreshLock(arg_11_0)
	if arg_11_0.isLock_ == false then
		return
	end

	arg_11_0.isLock_ = manager.time:GetServerTime() < arg_11_0.startTime_

	if arg_11_0.isLock_ == true then
		arg_11_0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_11_0.startTime_))
	else
		arg_11_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.UnRegisterRedPoint(arg_12_0)
	local var_12_0 = string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_12_0.mainActivityID_, arg_12_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_12_0.transformBtn_, var_12_0)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
	arg_13_0:UnRegisterRedPoint()
	Object.Destroy(arg_13_0.gameObject_)

	arg_13_0.transform_ = nil
	arg_13_0.gameObject_ = nil
	arg_13_0.selectController_ = nil
	arg_13_0.lockController_ = nil
end

return var_0_0
