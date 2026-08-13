class = var_0_10000

local var_0_0 = "ChargeSuccessCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

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

	Goods = var_1_10010

	local var_1_6 = var_1_4(var_1_5, var_1_10010.TYPE_CHARGE)

	getProxy = var_1_10008
	PlayerProxy = var_10

	local var_1_7 = var_1_10008(var_10)
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

		VipCard = var_1_10013

		local var_1_11 = var_1_10(var_1_9, var_1_10013.MONTH)

		GetZeroTime = var_1_7

		local var_1_12 = var_1_7() + 0

		if var_1_11 and var_1_11.leftDate ~= 0 then
			var_1_11.leftDate = var_1_11.leftDate + 0
		else
			VipCard = var_1_9

			local var_1_13 = var_1_9.New
			local var_1_14 = {
				data = 0
			}

			VipCard = var_1_10015
			var_1_14.type = var_1_10015.MONTH
			var_1_14.left_date = var_1_12
			var_1_11 = var_1_13(var_1_14)
		end

		var_1_8:addVipCard(var_1_11)
	end

	var_8:updatePlayer(var_1_8)

	local var_1_15 = var_1_6

	if var_1_6.isMonthCard(var_1_15) then
		MonthCardOutDateTipPanel = var_10

		var_10.SetMonthCardEndDateLocal()

		MonthCardOutDateTipPanel = var_10

		var_10.SetMonthCardTipDate(0)
	end

	getProxy = var_10
	ShopsProxy = var_1_15

	local var_1_16 = var_10(var_1_15)
	local var_1_17

	if not var_10.getChargedList(var_1_16) then
		var_1_17 = {}
	end

	local var_1_18 = false

	pairs = var_1_16

	for iter_1_0, iter_1_1 in var_1_16(var_1_17) do
		if iter_1_1.id == var_1_0 then
			local var_1_19 = var_1_17[iter_1_0]

			var_18.increaseBuyCount(var_1_19)

			var_1_18 = true

			break
		end
	end

	if not var_1_18 then
		Goods = var_13

		local var_1_20 = var_13.Create
		local var_1_21 = {
			pay_count = 1,
			shop_id = var_1_0
		}

		Goods = iter_1_0
		var_1_17[var_1_0] = var_1_20(var_1_21, iter_1_0.TYPE_CHARGE)
	end

	var_10:setChargedList(var_1_17)

	local var_1_22 = var_10
	local var_1_23

	if not var_10.getFirstChargeList(var_1_22) then
		var_1_23 = {}
	end

	_ = var_14

	local var_1_25

	if var_14.is_empty(var_1_23) then
		pg = var_1_25

		local var_1_24 = var_1_25.TrackerMgr.GetInstance()

		var_1_25 = var_1_25.Tracking
		TRACKING_PURCHASE_FIRST = iter_1_1

		var_1_25(var_1_24, iter_1_1, var_1_1)
	end

	pg = var_1_25

	local var_1_26 = var_1_25.TrackerMgr.GetInstance()
	local var_1_27 = var_14.Tracking

	TRACKING_PAY_SUCCESS = iter_1_1

	var_1_27(var_1_26, iter_1_1, var_1_1)

	local var_1_28 = var_1_6
	local var_1_29

	if var_1_6.firstPayDouble(var_1_28) then
		var_1_28 = var_10

		if not var_10.getFirstChargeList(var_1_28) then
			var_1_29 = {}
		end

		table = var_1_22

		if not var_1_22.contains(var_1_29, var_1_0) then
			table = var_15

			var_15.insert(var_1_29, var_1_0)
		end

		var_10:setFirstChargeList(var_1_29)
	end

	getProxy = var_1_29
	ActivityProxy = var_1_28

	local var_1_30 = var_1_29(var_1_28)
	local var_1_31 = var_14.getActivityByType

	ActivityConst = var_18

	if var_1_31(var_1_30, var_18.ACTIVITY_TYPE_CHARGEAWARD) and var_15.data1 == 0 then
		var_15.data1 = 1
	end

	pg = var_1_28

	local var_1_32 = var_1_28.TipsMgr.GetInstance()
	local var_1_33 = var_16.ShowTips

	i18n = var_1_10019

	var_1_33(var_1_32, var_1_10019("charge_success"))

	return
end

return var_0_1
