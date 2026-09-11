local cjson = require("cjson")
local var_0_1 = {}
local var_0_2
local var_0_3
local var_0_4
local var_0_5 = 0

function var_0_1.RefreshAllRedPoint()
	var_0_1.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.LIMIT_SUPPLY)
	var_0_1.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.DAILY_SUPPLY)
	var_0_1.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.NEWBIE_SHOP)
	var_0_1.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.RE_COME_SHOP)
	var_0_1.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.NEW_SERVER_SHOP)
end

manager.net:Bind(34009, function(arg_2_0)
	print(string.format("=======> pay result, channel = %s, platform = %s, create_timestamp = %s", tostring(arg_2_0.order.channel), tostring(arg_2_0.order.platform), tostring(arg_2_0.order.create_timestamp)))
	RechargeData:RecordTotalRecharge(arg_2_0.order.goods_id)
	var_0_1.UpdateTotalRechargeRedPoint()

	if SDKTools.IsSDK() and arg_2_0.order.is_web_recharge ~= true and (arg_2_0.order.channel ~= var_0_2 or arg_2_0.order.platform ~= var_0_3 or arg_2_0.order.create_timestamp ~= var_0_4) then
		return
	end

	if var_0_1.payTimer_ ~= nil then
		var_0_1.payTimer_:Stop()

		var_0_1.payTimer_ = nil
	end

	var_0_1.ShowWaiting(false)

	local var_2_0 = arg_2_0.order.order_id
	local var_2_1 = arg_2_0.order.goods_id
	local var_2_3 = arg_2_0.order.value
	local var_2_6 = PaymentCfg[arg_2_0.order.goods_id]
	local var_2_7 = getShopCfg(arg_2_0.order.shop_goods_id)

	if var_2_7 then
		local var_2_8

		if var_2_7.give_id then
			var_2_8 = ItemCfg[var_2_7.give_id] or RechargeShopDescriptionCfg[var_2_7.description]
		end

		ShowTips(string.format(GetTips("PAY_SUCCESS"), GetI18NText((var_2_8 or nil) and (var_2_8.name or tostring(arg_2_0.order.shop_goods_id)))))
	else
		ShowTips(string.format(GetTips("PAY_SUCCESS"), GetI18NText(var_2_6.name)))
	end

	if var_2_6.type == 1 then
		RechargeData:RecordRecharge(var_2_1)
	elseif var_2_6.type == 2 then
		RechargeData:SignToday()
	elseif var_2_6.type == 3 then
		PassportData:BuyedCard(var_2_6.id)
	end

	if arg_2_0.reward and #arg_2_0.reward > 0 then
		if whereami == "battle" or whereami == "battleResult" or manager.guide:IsPlaying() then
			manager.notify:Invoke(RECHARGE_SUCCESS, var_2_6.id)
		else
			getReward(arg_2_0.reward, nil, function()
				manager.notify:Invoke(RECHARGE_SUCCESS, var_2_6.id)
				var_0_1.AfterPayGetReward(arg_2_0.reward)
			end)
		end
	else
		manager.notify:Invoke(RECHARGE_SUCCESS, var_2_6.id)
	end

	if var_2_6.type == 1 then
		SendMessageManagerToSDK("purchase_crystal", {
			purchaseNum = var_2_6.total_point
		})
	elseif var_2_6.type == 3 then
		SendMessageManagerToSDK("passport_complete")
	elseif var_2_6.type == 4 then
		SendMessageManagerToSDK("purchase_complete_skin")
	end

	if var_0_5 <= 0 then
		var_0_5 = var_0_5 + var_2_3 / 100

		SendMessageManagerToSDK("purchase_first_ys")
	end

	SendMessageManagerToSDK("purchase_complete")
	SendMessageManagerToSDK("purchase_ys", {
		value = var_2_3 / 100,
		order_id = var_2_0,
		currency_type = var_2_6.currency_type
	})
end)

