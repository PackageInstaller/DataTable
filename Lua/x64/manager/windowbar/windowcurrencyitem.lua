local var_0_0 = class("WindowCurrencyItem", import("game.extend.ReduxView"))

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.currencyType_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()
	arg_2_0:RefreshUI()

	arg_2_0.isCanAdd_ = true
	arg_2_0.isCanClick_ = false
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(nil, nil, "OnClick")
	arg_3_0:AddBtnListener(arg_3_0.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, arg_3_0.currencyType_, arg_3_0.gameObject_)

		local var_4_0 = arg_3_0.currencyType_

		if var_4_0 == CurrencyConst.GetPlatformDiamondId() then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].flower_tips == 1 then
				JumpTools.OpenPageByJump("totalRecharge")
			end
		elseif var_4_0 == CurrencyConst.CURRENCY_TYPE_VITALITY and arg_3_0.OnClickCurrencyFunc_ then
			arg_3_0.OnClickCurrencyFunc_()
		end
	end)
end

function var_0_0.OnClick(arg_5_0)
	if arg_5_0.isCanAdd_ or arg_5_0.isCanClick_ then
		local var_5_0 = arg_5_0.currencyType_

		if var_5_0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			local var_5_1 = false
			local var_5_2 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]

			for iter_5_0, iter_5_1 in ipairs(var_5_2 or {}) do
				if ItemTools.getItemNum(iter_5_1) > 0 then
					var_5_1 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_5_1 then
				OperationRecorder.RecordButtonTouch("homepage_gold")
				JumpTools.OpenPopUp("currencyBuyGold", arg_5_0.params_, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
			end
		elseif var_5_0 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. arg_5_0.class.__cname, "hongjing")
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
			OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. arg_5_0.class.__cname, "dundunzhi")
			OperationRecorder.RecordButtonTouch("homepage_dundun")
			JumpTools.OpenPopUp("currencyBuyFatigue", arg_5_0.params_ or {
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

function var_0_0.SetCanAdd(arg_6_0, arg_6_1)
	if arg_6_0.isCanAdd_ == arg_6_1 then
		return
	end

	arg_6_0.isCanAdd_ = arg_6_1

	SetActive(arg_6_0.add_, arg_6_1)
end

function var_0_0.SetCanClick(arg_7_0, arg_7_1)
	arg_7_0.isCanClick_ = arg_7_1
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = arg_8_0.currencyType_

	if var_8_0 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		local var_8_1 = PlayerData:GetPlayerInfo().userLevel
		local var_8_2 = GameLevelSetting[var_8_1].fatigue_max

		arg_8_0.text_.text = NumberTools.RetractNumberForWindBar(arg_8_0:GetCnt(arg_8_0.currencyType_)) .. "/" .. var_8_2
	elseif var_8_0 == CurrencyConst.GetPlatformDiamondId() then
		arg_8_0.text_.text = NumberTools.RetractNumberForWindBar(CurrencyData:GetRechargeDiamond())
	else
		arg_8_0.text_.text = NumberTools.RetractNumberForWindBar(arg_8_0:GetCnt(arg_8_0.currencyType_))
	end

	arg_8_0.icon_.sprite = ItemTools.getItemLittleSprite(var_8_0)
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)

	if arg_9_1 then
		arg_9_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_9_0, arg_9_0.UpdateCurrencyNum))
		arg_9_0:RefreshUI()
		arg_9_0.transform_:SetAsLastSibling()

		if arg_9_0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
			arg_9_0:BindDailyFatigueRedPoint()
		end
	else
		arg_9_0:RemoveAllEventListener()

		if arg_9_0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
			arg_9_0:UnbindDailyFatigueRedPoint()
		end
	end
end

function var_0_0.UpdateCurrencyNum(arg_10_0, arg_10_1)
	if arg_10_1 == 0 or arg_10_1 == arg_10_0.currencyType_ or CurrencyData:IsRechargeDiamond(arg_10_1) and CurrencyData:IsRechargeDiamond(arg_10_0.currencyType_) then
		arg_10_0:RefreshUI()

		if arg_10_1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			local var_10_0 = PlayerData:GetPlayerInfo().userLevel

			if GameLevelSetting[var_10_0].fatigue_max <= arg_10_0:GetCnt(arg_10_0.currencyType_) and arg_10_0.OnStopTimerFunc_ then
				arg_10_0.OnStopTimerFunc_()
			end
		end
	end
end

function var_0_0.GetCnt(arg_11_0, arg_11_1)
	if arg_11_1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		return CommunityData:GetCurrenyA()
	elseif arg_11_1 == CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE then
		return ActivityReforgeData:GetCurCanUseGold()
	else
		return ItemTools.getItemNum(arg_11_1)
	end
end

function var_0_0.HaveVitalityMaterial(arg_12_0)
	local var_12_0 = false

	return #StoreTools.GetMaterialListBySubTypes({
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY,
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID
	}) > 0
end

function var_0_0.UnBindListener(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.RegistClickFunc(arg_14_0, arg_14_1)
	arg_14_0.OnClickCurrencyFunc_ = arg_14_1
end

function var_0_0.RegistTimeFunc(arg_15_0, arg_15_1)
	arg_15_0.OnStopTimerFunc_ = arg_15_1
end

function var_0_0.BindDailyFatigueRedPoint(arg_16_0)
	manager.redPoint:bindUIandKey(arg_16_0.icon_.transform, RedPointConst.DAILY_FATIGUE, {
		x = 49,
		y = 39
	})
	manager.redPoint:updateKey(RedPointConst.DAILY_FATIGUE)
end

function var_0_0.UnbindDailyFatigueRedPoint(arg_17_0)
	manager.redPoint:unbindUIandKey(arg_17_0.icon_.transform, RedPointConst.DAILY_FATIGUE)
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
		arg_18_0:UnbindDailyFatigueRedPoint()
	end

	var_0_0.super.Dispose(arg_18_0)

	arg_18_0.transform_ = nil
	arg_18_0.gameObject_ = nil
end

return var_0_0
