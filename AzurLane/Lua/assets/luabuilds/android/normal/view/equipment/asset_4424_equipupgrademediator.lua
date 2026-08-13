class = var_0_10000

local var_0_0 = "EquipUpgradeMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.EQUIPMENT_UPGRDE = "EquipUpgradeMediator:EQUIPMENT_UPGRDE"
var_0_1.REPLACE_EQUIP = "EquipUpgradeMediator:REPLACE_EQUIP"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.EQUIPMENT_UPGRDE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		pg = var_2_10004

		local var_2_0 = var_2_10004.UIMgr.GetInstance()

		var_4.LoadingOn(var_2_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_4.sendNotification

		GAME = var_2_10006

		var_2_2(var_2_1, var_2_10006.UPGRADE_EQUIPMENTS, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos,
			equipmentId = arg_1_0.contextData.equipmentId,
			target = arg_2_1,
			materials = arg_2_2,
			consume = arg_2_3
		})

		return
	end)

	local var_1_1, var_1_2

	if arg_1_0.contextData.shipId ~= nil then
		getProxy = var_1_0
		BayProxy = var_1_2
		var_1_1 = var_1_0(var_1_2)
		var_1_2 = var_2.getShipById(var_1_1, var_1)
		var_1_1 = arg_1_0.contextData
		var_1_1.shipVO = var_1_2
		var_1_1 = arg_1_0.contextData
		var_1_1.equipmentVO = var_1_2:getEquip(arg_1_0.contextData.pos)
	elseif arg_1_0.contextData.equipmentId ~= nil then
		getProxy = var_1_2
		EquipmentProxy = var_1_1

		local var_1_3 = var_1_2(var_1_1)

		arg_1_0.contextData.equipmentVO = var_1_3:getEquipmentById(var_2)
	end

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.UPGRADE_EQUIPMENTS_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.UPGRADE_EQUIPMENTS_DONE then
		local var_4_3 = var_4_2.ship
		local var_4_4 = var_4_2.equip
		local var_4_5 = var_4_2.newEquip

		arg_4_0.contextData.shipVO = var_4_3
		arg_4_0.contextData.equipmentVO = var_4_5

		local var_4_6 = arg_4_0.viewComponent

		var_7.updateAll(var_4_6)

		local var_4_7 = arg_4_0.viewComponent

		var_7.upgradeFinish(var_4_7, var_4_4, var_4_5)

		pg = var_7

		local var_4_8 = var_7.UIMgr.GetInstance()

		var_7.LoadingOff(var_4_8)
	end

	return
end

return var_0_1
