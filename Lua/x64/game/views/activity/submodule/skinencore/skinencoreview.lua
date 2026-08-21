ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SkinEncoreView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return SkinEncoreTools.GetUIName(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < arg_4_0.startTime_ then
			ShowTips("SOLO_NOT_OPEN")
		elseif var_5_0 <= arg_4_0.stopTime_ then
			JumpTools.GoToSystem("/rechargeMain", {
				page = 2
			}, ViewConst.SYSTEM_ID.SHOP)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshActivityData()
	arg_7_0:RefreshTime()
end

function var_0_0.RefreshActivityData(arg_8_0)
	arg_8_0.activityData_ = ActivityData:GetActivityData(arg_8_0.activityID_)
	arg_8_0.startTime_ = arg_8_0.activityData_.startTime
	arg_8_0.stopTime_ = arg_8_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_9_0)
	local var_9_0
	local var_9_1 = manager.time:GetServerTime()

	arg_9_0:StopTimer()

	if var_9_1 < arg_9_0.startTime_ then
		arg_9_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_9_0.timer_ = Timer.New(function()
			var_9_0 = arg_9_0.startTime_ - manager.time:GetServerTime()

			if var_9_0 <= 0 then
				arg_9_0:StopTimer()
				arg_9_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_9_0.timer_:Start()
	elseif var_9_1 < arg_9_0.stopTime_ then
		arg_9_0.timeTxt_.text = manager.time:GetLostTimeStrWith2Unit(arg_9_0.stopTime_)
		arg_9_0.timer_ = Timer.New(function()
			arg_9_0.timeTxt_.text = manager.time:GetLostTimeStrWith2Unit(arg_9_0.stopTime_)
			var_9_0 = arg_9_0.stopTime_ - manager.time:GetServerTime()

			if var_9_0 <= 0 then
				arg_9_0:StopTimer()
				arg_9_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_9_0.timer_:Start()
	else
		arg_9_0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	arg_13_0:RemoveAllEventListener()
	arg_13_0:StopTimer()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
