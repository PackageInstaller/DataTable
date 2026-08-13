class = var_0_10000

local var_0_0 = "PlayRoomInfoViewerMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_CLICK_SWITCH = "PlayRoomInfoViewerMediator::ON_CLICK_SWITCH"
var_0_1.ON_CLICK_KICK = "PlayRoomInfoViewerMediator::ON_CLICK_KICK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_CLICK_SWITCH, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.PLAY_ROOM_SWITCH_VIEWER, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_KICK, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.PLAY_ROOM_KICK, arg_3_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.PLAY_ROOM_SWITCH_VIEWER_DONE
	GAME = var_2
	var_4_0[2] = var_2.PLAY_ROOM_KICK_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	switch = var_5_0

	local var_5_3 = var_5_1
	local var_5_4 = {}

	GAME = var_1_10008
	var_5_4[var_1_10008.PLAY_ROOM_SWITCH_VIEWER_DONE] = function()
		local var_6_0 = arg_5_0.viewComponent

		var_0.RefreshUI(var_6_0)

		return
	end
	GAME = var_8
	var_5_4[var_8.PLAY_ROOM_KICK_DONE] = function()
		local var_7_0 = arg_5_0.viewComponent

		var_0.RefreshUI(var_7_0)

		return
	end

	var_5_0(var_5_3, var_5_4)

	return
end

function var_0_1.remove(arg_8_0)
	return
end

return var_0_1
