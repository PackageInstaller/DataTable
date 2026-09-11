local var_0_0 = class("", ReduxView)

function var_0_0:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.btnController_ = self.controllerEx_:GetController("default0")
	self.rewardItemList_ = {}

	for iter_1_0 = 1, 3 do
		self.rewardItemList_[iter_1_0] = CommonItemView.New(self[string.format("rewardItem%s_", iter_1_0)])
	end
end

function var_0_0:Dispose()
	var_0_0.super.Dispose(self)

	for iter_2_0, iter_2_1 in ipairs(self.rewardItemList_) do
		iter_2_1:Dispose()
	end

	self.rewardItemList_ = nil
end

function var_0_0:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function var_0_0:SetData(arg_5_1, arg_5_2)
	self.rewardIndex_ = arg_5_1
	self.taskID_ = arg_5_2

	self:RefreshUI()
end

function var_0_0:RefreshUI()
	self.textPhase_.text = string.format("%02d", self.rewardIndex_)
	self.textPhase2_.text = string.format("%02d", self.rewardIndex_)
	self.progressCntText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_6_0 = TaskData2:GetTaskProgress(self.taskID_)

	self.progressText_.text = string.format("%s/%s", var_6_0, AssignmentCfg[self.taskID_].need)
	self.progressBar_.value = var_6_0 / AssignmentCfg[self.taskID_].need

	local var_6_1 = TaskData2:GetTaskComplete(self.taskID_)

	if var_6_1 then
		self.btnController_:SetSelectedState("received")
	elseif AssignmentCfg[self.taskID_].need <= var_6_0 then
		self.btnController_:SetSelectedState("clear")
	else
		self.btnController_:SetSelectedState("notclear")
	end

	self:RefreshItem(var_6_1)
end

function var_0_0:RefreshItem(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(AssignmentCfg[self.taskID_].reward) do
		local var_7_0 = clone(ItemTemplateData)

		var_7_0.id = iter_7_1[1]
		var_7_0.number = iter_7_1[2]
		var_7_0.grayFlag = arg_7_1 == true

		function var_7_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItemList_[iter_7_0]:SetData(var_7_0)
	end

	for iter_7_2 = #AssignmentCfg[self.taskID_].reward + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_7_2]:SetData(nil)
	end
end

return var_0_0
