local SummerChessBoardActivityTaskItem = class("SummerChessBoardActivityTaskItem", ReduxView)

function SummerChessBoardActivityTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.btnController_ = self.allBtnController_:GetController("all")
	self.timeTipsController_ = self.greyController_:GetController("TImeTips")
	self.rewardItems_ = {}

	for iter_1_0 = 1, 3 do
		self.rewardItems_[iter_1_0] = CommonItemView.New(self[string.format("awardItem%sObj_", iter_1_0)])
	end
end

function SummerChessBoardActivityTaskItem:OnExit()
	self:StopTimer()
end

function SummerChessBoardActivityTaskItem:Dispose()
	self:StopTimer()

	for iter_3_0, iter_3_1 in ipairs(self.rewardItems_) do
		iter_3_1:Dispose()
	end

	self.rewardItems_ = nil

	SummerChessBoardActivityTaskItem.super.Dispose(self)
end

function SummerChessBoardActivityTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function SummerChessBoardActivityTaskItem:SetData(arg_7_1, arg_7_2)
	self.taskID_ = arg_7_1

	local var_7_0 = AssignmentCfg[arg_7_1]
	local var_7_1 = TaskData2:GetTaskProgress(arg_7_1)

	self.progressBar_.value = var_7_1 / AssignmentCfg[arg_7_1].need
	self.titleText_.text = var_7_0.desc
	self.progressText_.text = string.format("%s/%s", math.min(var_7_1, var_7_0.need), var_7_0.need)

	for iter_7_0, iter_7_1 in ipairs(var_7_0.reward) do
		local var_7_2 = clone(ItemTemplateData)

		var_7_2.id = iter_7_1[1]
		var_7_2.number = iter_7_1[2]
		var_7_2.grayFlag = TaskData2:GetTaskComplete(arg_7_1)

		function var_7_2:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItems_[iter_7_0]:SetData(var_7_2)
	end

	for iter_7_2 = #var_7_0.reward + 1, 3 do
		self.rewardItems_[iter_7_2]:SetData()
	end

	if arg_7_2 then
		self.timeTipsController_:SetSelectedState("show")
		self:RefreshTimer()
		self:AddTimer()
	else
		self.timeTipsController_:SetSelectedState("false")
	end

	if TaskData2:GetTaskComplete(arg_7_1) then
		if self.greyCon_ then
			self.greyCon_:SetSelectedState("true")
		end

		self.btnController_:SetSelectedState("complete")
	else
		if self.greyCon_ then
			self.greyCon_:SetSelectedState("false")
		end

		if var_7_1 >= var_7_0.need then
			self.btnController_:SetSelectedState("receive")
		else
			self.btnController_:SetSelectedState("go")
		end
	end
end

function SummerChessBoardActivityTaskItem:RefreshTimer()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData(AssignmentCfg[self.taskID_].activity_id).stopTime)
	end
end

function SummerChessBoardActivityTaskItem:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:RefreshTimer()
	end, 1, -1)

	self.timer_:Start()
end

function SummerChessBoardActivityTaskItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SummerChessBoardActivityTaskItem
