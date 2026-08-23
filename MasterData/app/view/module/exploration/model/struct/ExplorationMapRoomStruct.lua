local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationBuildConfig = require("app.view.module.exploration.const.ExplorationBuildConfig")
local ExplorationTiledStruct = require("app.view.module.exploration.model.struct.ExplorationTiledStruct")
local ExplorationMapRoomStruct = class("ExplorationMapRoomStruct")

function ExplorationMapRoomStruct:ctor(arg_1_1)
	self._cfg = arg_1_1
	self._mapRoomId = arg_1_1.room
	self._roomId = arg_1_1.room_id
	self._coordinate = cc.p(arg_1_1.room_x, arg_1_1.room_y)
	self._worldPosition = cc.p(0, 0)
	self._worldPositionMid = cc.p(0, 0)
	self._state = ExplorationConst.MAP.ROOM_STATE_LOCK

	if arg_1_1.birth_point == 1 then
		self._state = ExplorationConst.MAP.ROOM_STATE_UNLOCK
	end

	self._barrierTiledPicDic = {}
	self._lockBarrierDic = {}
	self._roomTiledCfgDic = {}
	self._tiledStructTab = {}
	self._birthTiled = nil
	self._mirrorTiled = nil
	self._entranceList = {
		[ExplorationConst.DIRECTION.UP] = nil,
		[ExplorationConst.DIRECTION.DOWN] = nil,
		[ExplorationConst.DIRECTION.LEFT] = nil,
		[ExplorationConst.DIRECTION.RIGHT] = nil
	}
	self._guardList = {
		[ExplorationConst.DIRECTION.UP] = nil,
		[ExplorationConst.DIRECTION.DOWN] = nil,
		[ExplorationConst.DIRECTION.LEFT] = nil,
		[ExplorationConst.DIRECTION.RIGHT] = nil
	}

	self:_initRoomTiled()
end

function ExplorationMapRoomStruct:_initRoomTiled()
	for iter_2_0, iter_2_1 in pairs(ExplorationBuildConfig) do
		local var_2_0 = string.split(iter_2_0, "_")

		if tonumber(var_2_0[1]) == self._roomId then
			local var_2_1 = tonumber(var_2_0[2]) .. "_" .. tonumber(var_2_0[3])

			self._barrierTiledPicDic[var_2_1] = iter_2_1
			self._lockBarrierDic[var_2_1] = true
		end
	end

	for iter_2_2 = 1, g.core.config.exploration_room_info.getLength() do
		local var_2_2 = g.core.config.exploration_room_info.indexOf(iter_2_2)

		if var_2_2.room_id == self._roomId then
			local var_2_3 = ExplorationTiledStruct.new(var_2_2, self._cfg)

			var_2_3:setBelongRoom(self._mapRoomId)

			self._tiledStructTab[self:_getCoordinateKey(var_2_3:getCoordinate())] = var_2_3

			if self._cfg.birth_point == 1 and var_2_2.grid_type == ExplorationConst.GRID_TYPE.BIRTH then
				self._birthTiled = var_2_3
			elseif var_2_3:getEventType() == ExplorationConst.EVENT_TYPE.ULTIMATUM then
				self._mirrorTiled = var_2_3
			end
		end
	end

	for iter_2_3 = 0, 8 do
		for iter_2_4 = 0, 8 do
			if not self._tiledStructTab[iter_2_3 .. "_" .. iter_2_4] and not self._barrierTiledPicDic[iter_2_3 .. "_" .. iter_2_4] then
				self._barrierTiledPicDic[iter_2_3 .. "_" .. iter_2_4] = ""
				self._lockBarrierDic[iter_2_3 .. "_" .. iter_2_4] = true
			end
		end
	end
end

function ExplorationMapRoomStruct:getAllTiled()
	return self._tiledStructTab
end

function ExplorationMapRoomStruct:getTiledStruct(arg_4_1)
	return self._tiledStructTab[self:_getCoordinateKey(arg_4_1)]
end

function ExplorationMapRoomStruct:getBirthTiled()
	return self._birthTiled
end

function ExplorationMapRoomStruct:getMirrorTiled()
	return self._mirrorTiled
end

function ExplorationMapRoomStruct:getTileEntranceStruct(arg_7_1)
	return self:getTiledStruct(({
		cc.p(4, 0),
		cc.p(8, 4),
		cc.p(0, 4),
		(cc.p(4, 8))
	})[arg_7_1])
end

function ExplorationMapRoomStruct:getMapRoomId()
	return self._mapRoomId
end

function ExplorationMapRoomStruct:getRoomCoordinate()
	return self._cfg.room_x, self._cfg.room_y
end

function ExplorationMapRoomStruct:getRoomZOrder()
	return self._cfg.room_x + self._cfg.room_y
end

function ExplorationMapRoomStruct:_getCoordinateKey(arg_11_1)
	return arg_11_1.x .. "_" .. arg_11_1.y
end

function ExplorationMapRoomStruct:getCfg()
	return self._cfg
end

function ExplorationMapRoomStruct:setEntranceDirection(arg_13_1, arg_13_2)
	self._entranceList[arg_13_2] = arg_13_1
end

