local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.furnitureData
local var_0_2 = g.core.model.User.hlTrainData

return {
	on_S2C_HomeLandTrain_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_2:onS2CHomeLandTrainGetInfo(arg_1_2)
			var_0_2:resetExpired()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO, false)
		end
	end,
	on_S2C_HomeLandTrain_Dispatch = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_2:onS2CHomeLandTrainDispatch(arg_2_2)
			var_0_1:onS2CHomeLandTrainDispatch(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH, false, arg_2_2)
		end
	end,
	on_S2C_HomeLandTrain_Product = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_2:onS2CHomeLandTrainProduct(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_PRODUCT, false, arg_3_2)
		end
	end,
	on_S2C_HomeLandTrain_DispatchAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_2:onS2CDispatchAward(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowReward = arg_4_2.awards
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCHAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_HomeLandTrain_UpLevel = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_2:onS2CHomeLandTrainUpLevel(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_UPLEVEL, false, arg_5_2)
		end
	end
}
