local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_YoungAct_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			-- block empty
		end
	end,
	on_S2C_YoungAct_UpdateInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			-- block empty
		end
	end,
	on_S2C_YoungAct_SignIn = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			-- block empty
		end
	end,
	on_S2C_YoungAct_ReceiveStageReward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			-- block empty
		end
	end,
	on_S2C_YoungAct_StoreExchange = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			-- block empty
		end
	end,
	on_S2C_YoungAct_TokenExchange = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			-- block empty
		end
	end,
	on_S2C_YoungAct_ReceiveTimerGift = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			-- block empty
		end
	end,
	on_S2C_YoungAct_NotifyTask = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			-- block empty
		end
	end
}
