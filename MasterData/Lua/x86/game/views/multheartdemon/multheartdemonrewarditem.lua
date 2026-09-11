local MultHeartDemonRewardItem = class("MultHeartDemonRewardItem", ReduxView)

function MultHeartDemonRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function MultHeartDemonRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonRewardItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.cfg then
			local var_4_0, var_4_1 = self:IsTaskInActivity()

			if var_4_0 then
				TaskAction:SubmitTask(self.cfg.id)
			else
				ShowTips(var_4_1)
			end
		end
	end)
end

function MultHeartDemonRewardItem:InitUI()
	self:BindCfgUI()

	self.controller = self.allBtnController_:GetController("all")
	self.rewardItems_ = {}

	SetActive(self[string.format("awardItem%dObj_", 3)], false)
end

function MultHeartDemonRewardItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index = arg_6_2
	self.data = arg_6_1
	self.type = arg_6_3

	self:UpdateView()
end

function MultHeartDemonRewardItem:UpdateView()
	for iter_7_0 = 1, 3 do
		SetActive(self[string.format("awardItem%dObj_", iter_7_0)], false)
	end

	self[self.type == 1 and "UpdateNormalView" or "UpdateRankView"](self)
end

function MultHeartDemonRewardItem:UpdateRankView()
	self.cfg = nil
	self.rewardCfg = MultHeartDemonRewardCfg[self.data]
	self.conditionCfg = ConditionCfg[self.rewardCfg.condition]
	self.titleText_.text = GetTipsF("SOLO_HEART_DEMON_REWARD_TIPS", (string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS1"), self.rewardCfg.reward_rank[1], self.rewardCfg.reward_rank[2])))

	for iter_8_0, iter_8_1 in ipairs(self.rewardCfg.reward_list) do
		if self.rewardItems_[iter_8_0] == nil then
			self.rewardItems_[iter_8_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_8_0)])
		end

		SetActive(self[string.format("awardItem%dObj_", iter_8_0)], true)

		local var_8_0 = clone(ItemTemplateData)

		var_8_0.id = iter_8_1[1]
		var_8_0.number = iter_8_1[2]
		var_8_0.completedFlag = false

		function var_8_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItems_[iter_8_0]:SetData(var_8_0)
	end
end

function MultHeartDemonRewardItem:UpdateNormalView()
	self.cfg = AssignmentCfg[self.data.id]
	self.taskData = TaskData2:GetTask(self.data.id)

	self.controller:SetSelectedState("lock")

	local var_10_0 = 0

	if self.taskData then
		var_10_0 = self.taskData.progress
	end

	if var_10_0 >= self.cfg.need then
		var_10_0 = self.cfg.need

		self.controller:SetSelectedState("receive")
	end

	if self.taskData ~= nil and TaskData2:GetTaskComplete(self.data.id) then
		self.controller:SetSelectedState("complete")
	end

	self.progressBar_.value = var_10_0 / self.cfg.need
	self.progressText_.text = var_10_0 .. "/" .. self.cfg.need
	self.titleText_.text = GetI18NText(self.cfg.desc)

	for iter_10_0, iter_10_1 in ipairs(self.cfg.reward) do
		if self.rewardItems_[iter_10_0] == nil then
			self.rewardItems_[iter_10_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_10_0)])
		end

		SetActive(self[string.format("awardItem%dObj_", iter_10_0)], true)

		local var_10_1 = clone(ItemTemplateData)

		var_10_1.id = iter_10_1[1]
		var_10_1.number = iter_10_1[2]
		var_10_1.completedFlag = TaskData2:GetTaskComplete(self.data.id)

		function var_10_1:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItems_[iter_10_0]:SetData(var_10_1)
	end

	for iter_10_2 = #self.cfg.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_2]:SetData(nil)
	end
end

function MultHeartDemonRewardItem:OnEnter()
	self:UpdateView()
end

function MultHeartDemonRewardItem:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	for iter_13_0, iter_13_1 in pairs(self.rewardItems_) do
		iter_13_1:Dispose()
	end

	self.rewardItems_ = {}

	MultHeartDemonRewardItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function MultHeartDemonRewardItem:IsTaskInActivity()
	local var_14_0 = nullable(self.cfg, "activity_id") or 0

	if var_14_0 ~= 0 then
		local var_14_1, var_14_2 = ActivityTools.GetActivityStatusWithTips(var_14_0)

		return var_14_1 == ActivityConst.ACTIVITY_STATE.ACTIVING, var_14_2
	end

	return true
end

return MultHeartDemonRewardItem
