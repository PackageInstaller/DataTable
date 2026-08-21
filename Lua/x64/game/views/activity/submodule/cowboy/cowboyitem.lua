local var_0_0 = class("CowboyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < arg_4_0.stopTime_ and var_5_0 >= arg_4_0.startTime_ then
			CowboyData:SetOpen(arg_4_0.activityID_)
			SetActive(arg_4_0.redGo_, false)
			CowboyAction:RefreshOpen(arg_4_0.activityID_)
			JumpTools.OpenPageByJump("cowboyReady", {
				mainActivityID = arg_4_0.mainActivityID_,
				activityID = arg_4_0.activityID_,
				index = arg_4_0.index_
			})
		elseif manager.time:GetServerTime() < arg_4_0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_4_0.startTime_)))
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.mainActivityID_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2

	arg_7_0:RefreshData()
	arg_7_0:RefreshTime()
end

function var_0_0.RefreshData(arg_8_0)
	arg_8_0.data_ = CowboyData:GetData(arg_8_0.activityID_)
	arg_8_0.activityData_ = ActivityData:GetActivityData(arg_8_0.activityID_)

	if arg_8_0.data_ and arg_8_0.activityData_:IsActivitying() and not CowboyData:GetOpen(arg_8_0.activityID_) then
		SetActive(arg_8_0.redGo_, true)
	else
		SetActive(arg_8_0.redGo_, false)
	end

	arg_8_0.startTime_ = arg_8_0.activityData_.startTime
	arg_8_0.stopTime_ = arg_8_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_9_0)
	local var_9_0
	local var_9_1 = manager.time:GetServerTime()

	arg_9_0:StopTimer()

	if var_9_1 < arg_9_0.startTime_ and arg_9_0.activityData_:IsActivitying() == false then
		arg_9_0.stateCon_:SetSelectedState("close")

		arg_9_0.timeTxt_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_9_0.startTime_))
		arg_9_0.timer_ = Timer.New(function()
			var_9_0 = arg_9_0.startTime_ - manager.time:GetServerTime()

			if var_9_0 <= 0 then
				arg_9_0:StopTimer()
				arg_9_0:RefreshTime()

				return
			end

			arg_9_0.timeTxt_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_9_0.startTime_))
		end, 1, -1)

		arg_9_0.timer_:Start()
	elseif arg_9_0.data_ and arg_9_0.data_.score > -10000 then
		arg_9_0.stateCon_:SetSelectedState("finish")

		arg_9_0.score_.text = arg_9_0.data_.score
	else
		arg_9_0.stateCon_:SetSelectedState("open")
	end
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.RefreshLevelText(arg_12_0, arg_12_1)
	arg_12_0.index_ = arg_12_1
	arg_12_0.levelText_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), arg_12_1)
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:StopTimer()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
