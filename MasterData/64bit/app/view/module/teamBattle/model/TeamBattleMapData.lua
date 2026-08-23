local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleMapCommon = require("app.view.module.teamBattle.common.TeamBattleMapCommon")
local var_0_2 = g.core.config.team_battle_buff_info
local var_0_3 = g.core.config.team_battle_buff_shop_info
local TeamBattlePlayerStruct = require("app.view.module.teamBattle.model.struct.TeamBattlePlayerStruct")
local TeamBattleMapRoomStruct = require("app.view.module.teamBattle.model.struct.TeamBattleMapRoomStruct")
local TeamBattleMapData = class("TeamBattleMapData")

function TeamBattleMapData:ctor()
	self._mapInfoDic = {}
	self._playerMap = {}
	self._mapCenterPos = nil
	self._score = 0
	self._eventMap = {}
	self._buffIdList = {}
	self._bossDic = {}
	self._unlockRoomList = {}
	self._waitPopBuff = {}
	self._canUnlockAreaDic = {}
	self._logList = {}
	self._curMapId = -1
	self._battleInfo = nil
	self._battleWin = false
	self._costPointCfg = nil
end

function TeamBattleMapData:_initMapInfo(arg_2_1)
	local var_2_0 = {
		maxY = 0,
		maxX = 0,
		isPass = false,
		roomTab = {},
		roomIdTab = {},
		birthPointMap = {},
		visiblePointArr = {}
	}

	for iter_2_0 = 1, g.core.config.team_battle_map_info.getLength() do
		local var_2_1 = g.core.config.team_battle_map_info.indexOf(iter_2_0)

		if var_2_1.group == arg_2_1 then
			local var_2_2 = TeamBattleMapRoomStruct.new(var_2_1)
			local var_2_3, var_2_4 = var_2_2:getRoomCoordinate()

			var_2_0.roomTab[var_2_3 .. "_" .. var_2_4] = var_2_2
			var_2_0.roomIdTab[var_2_2:getMapRoomId()] = var_2_2

			if var_2_3 > var_2_0.maxX then
				var_2_0.maxX = var_2_3
			end

			if var_2_4 > var_2_0.maxY then
				var_2_0.maxY = var_2_4
			end
		end
	end

	self:_parseAndLinkRoomRoute(var_2_0.roomTab)

	self._mapInfoDic[arg_2_1] = var_2_0
	self._costPointCfg = self._costPointCfg or g.core.config.play_num_info.get(TeamBattleConst.MAP.TEAM_MAP_COST_ID)
end

function TeamBattleMapData:_parseAndLinkRoomRoute(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_0 = iter_3_1:getTeleportId()

		if var_3_0 ~= 0 then
			local var_3_1 = g.core.config.team_battle_room_info.get(var_3_0)

			arg_3_1[var_3_1.x .. "_" .. var_3_1.y]:addFromId(var_3_0)
		end
	end
end

function TeamBattleMapData:resetMapInfo(arg_4_1)
	self._mapInfoDic[arg_4_1] = nil
end

function TeamBattleMapData:getMapInfo(arg_5_1, arg_5_2)
	if arg_5_2 then
		self._mapInfoDic[arg_5_1] = nil
	end

	local var_5_0 = self._mapInfoDic[arg_5_1]

	if not self._mapInfoDic[arg_5_1] then
		self:_initMapInfo(arg_5_1)

		var_5_0 = self._mapInfoDic[arg_5_1]
	end

	return var_5_0
end

function TeamBattleMapData:setCurMapId(arg_6_1)
	self._curMapId = arg_6_1
end

function TeamBattleMapData:getCurMapId()
	return self._curMapId
end

function TeamBattleMapData:getCurMapInfo()
	return self:getMapInfo(self._curMapId)
end

function TeamBattleMapData:updateMapData(arg_9_1)
	self._score = arg_9_1.map.score or 0

	self:clearEvent()
	self:updateRoomData(arg_9_1.room, true)
	self:setEventMap(arg_9_1.events or {})
	self:updateBuffList(arg_9_1.map.buff_ids or {}, arg_9_1.map.buff_shop_ids or {})
	self:updateItems(arg_9_1.map.items)

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.map.room_snapshots or {}) do
		local var_9_0 = self:getRoomStructByRoomId(iter_9_1.room_id)

		var_9_0:updateRoomTiledByCompleteList(iter_9_1.complete_grid_ids or {})

		if iter_9_1.boss then
			self:updateLimitBossList(iter_9_1.boss)
		end

		var_9_0:setRoomState(TeamBattleConst.MAP.ROOM_STATE_UNLOCK)
	end

	self._results = arg_9_1.challenge_result

	self:updatePlayer(arg_9_1.map.users)

	local var_9_1 = self:getPlayerStruct()

	var_9_1:updateExtData(arg_9_1.user_data or {})
	var_9_1:setActionPointAwards(arg_9_1.action_awards)
