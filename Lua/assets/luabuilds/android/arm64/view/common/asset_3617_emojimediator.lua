local EmojiMediator = class("EmojiMediator", import("..base.ContextMediator"))

function EmojiMediator:register()
	if not getProxy(EmojiProxy):getInitedTag() then
		self:sendNotification(GAME.REQUEST_EMOJI_INFO_FROM_SERVER)
	end

	return
end

function EmojiMediator:listNotificationInterests()
	return {
		GAME.REQUEST_EMOJI_INFO_FROM_SERVER_DONE
	}
end

function EmojiMediator:handleNotification(arg_3_1)
	return
end

return EmojiMediator
