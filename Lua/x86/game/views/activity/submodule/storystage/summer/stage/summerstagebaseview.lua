local var_0_0 = class("SummerStageBaseView", ReduxView)

function var_0_0.UIParent(arg_1_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.scrollMoveView_ = ScrollMoveView.New(arg_2_0, arg_2_0.scrollView_)
	arg_2_0.stageItem_ = {}
end

function var_0_0.OnEnter(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_3_0:IsOpenSectionInfo() then
			arg_3_0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)

	arg_3_0.stopTime_ = ActivityData:GetActivityData(arg_3_0:GetActivityID()).stopTime

	arg_3_0:AddTimer()
	arg_3_0:RefreshData()
	arg_3_0:RefreshStageList()
	arg_3_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
	arg_5_0.scrollMoveView_:OnExit()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.stageItem_) do
		iter_6_1:Dispose()
	end

	arg_6_0.stageItem_ = nil

	arg_6_0.scrollMoveView_:Dispose()

	arg_6_0.scrollMoveView_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		if arg_7_0:IsOpenSectionInfo() then
			arg_7_0.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end)
end

function var_0_0.OnUpdate(arg_9_0)
	arg_9_0:RefreshData()
	arg_9_0:RefreshUI()
end

function var_0_0.GetActivityID(arg_10_0)
	return
end

function var_0_0.RefreshData(arg_11_0)
	arg_11_0.chapterID_ = arg_11_0.params_.chapterID or 5
	arg_11_0.stageData_ = StoryStageActivityData:GetStageData(arg_11_0.chapterID_)
	arg_11_0.stageList_ = ActivityStoryChapterCfg[arg_11_0.chapterID_].stage_list
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.selectStageID_ = arg_12_0.params_.section or StoryStageActivityData:GetHistoryStage(arg_12_0.chapterID_) or arg_12_0.stageList_[1]

	local var_12_0 = arg_12_0:GetScrollPos()
	local var_12_1 = arg_12_0:GetScrollWidth()

	arg_12_0.scrollMoveView_:RefreshUI(var_12_0, var_12_1)
	arg_12_0:RefreshSelectItem()
end

function var_0_0.RefreshSelectItem(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.stageItem_) do
		iter_13_1:SelectorItem(arg_13_0.selectStageID_)
	end
end

function var_0_0.RefreshStageList(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.stageItem_ do
		arg_14_0.stageItem_[iter_14_0]:Show(false)
	end

	local var_14_0 = StoryStageActivityData:GetStageData(arg_14_0.chapterID_)

	for iter_14_1 = 1, table.length(var_14_0) do
		if not arg_14_0.stageItem_[iter_14_1] then
			arg_14_0.stageItem_[iter_14_1] = arg_14_0:GetStageItemClass().New(arg_14_0.itemGo_, arg_14_0.content_)
		end

		arg_14_0.stageItem_[iter_14_1]:SetData(arg_14_0.stageList_[iter_14_1], arg_14_0.chapterID_)
	end
end

function var_0_0.GetStageItemClass(arg_15_0)
	return
end

function var_0_0.GetScrollWidth(arg_16_0)
	local var_16_0 = arg_16_0.stageList_[1]

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.stageList_) do
		if not arg_16_0.stageData_[iter_16_1] then
			break
		end

		var_16_0 = iter_16_1
	end

	local var_16_1 = BattleActivityStoryStageCfg[var_16_0]

	return var_16_1 and var_16_1.position[1] or 0
end

function var_0_0.GetScrollPos(arg_17_0)
	local var_17_0 = BattleActivityStoryStageCfg[arg_17_0.selectStageID_]

	return var_17_0 and var_17_0.position[1] or 0
end

function var_0_0.IsOpenSectionInfo(arg_18_0)
	return arg_18_0:IsOpenRoute("storyStageInfoActivity")
end

function var_0_0.AddTimer(arg_19_0)
	if manager.time:GetServerTime() >= arg_19_0.stopTime_ then
		arg_19_0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_19_0.timeText_.text = manager.time:GetLostTimeStr(arg_19_0.stopTime_)
	arg_19_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_19_0.stopTime_ then
			arg_19_0:StopTimer()

			arg_19_0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_19_0.timeText_.text = manager.time:GetLostTimeStr(arg_19_0.stopTime_)
	end, 1, -1)

	arg_19_0.timer_:Start()
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end
end

return var_0_0
