local SpringWelfareTaskItem = class("SpringWelfareTaskItem", ReduxView)

function SpringWelfareTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SpringWelfareTaskItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SpringWelfareTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.rewardListGo_, SpringWelfareTaskRewardItem)
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function SpringWelfareTaskItem:AddUIListeners()
	self:AddBtnListener(self.getBtn_, nil, function()
		if self.handler_ then
			self:handler_(self.taskID_)
		end
	end)
end

function SpringWelfareTaskItem:OnTaskListChange()
	self:RefreshUI()
end

function SpringWelfareTaskItem:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.cfg_.reward[arg_7_1])
end

function SpringWelfareTaskItem:SetClickHandler(arg_8_1)
	self.handler_ = arg_8_1
end

function SpringWelfareTaskItem:SetData(arg_9_1, arg_9_2)
	self.taskID_ = arg_9_1
	self.activityID_ = arg_9_2
	self.cfg_ = AssignmentCfg[arg_9_1]

	self:RefreshUI()
end

function SpringWelfareTaskItem:RefreshUI()
	self:RefreshReward()
	self:RefreshTask()
end

function SpringWelfareTaskItem:RefreshReward()
	self.rewardList_:StartScroll(#self.cfg_.reward)
end

function SpringWelfareTaskItem:RefreshTask()
	local var_12_0 = TaskData2:GetTask(self.taskID_)

	self.descText_.text = self.cfg_.desc

	local var_12_1

	if var_12_0.progress > self.cfg_.need then
		var_12_1 = self.cfg_.need or var_12_0.progress
	end

	self.progressText_.text = string.format("%d/%d", var_12_1, self.cfg_.need)
	self.slider_.value = var_12_1 / self.cfg_.need

	if self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeCon_:SetSelectedState("normal")
	end

	local var_12_2

	do
		self.typeCon_:SetSelectedState("challenge")

		var_12_2 = var_12_0.progress >= self.cfg_.need
	end

	if var_12_0.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif var_12_2 then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function SpringWelfareTaskItem:OnExit()
	return
end

function SpringWelfareTaskItem:Dispose()
	self.rewardList_:Dispose()
	self.super.Dispose(self)
end

return SpringWelfareTaskItem
