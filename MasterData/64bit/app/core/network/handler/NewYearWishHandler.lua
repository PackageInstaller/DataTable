local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.newYearWishData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

return {
	on_S2C_NewYearWish_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CNewYearWishGetInfo(arg_1_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_NEW_YEAR_WISH_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_NewYearWish_Draw = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CNewYearWishDraw(arg_2_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_NEW_YEAR_WISH_DRAW, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_NewYearWish_Award = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CNewYearWishAward(arg_3_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_NEW_YEAR_WISH_AWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_NewYearWish_Pay = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_NEW_YEAR_WISH_AWARD, false, arg_4_1, arg_4_2)
		end
	end
}
