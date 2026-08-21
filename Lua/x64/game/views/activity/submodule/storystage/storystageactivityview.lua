local var_0_0 = class("StoryStageActivityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/HellaSelectStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.switchController_ = ControllerUtil.GetController(arg_3_0.goSwitch_.transform, "name")
	arg_3_0.btnLockController_ = ControllerUtil.GetController(arg_3_0.btnSwitch_.transform, "name")
	arg_3_0.storyChapterView_ = {}
	arg_3_0.stageItemList_ = {}
	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.goScrollView_)

	local var_3_0 = arg_3_0:FindCom(typeof(RectTransform), nil, arg_3_0.goStageItem_.transform).rect.width

	arg_3_0.scrollContenLineView_ = ScrollContentLineView.New(arg_3_0.goLineItem_, arg_3_0.goItemParent_, var_3_0, 30, 4)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_4_0:RefreshData()

	local var_4_0 = arg_4_0.activityIDList_

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.activityIDList_) do
		manager.redPoint:bindUIandKey(arg_4_0[string.format("transformRedPoint%s_", iter_4_0)], ActivityTools.GetRedPointKey(iter_4_1) .. iter_4_1)
	end

	for iter_4_2, iter_4_3 in pairs(var_4_0) do
		if #ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_4_3] > 1 then
			local var_4_1 = arg_4_0[string.format("goChapterPanel%s_", iter_4_2)]

			if var_4_1 then
				arg_4_0.storyChapterView_[iter_4_2] = arg_4_0.storyChapterView_[iter_4_2] or StoryChapterView.New(var_4_1, iter_4_3)
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(arg_4_0.storyChapterView_) do
		iter_4_5:OnEnter(arg_4_0.selectChapterID_)
	end

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	arg_5_0:StopTimer()
	arg_5_0.scrollMoveView_:OnExit()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.activityIDList_) do
		manager.redPoint:unbindUIandKey(arg_5_0[string.format("transformRedPoint%s_", iter_5_0)], ActivityTools.GetRedPointKey(iter_5_1) .. iter_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.storyChapterView_) do
		iter_5_3:OnExit()
	end
end

function var_0_0.OnUpdate(arg_6_0)
	arg_6_0:RefreshData()
	arg_6_0:RefreshUI()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.storyChapterView_) do
		iter_6_1:OnUpdate(arg_6_0.selectChapterID_)
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.storyChapterView_) do
		iter_7_1:Dispose()
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0.stageItemList_) do
		iter_7_3:Dispose()
	end

	arg_7_0.stageItemList_ = nil

	arg_7_0.scrollContenLineView_:Dispose()

	arg_7_0.scrollContenLineView_ = nil

	arg_7_0.scrollMoveView_:Dispose()

	arg_7_0.scrollMoveView_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btnSwitch_, nil, function()
		local var_9_0 = ActivityStoryChapterCfg[arg_8_0.selectChapterID_]

		for iter_9_0, iter_9_1 in pairs(arg_8_0.activityIDList_) do
			if var_9_0.activity_id ~= iter_9_1 then
				local var_9_1 = ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]
				local var_9_2 = ActivityStoryChapterCfg[var_9_1]
				local var_9_3 = ActivityData:GetActivityData(var_9_2.activity_id).startTime

				if var_9_3 > manager.time:GetServerTime() then
					local var_9_4 = GetTips("OPEN_TIME")

					ShowTips(string.format(var_9_4, manager.time:GetLostTimeStr(var_9_3)))
				else
					if ActivityData:GetActivityIsOpen(var_9_2.activity_id) == false then
						local var_9_5 = GetTips("OPEN_TIME")

						ShowTips(string.format(var_9_5, manager.time:GetLostTimeStr(manager.time:GetServerTime() + 1)))

						return
					end

					var_9_1 = StoryStageActivityData:GetHistoryChapter(iter_9_1) or var_9_1

					ActivityStoryAction.UpdateRedPoint(var_9_2.activity_id, 0)
					StoryStageActivityData:SaveDefaultActivityID(ActivityCfg[var_9_2.activity_id].activity_theme, var_9_2.activity_id)
					arg_8_0:Go("/storyStageActivity", {
						chapterID = var_9_1,
						theme = ActivityCfg[var_9_2.activity_id].activity_theme
					})
				end

				return
			end
		end
	end)
end

function var_0_0.RefreshData(arg_10_0)
	local var_10_0 = arg_10_0.params_.theme

	arg_10_0.activityIDList_ = ActivityTools.GetStoryActivityIDList(var_10_0)

	local var_10_1 = StoryStageActivityData:GetDefaultActivityID(var_10_0) or arg_10_0.activityIDList_[1]

	arg_10_0.selectChapterID_ = arg_10_0.params_.chapterID or StoryStageActivityData:GetHistoryChapter(var_10_1)

	local var_10_2 = ActivityStoryChapterCfg[arg_10_0.selectChapterID_]
	local var_10_3 = StoryStageActivityData:GetHistoryStage(arg_10_0.selectChapterID_)

	arg_10_0.selectStageIndex_ = table.keyof(var_10_2.stage_list, var_10_3) or 1

	local var_10_4 = var_10_2.activity_id

	arg_10_0.stageData_ = StoryStageActivityData:GetStageData(arg_10_0.selectChapterID_)
	arg_10_0.stageList_ = var_10_2.stage_list
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ActivityStoryChapterCfg[arg_11_0.selectChapterID_].activity_id

	arg_11_0:RefreshStageList()

	local var_11_1 = arg_11_0:GetScrollPos()
	local var_11_2 = arg_11_0:GetScrollWidth()

	arg_11_0.scrollMoveView_:RefreshUI(var_11_1, var_11_2)
	arg_11_0:RefreshSwitchBtn()
	arg_11_0:AddTimer()
	arg_11_0:RefreshSelectItem()
