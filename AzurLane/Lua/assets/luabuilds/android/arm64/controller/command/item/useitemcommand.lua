local var_0_0 = class("UseItemCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.count
	local var_1_3 = var_1_0.arg
	local var_1_4 = getProxy(BagProxy)
	local var_1_5 = getProxy(BagProxy):getItemById(var_1_0.id)
	local var_1_6 = var_1_5:getConfig("usage")
	local var_1_8 = var_1_0.callback
	local var_1_9 = var_1_0.isEquipBox

	if var_1_0.count == 0 then
		return
	end

	if var_1_2 > var_1_5.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

		return
	end

	if not var_0_0.Check(var_1_5, var_1_2) then
		return
	end

	if var_1_6 == ItemUsage.GUILD_DONATE or var_1_6 == ItemUsage.GUILD_OPERATION then
		local var_1_10 = getProxy(GuildProxy)

		if not var_1_10:getRawData() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("not_exist_guild_use_item"))

			return
		end
	elseif var_1_6 == ItemUsage.SKIN_SHOP_DISCOUNT or var_1_6 == ItemUsage.USAGE_SHOP_DISCOUNT then
		local var_1_11, var_1_12 = var_1_5:GetConsumeForSkinShopDiscount(var_1_3[1])

		if var_1_11 > 0 and getProxy(PlayerProxy):getRawData():getResource(var_1_12) < var_1_11 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(15002, {
		id = var_1_1,
		count = var_1_2,
		arg = var_1_3
	}, 15003, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			var_1_4:removeItemById(var_1_1, var_1_2)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.drop_list) do
				print(iter_2_0, iter_2_1)
			end

			if var_1_6 == ItemUsage.FOOD then
				arg_1_0:sendNotification(GAME.ADD_FOOD, {
					id = var_1_1,
					count = var_1_2
				})
			elseif var_1_6 == ItemUsage.DROP or var_1_6 == ItemUsage.DROP_TEMPLATE or var_1_6 == ItemUsage.DROP_APPOINTED or var_1_6 == ItemUsage.INVITATION or var_1_6 == ItemUsage.SKIN_SELECT or var_1_6 == ItemUsage.RANDOM_SKIN or var_1_6 == ItemUsage.SHIP_GIFT or var_1_6 == ItemUsage.REPAIR_LOVE_LETTER then
				var_2_0 = PlayerConst.addTranDrop(arg_2_0.drop_list)
			elseif var_1_6 == ItemUsage.USAGE_SKIN_EXP then
				getProxy(ShipSkinProxy):addSkin((ShipSkin.New({
					id = pg.shop_template[var_1_3[1]].effect_args[1],
					end_time = pg.TimeMgr.GetInstance():GetServerTime() + pg.shop_template[var_1_3[1]].time_second
				})))
				arg_1_0:sendNotification(GAME.SKIN_SHOPPIGN_DONE, {
					id = var_1_3[1]
				})
			elseif var_1_6 == ItemUsage.SKIN_SHOP_DISCOUNT or var_1_6 == ItemUsage.USAGE_SHOP_DISCOUNT then
				var_2_0 = PlayerConst.addTranDrop(arg_2_0.drop_list)

				local var_2_1, var_2_2 = var_1_5:GetConsumeForSkinShopDiscount(var_1_3[1])

				if var_2_1 > 0 then
					local var_2_3 = getProxy(PlayerProxy):getData()

					var_2_3:consume({
						[id2res(var_2_2)] = var_2_1
					})
					getProxy(PlayerProxy):updatePlayer(var_2_3)
				end

				arg_1_0:sendNotification(GAME.SKIN_SHOPPIGN_DONE, {
					id = var_1_3[1]
				})
			elseif var_1_6 == ItemUsage.DORM_LV_UP then
				arg_1_0:sendNotification(GAME.EXTEND_BACKYARD_AREA)
			elseif var_1_6 == ItemUsage.GUILD_DONATE then
				local var_2_4 = getProxy(GuildProxy):getRawData()

				if var_2_4 then
					var_2_4:AddExtraDonateCnt(var_1_2)
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_use_donateitem_success", var_1_2))
				end
			elseif var_1_6 == ItemUsage.GUILD_OPERATION then
				local var_2_5 = getProxy(GuildProxy):getRawData()

				if var_2_5 then
					var_2_5:AddExtraBattleCnt(var_1_2)
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_use_battleitem_success", var_1_2))
				end
			elseif var_1_6 == ItemUsage.REDUCE_COMMANDER_TIME then
				arg_1_0:sendNotification(GAME.REFRESH_COMMANDER_BOXES)
			else
				assert(false, "未处理类型" .. var_1_6)
			end

			local var_2_6 = QRJ_ITEM_ID_RANGE

			if var_1_1 >= QRJ_ITEM_ID_RANGE[1] and var_1_1 <= var_2_6[2] then
				table.sort(var_2_0, function(arg_3_0, arg_3_1)
					return arg_3_0.count < arg_3_1.count
				end)
			end

			if var_1_8 then
				var_1_8(var_2_0)
			end

			arg_1_0:sendNotification(GAME.USE_ITEM_DONE, {
				drops = var_2_0,
				isEquipBox = var_1_9
			})
		else
			if var_1_8 then
				var_1_8({})
			end

			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

function var_0_0.Check(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = CheckOverflow((GetItemsOverflowDic((arg_4_0:GetOverflowCheckItems(arg_4_1)))))

	if not var_4_0 then
		switch(var_4_1, {
			gold = function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

				return
			end,
			oil = function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

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

		return false
	end

	return true
end

return var_0_0
