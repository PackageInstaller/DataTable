local ActivitySkinDrawTaskItemOld = class("ActivitySkinDrawTaskItemOld", ReduxView)

function ActivitySkinDrawTaskItemOld:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawTaskItemOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawTaskItemOld:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.dailyCon_ = ControllerUtil.GetController(self.transform_, "daily")
end

function ActivitySkinDrawTaskItemOld:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivitySkinDrawTaskItemOld:Refresh(arg_6_1)
	self.info_ = arg_6_1
	self.taskID_ = self.info_.id
	self.cfg_ = AssignmentCfg[self.taskID_]

	self:RefreshUI()
end

function ActivitySkinDrawTaskItemOld:RefreshUI()
	self:RefreshReward()
	self:RefreshTask()
end

function ActivitySkinDrawTaskItemOld:RefreshReward()
	for iter_8_0, iter_8_1 in ipairs(self.cfg_.reward) do
		self.rewardItems_[iter_8_0] = self.rewardItems_[iter_8_0] or CommonItemView.New(Object.Instantiate(self.rewardItem_, self.rewardParent_), true)

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

function ActivitySkinDrawTaskItemOld:RefreshTask()
	self.desc_.text = GetI18NText(self.cfg_.desc)

	local var_10_0

	if self.info_.progress > self.cfg_.need then
		var_10_0 = self.cfg_.need or self.info_.progress

		if self.info_.complete_flag >= 1 then
			var_10_0 = self.cfg_.need
		end
	end

	self.progress_.text = GetI18NText(var_10_0 .. "/" .. self.cfg_.need)
	self.slider_.value = var_10_0 / self.cfg_.need

	if self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeCon_:SetSelectedState("normal")
	else
		self.typeCon_:SetSelectedState("challenge")
	end

	if self.info_.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif self.info_.progress >= self.cfg_.need then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end

	self.dailyCon_:SetSelectedState(tostring(self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY))
end

function ActivitySkinDrawTaskItemOld:OnExit()
	return
end

function ActivitySkinDrawTaskItemOld:Dispose()
	self:RemoveAllListeners()

	for iter_12_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_12_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ActivitySkinDrawTaskItemOld
