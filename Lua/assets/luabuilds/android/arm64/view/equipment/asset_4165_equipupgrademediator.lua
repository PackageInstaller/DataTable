local EquipUpgradeMediator = class("EquipUpgradeMediator", import("..base.ContextMediator"))

EquipUpgradeMediator.EQUIPMENT_UPGRDE = "EquipUpgradeMediator:EQUIPMENT_UPGRDE"
EquipUpgradeMediator.REPLACE_EQUIP = "EquipUpgradeMediator:REPLACE_EQUIP"

function EquipUpgradeMediator:register()
	self:bind(EquipUpgradeMediator.EQUIPMENT_UPGRDE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		pg.UIMgr.GetInstance():LoadingOn()
		self:sendNotification(GAME.UPGRADE_EQUIPMENTS, {
			shipId = self.contextData.shipId,
			pos = self.contextData.pos,
			equipmentId = self.contextData.equipmentId,
			target = arg_2_1,
			materials = arg_2_2,
			consume = arg_2_3
		})

		return
	end)

	if self.contextData.shipId ~= nil then
		local var_1_0 = getProxy(BayProxy):getShipById(self.contextData.shipId)

		self.contextData.shipVO = var_1_0
		self.contextData.equipmentVO = var_1_0:getEquip(self.contextData.pos)
	elseif self.contextData.equipmentId ~= nil then
		self.contextData.equipmentVO = getProxy(EquipmentProxy):getEquipmentById(self.contextData.equipmentId)
	end

	return
end

function EquipUpgradeMediator:listNotificationInterests()
	return {
		GAME.UPGRADE_EQUIPMENTS_DONE
	}
end

function EquipUpgradeMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.UPGRADE_EQUIPMENTS_DONE then
		self.contextData.shipVO = var_4_0.ship
		self.contextData.equipmentVO = var_4_0.newEquip

		self.viewComponent:updateAll()
		self.viewComponent:upgradeFinish(var_4_0.equip, var_4_0.newEquip)
		pg.UIMgr.GetInstance():LoadingOff()
	end

	return
end

return EquipUpgradeMediator
