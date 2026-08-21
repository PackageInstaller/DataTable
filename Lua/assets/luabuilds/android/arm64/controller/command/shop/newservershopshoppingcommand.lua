local var_0_0 = class("NewServerShopShoppingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.selectedList
	local var_1_3 = var_1_0.count or 1
	local var_1_4 = var_1_0.actType or ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP
	local var_1_5 = getProxy(ActivityProxy):getActivityByType(var_1_4)

	if not var_1_5 or var_1_5:isEnd() then
		return
	end

	local var_1_6 = getProxy(ShopsProxy):GetNewServerShop(var_1_4)

	if not var_1_6 then
		return
	end

	if #var_1_2 ~= 1 then
		local var_1_7 = #var_1_2 or var_1_3
		local var_1_8 = getProxy(PlayerProxy)
		local var_1_9 = var_1_8:getData()
		local var_1_10 = var_1_6:GetCommodityById(var_1_1)
		local var_1_11 = var_1_10:GetConsume()

		assert(var_1_11.type == 1, "暂不支持资源以为的类型")

		if var_1_9:getResource(var_1_11.id) < var_1_11.count * var_1_7 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

			return
		end

		if not var_1_10:CanPurchaseMulTimes(var_1_7) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_shop_cnt_no_enough"))

			return
		end

		local var_1_12 = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			if not var_1_12[iter_1_1] then
				var_1_12[iter_1_1] = {
					itemid = iter_1_1,
					count = var_1_3
				}
			else
				var_1_12[iter_1_1].count = var_1_12[iter_1_1].count + 1
			end
		end

		for iter_1_2, iter_1_3 in pairs(var_1_12) do
			table.insert({}, {
				itemid = iter_1_3.itemid,
				count = iter_1_3.count
			})
		end

		local var_1_13 = var_1_10:getConfig("type")
		local var_1_14 = var_1_10:getConfig("goods")[1]
		local var_1_15 = var_1_10:getConfig("num")

		if var_1_13 == 1 then
			if var_1_14 == 1 and var_1_9:GoldMax(var_1_15 * var_1_7) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_shop"))

				return
			end

			if var_1_14 == 2 and var_1_9:OilMax(var_1_15 * var_1_7) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_shop"))

				return
			end
		end

		local var_1_16 = Item.getConfigData(var_1_14)

		if DROP_TYPE_ITEM == var_1_13 and var_1_16.type == Item.EXP_BOOK_TYPE then
			if getProxy(BagProxy):getItemCountById(var_1_14) + var_1_15 * var_1_7 > var_1_16.max_num then
				pg.TipsMgr.GetInstance():ShowTips(i18n("expbook_max_tip_title") .. i18n("resource_max_tip_shop"))

				return
			end
		end

		pg.ConnectionMgr.GetInstance():Send(26043, {
			act_id = var_1_5.id,
			goodsid = var_1_1,
			selected = {}
		}, 26044, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_1_10:ReduceCnt(var_1_7)

				if var_1_10:LimitPurchaseSubGoods() then
					for iter_2_0, iter_2_1 in ipairs(var_1_2) do
						var_1_10:UpdateBoughtRecord(iter_2_1)
					end
				end

				local var_2_0 = getProxy(PlayerProxy):getData()

				var_2_0:consume({
					[id2res((var_1_10:getConfig("resource_type")))] = var_0 * var_1_7
				})
				var_1_8:updatePlayer(var_2_0)
				arg_1_0:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING_DONE, {
					awards = PlayerConst.addTranDrop(arg_2_0.drop_list)
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_0
