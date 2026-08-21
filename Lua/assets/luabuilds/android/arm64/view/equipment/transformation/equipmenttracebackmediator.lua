local var_0_0 = class("EquipmentTraceBackMediator", import("view.base.ContextMediator"))

var_0_0.TRANSFORM_EQUIP = "transform equip"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.env = {}

	arg_1_0:getViewComponent():SetEnv(arg_1_0.env)
	assert(arg_1_0.contextData.TargetEquipmentId, "Should Set TargetEquipment First")

	arg_1_0.env.tracebackHelper = getProxy(EquipmentProxy):GetWeakEquipsDict()

	arg_1_0:getViewComponent():UpdatePlayer(getProxy(PlayerProxy):getData())

	arg_1_0.stopUpdateView = false

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.TRANSFORM_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0.stopUpdateView = true

		arg_2_0:sendNotification(GAME.TRANSFORM_EQUIPMENT, {
			candicate = arg_3_1,
			formulaIds = arg_3_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
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

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == PlayerProxy.UPDATED then
		arg_5_0:getViewComponent():UpdatePlayer(var_5_1)
	elseif var_5_0 == BagProxy.ITEM_UPDATED then
		if arg_5_0.stopUpdateView then
			return
		end

		local var_5_2 = arg_5_0:getViewComponent()

		var_5_2:UpdateSort()
		var_5_2:UpdateSourceList()
		var_5_2:UpdateFormula()
	elseif var_5_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		if arg_5_0.stopUpdateView then
			return
		end

		if arg_5_0.contextData.sourceEquipmentInstance then
			local var_5_3 = arg_5_0.contextData.sourceEquipmentInstance

			if var_5_1.count == 0 and var_5_3.type == DROP_TYPE_EQUIP and EquipmentProxy.SameEquip(var_5_1, var_5_3.template) then
				arg_5_0.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_5_4 = arg_5_0:getViewComponent()

		var_5_4:UpdateSourceEquipmentPaths()
		var_5_4:UpdateSort()
		var_5_4:UpdateSourceList()
		var_5_4:UpdateFormula()
	elseif var_5_0 == GAME.UNEQUIP_FROM_SHIP_DONE or var_5_0 == GAME.EQUIP_TO_SHIP_DONE then
		if arg_5_0.stopUpdateView then
			return
		end

		local var_5_5 = arg_5_0.contextData.sourceEquipmentInstance

		if arg_5_0.contextData.sourceEquipmentInstance and var_5_5.type == DROP_TYPE_EQUIP then
			local var_5_6 = var_5_1:getEquip(var_5_5.template.shipPos)

			if var_5_5.template.shipId == var_5_1.id and (not var_5_6 or var_5_6.id ~= var_5_5.id) then
				arg_5_0.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_5_7 = arg_5_0:getViewComponent()

		var_5_7:UpdateSourceEquipmentPaths()
		var_5_7:UpdateSort()
		var_5_7:UpdateSourceList()
		var_5_7:UpdateFormula()
	elseif var_5_0 == GAME.TRANSFORM_EQUIPMENT_DONE or var_5_0 == GAME.TRANSFORM_EQUIPMENT_FAIL then
		arg_5_0.stopUpdateView = false

		local var_5_8 = arg_5_0:getViewComponent()

		var_5_8:UpdateSourceEquipmentPaths()
		var_5_8:UpdateSort()
		var_5_8:UpdateSourceList()
		var_5_8:UpdateFormula()
	end

	return
end

return var_0_0
