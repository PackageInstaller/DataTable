class = var_0_10000

local var_0_0 = "IslandShoppingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).shop

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getActivityById(var_1_2, var_1_1.activityId)
	local var_1_4 = var_1_1
	local var_1_5 = var_1_1.bindConfigTable(var_1_4)[var_2.arg1]
	local var_1_6

	if not var_2.arg2 then
		var_1_6 = 1
	end

	getProxy = var_1_4
	PlayerProxy = var_1_10009

	local var_1_7 = var_1_4(var_1_10009)
	local var_1_8 = var_7.getData(var_1_7)
	local var_1_9 = var_1_1:GetCommodityById(var_2.arg1)

	var_10.count = var_9.GetConsume(var_1_9).count * var_1_6

	if var_10:getOwnedCount() < var_10.count then
		pg = var_11

		local var_1_10 = var_11.TipsMgr.GetInstance()
		local var_1_11 = var_11.ShowTips

		i18n = var_1_10014

		var_1_11(var_1_10, var_1_10014("common_no_resource"))

		return
	end

	local var_1_12 = var_1_5.commodity_type

	DROP_TYPE_RESOURCE = var_12

	if var_1_12 == var_12 then
		if var_1_5.commodity_id == 1 and var_1_8:GoldMax(var_1_5.num * var_1_6) then
			pg = var_1_12

			local var_1_13 = var_1_12.TipsMgr.GetInstance()

			var_1_12 = var_1_12.ShowTips
			i18n = var_1_10014
			var_1_10014 = var_1_10014("gold_max_tip_title")
			i18n = var_1_10015

			var_1_12(var_1_13, var_1_10014 .. var_1_10015("resource_max_tip_shop"))

			return
		end

		if var_1_5.commodity_id == 2 and var_1_8:OilMax(var_1_5.num * var_1_6) then
			pg = var_1_12

			local var_1_14 = var_1_12.TipsMgr.GetInstance()

			var_1_12 = var_1_12.ShowTips
			i18n = var_1_10014
			var_1_10014 = var_1_10014("oil_max_tip_title")
			i18n = var_1_10015

			var_1_12(var_1_14, var_1_10014 .. var_1_10015("resource_max_tip_shop"))

			return
		end
	else
		var_1_12 = var_1_5.commodity_type
		DROP_TYPE_ITEM = var_12

		if var_1_12 == var_12 then
			Item = var_1_12
			var_1_12 = var_1_12.getConfigData(var_1_5.commodity_id).max_num

			if 0 < var_1_12 then
				getProxy = var_12
				BagProxy = var_1_10014

				local var_1_15 = var_12(var_1_10014)

				if var_1_12 < var_12.getItemCountById(var_1_15, var_1_5.commodity_id) + var_1_5.num * var_1_6 then
					pg = var_12

					local var_1_16 = var_12.TipsMgr.GetInstance()
					local var_1_17 = var_12.ShowTips

					i18n = var_15

					var_1_17(var_1_16, var_15("island_shop_limit_error"))

					return
				end
			end
		end
	end

	pg = var_1_12

	local var_1_18 = var_1_12.ConnectionMgr.GetInstance()

	var_11.Send(var_1_18, 11202, {
		cmd = 1,
		activity_id = var_1_3.id,
		arg1 = var_2.arg1,
		arg2 = var_2.arg2
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			table = var_1

			if var_1.contains(var_1_3.data1_list, var_0.arg1) then
				ipairs = var_1

				for iter_2_0, iter_2_1 in var_1(var_1_3.data1_list) do
					if iter_2_1 == var_0.arg1 then
						var_2_10006 = var_1_3.data2_list
						var_2_10006[iter_2_0] = var_1_3.data2_list[iter_2_0] + var_0.arg2

						break
					end
				end
			else
				table = var_1

				var_1.insert(var_1_3.data1_list, var_0.arg1)

				table = var_1

				var_1.insert(var_1_3.data2_list, var_0.arg2)
			end

			reducePlayerOwn = var_1

			var_1(var_0)

			local var_2_0 = var_1_1

			iter_2_0 = var_1.getGoodsById(var_2_0, var_0.arg1)

			var_1.addBuyCount(iter_2_0, var_0.arg2)

			getProxy = var_2
			ActivityProxy = iter_2_0
			iter_2_0 = var_2(iter_2_0)

			var_2.updateActivity(iter_2_0, var_1_3)

			PlayerConst = var_2

			local var_2_1 = var_2.GetTranAwards(var_0, arg_2_0)
			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			GAME = var_2_10006

			var_2_3(var_2_2, var_2_10006.ISLAND_SHOPPING_DONE, {
				awards = var_2_1,
				goodsId = var_0.arg1
			})
		else
			local var_2_4 = arg_1_0
			local var_2_5 = var_1.sendNotification

			ActivityProxy = iter_2_0

			var_2_5(var_2_4, iter_2_0.ACTIVITY_OPERATION_ERRO, {
				actId = var_1_3.id,
				code = arg_2_0.result
			})
		end

		return
	end)

	return
end

return var_0_1
