local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_HallOfFame_Rank = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.hallOfFameData:updateRankInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HALL_OF_FAME_RANK, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_HallOfFame_Like = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.hallOfFameData:updateLikesInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HALL_OF_FAME_LIKE, false, arg_2_1, arg_2_2)
		end
	end
}
