local BigMonthCardPage = class("BigMonthCardPage", BaseSignPage)

function BigMonthCardPage:OnCtor(arg_1_1, arg_1_2)
	self.hander_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/ActivitySign/BigMonthCard/BigMonthcard"), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BigMonthCardPage:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BigMonthCardPage:InitUI()
	self:BindCfgUI()

	self.num_ = {}
	self.icon_ = {}
	self.goal_ = {}
	self.reward_ = {}
	self.stateCon_ = {}
	self.itemAni = {}
	self.btnAni = self.btnGo_:GetComponent("Animator")
	self.animPlaying = false

	for iter_3_0 = 1, 4 do
		self.num_[iter_3_0] = self["num_" .. iter_3_0]
		self.icon_[iter_3_0] = self["icon_" .. iter_3_0]
		self.goal_[iter_3_0] = self["goal_" .. iter_3_0]
		self.reward_[iter_3_0] = self["reward_" .. iter_3_0]
		self.stateCon_[iter_3_0] = ControllerUtil.GetController(self["item_" .. iter_3_0].transform, "state")
		self.itemAni[iter_3_0] = self["giftpanelitemAni_" .. iter_3_0]
	end

	self.slider_ = {}

	for iter_3_1 = 1, 3 do
		self.slider_[iter_3_1] = self["slider_" .. iter_3_1]
	end

	self.btnCon_ = ControllerUtil.GetController(self.transform_, "btn")
	self.dayCon_ = ControllerUtil.GetController(self.transform_, "day")

	self:RefreshReward()
end

function BigMonthCardPage:AddUIListeners()
	self:AddBtnListener(self.buyBtn_, nil, function()
		if GameSetting.big_monthly_card_cost.value[2] <= CurrencyData:GetRechargeDiamond() then
			ShowMessageBox({
				isTop = true,
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(GameSetting.big_monthly_card_cost.value[1]), GameSetting.big_monthly_card_cost.value[2], GetTips("SIGN_TITLE_BIGMONTHCARD"), 1),
				OkCallback = function()
					BigMonthCardAction.BuyBigMonthCard()
				end
			})
		elseif AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
			ShopTools.DiamondEnoughMessageBox()
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
		end
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)
		BigMonthCardAction.SignToday()
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		self:ClickInfoFunc()
	end)
	self:AddBtnListener(self.imgBtn_, nil, function()
		self:ClickInfoFunc()
	end)

	local var_4_0 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()]

	for iter_4_0 = 1, 4 do
		local var_4_1 = BigMonthCardAccumulationCfg[var_4_0[iter_4_0]]

		self:AddBtnListener(self.reward_[iter_4_0], nil, function()
			if BigMonthCardData:GetSignDays() >= var_4_1.accumulation then
				BigMonthCardAction.SignToday()
			else
				ShowPopItem(POP_ITEM, {
					var_4_1.reward[1]
				})
			end
		end)
	end
end

function BigMonthCardPage:RefreshReward()
	local var_11_0 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		self.icon_[iter_11_0].sprite = ItemTools.getItemSprite(BigMonthCardAccumulationCfg[var_11_0[iter_11_0]].reward[1])
		self.num_[iter_11_0].text = "x" .. BigMonthCardAccumulationCfg[var_11_0[iter_11_0]].reward[2]
		self.goal_[iter_11_0].text = BigMonthCardAccumulationCfg[var_11_0[iter_11_0]].accumulation
	end
end

function BigMonthCardPage:ClickInfoFunc()
	JumpTools.OpenPageByJump("bigMonthPop")
end

function BigMonthCardPage:AutoGetReward()
	if BigMonthCardData:IsExpireTip() == 1 then
		BigMonthCardAction.FirstLoginSinceMonthCardFinish()
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)

		if BigMonthCardData:HaveMonthCard() and not BigMonthCardData:IsSignToday() or BigMonthCardData:IsNeedAccumulatSign() then
			BigMonthCardAction.SignToday()
		end
	end
end

function BigMonthCardPage:AutoGetAccumlateSign()
	local var_14_0 = BigMonthCardData:GetHaveSign()
	local var_14_1 = BigMonthCardData:GetSignDays()

	for iter_14_0, iter_14_1 in ipairs(BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()]) do
		if var_14_1 >= BigMonthCardAccumulationCfg[iter_14_1].accumulation and not table.indexof(var_14_0, iter_14_1) then
			manager.notify:CallUpdateFunc(SIGN_INPUT, false)
			BigMonthCardAction.AccumulateSign(iter_14_1)

			return
		end
	end

	manager.notify:CallUpdateFunc(SIGN_INPUT, true)
	self.hander_:CheckSign()
end

