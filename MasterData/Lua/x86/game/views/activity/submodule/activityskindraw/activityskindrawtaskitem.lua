local ActivitySkinDrawTaskItem = class("ActivitySkinDrawTaskItem", ReduxView)

function ActivitySkinDrawTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawTaskItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.stateCon_ = self.controllerEx_:GetController("state")
	self.dailyCon_ = self.controllerEx_:GetController("daily")
end

function ActivitySkinDrawTaskItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivitySkinDrawTaskItem:Refresh(arg_6_1)
	self.info_ = arg_6_1
	self.taskID_ = self.info_.id
	self.cfg_ = AssignmentCfg[self.taskID_]

	self:RefreshUI()
end

function ActivitySkinDrawTaskItem:RefreshUI()
	self:RefreshTask()
	self:RefreshReward()
end

function ActivitySkinDrawTaskItem:RefreshReward()
	for iter_8_0, iter_8_1 in ipairs(self.cfg_.reward) do
		self.rewardItems_[iter_8_0] = self.rewardItems_[iter_8_0] or CommonItemView.New(Object.Instantiate(self.rewardItem_, self.rewardParent_, false), true)

		local var_8_0 = clone(ItemTemplateData)

		var_8_0.id = iter_8_1[1]
		var_8_0.number = iter_8_1[2]

		function var_8_0.clickFun()
			ShowPopItem(POP_ITEM, {
				var_8_0.id
			})
		end

		self.rewardItems_[iter_8_0]:SetData(var_8_0)
		self.rewardItems_[iter_8_0]:Show(true)
	end

	for iter_8_2 = #self.cfg_.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_2]:Show(false)
	end
end

function ActivitySkinDrawTaskItem:RefreshTask()
	self.desc_.text = GetI18NText(self.cfg_.desc)

	local var_10_0

	if self.info_.complete_flag >= 1 or self.info_.progress > self.cfg_.need then
		var_10_0 = self.cfg_.need or self.info_.progress
	end

	self.progress_.text = GetI18NText(var_10_0 .. "/" .. self.cfg_.need)
	self.slider_.value = var_10_0 / self.cfg_.need

	if self.info_.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif self.info_.progress >= self.cfg_.need then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end

	self.dailyCon_:SetSelectedState(tostring(self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY))
end

function ActivitySkinDrawTaskItem:OnExit()
	return
end

function ActivitySkinDrawTaskItem:Dispose()
	self:RemoveAllListeners()

	for iter_12_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_12_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ActivitySkinDrawTaskItem
