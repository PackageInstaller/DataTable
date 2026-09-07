local AppreciatePicViewMediator = class("AppreciatePicViewMediator", import("..base.ContextMediator"))

function AppreciatePicViewMediator:register()
	return
end

function AppreciatePicViewMediator:listNotificationInterests()
	return {
		GAME.UPDATE_LOADING_PIC_DONE,
		GAME.APPRECIATE_GALLERY_LIKE_DONE,
		GAME.APPRECIATE_MANGA_LIKE_DONE
	}
end

function AppreciatePicViewMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == GAME.UPDATE_LOADING_PIC_DONE or var_3_0 == GAME.APPRECIATE_GALLERY_LIKE_DONE or var_3_0 == GAME.APPRECIATE_MANGA_LIKE_DONE then
		self.viewComponent:updatePanel()
	end

	return
end

return AppreciatePicViewMediator
