local var_0_0 = class("EquipmentTransformTreeMediator", import("view.base.ContextMediator"))

var_0_0.OPEN_LAYER = "OPEN_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.env = {}

	arg_1_0:getViewComponent():SetEnv(arg_1_0.env)

	arg_1_0.env.tracebackHelper = getProxy(EquipmentProxy):GetWeakEquipsDict()
	arg_1_0.env.nationsTree = EquipmentProxy.EquipmentTransformTreeTemplate

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.OPEN_LAYER, function(arg_3_0, ...)
		arg_2_0:addSubLayers(...)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.TRANSFORM_EQUIPMENT_DONE,
		PlayerProxy.UPDATED,
		BagProxy.ITEM_UPDATED,
		EquipmentProxy.EQUIPMENT_UPDATED,
		EquipmentTransformMediator.UPDATE_NEW_FLAG
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == PlayerProxy.UPDATED or var_5_0 == BagProxy.ITEM_UPDATED then
		arg_5_0:getViewComponent():UpdateItemNodes()
	elseif var_5_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		if var_5_1.count == 0 then
			arg_5_0:getViewComponent():UpdateItemNodes()
		end
	elseif var_5_0 == EquipmentTransformMediator.UPDATE_NEW_FLAG then
		arg_5_0:getViewComponent():UpdateItemNodeByID(var_5_1)
	end

	return
end

return var_0_0
