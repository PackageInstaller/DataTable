local var_0_0 = class("BigMonthCardPage", BaseSignPage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hander_ = arg_1_1

	local var_1_0 = Asset.Load("Widget/System/ActivitySign/BigMonthCard/BigMonthcard")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.num_ = {}
	arg_3_0.icon_ = {}
	arg_3_0.goal_ = {}
	arg_3_0.reward_ = {}
	arg_3_0.stateCon_ = {}
	arg_3_0.itemAni = {}
	arg_3_0.btnAni = arg_3_0.btnGo_:GetComponent("Animator")
	arg_3_0.animPlaying = false

	for iter_3_0 = 1, 4 do
		arg_3_0.num_[iter_3_0] = arg_3_0["num_" .. iter_3_0]
		arg_3_0.icon_[iter_3_0] = arg_3_0["icon_" .. iter_3_0]
		arg_3_0.goal_[iter_3_0] = arg_3_0["goal_" .. iter_3_0]
		arg_3_0.reward_[iter_3_0] = arg_3_0["reward_" .. iter_3_0]
		arg_3_0.stateCon_[iter_3_0] = ControllerUtil.GetController(arg_3_0["item_" .. iter_3_0].transform, "state")
		arg_3_0.itemAni[iter_3_0] = arg_3_0["giftpanelitemAni_" .. iter_3_0]
	end

	arg_3_0.slider_ = {}

	for iter_3_1 = 1, 3 do
		arg_3_0.slider_[iter_3_1] = arg_3_0["slider_" .. iter_3_1]
	end

	arg_3_0.btnCon_ = ControllerUtil.GetController(arg_3_0.transform_, "btn")
	arg_3_0.dayCon_ = ControllerUtil.GetController(arg_3_0.transform_, "day")

	arg_3_0:RefreshReward()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buyBtn_, nil, function()
		local var_5_0 = GameSetting.big_monthly_card_cost.value[2]
		local var_5_1 = ItemTools.getItemName(GameSetting.big_monthly_card_cost.value[1])

		if var_5_0 <= CurrencyData:GetRechargeDiamond() then
			ShowMessageBox({
				isTop = true,
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), var_5_1, var_5_0, GetTips("SIGN_TITLE_BIGMONTHCARD"), 1),
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
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)
		BigMonthCardAction.SignToday()
	end)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		arg_4_0:ClickInfoFunc()
	end)
	arg_4_0:AddBtnListener(arg_4_0.imgBtn_, nil, function()
		arg_4_0:ClickInfoFunc()
	end)

	local var_4_0 = BigMonthCardData:GetTemplateId()
	local var_4_1 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[var_4_0]

	for iter_4_0 = 1, 4 do
		local var_4_2 = var_4_1[iter_4_0]
		local var_4_3 = BigMonthCardAccumulationCfg[var_4_2]

		arg_4_0:AddBtnListener(arg_4_0.reward_[iter_4_0], nil, function()
			local var_10_0 = BigMonthCardData:GetSignDays()
			local var_10_1 = var_4_3.reward[1]

			if var_10_0 >= var_4_3.accumulation then
				BigMonthCardAction.SignToday()
			else
				ShowPopItem(POP_ITEM, {
					var_10_1
				})
			end
		end)
	end
end

function var_0_0.RefreshReward(arg_11_0)
	local var_11_0 = BigMonthCardData:GetTemplateId()
	local var_11_1 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[var_11_0]

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = var_11_1[iter_11_0]
		local var_11_3 = BigMonthCardAccumulationCfg[var_11_2]

		arg_11_0.icon_[iter_11_0].sprite = ItemTools.getItemSprite(var_11_3.reward[1])
		arg_11_0.num_[iter_11_0].text = "x" .. var_11_3.reward[2]
		arg_11_0.goal_[iter_11_0].text = var_11_3.accumulation
	end
end

function var_0_0.ClickInfoFunc(arg_12_0)
	JumpTools.OpenPageByJump("bigMonthPop")
end

function var_0_0.AutoGetReward(arg_13_0)
	if BigMonthCardData:IsExpireTip() == 1 then
		BigMonthCardAction.FirstLoginSinceMonthCardFinish()
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)

		if BigMonthCardData:HaveMonthCard() and not BigMonthCardData:IsSignToday() or BigMonthCardData:IsNeedAccumulatSign() then
			BigMonthCardAction.SignToday()
		end
	end
end

function var_0_0.AutoGetAccumlateSign(arg_14_0)
	local var_14_0 = BigMonthCardData:GetHaveSign()
	local var_14_1 = BigMonthCardData:GetSignDays()
	local var_14_2 = BigMonthCardData:GetTemplateId()
	local var_14_3 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[var_14_2]

	for iter_14_0, iter_14_1 in ipairs(var_14_3) do
		if var_14_1 >= BigMonthCardAccumulationCfg[iter_14_1].accumulation and not table.indexof(var_14_0, iter_14_1) then
			manager.notify:CallUpdateFunc(SIGN_INPUT, false)
			BigMonthCardAction.AccumulateSign(iter_14_1)

			return
		end
	end

	manager.notify:CallUpdateFunc(SIGN_INPUT, true)
	arg_14_0.hander_:CheckSign()
end

