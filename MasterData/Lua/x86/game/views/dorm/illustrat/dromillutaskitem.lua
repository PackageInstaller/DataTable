local DromIlluTaskItem = class("DromIlluTaskItem", ReduxView)

function DromIlluTaskItem:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.rewardItemGos_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow_ = true

	self:InitUI()
	self:AddListeners()
end

function DromIlluTaskItem:ReEnter(arg_2_1)
	self.taskID_ = arg_2_1
	self.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshProgress()
	self:RefreshUI()

	self.isShow_ = true
end

function DromIlluTaskItem:OnExit()
	self.isShow_ = false
end

function DromIlluTaskItem:Dispose()
	self:RemoveListeners()

	for iter_4_0, iter_4_1 in pairs(self.rewardItems_) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	self.rewardItems_ = nil

	DromIlluTaskItem.super.Dispose(self)
end

function DromIlluTaskItem:InitUI()
	self:BindCfgUI()

	self.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	self.controller_ = self.mainControllerEx_:GetController("state")
end

function DromIlluTaskItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(self.taskID_, TaskConst.TASK_TYPE.DORM_ILLU, function()
			DormRedPointTools:UpdateDormIlluRedPoint(AssignmentCfg[self.taskID_].condition)
		end)
	end)
end

function DromIlluTaskItem:RemoveListeners()
	self.btn_.onClick:RemoveAllListeners()
end

function DromIlluTaskItem:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	for iter_10_0, iter_10_1 in ipairs(AssignmentCfg[self.taskID_].reward or {}) do
		local var_10_0 = formatReward(iter_10_1)

		if self.rewardItems_[iter_10_0] == nil then
			self.rewardItems_[iter_10_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_10_0)])
			self.rewardItems_[iter_10_0].ResetTransform = function()
				return
			end
		end

		self.itemData[iter_10_0].id = var_10_0.id
		self.itemData[iter_10_0].number = var_10_0.num
		self.itemData[iter_10_0].timeValid = iter_10_1.timeValid or 0
		self.itemData[iter_10_0].grayFlag = self.taskComplete_
		self.itemData[iter_10_0].clickFun = handler(self, self.OnClickCommonItem)

		self.rewardItems_[iter_10_0]:SetData(self.itemData[iter_10_0])
	end

	for iter_10_2 = #AssignmentCfg[self.taskID_].reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_2]:SetData(nil)
	end
end

function DromIlluTaskItem:RefreshProgress()
	local var_12_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_12_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.value = var_12_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_12_0, AssignmentCfg[self.taskID_].need)

	local var_12_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.controller_:SetSelectedState("received")
	elseif var_12_1 then
		self.controller_:SetSelectedState("complete")
	else
		self.controller_:SetSelectedState("unfinish")
	end
end

function DromIlluTaskItem:SetSibling(arg_13_1)
	return
end

function DromIlluTaskItem:OnClickCommonItem(arg_14_1)
	ShowPopItem(POP_ITEM, {
		arg_14_1.id,
		arg_14_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return DromIlluTaskItem
