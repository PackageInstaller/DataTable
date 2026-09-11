local CommonActivityTaskItem = class("CommonActivityTaskItem", ReduxView)

function CommonActivityTaskItem:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow_ = true

	self:InitUI()
	self:AddListeners()
end

function CommonActivityTaskItem:RefreshTaskItem(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self.taskID_ = arg_2_1
	self.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshProgress()
	self:RefreshUI()

	self.isShow_ = true
end

function CommonActivityTaskItem:OnExit()
	self.isShow_ = false
end

function CommonActivityTaskItem:Dispose()
	self:RemoveListeners()

	for iter_4_0, iter_4_1 in pairs(self.rewardItems_) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	self.rewardItems_ = nil

	self:StopTimer()
	CommonActivityTaskItem.super.Dispose(self)
end

local var_0_1 = {
	"awardItem1Obj_",
	"awardItem2Obj_",
	"awardItem3Obj_",
	"rewardItem_"
}

local function var_0_2(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0 then
		return nil
	end

	arg_5_3 = arg_5_3 or arg_5_2

	return arg_5_0:GetController(arg_5_2) or ControllerUtil.GetController(arg_5_1, arg_5_2)
end

function CommonActivityTaskItem:BindCfgUIAlias()
	self.allBtnController_ = self.allBtnController_ or self.controllerEx_ or self.itemCon_
	self.controllers_ = self.controllers_ or self.allBtnController_
end

function CommonActivityTaskItem:InitUI()
	self:BindCfgUI()
	self:BindCfgUIAlias()

	self.controller = var_0_2(self.allBtnController_, self.transform_, "state")
	self.buttonController = self.allBtnController_:GetController("all")
	self.progressBar_ = self.progressBar_ or self.slider_
	self.progress_ = self.progress_ or self.progressText_
	self.desc_ = self.desc_ or self.titleText_ or self.descText_
	self.receiveBtn_ = self.receiveBtn_ or self.btn_
	self.typeController = var_0_2(self.controllers_, self.transform_, "type")
	self.timeController = var_0_2(self.controllers_, self.transform_, "time")

	for iter_7_0, iter_7_1 in ipairs(var_0_1) do
		if not isNil(self[iter_7_1]) then
			table.insert(self.rewardItems_, CommonItemView.New(self[iter_7_1].gameObject, true))
		end
	end
end

function CommonActivityTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)

	if self.goBtn_ and not isNil(self.goBtn_) then
		self:AddBtnListener(self.goBtn_, nil, function()
			JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
		end)
	end
end

function CommonActivityTaskItem:RemoveListeners()
	self.receiveBtn_.onClick:RemoveAllListeners()
end

local function var_0_3(arg_12_0)
	local var_12_0 = TaskData2:GetTask(arg_12_0).expired_timestamp

	if var_12_0 and var_12_0 > 0 then
		return var_12_0
	end

	return nil
end

function CommonActivityTaskItem:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function CommonActivityTaskItem:StartTimer(arg_14_1)
	self:StopTimer()

	self.timer = Timer.New(function()
		if manager.time:GetServerTime() > arg_14_1 then
			self:StopTimer()

			return
		end

		self:UpdateTaskLimitTime(arg_14_1)
	end, 1, -1)

	self.timer:Start()
end

function CommonActivityTaskItem:UpdateTaskRewards(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self.rewardItems_) do
		local var_16_0 = cfgToItemTemplate(arg_16_1[iter_16_0])

		if var_16_0 then
			var_16_0.grayFlag = self.taskComplete_
			var_16_0.clickFun = handler(self, self.OnClickCommonItem)
		end

		iter_16_1:SetData(var_16_0)
	end
end

local function var_0_4(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0 and not isNil(arg_17_1) then
		arg_17_1.text = manager.time:GetLostTimeStrWith2Unit(arg_17_0, true)
	end

	if arg_17_2 then
		arg_17_2:SetSelectedState(arg_17_0 and "true" or "false")
	end
end

function CommonActivityTaskItem:UpdateTaskLimitTime(arg_18_1)
	if not arg_18_1 then
		self:StopTimer()
		var_0_4(nil, self.timeText_, self.timeController)
	else
		self:StartTimer(arg_18_1)
		var_0_4(arg_18_1, self.timeText_, self.timeController)
	end
end

function CommonActivityTaskItem:UpdateTaskType(arg_19_1)
	if self.typeController ~= nil then
		if arg_19_1 == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
			self.typeController:SetSelectedState("normal")
		elseif AssignmentCfg[self.taskID_].activity_id == ActivityConst.AUTO_COOK or AssignmentCfg[self.taskID_].activity_id == ActivityConst.ACTIVITY_BLOOD_CARD_TASK or AssignmentCfg[self.taskID_].activity_id == ActivityConst.ACTIVITY_SPRING_QUIZ_TASK then
			self.typeController:SetSelectedState("nolabels")
		else
			self.typeController:SetSelectedState("challenge")
		end
	end
end

function CommonActivityTaskItem:RefreshUI()
	self.desc_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	self:UpdateTaskRewards(AssignmentCfg[self.taskID_].reward or {})
	self:UpdateTaskLimitTime((AssignmentCfg[self.taskID_].type ~= TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE or nil) and var_0_3(self.taskID_))
	self:UpdateTaskType(AssignmentCfg[self.taskID_].type)
end

local var_0_5 = {
	go = "go",
	received = "complete",
	unfinish = "lock",
	complete = "receive"
}

local function var_0_6(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0 then
		arg_21_0:SetSelectedState(var_0_5[arg_21_2])
	else
		arg_21_1:SetSelectedState(arg_21_2)
	end
end

local function var_0_7(arg_22_0)
	if arg_22_0 and next(arg_22_0) then
		return true
	end

	return false
end

function CommonActivityTaskItem:RefreshProgress()
	local var_23_0 = AssignmentCfg[self.taskID_]
	local var_23_1 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_23_1 = var_23_0.need
	end

	if self.progressBar_ then
		self.progressBar_.value = var_23_1 / var_23_0.need
	end

	if self.progress_ then
		self.progress_.text = string.format("%s/%s", var_23_1, var_23_0.need)
	end

	local var_23_2 = self.taskProgress >= var_23_0.need

	if self.taskComplete_ then
		var_0_6(self.buttonController, self.controller, "received")
	elseif var_23_2 then
		var_0_6(self.buttonController, self.controller, "complete")
	elseif self.goBtn_ and not isNil(self.goBtn_) and var_0_7(var_23_0.source) then
		var_0_6(self.buttonController, self.controller, "go")
	else
		var_0_6(self.buttonController, self.controller, "unfinish")
	end
end

function CommonActivityTaskItem:OnClickCommonItem(arg_24_1)
	ShowPopItem(POP_ITEM, {
		arg_24_1.id,
		arg_24_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return CommonActivityTaskItem
