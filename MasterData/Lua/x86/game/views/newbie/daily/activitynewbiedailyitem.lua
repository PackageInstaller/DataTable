local ActivityNewbieDailyItem = class("ActivityNewbieDailyItem", ReduxView)

function ActivityNewbieDailyItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = self.controllerExCollection_:GetController("state")
	self.lockTroller_ = ControllerUtil.GetController(self.transform_, "conName")
	self.countDownController_ = ControllerUtil.GetController(self.transform_, "countDown")
	self.parentWidth_ = self.transformParent_.rect.width / 2
	self.itemWidth_ = self.transform_.rect.width / 2
end

function ActivityNewbieDailyItem:Dispose()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
	ActivityNewbieDailyItem.super.Dispose(self)

	self.itemData_ = nil

	if self.rewardItem_ then
		self.rewardItem_:Dispose()

		self.rewardItem_ = nil
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityNewbieDailyItem:RegistListener(arg_3_1)
	self.func_ = arg_3_1
end

function ActivityNewbieDailyItem:AddListeners()
	self:AddBtnListener(self.buttonReceive_, nil, function()
		local var_5_0 = TaskData2:GetTask(self.taskID_)

		if var_5_0 then
			if var_5_0.complete_flag >= 1 then
				return
			elseif var_5_0.progress < AssignmentCfg[self.taskID_].need then
				JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
			else
				TaskAction:SubmitTask(self.taskID_)
			end
		end
	end)

	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
end

function ActivityNewbieDailyItem:onSubmitTaskResponse()
	self.controller_:SetSelectedState("2")

	if self.func_ then
		self.func_()
	end
end

function ActivityNewbieDailyItem:RefreshCountDown()
	local var_7_0

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
		var_7_0 = TaskData2:GetTask(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][self.index_ - 1])
	end

	if not TaskData2:GetTask(self.taskID_) and var_7_0 and var_7_0.complete_flag == 1 then
		self.countdownText_.text = tostring(manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime()))

		self.countDownController_:SetSelectedState("true")

		self.timer_ = Timer.New(function()
			local var_8_0 = manager.time:GetNextFreshTime() - manager.time:GetServerTime()

			self.countdownText_.text = tostring(manager.time:DescCDTime(var_8_0))

			if var_8_0 <= 0 then
				self:RefreshUI(self.index_)
				self.timer_:Stop()

				self.timer_ = nil
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.countDownController_:SetSelectedState("false")
	end
end

function ActivityNewbieDailyItem:RefreshUI(arg_9_1)
	self.index_ = arg_9_1
	self.textDay_.text = arg_9_1 < 10 and string.format("0<color=#3D3D3D>%s</color>", arg_9_1) or string.format("<color=#3D3D3D>%s</color>", arg_9_1)

	local var_9_0 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][arg_9_1]

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	local var_9_1 = AssignmentCfg[var_9_0]

	self.itemData_.id = AssignmentCfg[var_9_0].reward[1][1]
	self.itemData_.number = AssignmentCfg[var_9_0].reward[1][2]

	if self.rewardItem_ == nil then
		self.rewardItem_ = CommonItemPool.New(self.itemParent_, self.itemData_)
	else
		self.rewardItem_:SetData(self.itemData_)
	end

	self.taskID_ = var_9_0

	local var_9_2 = var_9_1.desc
	local var_9_3
	local var_9_5 = TaskData2:GetTask(var_9_0)

	if var_9_5 then
		local var_9_6 = var_9_5.progress

		if var_9_5.progress > var_9_1.need then
			var_9_6 = var_9_1.need
		end

		if var_9_5.complete_flag == 0 then
			if var_9_6 >= var_9_1.need then
				self.controller_:SetSelectedState("receive")
			else
				self.controller_:SetSelectedState("go")
			end
		else
			self.controller_:SetSelectedState("complete")

			var_9_6 = var_9_1.need
		end

		var_9_3 = string.format("%s/%s", var_9_6, var_9_1.need)

		self.lockTroller_:SetSelectedState("0")
	else
		self.controller_:SetSelectedState("0")
		self.lockTroller_:SetSelectedState("1")

		var_9_2 = ""
		var_9_3 = ""
	end

	self.textDesc_.text = var_9_2
	self.textProgress_.text = var_9_3

	self:RefreshCountDown()
end

function ActivityNewbieDailyItem:RefreshAlpha()
	self.canvasGroup_.alpha = 1 - math.abs(self.parentWidth_ - self.transformParent_:InverseTransformPoint(self.transform_:TransformPoint(Vector3.zero)).x - self.itemWidth_) / self.parentWidth_ * 0.5
end

return ActivityNewbieDailyItem
