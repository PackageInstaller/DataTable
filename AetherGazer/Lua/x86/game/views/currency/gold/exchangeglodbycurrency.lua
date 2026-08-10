local var_0_0 = class("ExchangeGlodByCurrency", ReduxView)

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
	local var_5_0 = CurrencyData:GetGoldBuyTimes()

	if var_5_0 < GameSetting.coin_max_buy_time.value[1] then
		local var_5_1 = GameCurrencyBuySetting[var_5_0 + 1].cost_diamond_to_money
		local var_5_2 = GameCurrencyBuySetting[var_5_0 + 1].diamond_to_money
		local var_5_3 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

		if var_5_3 < var_5_1 then
			ShopTools.DefaultOpenPopUp(var_5_1 - var_5_3)

			return
		end

		local var_5_4 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipDiamondBuyGoldTip and var_5_4.diamond_buy_gold_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("PAY_FOR_POWER"), var_5_1, ItemTools.getItemName(CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id), var_5_2),
				OkCallback = function()
					_G.SkipTip.SkipDiamondBuyGoldTip = arg_5_0.SkipDiamondBuyGoldTip_

					CurrencyAction.BuyCoin()
				end,
				ToggleCallback = function(arg_7_0)
					arg_5_0.SkipDiamondBuyGoldTip_ = arg_7_0
				end
			})
		else
			CurrencyAction.BuyCoin()
		end
	else
		ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
	end
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = CurrencyData:GetGoldBuyTimes()
	local var_8_1 = GameCurrencyBuySetting[var_8_0 + 1].cost_diamond_to_money
	local var_8_2 = formatNumber(GameCurrencyBuySetting[var_8_0 + 1].diamond_to_money)
	local var_8_3 = GameSetting.coin_max_buy_time.value[1]

	arg_8_0.limitCntText_.text = string.format(GetTips("ITEM_REMAIN"), var_8_3 - CurrencyData:GetGoldBuyTimes(), var_8_3)
	arg_8_0.useNumText_.text = var_8_1
	arg_8_0.getNumText_.text = var_8_2
	arg_8_0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_EXCHANGE"), var_8_1, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), var_8_2, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_GOLD))
end

return var_0_0
