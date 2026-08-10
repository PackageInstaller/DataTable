ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityPushBoxEnterView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryMainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		local var_5_0 = "ACTIVITY_PUSH_BOX_DESC"

		if var_5_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_5_0),
				key = var_5_0
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		if arg_4_0.activityData_:IsActivitying() then
			JumpTools.OpenPageByJump("/activityPushBoxMain", {
				activityID = arg_4_0.activityID_
			})
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
	arg_7_0:BindRedPointUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshData()
	arg_8_0:RefreshTime()
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.activityData_ = ActivityData:GetActivityData(arg_9_0.activityID_)
	arg_9_0.startTime_ = arg_9_0.activityData_.startTime
	arg_9_0.stopTime_ = arg_9_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_10_0)
	arg_10_0:StopTimer()

	local var_10_0 = manager.time:GetServerTime()

	if var_10_0 < arg_10_0.startTime_ then
		arg_10_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		arg_10_0.timer_ = Timer.New(function()
			if arg_10_0.startTime_ <= manager.time:GetServerTime() then
				arg_10_0:StopTimer()
				arg_10_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_10_0.timer_:Start()
	elseif var_10_0 < arg_10_0.stopTime_ then
		arg_10_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_10_0.stopTime_)
		arg_10_0.timer_ = Timer.New(function()
			if arg_10_0.stopTime_ <= manager.time:GetServerTime() then
				arg_10_0:StopTimer()
				arg_10_0:RefreshTime()

				return
			end

			arg_10_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_10_0.stopTime_)
		end, 1, -1)

		arg_10_0.timer_:Start()
	else
		arg_10_0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.BindRedPointUI(arg_14_0)
	manager.redPoint:bindUIandKey(arg_14_0.goBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. arg_14_0.activityID_)
end

function var_0_0.UnbindRedPointUI(arg_15_0)
	manager.redPoint:unbindUIandKey(arg_15_0.goBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. arg_15_0.activityID_)
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:StopTimer()
	arg_16_0:UnbindRedPointUI()
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	arg_17_0.super.Dispose(arg_17_0)
end

return var_0_0
