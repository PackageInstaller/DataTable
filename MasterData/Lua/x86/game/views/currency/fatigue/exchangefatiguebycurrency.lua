local ExchangeFatigueByCurrency = class("ExchangeFatigueByCurrency", ReduxView)

function ExchangeFatigueByCurrency:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function ExchangeFatigueByCurrency:OnEnter()
	self:RefreshUI()
end

function ExchangeFatigueByCurrency:OnExit()
	return
end

function ExchangeFatigueByCurrency:Dispose()
	ExchangeFatigueByCurrency.super.Dispose(self)
end

function ExchangeFatigueByCurrency:OnExchange()
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

		if not _G.SkipTip.SkipDiamondBuyFatigueTip and SettingData:GetRemindSettingData().diamond_buy_fatigue_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("PAY_FOR_POWER"), var_5_1, ItemTools.getItemName(CurrencyIdMapCfg.CURRENCY_TYPE_FATIGUE.item_id), var_5_0),
				OkCallback = function()
					_G.SkipTip.SkipDiamondBuyFatigueTip = self.SkipDiamondBuyFatigueTip_

					CurrencyAction.BuyFatigue()
				end,
				ToggleCallback = function(arg_7_0)
					self.SkipDiamondBuyFatigueTip_ = arg_7_0
				end
			})
		else
			CurrencyAction.BuyFatigue()
		end
	else
		ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
	end
end

function ExchangeFatigueByCurrency:RefreshUI()
	local var_8_0 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue
	local var_8_1 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].diamond_to_fatigue

	self.limitCntText_.text = string.format(GetTips("ITEM_REMAIN"), GameSetting.fatigue_max_buy_time.value[1] - CurrencyData:GetFatigueBuyTimes(), GameSetting.fatigue_max_buy_time.value[1])
	self.useNumText_.text = var_8_0
	self.getNumText_.text = var_8_1
	self.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_EXCHANGE"), var_8_0, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), var_8_1, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_VITALITY))
end

return ExchangeFatigueByCurrency
