local CommunitySpecialWelfareShopView = class("CommunitySpecialWelfareShopView", ReduxView)

function CommunitySpecialWelfareShopView:UIName()
	return "Widget/Common/Pop/showpopUI"
end

function CommunitySpecialWelfareShopView:UIParent()
	return manager.ui.uiPop.transform
end

function CommunitySpecialWelfareShopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.refreshUIHandler_ = handler(self, self.RefreshUI)
end

function CommunitySpecialWelfareShopView:InitUI()
	self:BindCfgUI()

	self.useNumTriggerListener_ = self.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	self.bgController = self.controller_:GetController("bg")
	self.timeController = self.controller_:GetController("time")
	self.viewController = self.controller_:GetController("view")
	self.starController = self.controller_:GetController("star")
	self.ndtabController = self.controller_:GetController("ndtab")
	self.consumeController = self.controller_:GetController("consume")
	self.numController = self.controller_:GetController("showNum")
	self.furnitureController = self.controller_:GetController("Furniture")
	self.groupController = self.controller_:GetController("group")
end

function CommunitySpecialWelfareShopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		if CommunityData:GetWelfareExchangeCnt() < self.useNum_ then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		CommunityAction:BuySpecialWelfare(self.useNum_)
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.useNumSlider_.value < self.canUseMaxNum_ then
			self.useNumSlider_.value = self.useNumSlider_.value + 1

			if self.useNumSlider_.value >= self.canUseMaxNum_ then
				self.useNumSlider_.value = self.canUseMaxNum_
			end

			self:RefreshBtnState()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.useNumSlider_.value >= 1 then
			self.useNumSlider_.value = self.useNumSlider_.value - 1

			if self.useNumSlider_.value < 1 or math.floor(self.useNumSlider_.value) == 1 then
				self.useNumSlider_.value = 1
			end

			self:RefreshBtnState()

			return true
		end

		return false
	end)
	self:AddBtnListener(self.maxBtn_, nil, function()
		self.useNum_ = self.canUseMaxNum_
		self.useNumSlider_.value = self.canUseMaxNum_
	end)
	self.useNumSlider_.onValueChanged:AddListener(function()
		if self.canUseMaxNum_ then
			self.useNum_ = math.floor(self.useNumSlider_.value)

			if self.useNum_ < 1 then
				self.useNum_ = 1
				self.useNumSlider_.value = 1
			elseif self.useNum_ > self.canUseMaxNum_ then
				self.useNum_ = self.canUseMaxNum_
			end

			if self.useNum_ <= 0 then
				self.useNum_ = 1
			end

			self:RefreshBtnState()
			self:UpdateCnt()
		end
	end)
	self.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		self.useNumSlider_.value = math.floor(self.useNumSlider_.value)
	end))
end

function CommunitySpecialWelfareShopView:OnEnter()
	CommunityAction:RefreshCurrencyA()
	manager.windowBar:SetAsLastSibling()
	self.numController:SetSelectedState("none")
	self.viewController:SetSelectedState("false")
	self.consumeController:SetSelectedState("normal")
	self.furnitureController:SetSelectedState("false")

	self.identity_ = CommunityData:GetIdentity()

	manager.notify:RegistListener(GUILD_WELFRE_CNT_REFRESH, self.refreshUIHandler_)

	self.okBtn_.interactable = CommunityData:GetCurrenyA() >= GameSetting.club_special_welfare_cost.value[1]

	self:RefreshUI()
	self:RefreshBtnState()

	self.useNumSlider_.value = 1
end

function CommunitySpecialWelfareShopView:RefreshBtnState()
	self.addBtn_.interactable = self.useNumSlider_.value ~= self.useNumSlider_.maxValue
	self.delBtn_.interactable = self.useNumSlider_.value ~= 1
end

function CommunitySpecialWelfareShopView:RefreshGood()
	self.ndtabController:SetSelectedState("off")

	self.itemIcon_.sprite = ItemTools.getItemSprite(ItemCfg[GameSetting.club_special_welfare.value[1]].id)

	self.bgController:SetSelectedState(tostring(ItemCfg[GameSetting.club_special_welfare.value[1]].rare))

	self.nameText_.text = GetI18NText(ItemCfg[GameSetting.club_special_welfare.value[1]].name)
	self.descText_.text = GetI18NText(ItemCfg[GameSetting.club_special_welfare.value[1]].desc) .. "\n\n" .. GetTips("CLUB_SPECIAL_WELFARE")
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)
end

function CommunitySpecialWelfareShopView:RefreshSlider()
	local var_16_0 = CommunityData:GetCurrenyA()
	local var_16_2 = CommunityData:GetWelfareExchangeCnt()

	self.canUseMaxNum_ = var_16_2
	self.useNumSlider_.minValue = 0
	self.useNumSlider_.maxValue = math.max(var_16_2, 1)
	self.useNumSlider_.value = math.min(self.useNumSlider_.maxValue, 1)

	self:UpdateDelAddBtn()
	self:UpdatePreview()
end

function CommunitySpecialWelfareShopView:UpdateDelAddBtn()
	return
end

function CommunitySpecialWelfareShopView:UpdatePreview()
	self.useNum_ = self.useNumSlider_.value
	self.useNumText_.text = self.useNum_
	self.totalCostText_.text = self.useNum_ * GameSetting.club_special_welfare_cost.value[1] > CommunityData:GetCurrenyA() and "<color=#FF0000>" .. self.useNum_ * GameSetting.club_special_welfare_cost.value[1] .. "</color>" or self.useNum_ * GameSetting.club_special_welfare_cost.value[1]
end

function CommunitySpecialWelfareShopView:UpdateCnt()
	self:UpdateDelAddBtn()
	self:UpdatePreview()
end

function CommunitySpecialWelfareShopView:OnBuyCommunitySpecialWelfare()
	self:Back()
	ShowTips("TIP_CLUB_SPECIAL_WELFARE_BUY")
end

function CommunitySpecialWelfareShopView:OnExit()
	manager.notify:RemoveListener(GUILD_WELFRE_CNT_REFRESH, self.refreshUIHandler_)
end

function CommunitySpecialWelfareShopView:OnExitInput()
	JumpTools.Back()

	return true
end

function CommunitySpecialWelfareShopView:Dispose()
	self.refreshUIHandler_ = nil

	self:RemoveAllListeners()
	self.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	CommunitySpecialWelfareShopView.super.Dispose(self)
end

function CommunitySpecialWelfareShopView:RefreshUI()
	self:RefreshGood()
	self:RefreshSlider()
	self.groupController:SetSelectedState("false")
	SetActive(self.limitGo_, true)

	self.limitText_.text = GetTips("LIMIT_WEEK") .. string.format("%s/%s", GameSetting.club_special_reward_buy_limit_weekly.value[1] - CommunityData:GetWelfareExchangeCnt(), GameSetting.club_special_reward_buy_limit_weekly.value[1])
end

return CommunitySpecialWelfareShopView
