class = var_0_10000

local var_0_0 = "UpGradeEquipmentCommands"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.pos
	local var_1_2 = var_2.equipmentId
	local var_1_3 = var_2.target
	local var_1_4 = var_2.materials
	local var_1_5 = var_2.consume
	local var_1_6

	if var_1_0 then
		getProxy = var_1_10010
		BayProxy = var_1_10012
		var_1_10013 = var_1_10010(var_1_10012)

		local var_1_7 = var_1_10010.getShipById(var_1_10013, var_1_0)

		var_1_6 = var_11.getEquip(var_1_7, var_1_1)
		assert = var_1_10012

		var_1_10012(var_1_6, "can not find equipment at ship.")
	else
		getProxy = var_1_10010
		EquipmentProxy = var_1_10012
		var_1_10013 = var_1_10010(var_1_10012)
		var_1_6 = var_1_10010.getEquipmentById(var_1_10013, var_1_2)
		assert = var_11

		var_11(var_1_6, "can not find equipment: " .. var_1_2)
	end

	Equipment = var_1_10010

	if not var_1_10010.canUpgrade(var_1_6.configId) then
		pg = var_10

		local var_1_8 = var_10.TipsMgr.GetInstance()
		local var_1_9 = var_10.ShowTips

		i18n = var_1_10013

		var_1_9(var_1_8, var_1_10013("equipment_max_level"))

		return
	end

	local var_1_10 = var_1_0 and 14002 or 14004
	local var_1_11 = var_1_0 and 14003 or 14005
	local var_1_12

	if not var_1_0 or not {
		ship_id = var_1_0,
		pos = var_1_1,
		lv = var_1_3:getConfig("level") - var_1_6:getConfig("level")
	} then
		var_1_12 = {
			equip_id = var_1_2,
			lv = var_1_3:getConfig("level") - var_1_6:getConfig("level")
		}
	end

	pg = var_1_10013

	local var_1_13 = var_1_10013.ConnectionMgr.GetInstance()

	var_13.Send(var_1_13, var_1_10, var_1_12, var_1_11, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			BayProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)
			getProxy = var_2_10002
			BagProxy = var_2_10004

			local var_2_1 = var_2_10002(var_2_10004)

			getProxy = var_2_10003
			EquipmentProxy = var_2_10005

			local var_2_2 = var_2_10003(var_2_10005)

			getProxy = var_2_10004
			PlayerProxy = var_2_10006
			var_2_10004 = var_2_10004(var_2_10006)

			local var_2_3
			local var_2_4

			if var_1_0 then
				var_2_10009 = var_2_0
				var_2_10009 = var_2_0.getShipById(var_2_10009, var_1_0)
				var_2_4 = var_2_3.getEquip(var_2_10009, var_1_1)
			else
				var_2_10009 = var_2_2
				var_2_4 = var_2_2.getEquipmentById(var_2_10009, var_1_2)
			end

			reducePlayerOwn = var_7
			Drop = var_2_10009

			local var_2_5 = var_2_10009.New
			local var_2_6 = {}

			DROP_TYPE_RESOURCE = var_2_10012
			var_2_6.type = var_2_10012
			PlayerConst = var_2_10012
			var_2_6.id = var_2_10012.ResGold
			var_2_6.count = var_1_5

			var_7(var_2_5(var_2_6))

			ipairs = var_7

			for iter_2_0, iter_2_1 in var_7(var_1_4) do
				reducePlayerOwn = var_12

				var_12(iter_2_1)
			end

			if var_2_3 then
				var_2_3:updateEquip(var_1_1, var_1_3)
				var_2_0:updateShip(var_2_3)
			elseif var_2_4 then
				var_2_2:removeEquipmentById(var_2_4.id, 1)
				var_2_2:addEquipmentById(var_1_3.id, 1, true)
			end

			local var_2_7 = arg_1_0
			local var_2_8 = var_7.sendNotification

			GAME = iter_2_0

			var_2_8(var_2_7, iter_2_0.UPGRADE_EQUIPMENTS_DONE, {
				ship = var_2_3,
				equip = var_2_4,
				newEquip = var_1_3
			})
		else
			pg = var_2_0

			local var_2_9 = var_2_0.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_10(var_2_9, var_2_10004("equipment_upgrade_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
