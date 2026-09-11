local GodEaterTaskItem = class("GodEaterTaskItem", ReduxView)

function GodEaterTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.RefreshItem), self.uilistUilist_, CommonItemView)
	self.btnControlller = self.btn_one_s_allControllerexcollection_:GetController("all")
	self.lockControlller = self.bountyitemControllerexcollection_:GetController("lock")
	self.gradeControlller = self.bountyitemControllerexcollection_:GetController("grade")
	self.completeControlller = self.bountyitemControllerexcollection_:GetController("complete")

	self:AddUIListeners()

	self.reward = {}
end

function GodEaterTaskItem:AddUIListeners()
	self:AddBtnListener(self.btngoBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.id].source)
	end)
	self:AddBtnListener(self.btnreceiveBtn_, nil, function()
		if self.isCanReceive then
			TaskAction:SubmitTask(self.id)
		end
	end)
	self:AddBtnListener(self.btncomplete01Btn_, nil, function()
		return
	end)
	self:AddBtnListener(self.btnunlockedBtn_, nil, function()
		return
	end)
end

function GodEaterTaskItem:SetData(arg_7_1)
	if type(arg_7_1) == "table" and arg_7_1.state == "lock" then
		self.lockControlller:SetSelectedState("true")

		self.locktextText_.text = string.format(GetTips("GODEATER_DES_5"), arg_7_1.num)
	else
		self.lockControlller:SetSelectedState("false")
	end

	local var_7_0 = AssignmentCfg[arg_7_1]

	self.id = arg_7_1
	self.isDraw = false

	if var_7_0 then
		self.desctextText_.text = var_7_0.desc
		self.fillImg_.transform.localScale = Vector3.New(Mathf.Clamp(TaskData2:GetTaskProgress(arg_7_1) / var_7_0.need, 0, 1), 1, 1)
		self.processtextText_.text = math.min(TaskData2:GetTaskProgress(arg_7_1), var_7_0.need) .. "/" .. var_7_0.need

		self.gradeControlller:SetSelectedState(GodEaterTool.GetTaskType(arg_7_1) == 1 and "A" or "S")

		if AssignmentCfg[self.id] then
			self.reward = AssignmentCfg[self.id].reward or {}
		end

		self.complete_flag = TaskData2:GetTaskComplete(arg_7_1)
		self.isCompleteProcess = TaskData2:GetTaskProgress(arg_7_1) >= AssignmentCfg[arg_7_1].need
		self.isCanReceive = not self.complete_flag and self.isCompleteProcess
		self.titletextText_.text = var_7_0.name

		if self.complete_flag then
			self.btnControlller:SetSelectedState("complete")
			self.completeControlller:SetSelectedState("true")

			self.isDraw = true
		else
			if self.isCanReceive then
				self.btnControlller:SetSelectedState("receive")
			else
				self.btnControlller:SetSelectedState("lock")
			end

			self.completeControlller:SetSelectedState("false")
		end

		self.uiList_:StartScroll(#self.reward)
	end
end

function GodEaterTaskItem:RefreshItem(arg_8_1, arg_8_2)
	local var_8_0

	if AssignmentCfg[self.id] then
		var_8_0 = AssignmentCfg[self.id].reward or {}
	end

	arg_8_2:SetData({
		id = var_8_0[arg_8_1][1],
		number = var_8_0[arg_8_1][2],
		completedFlag = self.isDraw,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	})
end

function GodEaterTaskItem:Dispose()
	GodEaterTaskItem.super.Dispose(self)

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end
end

return GodEaterTaskItem
