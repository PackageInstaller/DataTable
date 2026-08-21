local var_0_0 = class("UpgradeStarCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = var_1_1:getShipById(var_1_0.shipId)

	if pg.ship_data_breakout[var_1_2.configId].breakout_id == 0 then
		return
	end

	local var_1_3 = Clone(var_1_2)

	var_1_3.configId = pg.ship_data_breakout[var_1_2.configId].breakout_id

	for iter_1_0, iter_1_1 in pairs(var_1_2.equipments) do
		if iter_1_1 and var_1_3:isForbiddenAtPos(iter_1_1, iter_1_0) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("ship_upgrade_unequip_tip", var_1_3:getConfig("name"), "#fad545"),
				onYes = function()
					arg_1_0:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
						shipId = var_1_2.id,
						pos = iter_1_0
					})

					return
				end
			})

			return
		end
	end

	local var_1_4 = Clone(var_1_2)
	local var_1_5 = {}

	for iter_1_2, iter_1_3 in ipairs(var_1_0.shipIds) do
		local var_1_6 = var_1_1:getShipById(iter_1_3)

		if not var_1_6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", iter_1_3))

			return
		end

		table.insert({}, var_1_6)
	end

	local var_1_7 = getProxy(CollectionProxy):getShipGroup(Clone(var_1_2).groupId)

	pg.ConnectionMgr.GetInstance():Send(12027, {
		ship_id = var_1_0.shipId,
		material_id_list = var_1_0.shipIds
	}, 12028, function(arg_3_0)
		if arg_3_0.result == 0 then
			local var_3_0 = getProxy(EquipmentProxy)

			for iter_3_0, iter_3_1 in ipairs(var_1_5) do
				for iter_3_2, iter_3_3 in ipairs(iter_3_1.equipments) do
					if iter_3_3 then
						var_3_0:addEquipment(iter_3_3)
					end

					if iter_3_1:getEquipSkin(iter_3_2) ~= 0 then
						var_3_0:addEquipmentSkin(iter_3_1:getEquipSkin(iter_3_2), 1)
						iter_3_1:updateEquipmentSkin(iter_3_2, 0)
						pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_unload"))
					end
				end

				local var_3_1 = iter_3_1:GetSpWeapon()

				if var_3_1 then
					iter_3_1:UpdateSpWeapon(nil)
					var_3_0:AddSpWeapon(var_3_1)
				end

				var_1_1:removeShip(iter_3_1)
			end

			if pg.ship_data_breakout[var_1_2.configId].breakout_id ~= 0 then
				var_1_2.configId = pg.ship_data_breakout[var_1_2.configId].breakout_id

				for iter_3_4, iter_3_5 in ipairs(pg.ship_data_template[var_1_2.configId].buff_list) do
					var_1_2.skills[iter_3_5] = var_1_2.skills[iter_3_5] or {
						exp = 0,
						level = 1,
						id = iter_3_5
					}
				end

				var_1_2:updateMaxLevel(pg.ship_data_template[var_1_2.configId].max_level)

				for iter_3_6, iter_3_7 in ipairs(pg.ship_data_template[var_1_4.configId].buff_list) do
					if not table.contains(pg.ship_data_template[var_1_2.configId].buff_list, iter_3_7) then
						var_1_2.skills[iter_3_7] = nil
					end
				end

				var_1_1:updateShip(var_1_2)
			end

			local var_3_2 = getProxy(BagProxy)

			for iter_3_8, iter_3_9 in ipairs(pg.ship_data_breakout[var_1_2.configId].use_item) do
				var_3_2:removeItemById(iter_3_9[1], iter_3_9[2])
			end

			local var_3_3 = getProxy(PlayerProxy)
			local var_3_4 = var_3_3:getData()

			var_3_4:consume({
				gold = pg.ship_data_breakout[var_1_2.configId].use_gold
			})
			var_3_3:updatePlayer(var_3_4)
			arg_1_0:sendNotification(GAME.UPGRADE_STAR_DONE, {
				newShip = var_1_2,
				oldShip = var_1_4
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_upgradeStar_error", arg_3_0.result))
		end

		return
	end)

	return
end

return var_0_0
