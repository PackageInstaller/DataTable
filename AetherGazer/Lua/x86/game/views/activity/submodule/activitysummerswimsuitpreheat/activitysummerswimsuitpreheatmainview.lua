local var_0_0 = class("ActivitySummerSwimsuitPreheatMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stageItemList_ = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = ActivitySummerSwimsuitPreheatStageItem.New(arg_4_0["stageItemGo_" .. iter_4_0])

		table.insert(arg_4_0.stageItemList_, var_4_0)
	end

	arg_4_0.stateController_ = arg_4_0.conEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.stageItemList_) do
		iter_5_1:SetClickHandler(function(arg_6_0)
			arg_5_0:OnClickStage(iter_5_0, arg_6_0)
		end)
	end
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID

	local var_7_0 = ActivityData:GetActivityData(arg_7_0.activityID_)

	arg_7_0.startTime_ = var_7_0.startTime
	arg_7_0.stopTime_ = var_7_0.stopTime

	arg_7_0:RefreshUI()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.stageItemList_) do
		iter_7_1:BindRedPoint(true)
	end
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_8_0:RefreshUI()
	arg_8_0:AddTimer()
end

function var_0_0.OnBehind(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0:StopTimer()
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.stageItemList_) do
		iter_10_1:BindRedPoint(false)
	end
end

function var_0_0.OnActivitySummerSwimsuitPreheatInit(arg_11_0)
	arg_11_0:RefreshUI()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.stageItemList_) do
		iter_11_1:BindRedPoint(true)
	end
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = ActivitySummerSwimsuitPreheatTools.GetCfgIdList(arg_12_0.activityID_)
	local var_12_1 = #var_12_0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.stageItemList_) do
		local var_12_2

		if var_12_1 < iter_12_0 then
			var_12_2 = var_12_0[var_12_1]

			Debug.LogError(string.format("ActivitySummerSwimsuitPreheatCfg(%d) has no config of index %d", arg_12_0.activityID_, iter_12_0))
		else
			var_12_2 = var_12_0[iter_12_0]
		end

		iter_12_1:SetData(var_12_2, iter_12_0)
		iter_12_1:RefreshUI()
	end

	local var_12_3 = arg_12_0.activityID_
	local var_12_4 = true

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		if not ActivitySummerSwimsuitPreheatData.IsStageClear(var_12_3, iter_12_3) then
			var_12_4 = false

			break
		end
	end

	arg_12_0.stateController_:SetSelectedState(var_12_4 and "allClear" or "normal")
end

function var_0_0.OnClickStage(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ActivitySummerSwimsuitPreheatCfg[arg_13_2]

	if not ActivityData:GetActivityIsOpen(var_13_0.activity_id) then
		return
	end

	local var_13_1 = ActivitySummerSwimsuitPreheatCfg[arg_13_2]
	local var_13_2 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(var_13_1)
	local var_13_3 = ActivityTools.GetRedPointKey(var_13_2) .. var_13_2
	local var_13_4 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_STAGE, var_13_1.id, var_13_3)

	ActivitySummerSwimsuitPreheatAction.BanRedPoint(var_13_2, var_13_4)
	JumpTools.OpenPageByJump("activitySummerSwimsuitPreheatStage", {
		cfgId = arg_13_2
	})
end

function var_0_0.AddTimer(arg_14_0)
	arg_14_0:StopTimer()
	arg_14_0:RefreshTimeText()

	arg_14_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_14_0.stopTime_ then
			return
		end

		arg_14_0:RefreshTimeText()
	end, 1, -1)

	arg_14_0.timer_:Start()
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_17_0)
	if arg_17_0.timeText_ then
		if not ActivityData:GetActivityIsOpen(arg_17_0.activityID_) then
			arg_17_0.timeText_.text = GetTips("TIME_OUT")
		else
			arg_17_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_17_0.stopTime_, true)
		end
	end
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:StopTimer()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.stageItemList_) do
		iter_18_1:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
