local var_0_0 = class("AppreciatePicViewMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.UPDATE_LOADING_PIC_DONE,
		GAME.APPRECIATE_GALLERY_LIKE_DONE,
		GAME.APPRECIATE_MANGA_LIKE_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == GAME.UPDATE_LOADING_PIC_DONE or var_3_0 == GAME.APPRECIATE_GALLERY_LIKE_DONE or var_3_0 == GAME.APPRECIATE_MANGA_LIKE_DONE then
		arg_3_0.viewComponent:updatePanel()
	end

	return
end

return var_0_0
