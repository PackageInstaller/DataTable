local GalleryFullScreenMediator = class("GalleryFullScreenMediator", import("..base.ContextMediator"))

function GalleryFullScreenMediator:register()
	return
end

function GalleryFullScreenMediator:listNotificationInterests()
	return {}
end

function GalleryFullScreenMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return GalleryFullScreenMediator