function ExplorationMapRoomStruct:getEntranceList(arg_14_1)
	local var_14_0 = self._entranceList

	if arg_14_1 then
		var_14_0 = {}

		for iter_14_0, iter_14_1 in pairs(ExplorationConst.DIRECTION) do
			if self._entranceList[iter_14_1] then
				table.insert(var_14_0, self._entranceList[iter_14_1])
			end
		end
	end

	return var_14_0
end

function ExplorationMapRoomStruct:setGuardDirection(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 == 0 then
		arg_15_1 = nil
	end

	self._guardList[arg_15_2] = arg_15_1

	if arg_15_3 then
		self:getTileEntranceStruct(arg_15_2):exchangeEventType(ExplorationConst.EVENT_TYPE.NONE)
	end
end

function ExplorationMapRoomStruct:checkAndInitGuardMonster()
	for iter_16_0, iter_16_1 in pairs(ExplorationConst.DIRECTION) do
		local var_16_0 = self:getTileEntranceStruct(iter_16_1)

		if self._guardList[iter_16_1] then
			if self._entranceList[iter_16_1] then
				local var_16_1 = self._entranceList[iter_16_1]:getCfg()

				if self._cfg.guard_level < var_16_1.guard_level then
					self:setGuardDirection(nil, iter_16_1)
					self:_replaceGuard(var_16_0)
				elseif self._cfg.guard_level == var_16_1.guard_level and self._mapRoomId > var_16_1.room then
					self:setGuardDirection(nil, iter_16_1)
					self:_replaceGuard(var_16_0)
				else
					var_16_0:setTiledMonster(self._guardList[iter_16_1], self._mapRoomId, iter_16_1)
				end
			else
				var_16_0:setTiledMonster(self._guardList[iter_16_1], self._mapRoomId, iter_16_1)
			end
		else
			self:_replaceGuard(var_16_0)
		end
	end
end

function ExplorationMapRoomStruct:_replaceGuard(arg_17_1)
	if arg_17_1:getEventType() == ExplorationConst.EVENT_TYPE.GUARD then
		arg_17_1:exchangeEventType(ExplorationConst.EVENT_TYPE.NONE)
	end

	if arg_17_1:getEventType() ~= ExplorationConst.EVENT_TYPE.ROBBER then
		arg_17_1:setTiledMonster(nil)
	end
end

function ExplorationMapRoomStruct:getGuardList(arg_18_1)
	local var_18_0 = self._guardList

	if arg_18_1 then
		var_18_0 = {}

		for iter_18_0, iter_18_1 in pairs(ExplorationConst.DIRECTION) do
			if self._guardList[iter_18_1] then
				table.insert(var_18_0, self._guardList[iter_18_1])
			end
		end
	end

	return var_18_0
end

function ExplorationMapRoomStruct:canMoveEntrance(arg_19_1)
	if not self._entranceList[arg_19_1] then
		return false
	end

	return self._guardList[arg_19_1] == nil
end

function ExplorationMapRoomStruct:canMove(arg_20_1)
	if self:getBarrierPicId(arg_20_1) ~= nil then
		return false
	end

	local var_20_0 = self:getTiledStruct(arg_20_1)

	if var_20_0 then
		local var_20_1 = var_20_0:getTiledMonster()
		local var_20_2 = var_20_0:getEventType()

		return ExplorationConst.MAP.TILED_STATE_UNLOCK == var_20_0:getState() and not var_20_1 and not (var_20_2 >= ExplorationConst.EVENT_TYPE.KNIGHT_SHOP and var_20_2 <= ExplorationConst.EVENT_TYPE.ARTIFACT_SHOP)
	end
end

function ExplorationMapRoomStruct:getBarrierPicId(arg_21_1)
	return self._barrierTiledPicDic[self:_getCoordinateKey(arg_21_1)]
end

function ExplorationMapRoomStruct:getAllBarrier()
	return self._barrierTiledPicDic
end

function ExplorationMapRoomStruct:setBarrierUnlock(arg_23_1)
	self._lockBarrierDic[self:_getCoordinateKey(arg_23_1)] = nil
end

function ExplorationMapRoomStruct:isBarrierUnlock(arg_24_1)
	return self._lockBarrierDic[self:_getCoordinateKey(arg_24_1)] == nil
end

function ExplorationMapRoomStruct:getRoomState()
	return self._state
end

function ExplorationMapRoomStruct:updateRoomInfo(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1.guards) do
		self:setGuardDirection(iter_26_1.monster_id, iter_26_0)
	end
end

function ExplorationMapRoomStruct:unlockTiled(arg_27_1)
	local var_27_0 = self:getTiledStruct(arg_27_1)

	if var_27_0 then
		var_27_0:setState(ExplorationConst.MAP.TILED_STATE_UNLOCK)

		self._state = ExplorationConst.MAP.ROOM_STATE_UNLOCK
	end
end

function ExplorationMapRoomStruct:getShopTiled()
	local var_28_0

	for iter_28_0, iter_28_1 in pairs(self._tiledStructTab) do
		if iter_28_1:getEventType() > 1 and iter_28_1:getEventType() < 6 then
			var_28_0 = iter_28_1

			break
		end
	end

	return var_28_0
end

return ExplorationMapRoomStruct
