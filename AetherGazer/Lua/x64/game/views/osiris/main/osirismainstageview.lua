local var_0_0 = class("OsirisMainStageView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.type_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0)
	local var_2_0

	if arg_2_0.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_STROY)
	elseif arg_2_0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
		manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS))

		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_CHESS)
	elseif arg_2_0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		manager.redPoint:bindUIandKey(arg_2_0.transform_, RedPointConst.OSIRIS_DEMON)

		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON)
	elseif arg_2_0.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
		manager.redPoint:bindUIandKey(arg_2_0.transform_, RedPointConst.OSIRIS_RACE_TRIAL)

		var_2_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_TRIAL)
	end

	arg_2_0.startTime_ = var_2_0.startTime
	arg_2_0.stopTime_ = var_2_0.stopTime

	arg_2_0:RefreshLock()
	arg_2_0:AddTimer()
end

function var_0_0.OnExit(arg_3_0)
	if arg_3_0.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
		-- block empty
	elseif arg_3_0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
		manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS))
	elseif arg_3_0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		manager.redPoint:unbindUIandKey(arg_3_0.transform_, RedPointConst.OSIRIS_DEMON)
	elseif arg_3_0.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
		manager.redPoint:unbindUIandKey(arg_3_0.transform_, RedPointConst.OSIRIS_RACE_TRIAL)
	end

	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if manager.time:GetServerTime() < arg_5_0.startTime_ then
			local var_6_0 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_6_0, manager.time:GetLostTimeStr(arg_5_0.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
			arg_5_0:Go("/osirisStoryStage")
		elseif arg_5_0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
			arg_5_0:Go("/osirisChess")
		elseif arg_5_0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
			ActivityTools.JumpToSubmodulePage(ActivityConst.OSIRIS_DEMON)
		elseif arg_5_0.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
			arg_5_0:Go("/raceTrial", {
				activityID = ActivityConst.OSIRIS_TRIAL
			})
		end
	end)
end

function var_0_0.RefreshLock(arg_7_0)
	arg_7_0.controller_:SetSelectedState(tostring(manager.time:GetServerTime() < arg_7_0.startTime_))
end

function var_0_0.AddTimer(arg_8_0)
	local var_8_0 = GetTips("OPEN_TIME")

	arg_8_0.textTime_.text = string.format(var_8_0, manager.time:GetLostTimeStr(arg_8_0.startTime_))
	arg_8_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < arg_8_0.startTime_ then
			arg_8_0.textTime_.text = string.format(var_8_0, manager.time:GetLostTimeStr(arg_8_0.startTime_))
		else
			arg_8_0:RefreshLock()
			arg_8_0:StopTimer()
		end
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

return var_0_0
