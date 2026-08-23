local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.model.User.activityCelebrationLoginData

function var_0_1.on_S2C_CelebrationLogin_GetInfo(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		var_0_4:onS2CCelebrationLoginGetInfo(arg_1_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CELEBRATION_LOGIN_GETINFO, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_CelebrationLogin_SignReward(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		var_0_4:onS2CCelebrationLoginSignReward(arg_2_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CELEBRATION_LOGIN_SIGNREWARD, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_CelebrationLogin_DrawGift(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		var_0_4:onS2CCelebrationLoginDrawGift(arg_3_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CELEBRATION_LOGIN_DRAWGIFT, false, arg_3_1, arg_3_2)
	end
end

function var_0_1.on_S2C_CelebrationLogin_NoticeActivity(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		var_0_4:onRecvActNotice(arg_4_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CELEBRATION_LOGIN_NOTICEACTIVITY, false, arg_4_1, arg_4_2)
	end
end

return var_0_1
