local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GuideTask_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.guideTaskData:updateInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUIDE_TASK_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuideTask_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.guideTaskData:updateAward(arg_2_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUIDE_TASK_AWARD, false, arg_2_1, arg_2_2)
		end
	end
}
