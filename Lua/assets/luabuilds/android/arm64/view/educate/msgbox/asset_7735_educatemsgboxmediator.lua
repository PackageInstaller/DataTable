local EducateMsgBoxMediator = class("EducateMsgBoxMediator", import("..base.EducateContextMediator"))

function EducateMsgBoxMediator:register()
	return
end

function EducateMsgBoxMediator:listNotificationInterests()
	return {}
end

function EducateMsgBoxMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateMsgBoxMediator
