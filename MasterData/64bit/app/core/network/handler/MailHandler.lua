local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Mail_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.translateData:loadTranslateCache()
			g.core.model.User.chatData:setPrivateChatCotent(arg_1_2)
			g.core.model.User.mailData:onMailInfoBack(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIL_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Mail_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.mailData:onAwardsMailBack(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIL_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Mail_Send = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIL_SEND, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Mail_Del = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.mailData:onDeleteMailBack(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIL_DEL, false, arg_4_1, arg_4_2)
		end
	end
}
