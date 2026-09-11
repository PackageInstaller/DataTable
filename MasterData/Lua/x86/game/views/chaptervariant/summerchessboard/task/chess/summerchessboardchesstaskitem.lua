local SummerChessBoardChessTaskItem = class("SummerChessBoardChessTaskItem", ReduxView)

function SummerChessBoardChessTaskItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.btnController_ = self.allBtnController_:GetController("all")
	self.timeTipsController_ = self.greyController_:GetController("TImeTips")
	self.rewardItems_ = {}

	for iter_1_0 = 1, 3 do
		self.rewardItems_[iter_1_0] = CommonItemView.New(self[string.format("awardItem%sObj_", iter_1_0)])
	end
end

function SummerChessBoardChessTaskItem:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.rewardItems_) do
		iter_2_1:Dispose()
	end

	self.rewardItems_ = nil

	SummerChessBoardChessTaskItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SummerChessBoardChessTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function SummerChessBoardChessTaskItem:SetData(arg_6_1)
	self.taskID_ = arg_6_1

	local var_6_0 = TaskData2:GetTaskProgress(arg_6_1)

	self.progressBar_.value = var_6_0 / AssignmentCfg[arg_6_1].need
	self.titleText_.text = AssignmentCfg[arg_6_1].desc
	self.progressText_.text = string.format("%s/%s", var_6_0, AssignmentCfg[arg_6_1].need)

	for iter_6_0, iter_6_1 in ipairs(AssignmentCfg[arg_6_1].reward) do
		local var_6_1 = clone(ItemTemplateData)

		var_6_1.id = iter_6_1[1]
		var_6_1.number = iter_6_1[2]
		var_6_1.grayFlag = TaskData2:GetTaskComplete(arg_6_1)

		function var_6_1:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItems_[iter_6_0]:SetData(var_6_1)
	end

	for iter_6_2 = #AssignmentCfg[arg_6_1].reward + 1, 3 do
		self.rewardItems_[iter_6_2]:SetData()
	end

	self.timeTipsController_:SetSelectedState("false")

	if TaskData2:GetTaskComplete(arg_6_1) then
		self.btnController_:SetSelectedState("complete")
	elseif var_6_0 >= AssignmentCfg[arg_6_1].need then
		self.btnController_:SetSelectedState("receive")
	else
		self.btnController_:SetSelectedState("go")
	end
end

return SummerChessBoardChessTaskItem
