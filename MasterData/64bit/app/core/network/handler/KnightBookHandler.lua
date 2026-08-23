local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_KnightBook_Activate = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.handBookData:setKnightBookActivate(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_ACTIVATE, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_KnightBook_Info = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.handBookData:setAllActiveKnightData(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_INFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_KnightBook_Upgrade = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.handBookData:setKnightBookLevel(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_UPGRADE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_KnightBook_GetInfo = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_GETINFO, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_KnightBook_GetAward = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_GETAWARD, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_KnightBook_SyncTask = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_SYNCTASK, false, arg_6_1, arg_6_2)
		end
	end
}