function var_0_1.AfterPayGetReward(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		if ItemCfg[iter_4_1.id] and ItemCfg[iter_4_1.id].type == 5 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == ItemCfg[iter_4_1.id].sub_type then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("LUCKILYBAG_JUMP"),
				OkCallback = function()
					JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
				end
			})

			return
		end
	end
end

manager.notify:RegistListener(RECHARGE_FAILED, function()
	var_0_1.ShowWaiting(false)
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_1.RefreshAllRedPoint()
end)
manager.notify:RegistListener(OPERATION_STOP_UPDATE, function()
	var_0_1.RefreshAllRedPoint()
end)
manager.notify:RegistListener(SHOP_LIST_UPDATE, function(arg_9_0)
	if arg_9_0 == 0 then
		var_0_1.RefreshAllRedPoint()
	end
end)
manager.notify:RegistListener(SHOP_ITEM_UPDATE, function(arg_10_0, arg_10_1)
	if arg_10_0 == ShopConst.SHOP_ID.LIMIT_SUPPLY or arg_10_0 == ShopConst.SHOP_ID.DAILY_SUPPLY or arg_10_0 == ShopConst.SHOP_ID.NEWBIE_SHOP or arg_10_0 == ShopConst.SHOP_ID.RE_COME_SHOP or arg_10_0 == ShopConst.SHOP_ID.NEW_SERVER_SHOP then
		var_0_1.RefreshAllRedPoint()
	end
end)
manager.net:Bind(34007, function(arg_11_0)
	RechargeData:InitTotalRechargeDataFromServer(arg_11_0)
	SDKTools.SetRechargePublicAttribute()
	var_0_1.UpdateTotalRechargeRedPoint()
	var_0_1.UpdateVersionRechargeRedPoint()

	var_0_5 = arg_11_0.total_recharge_num / 100
end)
manager.net:Bind(34021, function(arg_12_0)
	RechargeData:InitFirstChargeDataFromServer(arg_12_0)
end)

local var_0_6 = -1

manager.net:Bind(34023, function(arg_13_0)
	if var_0_6 >= 0 and arg_13_0.monthly_card_num > var_0_6 then
		SendMessageManagerToSDK("purchase_complete_montlycard")
	end

	var_0_6 = arg_13_0.monthly_card_num

	RechargeData:InitWithServerData(arg_13_0)
	SDKTools.SetRechargePublicAttribute()
end)

