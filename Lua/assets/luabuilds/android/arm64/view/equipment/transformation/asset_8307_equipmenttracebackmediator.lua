local EquipmentTraceBackMediator = class("EquipmentTraceBackMediator", import("view.base.ContextMediator"))

EquipmentTraceBackMediator.TRANSFORM_EQUIP = "transform equip"

function EquipmentTraceBackMediator:register()
	self:BindEvent()

	self.env = {}

	self:getViewComponent():SetEnv(self.env)
	assert(self.contextData.TargetEquipmentId, "Should Set TargetEquipment First")

	self.env.tracebackHelper = getProxy(EquipmentProxy):GetWeakEquipsDict()

	self:getViewComponent():UpdatePlayer(getProxy(PlayerProxy):getData())

	self.stopUpdateView = false

	return
end

function EquipmentTraceBackMediator:BindEvent()
	self:bind(EquipmentTraceBackMediator.TRANSFORM_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		self.stopUpdateView = true

		self:sendNotification(GAME.TRANSFORM_EQUIPMENT, {
			candicate = arg_3_1,
			formulaIds = arg_3_2
		})

		return
	end)

	return
end

function EquipmentTraceBackMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		BagProxy.ITEM_UPDATED,
		EquipmentProxy.EQUIPMENT_UPDATED,
		GAME.EQUIP_TO_SHIP_DONE,
		GAME.UNEQUIP_FROM_SHIP_DONE,
		GAME.TRANSFORM_EQUIPMENT_DONE,
		GAME.TRANSFORM_EQUIPMENT_FAIL
	}
end

function EquipmentTraceBackMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == PlayerProxy.UPDATED then
		self:getViewComponent():UpdatePlayer(var_5_1)
	elseif var_5_0 == BagProxy.ITEM_UPDATED then
		if self.stopUpdateView then
			return
		end

		local var_5_2 = self:getViewComponent()

		var_5_2:UpdateSort()
		var_5_2:UpdateSourceList()
		var_5_2:UpdateFormula()
	elseif var_5_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		if self.stopUpdateView then
			return
		end

		if self.contextData.sourceEquipmentInstance then
			local var_5_3 = self.contextData.sourceEquipmentInstance

			if var_5_1.count == 0 and var_5_3.type == DROP_TYPE_EQUIP and EquipmentProxy.SameEquip(var_5_1, var_5_3.template) then
				self.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_5_4 = self:getViewComponent()

		var_5_4:UpdateSourceEquipmentPaths()
		var_5_4:UpdateSort()
		var_5_4:UpdateSourceList()
		var_5_4:UpdateFormula()
	elseif var_5_0 == GAME.UNEQUIP_FROM_SHIP_DONE or var_5_0 == GAME.EQUIP_TO_SHIP_DONE then
		if self.stopUpdateView then
			return
		end

		local var_5_5 = self.contextData.sourceEquipmentInstance

		if self.contextData.sourceEquipmentInstance and var_5_5.type == DROP_TYPE_EQUIP then
			local var_5_6 = var_5_1:getEquip(var_5_5.template.shipPos)

			if var_5_5.template.shipId == var_5_1.id and (not var_5_6 or var_5_6.id ~= var_5_5.id) then
				self.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_5_7 = self:getViewComponent()

		var_5_7:UpdateSourceEquipmentPaths()
		var_5_7:UpdateSort()
		var_5_7:UpdateSourceList()
		var_5_7:UpdateFormula()
	elseif var_5_0 == GAME.TRANSFORM_EQUIPMENT_DONE or var_5_0 == GAME.TRANSFORM_EQUIPMENT_FAIL then
		self.stopUpdateView = false

		local var_5_8 = self:getViewComponent()

		var_5_8:UpdateSourceEquipmentPaths()
		var_5_8:UpdateSort()
		var_5_8:UpdateSourceList()
		var_5_8:UpdateFormula()
	end

	return
end

return EquipmentTraceBackMediator
