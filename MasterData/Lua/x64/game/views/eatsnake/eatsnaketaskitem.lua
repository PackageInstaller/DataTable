local EatSnakeTaskItem = class("EatSnakeTaskItem", ReduxView)

function EatSnakeTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function EatSnakeTaskItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakeTaskItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityId) then
			return
		end

		TaskAction:SubmitTask(self.data.id)
	end)
end

function EatSnakeTaskItem:InitUI()
	self:BindCfgUI()

	self.controller = self.allBtnController_:GetController("all")
	self.rewardItems_ = {}
end

function EatSnakeTaskItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index = arg_6_2
	self.data = arg_6_1
	self.activityId = arg_6_3

	self:UpdateView()
end

function EatSnakeTaskItem:UpdateView()
	self:UpdateNormalView()
end

function EatSnakeTaskItem:UpdateNormalView()
	self.cfg = AssignmentCfg[self.data.id]
	self.taskData = TaskData2:GetTask(self.data.id)

	self.controller:SetSelectedState("lock")

	local var_8_0 = 0

	if self.taskData then
		var_8_0 = self.taskData.progress
	end

	if var_8_0 >= self.cfg.need then
		var_8_0 = self.cfg.need

		self.controller:SetSelectedState("receive")
	end

	if self.taskData ~= nil and TaskData2:GetTaskComplete(self.data.id) then
		self.controller:SetSelectedState("complete")
	end

	self.progressBar_.value = var_8_0 / self.cfg.need
	self.progressText_.text = var_8_0 .. "/" .. self.cfg.need
	self.titleText_.text = string.format(GetI18NText(self.cfg.desc), self.cfg.need)
	self.remainTxt_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self.activityId).stopTime, true)

	for iter_8_0, iter_8_1 in ipairs(self.cfg.reward) do
		if self.rewardItems_[iter_8_0] == nil then
			self.rewardItems_[iter_8_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_8_0)])
		end

		SetActive(self[string.format("awardItem%dObj_", iter_8_0)], true)

		local var_8_1 = clone(ItemTemplateData)

		var_8_1.id = iter_8_1[1]
		var_8_1.number = iter_8_1[2]
		var_8_1.grayFlag = TaskData2:GetTaskComplete(self.data.id)

		function var_8_1:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItems_[iter_8_0]:SetData(var_8_1)
	end

	for iter_8_2 = #self.cfg.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_2]:SetData(nil)
	end
end

function EatSnakeTaskItem:OnEnter()
	self:UpdateView()
end

function EatSnakeTaskItem:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	for iter_11_0, iter_11_1 in pairs(self.rewardItems_) do
		iter_11_1:Dispose()
	end

	self.rewardItems_ = {}

	EatSnakeTaskItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return EatSnakeTaskItem
