local var_0_0 = g.core.const.ConstMgr.PARAMETER_CONST
local WorldRedPacketData = class("WorldRedPacketData", require("app.core.model.BaseData"))

function WorldRedPacketData:ctor()
	WorldRedPacketData.super.ctor(self)
	self:initData()
end

function WorldRedPacketData:initData()
	self._packetDataDict = {}
	self._leftCountDict = {}
	self._maxCountDict = {}
	self._blackList = {}
	self._isAutoGet = false

	self:initParameterData()
end

function WorldRedPacketData:initParameterData()
	self._maxCountDict[var_0_0.WORLD_RED_PACKET_COUNT] = tonumber(g.core.config.parameter_info.get(var_0_0.WORLD_RED_PACKET_COUNT).parameter)

	for iter_3_0, iter_3_1 in pairs(self._maxCountDict) do
		self._leftCountDict[iter_3_0] = iter_3_1
	end
end

function WorldRedPacketData:onS2CGetInfo(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.world_red_packets or {}) do
		self._packetDataDict[iter_4_1.id] = iter_4_1
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_1.left_times or {}) do
		self._leftCountDict[iter_4_3.id] = iter_4_3.num
	end

	self:resetExpired()
end

function WorldRedPacketData:resetDataWhenCrossDay()
	if self:isExpired() then
		for iter_5_0, iter_5_1 in pairs(self._maxCountDict) do
			self._leftCountDict[iter_5_0] = iter_5_1
		end
	end

	self:resetExpired()
end

function WorldRedPacketData:onS2CDetail(arg_6_1)
	local var_6_0 = arg_6_1.world_red_packet_detail or {}

	self._packetDataDict[var_6_0.world_red_packet.id] = var_6_0.world_red_packet
end

function WorldRedPacketData:onS2CAward(arg_7_1)
	local var_7_1 = (arg_7_1.world_red_packet_detail or {}).world_red_packet or {}

	self._packetDataDict[var_7_1.id] = var_7_1

	if not self:isSelfPacket(var_7_1.id) then
		local var_7_2 = self:getBaseInfo(var_7_1.id).get_limit

		self._leftCountDict[var_7_2] = not self._leftCountDict[var_7_2] and 0 or self._leftCountDict[var_7_2] - 1
	end
end

function WorldRedPacketData:getBaseInfo(arg_8_1)
	return g.core.config.redpacket_info.get(self:getPacketById(arg_8_1).base_id)
end

function WorldRedPacketData:onS2CNotify(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.world_red_packets or {}) do
		self._packetDataDict[iter_9_1.id] = iter_9_1
	end
end

function WorldRedPacketData:onS2CUseAdd(arg_10_1)
	local var_10_0 = arg_10_1.world_red_packet or {}

	self._packetDataDict[var_10_0.id] = var_10_0
end

function WorldRedPacketData:getPacketById(arg_11_1)
	return self._packetDataDict[arg_11_1]
end

function WorldRedPacketData:getPacketSendText(arg_12_1)
	local var_12_0 = self:getPacketById(arg_12_1)

	if not var_12_0 then
		return ""
	end

	if not var_12_0.content or var_12_0.content == "" then
		return g.core.lang:get(109059)
	else
		return var_12_0.content
	end
end

function WorldRedPacketData:isSelfPacket(arg_13_1)
	return self:isUserPacket(arg_13_1, g.core.model.User:getId())
end

function WorldRedPacketData:isUserPacket(arg_14_1, arg_14_2)
	local var_14_0 = self:getPacketById(arg_14_1)

	if not var_14_0 then
		return false
	end

	return arg_14_2 == var_14_0.from_user.id
end

function WorldRedPacketData:packetIsExpire(arg_15_1)
	local var_15_0 = self:getPacketById(arg_15_1)

	if not var_15_0 then
		return true
	end

	if g.core.common.ServerTime:getTime() >= var_15_0.due_time then
		return true
	end

	return false
end

function WorldRedPacketData:canGetPacket(arg_16_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WORLD_RED_PACKET) then
		return false
	end

	if self:packetIsExpire(arg_16_1) or self:isInBlackListByPacketId(arg_16_1) then
		return false
	end

	local var_16_0 = self:getPacketById(arg_16_1)

	if not (var_16_0.self_pick_point and var_16_0.self_pick_point > 0) then
		local var_16_1 = self:getBaseInfo(arg_16_1)

		if var_16_0.pick_num < var_16_1.limit_people and (self:isSelfPacket(arg_16_1) or self:getLeftCount(var_16_1.get_limit) > 0) then
			return true
		end
	end

	return false
end

function WorldRedPacketData:getPacketDict()
	return self._packetDataDict
end

function WorldRedPacketData:getLeftCount(arg_18_1)
	return self._leftCountDict[arg_18_1] or 0
end

function WorldRedPacketData:isAutoGet()
	return self._isAutoGet
end

function WorldRedPacketData:setAutoGet(arg_20_1)
	self._isAutoGet = arg_20_1
end

function WorldRedPacketData:setBlackList(arg_21_1)
	if self:getPacketById(arg_21_1) then
		self._blackList[arg_21_1] = true
	end
end

function WorldRedPacketData:hasCanGetPacket()
	for iter_22_0, iter_22_1 in pairs(self._packetDataDict) do
		if self:canGetPacket(iter_22_1.id) then
			return true
		end
	end
end

function WorldRedPacketData:isInBlackListByPacketId(arg_23_1)
	local var_23_0 = self:getPacketById(arg_23_1)

	if var_23_0 and self._blackList[arg_23_1] then
		return true
	end

	local var_23_1 = var_23_0.from_user.id
	local var_23_2 = g.core.model.User.friendData:getBlackList()

	if not var_23_2 then
		return false
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		if iter_23_1:getBasicInfo().id == var_23_1 then
			return true
		end
	end

	return false
end

return WorldRedPacketData
