local IslandShoppingCommand = class("IslandShoppingCommand", pm.SimpleCommand)

function IslandShoppingCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shop
	local var_1_2 = getProxy(ActivityProxy):getActivityById(var_1_0.shop.activityId)
	local var_1_3 = var_1_0.shop:bindConfigTable()[var_1_0.arg1]
	local var_1_4 = var_1_0.arg2 or 1
	local var_1_5 = getProxy(PlayerProxy):getData()
	local var_1_6 = var_1_0.shop:GetCommodityById(var_1_0.arg1):GetConsume()

	var_1_6.count = var_1_6.count * var_1_4

	if var_1_6:getOwnedCount() < var_1_6.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	if var_1_3.commodity_type == DROP_TYPE_RESOURCE then
		if var_1_3.commodity_id == 1 and var_1_5:GoldMax(var_1_3.num * var_1_4) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_shop"))

			return
		end

		if var_1_3.commodity_id == 2 and var_1_5:OilMax(var_1_3.num * var_1_4) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_shop"))

			return
		end
	elseif var_1_3.commodity_type == DROP_TYPE_ITEM then
		local var_1_7 = Item.getConfigData(var_1_3.commodity_id).max_num

		if var_1_7 > 0 then
			if var_1_7 < getProxy(BagProxy):getItemCountById(var_1_3.commodity_id) + var_1_3.num * var_1_4 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_shop_limit_error"))

				return
			end
		end
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_2.id,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if table.contains(var_1_2.data1_list, var_1_0.arg1) then
				for iter_2_0, iter_2_1 in ipairs(var_1_2.data1_list) do
					if iter_2_1 == var_1_0.arg1 then
						var_1_2.data2_list[iter_2_0] = var_1_2.data2_list[iter_2_0] + var_1_0.arg2

						break
					end
				end
			else
				table.insert(var_1_2.data1_list, var_1_0.arg1)
				table.insert(var_1_2.data2_list, var_1_0.arg2)
			end

			reducePlayerOwn(var_1_6)
			var_1_1:getGoodsById(var_1_0.arg1):addBuyCount(var_1_0.arg2)
			getProxy(ActivityProxy):updateActivity(var_1_2)
			self:sendNotification(GAME.ISLAND_SHOPPING_DONE, {
				awards = PlayerConst.GetTranAwards(var_1_0, arg_2_0),
				goodsId = var_1_0.arg1
			})
		else
			self:sendNotification(ActivityProxy.ACTIVITY_OPERATION_ERRO, {
				actId = var_1_2.id,
				code = arg_2_0.result
			})
		end

		return
	end)

	return
end

return IslandShoppingCommand
