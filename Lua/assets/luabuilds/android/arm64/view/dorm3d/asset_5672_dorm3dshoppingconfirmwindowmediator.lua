local Dorm3dShoppingConfirmWindowMediator = class("Dorm3dShoppingConfirmWindowMediator", import("view.base.ContextMediator"))

function Dorm3dShoppingConfirmWindowMediator:register()
	return
end

function Dorm3dShoppingConfirmWindowMediator:listNotificationInterests()
	return {}
end

function Dorm3dShoppingConfirmWindowMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == nil then
		-- block empty
	end

	return
end

function Dorm3dShoppingConfirmWindowMediator:remove()
	return
end

return Dorm3dShoppingConfirmWindowMediator
