local ChallengeRogueTeamRewardPopView = class("ChallengeRogueTeamRewardPopView", ReduxView)

function ChallengeRogueTeamRewardPopView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeQuestPopUI"
end

function ChallengeRogueTeamRewardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamRewardPopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.bgController_ = self.controller_:GetController("bg")
	self.scheduleController_ = self.controller_:GetController("schedule")
	self.rewardItemList_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.taskUIList_, ChallengeRogueTeamTaskItem)
	self.refreshHandler_ = handler(self, self.RefreshUI)
end

function ChallengeRogueTeamRewardPopView:InitUI()
	self:BindCfgUI()
end

function ChallengeRogueTeamRewardPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.forwardBtn_, nil, function()
		self.stage_ = self.stage_ - 1

		self:RefreshUI()
	end)
	self:AddBtnListener(self.nextBtn_, nil, function()
		self.stage_ = self.stage_ + 1

		self:RefreshUI()
	end)
	self:AddBtnListener(self.stageRewardBtn_, nil, function()
		TaskAction:SubmitTaskList({
			self.stageTaskId_
		}, nil, function()
			self.stage_ = ChallengeRogueTeamData:GetUnCompletedTaskStage(self.activityId_)

			self:RefreshUI()
		end)
	end)
end

function ChallengeRogueTeamRewardPopView:OnEnter()
	self.activityId_ = self.params_.activityId
	self.cfg_ = ActivityCfg[self.activityId_]

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.refreshHandler_)

	self.stage_ = ChallengeRogueTeamData:GetUnCompletedTaskStage(self.activityId_)

	self:RefreshUI()
end

function ChallengeRogueTeamRewardPopView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.refreshHandler_)
end

function ChallengeRogueTeamRewardPopView:RefreshUI()
	self.stageTaskId_ = ChallengeRogueTeamData:GetStageTaskIDByActivtiyIDAndStage(self.activityId_, self.stage_)

	self:RefreshStageTask()
	self:RefreshScroll()
end

function ChallengeRogueTeamRewardPopView:OnTop()
	self:RefreshStageTask()
end

function ChallengeRogueTeamRewardPopView:RefreshStageTask()
	self.stageTaskCfg_ = AssignmentCfg[self.stageTaskId_]
	self.stageTitleText_.text = self.stageTaskCfg_.name
	self.scheduleTitleText_.text = self.stageTaskCfg_.name
	self.rewardList_ = self.stageTaskCfg_.reward
	self.stageTaskData_ = TaskData2:GetTask(self.stageTaskId_)
	self.progressText_.text = self.stageTaskData_.progress .. "/" .. self.stageTaskCfg_.need
	self.progressImg_.fillAmount = self.stageTaskData_.progress / self.stageTaskCfg_.need
	self.nextStageTaskId_ = ChallengeRogueTeamData:GetStageTaskIDByActivtiyIDAndStage(self.activityId_, self.stage_ + 1)
	self.stageTaskRewarded_ = TaskData2:GetTaskComplete(self.stageTaskId_)
	self.stageTaskCompeleted_ = self.stageTaskData_.progress >= AssignmentCfg[self.stageTaskId_].need

	SetActive(self.nextBtn_.gameObject, self.nextStageTaskId_ ~= nil and self.stageTaskCompeleted_)
	SetActive(self.forwardBtn_.gameObject, self.stage_ == 1)

	if self.stageTaskRewarded_ then
		self.bgController_:SetSelectedState("rewarded")
		self.scheduleController_:SetSelectedState("rewarded")
		SetActive(self.nextBtn_.gameObject, self.nextStageTaskId_ ~= nil)
	elseif self.stageTaskCompeleted_ then
		self.bgController_:SetSelectedState("complete")
		self.scheduleController_:SetSelectedState("complete")
	else
		self.bgController_:SetSelectedState("uncompeted")
		self.scheduleController_:SetSelectedState("uncompeted")
	end

	SetActive(self.forwardBtn_.gameObject, self.stage_ > 1)

	for iter_15_0, iter_15_1 in ipairs(self.rewardItemList_) do
		SetActive(iter_15_1.gameObject_, false)
	end

	for iter_15_2, iter_15_3 in ipairs(self.rewardList_) do
		self.rewardItemList_[iter_15_2] = self.rewardItemList_[iter_15_2] or CommonItemView.New((GameObject.Instantiate(self.commonItemGo_, self.rewardContent_)))

		local var_15_0 = clone(ItemTemplateData)

		var_15_0.id = iter_15_3[1]
		var_15_0.number = iter_15_3[2]

		function var_15_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItemList_[iter_15_2]:SetData(var_15_0)
		SetActive(self.rewardItemList_[iter_15_2].gameObject_, true)
	end
end

function ChallengeRogueTeamRewardPopView:RefreshScroll()
	self.taskList_ = {}

	for iter_17_0, iter_17_1 in pairs((ChallengeRogueTeamData:GetTaskIDListByActivtiyIDAndStage(self.activityId_, self.stage_))) do
		table.insert(self.taskList_, iter_17_1)
	end

	table.sort(self.taskList_, function(arg_18_0, arg_18_1)
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
	self.scrollHelper_:StartScroll(#self.taskList_)
end

function ChallengeRogueTeamRewardPopView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:UnBindRedPoint()
	arg_19_2:SetData(self.taskList_[arg_19_1])
	arg_19_2:SetReveivedHandler(handler(self, self.RefreshScroll))
end

function ChallengeRogueTeamRewardPopView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	for iter_20_0, iter_20_1 in ipairs(self.rewardItemList_) do
		iter_20_1:Dispose()
		Object.Destroy(iter_20_1.gameObject)
	end

	self.rewardItemList_ = nil
	self.refreshHandler_ = nil

	ChallengeRogueTeamRewardPopView.super.Dispose(self)
end

return ChallengeRogueTeamRewardPopView
