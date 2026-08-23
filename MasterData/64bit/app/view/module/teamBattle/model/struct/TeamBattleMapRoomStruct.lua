local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleGroundConfig = require("app.view.module.teamBattle.const.TeamBattleGroundConfig")
local TeamBattleBuildConfig = require("app.view.module.teamBattle.const.TeamBattleBuildConfig")
local TeamBattleTiledStruct = require("app.view.module.teamBattle.model.struct.TeamBattleTiledStruct")
local TeamBattleMapRoomStruct = class("TeamBattleMapRoomStruct")

function TeamBattleMapRoomStruct:ctor(arg_1_1)
	self._isFirstEnter = true
	self._cfg = arg_1_1
	self._mapRoomId = arg_1_1.room
	self._roomId = arg_1_1.room_id
	self._coordinate = cc.p(arg_1_1.room_x, arg_1_1.room_y)
	self._state = TeamBattleConst.MAP.ROOM_STATE_LOCK
	self._barrierTiledPicDic = {}
	self._inSightBarrier = {}
	self._lastLockBarrier = {}
	self._fromIdList = {}
	self._groundDic = {}
	self._lockBarrierDic = {}
	self._changePosTiled = {}
	self._tiledStructTab = {}
	self._tiledStructHoldTab = {}
	self._teleportTiled = nil
	self._waitBuffs = {}
	self._visibleArea = {}
	self._entranceList = {
		[TeamBattleConst.DIRECTION.UP] = nil,
		[TeamBattleConst.DIRECTION.DOWN] = nil,
		[TeamBattleConst.DIRECTION.LEFT] = nil,
		[TeamBattleConst.DIRECTION.RIGHT] = nil
	}
	self._inSightDic = {}
	self._guardList = {}

	self:_initRoomTiled()
end

