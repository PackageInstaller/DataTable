class = var_0_10000

local var_0_0 = "EmojiMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	EmojiProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	if not var_1.getInitedTag(var_1_0) then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.sendNotification

		GAME = var_1_10005

		var_1_2(var_1_1, var_1_10005.REQUEST_EMOJI_INFO_FROM_SERVER)
	end

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.REQUEST_EMOJI_INFO_FROM_SERVER_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	return
end

return var_0_1
