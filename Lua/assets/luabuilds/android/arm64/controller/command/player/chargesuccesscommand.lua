local var_0_0 = class("ChargeSuccessCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = Goods.Create({
		shop_id = var_1_0.shopId
	}, Goods.TYPE_CHARGE)
	local var_1_2 = getProxy(PlayerProxy)
	local var_1_3 = var_1_2:getData()

	if var_1_0.gem > 0 then
		var_1_3:addResources({
			gem = var_1_0.gem
		})
	end

	if var_1_0.gem_free > 0 then
		var_1_3:addResources({
			freeGem = var_1_0.gem_free
		})
	end

	if var_1_1:isMonthCard() then
		local var_1_4 = var_1_3:getCardById(VipCard.MONTH)

		if var_1_4 and var_1_4.leftDate ~= 0 then
			var_1_4.leftDate = var_1_4.leftDate + 0
		else
			var_1_4 = VipCard.New({
				data = 0,
				type = VipCard.MONTH,
				left_date = GetZeroTime() + 0
			})
		end

		var_1_3:addVipCard(var_1_4)
	end

	var_1_2:updatePlayer(var_1_3)

	if var_1_1:isMonthCard() then
		MonthCardOutDateTipPanel.SetMonthCardEndDateLocal()
		MonthCardOutDateTipPanel.SetMonthCardTipDate(0)
	end

	local var_1_5 = getProxy(ShopsProxy)
	local var_1_6 = var_1_5:getChargedList() or {}
	local var_1_7 = false

	for iter_1_0, iter_1_1 in pairs(var_1_6) do
		if iter_1_1.id == var_1_0.shopId then
			var_1_6[iter_1_0]:increaseBuyCount()

			var_1_7 = true

			break
		end
	end

	if not var_1_7 then
		var_1_6[var_1_0.shopId] = Goods.Create({
			pay_count = 1,
			shop_id = var_1_0.shopId
		}, Goods.TYPE_CHARGE)
	end

	var_1_5:setChargedList(var_1_6)

	local var_1_8 = var_1_5:getFirstChargeList() or {}

	if _.is_empty(var_1_8) then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_PURCHASE_FIRST, var_1_0.payId)
	end

	pg.TrackerMgr.GetInstance():Tracking(TRACKING_PAY_SUCCESS, var_1_0.payId)

	if var_1_1:firstPayDouble() then
		local var_1_9 = var_1_5:getFirstChargeList() or {}

		if not table.contains(var_1_9, var_1_0.shopId) then
			table.insert(var_1_9, var_1_0.shopId)
		end

		var_1_5:setFirstChargeList(var_1_9)
	end

	local var_1_10 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHARGEAWARD)

	if var_1_10 and var_1_10.data1 == 0 then
		var_1_10.data1 = 1
	end

	pg.TipsMgr.GetInstance():ShowTips(i18n("charge_success"))

	return
end

return var_0_0
