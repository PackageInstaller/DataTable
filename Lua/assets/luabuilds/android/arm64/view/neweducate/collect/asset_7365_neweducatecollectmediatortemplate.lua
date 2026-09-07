local EducateCollectMediatorTemplate = class("EducateCollectMediatorTemplate", import("view.base.ContextMediator"))

function EducateCollectMediatorTemplate:register()
	return
end

function EducateCollectMediatorTemplate:listNotificationInterests()
	return {}
end

function EducateCollectMediatorTemplate:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateCollectMediatorTemplate
