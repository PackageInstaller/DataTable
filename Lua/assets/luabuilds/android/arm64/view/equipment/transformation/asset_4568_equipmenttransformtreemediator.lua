local EquipmentTransformTreeMediator = class("EquipmentTransformTreeMediator", import("view.base.ContextMediator"))

EquipmentTransformTreeMediator.OPEN_LAYER = "OPEN_LAYER"

function EquipmentTransformTreeMediator:register()
	self:BindEvent()

	self.env = {}

	self:getViewComponent():SetEnv(self.env)

	self.env.tracebackHelper = getProxy(EquipmentProxy):GetWeakEquipsDict()
	self.env.nationsTree = EquipmentProxy.EquipmentTransformTreeTemplate

	return
end

function EquipmentTransformTreeMediator:BindEvent()
	self:bind(EquipmentTransformTreeMediator.OPEN_LAYER, function(arg_3_0, ...)
		self:addSubLayers(...)

		return
	end)

	return
end

function EquipmentTransformTreeMediator:listNotificationInterests()
	return {
		GAME.TRANSFORM_EQUIPMENT_DONE,
		PlayerProxy.UPDATED,
		BagProxy.ITEM_UPDATED,
		EquipmentProxy.EQUIPMENT_UPDATED,
		EquipmentTransformMediator.UPDATE_NEW_FLAG
	}
end

function EquipmentTransformTreeMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == PlayerProxy.UPDATED or var_5_0 == BagProxy.ITEM_UPDATED then
		self:getViewComponent():UpdateItemNodes()
	elseif var_5_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		if var_5_1.count == 0 then
			self:getViewComponent():UpdateItemNodes()
		end
	elseif var_5_0 == EquipmentTransformMediator.UPDATE_NEW_FLAG then
		self:getViewComponent():UpdateItemNodeByID(var_5_1)
	end

	return
end

return EquipmentTransformTreeMediator