function var_0_1.UpdateFreeGiftRedPoint(arg_14_0)
	if arg_14_0 ~= ShopConst.SHOP_ID.LIMIT_SUPPLY and arg_14_0 ~= ShopConst.SHOP_ID.DAILY_SUPPLY and arg_14_0 ~= ShopConst.SHOP_ID.NEWBIE_SHOP and arg_14_0 ~= ShopConst.SHOP_ID.RE_COME_SHOP and arg_14_0 ~= ShopConst.SHOP_ID.NEW_SERVER_SHOP then
		return
	end

	local var_14_0 = ShopData.GetShop(arg_14_0)
	local var_14_1

	if not var_14_0 then
		do return end

		var_14_1 = 0
	end

	for iter_14_0, iter_14_1 in pairs(var_14_0.shopItemIDs) do
		local var_14_2

		if ShopTools.GetPrice(iter_14_1) == 0 and ShopTools.IsGoodCanDisplay(arg_14_0, iter_14_1) and ShopData.IsGoodUnlock(iter_14_1) == 1 and not ShopData.IsSoldout(arg_14_0, iter_14_1) then
			var_14_1 = 1
			var_14_2 = 0
		end

		for iter_14_2, iter_14_3 in pairs(var_14_0.shopItemIDs) do
			if ShopTools.GetPrice(iter_14_3) == 0 and ShopTools.IsGoodCanDisplay(arg_14_0, iter_14_3) and ShopData.IsGoodUnlock(iter_14_3) == 1 and not ShopData.IsSoldout(arg_14_0, iter_14_3) then
				var_14_2 = 1
			end
		end

		if OperationData:IsFunctionStoped(ShopListCfg[arg_14_0].operation_stop_id) then
			var_14_2 = 0
		end

		if arg_14_0 == ShopConst.SHOP_ID.LIMIT_SUPPLY then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_BONUS_FREE, var_14_2)
		elseif arg_14_0 == ShopConst.SHOP_ID.DAILY_SUPPLY then
			manager.redPoint:setTip(RedPointConst.NORMAL_BONUS_FREE, var_14_2)
		elseif arg_14_0 == ShopConst.SHOP_ID.NEWBIE_SHOP then
			manager.redPoint:setTip(RedPointConst.NEWBIE_BONUS_FREE, var_14_2)
		elseif arg_14_0 == ShopConst.SHOP_ID.RE_COME_SHOP then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SUPPLY_FREE, var_14_2)
		elseif arg_14_0 == ShopConst.SHOP_ID.NEW_SERVER_SHOP then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE, var_14_2)
		end
	end

	if OperationData:IsFunctionStoped(ShopListCfg[arg_14_0].operation_stop_id) then
		var_14_1 = 0
	end

	if arg_14_0 == ShopConst.SHOP_ID.LIMIT_SUPPLY then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_BONUS_FREE, var_14_1)
	elseif arg_14_0 == ShopConst.SHOP_ID.DAILY_SUPPLY then
		manager.redPoint:setTip(RedPointConst.NORMAL_BONUS_FREE, var_14_1)
	elseif arg_14_0 == ShopConst.SHOP_ID.NEWBIE_SHOP then
		manager.redPoint:setTip(RedPointConst.NEWBIE_BONUS_FREE, var_14_1)
	elseif arg_14_0 == ShopConst.SHOP_ID.RE_COME_SHOP then
		manager.redPoint:setTip(RedPointConst.REGRESSION_SUPPLY_FREE, var_14_1)
	elseif arg_14_0 == ShopConst.SHOP_ID.NEW_SERVER_SHOP then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE, var_14_1)
	end
end

var_0_1.RefreshAllRedPoint()

function var_0_1.UpdateTotalRechargeRedPoint()
	manager.redPoint:setTip(RedPointConst.TOTAL_CHARGE_BONUS, RechargeData:HaveUngetRechargeBonus() and 1 or 0)
end

