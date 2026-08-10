local var_0_0 = class("OsirisStoryStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/OsirisPlotUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.scrollViewGo_)
	arg_3_0.missionItem_ = {}
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

	arg_4_0.stopTime_ = ActivityData:GetActivityData(ActivityConst.OSIRIS_STROY).stopTime

	arg_4_0:AddTimer()
	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0:StopTimer()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_6_0.scrollMoveView_:OnExit()

	arg_6_0.lastChapterID_ = nil
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.missionItem_) do
		iter_7_1:Dispose()
	end

	arg_7_0.missionItem_ = nil

	arg_7_0.scrollMoveView_:Dispose()

	arg_7_0.scrollMoveView_ = nil
end

function var_0_0.OnUpdate(arg_8_0)
	arg_8_0:RefreshData()
	arg_8_0:RefreshUI()
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btnBg_, nil, function()
		if arg_9_0:IsOpenSectionInfo() then
			arg_9_0.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end)
end

function var_0_0.RefreshData(arg_11_0)
	arg_11_0.chapterID_ = arg_11_0.params_.chapterID or 1
	arg_11_0.stageData_ = StoryStageActivityData:GetStageData(arg_11_0.chapterID_)
	arg_11_0.stageList_ = ActivityStoryChapterCfg[arg_11_0.chapterID_].stage_list
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:RefreshMissionList()

	arg_12_0.selectSection_ = arg_12_0.params_.section or StoryStageActivityData:GetHistoryStage(arg_12_0.chapterID_) or arg_12_0.stageList_[1]

	local var_12_0 = arg_12_0:GetScrollPos()
	local var_12_1 = arg_12_0:GetScrollWidth()

	arg_12_0.scrollMoveView_:RefreshUI(var_12_0, var_12_1)
	arg_12_0:RefreshSelectItem()
end

function var_0_0.RefreshSelectItem(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.missionItem_) do
		iter_13_1:SelectorItem(arg_13_0.selectSection_)
	end
end

function var_0_0.RefreshMissionList(arg_14_0)
	if arg_14_0.lastChapterID_ == arg_14_0.chapterID_ then
		return
	end

	arg_14_0.lastChapterID_ = arg_14_0.chapterID_

	for iter_14_0 = 1, #arg_14_0.missionItem_ do
		arg_14_0.missionItem_[iter_14_0]:Show(false)
	end

	for iter_14_1 = 1, #arg_14_0.stageList_ do
		if arg_14_0.missionItem_[iter_14_1] then
			arg_14_0.missionItem_[iter_14_1]:SetData(arg_14_0.stageList_[iter_14_1], arg_14_0.chapterID_)
		else
			local var_14_0 = Object.Instantiate(arg_14_0.sectionItem_, arg_14_0.content_.transform)

			arg_14_0.missionItem_[iter_14_1] = arg_14_0:GetSectionItemClass().New(var_14_0, arg_14_0.stageList_[iter_14_1], arg_14_0.chapterID_)
		end
	end
end

function var_0_0.GetSectionItemClass(arg_15_0)
	return OsirisStoryStageItem
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
	local var_17_0 = BattleActivityStoryStageCfg[arg_17_0.selectSection_]

	return var_17_0 and var_17_0.position[1] or 0
end

function var_0_0.IsOpenSectionInfo(arg_18_0)
	return arg_18_0:IsOpenRoute("osirisStoryStageInfo")
end

function var_0_0.AddTimer(arg_19_0)
	if manager.time:GetServerTime() >= arg_19_0.stopTime_ then
		arg_19_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_19_0.textTime_.text = manager.time:GetLostTimeStr(arg_19_0.stopTime_)
	arg_19_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_19_0.stopTime_ then
			arg_19_0:StopTimer()

			arg_19_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_19_0.textTime_.text = manager.time:GetLostTimeStr(arg_19_0.stopTime_)
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