end

function var_0_0.RefreshSwitchBtn(arg_12_0)
	if ActivityStoryChapterCfg[arg_12_0.selectChapterID_].activity_id == arg_12_0.activityIDList_[1] then
		arg_12_0.switchController_:SetSelectedState("1")

		arg_12_0.upChapter_.text = GetTips("FRONT_CHAPTER")
		arg_12_0.downLockChapter_.text = GetTips("AFTER_CHAPTER")
		arg_12_0.downUnLockChapter_.text = GetTips("AFTER_CHAPTER")
	else
		arg_12_0.switchController_:SetSelectedState("2")

		arg_12_0.upChapter_.text = GetTips("AFTER_CHAPTER")
		arg_12_0.downLockChapter_.text = GetTips("FRONT_CHAPTER")
		arg_12_0.downUnLockChapter_.text = GetTips("FRONT_CHAPTER")
	end

	local var_12_0 = ActivityStoryChapterCfg[arg_12_0.selectChapterID_]

	for iter_12_0, iter_12_1 in pairs(arg_12_0.activityIDList_) do
		if var_12_0.activity_id ~= iter_12_1 then
			local var_12_1 = ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_12_1][1]
			local var_12_2 = ActivityData:GetActivityData(iter_12_1).startTime

			arg_12_0.textTime_.text = manager.time:STimeDescS(var_12_2, "!%m/%d %H:%M")

			break
		end
	end
end

function var_0_0.AddTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()
	end

	local var_13_0
	local var_13_1 = 0
	local var_13_2 = ActivityStoryChapterCfg[arg_13_0.selectChapterID_]

	for iter_13_0, iter_13_1 in pairs(arg_13_0.activityIDList_) do
		if var_13_2.activity_id ~= iter_13_1 then
			var_13_0 = iter_13_1

			local var_13_3 = ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_13_1][1]

			var_13_1 = ActivityData:GetActivityData(iter_13_1).startTime

			if var_13_1 > manager.time:GetServerTime() then
				arg_13_0.btnLockController_:SetSelectedState("false")

				break
			end

			arg_13_0.btnLockController_:SetSelectedState("true")

			do return end

			break
		end
	end

	arg_13_0.timer_ = Timer.New(function()
		if ActivityData:GetActivityIsOpen(var_13_0) == false then
			return
		end

		if manager.time:GetServerTime() >= var_13_1 then
			arg_13_0.btnLockController_:SetSelectedState("true")
			arg_13_0:StopTimer()
		end
	end, 1, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
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
	local var_17_0 = ActivityStoryChapterCfg[arg_17_0.selectChapterID_].stage_list[arg_17_0.selectStageIndex_]
	local var_17_1 = BattleActivityStoryStageCfg[var_17_0]

	return var_17_1 and var_17_1.position[1] or 0
end

function var_0_0.RefreshStageList(arg_18_0)
	arg_18_0.lastChapterID_ = arg_18_0.selectChapterID_

	for iter_18_0 = 1, #arg_18_0.stageItemList_ do
		arg_18_0.stageItemList_[iter_18_0]:Show(false)
	end

	local var_18_0 = StoryStageActivityData:GetStageData(arg_18_0.selectChapterID_)

	for iter_18_1 = 1, table.length(var_18_0) do
		if not arg_18_0.stageItemList_[iter_18_1] then
			arg_18_0.stageItemList_[iter_18_1] = arg_18_0:GetStageItemClass().New(arg_18_0.goStageItem_, arg_18_0.goItemParent_)
		end

		arg_18_0.stageItemList_[iter_18_1]:SetData(arg_18_0.stageList_[iter_18_1], arg_18_0.selectChapterID_)
	end

	arg_18_0.scrollContenLineView_:CreateLineItemList(arg_18_0.stageData_, arg_18_0.stageList_, arg_18_0.stageItemList_)
end

function var_0_0.RefreshSelectItem(arg_19_0)
	local var_19_0 = ActivityStoryChapterCfg[arg_19_0.selectChapterID_].stage_list[arg_19_0.selectStageIndex_]

	for iter_19_0, iter_19_1 in pairs(arg_19_0.stageItemList_) do
		iter_19_1:SelectorItem(var_19_0)
	end
end

function var_0_0.IsOpenSectionInfo(arg_20_0)
	return arg_20_0:IsOpenRoute("storyStageInfoActivity")
end

function var_0_0.GetStageItemClass(arg_21_0)
	return StoryStageItemView
end

return var_0_0
