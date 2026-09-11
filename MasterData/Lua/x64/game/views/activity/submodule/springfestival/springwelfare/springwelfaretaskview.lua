local SpringWelfareTaskView = class("SpringWelfareTaskView", ReduxView)

function SpringWelfareTaskView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishUIRewardsPopUI"
end

function SpringWelfareTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringWelfareTaskView:Init()
	self:InitUI()
	self:AddUIListener()

	self.taskList_ = LuaList.New(handler(self, self.IndexItem), self.taskListGo_, SpringWelfareTaskItem)
	self.dailyRewardCon_ = ControllerUtil.GetController(self.ptTaskRect_, "state")
	self.allReceiveController_ = ControllerUtil.GetController(self.transform_, "clear")
end

function SpringWelfareTaskView:InitUI()
	self:BindCfgUI()
end

function SpringWelfareTaskView:AddUIListener()
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		self:OnClickAllReceiveBtn()
	end)
	self:AddBtnListener(self.receiveDailyBtn_, nil, function()
		self:OnClickReceiveDailyBtn()
	end)
	self:AddBtnListener(self.dailyPreviewBtn_, nil, function()
		self:OnClickDailyBtn()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SpringWelfareTaskView:OnEnter()
	SpringWelfareTaskView.super.OnEnter(self)
	self:RefreshUI()
	self:AddTimer()
end

function SpringWelfareTaskView:OnExit()
	SpringWelfareTaskView.super.OnExit(self)
	self:StopTimer()
end

function SpringWelfareTaskView:OnTop()
	SetActive(self.gameObject_, true)
end

function SpringWelfareTaskView:OnBehind()
	SetActive(self.gameObject_, false)
end

function SpringWelfareTaskView:Dispose()
	self.taskList_:Dispose()
	SpringWelfareTaskView.super.Dispose(self)
end

function SpringWelfareTaskView:OnClickAllReceiveBtn()
	local var_15_0 = TaskTools:GetCanGetActivityTaskList(self:GetActivityID())

	if not var_15_0 or #var_15_0 <= 0 then
		return
	end

	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		table.insert(var_15_1, iter_15_1.id)
	end

	self:SubmitTaskList(var_15_1)
end

function SpringWelfareTaskView:OnClickReceiveDailyBtn()
	SpringWelfareAction:AcquireDailyPointReward(SpringWelfareData:GetTodayPtCfg().id, function()
		self:RefreshDailyTaskUI()
		SpringWelfareAction:UpdateRedPoint(self:GetActivityID())
	end)
end

function SpringWelfareTaskView:OnClickDailyBtn()
	local var_18_0 = SpringWelfareData:GetTodayPtCfg().reward_item_list

	if #var_18_0 > 1 then
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = var_18_0
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	else
		ShowPopItem(POP_ITEM, var_18_0[1])
	end
end

function SpringWelfareTaskView:RefreshUI()
	self:RefreshTimeUI()
	self:RefreshTaskUI()
	self:RefreshDailyTaskUI()
end

function SpringWelfareTaskView:RefreshTimeUI()
	self.timeText_.text = manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime())
end

function SpringWelfareTaskView:IndexItem(arg_21_1, arg_21_2)
	arg_21_2:SetData(self.sortedTaskIDList_[arg_21_1].id, self:GetActivityID())
	arg_21_2:SetClickHandler(function(arg_22_0, arg_22_1)
		self:SubmitTaskList({
			arg_22_1
		})
	end)
end

function SpringWelfareTaskView:RefreshTaskUI()
	local var_23_0 = TaskData2:GetActivityTaskSortList(self:GetActivityID())

	self.sortedTaskIDList_ = var_23_0

	self.taskList_:StartScroll(#var_23_0)
	self.allReceiveController_:SetSelectedState(SpringWelfareData:HasTaskCanAcquire() and "true" or "false")
end

function SpringWelfareTaskView:RefreshDailyTaskUI()
	local var_24_0 = SpringWelfareData:GetTodayPtCfg()

	self.ptNeedIcon_.sprite = ItemTools.getItemSprite((SpringWelfareData:GetPtItemId()))
	self.ptTaskRewardIcon_.sprite = ItemTools.getItemSprite(var_24_0.reward_item_list[1][1])
	self.ptTaskRewardText_.text = string.format("x%d", var_24_0.reward_item_list[1][2])
	self.ptNeedText_.text = string.format("%d/%d", SpringWelfareData:GetTodayPtProgress(), var_24_0.need)
	self.ptTaskTitleText_.text = GetTips("SPRING_BLESSING_TASK_ITEM_TITLE")
	self.ptTaskDescText_.text = GetTips("SPRING_BLESSING_TASK_ITEM_DESC")

	if SpringWelfareData:IsTodayPtAcquired() then
		self.dailyRewardCon_:SetSelectedState("received")
	else
		self.dailyRewardCon_:SetSelectedState(SpringWelfareData:IsTodayPtCanAcquire() and "complete" or "unfinish")
	end
end

function SpringWelfareTaskView:SubmitTaskList(arg_25_1)
	self.curSubmitIdList_ = arg_25_1

	TaskAction:SubmitTaskList(arg_25_1)
end

function SpringWelfareTaskView:OnTaskListChange()
	self.curSubmitIdList_ = {}

	local var_26_1 = 0

	for iter_26_0, iter_26_1 in ipairs(self.curSubmitIdList_ or {}) do
		if TaskData2:GetTask(iter_26_1).complete_flag >= 1 then
			for iter_26_2, iter_26_3 in ipairs(AssignmentCfg[iter_26_1].reward) do
				if iter_26_3[1] == 53089 then
					var_26_1 = var_26_1 + iter_26_3[2]
				end
			end
		end
	end

	SpringWelfareData:AddTodayPtProgress(var_26_1)
	self:RefreshUI()
	self.taskList_:Refresh()
end

function SpringWelfareTaskView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:RefreshTimeUI()
	end, 1, -1)

	self.timer_:Start()
end

function SpringWelfareTaskView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SpringWelfareTaskView:GetActivityID()
	return SpringWelfareData:GetActivityId()
end

return SpringWelfareTaskView
