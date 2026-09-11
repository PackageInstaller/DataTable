local AchievementInfoItem = class("AchievementInfoItem", ReduxView)

function AchievementInfoItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.rewardItems_ = {}

	for iter_1_0 = 1, 3 do
		self.rewardItems_[iter_1_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_1_0)])
	end

	self:AddListeners()

	self.controller_ = self.allBtnController_:GetController("all")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "category")
end

function AchievementInfoItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		AchievementAction.GetReceiveReward(self.achievementID_)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		if AchievementCfg[self.achievementID_].source[1] == nil then
			print("成就的跳转是空的", self.achievementID_)

			return
		end

		AchievementData:SetScrollRecord(true)
		JumpTools.JumpToPage2(AchievementCfg[self.achievementID_].source)
	end)
end

function AchievementInfoItem:SetData(arg_5_1)
	local var_5_0 = AchievementCfg[arg_5_1]

	if arg_5_1 ~= self.achievementID_ then
		self.nameText_.text = GetI18NText(var_5_0.name)
		self.titleText_.text = GetI18NText(var_5_0.desc)
	end

	local var_5_1 = AchievementData:GetAchievementData(arg_5_1)

	if var_5_1.rewardState == 0 then
		self.controller_:SetSelectedState("go")

		self.progressText_.text = string.format("%s/%s", var_5_1.process, var_5_0.need)
		self.progressBar_.value = var_5_1.process / var_5_0.need

		for iter_5_0, iter_5_1 in pairs(var_5_0.reward) do
			local var_5_2 = clone(ItemTemplateData)

			var_5_2.id = iter_5_1[1]
			var_5_2.number = iter_5_1[2]

			function var_5_2:clickFun()
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end

			self.rewardItems_[iter_5_0]:SetData(var_5_2)
		end

		for iter_5_2 = #var_5_0.reward + 1, 3 do
			self.rewardItems_[iter_5_2]:SetData(nil)
		end
	elseif var_5_1.rewardState == 1 then
		self.controller_:SetSelectedState("receive")

		self.progressText_.text = string.format("%s/%s", var_5_0.need, var_5_0.need)
		self.progressBar_.value = 1

		for iter_5_3, iter_5_4 in pairs(var_5_0.reward) do
			local var_5_3 = clone(ItemTemplateData)

			var_5_3.id = iter_5_4[1]
			var_5_3.number = iter_5_4[2]

			function var_5_3:clickFun()
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end

			self.rewardItems_[iter_5_3]:SetData(var_5_3)
		end

		for iter_5_5 = #var_5_0.reward + 1, 3 do
			self.rewardItems_[iter_5_5]:SetData(nil)
		end
	else
		self.controller_:SetSelectedState("complete")

		self.progressText_.text = string.format("%s/%s", var_5_0.need, var_5_0.need)
		self.progressBar_.value = 1

		for iter_5_6, iter_5_7 in pairs(var_5_0.reward) do
			local var_5_4 = clone(ItemTemplateData)

			var_5_4.id = iter_5_7[1]
			var_5_4.number = iter_5_7[2]
			var_5_4.grayFlag = true

			function var_5_4:clickFun()
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end

			self.rewardItems_[iter_5_6]:SetData(var_5_4)
		end

		for iter_5_8 = #var_5_0.reward + 1, 3 do
			self.rewardItems_[iter_5_8]:SetData(nil)
		end

		self.textFinishTime_.text = manager.time:DescCTime(var_5_1.timestamp, "%Y/%m/%d")
	end

	self.typeController_:SetSelectedState(var_5_0.type_id)

	self.achievementID_ = arg_5_1
end

function AchievementInfoItem:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.rewardItems_) do
		if iter_9_1 then
			iter_9_1:Dispose()
		end
	end

	self.rewardItems_ = nil

	AchievementInfoItem.super.Dispose(self)
end

return AchievementInfoItem