function TeamBattleMapRoomStruct:_initRoomTiled()
	for iter_2_0, iter_2_1 in pairs(TeamBattleGroundConfig) do
		local var_2_0 = string.split(iter_2_0, "_")

		if tonumber(var_2_0[1]) == self._roomId then
			self._groundDic[self:_getCoordinateKey({
				x = tonumber(var_2_0[2]),
				y = tonumber(var_2_0[3])
			})] = iter_2_1
		end
	end

	for iter_2_2, iter_2_3 in pairs(TeamBattleBuildConfig) do
		local var_2_1 = string.split(iter_2_2, "_")

		if tonumber(var_2_1[1]) == self._roomId then
			local var_2_2 = tonumber(var_2_1[2])
			local var_2_3 = tonumber(var_2_1[3])
			local var_2_4 = tonumber(var_2_1[4])
			local var_2_5 = tonumber(var_2_1[5])
			local var_2_6

			if var_2_4 > 210 then
				var_2_3 = var_2_3 - 1
				var_2_6 = var_2_2
			end

			for iter_2_4 = var_2_2, var_2_2 - (var_2_4 / 210 - 1), -1 do
				for iter_2_5 = var_2_3, var_2_3 - (var_2_5 / 210 - 1), -1 do
					local var_2_7 = self:_getCoordinateKey({
						x = var_2_2,
						y = var_2_3
					})

					if iter_2_4 == var_2_2 and iter_2_5 == var_2_3 then
						self._barrierTiledPicDic[var_2_7] = iter_2_3
						self._lockBarrierDic[var_2_7] = true
					else
						local var_2_8 = self:_getCoordinateKey({
							x = iter_2_4,
							y = iter_2_5
						})

						self._barrierTiledPicDic[var_2_8] = "! @!"
						self._lockBarrierDic[var_2_8] = true
					end
				end
			end
		end
	end

	for iter_2_6 = 1, g.core.config.team_battle_room_info.getLength() do
		local var_2_9 = g.core.config.team_battle_room_info.indexOf(iter_2_6)

		if var_2_9.room_id == self._roomId then
			local var_2_10 = TeamBattleTiledStruct.new(var_2_9, self._cfg)

			var_2_10:setBelongRoom(self._mapRoomId)

			local var_2_11 = var_2_10:getCoordinate()
			local var_2_12 = var_2_10:getTiledSize() - 1
			local var_2_13 = self:_getCoordinateKey(var_2_11)

			self._tiledStructTab[var_2_13] = var_2_10

			local var_2_14 = {
				var_2_13
			}

			for iter_2_7 = var_2_11.x, var_2_11.x - var_2_12, -1 do
				for iter_2_8 = var_2_11.y, var_2_11.y - var_2_12, -1 do
					local var_2_15 = self:_getCoordinateKey(cc.p(iter_2_7, iter_2_8))

					var_2_14[#var_2_14 + 1] = var_2_15
					self._tiledStructHoldTab[var_2_15] = var_2_10
				end
			end

			if var_2_9.grid_type == TeamBattleConst.EVENT_TYPE.BIRTH then
				self._birthTiled = var_2_10
			end

			if var_2_9.grid_type == TeamBattleConst.EVENT_TYPE.GUARD then
				self._guardTiled = var_2_10
			end
		end
	end

	for iter_2_9 = 0, 19 do
		for iter_2_10 = 0, 19 do
			if not self._tiledStructHoldTab[iter_2_9 .. "_" .. iter_2_10] and not self._barrierTiledPicDic[iter_2_9 .. "_" .. iter_2_10] then
				self._barrierTiledPicDic[iter_2_9 .. "_" .. iter_2_10] = ""
				self._lockBarrierDic[iter_2_9 .. "_" .. iter_2_10] = true
			end
		end
	end
end

function TeamBattleMapRoomStruct:getAllTiled()
	return self._tiledStructTab
end

function TeamBattleMapRoomStruct:getTiledStruct(arg_4_1)
	return self._tiledStructTab[self:_getCoordinateKey(arg_4_1)]
end

function TeamBattleMapRoomStruct:getTiledStructByRangeMode(arg_5_1)
	local var_5_0 = self:getTiledStruct(arg_5_1)

	if not var_5_0 then
		for iter_5_0 = arg_5_1.x, arg_5_1.x + 1 do
			for iter_5_1 = arg_5_1.y, arg_5_1.y + 1 do
				local var_5_1 = self:getTiledStruct(cc.p(iter_5_0, iter_5_1))

				if var_5_1 and var_5_1:getTiledSize() > 1 then
					return var_5_1
				end
			end
		end
	end

	return var_5_0
end

function TeamBattleMapRoomStruct:getBirthTiled()
	return self._birthTiled
end

function TeamBattleMapRoomStruct:getGuardTiled()
	return self._guardTiled
end

function TeamBattleMapRoomStruct:getTeleportTiled()
	return self._teleportTiled
end

function TeamBattleMapRoomStruct:getTileEntranceStruct(arg_9_1)
	return self:getTiledStruct(({
		cc.p(4, 0),
		cc.p(8, 4),
		cc.p(0, 4),
		(cc.p(4, 8))
	})[arg_9_1])
end

function TeamBattleMapRoomStruct:getMapRoomId()
	return self._mapRoomId
end

function TeamBattleMapRoomStruct:getRoomCoordinate()
	return self._cfg.room_x, self._cfg.room_y
end

function TeamBattleMapRoomStruct:getRoomZOrder()
	return self._cfg.room_x + self._cfg.room_y
end

function TeamBattleMapRoomStruct:_getCoordinateKey(arg_13_1)
	return arg_13_1.x .. "_" .. arg_13_1.y
end

function TeamBattleMapRoomStruct:getCfg()
	return self._cfg
end

function TeamBattleMapRoomStruct:setEntranceDirection(arg_15_1, arg_15_2)
	self._entranceList[arg_15_2] = arg_15_1
end

function TeamBattleMapRoomStruct:getEntranceList(arg_16_1)
	local var_16_0 = self._entranceList

	if arg_16_1 then
		var_16_0 = {}

		for iter_16_0, iter_16_1 in pairs(TeamBattleConst.DIRECTION) do
			if self._entranceList[iter_16_1] then
				table.insert(var_16_0, self._entranceList[iter_16_1])
			end
		end
	end

	return var_16_0
end

function TeamBattleMapRoomStruct:setGuard(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.monster_id
	local var_17_1 = g.core.config.team_battle_room_info.get(arg_17_1.grid_id)

	if arg_17_1.monster_id == 0 then
		var_17_0 = nil
	end

	local var_17_2 = self:getTiledStruct((cc.p(var_17_1.x, var_17_1.y)))

	if not var_17_0 then
		var_17_2:finishEvent()
	else
		var_17_2:setTiledMonster(var_17_0, arg_17_1)
	end
end

function TeamBattleMapRoomStruct:addFromId(arg_18_1)
	self._fromIdList[#self._fromIdList + 1] = arg_18_1
end

function TeamBattleMapRoomStruct:canMove(arg_19_1)
	local var_19_0 = self:getBarrierPicId(arg_19_1)
	local var_19_1 = self._tiledStructHoldTab[self:_getCoordinateKey(arg_19_1)]

	if var_19_1 then
		local var_19_2 = var_19_1:getState() >= TeamBattleConst.MAP.TILED_STATE_UNLOCK
		local var_19_3 = var_19_1:getEventInfo()
		local var_19_4 = var_19_1:getEventType()

		return var_19_2 and not ((var_19_3 or nil) and var_19_1:getUIInfo().knightInfo and var_19_3:getState() ~= TeamBattleConst.EVENT_STATE.FINISH) and not (var_19_4 == TeamBattleConst.EVENT_TYPE.KNIGHT_SHOP or var_19_4 == TeamBattleConst.EVENT_TYPE.BUFF_SHOP)
	elseif var_19_0 then
		return var_19_0 == "" and self:getBarrierState(arg_19_1) >= 1
	end
end

function TeamBattleMapRoomStruct:checkEventIsClear(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self._tiledStructTab) do
		if arg_20_1[iter_20_1:getEventType(true)] then
			return false
		end
	end

	return true
end

function TeamBattleMapRoomStruct:getFromId()
	return (self._fromIdList[1] or nil) and self._fromIdList[1]
end

function TeamBattleMapRoomStruct:getTeleportId()
	if self._teleportTiled then
		-- block empty
	end

	return 0
end

function TeamBattleMapRoomStruct:canTeleportToTiledId(arg_23_1)
	if not self:checkEventIsClear({
		[TeamBattleConst.EVENT_TYPE.GUARD] = true,
		[TeamBattleConst.EVENT_TYPE.ROBBER] = true
	}) then
		return false
	end

	return arg_23_1 == self:getFromId() or arg_23_1 == self:getTeleportId()
end

function TeamBattleMapRoomStruct:canChallengeGuard()
	return self:checkEventIsClear({
		[TeamBattleConst.EVENT_TYPE.ROBBER] = true
	})
end

function TeamBattleMapRoomStruct:unlockGuard()
	self._isUnlockGuard = true
end

function TeamBattleMapRoomStruct:isUnlockGuard()
	self._isUnlockGuard = false

	return self._isUnlockGuard
end

function TeamBattleMapRoomStruct:getBarrierPicId(arg_27_1)
	return self._barrierTiledPicDic[self:_getCoordinateKey(arg_27_1)]
end

function TeamBattleMapRoomStruct:getBarrierPicIdAndFilter(arg_28_1)
	if self:getTiledStruct(arg_28_1) then
		return nil
	end

	return self:getBarrierPicId(arg_28_1)
end

function TeamBattleMapRoomStruct:getAllBarrier()
	return self._barrierTiledPicDic
end

function TeamBattleMapRoomStruct:setBarrierUnlock(arg_30_1, arg_30_2)
	local var_30_0 = self:_getCoordinateKey(arg_30_1)

	if self._lockBarrierDic[var_30_0] and not self._inSightBarrier[var_30_0] then
		self._lastLockBarrier[var_30_0] = true
	end

	self._lockBarrierDic[var_30_0] = nil
end

function TeamBattleMapRoomStruct:getBarrierState(arg_31_1)
	local var_31_0 = 0

	if not self._lockBarrierDic[self:_getCoordinateKey(arg_31_1)] then
		var_31_0 = 1
	end

	return (self._inSightBarrier[self:_getCoordinateKey(arg_31_1)] or nil) and 2
end

function TeamBattleMapRoomStruct:getLastBarrierState(arg_32_1)
	local var_32_0 = self:_getCoordinateKey(arg_32_1)

	if self._lastLockBarrier[var_32_0] then
		self._lastLockBarrier[var_32_0] = nil

		return 0
	else
		return 1
	end
end

function TeamBattleMapRoomStruct:setRoomState(arg_33_1)
	self._state = arg_33_1
end

function TeamBattleMapRoomStruct:getRoomState()
	return self._state
end

function TeamBattleMapRoomStruct:getShopTiled()
	local var_35_0

	for iter_35_0, iter_35_1 in pairs(self._tiledStructTab) do
		if iter_35_1:getEventType() > 1 and iter_35_1:getEventType() < 6 then
			var_35_0 = iter_35_1

			break
		end
	end

	return var_35_0
end

function TeamBattleMapRoomStruct:updateRoomStruct(arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1.visible_area or {}
	local var_36_1 = arg_36_1.mines or {}
	local var_36_2 = arg_36_1.buffs or {}
	local var_36_3 = arg_36_1.knight_shops or {}
	local var_36_4 = arg_36_1.buff_shops or {}
	local var_36_5 = arg_36_1.monsters or {}
	local var_36_6 = arg_36_1.games or {}

	self:updateRoomTiledByCompleteList(arg_36_1.complete_grid_ids or {})

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		local var_36_7 = g.core.config.team_battle_room_info.get(iter_36_1.grid_id)

		self:getTiledStruct(cc.p(var_36_7.x, var_36_7.y)):updateEvent(iter_36_1)
	end

	self._waitBuffs = {}

	for iter_36_2, iter_36_3 in ipairs(var_36_2) do
		local var_36_8 = g.core.config.team_battle_room_info.get(iter_36_3.grid_id)
		local var_36_9 = self:getTiledStruct(cc.p(var_36_8.x, var_36_8.y))
		local var_36_10 = var_36_9:getEventInfo()

		var_36_10:updateEvent(iter_36_3)

		if var_36_9:getState() == TeamBattleConst.MAP.TILED_STATE_UNLOCK and var_36_10:getState() ~= TeamBattleConst.EVENT_STATE.FINISH then
			self._waitBuffs[iter_36_3.grid_id] = var_36_9
		end
	end

	for iter_36_4, iter_36_5 in ipairs(var_36_3) do
		local var_36_11 = g.core.config.team_battle_room_info.get(iter_36_5.grid_id)

		self:getTiledStruct(cc.p(var_36_11.x, var_36_11.y)):updateEvent(iter_36_5)
	end

	for iter_36_6, iter_36_7 in ipairs(var_36_4) do
		local var_36_12 = g.core.config.team_battle_room_info.get(iter_36_7.grid_id)

		self:getTiledStruct(cc.p(var_36_12.x, var_36_12.y)):updateEvent(iter_36_7)
	end

	for iter_36_8, iter_36_9 in ipairs(var_36_5) do
		local var_36_13 = g.core.config.team_battle_room_info.get(iter_36_9.grid_id)

		self:getTiledStruct(cc.p(var_36_13.x, var_36_13.y)):updateEvent(iter_36_9)
	end

	for iter_36_10, iter_36_11 in ipairs(var_36_6) do
		local var_36_14 = g.core.config.team_battle_room_info.get(iter_36_11.grid_id)

		self:getTiledStruct(cc.p(var_36_14.x, var_36_14.y)):getEventInfo():updateUserId(iter_36_11.user_ids)
	end

	self:updateVisibleArea(var_36_0, arg_36_2)
end

function TeamBattleMapRoomStruct:updateRoomTiledByCompleteList(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		local var_37_0 = g.core.config.team_battle_room_info.get(iter_37_1)
		local var_37_1 = self:getTiledStruct(cc.p(var_37_0.x, var_37_0.y))

		var_37_1:setState(TeamBattleConst.MAP.TILED_STATE_UNLOCK)
		var_37_1:finishEvent()
	end
end

function TeamBattleMapRoomStruct:updateTiledEvent(arg_38_1)
	local var_38_1 = g.core.config.team_battle_room_info.get(arg_38_1.grid or arg_38_1.grid_id)

	self:getTiledStruct(cc.p(var_38_1.x, var_38_1.y)):updateEvent(arg_38_1)
end

function TeamBattleMapRoomStruct:finishTiledEvent(arg_39_1)
	local var_39_0 = g.core.config.team_battle_room_info.get(arg_39_1.grid_id)
	local var_39_1 = self:getTiledStruct(cc.p(var_39_0.x, var_39_0.y))

	var_39_1:finishEvent(arg_39_1)

	if var_39_1:getEventType() == TeamBattleConst.EVENT_TYPE.BUFF then
		self._waitBuffs[arg_39_1.grid_id] = nil
	end
end

function TeamBattleMapRoomStruct:updateVisibleArea(arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_1 or {}

	if arg_40_3 then
		local var_40_2 = arg_40_3:getPos()
	end

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		local var_40_3 = string.split(iter_40_1, ":")
		local var_40_4 = cc.p(tonumber(var_40_3[1]), tonumber(var_40_3[2]))

		self._visibleArea[self:_getCoordinateKey(var_40_4)] = var_40_4

		self:onUnlockTiled(var_40_4, arg_40_2)

		self._isFirstEnter = false
	end
end

function TeamBattleMapRoomStruct:onUnlockTiled(arg_41_1, arg_41_2)
	local var_41_0 = self:getTiledStruct(arg_41_1)

	if var_41_0 then
		if var_41_0:getState() ~= TeamBattleConst.MAP.TILED_STATE_LOCK or arg_41_2 then
			var_41_0:setState(TeamBattleConst.MAP.TILED_STATE_UNLOCK, arg_41_2)
		end
	elseif self:getBarrierState(arg_41_1) ~= 0 or arg_41_2 then
		self:setBarrierUnlock(arg_41_1, arg_41_2)
	end

	self._state = TeamBattleConst.MAP.ROOM_STATE_UNLOCK
end

function TeamBattleMapRoomStruct:onShowTiled(arg_42_1)
	local var_42_0 = self:getTiledStruct(arg_42_1)

	if var_42_0 then
		var_42_0:setState(TeamBattleConst.MAP.TILED_STATE_IN_SIGHT, true)
	else
		local var_42_1 = self:_getCoordinateKey(arg_42_1)

		self:setBarrierUnlock(arg_42_1)

		self._inSightBarrier[var_42_1] = true
	end
end

function TeamBattleMapRoomStruct:onHideTiled(arg_43_1)
	local var_43_0 = self:getTiledStruct(arg_43_1)

	if var_43_0 then
		var_43_0:unLockTiled()
	else
		local var_43_1 = self:_getCoordinateKey(arg_43_1)

		self:setBarrierUnlock(arg_43_1)

		self._inSightBarrier[var_43_1] = nil
	end
end

function TeamBattleMapRoomStruct:getWaitBuffs()
	return self._waitBuffs
end

function TeamBattleMapRoomStruct:getVisibleArea()
	return self._visibleArea
end

function TeamBattleMapRoomStruct:getGround(arg_46_1)
	return self._groundDic[self:_getCoordinateKey(arg_46_1)]
end

function TeamBattleMapRoomStruct:getOwnerTiledByGroundPos(arg_47_1)
	return self._tiledStructHoldTab[self:_getCoordinateKey(arg_47_1)]
end

function TeamBattleMapRoomStruct:getTiledGroundList(arg_48_1)
	local var_48_0 = {}

	if not arg_48_1 then
		return var_48_0
	end

	local var_48_1 = self:getTiledStruct(arg_48_1):getTiledSize() - 1

	for iter_48_0 = arg_48_1.x, arg_48_1.x - var_48_1, -1 do
		for iter_48_1 = arg_48_1.y, arg_48_1.y - var_48_1, -1 do
			local var_48_2 = cc.p(iter_48_0, iter_48_1)
			local var_48_3 = self:getGround(var_48_2)

			if var_48_3 then
				var_48_0[#var_48_0 + 1] = {
					pos = var_48_2,
					info = var_48_3
				}
			end
		end
	end

	return var_48_0
end

function TeamBattleMapRoomStruct:updateRoleSightTiled(arg_49_1, arg_49_2)
	local var_49_0 = arg_49_1:getPlayerId()
	local var_49_1 = self._inSightDic[var_49_0]
	local var_49_2 = g.core.model.User.teamBattleData:getMapData():getPlayerStruct():getRoomId() == self._roomId

	if not self._inSightDic[var_49_0] then
		var_49_1 = {}
		self._inSightDic[var_49_0] = var_49_1
		var_49_2 = self._isFirstEnter
	end

	arg_49_2 = arg_49_2 or arg_49_1:getPos()

	local var_49_3 = arg_49_1:getVisibleSize()
	local var_49_4 = {}

	for iter_49_0 = math.max(0, arg_49_2.x - var_49_3.width), math.min(arg_49_2.x + var_49_3.width, 19) do
		for iter_49_1 = math.max(0, arg_49_2.y - var_49_3.height), math.min(arg_49_2.y + var_49_3.height, 19) do
			local var_49_5 = cc.p(iter_49_0, iter_49_1)
			local var_49_6 = self:_getCoordinateKey(var_49_5)
			local var_49_7 = self:getTiledStruct(var_49_5)

			if var_49_1[var_49_6] then
				var_49_1[var_49_6] = nil
			elseif var_49_2 then
				local var_49_8

				if var_49_7 then
					var_49_8 = var_49_7:getState()

					local var_49_10 = var_49_7:getLastState()
				else
					var_49_8 = self:getBarrierState(var_49_5)

					local var_49_11 = self:getLastBarrierState(var_49_5)
				end

				if var_49_8 == TeamBattleConst.MAP.TILED_STATE_UNLOCK then
					self:addTiledToChangeDic(arg_49_1:getPlayerId(), var_49_5, "show", math.abs(arg_49_2.x - var_49_5.x) + math.abs(arg_49_2.y - var_49_5.y) - 1)
				elseif var_49_8 == TeamBattleConst.MAP.TILED_STATE_LOCK then
					self:addTiledToChangeDic(arg_49_1:getPlayerId(), var_49_5, "up", math.abs(arg_49_2.x - var_49_5.x) + math.abs(arg_49_2.y - var_49_5.y))
				end
			end

			var_49_4[var_49_6] = true

			self:onShowTiled(var_49_5)
		end
	end

	self._inSightDic[var_49_0] = var_49_4

	for iter_49_2, iter_49_3 in pairs(var_49_1) do
		local var_49_12 = string.split(iter_49_2, "_")
		local var_49_13 = cc.p(tonumber(var_49_12[1]), tonumber(var_49_12[2]))

		if self:_safeHideSightTiled(var_49_13) and var_49_2 then
			self:addTiledToChangeDic(arg_49_1:getPlayerId(), var_49_13, "hide", 0)
		end
	end

	self._isFirstEnter = false
end

function TeamBattleMapRoomStruct:clearRoleSightTiled(arg_50_1)
	local var_50_0 = arg_50_1:getPlayerId()

	self._inSightDic[var_50_0] = nil

	for iter_50_0, iter_50_1 in pairs(self._inSightDic[var_50_0] or {}) do
		local var_50_1 = string.split(iter_50_0, "_")

		self:_safeHideSightTiled((cc.p(tonumber(var_50_1[1]), tonumber(var_50_1[2]))))
	end
end

function TeamBattleMapRoomStruct:_safeHideSightTiled(arg_51_1)
	local var_51_0 = table.concat({
		arg_51_1.x,
		arg_51_1.y
	}, "_")

	for iter_51_0, iter_51_1 in pairs(self._inSightDic) do
		for iter_51_2, iter_51_3 in pairs(iter_51_1) do
			if var_51_0 == iter_51_2 then
				return false
			end
		end
	end

	self:onHideTiled(arg_51_1)

	return true
end

function TeamBattleMapRoomStruct:addTiledToChangeDic(arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	local var_52_0 = self._changePosTiled[arg_52_1]

	if not self._changePosTiled[arg_52_1] then
		var_52_0 = {}
		self._changePosTiled[arg_52_1] = var_52_0
	end

	var_52_0[table.concat({
		arg_52_2.x,
		arg_52_2.y
	}, "_")] = {
		showStr = arg_52_3,
		timeLevel = arg_52_4
	}
end

function TeamBattleMapRoomStruct:removeTiledFormChangeDic(arg_53_1, arg_53_2)
	if arg_53_1 then
		if not self._changePosTiled[arg_53_1] then
			return
		end

		if arg_53_2 then
			self._changePosTiled[arg_53_1][table.concat({
				arg_53_2.x,
				arg_53_2.y
			}, "_")] = nil
		else
			self._changePosTiled[arg_53_1] = {}
		end
	elseif arg_53_2 then
		local var_53_0 = self:_getCoordinateKey(arg_53_2)

		for iter_53_0, iter_53_1 in pairs(self._changePosTiled) do
			if iter_53_1[var_53_0] then
				iter_53_1[var_53_0] = nil
			end
		end
	end
end

function TeamBattleMapRoomStruct:getChangeDic(arg_54_1, arg_54_2)
	if arg_54_1 then
		return self._changePosTiled[arg_54_1]
	elseif arg_54_2 then
		local var_54_0 = self:_getCoordinateKey(arg_54_2)

		for iter_54_0, iter_54_1 in pairs(self._changePosTiled) do
			if iter_54_1[var_54_0] then
				return iter_54_1[var_54_0]
			end
		end
	end
end

function TeamBattleMapRoomStruct:getTiledStructList(arg_55_1)
	local var_55_0 = {}

	for iter_55_0, iter_55_1 in pairs(self._tiledStructTab) do
		if arg_55_1(iter_55_1) then
			var_55_0[#var_55_0 + 1] = iter_55_1
		end
	end

	return var_55_0
end

return TeamBattleMapRoomStruct
