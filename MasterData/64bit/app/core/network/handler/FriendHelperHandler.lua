local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.fogNightmareData
local var_0_2 = g.core.model.User.explorationData
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum

return {
	on_S2C_FriendHelper_GetKnights = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if arg_1_2.play_type == 0 then
				var_0_1:onS2CFriendHelperGetKnights(arg_1_2)
			elseif arg_1_2.play_type == 1 then
				var_0_2:getFormationData():onS2CFriendHelperGetKnights(arg_1_2)
			end

			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_FRIEND_HELPER_GETKNIGHTS, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_FriendHelper_SetKnights = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			if arg_2_2.play_type == 0 then
				var_0_1:onS2CFriendHelperSetKnights(arg_2_2)
			elseif arg_2_2.play_type == 1 then
				var_0_2:getFormationData():onS2CFriendHelperSetKnights(arg_2_2)
			end

			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_FRIEND_HELPER_SETKNIGHTS, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_FriendHelper_ShowSetKnights = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			if arg_3_2.play_type == 0 then
				var_0_1:onS2CFriendHelperShowKnights(arg_3_2)
			elseif arg_3_2.play_type == 1 then
				var_0_2:getFormationData():onS2CFriendHelperShowSetKnights(arg_3_2)
			end

			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_FRIEND_HELPER_SHOWSETKNIGHTS, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_FriendHelper_UseKnights = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			if arg_4_2.play_type == 1 then
				var_0_2:getFormationData():onS2CFriendHelperUseKnights(arg_4_2)
			end

			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_FRIEND_HELPER_USEKNIGHTS, false, arg_4_1, arg_4_2)
		end
	end
}
