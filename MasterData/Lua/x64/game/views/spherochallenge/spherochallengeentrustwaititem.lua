local SPHeroChallengeEntrustWaitItem = class("SPHeroChallengeEntrustWaitItem", ReduxView)

function SPHeroChallengeEntrustWaitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SPHeroChallengeEntrustWaitItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeEntrustWaitItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
	self.rankController = self.controller:GetController("rank")
end

function SPHeroChallengeEntrustWaitItem:RefreshUI(arg_4_1)
	if arg_4_1 then
		self.showiIndex = arg_4_1.showiIndex

		if arg_4_1.state then
			if arg_4_1.state == "lock" then
				self.stateController:SetSelectedState("lock")

				local var_4_0 = SPHeroChallengeData:GetActivityID()
				local var_4_1 = SPHeroChallengeData.activityCfg[var_4_0].waitEntrustListOpenCondition[self.showiIndex - SPHeroChallengeTools:GetMaxStartEntrustPosNum(var_4_0)][2]
				local var_4_2, var_4_3 = SPHeroChallengeTools:GetConditionDesc(var_4_1)

				self.lockdescText_.text = GetTips("RETURN_MATERIAL_MAX_POINT")

				ItemTools.GetItemSpriteAsync(var_4_3, function(arg_5_0, arg_5_1)
					self.currencyiconImg_.sprite = arg_5_1
				end)

				local var_4_4, var_4_5, var_4_6 = IsConditionAchieved(var_4_1)

				self.locknumText_.text = string.format("<color='#FF000B'>%d</color>", var_4_5) .. "/" .. var_4_6
			elseif arg_4_1.state == "empty" then
				self.stateController:SetSelectedState("empty")
			end
		else
			self:RefreshBaseInfo(arg_4_1.entrustIndex)

			if SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(arg_4_1.entrustIndex) then
				self.stateController:SetSelectedState("end")
			else
				self.stateController:SetSelectedState("start")
			end
		end
	end
end

function SPHeroChallengeEntrustWaitItem:RefreshBaseInfo(arg_6_1)
	local var_6_0 = ActivityHeroChallengeTaskCfg[SPHeroChallengeData:GetCurActivityInfo():GetEntrustInfoByIndex(arg_6_1).entrustID]

	self.entrustnameText_.text = var_6_0.name

	self.rankController:SetSelectedState(tostring(var_6_0.task_level))
end

function SPHeroChallengeEntrustWaitItem:AddUIListener()
	self:AddBtnListener(self.emptyBtn_, nil, function()
		if self.clickEmptyFunc then
			self.clickEmptyFunc(self.showIndex)
		end
	end)
	self:AddBtnListener(self.cancelBtn, nil, function()
		local var_9_0 = SPHeroChallengeData:GetCurActivityInfo():GetShowIndexEntrustInfo(self.showiIndex)

		if var_9_0 then
			SPHeroChallengeAction:CancelEntrust({
				index = var_9_0.index,
				entrustID = self.id
			})
		end
	end)
end

function SPHeroChallengeEntrustWaitItem:ClickEmptyFunc(arg_10_1)
	if arg_10_1 then
		self.clickEmptyFunc = arg_10_1
	end
end

function SPHeroChallengeEntrustWaitItem:Dispose()
	SPHeroChallengeEntrustWaitItem.super.Dispose(self)
end

return SPHeroChallengeEntrustWaitItem
