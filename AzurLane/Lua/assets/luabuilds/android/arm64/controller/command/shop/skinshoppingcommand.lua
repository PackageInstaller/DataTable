local var_0_0 = class("SkinShoppingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.count
	local var_1_2 = pg.shop_template[var_1_0.id]

	if not var_1_0.id then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_shopId_noFound"))

		return
	end

	if var_1_0.count == 0 then
		return
	end

	local var_1_3 = getProxy(ShopsProxy)
	local var_1_4 = var_1_3:getShopStreet()
	local var_1_6 = pg.shop_template[var_1_0.id].resource_num * var_1_0.count
	local var_1_7 = getProxy(PlayerProxy)
	local var_1_8 = getProxy(PlayerProxy):getData()

	if pg.shop_template[var_1_0.id].limit_args then
		for iter_1_0, iter_1_1 in ipairs(pg.shop_template[var_1_0.id].limit_args) do
			if type(iter_1_1) == "table" and iter_1_1[1] == "level" and iter_1_1[2] > var_1_8.level then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_limit_level", iter_1_1[2]))

				return
			end
		end
	end

	if pg.shop_template[var_1_0.id].discount ~= 0 and CommonCommodity.InCommodityDiscountTime(pg.shop_template[var_1_0.id].id) then
		var_1_6 = var_1_6 * ((100 - pg.shop_template[var_1_0.id].discount) / 100)
	end

	if var_1_6 > var_1_8[id2res(pg.shop_template[var_1_0.id].resource_type)] then
		if pg.shop_template[var_1_0.id].resource_type == 1 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
				{
					59001,
					var_1_6 - var_1_8[id2res(pg.shop_template[var_1_0.id].resource_type)],
					var_1_6
				}
			})
		elseif pg.shop_template[var_1_0.id].resource_type == 4 or pg.shop_template[var_1_0.id].resource_type == 14 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_BUILD_OR_SKIN_FAILD)
		elseif not ItemTipPanel.ShowItemTip(DROP_TYPE_RESOURCE, pg.shop_template[var_1_0.id].resource_type) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", (Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = pg.shop_template[var_1_0.id].resource_type
			}):getName())))
		end

		return
	end

	seriesAsync({}, function()
		pg.ConnectionMgr.GetInstance():Send(16001, {
			id = var_0,
			number = var_1_1
		}, 16002, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = {}
				local var_3_1 = var_1_7:getData()

				var_3_1:consume({
					[id2res(var_1_2.resource_type)] = var_1_6
				})
				switch(var_1_2.genre, {
					[ShopArgs.SkinShop] = function()
						var_3_0 = PlayerConst.addTranDrop(arg_3_0.drop_list)

						getProxy(ShipSkinProxy):addSkin((ShipSkin.New({
							id = var_1_2.effect_args[1]
						})))

						return
					end,
					[ShopArgs.SkinShopTimeLimit] = function()
						local var_5_0 = getProxy(ShipSkinProxy)
						local var_5_1 = var_5_0:getSkinById(var_1_2.effect_args[1])

						if var_5_1 and var_5_1:isExpireType() then
							var_5_0:addSkin((ShipSkin.New({
								id = var_1_2.effect_args[1],
								end_time = var_1_2.time_second * var_1_1 + var_5_1.endTime
							})))
						elseif not var_5_1 then
							({
								id = var_1_2.effect_args[1]
							}).end_time = var_1_2.time_second * var_1_1 + pg.TimeMgr.GetInstance():GetServerTime()

							var_5_0:addSkin((ShipSkin.New({
								id = var_1_2.effect_args[1]
							})))
						end

						return
					end
				})
				var_1_7:updatePlayer(var_3_1)

				if var_1_2.group > 0 then
					var_1_3:updateNormalGroupList(var_1_2.group, var_1_2.group_buy_count)
				end

				arg_1_0:sendNotification(GAME.SKIN_SHOPPIGN_DONE, {
					id = var_0,
					shopType = nil,
					normalList = var_1_3:GetNormalList(),
					normalGroupList = var_1_3:GetNormalGroupList(),
					awards = {}
				})
			else
				originalPrint(arg_3_0.result)

				if arg_3_0.result == 4400 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("shopping_error_time_limit"))
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_3_0.result))
				end
			end

			return
		end)

		return
	end)

	return
end

return var_0_0
