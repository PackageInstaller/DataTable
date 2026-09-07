local EducateCharProfileMediator = class("EducateCharProfileMediator", import("view.base.ContextMediator"))

function EducateCharProfileMediator:register()
	return
end

function EducateCharProfileMediator:listNotificationInterests()
	return {}
end

function EducateCharProfileMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateCharProfileMediator
