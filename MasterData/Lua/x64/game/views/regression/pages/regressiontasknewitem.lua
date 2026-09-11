local RegressionTaskNewItem = class("RegressionTaskNewItem", ReduxView)

function RegressionTaskNewItem:Ctor(arg_1_1)
	self.rewardItems_ = {}
	self.itemDataList_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow_ = true

	self:InitUI()
	self:AddListeners()
end

function RegressionTaskNewItem:ReEnter(arg_2_1, arg_2_2)
	self.taskID_ = arg_2_1
	self.maxRewardNum_ = arg_2_2
	self.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshUI()
	self:RefreshProgress()

	self.isShow_ = true
end

function RegressionTaskNewItem:OnExit()
	self.isShow_ = false

	SetActive(self.gameObject_, false)
end

function RegressionTaskNewItem:Dispose()
	self:RemoveListeners()

	self.itemDataList_ = nil

	for iter_4_0, iter_4_1 in pairs(self.rewardItems_) do
		iter_4_1:Dispose()
	end

	self.rewardItems_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil

	RegressionTaskNewItem.super.Dispose(self)
end

function RegressionTaskNewItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
end

function RegressionTaskNewItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "goBtn")
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function RegressionTaskNewItem:RemoveListeners()
	self.goBtn_.onClick:RemoveAllListeners()
	self.receiveBtn_.onClick:RemoveAllListeners()
end

function RegressionTaskNewItem:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	self:RefreshReward()
end

function RegressionTaskNewItem:RefreshReward()
	local var_11_0 = AssignmentCfg[self.taskID_].reward or {}

	for iter_11_0 = 1, 3 do
		if not self.itemDataList_[iter_11_0] then
			self.itemDataList_[iter_11_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_11_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		local var_11_1 = true

		if var_11_0[iter_11_0] then
			self.itemDataList_[iter_11_0].id = var_11_0[iter_11_0][1]
			self.itemDataList_[iter_11_0].number = var_11_0[iter_11_0][2]
			var_11_1 = false
		end

		if self.rewardItems_[iter_11_0] == nil then
			self.rewardItems_[iter_11_0] = CommonItemPool.New(self.goRewardPanel_, nil, true)
		end

		self.rewardItems_[iter_11_0]:Show(true)

		if not var_11_1 then
			self.rewardItems_[iter_11_0]:SetData(self.itemDataList_[iter_11_0])
		else
			self.rewardItems_[iter_11_0]:SetData(nil)
		end
	end

	for iter_11_1 = self.maxRewardNum_ + 1, #self.rewardItems_ do
		self.rewardItems_[iter_11_1]:Show(false)
	end
end

function RegressionTaskNewItem:RefreshProgress()
	local var_13_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_13_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.value = var_13_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_13_0, AssignmentCfg[self.taskID_].need)

	local var_13_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.controller_:SetSelectedState("2")
	elseif var_13_1 then
		self.controller_:SetSelectedState("1")
	else
		self.controller_:SetSelectedState("0")
	end
end

function RegressionTaskNewItem:SetSibling(arg_14_1)
	if AssignmentCfg[self.taskID_].condition == GameSetting.task_top_type.value[1] and AssignmentCfg[self.taskID_].additional_parameter[1] == TaskConst.TASK_TYPE.DAILY then
		self.transform_:SetSiblingIndex(0)
	else
		self.transform_:SetSiblingIndex(arg_14_1)
	end
end

return RegressionTaskNewItem
