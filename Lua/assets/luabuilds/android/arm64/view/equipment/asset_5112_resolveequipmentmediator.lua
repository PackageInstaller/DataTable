local ResolveEquipmentMediator = class("ResolveEquipmentMediator", import("..base.ContextMediator"))

ResolveEquipmentMediator.ON_RESOLVE = "ResolveEquipmentMediator:ON_RESOLVE"

function ResolveEquipmentMediator:register()
	self:bind(ResolveEquipmentMediator.ON_RESOLVE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.DESTROY_EQUIPMENTS, {
			equipments = arg_2_1
		})

		return
	end)
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	assert(self.contextData.Equipments, "equipmentVOs can not be nil")
	self.viewComponent:setEquipments(self.contextData.Equipments)

	return
end

function ResolveEquipmentMediator:listNotificationInterests()
	return {
		GAME.DESTROY_EQUIPMENTS_DONE,
		GAME.CANCEL_LIMITED_OPERATION
	}
end

function ResolveEquipmentMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.DESTROY_EQUIPMENTS_DONE then
		self.viewComponent:HideDestroyCondirm()

		local var_4_2 = getProxy(ContextProxy):getCurrentContext()

		if var_4_2 and var_4_2.mediator.__cname ~= "EquipmentMediator" and table.getCount(var_4_1) ~= 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_4_1,
				title = AwardInfoLayer.TITLE.ITEM,
				removeFunc = function()
					self.viewComponent:OnResolveEquipDone()

					return
				end
			})
		else
			self.viewComponent:OnResolveEquipDone()
		end
	elseif var_4_0 == GAME.CANCEL_LIMITED_OPERATION then
		-- block empty
	end

	return
end

return ResolveEquipmentMediator
