local AnniversaryTaskItem = class("AnniversaryTaskItem", ReduxView)

function AnniversaryTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function AnniversaryTaskItem:SetData(arg_2_1)
	self.taskID_ = arg_2_1

	local var_2_0 = AssignmentCfg[arg_2_1]

	self.descText_.text = GetI18NText(AssignmentCfg[arg_2_1].desc)

	local var_2_1 = TaskData2:GetTask(arg_2_1)

	self.cntText_.text = string.format("%s/%s", (var_2_1.progress > var_2_0.need or nil) and (var_2_0.need or var_2_1.progress), var_2_0.need)
	self.sliderImage_.fillAmount = var_2_1.progress / var_2_0.need
	self.rewardItem_ = self.rewardItem_ or CommonItem.New(self.rewardGo_)

	self.rewardItem_:RefreshData(formatReward(var_2_0.reward[1]))
	self.rewardItem_:RegistCallBack(function(arg_3_0)
		ShowPopItem(POP_ITEM, arg_3_0)
	end)
	self.rewardItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	self:RefreshBtnState()
end

function AnniversaryTaskItem:Dispose()
	AnniversaryTaskItem.super.Dispose(self)
	self:StopTimer()

	if self.rewardItem_ then
		self.rewardItem_:Dispose()

		self.rewardItem_ = nil
	end
end

function AnniversaryTaskItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function AnniversaryTaskItem:RefreshBtnState()
	local var_7_0 = TaskData2:GetTask(self.taskID_)

	if var_7_0.complete_flag == 0 then
		if var_7_0.progress >= AssignmentCfg[self.taskID_].need then
			self.controller_:SetSelectedState("complete")
		elseif AssignmentCfg[self.taskID_].activity_id ~= 0 then
			if manager.time:GetServerTime() < ActivityData:GetActivityData(AssignmentCfg[self.taskID_].activity_id).startTime then
				self.controller_:SetSelectedState("lock")
				self:AddTimer()
			else
				self.controller_:SetSelectedState("uncomplate")
			end
		else
			self.controller_:SetSelectedState("uncomplate")
		end
	elseif var_7_0.complete_flag >= 1 then
		self.controller_:SetSelectedState("finish")
	end
end

function AnniversaryTaskItem:AddTimer()
	if self.timer_ then
		self:StopTimer()
	end

	local var_8_0 = ActivityData:GetActivityData(AssignmentCfg[self.taskID_].activity_id).startTime

	if self.timeText_ then
		self.timeText_.text = string.format(GetTips("LATER"), manager.time:GetLostTimeStr(var_8_0))
	end

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_8_0 then
			self.controller_:SetSelectedState("uncomplate")
			self:StopTimer()

			return
		end

		if self.timeText_ then
			self.timeText_.text = string.format(GetTips("LATER"), manager.time:GetLostTimeStr(var_8_0))
		end
	end, 1, -1)

	self.timer_:Start()
end

function AnniversaryTaskItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return AnniversaryTaskItem
