local var_0_0 = {}
local ProtoHandler = import(".ProtoHandler")

function var_0_0.on_S2C_Rerun_GetInfo(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		g.core.model.User.activityReturnData:onS2CRerunGetInfo(arg_1_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RERUN_GETINFO, false, arg_1_1, arg_1_2)
	end
end

function var_0_0.on_S2C_Rerun_ChooseAward(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		g.core.model.User.activityReturnData:onS2CRerunChooseAward(arg_2_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RERUN_CHOOSEAWARD, false, arg_2_1, arg_2_2)
	end
end

function var_0_0.on_S2C_Rerun_Draw(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		g.core.model.User.activityReturnData:onS2CRerunDraw(arg_3_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RERUN_DRAW, false, arg_3_1, arg_3_2)
	end
end

function var_0_0.on_S2C_Rerun_TaskAward(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		g.core.model.User.activityReturnData:onS2CRerunTaskAward(arg_4_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RERUN_TASKAWARD, false, arg_4_1, arg_4_2)
	end
end

return var_0_0