end

function TeamBattleMapData:updatePlayer(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(g.core.model.User.teamBattleData:getTeamUpData():getMyTeam().members) do
		var_10_0[iter_10_1] = true
	end

	local var_10_1 = {}

	for iter_10_2, iter_10_3 in pairs(arg_10_1) do
		if var_10_0[iter_10_3.user_id] then
			var_10_1[#var_10_1 + 1] = iter_10_3
		end
	end

	if #var_10_1 > 0 then
		arg_10_1 = var_10_1
	end

	for iter_10_4, iter_10_5 in ipairs(arg_10_1) do
		local var_10_2 = self._playerMap[iter_10_5.user_id]

		if not self._playerMap[iter_10_5.user_id] then
			var_10_2 = TeamBattlePlayerStruct.new()
			self._playerMap[iter_10_5.user_id] = var_10_2
		end

		local var_10_3 = var_10_2:getRoomId()

		var_10_2:updateBaseInfo(iter_10_5)

		if var_10_3 >= 0 and var_10_2:getRoomId() ~= var_10_3 then
			self:getRoomStructByRoomId(var_10_3):clearRoleSightTiled(var_10_2)
		end
	end

	for iter_10_6, iter_10_7 in ipairs(arg_10_1) do
		local var_10_4 = self._playerMap[iter_10_7.user_id]:getRoomId()

		if self._playerMap[iter_10_7.user_id]:getOnLineState() == 1 then
			self:updateRoleSightTiled(iter_10_7.user_id)
		else
			self:getRoomStructByRoomId(var_10_4):clearRoleSightTiled(self._playerMap[iter_10_7.user_id])
		end
	end
end

function TeamBattleMapData:updatePlayerHasInfo(arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or g.core.model.User:getId()

	local var_11_0 = self._playerMap[arg_11_2]

	self._playerMap[arg_11_2]:updateValueByHasInfo(arg_11_1)

	if arg_11_1.status and arg_11_1.status == 0 then
		self:getRoomStructByRoomId(var_11_0:getRoomId()):clearRoleSightTiled(var_11_0)
	end
end

function TeamBattleMapData:updatePlayerExtData(arg_12_1)
	self:getPlayerStruct():safeUpdateExtData(arg_12_1)
end

function TeamBattleMapData:removePlayerExtDataItem(arg_13_1)
	self:getPlayerStruct():removeKeyValue(arg_13_1)
end

function TeamBattleMapData:updatePlayerActionPointAwards(arg_14_1)
	self:getPlayerStruct():setActionPointAwards(arg_14_1)
end

function TeamBattleMapData:updateRoomData(arg_15_1, arg_15_2)
	self:getRoomStructByRoomId(arg_15_1.room_id):updateRoomStruct(arg_15_1, arg_15_2)

	if arg_15_1.boss then
		self:updateLimitBossList(arg_15_1.boss)
	end
end

function TeamBattleMapData:updateVisibleArea(arg_16_1, arg_16_2, arg_16_3)
	arg_16_2 = arg_16_2 or g.core.model.User:getId()

	self:getRoomStructByRoomId((self._playerMap[arg_16_2]:getRoomId())):updateVisibleArea(arg_16_1, arg_16_3, self._playerMap[arg_16_2])
end

function TeamBattleMapData:updateBuffList(arg_17_1, arg_17_2)
	self._buffIdList = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		self:addBuff(iter_17_1, false)
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_2) do
		self:addBuff(iter_17_3, true)
	end
end

function TeamBattleMapData:addBuff(arg_18_1, arg_18_2)
	self._buffIdList[#self._buffIdList + 1] = {
		buffId = arg_18_1,
		isShop = arg_18_2
	}
end

function TeamBattleMapData:getBuffIdList()
	return self._buffIdList
end

function TeamBattleMapData:getBuffAttrList()
	local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
	local var_20_1 = {}
	local var_20_2 = {}

	for iter_20_0, iter_20_1 in ipairs(self._buffIdList) do
		var_20_2 = FightValueCalculation.getAttrListByTalentSkillId(self:getBuffInfo(iter_20_1).buff_id, var_20_2)
	end

	for iter_20_2, iter_20_3 in pairs(var_20_2) do
		table.insert(var_20_1, {
			type = iter_20_2,
			value = iter_20_3
		})
	end

	return var_20_1
end

function TeamBattleMapData:getBuffInfo(arg_21_1)
	if arg_21_1.isShop then
		return var_0_3.get(arg_21_1.buffId)
	else
		return var_0_2.get(arg_21_1.buffId)
	end
end

function TeamBattleMapData:updateItems(arg_22_1)
	return
end

function TeamBattleMapData:getRoomCoordinateAndCoordinateByGlobalCoordinate(arg_23_1)
	local var_23_0, var_23_1 = TeamBattleMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate(arg_23_1)

	return var_23_0, var_23_1
end

function TeamBattleMapData:getRoomStructByRoomId(arg_24_1)
	return self:getMapInfo(self._curMapId).roomIdTab[arg_24_1]
end

function TeamBattleMapData:getRoomStructByCoordinate(arg_25_1)
	return self:getMapInfo(self._curMapId).roomTab[arg_25_1.x .. "_" .. arg_25_1.y]
end

function TeamBattleMapData:getRoomStructAndLocalCoordinate(arg_26_1)
	local var_26_0, var_26_1 = self:getRoomCoordinateAndCoordinateByGlobalCoordinate(arg_26_1)

	return self:getRoomStructByCoordinate(var_26_0), var_26_1
end

function TeamBattleMapData:getRoomCenterGlobalCoordinateByRoomId(arg_27_1)
	return (cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self:getRoomStructByRoomId(arg_27_1), cc.p(4, 4))))
