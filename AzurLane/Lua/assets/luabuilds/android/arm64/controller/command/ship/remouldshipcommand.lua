local var_0_0 = class("RemouldShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.remouldId
	local var_1_3 = var_1_0.materialIds or {}

	if not var_1_0.shipId or not var_1_0.remouldId then
		return
	end

	local var_1_4 = getProxy(PlayerProxy):getData()
	local var_1_5 = pg.transform_data_template[var_1_0.remouldId]

	assert(pg.transform_data_template[var_1_0.remouldId], "transform_data_template>>>." .. var_1_0.remouldId)

	if pg.transform_data_template[var_1_0.remouldId].use_gold > var_1_4.gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	local var_1_6 = getProxy(BayProxy)
	local var_1_7 = var_1_6:getShipById(var_1_0.shipId)
	local var_1_8 = 0

	if var_1_7.transforms[var_1_0.remouldId] then
		var_1_8 = var_1_7.transforms[var_1_0.remouldId].level

		if var_1_7.transforms[var_1_0.remouldId].level == #pg.transform_data_template[var_1_0.remouldId].effect then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_max_level"))

			return
		end
	end

	local var_1_9 = pg.transform_data_template[var_1_0.remouldId].use_item[var_1_8 + 1] or {}
	local var_1_10 = getProxy(BagProxy)

	for iter_1_0, iter_1_1 in ipairs(var_1_9) do
		if var_1_10:getItemCountById(iter_1_1[1]) < iter_1_1[2] then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

			return
		end
	end

	if pg.transform_data_template[var_1_0.remouldId].use_ship ~= 0 then
		if table.getCount(var_1_3) ~= pg.transform_data_template[var_1_0.remouldId].use_ship then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_material_ship_no_enough"))

			return
		end

		for iter_1_2, iter_1_3 in ipairs(var_1_3) do
			if not var_1_6:getShipById(iter_1_3) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_material_ship_on_exist"))

				return
			end
		end
	end

	for iter_1_4, iter_1_5 in ipairs(pg.transform_data_template[var_1_0.remouldId].ship_id) do
		if iter_1_5[1] == var_1_7.configId then
			local var_1_11 = getProxy(EquipmentProxy)

			if var_1_11:getCapacity() >= var_1_4:getMaxEquipmentBag() then
				local var_1_12 = Clone(var_1_7)

				var_1_12.configId = iter_1_5[2]

				for iter_1_6, iter_1_7 in ipairs(var_1_12.equipments) do
					if iter_1_7 and var_1_12:isForbiddenAtPos(iter_1_7, iter_1_6) then
						pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_cant_unload"))

						return
					end
				end
			end
		end
	end

	local var_1_13
	local var_1_14
	local var_1_15

	for iter_1_8, iter_1_9 in ipairs(pg.transform_data_template[var_1_0.remouldId].ship_id) do
		if var_1_7.configId == iter_1_9[1] then
			var_1_13, var_1_14 = unpack(iter_1_9)

			break
		end
	end

	if var_1_13 and var_1_14 then
		var_1_15 = ShipType.GetTeamFromShipType(pg.ship_data_statistics[var_1_13].type) ~= ShipType.GetTeamFromShipType(pg.ship_data_statistics[var_1_14].type)
	end

	local var_1_16 = {}

	if var_1_15 then
		if var_1_7:getFlag("inFleet") then
			if not getProxy(FleetProxy):GetRegularFleetByShip(var_1_7):canRemove(var_1_7) then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					yesText = "text_forward",
					content = i18n("shipmodechange_reject_1stfleet_only"),
					onYes = function()
						arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BIANDUI)

						return
					end
				})

				return
			end
		end

		table.insert(var_1_16, function(arg_3_0)
			(function()
				local var_4_0, var_4_1 = ShipStatus.ShipStatusCheck("onTeamChange", var_1_7, var_0)

				if var_4_0 then
					arg_3_0()
				elseif var_4_1 then
					pg.TipsMgr.GetInstance():ShowTips(var_4_1)
				end

				return
			end)()

			return
		end)

		if var_1_7:getFlag("inWorld") then
			table.insert(var_1_16, function(arg_5_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("shipchange_alert_inworld"),
					onYes = arg_5_0
				})

				return
			end)
		end

		if var_1_7:getFlag("inElite") then
			table.insert(var_1_16, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("shipchange_alert_indiff"),
					onYes = function()
						arg_1_0:sendNotification(GAME.REMOVE_ELITE_TARGET_SHIP, {
							shipId = var_1_7.id,
							callback = arg_6_0
						})

						return
					end
				})

				return
			end)
		end
	end

	table.insert(var_1_16, function(arg_8_0)
		if var_1_5.skin_id and var_1_5.skin_id ~= 0 then
			PaintingGroupConst.AddPaintingNameBySkinID({}, var_1_5.skin_id)
		end

		PaintingGroupConst.PaintingDownload({
			isShowBox = true,
			paintingNameList = {},
			finishFunc = arg_8_0
		})

		return
	end)
	seriesAsync(var_1_16, function()
		pg.ConnectionMgr.GetInstance():Send(12011, {
			ship_id = var_1_1,
			remould_id = var_1_2,
			material_id = var_1_3
		}, 12012, function(arg_10_0)
			if arg_10_0.result == 0 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_REMOULD_SHIP, var_1_7.groupId)

				if var_1_15 and var_1_7:getFlag("inWorld") then
					local var_10_0 = nowWorld()
					local var_10_1 = var_10_0:GetFleet(var_10_0:GetShip(var_1_7.id).fleetId)

					var_10_1:UpdateShips((underscore.filter(var_10_1:GetShips(true), function(arg_11_0)
						return arg_11_0.id ~= var_1_7.id
					end)))
					pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inWorld")
				end

				if var_0 then
					var_1_7.transforms[var_1_2].level = var_1_7.transforms[var_1_2].level + 1
				else
					var_1_7.transforms[var_1_2] = {
						level = 1,
						id = var_1_2
					}
				end

				for iter_10_0, iter_10_1 in ipairs(var_1_5.edit_trans) do
					if var_1_7.transforms[iter_10_1] then
						var_1_7.transforms[iter_10_1] = nil
					end
				end

				local var_10_2 = getProxy(NavalAcademyProxy)
				local var_10_3 = var_10_2:getStudentByShipId(var_1_1)
				local var_10_4 = var_10_3 and var_10_3:getSkillId(var_1_7)

				if var_1_13 and var_1_14 then
					var_1_7.configId = var_1_14

					for iter_10_2 = 1, math.max(#pg.ship_data_template[var_1_13].buff_list, #pg.ship_data_template[var_1_14].buff_list) do
						local var_10_5 = pg.ship_data_template[var_1_13].buff_list[iter_10_2]
						local var_10_6 = pg.ship_data_template[var_1_14].buff_list[iter_10_2]

						if pg.ship_data_template[var_1_13].buff_list[iter_10_2] == pg.ship_data_template[var_1_14].buff_list[iter_10_2] then
							-- block empty
						else
							local var_10_7

							if var_10_5 then
								var_10_7 = var_1_7.skills[var_10_5]
								var_10_7.id = var_10_6
								var_1_7.skills[var_10_5] = nil
							else
								var_10_7 = {
									exp = 0,
									level = 1,
									id = var_10_6
								}
							end

							var_1_7.skills[var_10_6] = var_10_7

							pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_material_unlock_skill", pg.skill_data_template[var_10_6].name))

							if var_10_3 and var_10_4 == var_10_5 then
								var_10_3:updateSkillId(var_10_6)
								var_10_2:updateStudent(var_10_3)
							end
						end
					end
				end

				_.each(var_1_5.ship_id, function(arg_12_0)
					if arg_12_0[1] == var_1_7.configId then
						-- block empty
					end

					return
				end)

				local var_10_8 = var_1_5.use_item[var_0] or {}

				for iter_10_3, iter_10_4 in pairs(var_10_8) do
					var_1_10:removeItemById(iter_10_4[1], iter_10_4[2])
				end

				local var_10_9 = getProxy(PlayerProxy)
				local var_10_10 = var_10_9:getData()

				var_10_10:consume({
					gold = var_1_5.use_gold
				})
				var_10_9:updatePlayer(var_10_10)

				local var_10_11 = {}

				if var_1_5.skin_id ~= 0 then
					var_1_7:updateSkinId(var_1_5.skin_id, 0)
					table.insert({}, {
						count = 1,
						type = DROP_TYPE_SKIN,
						id = var_1_5.skin_id
					})

					local var_10_12 = getProxy(CollectionProxy)
					local var_10_13 = var_10_12:getShipGroup(var_1_7.groupId)

					if var_10_13 and not var_10_13.trans then
						var_10_13.trans = true

						var_10_12:updateShipGroup(var_10_13)
					end
				end

				if var_1_5.skill_id ~= 0 and not var_1_7.skills[var_1_5.skill_id] then
					var_1_7.skills[var_1_5.skill_id] = {
						exp = 0,
						level = 1,
						id = var_1_5.skill_id
					}

					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_material_unlock_skill", pg.skill_data_template[var_1_5.skill_id].name))
				end

				var_1_7:updateName()

				local var_10_14 = var_1_7:GetSpWeapon()

				if var_10_14 and not var_1_7:CanEquipSpWeapon(var_10_14) then
					var_1_7:UpdateSpWeapon(nil)
					getProxy(EquipmentProxy):AddSpWeapon(var_10_14)
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_unequipFromShip_ok", var_10_14:GetName()), "red")
				end

				var_1_6:updateShip(var_1_7)

				local var_10_15 = getProxy(EquipmentProxy)
				local var_10_16 = var_1_3 or {}

				for iter_10_5, iter_10_6 in ipairs(var_10_16) do
					local var_10_17 = var_1_6:getShipById(iter_10_6)

					for iter_10_7, iter_10_8 in ipairs(var_10_17.equipments) do
						if iter_10_8 then
							var_10_15:addEquipment(iter_10_8)
						end

						if var_10_17:getEquipSkin(iter_10_7) ~= 0 then
							var_10_15:addEquipmentSkin(var_10_17:getEquipSkin(iter_10_7), 1)
							pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_unload"))
						end
					end

					local var_10_18 = var_10_17:GetSpWeapon()

					if var_10_18 then
						var_10_17:UpdateSpWeapon(nil)
						var_10_15:AddSpWeapon(var_10_18)
					end

					var_1_6:removeShipById(iter_10_6)
				end

				for iter_10_9, iter_10_10 in ipairs(var_1_7.equipments) do
					if iter_10_10 and not var_1_7:canEquipAtPos(iter_10_10, iter_10_9) then
						table.insert({}, function(arg_13_0)
							arg_1_0:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
								shipId = var_1_7.id,
								pos = iter_10_9,
								callback = arg_13_0
							})

							return
						end)
					end
				end

				seriesAsync({}, function()
					arg_1_0:sendNotification(GAME.REMOULD_SHIP_DONE, {
						ship = var_1_6:getShipById(var_1_1),
						awards = var_10_11
					})

					local var_14_0 = nowWorld()
					local var_14_1 = var_14_0 and var_14_0:GetBossProxy()

					if var_14_1 and var_14_1.isSetup then
						var_14_1:CheckRemouldShip()
					end

					return
				end)
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_remouldShip", arg_10_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_0
