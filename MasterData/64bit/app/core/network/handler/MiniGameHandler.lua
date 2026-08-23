local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.themeData

return {
	on_S2C_MiniGame_Guess_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_1:getThemeData(arg_1_2.id)

			if var_1_0 then
				var_1_0:getThemeGuessData():on_S2C_Guess_GetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINI_GAME_GUESS_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_MiniGame_Guess_Result = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = var_0_1:getThemeData(arg_2_2.id)

			if var_2_0 then
				var_2_0:getThemeGuessData():onS2CGuessResult(arg_2_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINI_GAME_GUESS_RESULT, false, arg_2_1, arg_2_2)
		end
	end
}