end

function TeamBattleMapData:getAllUnlockRoom(arg_28_1)
	local var_28_0 = self:getPlayerStruct():getRoomId()
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in pairs(self:getMapInfo(self._curMapId).roomIdTab) do
		if iter_28_1:getRoomState() == TeamBattleConst.MAP.ROOM_STATE_UNLOCK and (not arg_28_1 or var_28_0 ~= iter_28_1:getCfg().room_id) then
			var_28_1[#var_28_1 + 1] = iter_28_1
		end
	end

	return var_28_1
end

function TeamBattleMapData:getGroundInfo(arg_29_1)
	local var_29_0, var_29_1 = self:getRoomStructAndLocalCoordinate(arg_29_1)

	if not var_29_0 then
		return
	end

	local var_29_2 = var_29_0:getGround(var_29_1)

	if not var_29_2 then
		return
	end

	return {
		type = "build",
		value = var_29_0:getOwnerTiledByGroundPos(var_29_1),
		ground = var_29_2,
		changeInfo = var_29_0:getChangeDic(nil, var_29_1),
		coordinate = var_29_1
	}
end

function TeamBattleMapData:getTiledInfo(arg_30_1)
	local var_30_0, var_30_1 = self:getRoomStructAndLocalCoordinate(arg_30_1)

	if not var_30_0 then
		return
	end

	local var_30_2
	local var_30_3 = var_30_0:getBarrierPicId(var_30_1)
	local var_30_4 = var_30_0:getTiledStruct(var_30_1)
	local var_30_5 = var_30_0:getChangeDic(nil, var_30_1)

	var_30_2 = not var_30_4 and var_30_3 and {
		type = "barrier",
		value = var_30_3,
		valueEx = var_30_0:getBarrierState(var_30_1),
		ground = var_30_0:getGround(var_30_1),
		changeInfo = var_30_5,
		coordinate = var_30_1
	} or var_30_4 and {
		type = "build",
		value = var_30_4,
		ground = var_30_0:getGround(var_30_1),
		changeInfo = var_30_5,
		coordinate = var_30_1
	} or var_30_2

	return var_30_2
end

function TeamBattleMapData:getTiledInfoRange(arg_31_1)
	local var_31_0, var_31_1 = self:getRoomStructAndLocalCoordinate(arg_31_1)

	if not var_31_0 then
		return
	end

	local var_31_2
	local var_31_3 = var_31_0:getBarrierPicId(var_31_1)
	local var_31_4 = var_31_0:getTiledStructByRangeMode(var_31_1)
	local var_31_5 = var_31_0:getChangeDic(nil, var_31_1)

	var_31_2 = var_31_3 and not var_31_4 and {
		type = "barrier",
		value = var_31_3,
		valueEx = var_31_0:getBarrierState(var_31_1),
		ground = var_31_0:getGround(var_31_1),
		changeInfo = var_31_5,
		coordinate = arg_31_1
	} or var_31_4 and {
		type = "build",
		value = var_31_4,
		ground = var_31_0:getGround(var_31_1),
		changeInfo = var_31_5,
		coordinate = cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_31_0, var_31_4:getCoordinate()))
	} or var_31_2

	return var_31_2
