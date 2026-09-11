local ActivityHeroLetterTaskView = class("ActivityHeroLetterTaskView", ReduxView)

function ActivityHeroLetterTaskView:UIName()
	return ActivityHeroLetterTools.GetTaskUIName(self.params_.activityID)
end

function ActivityHeroLetterTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityHeroLetterTaskView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityHeroLetterTaskView:InitUI()
	self:BindCfgUI()

	self.onSubmitTaskResponseHandle_ = handler(self, self.OnTaskRefresh)
	self.stateCon_ = self.conCollecter_:GetController("state")
	self.lockCon_ = self.rewardCollecter_:GetController("lock")
	self.rewardCon_ = self.rewardCollecter_:GetController("reward")
	self.rewardGo_ = {}
	self.rewardItem_ = {}

	for iter_4_0 = 1, 3 do
		self.rewardGo_[iter_4_0] = self["rewardGo_" .. iter_4_0]
		self.rewardItem_[iter_4_0] = CommonItemView.New(self.rewardGo_[iter_4_0])
	end
end

function ActivityHeroLetterTaskView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivityHeroLetterTaskView:OnEnter()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
	self.lockCon_:SetSelectedState("on")
	self:RefreshUI()
	self:RefreshTask()
end

function ActivityHeroLetterTaskView:RefreshUI()
	self.id_ = self.params_.id
	self.cfg_ = ActivityHeroTaskCfg[self.id_]
	self.name2_.text = HeroCfg[self.cfg_.hero_id].suffix
	self.name1_.text = string.format(GetTips("ACTIVITY_HERO_TASK_REWARD"), HeroCfg[self.cfg_.hero_id].suffix)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. self.cfg_.hero_id)
	self.desc_.text = self.cfg_.desc

	self.rewardCon_:SetSelectedState(ActivityHeroLetterTools.IsReward(self.id_) and "on" or "off")
end

function ActivityHeroLetterTaskView:RefreshTask()
	self.taskID_ = self.cfg_.task_id

	local var_9_0 = AssignmentCfg[self.taskID_]

	self.taskDesc_.text = AssignmentCfg[self.taskID_].desc

	local var_9_1 = TaskData2:GetTask(self.taskID_)
	local var_9_2 = var_9_0.need
	local var_9_3 = var_9_0.need < var_9_1.progress and var_9_2 or var_9_1.progress

	self.progress_.text = (var_9_0.need < var_9_1.progress and var_9_2 or var_9_1.progress) .. "/" .. var_9_0.need
	self.slider_.value = var_9_3 / var_9_2

	local var_9_4 = var_9_0.reward or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_4) do
		local var_9_5 = clone(ItemTemplateData)

		var_9_5.id = iter_9_1[1]
		var_9_5.number = iter_9_1[2]

		function var_9_5.clickFun()
			ShowPopItem(POP_ITEM, {
				var_9_5.id
			})
		end

		self.rewardItem_[iter_9_0]:SetData(var_9_5)
	end

	for iter_9_2 = #var_9_4 + 1, #self.rewardItem_ do
		self.rewardItem_[iter_9_2]:SetData()
	end

	if var_9_1.complete_flag == 1 then
		self.stateCon_:SetSelectedState("complete")
	elseif var_9_2 <= var_9_3 then
		self.stateCon_:SetSelectedState("get")
	else
		self.stateCon_:SetSelectedState("unfinished")
	end
end

function ActivityHeroLetterTaskView:OnTaskRefresh()
	self:RefreshUI()
	self:RefreshTask()
end

function ActivityHeroLetterTaskView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityHeroLetterTaskView:OnExit()
	self:RemoveAllEventListener()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
	manager.windowBar:HideBar()
end

function ActivityHeroLetterTaskView:Dispose()
	self:RemoveAllListeners()

	for iter_14_0, iter_14_1 in ipairs(self.rewardItem_) do
		iter_14_1:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityHeroLetterTaskView
