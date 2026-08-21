local var_0_0 = class("ItemExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/XH2ndRecharge"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.refreshVitalityHandler_ = handler(arg_3_0, arg_3_0.RefreshVitality)
	arg_3_0.okController_ = ControllerUtil.GetController(arg_3_0.okBtn_.transform, "enabled")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.exchangeID_ = arg_4_0.params_.exchangeID
	arg_4_0.maxCnt_ = arg_4_0.params_.maxCnt

	arg_4_0:CalcMaxCnt()
	arg_4_0:InitExchangeCurrency()
	arg_4_0:RefreshVitality()
	arg_4_0:RefreshCountdown()
	manager.notify:RegistListener(CURRENCY_UPDATE, arg_4_0.refreshVitalityHandler_)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
	manager.notify:RemoveListener(CURRENCY_UPDATE, arg_5_0.refreshVitalityHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.refreshVitalityHandler_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		local var_9_0 = ItemExchangeCfg[arg_7_0.exchangeID_]
		local var_9_1 = tonumber(arg_7_0.cntText_.text)

		if var_9_1 > arg_7_0.uiMaxCnt_ then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_9_0.cost[1][1])))

			return
		end

		CurrencyAction.ExchangeItem(arg_7_0.exchangeID_, var_9_1, function(arg_10_0)
			ShowTips("EXCHANGE_SUCCESS")
			arg_7_0:Back()
		end)
	end)
	arg_7_0:AddBtnListener(arg_7_0.addBtn_, nil, function()
		local var_11_0 = tonumber(arg_7_0.cntText_.text)

		if var_11_0 + 1 <= arg_7_0.uiMaxCnt_ then
			arg_7_0.cntText_.text = var_11_0 + 1

			arg_7_0:RefreshExchangeCurrenty()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.subBtn_, nil, function()
		local var_12_0 = tonumber(arg_7_0.cntText_.text)

		if var_12_0 > 1 then
			arg_7_0.cntText_.text = var_12_0 - 1

			arg_7_0:RefreshExchangeCurrenty()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.maxBtn_, nil, function()
		arg_7_0.cntText_.text = arg_7_0.uiMaxCnt_ < 1 and 1 or arg_7_0.uiMaxCnt_

		arg_7_0:RefreshExchangeCurrenty()
	end)
end

function var_0_0.CalcMaxCnt(arg_14_0)
	arg_14_0.uiMaxCnt_ = arg_14_0.maxCnt_

	local var_14_0 = arg_14_0.exchangeID_
	local var_14_1 = ItemExchangeCfg[var_14_0]

	for iter_14_0, iter_14_1 in ipairs(var_14_1.cost) do
		local var_14_2 = iter_14_1[1]
		local var_14_3 = ItemTools.getItemNum(var_14_2)
		local var_14_4 = math.floor(var_14_3 / iter_14_1[2])

		if var_14_4 < arg_14_0.uiMaxCnt_ then
			arg_14_0.uiMaxCnt_ = var_14_4
		end
	end
end

function var_0_0.InitExchangeCurrency(arg_15_0)
	local var_15_0 = ItemExchangeCfg[arg_15_0.exchangeID_]
	local var_15_1 = var_15_0.cost[1][1]

	arg_15_0.leftIconImage_.sprite = ItemTools.getItemLittleSprite(var_15_1)
	arg_15_0.leftNameText_.text = ItemTools.getItemName(var_15_1)
	arg_15_0.leftCntText_.text = var_15_0.cost[1][2]
	arg_15_0.rightIconImage_.sprite = ItemTools.getItemLittleSprite(var_15_0.item_id)
	arg_15_0.rightNameText_.text = ItemTools.getItemName(var_15_0.item_id)
	arg_15_0.rightCntText_.text = 1
	arg_15_0.cntText_.text = 1

	SetActive(arg_15_0.currentyPanel_, var_15_1 == CurrencyConst.CURRENCY_TYPE_VITALITY)
end

function var_0_0.RefreshExchangeCurrenty(arg_16_0)
	local var_16_0 = tonumber(arg_16_0.cntText_.text)
	local var_16_1 = ItemExchangeCfg[arg_16_0.exchangeID_].cost[1][2]

	arg_16_0.leftCntText_.text = var_16_0 * var_16_1
	arg_16_0.rightCntText_.text = var_16_0
	arg_16_0.subBtn_.interactable = var_16_0 > 1
	arg_16_0.addBtn_.interactable = var_16_0 < arg_16_0.uiMaxCnt_
	arg_16_0.maxBtn_.interactable = var_16_0 < arg_16_0.uiMaxCnt_
end

function var_0_0.RefreshVitality(arg_17_0)
	local var_17_0 = PlayerData:GetPlayerInfo().userLevel
	local var_17_1 = GameLevelSetting[var_17_0].fatigue_max
	local var_17_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

	arg_17_0.vitalityCntText_.text = string.format("%s/%s", var_17_2, var_17_1)

	local var_17_3 = var_17_2 < var_17_1

	SetActive(arg_17_0.singleCdGo_, var_17_3)
	SetActive(arg_17_0.allCdGo_, var_17_3)

	local var_17_4 = ItemExchangeCfg[arg_17_0.exchangeID_]

	arg_17_0:CalcMaxCnt()
	arg_17_0.okController_:SetSelectedState(tostring(arg_17_0.uiMaxCnt_ > 0))
	arg_17_0:RefreshExchangeCurrenty()
end

function var_0_0.during(arg_18_0)
	local var_18_0 = GameSetting.fatigue_recovery.value[1] * 60

	return CurrencyData:GetLastFatigueRecoverTime() == 0 and var_18_0 or var_18_0 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % var_18_0
end

function var_0_0.RefreshCountdown(arg_19_0)
	arg_19_0:StopTimer()

	local var_19_0 = arg_19_0:during()
	local var_19_1 = GameSetting.fatigue_recovery.value[1] * 60
	local var_19_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_19_3 = PlayerData:GetPlayerInfo().userLevel
	local var_19_4 = GameLevelSetting[var_19_3].fatigue_max
	local var_19_5 = (var_19_4 - var_19_2 - 1) * var_19_1 + var_19_0

	arg_19_0.singleCdText_.text = string.format("%02d:%02d:%02d", math.floor(var_19_0 / 3600), math.floor(var_19_0 % 3600 / 60), var_19_0 % 60)
	arg_19_0.allCdText_.text = string.format("%02d:%02d:%02d", math.floor(var_19_5 / 3600), math.floor(var_19_5 % 3600 / 60), var_19_5 % 60)
	arg_19_0.timer_ = Timer.New(function()
		var_19_0 = arg_19_0:during()
		var_19_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		var_19_5 = (var_19_4 - var_19_2 - 1) * var_19_1 + var_19_0
		arg_19_0.singleCdText_.text = string.format("%02d:%02d:%02d", math.floor(var_19_0 / 3600), math.floor(var_19_0 % 3600 / 60), var_19_0 % 60)
		arg_19_0.allCdText_.text = string.format("%02d:%02d:%02d", math.floor(var_19_5 / 3600), math.floor(var_19_5 % 3600 / 60), var_19_5 % 60)

		if var_19_0 <= 0 then
			arg_19_0:StopTimer()
		end
	end, 0.2, -1)

	arg_19_0.timer_:Start()
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end
end

return var_0_0