end

function TeamBattleMapData:getTiledStruct(arg_32_1)
	local var_32_0 = g.core.config.team_battle_room_info.get(arg_32_1)

	return self:getRoomStructByRoomId(var_32_0.room_id):getTiledStruct(cc.p(var_32_0.x, var_32_0.y))
end

function TeamBattleMapData:getRouteArray(arg_33_1, arg_33_2)
	self._tempTo = arg_33_2

	return (require("app.core.utils.KsAStar").searchPath(arg_33_1, arg_33_2, self))
end

function TeamBattleMapData:doCalcNeighborAStar(arg_34_1)
	local var_34_0 = self

	return (self:_getNeighborCoordinateArr(arg_34_1, function(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
		local var_35_0 = false

		if arg_35_3 then
			local var_35_2, var_35_3 = var_34_0:getRoomStructAndLocalCoordinate(arg_35_3)

			arg_35_1 = var_35_3

			if var_35_2:canMove(var_35_3) then
				var_35_0 = false
			end
		else
			var_35_0 = arg_35_0:canMove(arg_35_1)
		end

		if not var_35_0 then
			arg_35_3 = arg_35_3 or cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(arg_35_0, arg_35_1))

			local var_35_4, var_35_5 = self:getRoomStructAndLocalCoordinate(arg_35_3)

			if self._tempTo and arg_35_3.x == self._tempTo.x and arg_35_3.y == self._tempTo.y and var_35_4:getBarrierPicIdAndFilter(var_35_5) == nil then
				var_35_0 = true
			end
		end

		return var_35_0
	end))
end

function TeamBattleMapData:_getNeighborCoordinateArr(arg_36_1, arg_36_2)
	local var_36_0 = {}
	local var_36_1 = self:getCurMapInfo().roomTab
	local var_36_2, var_36_3 = TeamBattleMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate(arg_36_1)
	local var_36_4 = cc.p(arg_36_1.x, arg_36_1.y)
	local var_36_5 = {
		"y",
		"x"
	}

	for iter_36_0, iter_36_1 in pairs(TeamBattleConst.DIRECTION) do
		local var_36_7 = var_36_5[bit.rshift(bit.band(iter_36_1, 2), 1) + 1]

		var_36_4[var_36_7] = var_36_4[var_36_7] + math.pow(-1, (bit.band(iter_36_1, 1)))

		local var_36_8, var_36_9 = TeamBattleMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate(var_36_4)

		if (var_36_1[var_36_8.x .. "_" .. var_36_8.y] or nil) and ((var_36_8.x ~= var_36_2.x or var_36_8.y ~= var_36_2.y) and arg_36_2(var_36_1[var_36_2.x .. "_" .. var_36_2.y], var_36_9, iter_36_1, var_36_4) or arg_36_2(var_36_1[var_36_8.x .. "_" .. var_36_8.y], var_36_9, iter_36_1)) then
			table.insert(var_36_0, cc.p(var_36_4.x, var_36_4.y))
		end

		var_36_4.x = arg_36_1.x
		var_36_4.y = arg_36_1.y
	end

	return var_36_0
end

function TeamBattleMapData:clearEvent(arg_37_1)
	self._eventMap = {}
end

function TeamBattleMapData:setEventMap(arg_38_1)
	self._eventMap = {}

	self:updateEventMap(arg_38_1)
end

function TeamBattleMapData:updateEventMap(arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
		self:updateEventMapByOneEvent(iter_39_1)
	end
end

function TeamBattleMapData:onSelectGame(arg_40_1)
	self:updateEventMap({
		arg_40_1.event
	} or {})
end

function TeamBattleMapData:updateEventMapByOneEvent(arg_41_1)
	self:updateEvent(arg_41_1)

	local var_41_0 = g.core.config.team_battle_room_info.get(arg_41_1.grid_id).grid_type

	self._eventMap[var_41_0] = self._eventMap[var_41_0] or {}

	for iter_41_0, iter_41_1 in ipairs(self._eventMap[var_41_0]) do
		if iter_41_1.unique_id == arg_41_1.unique_id then
			return
		end
	end

	table.insert(self._eventMap[var_41_0], arg_41_1)
end

function TeamBattleMapData:getEventByType(arg_42_1)
	if self._eventMap[arg_42_1] then
		local var_42_0 = next(self._eventMap[arg_42_1])

		return var_42_0 and self._eventMap[arg_42_1][var_42_0]
	end

	return nil
end

function TeamBattleMapData:getEventNumByType(arg_43_1)
	if self._eventMap[arg_43_1] then
		return table.nums(self._eventMap[arg_43_1])
	end

	return 0
end

function TeamBattleMapData:isInEventMap(arg_44_1, arg_44_2)
	for iter_44_0, iter_44_1 in ipairs(self._eventMap[arg_44_1]) do
		if iter_44_1.unique_id == arg_44_2 then
			return true
		end
	end

	return false
end

function TeamBattleMapData:onOtherBuyBuff(arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(arg_45_1.buy_poss) do
		self:addBuff(arg_45_1.goods_ids[iter_45_1 + 1], true)
	end
end

function TeamBattleMapData:updateEvent(arg_46_1, arg_46_2)
	self:getRoomStructByRoomId(g.core.config.team_battle_room_info.get(arg_46_1.grid_id).room_id):updateTiledEvent(arg_46_1)
end

function TeamBattleMapData:updateShopBuyPos(arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = self:getTiledStruct(arg_47_1):getEventInfo()

	var_47_0:onBuyItemByPos(arg_47_2)

	if var_47_0:getEventType() == TeamBattleConst.EVENT_TYPE.KNIGHT_SHOP then
		g.core.model.User.teamBattleData:getFormationData():addPoolMemberKnight({
			hp = 1000,
			base_id = var_47_0:getEventInfo().productList[arg_47_2],
			id = arg_47_3
		}, "insert")
	else
		self:addBuff(arg_47_3, true)
	end
end

function TeamBattleMapData:updateMine(arg_48_1)
	self:getTiledStruct(arg_48_1):getEventInfo():costOneMineTimes()
end

function TeamBattleMapData:eventFinish(arg_49_1)
	local var_49_0 = g.core.config.team_battle_room_info.get(arg_49_1.grid_id)

	self:getRoomStructByRoomId(var_49_0.room_id):finishTiledEvent(arg_49_1)

	if arg_49_1.unique_id then
		for iter_49_0, iter_49_1 in ipairs(self._eventMap[var_49_0.grid_type]) do
			if iter_49_1.unique_id == arg_49_1.unique_id then
				table.remove(self._eventMap[var_49_0.grid_type], iter_49_0)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_EVENT_FINISH)

				break
			end
		end
	end
end

function TeamBattleMapData:getWaitBuffTab()
	return self._waitPopBuff
end

function TeamBattleMapData:getPlayerStruct(arg_51_1)
	arg_51_1 = arg_51_1 or g.core.model.User:getId()

	return self._playerMap[arg_51_1]
end

function TeamBattleMapData:getPlayerMap()
	return self._playerMap
end

function TeamBattleMapData:getRoleCoordinate(arg_53_1)
	local var_53_0 = self:getPlayerStruct(arg_53_1)

	return (cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self:getRoomStructByRoomId((var_53_0:getRoomId())), (var_53_0:getPos()))))
end

function TeamBattleMapData:getMainRoleCoordinate()
	local var_54_0 = self._playerMap[g.core.model.User:getId()]

	return (cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self:getRoomStructByRoomId((var_54_0:getRoomId())), (var_54_0:getPos()))))
end

function TeamBattleMapData:saveMapCenterPos(arg_55_1)
	self._mapCenterPos = arg_55_1
end

function TeamBattleMapData:getMapCenterPos()
	return self._mapCenterPos
end

function TeamBattleMapData:unlockCoordinateAndUpdateEvent(arg_57_1)
	if arg_57_1.event then
		self:addExplorationMiniGame(arg_57_1.event)
		self:_updateOneCanUnlockArea((cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self:getRoomStructByRoomId(g.core.config.team_battle_room_info.get(arg_57_1.event.grid_id).room_id), cc.p(arg_57_1.event.x, arg_57_1.event.y)))))
	else
		self:_updateOneCanUnlockArea((cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self:getRoomStructByRoomId(arg_57_1.room_id), cc.p(arg_57_1.x, arg_57_1.y)))))
	end
end

function TeamBattleMapData:getBossList()
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in pairs(self._bossDic) do
		var_58_0[#var_58_0 + 1] = iter_58_1
	end

	return var_58_0
end

function TeamBattleMapData:canGetLimitBoss(arg_59_1)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in pairs(self._bossDic) do
		local var_59_1 = self:getTiledStruct(iter_59_1:getEventInfo().grid)

		var_59_0[#var_59_0 + 1] = cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_59_1:getBelongRoom(), var_59_1:getCoordinate()))
	end

	local var_59_2 = false

	for iter_59_2, iter_59_3 in pairs(var_59_0) do
		if #self:doCalcNeighborAStar(iter_59_3) > 0 then
			var_59_2 = self:getRoomStructAndLocalCoordinate(iter_59_3):getBossTiled():getEventInfo().unique_id ~= nil
		end

		if var_59_2 then
			break
		end
	end

	return var_59_2
end

function TeamBattleMapData:isShopFull(arg_60_1)
	local var_60_0
	local var_60_1

	if arg_60_1 == TeamBattleConst.EVENT_TYPE.KNIGHT_SHOP then
		var_60_0 = g.core.common.Goods.TYPE_KNIGHT
		var_60_1 = 427012
	end

	if not var_60_0 then
		return false
	end

	return g.core.model.User.teamBattleData:getFormationData():isBagFullByType(var_60_0), var_60_1
end

function TeamBattleMapData:clearBossDic()
	self._bossDic = {}
end

function TeamBattleMapData:updateLimitBossList(arg_62_1)
	self._bossDic = self._bossDic or {}

	local var_62_0 = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_1) do
		local var_62_1 = self:getTiledStruct(iter_62_1.grid_id)

		var_62_1:updateBossEvent(iter_62_1, arg_62_1)

		self._bossDic[iter_62_1.grid_id] = var_62_1:getEventInfo()
		var_62_0[#var_62_0 + 1] = var_62_1:getEventInfo()
	end

	for iter_62_2, iter_62_3 in ipairs(var_62_0) do
		iter_62_3:setBindBossEvent(var_62_0)
	end
end

function TeamBattleMapData:saveBattleInfo(arg_63_1)
	self._battleInfo = arg_63_1
end

function TeamBattleMapData:onGuardBattleFinish(arg_64_1)
	if arg_64_1 and self._battleInfo and self._battleInfo.direction then
		local var_64_0 = self:getRoomStructByRoomId(g.core.config.team_battle_room_info.get(self._battleInfo.grid_id).room_id)

		var_64_0:setGuard({
			monster_id = 0,
			grid_id = self._battleInfo.grid_id
		}, true)
		self:_updateOneCanUnlockArea(cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_64_0, var_64_0:getTileEntranceStruct(self._battleInfo.direction):getCoordinate())), true)
	end

	self._battleWin = arg_64_1
	self._battleInfo = nil
end

function TeamBattleMapData:onRobberBattleFinish(arg_65_1)
	if arg_65_1 and self._battleInfo and self._battleInfo.event then
		self:updateEventByUID(self._battleInfo.event.unique_id, {
			tp = TeamBattleConst.EVENT_TYPE.NONE
		})
		self:_updateOneCanUnlockArea(cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self:getRoomStructByRoomId(g.core.config.team_battle_room_info.get(self._battleInfo.event.grid_id).room_id), cc.p(self._battleInfo.event.x, self._battleInfo.event.y))), true)
	end

	self._battleWin = arg_65_1
	self._battleInfo = nil
end

function TeamBattleMapData:isBattleWin()
	return self._battleInfo == nil and self._battleWin
end

function TeamBattleMapData:resetBattleWin()
	self._battleWin = false
end

function TeamBattleMapData:getMonsterResIdTab(arg_68_1)
	local var_68_0 = {
		monsterCnt = 0,
		guardTab = {},
		robberTab = {},
		curTab = {}
	}
	local var_68_1 = cc.rect(arg_68_1.x - 10, arg_68_1.y - 10, 20, 20)

	for iter_68_0, iter_68_1 in pairs(self:getCurMapInfo().roomIdTab) do
		for iter_68_2, iter_68_3 in pairs((iter_68_1:getAllTiled())) do
			local var_68_2 = iter_68_3:getCoordinate()

			var_68_2.x, var_68_2.y = TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(iter_68_1, var_68_2)

			if cc.rectContainsPoint(var_68_1, var_68_2) and (iter_68_3:getEventType() == TeamBattleConst.EVENT_TYPE.GUARD or iter_68_3:getEventType() == TeamBattleConst.EVENT_TYPE.ROBBER) then
				local var_68_3 = iter_68_3:getTiledMonster().resId

				var_68_0.curTab[var_68_3] = var_68_0.curTab[var_68_3] or 0
				var_68_0.curTab[var_68_3] = var_68_0.curTab[var_68_3] + 1
			elseif iter_68_3:getEventType() == TeamBattleConst.EVENT_TYPE.GUARD then
				local var_68_4 = iter_68_3:getTiledMonster().resId

				var_68_0.guardTab[var_68_4] = var_68_0.guardTab[var_68_4] or 0
				var_68_0.guardTab[var_68_4] = var_68_0.guardTab[var_68_4] + 1
				var_68_0.monsterCnt = var_68_0.monsterCnt + 1
			elseif iter_68_3:getEventType() == TeamBattleConst.EVENT_TYPE.ROBBER then
				local var_68_5 = iter_68_3:getTiledMonster().resId

				var_68_0.robberTab[var_68_5] = var_68_0.robberTab[var_68_5] or 0
				var_68_0.robberTab[var_68_5] = var_68_0.robberTab[var_68_5] + 1
				var_68_0.monsterCnt = var_68_0.monsterCnt + 1
			end
		end
	end

	return var_68_0