function var_0_1.UpdateVersionRechargeRedPoint()
	local var_16_0 = getData("Recharge", "version") ~= RechargeData:GetTimeLimitRechargeVersion()

	saveData("Recharge", "version", RechargeData:GetTimeLimitRechargeVersion())
	manager.redPoint:setTip(RedPointConst.TOTAL_CHARGE_BONUS, var_16_0 and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_1.GetMonthCardBonus()
	manager.net:SendWithLoadingNew(34024, {}, 34025, var_0_1.OnGetMonthCardBonus)
end

function var_0_1:OnGetMonthCardBonus(arg_18_1)
	if isSuccess(self.result) then
		RechargeData:SignToday(self.is_sign)
		getReward(self.reward_list, nil, function()
			manager.notify:CallUpdateFunc(MONTH_CARD_DAILY_REWARD)
		end)
		ActivityNewbieTools.SetMonthlyCardSign()
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
	end
end

function var_0_1.RequestGSPay(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	arg_20_1 = arg_20_1 or 1
	var_0_1.gsPayCallback_ = arg_20_6

	local var_20_0 = {
		id = arg_20_0,
		number = arg_20_1
	}

	if arg_20_2 ~= nil then
		var_20_0.shop_id = arg_20_2
	end

	if arg_20_3 ~= nil then
		var_20_0.buy_id = arg_20_3
	end

	if arg_20_4 ~= nil then
		var_20_0.buy_source = arg_20_4
	end

	if arg_20_5 ~= nil and next(arg_20_5) ~= nil then
		var_20_0.ticket = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_5) do
			table.insert(var_20_0.ticket, {
				item_info = {
					id = iter_20_1.id,
					num = iter_20_1.num,
					time_valid = iter_20_1.timeValid
				}
			})
		end
	end

	manager.net:SendWithLoadingNew(34010, var_20_0, 34011, var_0_1.OnRequestGSPayCallback)
	var_0_1.ShowWaiting(true)
	SendMessageManagerToSDK("purchase_click")
end

local function var_0_7(arg_21_0, arg_21_1)
	var_0_2 = arg_21_0.order.channel
	var_0_3 = arg_21_0.order.platform
	var_0_4 = arg_21_0.order.create_timestamp

	print(string.format("=======> pay request, channel = %s, platform = %s, create_timestamp = %s", tostring(var_0_2), tostring(var_0_3), tostring(var_0_4)))

	local var_21_3 = PlayerData:GetPlayerInfo()

	if GameToSDK.PLATFORM_ID == 1 then
		return {
			productId = PaymentCfg[arg_21_1.id].product_id,
			price = arg_21_0.order.value,
			count = arg_21_0.order.num,
			outOrderNo = arg_21_0.order.order_id,
			currency = PaymentCfg[arg_21_1.id].currency_type,
			extraData = arg_21_0.order.extra_data,
			orderSign = arg_21_0.order.sign,
			params = {
				gameRoleId = var_21_3.userID,
				gameRoleName = var_21_3.nick,
				gameRoleLevel = var_21_3.userLevel,
				gameServerId = _G.TMP_SERVER_ID,
				gameServerName = tostring(_G.TMP_SERVER_ID),
				gameServerCode = _G.TMP_SERVER_ID
			}
		}
	elseif GameToSDK.PLATFORM_ID == 0 then
		return {
			orderId = arg_21_0.order.order_id,
			productId = PaymentCfg[arg_21_1.id].product_id,
			productName = PaymentCfg[arg_21_1.id].name,
			productDes = PaymentCfg[arg_21_1.id].describe,
			price = arg_21_0.order.value,
			count = arg_21_0.order.num,
			currentNum = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RMB),
			gameServerId = _G.TMP_SERVER_ID,
			gameServerName = tostring(_G.TMP_SERVER_ID),
			gameServerCode = _G.TMP_SERVER_ID,
			gameRoleId = var_21_3.userID,
			gameRoleName = var_21_3.nick,
			gameRoleLevel = var_21_3.userLevel,
			currency = PaymentCfg[arg_21_1.id].currency_type,
			orderSign = arg_21_0.order.sign,
			extraData = arg_21_0.order.extra_data
		}
	elseif GameToSDK.IsEditorOrPcPlatform() then
		return {
			orderId = arg_21_0.order.order_id,
			productId = PaymentCfg[arg_21_1.id].product_id,
			productName = PaymentCfg[arg_21_1.id].name,
			productDes = PaymentCfg[arg_21_1.id].describe,
			price = arg_21_0.order.value,
			count = arg_21_0.order.num,
			currentNum = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RMB),
			gameServerId = _G.TMP_SERVER_ID,
			gameServerName = tostring(_G.TMP_SERVER_ID),
			gameServerCode = _G.TMP_SERVER_ID,
			gameRoleId = var_21_3.userID,
			gameRoleName = var_21_3.nick,
			gameRoleLevel = var_21_3.userLevel,
			currency = PaymentCfg[arg_21_1.id].currency_type,
			orderSign = arg_21_0.order.sign,
			extraData = arg_21_0.order.extra_data
		}
	elseif GameToSDK.PLATFORM_ID == 4 then
		return {
			orderId = arg_21_0.order.order_id,
			productId = PaymentCfg[arg_21_1.id].product_id,
			productName = PaymentCfg[arg_21_1.id].name,
			productDes = PaymentCfg[arg_21_1.id].describe,
			price = arg_21_0.order.value,
			count = arg_21_0.order.num,
			currentNum = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RMB),
			gameServerId = _G.TMP_SERVER_ID,
			gameServerName = tostring(_G.TMP_SERVER_ID),
			gameServerCode = _G.TMP_SERVER_ID,
			gameRoleId = var_21_3.userID,
			gameRoleName = var_21_3.nick,
			gameRoleLevel = var_21_3.userLevel,
			currency = PaymentCfg[arg_21_1.id].currency_type,
			orderSign = arg_21_0.order.sign,
			extraData = arg_21_0.order.extra_data
		}
	end
