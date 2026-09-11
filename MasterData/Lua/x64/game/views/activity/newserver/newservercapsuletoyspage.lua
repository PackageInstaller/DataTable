local NewServerCapsuleToysPage = class("NewServerCapsuleToysPage", ReduxView)

function NewServerCapsuleToysPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerGashaponUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function NewServerCapsuleToysPage:Init()
	self.rewardItemList_ = {}
	self.itemDataList_ = {}

	self:InitUI()
	self:AddUIListener()
end

function NewServerCapsuleToysPage:InitUI()
	self:BindCfgUI()
end

function NewServerCapsuleToysPage:AddUIListener()
	self:AddBtnListener(self.drawOnceBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		if NewServerCfg[self.activityID_].coin_num <= ItemTools.getItemNum(NewServerCfg[self.activityID_].coin_id) then
			manager.audio:PlayEffect("ui_system", "back_niudan")
			NewServerAction.CapsuleToysDraw(1, handler(self, self.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	self:AddBtnListener(self.drawMultipleBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		local var_6_0 = ItemTools.getItemNum(NewServerCfg[self.activityID_].coin_id)

		if var_6_0 >= NewServerCfg[self.activityID_].coin_num * 2 then
			manager.audio:PlayEffect("ui_system", "back_niudan")

			local var_6_1 = math.floor(var_6_0 / NewServerCfg[self.activityID_].coin_num)

			var_6_1 = var_6_1 <= 10 and var_6_1 or 10

			NewServerAction.CapsuleToysDraw(var_6_1, handler(self, self.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("newServerCapsuleToysReward", {
			activityID = self.activityID_
		})
	end)
end

function NewServerCapsuleToysPage:Dispose()
	if self.rewardItemList_ then
		for iter_8_0, iter_8_1 in ipairs(self.rewardItemList_) do
			iter_8_1:Dispose()
		end

		self.rewardItemList_ = nil
	end

	NewServerCapsuleToysPage.super.Dispose(self)
end

function NewServerCapsuleToysPage:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)

	if arg_9_1 == false then
		if self.timer_ ~= nil then
			self.timer_:Stop()

			self.timer_ = nil
		end

		manager.ui:UIEventEnabledByUI(true, false)
	end
end

function NewServerCapsuleToysPage:SetData(arg_10_1)
	self.activityID_ = arg_10_1
	self.rewardCfgList_ = {}

	for iter_10_0, iter_10_1 in ipairs(NewServerCfg[self.activityID_].gashapon) do
		if NewServerCapsuleToysCfg[iter_10_1].reward_type == 1 then
			self.rewardCfgList_[#self.rewardCfgList_ + 1] = iter_10_1
		end
	end

	for iter_10_2, iter_10_3 in ipairs(self.rewardCfgList_) do
		self.rewardItemList_[iter_10_2] = self.rewardItemList_[iter_10_2] or NewServerCapsuleToysItem.New((Object.Instantiate(self.rewardGo_, self.rewardPanelTrans_)))

		self.rewardItemList_[iter_10_2]:SetData(iter_10_3)
	end

	for iter_10_4 = #self.rewardCfgList_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_4]:Show(false)
	end

	self.drawOnceIcon_.sprite = ItemTools.getItemSprite(NewServerCfg[self.activityID_].coin_id)
	self.drawOnceCostText_.text = "x" .. NewServerCfg[self.activityID_].coin_num
	self.drawMultiIcon_.sprite = ItemTools.getItemSprite(NewServerCfg[self.activityID_].coin_id)
	self.drawMultiCostText_.text = "x" .. tostring(NewServerCfg[self.activityID_].coin_num * 10)

	self:RefreshMultiDrawBtn()
end

function NewServerCapsuleToysPage:OnCapsuleToysDraw(arg_11_1, arg_11_2)
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
				var_11_2 = NewServerCfg[self.activityID_].gashapon_default
			end

			local var_11_3

			do
				var_11_2 = NewServerCapsuleToysCfg[iter_11_1.id].reward
				var_11_3 = {}
			end

			var_11_3.id = var_11_2[1]
			var_11_3.num = var_11_2[2] * iter_11_1.num
			var_11_1[#var_11_1 + 1] = var_11_3
		end

		NewServerData:SetCapsuleToysStatus(var_11_0)
		self:GetCapsuleReward(var_11_1)
	else
		ShowTips(arg_11_1.result)
	end
end

function NewServerCapsuleToysPage:GetCapsuleReward(arg_12_1)
	manager.ui:UIEventEnabledByUI(false, true)
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

			self:SetData(self.activityID_)

			for iter_13_0, iter_13_1 in ipairs(arg_12_1) do
				if iter_13_1.id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS or iter_13_1.id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS then
					iter_13_1.id = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE
				end
			end

			manager.ui:UIEventEnabledByUI(true, false)
			getReward(arg_12_1)
		end
	end, 0.033, -1)

	self.timer_:Start()
end

function NewServerCapsuleToysPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NewServerCfg[self.activityID_].coin_id
	})
	manager.windowBar:SetBarCanClick(NewServerCfg[self.activityID_].coin_id, true)
end

function NewServerCapsuleToysPage:RefreshMultiDrawBtn()
	local var_15_0 = ItemTools.getItemNum(NewServerCfg[self.activityID_].coin_id)
	local var_15_1 = 2

	if var_15_0 >= NewServerCfg[self.activityID_].coin_num * 2 then
		local var_15_2 = math.floor(var_15_0 / NewServerCfg[self.activityID_].coin_num)

		var_15_1 = var_15_2 <= 10 and var_15_2 or 10
	end

	self.multiDrawTimesText_.text = string.format(GetTips("REGRESSION_GASHAPON_EXTRACT"), var_15_1)
	self.drawMultiCostText_.text = "x" .. tostring(NewServerCfg[self.activityID_].coin_num * var_15_1)
end

function NewServerCapsuleToysPage:OnExit()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return NewServerCapsuleToysPage