end

function TeamBattleMapData:checkRoomIsEnter(arg_69_1)
	return next(arg_69_1:getVisibleArea())
end

function TeamBattleMapData:getPosVisibleArea(arg_70_1, arg_70_2, arg_70_3)
	local var_70_0, var_70_1 = self:getRoomStructAndLocalCoordinate(arg_70_1)
	local var_70_2 = {}

	if not arg_70_3 then
		arg_70_3 = {}

		for iter_70_0, iter_70_1 in pairs((var_70_0:getVisibleArea())) do
			arg_70_3[iter_70_0] = iter_70_1
		end
	end

	for iter_70_2 = math.max(0, var_70_1.x - arg_70_2.width), math.min(var_70_1.x + arg_70_2.width, 19) do
		for iter_70_3 = math.max(0, var_70_1.y - arg_70_2.height), math.min(var_70_1.y + arg_70_2.height, 19) do
			local var_70_3 = table.concat({
				iter_70_2,
				iter_70_3
			}, "_")

			if not arg_70_3[var_70_3] then
				local var_70_4 = cc.p(iter_70_2, iter_70_3)

				var_70_2[var_70_3] = {
					pos = var_70_4
				}
				arg_70_3[var_70_3] = var_70_4
			end
		end
	end

	return var_70_2, arg_70_3
end

function TeamBattleMapData:getPlayerVisibleArea(arg_71_1)
	local var_71_0, var_71_1 = self:getPosVisibleArea(cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self:getRoomStructByRoomId(arg_71_1:getRoomId()), (arg_71_1:getPos()))), (arg_71_1:getVisibleSize()))

	if next(var_71_0) then
		return var_71_1
	end
end

function TeamBattleMapData:getVisibleAreaStr(arg_72_1)
	local var_72_0 = {}

	for iter_72_0, iter_72_1 in pairs(arg_72_1) do
		var_72_0[#var_72_0 + 1] = table.concat({
			iter_72_1.x,
			iter_72_1.y
		}, ":")
	end

	return var_72_0
end

function TeamBattleMapData:setTempArea(arg_73_1)
	self._tempArea = arg_73_1
end

function TeamBattleMapData:getTempArea()
	return self._tempArea
end

function TeamBattleMapData:getNewAreaByAddArea(arg_75_1, arg_75_2)
	local var_75_0 = {}

	table.merge(var_75_0, arg_75_1)
	table.merge(var_75_0, arg_75_2)

	return var_75_0
end

function TeamBattleMapData:updateMoviePathAndEvent(arg_76_1)
	for iter_76_0, iter_76_1 in ipairs(arg_76_1.events or {}) do
		self:getRoomStructByRoomId(g.core.config.team_battle_room_info.get(iter_76_1.grid_id).room_id):updateTiledEvent(iter_76_1)
	end

	local var_76_1 = self._playerMap[g.core.model.User:getId()]

	if arg_76_1.user then
		var_76_1 = self._playerMap[arg_76_1.user.user_id]

		self._playerMap[arg_76_1.user.user_id]:updateBaseInfo(arg_76_1.user)
	end

	local var_76_2 = self:getRoomStructByRoomId((var_76_1:getRoomId()))
	local var_76_3 = {}

	for iter_76_2, iter_76_3 in ipairs(arg_76_1.path_pos) do
		var_76_3[iter_76_2] = cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_76_2, iter_76_3))
	end

	var_76_1:setMoveRouteInfo({
		pathList = var_76_3,
		event = arg_76_1.events
	})
end

