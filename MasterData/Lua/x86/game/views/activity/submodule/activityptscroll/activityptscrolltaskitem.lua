local ActivityPtScrollTaskItem = class("ActivityPtScrollTaskItem", ReduxView)

function ActivityPtScrollTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPtScrollTaskItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPtScrollTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.typeCon_ = self.itemCon_:GetController("type")
	self.stateCon_ = self.itemCon_:GetController("state")
end

function ActivityPtScrollTaskItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.taskID_ == 0 then
			ActivityPtScrollAction.TryToSubmitScrollTask(self.activityID_)
		else
			TaskAction:SubmitTask(self.taskID_)
		end
	end)
end

function ActivityPtScrollTaskItem:Refresh(arg_6_1, arg_6_2)
	self.taskID_ = arg_6_1
	self.activityID_ = arg_6_2
	self.taskActivityID_ = ActivityPtScrollTools.GetTaskActivityID(self.activityID_)
	self.info_ = TaskData2:GetTask(self.taskID_)
	self.cfg_ = AssignmentCfg[arg_6_1]

	if self.taskID_ == 0 then
		self:RefreshInfinityTask()
	else
		self:RefreshNormalTask()
	end
end

function ActivityPtScrollTaskItem:RefreshInfinityTask()
	local var_7_0 = GameSetting.activity_pt_roulette_task_times.value[1]
	local var_7_1 = ActivityPtScrollData:GetClearTime(self.activityID_)

	self.desc_.text = ActivityConst.ACTIVITY_PTSCROLL_4_2 == self.activityID_ and string.format(GetTips("ACTIVITY_GODEATER_ROULETTE_TASK_DESC"), var_7_0) or string.format(GetTips("ACTIVITY_ROULETTE_TASK_DESC"), var_7_0)

	self.typeCon_:SetSelectedState("infinity")

	local var_7_2

	for iter_7_0, iter_7_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.activityID_]) do
		if ActivityPtRouletteStageCfg[iter_7_1].mode == 2 then
			var_7_2 = ActivityPtRouletteStageCfg[iter_7_1].cost[1]

			break
		end
	end

	self:RefreshReward({
		{
			var_7_2,
			nil
		}
	})

	self.progress_.text = var_7_1 .. "/" .. var_7_0
	self.slider_.value = var_7_0 < var_7_1 and 1 or var_7_1 / var_7_0

	if var_7_0 <= var_7_1 then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function ActivityPtScrollTaskItem:RefreshNormalTask()
	local var_8_0 = TaskData2:GetTask(self.taskID_)
	local var_8_1 = AssignmentCfg[self.taskID_]

	self.desc_.text = AssignmentCfg[self.taskID_].desc

	if var_8_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeCon_:SetSelectedState("normal")
	else
		self.typeCon_:SetSelectedState("challenge")
	end

	self:RefreshReward(var_8_1.reward)

	local var_8_2 = var_8_1.need

	self.progress_.text = (var_8_1.need < var_8_0.progress and var_8_2 or var_8_0.progress) .. "/" .. var_8_1.need
	self.slider_.value = (var_8_1.need < var_8_0.progress and var_8_2 or var_8_0.progress) / var_8_2

	if var_8_0.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif var_8_0.progress >= var_8_1.need then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function ActivityPtScrollTaskItem:RefreshReward(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		self.rewardItems_[iter_9_0] = self.rewardItems_[iter_9_0] or CommonItemView.New(Object.Instantiate(self.rewardItem_, self.rewardParent_), true)

		local var_9_0 = cfgToItemTemplate(iter_9_1)

		function var_9_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end

		self.rewardItems_[iter_9_0]:SetData(var_9_0)
		self.rewardItems_[iter_9_0].countdownController_:SetSelectedState("false")
	end

	for iter_9_2 = #arg_9_1 + 1, #self.rewardItems_ do
		self.rewardItems_[iter_9_2]:Show(false)
	end
end

function ActivityPtScrollTaskItem:OnExit()
	return
end

function ActivityPtScrollTaskItem:Dispose()
	self:RemoveAllListeners()

	for iter_12_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_12_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityPtScrollTaskItem
