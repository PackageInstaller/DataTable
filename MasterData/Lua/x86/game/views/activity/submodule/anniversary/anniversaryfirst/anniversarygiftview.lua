local AnniversaryGiftView = class("AnniversaryGiftView", ReduxView)

function AnniversaryGiftView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function AnniversaryGiftView:OnEnter()
	self:UpdateItem()

	self.onSubmitResponse = handler(self, self.RefreshBtnState)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitResponse)
end

function AnniversaryGiftView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitResponse)
end

function AnniversaryGiftView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function AnniversaryGiftView:Dispose()
	AnniversaryGiftView.super.Dispose(self)
end

function AnniversaryGiftView:UpdateItem()
	self.taskID_ = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_ANNIVERSARY_EXTRA_TASK][1]

	local var_7_0 = AssignmentCfg[AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_ANNIVERSARY_EXTRA_TASK][1]]
	local var_7_1 = TaskData2:GetTask(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_ANNIVERSARY_EXTRA_TASK][1])

	if var_7_1 == nil then
		return
	end

	self.cntText_.text = string.format("%s/%s", (var_7_1.progress > var_7_0.need or nil) and (var_7_0.need or var_7_1.progress), var_7_0.need)
	self.sliderImage_.fillAmount = var_7_1.progress / var_7_0.need

	self:RefreshBtnState()
end

function AnniversaryGiftView:RefreshBtnState()
	local var_8_0 = TaskData2:GetTask(self.taskID_)

	if var_8_0.complete_flag == 0 then
		if var_8_0.progress >= AssignmentCfg[self.taskID_].need then
			self.controller_:SetSelectedState("complete")
		else
			self.controller_:SetSelectedState("uncomplate")
		end
	elseif var_8_0.complete_flag >= 1 then
		self.controller_:SetSelectedState("finish")
	end
end

return AnniversaryGiftView
