local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_BgBook_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.userActiveSceneData:updateActiveSceneData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_LEVELUP, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_BgBook_SetUse = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BG_BOOK_SETUSE, false, arg_2_1, arg_2_2)
		end
	end
}
