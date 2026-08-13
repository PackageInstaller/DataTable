class = var_0_10000

local var_0_0 = "PlayRoomRankMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.sendNotification

	GAME = var_1_10003

	var_1_1(var_1_0, var_1_10003.PLAY_ROOM_REFRESH_RANK, {
		gameType = arg_1_0.contextData.gameType
	})

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.PLAY_ROOM_REFRESH_RANK_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	switch = var_3_1

	local var_3_3 = var_3_0
	local var_3_4 = {}

	GAME = var_1_10007
	var_3_4[var_1_10007.PLAY_ROOM_REFRESH_RANK_DONE] = function(arg_4_0)
		local var_4_0 = arg_3_0.viewComponent

		var_1.RefreshUI(var_4_0)

		return
	end

	var_3_1(var_3_3, var_3_4)

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
