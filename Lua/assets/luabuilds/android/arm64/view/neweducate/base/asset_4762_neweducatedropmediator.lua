local EducateAwardInfoMediator = class("EducateAwardInfoMediator", import("view.newEducate.base.NewEducateContextMediator"))

function EducateAwardInfoMediator:register()
	return
end

function EducateAwardInfoMediator:listNotificationInterests()
	return {}
end

function EducateAwardInfoMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateAwardInfoMediator
