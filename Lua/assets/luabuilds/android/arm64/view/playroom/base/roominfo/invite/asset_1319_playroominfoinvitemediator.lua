local PlayRoomInfoInviteMediator = class("PlayRoomInfoInviteMediator", import("view.base.ContextMediator"))

PlayRoomInfoInviteMediator.ON_CLICK_INVITE = "PlayRoomInfoInviteMediator::ON_CLICK_INVITE"

function PlayRoomInfoInviteMediator:register()
	self:bind(PlayRoomInfoInviteMediator.ON_CLICK_INVITE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.PLAY_ROOM_INVITE, arg_2_1)

		return
	end)
	getProxy(PlayRoomProxy):GetInviteRecordList()

	return
end

function PlayRoomInfoInviteMediator:listNotificationInterests()
	return {
		GAME.PLAY_ROOM_INVITE_DONE
	}
end

function PlayRoomInfoInviteMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	switch(arg_4_1:getName(), {
		[GAME.PLAY_ROOM_INVITE_DONE] = function(arg_5_0)
			self.viewComponent:RefreshItem()

			return
		end
	})

	return
end

function PlayRoomInfoInviteMediator:remove()
	return
end

return PlayRoomInfoInviteMediator
