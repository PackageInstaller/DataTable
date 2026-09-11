local SnowballQuestItem = class("SnowballQuestItem", ReduxView)

function SnowballQuestItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SnowballQuestItem:Init()
	self:BindCfgUI()

	self.typeController = ControllerUtil.GetController(self.transform_, "type")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")

	self:AddBtnListenerScale(self.btn_, nil, handler(self, self.SubmitQuest))

	self.rewardItems = self:UseUIListForRewards() and LuaList.New(handler(self, self.RenderRewardListItem), self.rewardListGo_, CommonItem) or {}
end

function SnowballQuestItem:UseUIListForRewards()
	return self.rewardListGo_ ~= nil
end

function SnowballQuestItem:SubmitQuest()
	TaskAction:SubmitTask(self.taskID)
end

function SnowballQuestItem:RenderRewardListItem(arg_5_1, arg_5_2)
	local var_5_0 = self.cfg.reward[arg_5_1]

	arg_5_2:RefreshData(formatReward(self.cfg.reward[arg_5_1]))
	arg_5_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_5_0)
		OperationRecorder.Record(RewardItem.__cname, "open_pop_item")
	end)
end

function SnowballQuestItem:SetData(arg_7_1, arg_7_2)
	self.taskID = arg_7_1
	self.taskActivityID = arg_7_2
	self.info = TaskData2:GetTask(arg_7_1)
	self.cfg = AssignmentCfg[arg_7_1]

	self:RefreshReward()
	self:RefreshTask()

	if self.typeController then
		self.typeController:SetSelectedState(self.cfg.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY and "normal" or "challenge")
	end
end

function SnowballQuestItem:RefreshReward()
	if self:UseUIListForRewards() then
		self.rewardItems:StartScroll(#self.cfg.reward)
	else
		local var_8_0 = #self.cfg.reward

		for iter_8_0, iter_8_1 in ipairs(self.cfg.reward) do
			if not self.rewardItems[iter_8_0] then
				self.rewardItems[iter_8_0] = RewardItem.New(self.rewardItem_, self.rewardParent_)

				self.rewardItems[iter_8_0]:UpdateCommonItemAni()
			end

			self.rewardItems[iter_8_0]:SetData(iter_8_1)
		end

		for iter_8_2 = var_8_0 + 1, #self.rewardItems do
			self.rewardItems[iter_8_2]:Show(false)
		end
	end
end

function SnowballQuestItem:RefreshTask()
	self.desc_.text = self.cfg.desc

	local var_9_0 = 0

	var_9_0 = self.info.progress >= self.cfg.need and self.cfg.need or self.info.progress
	self.progress_.text = var_9_0 .. "/" .. self.cfg.need
	self.slider_.value = var_9_0 / self.cfg.need

	if self.info.complete_flag >= 1 then
		self.stateController:SetSelectedState("received")
	elseif var_9_0 >= self.cfg.need then
		self.stateController:SetSelectedState("complete")
	else
		self.stateController:SetSelectedState("unfinish")
	end
end

function SnowballQuestItem:Dispose()
	self:RemoveAllListeners()

	if self:UseUIListForRewards() then
		self.rewardItems:Dispose()
	else
		for iter_10_0 = 1, #self.rewardItems do
			self.rewardItems[iter_10_0]:Dispose()
		end
	end

	self.rewardItems = nil

	self.super.Dispose(self)
end

return SnowballQuestItem