function var_0_0.OnShow(arg_15_0)
	arg_15_0:RefreshUI()
	arg_15_0:RegistEventListener(GET_BIG_MONTH_SIGN, function()
		arg_15_0:RefreshUI()
	end)
	arg_15_0:RegistEventListener(GET_BIG_MONTH_ACCUMULATE_SIGN, function()
		arg_15_0:RefreshUI()
	end)
	arg_15_0:RegistEventListener(BUY_BIG_MONTH_CARD, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_big_monthcard = 1
		})
		arg_15_0:RefreshUI()
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)
		BigMonthCardAction.SignToday()
	end)
	SDKTools.SendPaymentMessageToSDK("payment_big_monthcard_click", {
		big_monthcard_click = 1
	})
end

function var_0_0.RefreshUI(arg_19_0)
	if BigMonthCardData:HaveMonthCard() then
		arg_19_0:RefreshUnlock()
	else
		arg_19_0:RefreshLock()
	end

	arg_19_0:RefreshReward()
end

function var_0_0.RefreshUnlock(arg_20_0)
	local var_20_0 = false
	local var_20_1 = BigMonthCardData:IsSignToday()

	if var_20_1 then
		arg_20_0.btnCon_:SetSelectedState("signed")
	else
		arg_20_0.btnCon_:SetSelectedState("unlock")
	end

	local var_20_2 = BigMonthCardData:GetSignDays()

	arg_20_0.lastDays_.text = BigMonthCardData:GetMonthCardLastDay() .. GetTips("DAY")

	local var_20_3 = 0
	local var_20_4 = BigMonthCardData:GetHaveSign()
	local var_20_5 = BigMonthCardData:GetTemplateId()
	local var_20_6 = BigMonthCardAccumulationCfg.get_id_list_by_template_id[var_20_5]

	for iter_20_0, iter_20_1 in ipairs(var_20_6) do
		local var_20_7 = var_20_6[iter_20_0]
		local var_20_8 = BigMonthCardAccumulationCfg[var_20_7].accumulation

		if var_20_8 <= var_20_2 then
			local var_20_9 = table.indexof(var_20_4, var_20_7)

			arg_20_0.stateCon_[iter_20_0]:SetSelectedState(var_20_9 and "received" or "complete")

			if iter_20_0 ~= 1 then
				arg_20_0.slider_[iter_20_0 - 1].value = 1
			end

			if var_20_2 == var_20_8 and var_20_9 then
				var_20_0 = true
			end

			if var_20_9 and arg_20_0.itemAni[iter_20_0] then
				arg_20_0.itemAni[iter_20_0].enabled = false
			end
		else
			local var_20_10 = var_20_6[iter_20_0 - 1]
			local var_20_11 = var_20_10 and BigMonthCardAccumulationCfg[var_20_10].accumulation or 0
			local var_20_12 = var_20_2 - var_20_11
			local var_20_13 = var_20_12 <= 0 and 0 or var_20_12
			local var_20_14 = var_20_8 - var_20_11

			if var_20_3 ~= 0 then
				var_20_3 = var_20_3 < var_20_8 - var_20_2 and var_20_3 or var_20_8 - var_20_2
			else
				var_20_3 = var_20_8 - var_20_2
			end

			if iter_20_0 ~= 1 then
				arg_20_0.slider_[iter_20_0 - 1].value = var_20_13 / var_20_14
			end
		end
	end

	if var_20_3 ~= 0 then
		arg_20_0.next_.text = string.format(GetTips("SIGN_TITLE_BIGMONTHCARD_TIP"), var_20_3)

		arg_20_0.dayCon_:SetSelectedState("true")
	else
		arg_20_0.dayCon_:SetSelectedState("false")
	end

	if var_20_0 then
		arg_20_0.tip_.text = GetTips("BIG_CARD_TIPS_4")
	elseif var_20_1 then
		arg_20_0.tip_.text = GetTips("BIG_CARD_TIPS_3")
	else
		arg_20_0.tip_.text = GetTips("BIG_CARD_TIPS_2")
	end

	arg_20_0:ResetTipTimer()
end

function var_0_0.RefreshLock(arg_21_0)
	arg_21_0.btnCon_:SetSelectedState("lock")
	arg_21_0.dayCon_:SetSelectedState("false")

	for iter_21_0 = 1, 4 do
		arg_21_0.stateCon_[iter_21_0]:SetSelectedState("uncomplete")

		if arg_21_0.itemAni[iter_21_0] then
			arg_21_0.itemAni[iter_21_0].enabled = false
		end
	end

	for iter_21_1 = 1, 3 do
		arg_21_0.slider_[iter_21_1].value = 0
	end

	arg_21_0:StopTipTimer()

	if BigMonthCardData:IsExpireTip() == 1 then
		arg_21_0.tip_.text = GetTips("BIG_CARD_TIPS_5")
	else
		arg_21_0.tip_.text = GetTips("BIG_CARD_TIPS_1")
	end
end

function var_0_0.ResetTipTimer(arg_22_0)
	arg_22_0:StopTipTimer()
	SetActive(arg_22_0.tipGo_, true)

	arg_22_0.tipTimer_ = Timer.New(function()
		SetActive(arg_22_0.tipGo_, false)
		arg_22_0:StopTipTimer()
	end, 5, 1)

	arg_22_0.tipTimer_:Start()
end

function var_0_0.StopTipTimer(arg_24_0)
	if arg_24_0.tipTimer_ then
		arg_24_0.tipTimer_:Stop()

		arg_24_0.tipTimer_ = nil
	end
end

function var_0_0.OnHide(arg_25_0)
	arg_25_0:StopTipTimer()
	arg_25_0:RemoveAllEventListener()
end

return var_0_0
