local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_UniteToken_GetAttribute = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.uniteTokenData:updateTokenAttr(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_GETATTRIBUTE, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_UniteToken_Awaken = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.uniteTokenData:updateTokenAwaken(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_AWAKEN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_UniteToken_Upgrade = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.uniteTokenData:opUpdateUniteToken(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_UPGRADE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_UniteToken_OneKey_Upgrade = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_ONEKEY_UPGRADE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_UniteToken_StarIncrease = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.uniteTokenData:opUpdateUniteToken(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_STARINCREASE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_UniteToken_RunesActivate = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_RUNESACTIVATE, false, arg_6_1, arg_6_2)
		end
	end
}
