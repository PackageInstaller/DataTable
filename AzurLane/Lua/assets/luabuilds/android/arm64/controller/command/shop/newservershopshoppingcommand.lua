class = var_0_10000

local var_0_0 = "NewServerShopShoppingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.selectedList
	local var_1_2

	if not var_2.count then
		var_1_2 = 1
	end

	local var_1_3

	if not var_2.actType then
		ActivityConst = var_1_3
		var_1_3 = var_1_3.ACTIVITY_TYPE_NEWSERVER_SHOP
	end

	getProxy = var_1_10007
	ActivityProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)

	if var_7.getActivityByType(var_1_4, var_1_3) then
		local var_1_5 = var_7

		if var_7.isEnd(var_1_5) then
			return
		end

		getProxy = var_1_10008
		ShopsProxy = var_1_5

		local var_1_6 = var_1_10008(var_1_5)

		if not var_8.GetNewServerShop(var_1_6, var_1_3) then
			return
		end

		local var_1_7

		if #var_1_1 == 1 or not #var_1_1 then
			var_1_7 = var_1_2
		end

		getProxy = var_1_6
		PlayerProxy = var_1_10012

		local var_1_8 = var_1_6(var_1_10012)
		local var_1_9 = var_10.getData(var_1_8)
		local var_1_10 = var_8
		local var_1_11 = var_8.GetCommodityById(var_1_10, var_1_0)
		local var_1_12 = var_12.GetConsume(var_1_11)

		assert = var_1_10

		var_1_10(var_1_12.type == 1, "暂不支持资源以为的类型")

		if var_1_9:getResource(var_1_12.id) < var_1_12.count * var_1_7 then
			pg = var_16

			local var_1_13 = var_16.TipsMgr.GetInstance()
			local var_1_14 = var_16.ShowTips

			i18n = var_1_10019

			var_1_14(var_1_13, var_1_10019("common_no_resource"))

			return
		end

		if not var_12:CanPurchaseMulTimes(var_1_7) then
			pg = var_16

			local var_1_15 = var_16.TipsMgr.GetInstance()
			local var_1_16 = var_16.ShowTips

			i18n = var_19

			var_1_16(var_1_15, var_19("guild_shop_cnt_no_enough"))

			return
		end

		local var_1_17 = {}

		ipairs = var_17

		for iter_1_0, iter_1_1 in var_17(var_1_1) do
			if not var_1_17[iter_1_1] then
				var_1_17[iter_1_1] = {
					itemid = iter_1_1,
					count = var_1_2
				}
			else
				var_1_17[iter_1_1].count = var_1_17[iter_1_1].count + 1
			end
		end

		local var_1_18 = {}

		pairs = var_18

		for iter_1_2, iter_1_3 in var_18(var_1_17) do
			table = var_1_10023

			var_1_10023.insert(var_1_18, {
				itemid = iter_1_3.itemid,
				count = iter_1_3.count
			})
		end

		local var_1_19 = var_12:getConfig("type")
		local var_1_20 = var_12
		local var_1_21 = var_12.getConfig(var_1_20, "goods")[1]
		local var_1_22 = var_12
		local var_1_23 = var_12.getConfig(var_1_22, "num")

		if var_1_19 == 1 then
			if var_1_21 == 1 and var_1_9:GoldMax(var_1_23 * var_1_7) then
				pg = var_1_20

				local var_1_24 = var_1_20.TipsMgr.GetInstance()

				var_1_20 = var_1_20.ShowTips
				i18n = var_1_10024
				var_1_10024 = var_1_10024("gold_max_tip_title")
				i18n = var_1_10025

				var_1_20(var_1_24, var_1_10024 .. var_1_10025("resource_max_tip_shop"))

				return
			end

			if var_1_21 == 2 and var_1_9:OilMax(var_1_23 * var_1_7) then
				pg = var_1_20

				local var_1_25 = var_1_20.TipsMgr.GetInstance()

				var_1_20 = var_1_20.ShowTips
				i18n = var_1_10024
				var_1_10024 = var_1_10024("oil_max_tip_title")
				i18n = var_1_10025

				var_1_20(var_1_25, var_1_10024 .. var_1_10025("resource_max_tip_shop"))

				return
			end
		end

		Item = var_1_20

		local var_1_26 = var_1_20.getConfigData(var_1_21)

		DROP_TYPE_ITEM = var_1_22

		if var_1_22 == var_1_19 then
			var_1_22 = var_1_26.type
			Item = var_23

			if var_1_22 == var_23.EXP_BOOK_TYPE then
				getProxy = var_1_22
				BagProxy = var_1_10024

				local var_1_27 = var_1_22(var_1_10024)

				if var_1_22.getItemCountById(var_1_27, var_1_21) + var_1_23 * var_1_7 > var_1_26.max_num then
					pg = var_1_27

					local var_1_28 = var_1_27.TipsMgr.GetInstance()
					local var_1_29 = var_24.ShowTips

					i18n = var_1_10027

					local var_1_30 = var_1_10027("expbook_max_tip_title")

					i18n = var_1_10028

					var_1_29(var_1_28, var_1_30 .. var_1_10028("resource_max_tip_shop"))

					return
				end
			end
		end

		pg = var_1_22

		local var_1_31 = var_1_22.ConnectionMgr.GetInstance()

		var_22.Send(var_1_31, 26043, {
			act_id = var_7.id,
			goodsid = var_1_0,
			selected = var_1_18
		}, 26044, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				PlayerConst = var_2_0
				var_2_0 = var_2_0.addTranDrop(arg_2_0.drop_list)
				var_2_10004 = var_0

				var_2.ReduceCnt(var_2_10004, var_1_7)

				var_2_10004 = var_0

				if var_2.LimitPurchaseSubGoods(var_2_10004) then
					ipairs = var_2

					for iter_2_0, iter_2_1 in var_2(var_1_1) do
						local var_2_1 = var_0

						var_7.UpdateBoughtRecord(var_2_1, iter_2_1)
					end
				end

				getProxy = var_2
				PlayerProxy = var_2_10004
				var_2_10004 = var_2(var_2_10004)

				local var_2_2 = var_2.getData(var_2_10004)
				local var_2_3 = var_0
				local var_2_4 = var_3.getConfig(var_2_3, "resource_type")
				local var_2_5 = var_2_2

				var_2_10004 = var_2_2.consume

				local var_2_6 = {}

				id2res = var_2_10008
				var_2_6[var_2_10008(var_2_4)] = var_0 * var_1_7

				var_2_10004(var_2_5, var_2_6)

				local var_2_7 = var_0

				var_2_10004.updatePlayer(var_2_7, var_2_2)

				local var_2_8 = arg_1_0

				var_2_10004 = var_2_10004.sendNotification
				GAME = var_7

				var_2_10004(var_2_8, var_7.NEW_SERVER_SHOP_SHOPPING_DONE, {
					awards = var_2_0
				})
			else
				pg = var_2_0

				local var_2_9 = var_2_0.TipsMgr.GetInstance()
				local var_2_10 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_10(var_2_9, var_2_10004[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_1
