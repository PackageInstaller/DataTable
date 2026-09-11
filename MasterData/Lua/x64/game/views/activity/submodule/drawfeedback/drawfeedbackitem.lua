local DrawFeedbackItem = class("DrawFeedbackItem", ReduxView)

function DrawFeedbackItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function DrawFeedbackItem:SetData(arg_2_1)
	self.taskID_ = arg_2_1

	local var_2_0 = AssignmentCfg[arg_2_1]

	self.descText_.text = GetI18NText(AssignmentCfg[arg_2_1].desc)

	local var_2_1 = TaskData2:GetTask(arg_2_1)

	self.cntText_.text = string.format("%s/%s", (var_2_1.progress > var_2_0.need or nil) and (var_2_0.need or var_2_1.progress), var_2_0.need)
	self.sliderImage_.value = var_2_1.progress / var_2_0.need
	self.rewardItem_ = self.rewardItem_ or CommonItem.New(self.rewardGo_)

	self.rewardItem_:RefreshData(formatReward(var_2_0.reward[1]))
	self.rewardItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_2_0.reward[1])
	end)
	self.rewardItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	self:RefreshBtnState()
end

function DrawFeedbackItem:Dispose()
	DrawFeedbackItem.super.Dispose(self)

	if self.rewardItem_ then
		self.rewardItem_:Dispose()

		self.rewardItem_ = nil
	end
end

function DrawFeedbackItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function DrawFeedbackItem:RefreshBtnState()
	local var_7_0 = TaskData2:GetTask(self.taskID_)

	if var_7_0.complete_flag == 0 then
		if var_7_0.progress >= AssignmentCfg[self.taskID_].need then
			self.controller_:SetSelectedState("complete")
		else
			self.controller_:SetSelectedState("uncomplate")
		end
	elseif var_7_0.complete_flag >= 1 then
		self.controller_:SetSelectedState("finish")
	end
end

return DrawFeedbackItem
