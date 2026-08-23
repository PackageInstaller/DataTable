local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Questionnaire_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.questionnaireData:updateQuestionData(arg_1_2)
			g.core.model.User.UserTitleData:setMenuData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_QUESTIONNAIRE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Questionnaire_Notify = function(arg_2_0, arg_2_1, arg_2_2)
		g.core.network.GameNetProxy:send_C2S_Questionnaire_GetInfo({})
	end
}
