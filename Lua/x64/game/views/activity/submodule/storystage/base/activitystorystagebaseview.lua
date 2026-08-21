local var_0_0 = class("ActivityStoryStageBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/OsirisPlotUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.stageItemList_ = {}
	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.scrollViewGo_)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_4_0:IsOpenSectionInfo() then
			arg_4_0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	manager.ui:SetMainCamera("null")
	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()
	arg_4_0:AddTimer()
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_6_0.scrollMoveView_:OnExit()
	arg_6_0:StopTimer()
end

function var_0_0.OnUpdate(arg_7_0)
	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.stageItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.stageItemList_ = nil

	arg_8_0.scrollMoveView_:Dispose()

	arg_8_0.scrollMoveView_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	return
end

function var_0_0.RefreshData(arg_10_0)
	if arg_10_0.params_.chapterID == nil then
		local var_10_0 = arg_10_0.params_.theme

		arg_10_0.activityIDList_ = ActivityTools.GetStoryActivityIDList(var_10_0)

		local var_10_1 = StoryStageActivityData:GetDefaultActivityID(var_10_0) or arg_10_0.activityIDList_[1]

		arg_10_0.chapterID_ = arg_10_0.params_.chapterID or StoryStageActivityData:GetHistoryChapter(var_10_1)
	else
		arg_10_0.chapterID_ = arg_10_0.params_.chapterID
	end

	arg_10_0.stageData_ = StoryStageActivityData:GetStageData(arg_10_0.chapterID_)
	arg_10_0.stageList_ = ActivityStoryChapterCfg[arg_10_0.chapterID_].stage_list
	arg_10_0.selectStageID_ = StoryStageActivityData:GetHistoryStage(arg_10_0.chapterID_) or arg_10_0.stageList_[1]
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = arg_11_0:GetScrollPos()
	local var_11_1 = arg_11_0:GetScrollWidth()

	arg_11_0.scrollMoveView_:RefreshUI(var_11_0, var_11_1)

	local var_11_2 = table.length(arg_11_0.stageData_)

	for iter_11_0 = #arg_11_0.stageItemList_, var_11_2 + 1, -1 do
		arg_11_0.stageItemList_[iter_11_0]:Dispose()

		arg_11_0.stageItemList_[iter_11_0] = nil
	end

	for iter_11_1 = 1, var_11_2 do
		if arg_11_0.stageItemList_[iter_11_1] == nil then
			arg_11_0.stageItemList_[iter_11_1] = arg_11_0:GetItemClass().New(arg_11_0.sectionItem_, arg_11_0.content_)
		end

		arg_11_0.stageItemList_[iter_11_1]:SetData(arg_11_0.stageList_[iter_11_1], arg_11_0.chapterID_)
	end

	arg_11_0:RefreshSelectItem()
end

function var_0_0.RefreshSelectItem(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.stageItemList_) do
		iter_12_1:SelectorItem(arg_12_0.selectStageID_)
	end
end

function var_0_0.GetItemClass(arg_13_0)
	return ActivityStoryStageBaseItem
end

function var_0_0.GetScrollWidth(arg_14_0)
	local var_14_0 = arg_14_0.stageList_[1]

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.stageList_) do
		if not arg_14_0.stageData_[iter_14_1] then
			break
		end

		var_14_0 = iter_14_1
	end

	local var_14_1 = BattleActivityStoryStageCfg[var_14_0]

	return var_14_1 and var_14_1.position[1] or 0
end

function var_0_0.GetScrollPos(arg_15_0)
	local var_15_0 = arg_15_0.selectStageID_
	local var_15_1 = BattleActivityStoryStageCfg[var_15_0]

	return var_15_1 and var_15_1.position[1] or 0
end

function var_0_0.IsOpenSectionInfo(arg_16_0)
	return arg_16_0:IsOpenRoute("storyStageInfoActivity")
end

function var_0_0.AddTimer(arg_17_0)
	local var_17_0 = ActivityStoryChapterCfg[arg_17_0.chapterID_].activity_id

	arg_17_0.stopTime_ = ActivityData:GetActivityData(var_17_0).stopTime

	arg_17_0:StopTimer()

	if manager.time:GetServerTime() >= arg_17_0.stopTime_ then
		arg_17_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_17_0.textTime_.text = manager.time:GetLostTimeStr(arg_17_0.stopTime_)
	arg_17_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_17_0.stopTime_ then
			arg_17_0:StopTimer()

			arg_17_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_17_0.textTime_.text = manager.time:GetLostTimeStr(arg_17_0.stopTime_)
	end, 1, -1)

	arg_17_0.timer_:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

return var_0_0
