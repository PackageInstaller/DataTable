local MetaPTAwardPreviewMediator = class("MetaPTAwardPreviewMediator", import("...base.ContextMediator"))

function MetaPTAwardPreviewMediator:register()
	return
end

function MetaPTAwardPreviewMediator:listNotificationInterests()
	return {}
end

function MetaPTAwardPreviewMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return MetaPTAwardPreviewMediator
