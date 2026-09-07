local IslandShopOpCommand = class("IslandShopOpCommand", pm.SimpleCommand)

function IslandShopOpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetShopAgency()
	local var_1_2 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	if var_1_0.operation == IslandConst.SHOP_GET_DATA then
		pg.ConnectionMgr.GetInstance():Send(21016, {
			shop_id = var_1_0.shopId
		}, 21017, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_1_1:UpdateShop(var_1_0.shopId, arg_2_0.shop_info)
				self:sendNotification(GAME.ISLAND_SHOP_OP_DONE, {
					operation = var_1_0.operation,
					refreshAll = var_1_0.refreshAll
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				var_1_1:UpdateShop(var_1_0.shopId, nil)
			end

			return
		end)
	elseif var_1_0.operation == IslandConst.SHOP_BUY_COMMODITY then
		local var_1_3 = getProxy(PlayerProxy):getData()
		local var_1_4 = {}
		local var_1_5 = {}
		local var_1_6 = 0
		local var_1_7 = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_0.commodityList) do
			local var_1_8 = var_1_1:GetShopCommodity(iter_1_1.key, iter_1_1.value1)

			table.insert(var_1_4, var_1_8)
			table.insertto(var_1_7, var_1_8:GetItems())

			if not var_1_8 then
				return
			end

			if iter_1_1.value2 == 0 then
				return
			end

			local var_1_9 = Clone(var_1_8:GetResourceConsume())

			var_1_9[3] = math.ceil((100 - var_1_8:GetDiscount()) / 100 * (var_1_9[3] * iter_1_1.value2))

			local var_1_10 = false

			for iter_1_2, iter_1_3 in ipairs(var_1_5) do
				if iter_1_3[1] == var_1_9[1] and iter_1_3[2] == var_1_9[2] then
					var_1_10 = true
					iter_1_3[3] = iter_1_3[3] + var_1_9[3]

					break
				end
			end

			if not var_1_10 then
				table.insert(var_1_5, var_1_9)
			end

			var_1_6 = var_1_6 + pg.island_shop_goods[iter_1_1.value1].pt_award * iter_1_1.value2

			local var_1_11 = {}

			for iter_1_4, iter_1_5 in ipairs((var_1_8:GetItems())) do
				if iter_1_5[1] ~= DROP_TYPE_ISLAND_ITEM then
					table.insert(var_1_11, (Drop.New({
						type = iter_1_5[1],
						id = iter_1_5[2],
						count = iter_1_5[3]
					})))
				end
			end

			local var_1_12 = GetItemsOverflowDic(var_1_11)
			local var_1_13, var_1_14 = CheckOverflow(var_1_12)

			if not var_1_13 then
				switch(var_1_14, {
					gold = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_shop"))

						return
					end,
					oil = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_shop"))

						return
					end,
					equip = function()
						NoPosMsgBox(i18n("switch_to_shop_tip_noPos"), openDestroyEquip, gotoChargeScene)

						return
					end,
					ship = function()
						NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene, openDockyardIntensify)

						return
					end
				})

				return
			end

			if not CheckShipExpOverflow(var_1_12) then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("player_expResource_mail_fullBag"),
					onYes = next
				})

				return
			end
		end

		local var_1_15 = false

		for iter_1_6, iter_1_7 in ipairs(var_1_7) do
			if iter_1_7[1] == DROP_TYPE_ISLAND_ITEM then
				var_1_15 = true
			end
		end

		if var_1_15 and var_1_2:ExistAnyOverFlowItem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_3Dshop_bag_max"))

			return
		end

		for iter_1_8, iter_1_9 in ipairs(var_1_5) do
			if iter_1_9[1] == DROP_TYPE_RESOURCE then
				if iter_1_9[3] > var_1_3[id2res(iter_1_9[2])] then
					local var_1_16 = Drop.New({
						type = DROP_TYPE_RESOURCE,
						id = iter_1_9[2]
					}):getName()

					if iter_1_9[2] == 1 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("island_3Dshop_lack_gold"))
					elseif iter_1_9[2] == 4 or iter_1_9[2] == 14 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("island_3Dshop_lack_gem"))
					elseif not ItemTipPanel.ShowItemTip(DROP_TYPE_RESOURCE, iter_1_9[2]) then
						pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", var_1_16))
					end

					return
				end
			elseif iter_1_9[1] == DROP_TYPE_ISLAND_ITEM and iter_1_9[3] > var_1_2:GetOwnCount(iter_1_9[2]) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_3Dshop_lack_res"))

				return
			end
		end

		if var_1_4[1]:GetPayId() == 0 then
			pg.ConnectionMgr.GetInstance():Send(21018, {
				goods_list = var_1_0.commodityList
			}, 21019, function(arg_7_0)
				if arg_7_0.result == 0 then
					for iter_7_0, iter_7_1 in ipairs(var_1_5) do
						self:sendNotification(GAME.CONSUME_ITEM, Drop.New({
							type = iter_7_1[1],
							id = iter_7_1[2],
							count = iter_7_1[3]
						}))
					end

					local var_7_0 = {}

					for iter_7_2, iter_7_3 in ipairs(arg_7_0.drop_list) do
						table.insert(var_7_0, iter_7_3)
					end

					table.insert(var_7_0, {
						id = 0,
						type = VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT,
						count = var_1_6
					})

					for iter_7_4, iter_7_5 in ipairs(var_1_0.commodityList) do
						var_1_1:UpdateShopCommodity(iter_7_5.key, iter_7_5.value1, iter_7_5.value2)
						pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShopBuy(iter_7_5.key, iter_7_5.value1))
					end

					self:sendNotification(GAME.ISLAND_SHOP_OP_DONE, {
						operation = var_1_0.operation,
						awards = IslandDropHelper.AddItems({
							drop_list = var_7_0
						})
					})

					if var_1_0.callback then
						var_1_0.callback()
					end
				else
					pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_7_0.result] .. arg_7_0.result)
				end

				return
			end)
		end
	elseif var_1_0.operation == IslandConst.SHOP_REFRESH_BY_PLAYER then
		local var_1_18 = var_1_0.refreshResource
		local var_1_19 = getProxy(PlayerProxy):getData()
		local var_1_20 = var_1_0.refreshResource[3]

		if var_1_0.refreshResource[3] ~= 0 then
			if var_1_0.refreshResource[1] == DROP_TYPE_RESOURCE then
				if var_1_0.refreshResource[3] > var_1_19[id2res(var_1_0.refreshResource[2])] then
					if var_1_0.refreshResource[2] == 1 then
						GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
							{
								59001,
								var_1_0.refreshResource[3] - var_1_19[id2res(var_1_0.refreshResource[2])],
								var_1_0.refreshResource[3]
							}
						})
					elseif var_1_0.refreshResource[2] == 4 or var_1_0.refreshResource[2] == 14 then
						GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
					elseif not ItemTipPanel.ShowItemTip(DROP_TYPE_RESOURCE, var_1_0.refreshResource[2]) then
						pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", (Drop.New({
							type = DROP_TYPE_RESOURCE,
							id = var_1_0.refreshResource[2]
						}):getName())))
					end

					return
				end
			elseif var_1_0.refreshResource[1] == DROP_TYPE_ISLAND_ITEM and var_1_0.refreshResource[3] > var_1_2:GetOwnCount(var_1_0.refreshResource[2]) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", pg.island_item_data_template[var_1_0.refreshResource[2]].name))

				return
			end
		end

		pg.ConnectionMgr.GetInstance():Send(21020, {
			shop_id = var_1_0.shopId
		}, 21021, function(arg_8_0)
			if arg_8_0.result == 0 then
				if var_1_20 ~= 0 then
					self:sendNotification(GAME.CONSUME_ITEM, Drop.New({
						type = var_1_18[1],
						id = var_1_18[2],
						count = var_1_20
					}))
				end

				var_1_1:UpdateShop(var_1_0.shopId, arg_8_0.shop_info)
				self:sendNotification(GAME.ISLAND_SHOP_OP_DONE, {
					operation = var_1_0.operation
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_8_0.result] .. arg_8_0.result)
			end

			return
		end)
	end

	return
end

return IslandShopOpCommand
