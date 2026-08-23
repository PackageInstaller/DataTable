local ProtoHandler = import(".ProtoHandler")
local StormCityHandler = class("StormCityHandler")

function StormCityHandler:on_S2C_StormCity_Info(arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		g.core.model.User.stormCityData:updateInfo(arg_1_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_INFO, false, arg_1_1, arg_1_2)
	end
end

function StormCityHandler:on_S2C_StormCity_ChallengeBegin(arg_2_1, arg_2_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_CHALLENGEBEGIN, false, arg_2_1, arg_2_2)
end

function StormCityHandler:on_S2C_StormCity_ChallengeFinish(arg_3_1, arg_3_2)
	g.core.model.User.stormCityData:updateChallengeFinish(arg_3_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
end

function StormCityHandler:on_S2C_StormCity_GetLordAward(arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		g.core.model.User.stormCityData:updateLordReceiveTime((g.core.common.ServerTime:getTime()))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORDAWARD, false, arg_4_1, arg_4_2)
	end
end

function StormCityHandler:on_S2C_StormCity_GetRanklist(arg_5_1, arg_5_2)
	if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
		g.core.model.User.stormCityData:updateCityRankData(arg_5_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETRANKLIST, false, arg_5_1, arg_5_2)
	end
end

function StormCityHandler:on_S2C_StormCity_GetLord(arg_6_1, arg_6_2)
	if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
		g.core.model.User.stormCityData:updateGetLord(arg_6_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORD, false, arg_6_1, arg_6_2)
	end
end

function StormCityHandler:on_S2C_StormCity_LordHistorys(arg_7_1, arg_7_2)
	if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
		g.core.model.User.stormCityData:updateLordHistory(arg_7_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_LORDHISTORYS, false, arg_7_1, arg_7_2)
	end
end

function StormCityHandler:on_S2C_StormCity_LordAchiveChange(arg_8_1, arg_8_2)
	if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
		g.core.model.User.stormCityData:updateLordAchievePoint(arg_8_2.point)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_LORDACHIVECHANGE, false, arg_8_1, arg_8_2)
	end
end

function StormCityHandler:on_S2C_StormCity_GetLordAchive(arg_9_1, arg_9_2)
	if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
		g.core.model.User.stormCityData:updateLordAchieve(arg_9_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORDACHIVE, false, arg_9_1, arg_9_2)
	end
end

function StormCityHandler:on_S2C_StormCity_GetLordAchiveAward(arg_10_1, arg_10_2)
	if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
		g.core.model.User.stormCityData:updateGetLordAchieveAward(arg_10_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORDACHIVEAWARD, false, arg_10_1, arg_10_2)
	end
end

function StormCityHandler:on_S2C_StormCity_GetMaxLordAward(arg_11_1, arg_11_2)
	if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
		g.core.model.User.stormCityData:updateMaxLordAward()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETMAXLORDAWARD, false, arg_11_1, arg_11_2)
	end
end

return StormCityHandler
