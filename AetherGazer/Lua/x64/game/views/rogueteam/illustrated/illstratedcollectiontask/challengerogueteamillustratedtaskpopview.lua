local var_0_0 = class("ChallengeRogueTeamIllustratedTaskPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeCollectRewardsPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, ChallengeRogueTeamIllustratedTaskPopItem)
	arg_4_0.onClickController_ = arg_4_0.controller_:GetController("oneclick")
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.activityIds_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.onClickBtn_, nil, function()
		local var_8_0 = arg_6_0:GetCanRewardTask()

		TaskAction:SubmitTaskList(var_8_0)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, handler(arg_9_0, arg_9_0.RefreshUI))

	arg_9_0.activityIds_ = arg_9_0.params_.activityIDList
	arg_9_0.type_ = arg_9_0.params_.type
	arg_9_0.campID_ = arg_9_0.params_.campID

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	table.sort(arg_10_0.activityIds_, function(arg_11_0, arg_11_1)
		local var_11_0 = TaskData2:GetTaskComplete(arg_11_0)
		local var_11_1 = TaskData2:GetTaskComplete(arg_11_1)
		local var_11_2 = TaskData2:GetTaskProgress(arg_11_0) >= AssignmentCfg[arg_11_0].need
		local var_11_3 = TaskData2:GetTaskProgress(arg_11_1) >= AssignmentCfg[arg_11_1].need

		if var_11_0 ~= var_11_1 then
			return var_11_1
		end

		if var_11_2 ~= var_11_3 then
			return var_11_2
		end

		return arg_11_0 < arg_11_1
	end)
	arg_10_0.uiList_:StartScroll(#arg_10_0.activityIds_)

	local var_10_0, var_10_1 = arg_10_0:GetCanRewardTask()

	arg_10_0.onClickController_:SetSelectedState(tostring(not table.isEmpty(canReward)))

	arg_10_0.collectCountText.text = string.format(GetTips("ROGUE_TEAM_ILLUSTRADED_TASK_COUNT"), var_10_1)
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.GetCanRewardTask(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.activityIds_) do
		if iter_13_1 then
			local var_13_2 = TaskData2:GetTaskComplete(iter_13_1)

			if TaskData2:GetTaskProgress(iter_13_1) >= AssignmentCfg[iter_13_1].need and not var_13_2 then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	if arg_13_0.type_ == ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP then
		var_13_1 = #ChallengeRogueTeamData:GetUnlockIllustratedTreasureDataByCamp(ChallengeRogueTeamData:GetCacheTemplateID(), arg_13_0.campID_)
	else
		var_13_1 = #ChallengeRogueTeamData:GetIllustratedDataByType(ChallengeRogueTeamData:GetCacheTemplateID(), arg_13_0.type_)
	end

	return var_13_0, var_13_1
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
