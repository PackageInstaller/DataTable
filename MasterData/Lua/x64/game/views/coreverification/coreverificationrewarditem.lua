local CoreVerificationRewardItem = class("CoreVerificationRewardItem", ReduxView)

function CoreVerificationRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function CoreVerificationRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationRewardItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.type_ < 5 then
			if CoreVerificationRewardCfg[self.data_].reward_type ~= 4 and CoreVerificationData:GetCanReset() then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CORE_VERIFICATION_RESETTIPS3"),
					OkCallback = function()
						self:GetReward()
					end
				})
			else
				self:GetReward()
			end
		elseif self.type_ == 5 then
			-- block empty
		elseif CoreVerificationChallengeTools.IsJumpAllStage(self.activityId_) then
			self:GetReward()
		elseif CoreVerificationChallengeData:IsGetTaskReward() then
			self:GetReward()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CORE_VERIFICATION_CL_LOCK_TIPS_1"),
				OkCallback = function()
					self:GetReward()
				end
			})
		end
	end)
end

function CoreVerificationRewardItem:GetReward()
	if self.type_ < 5 then
		CoreVerificationAction.GetReward({
			reward_list = {
				self.data_
			}
		})
	else
		CoreVerificationChallengeTools.GetReward(self.activityId_, {
			self.data_
		})
	end

	self.controller_:SetSelectedState("complete")
end

function CoreVerificationRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.controller_ = self.allBtnController_:GetController("all")
	self.processCon_ = self.processController_:GetController("Progressbar")
end

function CoreVerificationRewardItem:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.data_ = arg_9_1
	self.type_ = arg_9_2
	self.activityId_ = arg_9_3

	self:UpdateView()
end

