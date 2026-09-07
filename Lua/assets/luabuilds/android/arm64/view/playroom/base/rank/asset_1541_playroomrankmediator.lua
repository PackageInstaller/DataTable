local PlayRoomRankMediator = class("PlayRoomRankMediator", import("view.base.ContextMediator"))

function PlayRoomRankMediator:register()
	self:sendNotification(GAME.PLAY_ROOM_REFRESH_RANK, {
		gameType = self.contextData.gameType
	})

	return
end

function PlayRoomRankMediator:listNotificationInterests()
	return {
		GAME.PLAY_ROOM_REFRESH_RANK_DONE
	}
end

function PlayRoomRankMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	switch(arg_3_1:getName(), {
		[GAME.PLAY_ROOM_REFRESH_RANK_DONE] = function(arg_4_0)
			self.viewComponent:RefreshUI()

			return
		end
	})

	return
end

function PlayRoomRankMediator:remove()
	return
end

return PlayRoomRankMediator
