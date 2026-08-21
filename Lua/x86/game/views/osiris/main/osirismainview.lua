local var_0_0 = class("OsirisMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisUIHomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.mainStageBtnList_ = {
		OsirisMainStageView.New(arg_3_0.goStory_, BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY),
		OsirisMainStageView.New(arg_3_0.goChess_, BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS),
		OsirisMainStageView.New(arg_3_0.goChallenge_, BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON),
		OsirisMainStageView.New(arg_3_0.goSimulator_, BattleConst.STAGE_TYPE_NEW.RACE_TRIAL)
	}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.redPoint:bindUIandKey(arg_4_0.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY))
	manager.redPoint:bindUIandKey(arg_4_0.transformTrial_, string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE))
	manager.redPoint:bindUIandKey(arg_4_0.transformSkinTrial_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.OSIRIS_SKIN_TRIAL_STAGE))

	local var_4_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_ACTIVITY)
	local var_4_1 = var_4_0.startTime
	local var_4_2 = var_4_0.stopTime

	arg_4_0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_4_1, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_4_2, "!%Y.%m.%d %H:%M"))

	for iter_4_0, iter_4_1 in pairs(arg_4_0.mainStageBtnList_) do
		iter_4_1:OnEnter()
	end
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_5_0.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY))
	manager.redPoint:unbindUIandKey(arg_5_0.transformTrial_, string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE))
	manager.redPoint:unbindUIandKey(arg_5_0.transformSkinTrial_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.OSIRIS_SKIN_TRIAL_STAGE))

	for iter_5_0, iter_5_1 in pairs(arg_5_0.mainStageBtnList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.mainStageBtnList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.mainStageBtnList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnStoryView_, nil, function()
		arg_7_0:Go("/osirisRecall")
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnHeroTrial_, nil, function()
		local var_9_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
		local var_9_1 = var_9_0.startTime

		if var_9_0.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		arg_7_0:Go("/heroTrialActivity", {
			activityID = ActivityConst.OSIRIS_HERO_TRIAL_STAGE
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnGift_, nil, function()
		local var_10_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_INFINITY_POOL)
		local var_10_1 = var_10_0.startTime

		if var_10_0.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		arg_7_0:Go("/osirisActivity", {
			activityType = OsirisConst.ACTIVITY_TYPE.TASK,
			activityTaskID = ActivityConst.OSIRIS_TASK_DAILY,
			activityInfinityID = ActivityConst.OSIRIS_INFINITY_POOL
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnSkinTrial_, nil, function()
		local var_11_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_SKIN_TRIAL_STAGE)
		local var_11_1 = var_11_0.startTime

		if var_11_0.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		arg_7_0:Go("/skinTrialActivity", {
			activityID = ActivityConst.OSIRIS_SKIN_TRIAL_STAGE
		})
	end)
end

return var_0_0
