local var_0_0 = class("DiamondExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/DiamondExchangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.selector_ = createStructuredSelector({
		rmb = function(arg_4_0)
			return CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RMB)
		end,
		diamond = function(arg_5_0)
			return CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
		end
	})
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0.showText_ = arg_6_0:FindCom("Text", "textbg/text")
	arg_6_0.icon1_ = arg_6_0:FindCom("Image", "panel/message/icon1")
	arg_6_0.icon2_ = arg_6_0:FindCom("Image", "panel/message/icon2")
	arg_6_0.use_ = arg_6_0:FindCom("Text", "panel/message/use")
	arg_6_0.get_ = arg_6_0:FindCom("Text", "panel/message/get")
	arg_6_0.select_ = arg_6_0:FindCom("Text", "panel/message/numbg/select")
	arg_6_0.selectGo_ = arg_6_0:FindGo("panel/message/numbg/select")
	arg_6_0.selectInputGo_ = arg_6_0:FindGo("panel/message/numbg/select_input")
	arg_6_0.selectInput_ = arg_6_0:FindCom("InputField", "panel/message/numbg/select_input")
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener("bgmask", nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListenerScale("btn_ok", nil, function()
		if arg_7_0.model_.rmb == 0 then
			ShowMessageBox({
				content = "秘钻不足，是否前往秘钻投资商店购买？",
				title = GetTips("PROMPT"),
				OkCallback = function()
					return
				end,
				CancelCallback = function()
					return
				end
			})
		end

		if arg_7_0.selectNum_ == 0 then
			return
		end

		CurrencyAction.BuyDiamond(arg_7_0.selectNum_)
	end)
	arg_7_0:AddBtnListenerScale("btn_cancel", nil, function()
		arg_7_0:Back()
	end)

	local var_7_0 = arg_7_0:FindGo("panel/message/numbg/add")

	arg_7_0:AddPressingByTimeListener(var_7_0, 3, 0.5, 0.2, function()
		if arg_7_0.selectNum_ < arg_7_0.model_.rmb then
			arg_7_0.selectNum_ = arg_7_0.selectNum_ + 1

			arg_7_0:RefreshTexts()

			return true
		end

		return false
	end)

	local var_7_1 = arg_7_0:FindGo("panel/message/numbg/cut")

	arg_7_0:AddPressingByTimeListener(var_7_1, 3, 0.5, 0.2, function()
		if arg_7_0.selectNum_ > 1 then
			arg_7_0.selectNum_ = arg_7_0.selectNum_ - 1

			arg_7_0:RefreshTexts()

			return true
		end

		return false
	end)
	arg_7_0:AddBtnListenerScale("panel/message/numbg/max", nil, function()
		arg_7_0.selectNum_ = arg_7_0.model_.rmb

		if arg_7_0.selectNum_ <= 0 then
			arg_7_0.selectNum_ = 1
		end

		arg_7_0:RefreshTexts()
	end)
	arg_7_0:AddBtnListener("panel/message/numbg/select", nil, function()
		arg_7_0.selectInput_.text = arg_7_0.selectNum_

		SetActive(arg_7_0.selectInputGo_, true)
		SetActive(arg_7_0.selectGo_, false)
		arg_7_0.selectInput_:ActivateInputField()
	end)
	arg_7_0.selectInput_.onEndEdit:AddListener(function()
		local var_17_0 = tonumber(arg_7_0.selectInput_.text) or 0

		if var_17_0 > arg_7_0.model_.rmb then
			var_17_0 = arg_7_0.model_.rmb
		end

		if var_17_0 <= 0 then
			var_17_0 = 1
		end

		arg_7_0.selectNum_ = var_17_0

		SetActive(arg_7_0.selectInputGo_, false)
		SetActive(arg_7_0.selectGo_, true)
		arg_7_0:RefreshTexts()
	end)
end

function var_0_0.Render(arg_18_0)
	return
end

function var_0_0.Init(arg_19_0)
	arg_19_0:InitUI()
	arg_19_0:AddUIListener()
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.model_ = arg_20_0.selector_.compute(gameStore.getState())
	arg_20_0.selectNum_ = 1

	arg_20_0:RefreshTexts()
end

function var_0_0.RefreshTexts(arg_21_0)
	arg_21_0.use_.text = arg_21_0.selectNum_
	arg_21_0.get_.text = arg_21_0.selectNum_
	arg_21_0.select_.text = arg_21_0.selectNum_
	arg_21_0.showText_.text = GetI18NText(string.format("是否消耗%d个秘钻兑换%d个虹晶?", arg_21_0.selectNum_, arg_21_0.selectNum_))
end

function var_0_0.OnBuyDiamond(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1.result == 0 then
		arg_22_0:Back()
		ShowTips("TRANSACTION_SUCCESS")
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
