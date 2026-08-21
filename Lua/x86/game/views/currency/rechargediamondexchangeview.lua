local var_0_0 = class("RechargeDiamondExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/Addshiftedstars"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:UpdateView()
	arg_4_0:UpdateBar()
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_flower_to_diamond = "{" .. ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
	})
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.ConfirmToDo(arg_5_0, arg_5_1)
	local var_5_0 = ItemCfg[arg_5_0.params_.useId]
	local var_5_1 = ItemCfg[arg_5_0.params_.getId]

	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_ticket_check = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
	})

	local var_5_2 = tonumber(arg_5_0.inputFieldText_.text)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("CONFIRM_BUY"), ItemTools.getItemName(arg_5_0.params_.useId), arg_5_0.params_.useBaseNum * var_5_2, ItemTools.getItemName(arg_5_0.params_.getId), arg_5_0.params_.getBaseNum * var_5_2),
		OkCallback = function()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 0
			})
			arg_5_1()
		end,
		CancelCallback = function()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 1
			})
		end
	})
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.okBtn_, nil, function()
		arg_8_0:CheckBuy()
	end)
	arg_8_0:AddPressingByTimeListener(arg_8_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_12_0 = tonumber(arg_8_0.inputFieldText_.text)

		if var_12_0 >= arg_8_0.canUseMaxNum_ then
			return false
		end

		if arg_8_0.pressCnt_ > 1 then
			if arg_8_0.pressCnt_ == 2 then
				var_12_0 = var_12_0 + 9
			else
				var_12_0 = var_12_0 + 10
			end
		else
			var_12_0 = var_12_0 + 1
		end

		if var_12_0 < arg_8_0.canUseMaxNum_ then
			arg_8_0:UpdateCnt(var_12_0)

			return true
		end

		local var_12_1 = arg_8_0.canUseMaxNum_

		arg_8_0:UpdateCnt(var_12_1)

		return false
	end)
	arg_8_0:AddPressingByTimeListener(arg_8_0.delBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_13_0 = tonumber(arg_8_0.inputFieldText_.text)

		if var_13_0 <= 1 then
			return false
		end

		if arg_8_0.pressCnt_ > 1 then
			if arg_8_0.pressCnt_ == 2 then
				var_13_0 = var_13_0 - 9
			else
				var_13_0 = var_13_0 - 10
			end
		else
			var_13_0 = var_13_0 - 1
		end

		if var_13_0 > 1 then
			arg_8_0:UpdateCnt(var_13_0)

			return true
		end

		local var_13_1 = 1

		arg_8_0:UpdateCnt(var_13_1)

		return false
	end)
	arg_8_0:AddBtnListener(arg_8_0.maxBtn_, nil, function()
		arg_8_0:UpdateCnt(arg_8_0.canUseMaxNum_)
	end)
	arg_8_0.inputFieldText_.onValueChanged:AddListener(function()
		local var_15_0 = tonumber(arg_8_0.inputFieldText_.text) or 0

		if var_15_0 < 1 then
			var_15_0 = 1
		end

		arg_8_0:UpdateCnt(var_15_0)
	end)
end

function var_0_0.UpdateView(arg_16_0)
	if arg_16_0.params_.useId then
		arg_16_0.icon1_.sprite = ItemTools.getItemLittleSprite(arg_16_0.params_.useId)
		arg_16_0.useNameText_.text = ItemTools.getItemName(arg_16_0.params_.useId)
	end

	if arg_16_0.params_.getId then
		local var_16_0 = ItemTools.getItemLittleSprite(arg_16_0.params_.getId)

		arg_16_0.icon2_.sprite = var_16_0
		arg_16_0.getImage_.sprite = var_16_0
		arg_16_0.getNameText_.text = ItemTools.getItemName(arg_16_0.params_.getId)
		arg_16_0.titleText_.text = string.format(GetTips("EXCHANGE_TIP"), ItemTools.getItemName(arg_16_0.params_.getId))
	end

	local var_16_1 = arg_16_0:GetTotal()

	arg_16_0.canUseMaxNum_ = math.floor(var_16_1 / (arg_16_0.params_.useBaseNum or 1))

	arg_16_0:UpdateCnt(arg_16_0.params_.defaultNum ~= 0 and arg_16_0.params_.defaultNum or 1)

	local var_16_2 = arg_16_0.canUseMaxNum_ ~= 1

	if var_16_2 == false then
		arg_16_0.addBtn_.interactable = var_16_2
		arg_16_0.maxBtn_.interactable = var_16_2
	end
