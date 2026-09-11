local PaChinKoEntranceItem = class("PaChinKoEntranceItem", ReduxView)

function PaChinKoEntranceItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.rewardItems_ = {}
	self.typeCon_ = self.controllerEx_:GetController("type")
	self.stateCon_ = self.controllerEx_:GetController("state")
end

function PaChinKoEntranceItem:Dispose()
	for iter_2_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_2_0]:Dispose()
	end

	self.rewardItems_ = nil

	PaChinKoEntranceItem.super.Dispose(self)
end

function PaChinKoEntranceItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function PaChinKoEntranceItem:Refresh(arg_5_1, arg_5_2)
	self.taskID_ = arg_5_1
	self.activityID_ = arg_5_2
	self.taskActivityID_ = PaChinKoTools.GetTaskActivityID(self.activityID_)
	self.info_ = TaskData2:GetTask(self.taskID_)
	self.cfg_ = AssignmentCfg[arg_5_1]

	self:RefreshNormalTask()
end

function PaChinKoEntranceItem:RefreshNormalTask()
	local var_6_0 = TaskData2:GetTask(self.taskID_)
	local var_6_1 = AssignmentCfg[self.taskID_]

	self.desc_.text = AssignmentCfg[self.taskID_].desc

	if var_6_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeCon_:SetSelectedState("normal")
	else
		self.typeCon_:SetSelectedState("challenge")
	end

	self:RefreshReward(var_6_1.reward)

	local var_6_2 = var_6_1.need

	self.progress_.text = (var_6_1.need < var_6_0.progress and var_6_2 or var_6_0.progress) .. "/" .. var_6_1.need
	self.slider_.value = (var_6_1.need < var_6_0.progress and var_6_2 or var_6_0.progress) / var_6_2

	if var_6_0.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif var_6_0.progress >= var_6_1.need then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function PaChinKoEntranceItem:RefreshReward(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self.rewardItems_[iter_7_0] = self.rewardItems_[iter_7_0] or CommonItemView.New(Object.Instantiate(self.rewardItem_, self.rewardParent_), true)

		local var_7_0 = cfgToItemTemplate(iter_7_1)

		function var_7_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end

		self.rewardItems_[iter_7_0]:SetData(var_7_0)
		self.rewardItems_[iter_7_0].countdownController_:SetSelectedState("false")
	end

	for iter_7_2 = #arg_7_1 + 1, #self.rewardItems_ do
		self.rewardItems_[iter_7_2]:Show(false)
	end
end

return PaChinKoEntranceItem
