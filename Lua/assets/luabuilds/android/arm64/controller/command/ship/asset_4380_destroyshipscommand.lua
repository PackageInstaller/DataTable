local DestroyShipsCommand = class("DestroyShipsCommand", pm.SimpleCommand)

function DestroyShipsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not var_1_0.destroyEquipment then
		-- block empty
	end

	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.shipIds) do
		local var_1_4 = var_1_2:getShipById(iter_1_1)

		if var_1_4 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", iter_1_1))

			return
		end

		table.insert(var_1_3, var_1_4)
	end

	pg.ConnectionMgr.GetInstance():Send(12004, {
		ship_id_list = var_1_0.shipIds
	}, 12005, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(EquipmentProxy)
			local var_2_1 = {}
			local var_2_2 = {}

			for iter_2_0, iter_2_1 in ipairs(var_1_3) do
				var_1_2:removeShip(iter_2_1)

				for iter_2_2, iter_2_3 in ipairs(iter_2_1.equipments) do
					if iter_2_3 then
						var_2_0:addEquipment(iter_2_3)

						if not var_2_1[iter_2_3.id] then
							var_2_1[iter_2_3.id] = iter_2_3:clone()
						else
							var_2_1[iter_2_3.id].count = var_2_1[iter_2_3.id].count + 1
						end
					end

					if iter_2_1:getEquipSkin(iter_2_2) ~= 0 then
						var_2_0:addEquipmentSkin(iter_2_1:getEquipSkin(iter_2_2), 1)
						iter_2_1:updateEquipmentSkin(iter_2_2, 0)
						pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_unload"))
					end
				end

				local var_2_3 = iter_2_1:GetSpWeapon()

				if var_2_3 then
					iter_2_1:UpdateSpWeapon(nil)
					var_2_0:AddSpWeapon(var_2_3)
					pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_unload"))
				end

				table.insert(var_2_2, iter_2_1.id)
			end

			local var_2_4, var_2_5, var_2_6 = ShipCalcHelper.CalcDestoryRes(var_1_3)
			local var_2_7 = {}

			if var_2_4 > 0 then
				table.insert(var_2_7, Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = PlayerConst.ResGold,
					count = var_2_4
				}))
			end

			if var_2_5 > 0 then
				table.insert(var_2_7, Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = PlayerConst.ResOil,
					count = var_2_5
				}))
			end

			local var_2_8 = table.mergeArray(var_2_7, var_2_6)

			for iter_2_4, iter_2_5 in ipairs(var_2_8) do
				self:sendNotification(GAME.ADD_ITEM, iter_2_5)
			end

			self:sendNotification(GAME.DESTROY_SHIP_DONE, {
				destroiedShipIds = var_2_2,
				bonus = var_2_8,
				equipments = var_2_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_destoryShips", arg_2_0.result))
		end

		return
	end)

	return
end

return DestroyShipsCommand