function TeamBattleMapData:updateMoviePath(arg_77_1)
	local var_77_0 = self._playerMap[g.core.model.User:getId()]

	if arg_77_1.user then
		var_77_0 = self._playerMap[arg_77_1.user.user_id]

		self._playerMap[arg_77_1.user.user_id]:updateBaseInfo(arg_77_1.user)
	end

	local var_77_1 = self:getRoomStructByRoomId((var_77_0:getRoomId()))
	local var_77_2 = {}

	for iter_77_0, iter_77_1 in ipairs(arg_77_1.path_pos) do
		var_77_2[iter_77_0] = cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_77_1, iter_77_1))
	end

	var_77_0:getMoveRouteInfo().pathList = var_77_2
end

function TeamBattleMapData:getMoviePath()
	return self._tempPathInfo
end

function TeamBattleMapData:getActionPoint()
	return g.core.model.User.shopData:getLeftCount(93) - g.core.model.User.shopData:getPlayBuyCount(93)
end

function TeamBattleMapData:getMapResult()
	return self._results
end

function TeamBattleMapData:clearMapResult(arg_81_1)
	local var_81_0 = self:getTiledStruct(self._results.grid_id)
	local var_81_1

	var_81_0:getEventInfo():triggerEvent()

	if not arg_81_1 then
		if self._results.is_win then
			var_81_0:finishEvent({
				kill_user_id = g.core.model.User:getId()
			})

			if var_81_0:getEventType() == TeamBattleConst.EVENT_TYPE.ROBBER then
				local var_81_2 = self:getRoomStructByRoomId(var_81_0:getBelongRoom())

				if var_81_2:canChallengeGuard() then
					var_81_2:unlockGuard()
				end
			end
		else
			var_81_0:getEventInfo():updateMonsterHp(self._results.enemy_hp_list)
		end

		var_81_1 = self._results.knight_hp_list
	else
		local var_81_3 = self:getPlayerStruct():getExtData()

		var_81_3.daily_give_up_times = var_81_3.daily_give_up_times + 1
	end

	self._results = nil

	return var_81_1
end

function TeamBattleMapData:challengeMonster(arg_82_1)
	local var_82_0 = self:getTiledStruct(arg_82_1.grid_id)
end

function TeamBattleMapData:updateMonster(arg_83_1)
	local var_83_0 = self:getTiledStruct(arg_83_1.grid_id)

	var_83_0:getEventInfo():triggerEvent()

	if not arg_83_1.is_give_up then
		if arg_83_1.is_win then
			var_83_0:finishEvent({
				kill_user_id = g.core.model.User:getId()
			})
		else
			var_83_0:updateEvent(arg_83_1.monster or arg_83_1.boss)
		end
	end

	self:updatePlayer({
		arg_83_1.user
	})
end

function TeamBattleMapData:updateBoss(arg_84_1)
	local var_84_0 = self:getTiledStruct(arg_84_1.grid_id)

	var_84_0:getEventInfo():triggerEvent()
	var_84_0:updateEvent(arg_84_1.boss)
	self:updatePlayer({
		arg_84_1.user
	})
end

function TeamBattleMapData:setBattleResult(arg_85_1)
	self._results = arg_85_1
end

function TeamBattleMapData:getCostCfg()
	return self._costPointCfg
end

function TeamBattleMapData:updateRoleSightTiled(arg_87_1, arg_87_2)
	local var_87_0 = self:getPlayerStruct(arg_87_1)

	self:getRoomStructByRoomId(var_87_0:getRoomId()):updateRoleSightTiled(var_87_0, arg_87_2)
end

function TeamBattleMapData:addScore(arg_88_1)
	self._score = self._score + arg_88_1
end

function TeamBattleMapData:getScore()
	return self._score
end

function TeamBattleMapData:setScore(arg_90_1)
	self._score = arg_90_1 or 0
end

function TeamBattleMapData:getHomeCfg(arg_91_1)
	return (g.core.config.team_battle_map_info.get(g.core.config.team_battle_room_info.get(arg_91_1).room_id, g.core.model.User.teamBattleData:getActivityId()))
end

function TeamBattleMapData:getMineRoom()
	return (self:getRoomStructByRoomId(self:getPlayerStruct():getRoomId()))
end

function TeamBattleMapData:getLeftPoint()
	return g.core.model.User.shopData:getLeftCount(93)
end

function TeamBattleMapData:isLastGuardTiled(arg_94_1)
	return self:getRoomStructByRoomId((arg_94_1:getBelongRoom())):getCfg().near_id == 0
end

return TeamBattleMapData
