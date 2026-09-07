local MetaPTGetPreviewMediator = class("MetaPTGetPreviewMediator", import("...base.ContextMediator"))

function MetaPTGetPreviewMediator:register()
	return
end

function MetaPTGetPreviewMediator:listNotificationInterests()
	return {}
end

function MetaPTGetPreviewMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return MetaPTGetPreviewMediator
