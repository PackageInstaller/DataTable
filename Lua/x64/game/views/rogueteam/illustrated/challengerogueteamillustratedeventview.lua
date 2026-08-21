local var_0_0 = class("ChallengeRogueTeamIllustratedEventView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedEventUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.eventItemList_ = {}
	arg_3_0.lockController_ = arg_3_0.controller_:GetController("lock")
	arg_3_0.rewardController_ = arg_3_0.btnController_:GetController("rewards")

	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.templateID_ = arg_4_0.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	arg_4_0.eventList_ = {}
	arg_4_0.eventList_ = RogueTeamEventCfg.get_id_list_by_event_group[1]
	arg_4_0.unlockEventList_ = ChallengeRogueTeamData:GetIllustratedDataByType(arg_4_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT)

	local var_4_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_4_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))

	manager.redPoint:bindUIandKey(arg_4_0.taskBtn_.transform, var_4_0)
	arg_4_0:RefreshSelect(arg_4_0.eventList_[1])
	arg_4_0:RefreshUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamIllustratedTaskPop", {
			activityIDList = arg_5_0.rewardTaskList_,
			type = ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT
		})
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.eventItemList_) do
		SetActive(iter_7_1.gameObject_, false)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.eventList_) do
		if not arg_7_0.eventItemList_[iter_7_2] then
			local var_7_0 = GameObject.Instantiate(arg_7_0.itemGo_, arg_7_0.itemContent_)
			local var_7_1 = ChallengeRogueTeamIllustratedEventItem.New(var_7_0)

			var_7_1:SetClickCallBack(function(arg_8_0)
				for iter_8_0, iter_8_1 in ipairs(arg_7_0.eventItemList_) do
					iter_8_1:RefreshSelect(arg_8_0)
				end

				arg_7_0:RefreshSelect(arg_8_0)
			end)

			arg_7_0.eventItemList_[iter_7_2] = var_7_1
		end

		arg_7_0.eventItemList_[iter_7_2]:SetData(iter_7_2, arg_7_0.eventList_[iter_7_2])
		arg_7_0.eventItemList_[iter_7_2]:RefreshSelect(arg_7_0.selectID_)
		arg_7_0.eventItemList_[iter_7_2]:RefreshUnlock(tostring(not ChallengeRogueTeamData:IsIllustratedObtained(arg_7_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT, iter_7_3)))
		SetActive(arg_7_0.eventItemList_[iter_7_2].gameObject_, true)
	end

	arg_7_0.rewardTaskList_ = ChallengeRogueTeamData:GetAllCollectionTaskByType(arg_7_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT)

	local var_7_2 = ChallengeRogueTeamTools.GetCanRewardTask(arg_7_0.rewardTaskList_)

	arg_7_0.rewardController_:SetSelectedState(tostring(#var_7_2 > 0))

	arg_7_0.progressText_.text = #arg_7_0.unlockEventList_ .. "/" .. #arg_7_0.eventList_
end

function var_0_0.RefreshSelect(arg_9_0, arg_9_1)
	arg_9_0.selectID_ = arg_9_1

	local var_9_0 = RogueTeamEventCfg[arg_9_1]

	arg_9_0.eventImg_.sprite = pureGetSpriteWithoutAtlas(var_9_0.image)
	arg_9_0.eventTitleText_.text = var_9_0.title
	arg_9_0.descText_.text = var_9_0.brief_desc

	arg_9_0.lockController_:SetSelectedState(tostring(not ChallengeRogueTeamData:IsIllustratedObtained(arg_9_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.EVENT, arg_9_1)))
end

function var_0_0.OnExit(arg_10_0)
	local var_10_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_10_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))

	manager.redPoint:unbindUIandKey(arg_10_0.taskBtn_.transform, var_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.eventItemList_ then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.eventItemList_) do
			iter_11_1:Dispose()
		end

		arg_11_0.eventItemList_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_12_0:RefreshUI()
end

return var_0_0
