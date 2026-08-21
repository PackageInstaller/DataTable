local var_0_0 = class("ShipEquipAllChangeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = getProxy(EquipmentProxy)
	local var_1_5 = var_1_0.shipId
	local var_1_6 = getProxy(BayProxy):getShipById(var_1_0.shipId)

	if not var_1_6 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_5))

		return
	end

	local var_1_7 = {}
	local var_1_8 = {}
	local var_1_9 = 0
	local var_1_10 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0.equipData) do
		local var_1_11 = false

		if iter_1_0 == 6 then
			var_1_11 = iter_1_1 and iter_1_1 and iter_1_1.shipId == var_1_5 or not var_1_6.spWeapon

			if not var_1_11 then
				if iter_1_1 and iter_1_1.shipId then
					table.insert(var_1_8, var_1_4(iter_1_1.shipId, 0))
				end

				local var_1_13 = var_1_8

				if iter_1_1 then
					var_1_12(var_1_13, var_1_14(var_1_15, var_1_16))

					if var_1_6.spWeapon or iter_1_1 and iter_1_1.shipId then
						var_1_10 = var_1_10 + 1
					end

					goto label_1_0

					var_1_11 = iter_1_1 and iter_1_1 and iter_1_1.shipId == var_1_5 and iter_1_1.shipPos == iter_1_0 or not var_1_6.equipments[iter_1_0]

					::label_1_0::

					if not var_1_11 then
						if var_1_6.equipments[iter_1_0] then
							table.insert(var_1_7, var_1_3(var_1_5, 0, iter_1_0))
						end

						if iter_1_1 and iter_1_1.shipId and iter_1_1.shipId ~= var_1_5 then
							table.insert(var_1_8, var_1_3(iter_1_1.shipId, 0, iter_1_1.shipPos))
						end

						local var_1_18 = var_1_8

						if iter_1_1 then
							do
								var_1_17(var_1_18, var_1_19(var_1_20, var_1_21, iter_1_0))

								if var_1_6.equipments[iter_1_0] or iter_1_1 and iter_1_1.shipId then
									var_1_9 = var_1_9 + 1
								end
							end
						end
					end
				end
			end
		end
	end

	if var_1_9 > 0 then
		if getProxy(PlayerProxy):getData():getMaxEquipmentBag() < var_1_2:getCapacity() + var_1_9 then
			NoPosMsgBox(i18n("switch_to_shop_tip_noPos"), openDestroyEquip, gotoChargeScene)

			return
		end
	end

	if var_1_10 > 0 and var_1_2:GetSpWeaponCapacity() < var_1_2:GetSpWeaponCount() + var_1_10 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_bag_no_enough"))

		return
	end

	seriesAsync(table.mergeArray(var_1_7, var_1_8), function()
		arg_1_0:sendNotification(GAME.SHIP_EQUIP_ALL_CHANGE_DONE, var_1_5)
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_import_success"))

		return
	end)

	return
end

return var_0_0