end

function var_0_1:OnRequestGSPayCallback(arg_22_1)
	if isSuccess(self.result) then
		if GameToSDK.IsEditorPlatform() then
			ShowTips("PC_SHOP_TIPS2")
			var_0_1.ShowWaiting(false)

			return
		elseif ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
			ShowTips("PC_SHOP_TIPS2")
			var_0_1.ShowWaiting(false)

			return
		else
			print("extra_data = " .. self.order.extra_data)
			GameToSDK.Pay((cjson.encode((var_0_7(self, arg_22_1)))))
			var_0_1.ShowWaiting(true)
		end
	else
		if TipsCfg[self.result] ~= nil then
			ShowTips(TipsCfg[self.result].desc)
		else
			ShowTips(GetTips(tostring(self.result)))
		end

		var_0_1.ShowWaiting(false)
	end

	if var_0_1.gsPayCallback_ ~= nil then
		var_0_1.gsPayCallback_(self)

		var_0_1.gsPayCallback_ = nil
	end
end

function var_0_1.GetTotalRechargeBonus(arg_23_0, arg_23_1)
	var_0_1.isAppend = arg_23_1

	manager.net:SendWithLoadingNew(34012, {
		id_list = arg_23_0
	}, 34013, var_0_1.OnGetTotalRechargeBonus)
end

function var_0_1:OnGetTotalRechargeBonus(arg_24_1)
	if isSuccess(self.result) then
		if var_0_1.isAppend then
			RechargeData:UpdateVersionToTarget()

			var_0_1.isAppend = false
		end

		RechargeData:MarkBonusGet(arg_24_1.id_list)
		getReward(mergeReward(self.reward_list))
		manager.notify:Invoke(GET_TOTAL_RECHARGE_BONUS, arg_24_1.id_list)
		var_0_1.UpdateTotalRechargeRedPoint()
	end
end

function var_0_1.GetVersionRechargeBonus(arg_25_0)
	manager.net:SendWithLoadingNew(34118, {
		id_list = arg_25_0
	}, 34119, var_0_1.OnGetVersionRechargeBonus)
end

function var_0_1:OnGetVersionRechargeBonus(arg_26_1)
	if isSuccess(self.result) then
		RechargeData:MarkVersionBonusGet(arg_26_1.id_list)
		getReward(mergeReward(self.reward_list))
		manager.notify:Invoke(GET_TOTAL_RECHARGE_BONUS, arg_26_1.id_list)
		var_0_1.UpdateTotalRechargeRedPoint()
	end
end

function var_0_1.ShowWaiting(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or 180

	SetForceShowQuanquan(arg_27_0)

	if arg_27_0 then
		var_0_1.payTimer_ = TimeTools.StartAfterSeconds(arg_27_1, function()
			if var_0_1.payTimer_ ~= nil then
				var_0_1.payTimer_:Stop()

				var_0_1.payTimer_ = nil
			end

			SetForceShowQuanquan(false)
		end, {})
	elseif var_0_1.payTimer_ ~= nil then
		var_0_1.payTimer_:Stop()

		var_0_1.payTimer_ = nil
	end
end

return var_0_1
