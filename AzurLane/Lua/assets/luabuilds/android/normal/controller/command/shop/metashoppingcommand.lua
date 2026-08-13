class = var_0_10000

local var_0_0 = "MetaShoppingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ShopsProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.GetMetaShop(var_1_2)

	assert = var_1_2

	var_1_2(var_1_3, "should exist shop")

	local var_1_4 = var_1_3
	local var_1_5 = var_1_3.GetCommodityById(var_1_4, var_1_1.arg1)

	assert = var_1_4

	var_1_4(var_1_5, "commodity cant not be nil")

	getProxy = var_1_4
	ActivityProxy = var_7

	local var_1_6 = var_1_4(var_7)

	if not var_6.getActivityById(var_1_6, var_1_1.activity_id) or var_6:isEnd() then
		pg = var_1_6

		local var_1_7 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10009

		var_1_6(var_1_7, var_1_10009("common_activity_end"))

		return
	end

	PlayerConst = var_1_6

	local var_1_8, var_1_9

	if not var_1_6.CheckResForShopping(var_1_5:GetConsume(), var_1_1.arg2) then
		pg = var_1_9
		var_1_8 = var_1_9.TipsMgr.GetInstance()
		var_1_9 = var_1_9.ShowTips
		i18n = var_9

		var_1_9(var_1_8, var_9("common_no_resource"))

		return
	end

	getProxy = var_1_9
	PlayerProxy = var_1_8

	local var_1_10 = var_1_9(var_1_8)
	local var_1_11 = var_7.getRawData(var_1_10)
	local var_1_12 = var_1_1.arg2
	local var_1_13 = var_1_5:getConfig("commodity_type")
	local var_1_14 = var_1_5:getConfig("commodity_id")
	local var_1_15 = var_1_5
	local var_1_16 = var_1_5.getConfig(var_1_15, "num")

	if var_1_13 == 1 then
		if var_1_14 == 1 and var_1_11:GoldMax(var_1_16 * var_1_12) then
			pg = var_1_15

			local var_1_17 = var_1_15.TipsMgr.GetInstance()

			var_1_15 = var_1_15.ShowTips
			i18n = var_14

			local var_1_18 = var_14("gold_max_tip_title")

			i18n = var_15

			var_1_15(var_1_17, var_1_18 .. var_15("resource_max_tip_shop"))

			return
		end

		if var_1_14 == 2 and var_1_11:OilMax(var_1_16 * var_1_12) then
			pg = var_1_15

			local var_1_19 = var_1_15.TipsMgr.GetInstance()

			var_1_15 = var_1_15.ShowTips
			i18n = var_14

			local var_1_20 = var_14("oil_max_tip_title")

			i18n = var_15

			var_1_15(var_1_19, var_1_20 .. var_15("resource_max_tip_shop"))

			return
		end
	end

	pg = var_1_15

	local var_1_21 = var_1_15.ConnectionMgr.GetInstance()
	local var_1_22 = var_12.Send
	local var_1_23 = 11202
	local var_1_24 = {
		activity_id = var_1_1.activity_id,
		cmd = var_1_1.cmd,
		arg1 = var_1_1.arg1,
		arg2 = var_1_1.arg2,
		arg_list = {}
	}
	local var_1_25

	if not var_1_1.kvargs1 then
		var_1_25 = {}
	end

	var_1_24.kvargs1 = var_1_25

	var_1_22(var_1_21, var_1_23, var_1_24, 11203, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.GetMetaShop(var_2_0)
			table = var_2_0

			if var_2_0.contains(var_0.data1_list, var_1_1.arg1) then
				ipairs = var_2

				for iter_2_0, iter_2_1 in var_2(var_0.data1_list) do
					if iter_2_1 == var_1_1.arg1 then
						var_0.data2_list[iter_2_0] = var_0.data2_list[iter_2_0] + var_1_1.arg2

						break
					end
				end
			else
				table = var_2

				var_2.insert(var_0.data1_list, var_1_1.arg1)

				table = var_2

				var_2.insert(var_0.data2_list, var_1_1.arg2)
			end

			getProxy = var_2
			ActivityProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)

			var_2.updateActivity(var_2_10003, var_0)

			PlayerConst = var_2

			local var_2_2 = var_2.ConsumeResForShopping
			local var_2_3 = var_1_5

			var_2_2(var_2_10003.GetConsume(var_2_3), var_1_1.arg2)

			PlayerConst = var_2_2

			local var_2_4 = var_2_2.GetTranAwards(var_1_1, arg_2_0)
			local var_2_5 = var_0

			var_2_10003.UpdateMetaShopGoods(var_2_5, var_1_1.arg1, var_1_1.arg2)

			local var_2_6 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			var_2_10003(var_2_6, var_5.ON_META_SHOPPING_DONE, {
				awards = var_2_4
			})

			pg = var_2_10003

			local var_2_7 = var_2_10003.TipsMgr.GetInstance()

			var_2_10003 = var_2_10003.ShowTips
			i18n = var_5

			var_2_10003(var_2_7, var_5("common_buy_success"))
		else
			pg = var_2_1

			local var_2_8 = var_2_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
