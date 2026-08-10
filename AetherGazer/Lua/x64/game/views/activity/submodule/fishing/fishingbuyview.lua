local var_0_0 = class("FishingBuyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingBuyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.slider_ = LuaSlider.New(arg_5_0.sliderGo_)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.slider_:SetNumChangeHandler(function(arg_7_0)
		arg_6_0:UpdateView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		local var_9_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
		local var_9_1 = arg_6_0.slider_:GetSelectedNum()

		if var_9_0 < arg_6_0.cfg_.price * var_9_1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		end

		FishingAction.FishingBuyFish(ActivityConst.SUMMER_FISHING, arg_6_0.params_.fishId, var_9_1)
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(FISHING_BUY_SUCCESS, function()
		arg_10_0:Back()
	end)
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_0 = arg_12_0.slider_:GetSelectedNum()

	arg_12_0.buyNumLabel_.text = var_12_0
	arg_12_0.useText_.text = arg_12_0.cfg_.price * arg_12_0.slider_:GetSelectedNum()
	arg_12_0.getText_.text = arg_12_0.slider_:GetSelectedNum()

	local var_12_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)

	arg_12_0.maxNum_ = 10000

	if arg_12_0.cfg_.price ~= nil and arg_12_0.cfg_.price ~= 0 then
		arg_12_0.maxNum_ = math.floor(var_12_1 / arg_12_0.cfg_.price)
	end
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_14_0)
	arg_14_0:ShowDefaultBar()
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()

	arg_15_0.cfg_ = RareFishCfg[arg_15_0.params_.fishId]
	arg_15_0.icon1_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	arg_15_0.icon2_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Fishing/RareFishIcon/%d", arg_15_0.params_.fishId))
	arg_15_0.useNameText_.text = ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	arg_15_0.getNameText_.text = GetI18NText(RareFishCfg[arg_15_0.params_.fishId].name)

	arg_15_0:UpdateView()
	arg_15_0.slider_:SetData(1, arg_15_0.maxNum_)
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()

	if arg_16_0.slider_ then
		arg_16_0.slider_:Reset()
	end
end

function var_0_0.OnMainHomeViewTop(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.slider_ then
		arg_18_0.slider_:Dispose()

		arg_18_0.slider_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
