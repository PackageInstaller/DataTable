local var_0_0 = class("UpGradeEquipmentCommands", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.pos
	local var_1_3 = var_1_0.equipmentId
	local var_1_4 = var_1_0.target
	local var_1_5 = var_1_0.materials
	local var_1_6 = var_1_0.consume
	local var_1_7

	if var_1_0.shipId then
		var_1_7 = getProxy(BayProxy):getShipById(var_1_1):getEquip(var_1_2)

		assert(var_1_7, "can not find equipment at ship.")
	else
		var_1_7 = getProxy(EquipmentProxy):getEquipmentById(var_1_3)

		assert(var_1_7, "can not find equipment: " .. var_1_3)
	end

	local var_1_8, var_1_9

	if not Equipment.canUpgrade(var_1_7.configId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_max_level"))

		do return end

		var_1_8 = var_1_1 and 14003 or 14005
		var_1_9 = var_1_1 and {
			ship_id = var_1_1,
			pos = var_1_2,
			lv = var_1_4:getConfig("level") - var_1_7:getConfig("level")
		} or {
			equip_id = var_1_3,
			lv = var_1_4:getConfig("level") - var_1_7:getConfig("level")
		}
	end

	pg.ConnectionMgr.GetInstance():Send(var_1_1 and 14002 or 14004, var_1_9, var_1_8, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = getProxy(BagProxy)
			local var_2_2 = getProxy(EquipmentProxy)
			local var_2_3 = getProxy(PlayerProxy)
			local var_2_4
			local var_2_5

			if var_1_1 then
				var_2_4 = var_2_0:getShipById(var_1_1)
				var_2_5 = var_2_4:getEquip(var_1_2)
			else
				var_2_5 = var_2_2:getEquipmentById(var_1_3)
			end

			reducePlayerOwn(Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold,
				count = var_1_6
			}))

			for iter_2_0, iter_2_1 in ipairs(var_1_5) do
				reducePlayerOwn(iter_2_1)
			end

			if var_2_4 then
				var_2_4:updateEquip(var_1_2, var_1_4)
				var_2_0:updateShip(var_2_4)
			elseif var_2_5 then
				var_2_2:removeEquipmentById(var_2_5.id, 1)
				var_2_2:addEquipmentById(var_1_4.id, 1, true)
			end

			arg_1_0:sendNotification(GAME.UPGRADE_EQUIPMENTS_DONE, {
				ship = var_2_4,
				equip = var_2_5,
				newEquip = var_1_4
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("equipment_upgrade_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
