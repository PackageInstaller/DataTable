class = var_0_10000

local var_0_0 = "ChargeSuccessCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shopId
	local var_1_1 = var_2.payId
	local var_1_2 = var_2.gem
	local var_1_3 = var_2.gem_free

	Goods = var_1_10007

	local var_1_4 = var_1_10007.Create
	local var_1_5 = {
		shop_id = var_1_0
	}

	Goods = var_1_10009

	local var_1_6 = var_1_4(var_1_5, var_1_10009.TYPE_CHARGE)

	getProxy = var_1_5
	PlayerProxy = var_9

	local var_1_7 = var_1_5(var_9)
	local var_1_8 = var_8.getData(var_1_7)

	if var_1_2 > 0 then
		var_1_8:addResources({
			gem = var_1_2
		})
	end

	if var_1_3 > 0 then
		var_1_8:addResources({
			freeGem = var_1_3
		})
	end

	if var_1_6:isMonthCard() then
		local var_1_9 = var_1_8
		local var_1_10 = var_1_8.getCardById

		VipCard = var_1_10012

		local var_1_11 = var_1_10(var_1_9, var_1_10012.MONTH)

		GetZeroTime = var_1_9

		local var_1_12 = var_1_9() + 0

		if var_1_11 and var_1_11.leftDate ~= 0 then
			var_1_11.leftDate = var_1_11.leftDate + 0
		else
			VipCard = var_12

			local var_1_13 = var_12.New

			var_1_10013 = {
				data = 0
			}
			VipCard = var_1_10014
			var_1_10013.type = var_1_10014.MONTH
			var_1_10013.left_date = var_1_12
			var_1_11 = var_1_13(var_1_10013)
		end

		var_1_10013 = var_1_8

		var_1_8.addVipCard(var_1_10013, var_1_11)
	end

	var_8:updatePlayer(var_1_8)

	local var_1_14 = var_1_6

	if var_1_6.isMonthCard(var_1_14) then
		MonthCardOutDateTipPanel = var_10

		var_10.SetMonthCardEndDateLocal()

		MonthCardOutDateTipPanel = var_10

		var_10.SetMonthCardTipDate(0)
	end

	getProxy = var_10
	ShopsProxy = var_1_14

	local var_1_15 = var_10(var_1_14)
	local var_1_16

	if not var_10.getChargedList(var_1_15) then
		var_1_16 = {}
	end

	local var_1_17 = false

	pairs = var_1_10013

	for iter_1_0, iter_1_1 in var_1_10013(var_1_16) do
		if iter_1_1.id == var_1_0 then
			local var_1_18 = var_1_16[iter_1_0]

			var_1_10018.increaseBuyCount(var_1_18)

			var_1_17 = true

			break
		end
	end

	if not var_1_17 then
		Goods = var_13

		local var_1_19 = var_13.Create
		local var_1_20 = {
			pay_count = 1,
			shop_id = var_1_0
		}

		Goods = var_15
		var_1_16[var_1_0] = var_1_19(var_1_20, var_15.TYPE_CHARGE)
	end

	var_10:setChargedList(var_1_16)

	local var_1_21 = var_10
	local var_1_22

	if not var_10.getFirstChargeList(var_1_21) then
		var_1_22 = {}
	end

	_ = var_1_21

	local var_1_24

	if var_1_21.is_empty(var_1_22) then
		pg = var_1_24

		local var_1_23 = var_1_24.TrackerMgr.GetInstance()

		var_1_24 = var_1_24.Tracking
		TRACKING_PURCHASE_FIRST = iter_1_0

		var_1_24(var_1_23, iter_1_0, var_1_1)
	end

	pg = var_1_24

	local var_1_25 = var_1_24.TrackerMgr.GetInstance()
	local var_1_26 = var_14.Tracking

	TRACKING_PAY_SUCCESS = iter_1_0

	var_1_26(var_1_25, iter_1_0, var_1_1)

	local var_1_27 = var_1_6
	local var_1_28

	if var_1_6.firstPayDouble(var_1_27) then
		var_1_27 = var_10

		if not var_10.getFirstChargeList(var_1_27) then
			var_1_28 = {}
		end

		table = var_1_27

		if not var_1_27.contains(var_1_28, var_1_0) then
			table = var_1_27

			var_1_27.insert(var_1_28, var_1_0)
		end

		var_10:setFirstChargeList(var_1_28)
	end

	getProxy = var_1_28
	ActivityProxy = var_1_27

	local var_1_29 = var_1_28(var_1_27)
	local var_1_30 = var_14.getActivityByType

	ActivityConst = var_17

	if var_1_30(var_1_29, var_17.ACTIVITY_TYPE_CHARGEAWARD) and var_15.data1 == 0 then
		var_15.data1 = 1
	end

	pg = var_1_29

	local var_1_31 = var_1_29.TipsMgr.GetInstance()
	local var_1_32 = var_16.ShowTips

	i18n = var_1_10018

	var_1_32(var_1_31, var_1_10018("charge_success"))

	return
end

return var_0_1