function CoreVerificationRewardItem:UpdateView()
	local var_10_0 = {}
	local var_10_1 = false

	if self.type_ < 5 then
		self.processCon_:SetSelectedIndex(0)

		var_10_0 = CoreVerificationRewardCfg[self.data_]

		local var_10_2, var_10_3, var_10_4, var_10_5 = CoreVerificationData:GetTaskProcess(self.data_)

		self.progressBar_.value = var_10_2 / var_10_3
		self.progressText_.text = string.format("%s/%s", var_10_2, var_10_3)

		if var_10_5 then
			self.controller_:SetSelectedState("complete")

			var_10_1 = true
		elseif var_10_4 then
			self.controller_:SetSelectedState("receive")

			var_10_1 = false
		else
			self.controller_:SetSelectedState("lock")

			var_10_1 = false
		end

		self.titleText_.text = string.format(GetI18NText(ConditionCfg[var_10_0.condition].desc), ConditionCfg[var_10_0.condition].params[1])
	elseif self.type_ == 5 then
		self.processCon_:SetSelectedIndex(1)

		var_10_0 = CoreVerificationClRewardCfg[self.data_]

		local var_10_6 = CoreVerificationChallengeTools.GetTaskStateById(self.data_, self.activityId_)

		if var_10_6 == 2 then
			self.controller_:SetSelectedState("complete")

			var_10_1 = true
		elseif var_10_6 == 1 then
			self.controller_:SetSelectedState("receive")

			var_10_1 = false
		else
			self.controller_:SetSelectedState("lock")

			var_10_1 = false
		end

		self.titleText_.text = string.format(GetI18NText(var_10_0.reward_desc), var_10_0.reward_rank[1], var_10_0.reward_rank[2])
	else
		self.processCon_:SetSelectedIndex(0)

		var_10_0 = CoreVerificationClRewardCfg[self.data_]

		local var_10_7 = CoreVerificationChallengeTools.GetTaskStateById(self.data_, self.activityId_)

		if var_10_7 == 2 then
			self.controller_:SetSelectedState("complete")

			var_10_1 = true
		elseif var_10_7 == 1 then
			self.controller_:SetSelectedState("receive")

			var_10_1 = false
		else
			self.controller_:SetSelectedState("lock")

			var_10_1 = false
		end

		local var_10_8 = ConditionCfg[var_10_0.condition]
		local var_10_9 = CoreVerificationChallengeTools.GetModeCfg(self.activityId_)

		if ConditionCfg[var_10_0.condition].type == 11304 then
			self.titleText_.text = string.format(GetI18NText(var_10_8.desc), GetI18NText(var_10_9[var_10_8.params[1]].stage_name))
			self.progressBar_.value = (var_10_7 > 0 and 1 or 0) / 1
			self.progressText_.text = string.format("%s/%s", var_10_7 > 0 and 1 or 0, 1)
		elseif var_10_8.type == 11305 then
			self.titleText_.text = string.format(GetI18NText(var_10_8.desc), GetI18NText(var_10_9[var_10_8.params[1]].stage_name), var_10_8.params[2])
			self.progressBar_.value = (var_10_7 > 0 and 1 or 0) / 1
			self.progressText_.text = string.format("%s/%s", var_10_7 > 0 and 1 or 0, 1)
		elseif var_10_8.type == 11306 then
			self.titleText_.text = string.format(GetI18NText(var_10_8.desc), GetI18NText(var_10_9[var_10_8.params[2]].stage_name))
			self.progressBar_.value = (var_10_7 > 0 and 1 or 0) / 1
			self.progressText_.text = string.format("%s/%s", var_10_7 > 0 and 1 or 0, 1)
		elseif var_10_8.type == 11307 then
			self.titleText_.text = string.format(GetI18NText(var_10_8.desc), GetI18NText(var_10_9[var_10_8.params[1]].stage_name), var_10_8.params[2])

			local var_10_10 = CoreVerificationChallengeTools.GetDataCls(self.activityId_)
			local var_10_11
			local var_10_12 = var_10_8.params[2]

			var_10_11 = nullable(var_10_10, "GetCurPoint") and var_10_10:GetCurPoint() or 0

			if var_10_12 < var_10_11 or var_10_7 == 2 or var_10_7 == 1 then
				var_10_11 = var_10_12
			end

			self.progressBar_.value = var_10_11 / var_10_12
			self.progressText_.text = string.format("%s/%s", var_10_11, var_10_12)
		end
	end

	if self.type_ == 5 then
		SetActive(self.allBtnController_.gameObject, false)
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0.reward or {}) do
		local var_10_13 = formatReward(iter_10_1)
		local var_10_14 = clone(ItemTemplateData)

		if self.rewardItems_[iter_10_0] == nil then
			self.rewardItems_[iter_10_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_10_0)])
			self.rewardItems_[iter_10_0].ResetTransform = function()
				return
			end
		end

		var_10_14.id = var_10_13.id
		var_10_14.number = var_10_13.num
		var_10_14.timeValid = iter_10_1.timeValid or 0
		var_10_14.grayFlag = var_10_1
		var_10_14.clickFun = handler(self, self.OnClickCommonItem)

		self.rewardItems_[iter_10_0]:SetData(var_10_14)
	end

	for iter_10_2 = #var_10_0.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_2]:SetData(nil)
	end

	SetActive(self.progressText_.gameObject, self.type_ ~= 5)
	SetActive(self.allBtnController_.gameObject, self.type_ ~= 5)
end

function CoreVerificationRewardItem:OnClickCommonItem(arg_12_1)
	ShowPopItem(POP_ITEM, {
		arg_12_1.id,
		arg_12_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function CoreVerificationRewardItem:OnEnter()
	self:UpdateView()
end

function CoreVerificationRewardItem:Dispose()
	for iter_14_0, iter_14_1 in pairs(self.rewardItems_) do
		iter_14_1:Dispose()
	end

	self.rewardItems_ = {}

	CoreVerificationRewardItem.super.Dispose(self)
end

return CoreVerificationRewardItem
