local var_0_0 = class("EmojiMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	if not getProxy(EmojiProxy):getInitedTag() then
		arg_1_0:sendNotification(GAME.REQUEST_EMOJI_INFO_FROM_SERVER)
	end

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.REQUEST_EMOJI_INFO_FROM_SERVER_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	return
end

return var_0_0
