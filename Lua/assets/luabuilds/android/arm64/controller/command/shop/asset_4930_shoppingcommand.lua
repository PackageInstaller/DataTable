local ShoppingCommand = class("ShoppingCommand", pm.SimpleCommand)

function ShoppingCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.count
	local var_1_3 = pg.shop_template[var_1_0.id]

	if not var_1_0.id then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_shopId_noFound"))

		return
	end

	if var_1_3.type == DROP_TYPE_WORLD_ITEM then
		if not nowWorld():IsActivate() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_shop_bag_unactivated"))

			return
		end
	end

	local var_1_4 = getProxy(PlayerProxy)
	local var_1_5 = var_1_4:getData()

	if var_1_3.type == DROP_TYPE_ITEM then
		for iter_1_0, iter_1_1 in pairs(Item.getConfigData(var_1_3.effect_args[1]).display_icon) do
			if iter_1_1[1] == 1 then
				if iter_1_1[2] == 1 and var_1_5:GoldMax(iter_1_1[3]) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_shop"))

					return
				end

				if iter_1_1[2] == 2 and var_1_5:OilMax(iter_1_1[3]) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_shop"))

					return
				end
			end
		end
	end

	if var_1_3.type == DROP_TYPE_RESOURCE then
		if var_1_3.effect_args[1] == 1 and var_1_5:GoldMax(var_1_3.num * var_1_0.count) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_shop"))

			return
		end

		if var_1_3.effect_args[1] == 2 then
			if var_1_5:OilMax(((var_1_3.num == -1 and var_1_3.genre == ShopArgs.BuyOil or nil) and ShopArgs.getOilByLevel(var_1_5.level)) * var_1_0.count) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_shop"))

				return
			end
		end
	end

	if var_1_0.count == 0 then
		return
	end

	local var_1_7 = getProxy(ShopsProxy)
	local var_1_8 = var_1_7:getShopStreet()
	local var_1_9 = false
	local var_1_10 = var_1_3.resource_num
	local var_1_11 = getProxy(NavalAcademyProxy)

	if var_1_3.resource_num == -1 then
		if var_1_3.effect_args == ShopArgs.EffectShopStreetLevel then
			var_1_10 = pg.navalacademy_shoppingstreet_template[var_1_8.level].lv_up_cost[2] * var_1_0.count
		else
			local var_1_12 = switch(var_1_3.effect_args, {
				[ShopArgs.EffectTradingPortLevel] = function()
					return var_1_11._goldVO
				end,
				[ShopArgs.EffectOilFieldLevel] = function()
					return var_1_11._oilVO
				end,
				[ShopArgs.EffectClassLevel] = function()
					return var_1_11._classVO
				end
			})

			if var_1_12 then
				var_1_10 = var_1_12:bindConfigTable()[var_1_12:GetLevel()].use[2] * var_1_0.count
			end
		end
	else
		var_1_10 = var_1_3.resource_num * var_1_0.count

		if var_1_8 and var_1_3.genre == ShopArgs.ShoppingStreetLimit then
			var_1_9 = true
			var_1_10 = math.ceil(var_1_8:getGoodsById(var_1_0.id).discount / 100 * var_1_10)
		end
	end

	if var_1_3.limit_args then
		for iter_1_2, iter_1_3 in ipairs(var_1_3.limit_args) do
			if type(iter_1_3) == "table" and iter_1_3[1] == "level" and iter_1_3[2] > var_1_5.level then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_limit_level", iter_1_3[2]))

				return
			end
		end
	end

	if var_1_3.discount ~= 0 and CommonCommodity.InCommodityDiscountTime(var_1_3.id) then
		var_1_10 = var_1_10 * ((100 - var_1_3.discount) / 100)
	end

	if var_1_10 > var_1_5[id2res(var_1_3.resource_type)] then
		if var_1_3.resource_type == 1 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
				{
					59001,
					var_1_10 - var_1_5[id2res(var_1_3.resource_type)],
					var_1_10
				}
			})
		elseif var_1_3.resource_type == 4 or var_1_3.resource_type == 14 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)

			if var_1_3.id == NewShopMainMediator.FAST_BUILD_ITEM_ID then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_BUILD_OR_SKIN_FAILD)
			end
		elseif not ItemTipPanel.ShowItemTip(DROP_TYPE_RESOURCE, var_1_3.resource_type) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", (Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_1_3.resource_type
			}):getName())))
		end

		return
	end

	local var_1_13 = {}

	table.insert(var_1_13, function(arg_5_0)
		if var_1_3.genre ~= ShopArgs.GiftPackage then
			if var_1_3.genre == ShopArgs.NewServerShop then
				local var_5_0 = {}

				var_5_0[1] = Drop.New({
					count = 1,
					type = DROP_TYPE_ITEM,
					id = var_1_3.effect_args[1]
				})

				local var_5_1 = GetItemsOverflowDic(var_5_0)
				local var_5_2, var_5_3 = CheckOverflow(var_5_1)

				if not var_5_2 then
					switch(var_5_3, {
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

				if not CheckShipExpOverflow(var_5_1) then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("player_expResource_mail_fullBag"),
						onYes = arg_5_0
					})

					return
				end
			end
		end

		arg_5_0()

		return
	end)
	seriesAsync(var_1_13, function()
		pg.ConnectionMgr.GetInstance():Send(16001, {
			id = var_1_1,
			number = var_1_2
		}, 16002, function(arg_11_0)
			if arg_11_0.result == 0 then
				local var_11_0 = var_1_4:getData()

				var_11_0:consume({
					[id2res(var_1_3.resource_type)] = var_1_10
				})

				local var_11_1

				if var_1_9 then
					local var_11_2 = var_1_7:getShopStreet()

					var_11_1 = var_11_2.type

					var_11_2:getGoodsById(var_1_1):reduceBuyCount()
					var_1_7:UpdateShopStreet(var_11_2)
				else
					switch(var_1_3.genre, {
						[ShopArgs.BuyOil] = function()
							var_11_0:increaseBuyOilCount()

							return
						end,
						[ShopArgs.ArenaShopLimit] = function()
							local var_13_0 = getProxy(ShopsProxy)
							local var_13_1 = var_13_0:getMeritorousShop()
							local var_13_2 = var_13_1:getGoodsById(var_1_1)

							var_13_2:increaseBuyCount()
							var_13_1:updateGoods(var_13_2)

							var_11_1 = var_13_1.type

							var_13_0:updateMeritorousShop(var_13_1)

							return
						end,
						[ShopArgs.GiftPackage] = function()
							var_1_7:GetNormalByID(var_1_1):increaseBuyCount()

							return
						end,
						[ShopArgs.NewServerShop] = function()
							var_1_7:GetNormalByID(var_1_1):increaseBuyCount()

							return
						end,
						[ShopArgs.SkinShop] = function()
							assert(false, "must be used ShoppingCommand")

							return
						end,
						[ShopArgs.SkinShopTimeLimit] = function()
							assert(false, "must be used ShoppingCommand")

							return
						end,
						[ShopArgs.guildShop] = function()
							local var_18_0 = getProxy(ShopsProxy):getGuildShop()

							var_18_0:getGoodsById(var_1_1):reduceBuyCount()
							var_1_7:updateGuildShop(var_18_0)

							return
						end,
						[ShopArgs.WorldShop] = function()
							nowWorld():UpdateWorldShopGoods({
								{
									goods_id = var_1_1,
									count = var_1_2
								}
							})

							return
						end,
						[ShopArgs.WorldCollection] = function()
							nowWorld():UpdateWorldShopGoods({
								{
									goods_id = var_1_1,
									count = var_1_2
								}
							})

							return
						end,
						[ShopArgs.CruiseSkin] = function()
							var_1_7:GetNormalByID(var_1_1):increaseBuyCount()

							return
						end,
						[ShopArgs.CruiseGearSkin] = function()
							var_1_7:GetNormalByID(var_1_1):increaseBuyCount()

							return
						end
					})
				end

				var_1_4:updatePlayer(var_11_0)

				if var_1_3.group > 0 then
					var_1_7:updateNormalGroupList(var_1_3.group, var_1_3.group_buy_count)
				end

				if var_1_3.genre == ShopArgs.CruiseSkin or var_1_3.genre == ShopArgs.CruiseGearSkin then
					var_1_7:UpdateCruiseShop()
				end

				switch(var_1_3.effect_args, {
					[ShopArgs.EffecetShipBagSize] = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("shop_extendship_success"))

						return
					end,
					[ShopArgs.EffecetEquipBagSize] = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("shop_extendequip_success"))

						return
					end,
					[ShopArgs.EffectCommanderBagSize] = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("shop_extendcommander_success"))

						return
					end,
					[ShopArgs.EffectSpWeaponBagSize] = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("shop_spweapon_success"))

						return
					end
				})

				if var_1_3.limit_args then
					for iter_11_0, iter_11_1 in ipairs(var_1_3.limit_args) do
						if type(iter_11_1) == "table" and (var_1_3.type == DROP_TYPE_DORM3D_FURNITURE or var_1_3.type == DROP_TYPE_DORM3D_GIFT) then
							if iter_11_1[1] == "dailycount" then
								if var_1_3.type == DROP_TYPE_DORM3D_FURNITURE then
									getProxy(ApartmentProxy):AddDailyFurnitureShopCount(var_1_3.effect_args[1], (not var_1_3.effect_args[2] or nil) and 1)
								elseif var_1_3.type == DROP_TYPE_DORM3D_GIFT then
									getProxy(ApartmentProxy):AddDailyGiftShopCount(var_1_3.effect_args[1], (not var_1_3.effect_args[2] or nil) and 1)
								end
							elseif iter_11_1[1] == "count" then
								if var_1_3.type == DROP_TYPE_DORM3D_FURNITURE then
									getProxy(ApartmentProxy):AddPermanentFurnitureShopCount(var_1_3.effect_args[1], (not var_1_3.effect_args[2] or nil) and 1)
								elseif var_1_3.type == DROP_TYPE_DORM3D_GIFT then
									getProxy(ApartmentProxy):AddPermanentGiftShopCount(var_1_3.effect_args[1], (not var_1_3.effect_args[2] or nil) and 1)
								end
							end
						end
					end
				end

				if var_1_3.group_limit > 0 and (var_1_3.type == DROP_TYPE_DORM3D_FURNITURE or var_1_3.type == DROP_TYPE_DORM3D_GIFT) then
					if var_1_3.type == DROP_TYPE_DORM3D_FURNITURE then
						getProxy(ApartmentProxy):AddDailyFurnitureShopCount(var_1_3.effect_args[1], var_1_3.effect_args[2] or 1)
					elseif var_1_3.type == DROP_TYPE_DORM3D_GIFT then
						getProxy(ApartmentProxy):AddDailyGiftShopCount(var_1_3.effect_args[1], var_1_3.effect_args[2] or 1)
					end
				end

				local var_11_9 = {}

				if var_1_3.type == 0 then
					self:sendNotification(GAME.EXTEND, {
						id = var_1_1,
						count = var_1_2
					})
				else
					var_11_9 = PlayerConst.addTranDrop(arg_11_0.drop_list)

					if not var_1_0.silentTip then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_buy_success"))
					end
				end

				if not var_1_0.isQuickShopping then
					self:sendNotification(GAME.SHOPPING_DONE, {
						id = var_1_1,
						shopType = var_11_1,
						normalList = var_1_7:GetNormalList(),
						normalGroupList = var_1_7:GetNormalGroupList(),
						awards = var_11_9
					})
				end
			else
				originalPrint(arg_11_0.result)

				if arg_11_0.result == 4400 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("shopping_error_time_limit"))
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_11_0.result))
				end
			end

			return
		end)

		return
	end)

	return
end

return ShoppingCommand
