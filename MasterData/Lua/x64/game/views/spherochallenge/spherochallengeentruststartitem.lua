local SPHeroChallengeEntrustStartItem = class("SPHeroChallengeEntrustStartItem", ReduxView)

function SPHeroChallengeEntrustStartItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.showIndex = arg_1_2

	self:Init()
end

function SPHeroChallengeEntrustStartItem:Init()
	self:InitUI()
end

function SPHeroChallengeEntrustStartItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
	self.rankController = self.controller:GetController("rank")
	self.commonItemView = CommonItemView.New(self.commonItem)

	self:AddUIListener()
end

function SPHeroChallengeEntrustStartItem:RefreshUI(arg_4_1)
	self.rankController:SetSelectedState(1)

	if arg_4_1 then
		self.showIndex = arg_4_1.showIndex

		if arg_4_1.state == "lock" then
			self.stateController:SetSelectedState("lock")

			local var_4_0, var_4_1 = SPHeroChallengeTools:GetEntrustLockDesc(self.showIndex)

			self.lockDesc.text = var_4_1
		elseif arg_4_1.state == "empty" then
			self.stateController:SetSelectedState("empty")
		elseif arg_4_1.state == "start" then
			self.stateController:SetSelectedState("start")
			self:RefreshBaseInfo()
			self:RefreshStartInfo()
		elseif arg_4_1.state == "end" then
			self.stateController:SetSelectedState("end")
			self:RefreshBaseInfo()
			self:RefreshEndInfo()
		end
	end
end

function SPHeroChallengeEntrustStartItem:RefreshBaseInfo()
	local var_5_0 = SPHeroChallengeData:GetCurActivityInfo()

	if var_5_0 then
		self.info = var_5_0:GetShowIndexEntrustInfo(self.showIndex)
		self.nameText.text = ActivityHeroChallengeTaskCfg[self.info.entrustID].name

		self.rankController:SetSelectedState(tostring(ActivityHeroChallengeTaskCfg[self.info.entrustID].task_level))
		self.commonItemView:SetData({
			id = ActivityHeroChallengeTaskCfg[self.info.entrustID].reward_list[1][1],
			number = ActivityHeroChallengeTaskCfg[self.info.entrustID].reward_list[1][2],
			clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		})
	end
end

function SPHeroChallengeEntrustStartItem:RefreshStartInfo()
	self.curIcon.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)

	self:RefreshTime()
end

function SPHeroChallengeEntrustStartItem:RefreshTime()
	if self.stateController:GetSelectedState() == "start" then
		local var_8_0, var_8_1 = SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(self.info.index)

		if var_8_0 == nil then
			return
		end

		if var_8_1 then
			if not var_8_0 then
				self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:DescCdTime3(var_8_1)
				self.accDesc.text = SPHeroChallengeTools:GetAcceleratorNumByIndex(self.info.index)
			elseif not self.info.refreshFlag then
				SPHeroChallengeAction:RefreshEntrust()

				self.info.refreshFlag = true
			end
		end
	end
end

function SPHeroChallengeEntrustStartItem:RefreshEndInfo()
	return
end

function SPHeroChallengeEntrustStartItem:AddUIListener()
	self:AddBtnListener(self.endbtnBtn_, nil, function()
		local var_11_0 = SPHeroChallengeTools:GetAcceleratorNumByIndex(self.info.index)

		if SPHeroChallengeData:GetAccelerateNum() < var_11_0 then
			ShowTips(GetTips("ACTIVITY_HERO_CHALLENGE_ACCELERATOR_LACK"))

			return
		end

		SPHeroChallengeAction:UseEntrustAccelerator(var_11_0, self.info.index)
	end)
	self:AddBtnListener(self.emptyBtn_, nil, function()
		if self.clickEmptyFunc then
			self.clickEmptyFunc(self.showIndex)
		end
	end)
	self:AddBtnListener(self.reciveBtn, nil, function()
		local var_13_0 = SPHeroChallengeData:GetCurActivityInfo()

		if var_13_0 then
			local var_13_1 = var_13_0:GetCanGetRewardEntrustIndexList()

			if #var_13_1 > 0 then
				SPHeroChallengeAction:GetEntrustAward(var_13_1)
			else
				ShowTips("ACTIVITY_HERO_CHALLENGE_NONE_ENTRUST_FINISH")
			end
		end
	end)
end

function SPHeroChallengeEntrustStartItem:ClickEmptyFunc(arg_14_1)
	if arg_14_1 then
		self.clickEmptyFunc = arg_14_1
	end
end

function SPHeroChallengeEntrustStartItem:Dispose()
	if self.commonItemView then
		self.commonItemView:Dispose()
	end

	SPHeroChallengeEntrustStartItem.super.Dispose(self)
end

return SPHeroChallengeEntrustStartItem
