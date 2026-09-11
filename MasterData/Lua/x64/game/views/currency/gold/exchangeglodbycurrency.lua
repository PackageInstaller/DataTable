local ExchangeGlodByCurrency = class("ExchangeGlodByCurrency", ReduxView)

function ExchangeGlodByCurrency:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function ExchangeGlodByCurrency:OnEnter()
	self:RefreshUI()
end

function ExchangeGlodByCurrency:OnExit()
	return
end

function ExchangeGlodByCurrency:Dispose()
	ExchangeGlodByCurrency.super.Dispose(self)
end

function ExchangeGlodByCurrency:OnExchange()
	local var_5_0 = CurrencyData:GetGoldBuyTimes()

	if var_5_0 < GameSetting.coin_max_buy_time.value[1] then
		local var_5_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

		if var_5_1 < GameCurrencyBuySetting[var_5_0 + 1].cost_diamond_to_money then
			ShopTools.DefaultOpenPopUp(GameCurrencyBuySetting[var_5_0 + 1].cost_diamond_to_money - var_5_1)

			return
		end

		if not _G.SkipTip.SkipDiamondBuyGoldTip and SettingData:GetRemindSettingData().diamond_buy_gold_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("PAY_FOR_POWER"), GameCurrencyBuySetting[var_5_0 + 1].cost_diamond_to_money, ItemTools.getItemName(CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id), GameCurrencyBuySetting[var_5_0 + 1].diamond_to_money),
				OkCallback = function()
					_G.SkipTip.SkipDiamondBuyGoldTip = self.SkipDiamondBuyGoldTip_

					CurrencyAction.BuyCoin()
				end,
				ToggleCallback = function(arg_7_0)
					self.SkipDiamondBuyGoldTip_ = arg_7_0
				end
			})
		else
			CurrencyAction.BuyCoin()
		end
	else
		ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
	end
end

function ExchangeGlodByCurrency:RefreshUI()
	local var_8_0 = CurrencyData:GetGoldBuyTimes()
	local var_8_1 = formatNumber(GameCurrencyBuySetting[var_8_0 + 1].diamond_to_money)

	self.limitCntText_.text = string.format(GetTips("ITEM_REMAIN"), GameSetting.coin_max_buy_time.value[1] - CurrencyData:GetGoldBuyTimes(), GameSetting.coin_max_buy_time.value[1])
	self.useNumText_.text = GameCurrencyBuySetting[var_8_0 + 1].cost_diamond_to_money
	self.getNumText_.text = var_8_1
	self.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_EXCHANGE"), GameCurrencyBuySetting[var_8_0 + 1].cost_diamond_to_money, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), var_8_1, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_GOLD))
end

return ExchangeGlodByCurrency
