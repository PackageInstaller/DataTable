local DestroyEquipmentsCommand = class("DestroyEquipmentsCommand", pm.SimpleCommand)

function DestroyEquipmentsCommand:execute(arg_1_1)
	local var_1_0 = {}
	local var_1_1 = getProxy(EquipmentProxy)
	local var_1_2

	for iter_1_0, iter_1_1 in ipairs(arg_1_1:getBody().equipments) do
		local var_1_3 = var_1_1:getEquipmentById(iter_1_1[1])

		if not var_1_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_destroyEquipments_error_noEquip"))

			return
		end

		if iter_1_1[2] > var_1_3.count then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_destroyEquipments_error_notEnoughEquip"))

			return
		end

		table.insert(var_1_0, {
			id = iter_1_1[1],
			count = iter_1_1[2]
		})

		if not var_1_2 then
			local var_1_4 = not not var_1_3:isImportance()

			if var_1_3:getConfig("rarity") >= EquipmentRarity.Gold then
				var_1_4 = true
			end

			var_1_2 = (var_1_3:getConfig("id") % 20 >= 10 or nil) and true and iter_1_1[1]
		end
	end

	local var_1_5 = {}

	if var_1_2 then
		table.insert(var_1_5, function(arg_2_0)
			pg.SecondaryPWDMgr:LimitedOperation(pg.SecondaryPWDMgr.RESOLVE_EQUIPMENT, var_1_2, arg_2_0)

			return
		end)
	end

	seriesAsync(var_1_5, function()
		pg.ConnectionMgr.GetInstance():Send(14008, {
			equip_list = var_1_0
		}, 14009, function(arg_4_0)
			if arg_4_0.result == 0 then
				local var_4_0 = getProxy(PlayerProxy):getData()
				local var_4_1 = {}
				local var_4_2 = 0

				local function var_4_3(arg_5_0, arg_5_1)
					print("remove: " .. arg_5_0 .. " " .. arg_5_1)

					local var_5_0 = var_1_1:getEquipmentById(arg_5_0)

					var_1_1:removeEquipmentById(arg_5_0, arg_5_1)

					local var_5_1 = var_5_0:getConfig("destory_item") or {}

					var_4_2 = var_4_2 + (var_5_0:getConfig("destory_gold") or 0) * arg_5_1

					for iter_5_0, iter_5_1 in ipairs(var_5_1) do
						local var_5_2 = false

						for iter_5_2, iter_5_3 in ipairs(var_4_1) do
							if iter_5_1[1] == var_4_1[iter_5_2].id then
								var_4_1[iter_5_2].count = var_4_1[iter_5_2].count + iter_5_1[2] * arg_5_1
								var_5_2 = true

								break
							end
						end

						if not var_5_2 then
							table.insert(var_4_1, Drop.New({
								type = DROP_TYPE_ITEM,
								id = iter_5_1[1],
								count = iter_5_1[2] * arg_5_1
							}))
						end
					end

					return
				end

				self:sendNotification(EquipmentMediator.NO_UPDATE)

				for iter_4_0, iter_4_1 in ipairs(var_1_0) do
					var_4_3(iter_4_1.id, iter_4_1.count)
				end

				table.insert(var_4_1, Drop.New({
					id = 1,
					type = DROP_TYPE_RESOURCE,
					count = 0
				}))

				for iter_4_2, iter_4_3 in ipairs(var_4_1) do
					self:sendNotification(GAME.ADD_ITEM, iter_4_3)
				end

				if not LOCK_QUOTA_SHOP then
					getProxy(ShopsProxy):updateQuotaShop((QuotaShop.New()))
				end

				self:sendNotification(GAME.DESTROY_EQUIPMENTS_DONE, var_4_1)
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("equipment_destroyEquipments", arg_4_0.result))
			end

			return
		end)

		return
	end)

	return
end

return DestroyEquipmentsCommand
