local var_0_0 = class("CollectionGetAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.index
	local var_1_3 = false
	local var_1_4 = 0
	local var_1_5 = getProxy(PlayerProxy):getData()

	if pg.storeup_data_template[var_1_0.id].award_display[var_1_0.index] and pg.storeup_data_template[var_1_0.id].award_display[var_1_0.index][1] == DROP_TYPE_RESOURCE then
		var_1_4 = pg.storeup_data_template[var_1_0.id].award_display[var_1_0.index][2]
		var_1_3 = true
	end

	if var_1_3 and var_1_4 == 1 and var_1_5:GoldMax(1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_collect"))

		return
	end

	if var_1_3 and var_1_4 == 2 and var_1_5:OilMax(1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_collect"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(17005, {
		id = var_1_0.id,
		award_index = var_1_0.index
	}, 17006, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(CollectionProxy):updateAward(var_1_1, var_1_2)

			local var_2_0 = pg.storeup_data_template[var_1_1].award_display[var_1_2]

			if pg.storeup_data_template[var_1_1].award_display[var_1_2][1] == DROP_TYPE_RESOURCE then
				local var_2_1 = getProxy(PlayerProxy)
				local var_2_2 = var_2_1:getData()

				var_2_2:addResources({
					[id2res(var_2_0[2])] = var_2_0[3]
				})
				var_2_1:updatePlayer(var_2_2)
			elseif var_2_0[1] == DROP_TYPE_ITEM then
				getProxy(BagProxy):addItemById(var_2_0[2], var_2_0[3])
			elseif var_2_0[1] == DROP_TYPE_EQUIP then
				getProxy(EquipmentProxy):addEquipmentById(var_2_0[2], var_2_0[3])
			elseif var_2_0[1] == DROP_TYPE_SHIP then
				pg.TipsMgr.GetInstance():ShowTips(i18n("collection_award_ship", pg.ship_data_statistics[var_2_0[2]].name))
			elseif var_2_0[1] == DROP_TYPE_FURNITURE then
				local var_2_3 = getProxy(DormProxy)
				local var_2_4 = var_2_3:getRawData()

				var_2_4:AddFurniture((Furniture.New({
					count = 1,
					id = var_2_0[2]
				})))
				var_2_3:updateDrom(var_2_4, BackYardConst.DORM_UPDATE_TYPE_FURNITURE)
			end

			local var_2_5 = {}

			table.insert({}, Drop.Create(var_2_0))
			arg_1_0:sendNotification(GAME.COLLECT_GET_AWARD_DONE, {
				id = var_1_1,
				items = var_2_5
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_takeOk"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("collection_getResource_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
