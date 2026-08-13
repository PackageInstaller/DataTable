class = var_0_10000

local var_0_0 = "PlayRoomInfoInviteMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_CLICK_INVITE = "PlayRoomInfoInviteMediator::ON_CLICK_INVITE"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_CLICK_INVITE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.PLAY_ROOM_INVITE, arg_2_1)

		return
	end)

	getProxy = var_1
	PlayRoomProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	var_1.GetInviteRecordList(var_1_1)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.PLAY_ROOM_INVITE_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	switch = var_4_1

	local var_4_3 = var_4_0
	local var_4_4 = {}

	GAME = var_1_10007
	var_4_4[var_1_10007.PLAY_ROOM_INVITE_DONE] = function(arg_5_0)
		local var_5_0 = arg_4_0.viewComponent

		var_1.RefreshItem(var_5_0)

		return
	end

	var_4_1(var_4_3, var_4_4)

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
