local Dorm3dFurnitureAcessesWindowMediator = class("Dorm3dFurnitureAcessesWindowMediator", import("view.base.ContextMediator"))

function Dorm3dFurnitureAcessesWindowMediator:register()
	return
end

function Dorm3dFurnitureAcessesWindowMediator:listNotificationInterests()
	return {}
end

function Dorm3dFurnitureAcessesWindowMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == nil then
		-- block empty
	end

	return
end

function Dorm3dFurnitureAcessesWindowMediator:remove()
	return
end

return Dorm3dFurnitureAcessesWindowMediator
