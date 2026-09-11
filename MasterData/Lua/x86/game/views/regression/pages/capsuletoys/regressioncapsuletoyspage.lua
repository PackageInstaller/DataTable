local RegressionCapsuleToysPage = class("RegressionCapsuleToysPage", ReduxView)

function RegressionCapsuleToysPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnTwo/RT2stTwistedEggUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionCapsuleToysPage:Init()
	self.rewardItemList_ = {}
	self.itemDataList_ = {}

	self:InitUI()
	self:AddUIListener()
end

function RegressionCapsuleToysPage:InitUI()
	self:BindCfgUI()

	self.descText_.text = GetTips("REGRESSION_GASHAPON_DESCRIPE")
	self.drawOnceIcon_.sprite = ItemTools.getItemSprite(GameSetting.regression_gashapon_cost.value[1])
	self.drawOnceCostText_.text = "x" .. GameSetting.regression_gashapon_cost.value[2]
	self.drawMultiIcon_.sprite = ItemTools.getItemSprite(GameSetting.regression_gashapon_cost.value[1])
	self.drawMultiCostText_.text = "x" .. tostring(GameSetting.regression_gashapon_cost.value[2] * 10)
	self.drawController_ = ControllerUtil.GetController(self.transform_, "draw")
end

function RegressionCapsuleToysPage:AddUIListener()
	self:AddBtnListener(self.drawOnceBtn_, nil, function()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		if ItemTools.getItemNum(GameSetting.regression_gashapon_cost.value[1]) >= GameSetting.regression_gashapon_cost.value[2] then
			manager.audio:PlayEffect("ui_system", "back_niudan")
			self.drawController_:SetSelectedState("true")
			RegressionAction.RegressionCapsuleToysDraw(1, handler(self, self.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	self:AddBtnListener(self.drawMultipleBtn_, nil, function()
		local var_6_0

		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			do return end

			var_6_0 = ItemTools.getItemNum(GameSetting.regression_gashapon_cost.value[1])
		end

		if var_6_0 >= GameSetting.regression_gashapon_cost.value[2] * 2 then
			manager.audio:PlayEffect("ui_system", "back_niudan")

			local var_6_1 = math.floor(var_6_0 / GameSetting.regression_gashapon_cost.value[2])

			var_6_1 = var_6_1 <= 10 and var_6_1 or 10

			self.drawController_:SetSelectedState("true")
			RegressionAction.RegressionCapsuleToysDraw(var_6_1, handler(self, self.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("capsuleToysReward")
	end)
end

function RegressionCapsuleToysPage:Dispose()
	RegressionCapsuleToysPage.super.Dispose(self)

	if self.rewardItemList_ then
		for iter_8_0, iter_8_1 in ipairs(self.rewardItemList_) do
			iter_8_1:Dispose()
		end

		self.rewardItemList_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function RegressionCapsuleToysPage:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)

	if arg_9_1 == false and self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.drawController_:SetSelectedState("false")
end

function RegressionCapsuleToysPage:SetData()
	self.version_ = RegressionData:GetRegressionVersion()
	self.rewardCfgList_ = {}

	for iter_10_0, iter_10_1 in ipairs(RegressionCfg[self.version_].gashapon) do
		if RegressionCapsuleToysCfg[iter_10_1].reward_type == 1 then
			self.rewardCfgList_[#self.rewardCfgList_ + 1] = iter_10_1
		end
	end

	for iter_10_2, iter_10_3 in ipairs(self.rewardCfgList_) do
		self.rewardItemList_[iter_10_2] = self.rewardItemList_[iter_10_2] or CapsuleToysRewardItem.New(self.goRewardPanel_, self.rewardGo_, false)

		self.rewardItemList_[iter_10_2]:SetData(iter_10_3)
	end

	for iter_10_4 = #self.rewardCfgList_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_4]:Show(false)
	end

	self:RefreshMultiDrawBtn()
end

function RegressionCapsuleToysPage:OnCapsuleToysDraw(arg_11_1, arg_11_2)
	if isSuccess(arg_11_1.result) then
		local var_11_0 = {}
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_1.item_list) do
			var_11_0[#var_11_0 + 1] = {
				iter_11_1.id,
				iter_11_1.num
			}

			local var_11_2

			if iter_11_1.id == 0 then
				var_11_2 = GameSetting.regression_gashapon_reward.value
			end

			local var_11_3

			do
				var_11_2 = RegressionCapsuleToysCfg[iter_11_1.id].reward
				var_11_3 = {}
			end

			var_11_3[1] = var_11_2[1]
			var_11_3[2] = var_11_2[2] * iter_11_1.num
			var_11_1[#var_11_1 + 1] = var_11_3
		end

		RegressionData:SetCapsuleToysStatus(var_11_0)
		self:GetCapsuleReward(var_11_1)
	else
		ShowTips(arg_11_1.result)
		self.drawController_:SetSelectedState("false")
	end
end

function RegressionCapsuleToysPage:GetCapsuleReward(arg_12_1)
	self:RefreshMultiDrawBtn()

	local var_12_0 = "Fx_niudanji_cx"

	self.animator_:Play("Fx_niudanji_cx", -1, 0)
	self.animator_:Update(0)

	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.timer_ = Timer.New(function()
		local var_13_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if var_13_0:IsName(var_12_0) and var_13_0.normalizedTime >= 1 then
			if self.timer_ ~= nil then
				self.timer_:Stop()

				self.timer_ = nil
			end

			self:SetData()

			for iter_13_0, iter_13_1 in ipairs(arg_12_1) do
				if iter_13_1[1] == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS or iter_13_1[1] == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS then
					iter_13_1[1] = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE
				end
			end

			self.drawController_:SetSelectedState("false")
			JumpTools.OpenPageByJump("capsuleToysGetReward", {
				list = arg_12_1
			})
		end
	end, 0.033, -1)

	self.timer_:Start()
end

function RegressionCapsuleToysPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN, true)
end

function RegressionCapsuleToysPage:RefreshMultiDrawBtn()
	local var_15_0 = ItemTools.getItemNum(GameSetting.regression_gashapon_cost.value[1])
	local var_15_1 = 2

	if var_15_0 >= GameSetting.regression_gashapon_cost.value[2] * 2 then
		local var_15_2 = math.floor(var_15_0 / GameSetting.regression_gashapon_cost.value[2])

		var_15_1 = var_15_2 <= 10 and var_15_2 or 10
	end

	self.multiDrawTimesText_.text = string.format(GetTips("REGRESSION_GASHAPON_EXTRACT"), var_15_1)
	self.drawMultiCostText_.text = "x" .. tostring(GameSetting.regression_gashapon_cost.value[2] * var_15_1)
end

function RegressionCapsuleToysPage:OnExit()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return RegressionCapsuleToysPage
