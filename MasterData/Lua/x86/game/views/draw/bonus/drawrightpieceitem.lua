local DrawRightPieceItem = class("DrawRightPieceItem", ReduxView)

function DrawRightPieceItem:UIName()
	return "Widget/System/Pool/SendCharacterBtn"
end

function DrawRightPieceItem:Ctor(arg_2_1, arg_2_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), arg_2_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.taskIDList_ = {}
	self.stateController_ = self.controller_:GetController("state")
	self.headController1_ = self.controller1_:GetController("status")
	self.headController2_ = self.controller2_:GetController("status")
end

function DrawRightPieceItem:Dispose()
	self.onModifyBonusHandler_ = nil

	DrawRightPieceItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transfrom_ = nil
end

function DrawRightPieceItem:AddListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		DrawAction.GetPoolData(self.selectPoolID_)
	end)
end

function DrawRightPieceItem:SetData(arg_6_1, arg_6_2)
	self.activityID_ = arg_6_1
	self.selectPoolID_ = arg_6_2
	self.taskActivity_ = ActivityDrawPieceCfg[arg_6_1].task_activity
	self.taskIDList_ = {}

	for iter_6_0, iter_6_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[self.taskActivity_]) do
		table.insert(self.taskIDList_, iter_6_1)
	end

	table.sort(self.taskIDList_, function(arg_7_0, arg_7_1)
		local var_7_0 = AssignmentCfg[arg_7_1]
		local var_7_1 = TaskData2:GetTask(arg_7_0)
		local var_7_2 = TaskData2:GetTask(arg_7_1)
		local var_7_3 = TaskData2:GetTaskComplete(arg_7_0)
		local var_7_4 = TaskData2:GetTaskComplete(arg_7_1)
		local var_7_5 = var_7_1 and var_7_1.progress >= AssignmentCfg[arg_7_0].need or false
		local var_7_6 = var_7_2 and var_7_2.progress >= var_7_0.need or false

		if var_7_3 and not var_7_4 then
			return false
		elseif not var_7_3 and var_7_4 then
			return true
		elseif var_7_5 and not var_7_6 then
			return true
		elseif not var_7_5 and var_7_6 then
			return false
		else
			return arg_7_0 < arg_7_1
		end
	end)

	self.activeTask_ = 0

	for iter_6_2, iter_6_3 in ipairs(self.taskIDList_) do
		local var_6_0 = TaskData2:GetTask(iter_6_3)

		if not TaskData2:GetTaskComplete(iter_6_3) and (var_6_0 and var_6_0.progress >= AssignmentCfg[iter_6_3].need or false) then
			self.activeTask_ = iter_6_3

			break
		end
	end

	if self.activeTask_ == 0 then
		self.activeTask_ = self.taskIDList_[#self.taskIDList_]
	end

	local var_6_1 = AssignmentCfg[self.activeTask_]
	local var_6_2 = TaskData2:GetTask(self.activeTask_)

	if AssignmentCfg[self.activeTask_] then
		local var_6_3 = clone(ItemTemplateData)

		var_6_3.id = var_6_1.reward[1][1]
		var_6_3.number = var_6_1.reward[1][2]
		var_6_3.taskID = self.activeTask_

		function var_6_3:clickFun()
			local var_8_0 = TaskData2:GetTask(self.taskID)

			if (var_8_0 and var_8_0.progress >= AssignmentCfg[self.taskID].need or false) and not TaskData2:GetTaskComplete(self.taskID) then
				TaskAction:SubmitTaskList({
					self.taskID
				}, 0, function()
					self:RefreshText()
				end)
			else
				ShowPopItem(POP_ITEM, {
					self.id
				})
			end
		end

		if not self.item_ then
			self.item = CommonItemView.New(self.pieceItem1_, true)
		end

		self.item:SetData(var_6_3)
	end

	self:RefreshText()
end

function DrawRightPieceItem:CheckCompleteList(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self.taskIDList_) do
		local var_10_1 = TaskData2:GetTask(iter_10_1)

		if not TaskData2:GetTaskComplete(iter_10_1) and (var_10_1 and var_10_1.progress >= AssignmentCfg[iter_10_1].need or false) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	if #var_10_0 > 0 then
		self.stateController_:SetSelectedState("claimable")

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		if arg_10_1 then
			SetActive(arg_10_1.maskGo_, true)
		end

		self.timer_ = Timer.New(function()
			if arg_10_1 then
				SetActive(arg_10_1.maskGo_, false)
			end

			TaskAction:SubmitTaskList(var_10_0, 0, function()
				self:RefreshText()
			end)
			self.timer_:Stop()

			self.timer_ = nil
		end, 1, -1)

		self.timer_:Start()
	else
		SetActive(self.maskGo_, false)
		self.stateController_:SetSelectedState("normal")
	end
end

function DrawRightPieceItem:RefreshText()
	local var_13_0 = self.item:GetData()
	local var_13_1 = AssignmentCfg[self.activeTask_]
	local var_13_2 = TaskData2:GetTask(self.activeTask_)
	local var_13_3 = TaskData2:GetTaskComplete(self.activeTask_)

	var_13_0.highLight = not var_13_3 and (var_13_2 and var_13_2.progress >= AssignmentCfg[self.activeTask_].need or false)
	var_13_0.completedFlag = TaskData2:GetTaskComplete(var_13_3)
	var_13_0.grayFlag = TaskData2:GetTaskComplete(var_13_3)

	self.item:SetData(var_13_0)

	local var_13_4 = {}
	local var_13_5 = {}

	for iter_13_0, iter_13_1 in ipairs(self.taskIDList_) do
		local var_13_6 = AssignmentCfg[iter_13_1]
		local var_13_7 = TaskData2:GetTask(iter_13_1)
		local var_13_8

		if var_13_7 then
			var_13_8 = var_13_7.progress or 0
		end

		local var_13_9 = var_13_6.additional_parameter[1]

		if not var_13_5[var_13_6.additional_parameter[1]] then
			var_13_5[var_13_9] = true

			local var_13_11 = {
				roleID = var_13_9
			}

			var_13_11.progress = math.max(var_13_4[var_13_9] or 0, var_13_8)

			table.insert(var_13_4, var_13_11)
		end

		for iter_13_2, iter_13_3 in ipairs(var_13_4) do
			if iter_13_3.roleID == var_13_9 then
				iter_13_3.progress = math.max(iter_13_3.progress, var_13_8)

				break
			end
		end
	end

	table.sort(var_13_4, function(arg_14_0, arg_14_1)
		return arg_14_0.roleID < arg_14_1.roleID
	end)

	local var_13_12 = 0
	local var_13_13 = 0

	for iter_13_4, iter_13_5 in ipairs(var_13_4) do
		local var_13_14 = 0

		for iter_13_6, iter_13_7 in ipairs(self.taskIDList_) do
			if AssignmentCfg[iter_13_7].additional_parameter[1] == iter_13_5.roleID then
				var_13_14 = math.max(var_13_14, AssignmentCfg[iter_13_7].need)
			end
		end

		var_13_12 = var_13_12 + math.min(iter_13_5.progress, var_13_14)
		var_13_13 = var_13_13 + var_13_14
	end

	self.headController1_:SetSelectedIndex(var_13_4[1].progress)
	self.headController2_:SetSelectedIndex(var_13_4[2].progress)

	if not var_13_2 or not math.min(var_13_2.progress, var_13_1.need) then
		-- block empty
	end

	self.progressText1_.text = string.format("%s/%s", var_13_12, var_13_13)

	self:Show(true)
end

function DrawRightPieceItem:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function DrawRightPieceItem:Show(arg_16_1)
	SetActive(self.gameObject_, arg_16_1)
end

return DrawRightPieceItem
