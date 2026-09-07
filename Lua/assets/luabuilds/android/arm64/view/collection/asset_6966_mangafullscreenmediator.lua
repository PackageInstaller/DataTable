local MangaFullScreenMediator = class("MangaFullScreenMediator", import("..base.ContextMediator"))

function MangaFullScreenMediator:register()
	return
end

function MangaFullScreenMediator:listNotificationInterests()
	return {
		GAME.APPRECIATE_MANGA_READ_DONE,
		GAME.APPRECIATE_MANGA_LIKE_DONE,
		GAME.UPDATE_LOADING_PIC_DONE
	}
end

function MangaFullScreenMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()

	if var_3_0 == GAME.APPRECIATE_MANGA_READ_DONE then
		if self.contextData.mangaContext then
			self.contextData.mangaContext:updateLineAfterRead(arg_3_1:getBody().mangaID)
		end
	elseif var_3_0 == GAME.APPRECIATE_MANGA_LIKE_DONE then
		self.viewComponent:updateLikeBtn()
	elseif var_3_0 == GAME.UPDATE_LOADING_PIC_DONE then
		self.viewComponent:updateLoadingBtn()
	end

	return
end

return MangaFullScreenMediator
