local StrongholdOperateTaskItem = class("StrongholdOperateTaskItem", ReduxView)

function StrongholdOperateTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StrongholdOperateTaskItem:Init()
	self:InitUI()
end

function StrongholdOperateTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.rewardItemGos_ = {}
	self.controller_ = ControllerUtil.GetController(self.transform_, "state")
	self.rewardCountController = ControllerUtil.GetController(self.transform_, "rewardCount")
	self.typeCountController = ControllerUtil.GetController(self.transform_, "type")
end

function StrongholdOperateTaskItem:SetData(arg_4_1, arg_4_2)
	self.task_activity_id = arg_4_1
	self.taskID_ = arg_4_2

	local var_4_0 = TaskData2:GetTask(self.taskID_)

	if var_4_0 then
		self.taskProgress = var_4_0.progress or 0
	end

	self.taskComplete_ = var_4_0 and var_4_0.complete_flag >= 1 or false

	self:RefreshUI()
	self:RefreshProgress()
end

function StrongholdOperateTaskItem:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.rewardItems_) do
		iter_5_1:Dispose()
	end

	self.rewardItems_ = nil

	StrongholdOperateTaskItem.super.Dispose(self)
end

function StrongholdOperateTaskItem:RefreshUI()
	self.titleText_.text = AssignmentCfg[self.taskID_].desc

	local var_6_0 = AssignmentCfg[self.taskID_].reward or {}

	self.rewardCountController:SetSelectedIndex(math.min(3, #var_6_0))

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if self.rewardItems_[iter_6_0] == nil then
			self.rewardItems_[iter_6_0] = RewardItem.New(self.rewardItem_, self.rewardParent_)

			self.rewardItems_[iter_6_0]:UpdateCommonItemAni()
			self.rewardItems_[iter_6_0].commonItem_:RegistCallBack(function()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		self.rewardItems_[iter_6_0]:SetData(iter_6_1)
	end

	for iter_6_2 = #AssignmentCfg[self.taskID_].reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_6_2]:Show(false)
	end

	if AssignmentCfg[self.taskID_].type == 711 or AssignmentCfg[self.taskID_].type == 721 or AssignmentCfg[self.taskID_].type == 731 then
		self.typeCountController:SetSelectedIndex(0)
	else
		self.typeCountController:SetSelectedIndex(1)
	end
end

function StrongholdOperateTaskItem:RefreshProgress()
	local var_8_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_8_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.fillAmount = var_8_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_8_0, AssignmentCfg[self.taskID_].need)

	local var_8_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.controller_:SetSelectedIndex(2)
	elseif var_8_1 then
		self.controller_:SetSelectedIndex(1)
	else
		self.controller_:SetSelectedIndex(0)
	end

	self.m_icon.sprite = getSprite("Atlas/XuHeng3rdUI", (ActivityStrongholdTaskIconCfg[self.taskID_] or nil) and (ActivityStrongholdTaskIconCfg[self.taskID_].task_icon or ""))
end

function StrongholdOperateTaskItem:RefreshComplete()
	SetActive(self.gameObject_, not self.taskComplete_)
end

return StrongholdOperateTaskItem