function BigMonthCardPage:OnShow()
	self:RefreshUI()
	self:RegistEventListener(GET_BIG_MONTH_SIGN, function()
		self:RefreshUI()
	end)
	self:RegistEventListener(GET_BIG_MONTH_ACCUMULATE_SIGN, function()
		self:RefreshUI()
	end)
	self:RegistEventListener(BUY_BIG_MONTH_CARD, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_big_monthcard = 1
		})
		self:RefreshUI()
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)
		BigMonthCardAction.SignToday()
	end)
	SDKTools.SendPaymentMessageToSDK("payment_big_monthcard_click", {
		big_monthcard_click = 1
	})
end

function BigMonthCardPage:RefreshUI()
	if BigMonthCardData:HaveMonthCard() then
		self:RefreshUnlock()
	else
		self:RefreshLock()
	end

	self:RefreshReward()
end

function BigMonthCardPage:RefreshUnlock()
	local var_20_0 = false
	local var_20_1 = BigMonthCardData:IsSignToday()

	if var_20_1 then
		self.btnCon_:SetSelectedState("signed")
	else
		self.btnCon_:SetSelectedState("unlock")
	end

	local var_20_2 = BigMonthCardData:GetSignDays()

	self.lastDays_.text = BigMonthCardData:GetMonthCardLastDay() .. GetTips("DAY")

	local var_20_3 = 0
	local var_20_4 = BigMonthCardData:GetHaveSign()
	local var_20_5 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()]

	for iter_20_0, iter_20_1 in ipairs(var_20_5) do
		local var_20_6 = BigMonthCardAccumulationCfg[var_20_5[iter_20_0]].accumulation

		if BigMonthCardAccumulationCfg[var_20_5[iter_20_0]].accumulation <= var_20_2 then
			local var_20_7 = table.indexof(var_20_4, var_20_5[iter_20_0])

			self.stateCon_[iter_20_0]:SetSelectedState(var_20_7 and "received" or "complete")

			if iter_20_0 ~= 1 then
				self.slider_[iter_20_0 - 1].value = 1
			end

			if var_20_2 == var_20_6 and var_20_7 then
				var_20_0 = true
			end

			if var_20_7 and self.itemAni[iter_20_0] then
				self.itemAni[iter_20_0].enabled = false
			end
		else
			local var_20_8

			if var_20_5[iter_20_0 - 1] then
				var_20_8 = BigMonthCardAccumulationCfg[var_20_5[iter_20_0 - 1]].accumulation or 0
			end

			var_20_3 = var_20_3 ~= 0 and (var_20_3 < var_20_6 - var_20_2 and var_20_3 or var_20_6 - var_20_2) or var_20_6 - var_20_2

			if iter_20_0 ~= 1 then
				self.slider_[iter_20_0 - 1].value = (var_20_2 - var_20_8 <= 0 and 0 or var_20_2 - var_20_8) / (var_20_6 - var_20_8)
			end
		end
	end

	if var_20_3 ~= 0 then
		self.next_.text = string.format(GetTips("SIGN_TITLE_BIGMONTHCARD_TIP"), var_20_3)

		self.dayCon_:SetSelectedState("true")
	else
		self.dayCon_:SetSelectedState("false")
	end

	self.tip_.text = var_20_0 and GetTips("BIG_CARD_TIPS_4") or var_20_1 and GetTips("BIG_CARD_TIPS_3") or GetTips("BIG_CARD_TIPS_2")

	self:ResetTipTimer()
end

function BigMonthCardPage:RefreshLock()
	self.btnCon_:SetSelectedState("lock")
	self.dayCon_:SetSelectedState("false")

	for iter_21_0 = 1, 4 do
		self.stateCon_[iter_21_0]:SetSelectedState("uncomplete")

		if self.itemAni[iter_21_0] then
			self.itemAni[iter_21_0].enabled = false
		end
	end

	for iter_21_1 = 1, 3 do
		self.slider_[iter_21_1].value = 0
	end

	self:StopTipTimer()

	self.tip_.text = BigMonthCardData:IsExpireTip() == 1 and GetTips("BIG_CARD_TIPS_5") or GetTips("BIG_CARD_TIPS_1")
end

function BigMonthCardPage:ResetTipTimer()
	self:StopTipTimer()
	SetActive(self.tipGo_, true)

	self.tipTimer_ = Timer.New(function()
		SetActive(self.tipGo_, false)
		self:StopTipTimer()
	end, 5, 1)

	self.tipTimer_:Start()
end

function BigMonthCardPage:StopTipTimer()
	if self.tipTimer_ then
		self.tipTimer_:Stop()

		self.tipTimer_ = nil
	end
end

function BigMonthCardPage:OnHide()
	self:StopTipTimer()
	self:RemoveAllEventListener()
end

return BigMonthCardPage