end

function var_0_0.UpdateBar(arg_17_0)
	arg_17_0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	arg_17_0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	arg_17_0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	end
end

function var_0_0.GetTotal(arg_18_0)
	if arg_18_0.params_.useId == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or arg_18_0.params_.useId == CurrencyConst.GetPlatformDiamondId() then
		return CurrencyData:GetRechargeDiamond()
	end

	return ItemTools.getItemNum(arg_18_0.params_.useId)
end

function var_0_0.UpdateCnt(arg_19_0, arg_19_1)
	arg_19_0.useNumText_.text = NumberTools.RetractNumberForWindBar(arg_19_1 * arg_19_0.params_.useBaseNum)
	arg_19_0.getNumText_.text = NumberTools.RetractNumberForWindBar(arg_19_1)

	if tonumber(arg_19_0.inputFieldText_.text) ~= arg_19_1 then
		arg_19_0.inputFieldText_.text = arg_19_1
	end

	arg_19_0.tipsNumText_.text = arg_19_1

	if arg_19_1 > arg_19_0.canUseMaxNum_ then
		arg_19_0.inputFieldText_.textComponent.color = Color(1, 0, 0.043)
	else
		arg_19_0.inputFieldText_.textComponent.color = Color(0.302, 0.338, 0.389)
	end

	arg_19_0.delBtn_.interactable = arg_19_1 > 1
	arg_19_0.addBtn_.interactable = arg_19_1 < arg_19_0.canUseMaxNum_
	arg_19_0.maxBtn_.interactable = arg_19_1 < arg_19_0.canUseMaxNum_
end

function var_0_0.CheckBuy(arg_20_0)
	local var_20_0 = tonumber(arg_20_0.inputFieldText_.text)

	if arg_20_0.params_.defaultNum ~= 0 then
		var_20_0 = var_20_0 * arg_20_0.params_.useBaseNum
	end

	if arg_20_0.params_.getId == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		if var_20_0 <= CurrencyData:GetRechargeDiamond() then
			arg_20_0:ConfirmToDo(function()
				CurrencyAction.BuyDiamond(var_20_0)
			end)
		else
			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				ShopTools.DiamondEnoughMessageBox()
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
			end
		end
	elseif arg_20_0.params_.exchangeId then
		local var_20_1 = getShopCfg(arg_20_0.params_.exchangeId)
		local var_20_2 = var_20_1.cost_id

		if var_20_2 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < var_20_1.cost * var_20_0 then
				arg_20_0:Back()
				ShopTools.DefaultOpenPopUp(0)

				return
			end
		elseif var_20_2 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE and CurrencyData:GetRechargeDiamond() < var_20_1.cost * var_20_0 then
			arg_20_0:Back()

			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			ShopTools.DiamondEnoughMessageBox()

			return
		end

		arg_20_0:ConfirmToDo(function()
			local var_22_0

			if arg_20_0.params_.buy_source then
				var_22_0 = arg_20_0.params_.buy_source
			end

			ShopAction.BuyItem({
				{
					goodID = var_20_1.goods_id,
					buyNum = var_20_0
				}
			}, nil, var_22_0)
		end)
	end
end

function var_0_0.RestoreBar(arg_23_0)
	if arg_23_0.lastBarList_ then
		manager.windowBar:SwitchBar(arg_23_0.lastBarList_)
	end

	if arg_23_0.lastAddBarList_ then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_23_1, true)
		end
	end

	if arg_23_0.lastCanClickBarList_ then
		for iter_23_2, iter_23_3 in ipairs(arg_23_0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_23_3, true)
		end
	end
end

function var_0_0.OnBuyDiamond(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1.result == 0 then
		arg_24_0:Back()
		ShowTips("TRANSACTION_SUCCESS")
	end
end

function var_0_0.OnShopBuyResult(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_1 == 0 then
		arg_25_0:Back()
	end
end

function var_0_0.OnExit(arg_26_0)
	arg_26_0:RestoreBar()
	manager.windowBar:SetAsFirstSibling()

	arg_26_0.lastBarList_ = nil
	arg_26_0.lastAddBarList_ = nil
	arg_26_0.lastCanClickBarList_ = nil
end

function var_0_0.OnExitInput(arg_27_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_28_0)
	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
