local WindowCurrencyItem = class("WindowCurrencyItem", import("game.extend.ReduxView"))

function WindowCurrencyItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.currencyType_ = arg_1_2

	self:Init()
end

function WindowCurrencyItem:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:RefreshUI()

	self.isCanAdd_ = true
	self.isCanClick_ = false
end

function WindowCurrencyItem:AddListeners()
	self:AddBtnListener(nil, nil, "OnClick")
	self:AddBtnListener(self.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, self.currencyType_, self.gameObject_)

		if self.currencyType_ == CurrencyConst.GetPlatformDiamondId() then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].flower_tips == 1 then
				JumpTools.OpenPageByJump("totalRecharge")
			end
		elseif self.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY and self.OnClickCurrencyFunc_ then
			self.OnClickCurrencyFunc_()
		end
	end)
end

function WindowCurrencyItem:OnClick()
	if self.isCanAdd_ or self.isCanClick_ then
		local var_5_0 = self.currencyType_

		if self.currencyType_ == CurrencyConst.CURRENCY_TYPE_GOLD then
			local var_5_1 = false

			for iter_5_0, iter_5_1 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
				if ItemTools.getItemNum(iter_5_1) > 0 then
					var_5_1 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_5_1 then
				OperationRecorder.RecordButtonTouch("homepage_gold")
				JumpTools.OpenPopUp("currencyBuyGold", self.params_, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
			end
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. self.class.__cname, "hongjing")
				OperationRecorder.RecordButtonTouch("homepage_diamond")
				ShopTools.DefaultOpenPopUp(0)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			end
		elseif var_5_0 == CurrencyConst.GetPlatformDiamondId() then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			else
				JumpTools.GoToSystem("/rechargeMain", {
					childShopIndex = 2,
					page = 3
				}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
				OperationRecorder.RecordButtonTouch("homepage_flower")
			end
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_SKIN then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			else
				JumpTools.GoToSystem("/rechargeMain", {
					childShopIndex = 4,
					page = 2
				}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
			end
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. self.class.__cname, "dundunzhi")
			OperationRecorder.RecordButtonTouch("homepage_dundun")
			JumpTools.OpenPopUp("currencyBuyFatigue", self.params_ or {
				page = 0
			}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_R_FRAGMENT or var_5_0 == CurrencyConst.CURRENCY_TYPE_SR_FRAGMENT or var_5_0 == CurrencyConst.CURRENCY_TYPE_SSR_FRAGMENT then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_5_0,
				0
			})
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_EQUIP_PIECE or var_5_0 == CurrencyConst.CURRENCY_TYPE_EQUIP_CHIP_FIVESTAR or var_5_0 == CurrencyConst.CURRENCY_TYPE_EQUIP_CHIP_SIXSTAR then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_5_0,
				0
			})
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_MYTHIC then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_5_0,
				0
			})
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN or var_5_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_RING or var_5_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION or var_5_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT or var_5_0 == CurrencyConst.CURRENCY_TYPE_BOSS_CHALLENGE then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_5_0,
				0
			})
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_CLUB_A or var_5_0 == CurrencyConst.CURRENCY_TYPE_CLUB_B then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_5_0,
				0
			})
		else
			ShowPopItem(POP_SOURCE_ITEM, {
				var_5_0,
				0
			})
		end
	end
end

function WindowCurrencyItem:SetCanAdd(arg_6_1)
	if self.isCanAdd_ == arg_6_1 then
		return
	end

	self.isCanAdd_ = arg_6_1

	SetActive(self.add_, arg_6_1)
end

function WindowCurrencyItem:SetCanClick(arg_7_1)
	self.isCanClick_ = arg_7_1
end

function WindowCurrencyItem:RefreshUI()
	self.text_.text = self.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY and NumberTools.RetractNumberForWindBar(self:GetCnt(self.currencyType_)) .. "/" .. GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max or self.currencyType_ == CurrencyConst.GetPlatformDiamondId() and NumberTools.RetractNumberForWindBar(CurrencyData:GetRechargeDiamond()) or NumberTools.RetractNumberForWindBar(self:GetCnt(self.currencyType_))
	self.icon_.sprite = ItemTools.getItemLittleSprite(self.currencyType_)
end

function WindowCurrencyItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)

	if arg_9_1 then
		self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.UpdateCurrencyNum))
		self:RefreshUI()
		self.transform_:SetAsLastSibling()

		if self.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
			self:BindDailyFatigueRedPoint()
		end
	else
		self:RemoveAllEventListener()

		if self.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
			self:UnbindDailyFatigueRedPoint()
		end
	end
end

function WindowCurrencyItem:UpdateCurrencyNum(arg_10_1)
	if arg_10_1 == 0 or arg_10_1 == self.currencyType_ or CurrencyData:IsRechargeDiamond(arg_10_1) and CurrencyData:IsRechargeDiamond(self.currencyType_) then
		self:RefreshUI()

		if arg_10_1 == CurrencyConst.CURRENCY_TYPE_VITALITY and GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= self:GetCnt(self.currencyType_) and self.OnStopTimerFunc_ then
			self.OnStopTimerFunc_()
		end
	end
end

function WindowCurrencyItem:GetCnt(arg_11_1)
	if arg_11_1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		return CommunityData:GetCurrenyA()
	elseif arg_11_1 == CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE then
		return ActivityReforgeData:GetCurCanUseGold()
	else
		return ItemTools.getItemNum(arg_11_1)
	end
end

function WindowCurrencyItem:HaveVitalityMaterial()
	return #StoreTools.GetMaterialListBySubTypes({
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY,
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID
	}) > 0
end

function WindowCurrencyItem:UnBindListener()
	self:RemoveAllEventListener()
end

function WindowCurrencyItem:RegistClickFunc(arg_14_1)
	self.OnClickCurrencyFunc_ = arg_14_1
end

function WindowCurrencyItem:RegistTimeFunc(arg_15_1)
	self.OnStopTimerFunc_ = arg_15_1
end

function WindowCurrencyItem:BindDailyFatigueRedPoint()
	manager.redPoint:bindUIandKey(self.icon_.transform, RedPointConst.DAILY_FATIGUE, {
		x = 49,
		y = 39
	})
	manager.redPoint:updateKey(RedPointConst.DAILY_FATIGUE)
end

function WindowCurrencyItem:UnbindDailyFatigueRedPoint()
	manager.redPoint:unbindUIandKey(self.icon_.transform, RedPointConst.DAILY_FATIGUE)
end

function WindowCurrencyItem:Dispose()
	if self.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
		self:UnbindDailyFatigueRedPoint()
	end

	WindowCurrencyItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return WindowCurrencyItem
