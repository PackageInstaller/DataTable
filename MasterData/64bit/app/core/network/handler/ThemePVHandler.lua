local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_ThemePV_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.plotReplayReviewData:initThemeDungeonSeenPv(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_PV_GETINFO, false, arg_1_1, arg_1_2)
		end
	end
}
