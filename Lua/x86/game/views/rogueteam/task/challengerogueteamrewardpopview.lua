local var_0_0 = class("ChallengeRogueTeamRewardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeQuestPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.bgController_ = arg_3_0.controller_:GetController("bg")
	arg_3_0.scheduleController_ = arg_3_0.controller_:GetController("schedule")
	arg_3_0.rewardItemList_ = {}
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.taskUIList_, ChallengeRogueTeamTaskItem)
	arg_3_0.refreshHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.forwardBtn_, nil, function()
		arg_5_0.stage_ = arg_5_0.stage_ - 1

		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_, nil, function()
		arg_5_0.stage_ = arg_5_0.stage_ + 1

		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.stageRewardBtn_, nil, function()
		TaskAction:SubmitTaskList({
			arg_5_0.stageTaskId_
		}, nil, function()
			arg_5_0.stage_ = ChallengeRogueTeamData:GetUnCompletedTaskStage(arg_5_0.activityId_)

			arg_5_0:RefreshUI()
		end)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityId_ = arg_11_0.params_.activityId
	arg_11_0.cfg_ = ActivityCfg[arg_11_0.activityId_]

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_11_0.refreshHandler_)

	arg_11_0.stage_ = ChallengeRogueTeamData:GetUnCompletedTaskStage(arg_11_0.activityId_)

	arg_11_0:RefreshUI()
end

function var_0_0.OnExit(arg_12_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_12_0.refreshHandler_)
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0.stageTaskId_ = ChallengeRogueTeamData:GetStageTaskIDByActivtiyIDAndStage(arg_13_0.activityId_, arg_13_0.stage_)

	arg_13_0:RefreshStageTask()
	arg_13_0:RefreshScroll()
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:RefreshStageTask()
end

function var_0_0.RefreshStageTask(arg_15_0)
	arg_15_0.stageTaskCfg_ = AssignmentCfg[arg_15_0.stageTaskId_]
	arg_15_0.stageTitleText_.text = arg_15_0.stageTaskCfg_.name
	arg_15_0.scheduleTitleText_.text = arg_15_0.stageTaskCfg_.name
	arg_15_0.rewardList_ = arg_15_0.stageTaskCfg_.reward
	arg_15_0.stageTaskData_ = TaskData2:GetTask(arg_15_0.stageTaskId_)
	arg_15_0.progressText_.text = arg_15_0.stageTaskData_.progress .. "/" .. arg_15_0.stageTaskCfg_.need
	arg_15_0.progressImg_.fillAmount = arg_15_0.stageTaskData_.progress / arg_15_0.stageTaskCfg_.need
	arg_15_0.nextStageTaskId_ = ChallengeRogueTeamData:GetStageTaskIDByActivtiyIDAndStage(arg_15_0.activityId_, arg_15_0.stage_ + 1)
	arg_15_0.stageTaskRewarded_ = TaskData2:GetTaskComplete(arg_15_0.stageTaskId_)
	arg_15_0.stageTaskCompeleted_ = arg_15_0.stageTaskData_.progress >= AssignmentCfg[arg_15_0.stageTaskId_].need

	SetActive(arg_15_0.nextBtn_.gameObject, arg_15_0.nextStageTaskId_ ~= nil and arg_15_0.stageTaskCompeleted_)
	SetActive(arg_15_0.forwardBtn_.gameObject, arg_15_0.stage_ == 1)

	if arg_15_0.stageTaskRewarded_ then
		arg_15_0.bgController_:SetSelectedState("rewarded")
		arg_15_0.scheduleController_:SetSelectedState("rewarded")
		SetActive(arg_15_0.nextBtn_.gameObject, arg_15_0.nextStageTaskId_ ~= nil)
	elseif arg_15_0.stageTaskCompeleted_ then
		arg_15_0.bgController_:SetSelectedState("complete")
		arg_15_0.scheduleController_:SetSelectedState("complete")
	else
		arg_15_0.bgController_:SetSelectedState("uncompeted")
		arg_15_0.scheduleController_:SetSelectedState("uncompeted")
	end

	SetActive(arg_15_0.forwardBtn_.gameObject, arg_15_0.stage_ > 1)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.rewardItemList_) do
		SetActive(iter_15_1.gameObject_, false)
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.rewardList_) do
		if not arg_15_0.rewardItemList_[iter_15_2] then
			local var_15_0 = GameObject.Instantiate(arg_15_0.commonItemGo_, arg_15_0.rewardContent_)

			arg_15_0.rewardItemList_[iter_15_2] = CommonItemView.New(var_15_0)
		end

		local var_15_1 = clone(ItemTemplateData)

		var_15_1.id = iter_15_3[1]
		var_15_1.number = iter_15_3[2]

		function var_15_1.clickFun(arg_16_0)
			ShowPopItem(POP_ITEM, {
				arg_16_0.id,
				arg_16_0.number
			})
		end

		arg_15_0.rewardItemList_[iter_15_2]:SetData(var_15_1)
		SetActive(arg_15_0.rewardItemList_[iter_15_2].gameObject_, true)
	end
end

function var_0_0.RefreshScroll(arg_17_0)
	local var_17_0 = ChallengeRogueTeamData:GetTaskIDListByActivtiyIDAndStage(arg_17_0.activityId_, arg_17_0.stage_)

	arg_17_0.taskList_ = {}

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		table.insert(arg_17_0.taskList_, iter_17_1)
	end

	table.sort(arg_17_0.taskList_, function(arg_18_0, arg_18_1)
		local var_18_0 = TaskData2:GetTask(arg_18_0)
		local var_18_1 = TaskData2:GetTask(arg_18_1)
		local var_18_2 = var_18_0.progress >= AssignmentCfg[arg_18_0].need
		local var_18_3 = var_18_1.progress >= AssignmentCfg[arg_18_1].need

		if var_18_0.complete_flag ~= var_18_1.complete_flag then
			return var_18_0.complete_flag < var_18_1.complete_flag
		elseif var_18_2 ~= var_18_3 then
			return var_18_2 and not var_18_3
		else
			return arg_18_0 < arg_18_1
		end
	end)
	arg_17_0.scrollHelper_:StartScroll(#arg_17_0.taskList_)
end

function var_0_0.IndexItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:UnBindRedPoint()
	arg_19_2:SetData(arg_19_0.taskList_[arg_19_1])
	arg_19_2:SetReveivedHandler(handler(arg_19_0, arg_19_0.RefreshScroll))
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.scrollHelper_ then
		arg_20_0.scrollHelper_:Dispose()

		arg_20_0.scrollHelper_ = nil
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.rewardItemList_) do
		local var_20_0 = iter_20_1.gameObject

		iter_20_1:Dispose()
		Object.Destroy(var_20_0)
	end

	arg_20_0.rewardItemList_ = nil
	arg_20_0.refreshHandler_ = nil

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
