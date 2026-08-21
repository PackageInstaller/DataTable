local var_0_0 = class("ExchangeFatigueByCurrency", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.OnExchange(arg_5_0)
	local var_5_0 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].diamond_to_fatigue

	if var_5_0 + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return false
	end

	if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] then
		local var_5_1 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue

		if var_5_1 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) then
			ShopTools.DefaultOpenPopUp(var_5_1 - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND))

			return
		end

		local var_5_2 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipDiamondBuyFatigueTip and var_5_2.diamond_buy_fatigue_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("PAY_FOR_POWER"), var_5_1, ItemTools.getItemName(CurrencyIdMapCfg.CURRENCY_TYPE_FATIGUE.item_id), var_5_0),
				OkCallback = function()
					_G.SkipTip.SkipDiamondBuyFatigueTip = arg_5_0.SkipDiamondBuyFatigueTip_

					CurrencyAction.BuyFatigue()
				end,
				ToggleCallback = function(arg_7_0)
					arg_5_0.SkipDiamondBuyFatigueTip_ = arg_7_0
				end
			})
		else
			CurrencyAction.BuyFatigue()
		end
	else
		ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
	end
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue
	local var_8_1 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].diamond_to_fatigue
	local var_8_2 = GameSetting.fatigue_max_buy_time.value[1]

	arg_8_0.limitCntText_.text = string.format(GetTips("ITEM_REMAIN"), var_8_2 - CurrencyData:GetFatigueBuyTimes(), var_8_2)
	arg_8_0.useNumText_.text = var_8_0
	arg_8_0.getNumText_.text = var_8_1
	arg_8_0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_EXCHANGE"), var_8_0, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), var_8_1, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_VITALITY))
end

return var_0_0
