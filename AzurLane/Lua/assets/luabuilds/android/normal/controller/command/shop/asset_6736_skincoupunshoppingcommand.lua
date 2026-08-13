class = var_0_10000

local var_0_0 = "SkinCoupunShoppingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shopId
	local var_1_1 = var_2.cnt

	getProxy = var_1_10005
	ShipSkinProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetAllSkins(var_1_2)

	_ = var_1_2

	if not var_1_2.detect(var_1_3, function(arg_2_0)
		return arg_2_0.id == var_1_0
	end) then
		pg = var_7

		local var_1_4 = var_7.TipsMgr.GetInstance()
		local var_1_5 = var_7.ShowTips

		i18n = var_1_10009

		var_1_5(var_1_4, var_1_10009("common_shopId_noFound"))

		return
	end

	if not var_6:canPurchase() then
		return
	end

	local var_1_6 = var_6
	local var_1_7 = var_6.getSkinId(var_1_6)

	getProxy = var_1_6
	ShipSkinProxy = var_1_10009

	local var_1_8 = var_1_6(var_1_10009)

	ShipSkin = var_1_10009

	local var_1_9 = var_1_10009.New({
		id = var_1_7
	})

	local function var_1_10(arg_3_0)
		local var_3_0 = var_0
		local var_3_1 = var_1.getConfig(var_3_0, "resource_num") - arg_3_0.discount

		getProxy = var_2
		PlayerProxy = var_3

		local var_3_2 = var_2(var_3)
		local var_3_3 = var_2.getRawData(var_3_2)

		id2res = var_3_2

		local var_3_4 = var_0

		if var_3_3[var_3_2(var_4.getConfig(var_3_4, "resource_type"))] < var_3_1 then
			GoShoppingMsgBox = var_3
			i18n = var_4

			local var_3_5 = "switch_to_shop_tip_3"

			i18n = var_6

			local var_3_6 = var_4(var_3_5, var_6("word_gem"))

			ChargeScene = var_3_5

			var_3(var_3_6, var_3_5.TYPE_DIAMOND)

			return
		end

		pg = var_3

		local var_3_7 = var_3.ConnectionMgr.GetInstance()

		var_3.Send(var_3_7, 11202, {
			cmd = 1,
			activity_id = arg_3_0.actId,
			arg1 = var_1_0,
			arg2 = var_1_1,
			arg_list = {}
		}, 11203, function(arg_4_0)
			if arg_4_0.result == 0 then
				SkinCouponActivity = var_1

				var_1.UseSkinCoupon(arg_3_0.actId)

				local var_4_0 = var_1_8

				var_1.addSkin(var_4_0, var_1_9)

				getProxy = var_1
				PlayerProxy = var_4_0

				local var_4_1 = var_1(var_4_0)

				var_3_10003 = var_1.getData(var_4_1)

				local var_4_2 = var_1.consume
				local var_4_3 = {}

				id2res = var_3_10005

				local var_4_4 = var_0

				var_4_3[var_3_10005(var_6.getConfig(var_4_4, "resource_type"))] = var_3_1

				var_4_2(var_3_10003, var_4_3)

				getProxy = var_4_2
				PlayerProxy = var_3_10003
				var_3_10003 = var_4_2(var_3_10003)

				var_2.updatePlayer(var_3_10003, var_1)

				pg = var_2
				var_3_10003 = var_2.TipsMgr.GetInstance()

				local var_4_5 = var_2.ShowTips

				i18n = var_4

				var_4_5(var_3_10003, var_4("common_buy_success"))

				var_3_10003 = arg_1_0

				local var_4_6 = var_2.sendNotification

				GAME = var_4

				var_4_6(var_3_10003, var_4.SKIN_COUPON_SHOPPING_DONE, {
					id = var_1_0,
					awards = {}
				})
			else
				pg = var_1

				local var_4_7 = var_1.TipsMgr.GetInstance()
				local var_4_8 = var_1.ShowTips

				ERROR_MESSAGE = var_3_10003

				var_4_8(var_4_7, var_3_10003[arg_4_0.result] .. arg_4_0.result)
			end

			return
		end)

		return
	end

	local var_1_11 = {}

	SkinCouponActivity = var_1_10012

	if #var_1_10012.GetSkinCouponActivities(var_1_0) == 0 then
		return
	end

	table = var_13

	local var_1_12 = var_13.sort
	local var_1_13 = var_12

	CompareFuncs = var_1_10015

	var_1_12(var_1_13, var_1_10015({
		function(arg_5_0)
			return -arg_5_0:GetDiscountPrice()
		end,
		function(arg_6_0)
			return arg_6_0.id
		end
	}))

	ipairs = var_1_12

	for iter_1_0, iter_1_1 in var_1_12(var_12) do
		if iter_1_1:GetCanUsageCnt() > 0 then
			table = var_18

			local var_1_14 = var_18.insert
			local var_1_15 = var_1_11
			local var_1_16 = {
				actId = iter_1_1.id
			}

			Drop = var_21

			local var_1_17 = var_21.New
			local var_1_18 = {}

			DROP_TYPE_VITEM = var_1_10023
			var_1_18.type = var_1_10023
			var_1_18.id = iter_1_1:GetItemId()
			var_1_18.count = iter_1_1:GetCanUsageCnt()
			var_1_16.drop = var_1_17(var_1_18)
			var_1_16.discount = iter_1_1:GetDiscountPrice()

			var_1_14(var_1_15, var_1_16)
		end
	end

	SkinCouponMultiMsgBox = var_13

	local var_1_19 = var_13.New

	pg = var_14

	local var_1_20 = var_1_19(var_14.UIMgr.GetInstance().OverlayMain)

	var_13.ExecuteAction(var_1_20, "Show", {
		itemList = var_1_11,
		skinId = var_1_7,
		skinName = var_1_9.skinName,
		price = var_6:getConfig("resource_num"),
		onYes = var_1_10
	})

	return
end

return var_0_1
