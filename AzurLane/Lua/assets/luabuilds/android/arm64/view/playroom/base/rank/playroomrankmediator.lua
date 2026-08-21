local var_0_0 = class("PlayRoomRankMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:sendNotification(GAME.PLAY_ROOM_REFRESH_RANK, {
		gameType = arg_1_0.contextData.gameType
	})

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.PLAY_ROOM_REFRESH_RANK_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	switch(arg_3_1:getName(), {
		[GAME.PLAY_ROOM_REFRESH_RANK_DONE] = function(arg_4_0)
			arg_3_0.viewComponent:RefreshUI()

			return
		end
	})

	return
end

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
