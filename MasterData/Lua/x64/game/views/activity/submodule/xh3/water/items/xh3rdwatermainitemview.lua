local XH3rdWaterMainItemView = class("XH3rdWaterMainItemView", ReduxView)

function XH3rdWaterMainItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH3rdWaterMainItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterMainItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.typeController_ = ControllerUtil.GetController(self.gameObject_.transform, "type")
	self.commonItem_ = CommonItem.New(self.rewardItem_)
end

function XH3rdWaterMainItemView:AddUIListener()
	self.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityId_) then
			return
		end

		TaskAction:SubmitTask(self.assignmentId_)
	end)
end

function XH3rdWaterMainItemView:AddEventListeners()
	return
end

function XH3rdWaterMainItemView:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1
	self.assignmentId_ = arg_8_2
	self.assignmentCfg_ = AssignmentCfg[arg_8_2]
	self.activityId_ = arg_8_3

	self:UpdateView()
end

function XH3rdWaterMainItemView:UpdateView()
	if self.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeController_:SetSelectedState("daily")
	elseif self.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		self.typeController_:SetSelectedState("challenge")
	else
		self.typeController_:SetSelectedState("daily")
	end

	self.desc_.text = self.assignmentCfg_.desc

	local var_9_0 = TaskData2:GetTask(self.assignmentId_)
	local var_9_1 = 0

	if var_9_0 then
		var_9_1 = var_9_0.progress
	end

	if var_9_1 > self.assignmentCfg_.need then
		var_9_1 = self.assignmentCfg_.need
	end

	self.slider_.value = math.min(1, var_9_1 / self.assignmentCfg_.need)
	self.progress_.text = var_9_1 .. "/" .. self.assignmentCfg_.need

	self.commonItem_:RefreshData((rewardToItemTemplate((formatReward(self.assignmentCfg_.reward[1])))))

	if not ActivityData:GetActivityIsOpen(self.activityId_) then
		self.statusController_:SetSelectedState("gray")
	elseif var_9_0 ~= nil and TaskData2:GetTaskComplete(self.assignmentId_) then
		self.statusController_:SetSelectedState("received")
	elseif var_9_1 >= self.assignmentCfg_.need then
		self.statusController_:SetSelectedState("complete")
	else
		self.statusController_:SetSelectedState("unfinish")
	end
end

function XH3rdWaterMainItemView:OnEnter()
	self:AddEventListeners()
end

function XH3rdWaterMainItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH3rdWaterMainItemView:OnMainHomeViewTop()
	return
end

function XH3rdWaterMainItemView:Dispose()
	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	self.data_ = nil

	XH3rdWaterMainItemView.super.Dispose(self)
end

return XH3rdWaterMainItemView
