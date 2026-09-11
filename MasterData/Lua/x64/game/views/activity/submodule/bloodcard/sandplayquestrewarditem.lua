local SandPlayQuestRewardItem = class("SandPlayQuestRewardItem", ReduxView)

function SandPlayQuestRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SandPlayQuestRewardItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemGoList_ = {}

	for iter_2_0 = 1, 3 do
		table.insert(self.itemGoList_, self["awardItem" .. iter_2_0 .. "Obj_"])
	end

	self.itemList_ = {}
	self.btnController_ = self.allBtnController_:GetController("all")
	self.tagController_ = self.controllers_:GetController("type")
	self.timeController_ = self.controllers_:GetController("time")
end

function SandPlayQuestRewardItem:InitUI()
	self:BindCfgUI()
end

function SandPlayQuestRewardItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function SandPlayQuestRewardItem:IndexItem(arg_6_1, arg_6_2)
	local var_6_0 = formatReward(self.rewardData_[arg_6_1])
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.num
	var_6_1.timeValid = var_6_0.timeValid or 0

	function var_6_1:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_6_2:SetData(var_6_1)
end

function SandPlayQuestRewardItem:SetData(arg_8_1)
	self.taskID_ = arg_8_1
	self.cfg_ = AssignmentCfg[arg_8_1]
	self.rewardData_ = self.cfg_.reward

	if not self.taskID_ or self.taskID_ == 0 then
		return
	end

	self:UpdateView()
	self:AddTimer()
end

function SandPlayQuestRewardItem:UpdateView()
	local var_9_0 = TaskData2:GetTaskComplete(self.taskID_)
	local var_9_1 = TaskData2:GetTaskProgress(self.taskID_) >= self.cfg_.need
	local var_9_2 = math.min(TaskData2:GetTaskProgress(self.taskID_), self.cfg_.need)

	self.titleText_.text = self.cfg_.condition == 51311 and string.format(self.cfg_.desc, HeroCfg[self.cfg_.additional_parameter[1]].suffix) or self.cfg_.desc
	self.progressText_.text = var_9_2 .. "/" .. self.cfg_.need
	self.progressBar_.value = var_9_2 / self.cfg_.need

	if var_9_0 then
		self.btnController_:SetSelectedState("complete")
	elseif var_9_1 then
		self.btnController_:SetSelectedState("receive")
	else
		self.btnController_:SetSelectedState("lock")
	end

	if self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.tagController_:SetSelectedState("normal")
	elseif self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		self.tagController_:SetSelectedState("challenge")
	end

	for iter_9_0, iter_9_1 in ipairs(self.itemGoList_) do
		self.itemList_[iter_9_0] = self.itemList_[iter_9_0] or CommonItemView.New(iter_9_1)

		if self.rewardData_[iter_9_0] then
			self:IndexItem(iter_9_0, self.itemList_[iter_9_0])
			SetActive(iter_9_1, true)
		else
			SetActive(iter_9_1, false)
		end
	end
end

function SandPlayQuestRewardItem:AddTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.timeController_:SetSelectedState("false")

	if not TaskData2:GetTask(self.taskID_) then
		return
	end

	local var_10_0 = TaskData2:GetTask(self.taskID_).expired_timestamp

	if self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		self.timeController_:SetSelectedState("false")

		return
	end

	if var_10_0 then
		if var_10_0 == 0 then
			self.timeController_:SetSelectedState("false")
		else
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_10_0, true)

			self.timeController_:SetSelectedState("true")

			self.timer_ = Timer.New(function()
				if manager.time:GetServerTime() > var_10_0 then
					return
				end

				self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_10_0, true)
			end, 1, -1)
		end

		self.timer_:Start()
	end
end

function SandPlayQuestRewardItem:Dispose()
	self:RemoveAllListeners()

	if self.itemList_ then
		for iter_12_0, iter_12_1 in ipairs(self.itemList_) do
			iter_12_1:Dispose()
		end
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	SandPlayQuestRewardItem.super.Dispose(self)
end

return SandPlayQuestRewardItem
