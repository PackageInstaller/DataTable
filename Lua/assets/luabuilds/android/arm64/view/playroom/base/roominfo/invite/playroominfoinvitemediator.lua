local var_0_0 = class("PlayRoomInfoInviteMediator", import("view.base.ContextMediator"))

var_0_0.ON_CLICK_INVITE = "PlayRoomInfoInviteMediator::ON_CLICK_INVITE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_CLICK_INVITE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_INVITE, arg_2_1)

		return
	end)
	getProxy(PlayRoomProxy):GetInviteRecordList()

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.PLAY_ROOM_INVITE_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	switch(arg_4_1:getName(), {
		[GAME.PLAY_ROOM_INVITE_DONE] = function(arg_5_0)
			arg_4_0.viewComponent:RefreshItem()

			return
		end
	})

	return
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
