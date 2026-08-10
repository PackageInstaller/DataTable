local var_0_0 = class("ChallengeRogueTeamIllustratedEndingEntraceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/illustratedendingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.endingItemList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.templateID_ = arg_4_0.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	arg_4_0.endingList_ = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[RogueTeamCfg[arg_4_0.templateID_].item_temp][1]

	arg_4_0:RefreshUI()
	arg_4_0:BindRedPoint()
end

function var_0_0.RefreshUI(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.endingItemList_) do
		SetActive(iter_5_1.gameObject_, false)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.endingList_) do
		if not arg_5_0.endingItemList_[iter_5_2] then
			local var_5_0 = GameObject.Instantiate(arg_5_0.endingItemGo_, arg_5_0.endingContent_)
			local var_5_1 = ChallengeRogueTeamEndingItem.New(var_5_0)

			arg_5_0.endingItemList_[iter_5_2] = var_5_1
		end

		arg_5_0.endingItemList_[iter_5_2]:SetData(iter_5_2, arg_5_0.endingList_[iter_5_2])
		SetActive(arg_5_0.endingItemList_[iter_5_2].gameObject_, true)
	end
end

function var_0_0.BindRedPoint(arg_6_0)
	arg_6_0.taskList_ = ChallengeRogueTeamData:GetAllCollectionTaskByType(arg_6_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.END)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.endingList_) do
		local var_6_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_6_0.taskList_[iter_6_0])

		manager.redPoint:bindUIandKey(arg_6_0.endingItemList_[iter_6_0].transform_, var_6_0)
	end
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.endingList_) do
		local var_8_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_8_0.taskList_[iter_8_0])

		manager.redPoint:unbindUIandKey(arg_8_0.endingItemList_[iter_8_0].transform_, var_8_0)
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.endingItemList_ then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.endingItemList_) do
			iter_9_1:Dispose()
		end

		arg_9_0.endingItemList_ = nil
	end
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:RefreshUI()
end

return var_0_0
