local XH1stSeamItemView = class("XH1stSeamItemView", ReduxView)

function XH1stSeamItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH1stSeamItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH1stSeamItemView:InitUI()
	self:BindCfgUI()

	self.itemController_ = ControllerUtil.GetController(self.gameObject_.transform, "item")
	self.itemtypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "itemtype")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function XH1stSeamItemView:AddUIListener()
	self.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.assignmentId_].source)
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		TaskAction:SubmitTask(self.assignmentId_)
	end)
end

function XH1stSeamItemView:AddEventListeners()
	return
end

function XH1stSeamItemView:SetData(arg_9_1, arg_9_2)
	self.index_ = arg_9_1
	self.assignmentId_ = arg_9_2
	self.assignmentCfg_ = AssignmentCfg[arg_9_2]

	self:UpdateView()
end

function XH1stSeamItemView:UpdateView()
	self.titleLabel_.text = GetI18NText(self.assignmentCfg_.desc)

	local var_10_0 = TaskData2:GetTask(self.assignmentId_).progress

	if var_10_0 > self.assignmentCfg_.need then
		var_10_0 = self.assignmentCfg_.need
	end

	self.progressBar_.value = math.min(1, var_10_0 / self.assignmentCfg_.need)
	self.progressLabel_.text = var_10_0 .. "/" .. self.assignmentCfg_.need

	self.commonItem_:RefreshData({
		id = self.assignmentCfg_.reward[1][1],
		number = self.assignmentCfg_.reward[1][2]
	})

	if self.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.itemtypeController_:SetSelectedState("daily")
	elseif self.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		self.itemtypeController_:SetSelectedState("challenge")
	else
		self.itemtypeController_:SetSelectedState("daily")
	end

	if TaskData2:GetTaskComplete(self.assignmentId_) then
		self.itemController_:SetSelectedState("received")
	elseif var_10_0 >= self.assignmentCfg_.need then
		self.itemController_:SetSelectedState("complete")
	else
		self.itemController_:SetSelectedState("normal")
	end
end

function XH1stSeamItemView:OnEnter()
	self:AddEventListeners()
end

function XH1stSeamItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH1stSeamItemView:OnMainHomeViewTop()
	return
end

function XH1stSeamItemView:Dispose()
	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	self.data_ = nil

	XH1stSeamItemView.super.Dispose(self)
end

return XH1stSeamItemView
