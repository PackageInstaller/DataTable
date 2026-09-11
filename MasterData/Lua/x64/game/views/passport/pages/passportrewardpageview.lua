local PassportRewardPageView = class("PassportRewardPageView", ReduxView)

function PassportRewardPageView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PassportRewardPageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportRewardPageView:HeadTailChangeHandler(arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 + 1
	arg_3_2 = math.max(1, arg_3_2)
	self.minEndIndex_ = self.minEndIndex_ or arg_3_2
	self.nearestBonusIndex_ = self:GetNextBonusIndex(arg_3_2)

	self:UpdateNextBonus()
end

function PassportRewardPageView:UpdateNextBonus()
	local var_4_0 = BattlePassCfg[self.rewardIdList_[self.nearestBonusIndex_]]
	local var_4_1 = GameLevelSetting[self.nearestBonusIndex_]

	self.nextBonusLevelLabel_.text = string.format("%d", self.nearestBonusIndex_)
	self.nextBonusBottomLabel_.text = string.format("%d", self.nearestBonusIndex_)

	self.nextCommonItem1_:RefreshData({
		id = var_4_0.reward_free[1][1],
		number = var_4_0.reward_free[1][2]
	})
	self.nextCommonItem2_:RefreshData({
		id = var_4_0.reward_pay[1][1],
		number = var_4_0.reward_pay[1][2]
	})

	local var_4_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)
	local var_4_3 = PassportData:GetPayLevel() > 0 and "pay" or "free"

	if PassportData:HaveGetBonus(var_4_0.id) then
		self.statusController_:SetSelectedState(var_4_3 .. "HaveGet")
	elseif var_4_2 >= var_4_1.battlepass_lv_exp_sum then
		if var_4_3 == "free" then
			self.statusController_:SetSelectedState(var_4_3 .. "CanGet")
		elseif PassportData:HaveReceiveInfo(var_4_0.id) then
			self.statusController_:SetSelectedState(var_4_3 .. "HalfCanGet")
		else
			self.statusController_:SetSelectedState(var_4_3 .. "CanGet")
		end
	else
		self.statusController_:SetSelectedState(var_4_3 .. "CannotGet")
	end
end

function PassportRewardPageView:OnEnter()
	self:AdaptScreen()
	self:AddEventListeners()
end

function PassportRewardPageView:Show()
	SetActive(self.gameObject_, true)
end

function PassportRewardPageView:Hide()
	SetActive(self.gameObject_, false)
end

function PassportRewardPageView:OnBuyPassportLevel()
	self.list_:Refresh()
	self:UpdateView()
	self:UpdateNextBonus()
end

return PassportRewardPageView
