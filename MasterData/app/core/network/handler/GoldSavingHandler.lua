local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GoldSaving_Flush = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.goldSavingData:updateGoldSavingData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_FLUSH, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GoldSaving_Pay = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.goldSavingData:updatePay(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_PAY, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GoldSaving_NotifyGameInfo = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.goldSavingData:addGameId(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_NOTIFYGAMEINFO, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GoldSaving_GameStart = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.goldSavingData:saveGameStartInfo(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMESTART, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GoldSaving_GameOver = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.goldSavingData:delGameId(arg_5_2.game_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMEOVER, false, arg_5_1, arg_5_2)
		end
	end
}
