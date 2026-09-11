local TaskPlotPhaseView = class("TaskPlotPhaseView", ReduxView)

function TaskPlotPhaseView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.rewardItems_ = {}
	self.goRewardParent_ = {
		CommonItemView.New(self.goItem1_),
		CommonItemView.New(self.goItem2_),
		CommonItemView.New(self.goItem3_)
	}
	self.goItemTemplate_ = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	self.btnController = self.phaseController_:GetController("default0")

	self:AddListeners()
end

function TaskPlotPhaseView:AddListeners()
	self:AddBtnListener(self.awardBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function TaskPlotPhaseView:RefreshUI()
	self.taskID_ = TaskTools:GetPlotPhaseID()

	if self.taskID_ == nil then
		return
	end

	local var_4_0 = TaskData2:GetTask(self.taskID_)
	local var_4_1 = AssignmentCfg[self.taskID_]
	local var_4_2 = var_4_0.progress

	if var_4_0.complete_flag >= 1 then
		SetActive(self.awardBtn_.gameObject, false)
		SetActive(self.activeAnimator_, false)

		var_4_2 = var_4_1.need

		self.btnController:SetSelectedState("1")
	elseif var_4_2 < var_4_1.need then
		SetActive(self.awardBtn_.gameObject, false)
		SetActive(self.activeAnimator_, false)
		self.btnController:SetSelectedState("1")
	else
		SetActive(self.awardBtn_.gameObject, true)
		SetActive(self.activeAnimator_, true)

		var_4_2 = var_4_1.need

		self.btnController:SetSelectedState("2")
	end

	self.imageProgress_.value = var_4_2 / var_4_1.need
	self.textNum_.text = string.format("<color=#FFA456><size=56>%s</size></color>/%s", var_4_2, var_4_1.need)
	self.textTitle_.text = GetI18NText(var_4_1.name)
	self.textContent_.text = GetI18NText(var_4_1.desc)

	self:RefreshReward(var_4_1.reward)
end

function TaskPlotPhaseView:RefreshReward(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_0 = formatReward(iter_5_1)

		self.goItemTemplate_[iter_5_0].id = var_5_0.id
		self.goItemTemplate_[iter_5_0].number = var_5_0.number
		self.goItemTemplate_[iter_5_0].timeValid = iter_5_1.timeValid or 0
		self.goItemTemplate_[iter_5_0].completedFlag = TaskData2:GetTaskComplete(self.taskID_)
		self.goItemTemplate_[iter_5_0].clickFun = handler(self, self.OnClickCommonItem)

		self.goRewardParent_[iter_5_0]:SetData(self.goItemTemplate_[iter_5_0])
	end

	for iter_5_2 = #arg_5_1 + 1, 3 do
		self.goRewardParent_[iter_5_2]:SetData(nil)
	end
end

function TaskPlotPhaseView:Dispose()
	TaskPlotPhaseView.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.goRewardParent_) do
		iter_6_1:Dispose()
	end

	self.goRewardParent_ = nil
end

function TaskPlotPhaseView:OnClickCommonItem(arg_7_1)
	ShowPopItem(POP_ITEM, {
		arg_7_1.id,
		arg_7_1.number
	})
end

return TaskPlotPhaseView
