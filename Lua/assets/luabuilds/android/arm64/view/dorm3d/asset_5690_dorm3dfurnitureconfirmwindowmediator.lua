local Dorm3dFurnitureConfirmWindowMediator = class("Dorm3dFurnitureConfirmWindowMediator", import("view.base.ContextMediator"))

function Dorm3dFurnitureConfirmWindowMediator:register()
	return
end

function Dorm3dFurnitureConfirmWindowMediator:listNotificationInterests()
	return {}
end

function Dorm3dFurnitureConfirmWindowMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == nil then
		-- block empty
	end

	return
end

function Dorm3dFurnitureConfirmWindowMediator:remove()
	return
end

return Dorm3dFurnitureConfirmWindowMediator
