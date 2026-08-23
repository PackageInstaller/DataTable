local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.model.User.furnitureData
local var_0_3 = g.core.model.User.hlTrainData
local DebugOneKeyRoom = class("DebugOneKeyRoom", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyRoom:initData()
	self._oneKeyName = "一键生产平台派遣"
	self._needAddEventList = {
		[g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO] = handler(self, self._onS2CDispatchRoom),
		[g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH] = handler(self, self._onS2CDispatchRoom),
		[g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCHAWARD] = handler(self, self._onS2CGetAllAward)
	}
end

function DebugOneKeyRoom:doOneKey()
	if not self._isGetInfo then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_HomeLandTrain_GetInfo({})
		end)

		return
	end

	local var_2_0 = var_0_3:getUnlockedRoomStructArr()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		if not iter_2_1:isWorking() then
			local var_2_1, var_2_2 = self:getRecommendKnightIdDict(iter_2_1)

			if var_2_2 then
				self:send(function()
					g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Dispatch({
						dispatch = var_2_1
					})
				end)

				return
			end
		end
	end

	local var_2_3 = {}

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		if iter_2_3:isExistAward() then
			table.insert(var_2_3, iter_2_3.advanceId)
		end
	end

	if #var_2_3 > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_HomeLandTrain_DispatchAward({
				adv_id = var_2_3
			})
		end)

		return
	end

	self._isFinish = true
end

function DebugOneKeyRoom:_onS2CDispatchRoom(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._isGetInfo = true

	local var_6_0 = "信息更新中"

	if arg_6_4 then
		local var_6_1 = arg_6_4.dispatch.adv_id or 0

		var_6_0 = var_6_1 > 0 and var_0_3:getRoomStruct(var_6_1).refCfgBaseInfo.name .. " 派遣成功" or "没找到房间"
	end

	return var_6_0
end

function DebugOneKeyRoom:_onS2CGetAllAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return "快速收集成功"
end

function DebugOneKeyRoom:getRecommendKnightIdDict(arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.knightIdArr) do
		if var_0_1:getKnightById(iter_8_1):getMobilityVal() > 0 then
			var_8_0 = var_8_0 + 1
		end
	end

	local var_8_1 = math.min(HLTrainConst.ROOM_MAX_DISPATCH_NUM, arg_8_1.refCfgInfo.limit_dispatch) - var_8_0
	local var_8_2

	if var_8_1 < 1 then
		do return {} end

		var_8_2 = {}
	end

	for iter_8_2, iter_8_3 in ipairs((var_0_1:getSpList(function(arg_9_0)
		return arg_9_0:isCanBeDispatched()
	end))) do
		local var_8_3 = iter_8_3:getServerId()

		if not var_0_2:isKnightCheckIn(var_8_3) and not var_0_3:isKnightDispatched(var_8_3) and iter_8_3:getMobilityVal() > iter_8_3:getMaxMobility() * 0.35 then
			table.insert(var_8_2, iter_8_3)
		end
	end

	local var_8_4 = {}
	local var_8_5 = #var_8_2

	if var_8_1 < #var_8_2 then
		for iter_8_4 = 1, var_8_1 do
			var_8_4[var_8_2[iter_8_4]:getServerId()] = true
		end
	else
		for iter_8_5, iter_8_6 in ipairs(var_8_2) do
			var_8_4[iter_8_6:getServerId()] = true
		end
	end

	return {
		{
			adv_id = arg_8_1.advanceId,
			knight_ids = table.keys(var_8_4)
		}
	}, var_8_5 > 0
end

return DebugOneKeyRoom
