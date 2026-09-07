local PlayRoomInfoViewerMediator = class("PlayRoomInfoViewerMediator", import("view.base.ContextMediator"))

PlayRoomInfoViewerMediator.ON_CLICK_SWITCH = "PlayRoomInfoViewerMediator::ON_CLICK_SWITCH"
PlayRoomInfoViewerMediator.ON_CLICK_KICK = "PlayRoomInfoViewerMediator::ON_CLICK_KICK"

function PlayRoomInfoViewerMediator:register()
	self:bind(PlayRoomInfoViewerMediator.ON_CLICK_SWITCH, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.PLAY_ROOM_SWITCH_VIEWER, arg_2_1)

		return
	end)
	self:bind(PlayRoomInfoViewerMediator.ON_CLICK_KICK, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.PLAY_ROOM_KICK, arg_3_1)

		return
	end)

	return
end

function PlayRoomInfoViewerMediator:listNotificationInterests()
	return {
		GAME.PLAY_ROOM_SWITCH_VIEWER_DONE,
		GAME.PLAY_ROOM_KICK_DONE
	}
end

function PlayRoomInfoViewerMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	switch(arg_5_1:getName(), {
		[GAME.PLAY_ROOM_SWITCH_VIEWER_DONE] = function()
			self.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_KICK_DONE] = function()
			self.viewComponent:RefreshUI()

			return
		end
	})

	return
end

function PlayRoomInfoViewerMediator:remove()
	return
end

return PlayRoomInfoViewerMediator
