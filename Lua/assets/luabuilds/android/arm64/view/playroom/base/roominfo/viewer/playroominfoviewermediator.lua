local var_0_0 = class("PlayRoomInfoViewerMediator", import("view.base.ContextMediator"))

var_0_0.ON_CLICK_SWITCH = "PlayRoomInfoViewerMediator::ON_CLICK_SWITCH"
var_0_0.ON_CLICK_KICK = "PlayRoomInfoViewerMediator::ON_CLICK_KICK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_CLICK_SWITCH, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_SWITCH_VIEWER, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CLICK_KICK, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_KICK, arg_3_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.PLAY_ROOM_SWITCH_VIEWER_DONE,
		GAME.PLAY_ROOM_KICK_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	switch(arg_5_1:getName(), {
		[GAME.PLAY_ROOM_SWITCH_VIEWER_DONE] = function()
			arg_5_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_KICK_DONE] = function()
			arg_5_0.viewComponent:RefreshUI()

			return
		end
	})

	return
end

function var_0_0.remove(arg_8_0)
	return
end

return var_0_0
