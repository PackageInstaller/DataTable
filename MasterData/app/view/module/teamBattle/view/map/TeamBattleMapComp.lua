local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local MapConst = require("app.core.ksmap.MapConst")
local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_3 = g.core.model.User.teamBattleData
local TeamBattleMapCommon = require("app.view.module.teamBattle.common.TeamBattleMapCommon")
local TeamBattleMapWorld = require("app.view.module.teamBattle.view.map.TeamBattleMapWorld")
local TeamBattleMapComp = class("TeamBattleMapComp", require("app.fairyGUI.teamBattle.UI_TeamBattleMapComp"))
local var_0_7 = 12

function TeamBattleMapComp:ctor()
	self._roomList = {}
	self._tiledWorld = nil
	self._moveRoleMap = {}
	self._moveArrMap = {}
	self._moveFinishTimer = nil
	self._doNextTime = nil
	self._stage = nil
	self._waitTriggerEventInfo = nil

	self:_initTiledWorld()
	self:addListen(self.m_floorComp)
end

function TeamBattleMapComp:_initTiledWorld()
	self._tiledWorld = TeamBattleMapWorld.new(self)

	self._tiledWorld:startObserver(self.m_touchComp)
	self.m_mapRootNode:addNode(self._tiledWorld)
	self._tiledWorld:setWorldId(var_0_3:getMapData():getCurMapId())
end

function TeamBattleMapComp:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_MOVE, handler(self, self._onS2CTeamBattleMove), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYMOVE, handler(self, self._onS2CTeamBattleNotifyMove), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SELECTGAME, handler(self, self._onS2CTeamBattleSelectGame), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SELECTBUFF, handler(self, self._onS2CTeamBattleSelectBuff), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_MINE, handler(self, self._onS2CTeamBattleMine), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYMINE, handler(self, self._onS2CTeamBattleNotifyMine), self)
end

function TeamBattleMapComp:onLoad()
	self:_addCustomListener()

	for iter_4_0, iter_4_1 in pairs((var_0_3:getMapData():getWaitBuffTab())) do
		self:_showBuffPop(iter_4_1)

		break
	end

	self.m_floorComp:updateCurComp()
end

function TeamBattleMapComp:onUnload()
	for iter_5_0, iter_5_1 in pairs(self._moveRoleMap) do
		if next(iter_5_1:getMoveRouteInfo()) then
			local var_5_0 = iter_5_1:getMoveRouteInfo().pathList

			self:_onRoleJumpTo(var_5_0[#var_5_0], iter_5_1)
		end
	end

	self._moveRoleMap = {}
end

function TeamBattleMapComp:getMapWorld()
	return self._tiledWorld
end

function TeamBattleMapComp:moveToPoint(arg_7_1, arg_7_2)
	self._tiledWorld:moveCell2SC({
		x = arg_7_1,
		y = arg_7_2
	})
	self:onMapMoveEnd()
end

function TeamBattleMapComp:getScreenCenterPoint()
	local var_8_0 = self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	})
	local var_8_1, var_8_2 = self:getMapWorld():getMapGround():pixelToCoord(var_8_0.x, var_8_0.y)

	return {
		x = var_8_1,
		y = var_8_2
	}
end

function TeamBattleMapComp:getCenterPos()
	return
end

function TeamBattleMapComp:checkIsMonsterPoint(arg_10_1, arg_10_2)
	if self._stage then
		local var_10_0, var_10_1 = self._stage:checkIsMonsterPoint(arg_10_1, arg_10_2)

		return var_10_0, var_10_1
	end

	return false
end

function TeamBattleMapComp:updateFloorCompPos(arg_11_1, arg_11_2)
	self.m_floorComp:setPosition(arg_11_1, arg_11_2)
	self.m_floorComp:updateCurPos(arg_11_1, arg_11_2)
	self._tiledWorld:checkAndLoadParts(self:getCenterPos())
end

function TeamBattleMapComp:updateTipIcon()
	if self._stage then
		return self._stage:updateTipIcon()
	end
end

function TeamBattleMapComp:setStage(arg_13_1)
	self._stage = arg_13_1
end

function TeamBattleMapComp:onMapMoveEnd()
	return
end

function TeamBattleMapComp:_checkClickKnight(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = false
	local var_15_1 = var_0_3:getMapData():getTiledInfo(cc.p(arg_15_1 + 1, arg_15_2 + 1))

	if var_15_1 and var_15_1.type == "build" and var_15_1.value:getUIInfo().knightInfo ~= nil then
		local var_15_2 = self._tiledWorld:getMapGround():getHalfTileW()

		var_15_0 = arg_15_3.x > -var_15_2 / 2 and arg_15_3.x < var_15_2 / 2 and arg_15_3.y > -self._tiledWorld:getMapGround():getHalfTileH() / 2 and arg_15_3.y < 0
	end

	return var_15_0
end

function TeamBattleMapComp:onSingleClick(arg_16_1, arg_16_2, arg_16_3)
	if self:_checkClickKnight(arg_16_1, arg_16_2, arg_16_3) then
		arg_16_1 = arg_16_1 + 1
		arg_16_2 = arg_16_2 + 1
	end

	local var_16_0 = var_0_3:getMapData():getTiledInfoRange(cc.p(arg_16_1, arg_16_2))

	if not var_16_0 or var_16_0.type == "barrier" and var_16_0.value ~= "" or var_16_0.type == "build" and var_16_0.value:getState() == TeamBattleConst.MAP.TILED_STATE_LOCK then
		g.core.module.ModuleManager:tip(g.core.lang:get(420688))

		return
	end

	self.m_floorComp:onSingleClick(var_16_0.coordinate.x, var_16_0.coordinate.y, (var_0_3:getMapData():getRouteArray(self.m_floorComp:getRoleCompCoordinate(g.core.model.User:getId()), (cc.p(arg_16_1, arg_16_2)))))
end

function TeamBattleMapComp:updateMoveRole()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self._moveRoleMap) do
		local var_17_1 = self.m_floorComp:getRoleComp(iter_17_0)
		local var_17_2 = iter_17_1:getMoveRouteInfo()

		if next(var_17_2) and var_17_1:isVisible() then
			if iter_17_1:isSelf() then
				self._tiledWorld:setDragClickEnable(false)
			end

			if var_17_2.pathList[1] then
				self:_updateOneRoleMove(iter_17_1)
			else
				iter_17_1:clearRouteList()
				self:onRoleMoveFinish(iter_17_1)

				var_17_0[#var_17_0 + 1] = iter_17_0
			end
		else
			var_17_0[#var_17_0 + 1] = iter_17_0

			iter_17_1:clearRouteList()
		end
	end

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		self._moveRoleMap[iter_17_3] = nil
	end
end

function TeamBattleMapComp:_updateOneRoleMove(arg_18_1)
	local var_18_0 = arg_18_1:getPlayerId()
	local var_18_1 = arg_18_1:getMoveRouteInfo()
	local var_18_2 = var_18_1.pathList[1]
	local var_18_3 = self.m_floorComp:getRoleCompCoordinate(var_18_0)

	if var_18_1.pathList[1].x == var_18_3.x and var_18_2.y == var_18_3.y then
		table.remove(var_18_1.pathList, 1)

		var_18_2 = var_18_1.pathList[1]

		self:_changeMoveCoordinateAndUpdatePosArr(var_18_1.pathList[1], var_18_3, var_18_0)
	end

	local var_18_4 = self.m_floorComp:getRolePos(var_18_0)
	local var_18_5 = table.remove(self._moveArrMap[var_18_0], 1)

	self.m_floorComp:updateRoleCompPos(var_18_5, var_18_0)

	if arg_18_1:isSelf() then
		local var_18_6 = cc.pSub(var_18_5, var_18_4)

		var_18_6.x = -var_18_6.x

		self._tiledWorld:moveWorld(var_18_6)
	end

	if #self._moveArrMap[var_18_0] == 0 then
		self:_onOneRoleMoveToCoordinate(var_18_2, var_18_0)

		if #var_18_1.pathList <= 1 then
			self:onRoleMoveFinish(arg_18_1)
		end
	end
end

function TeamBattleMapComp:_onOneRoleMoveToCoordinate(arg_19_1, arg_19_2)
	local var_19_0, var_19_1 = var_0_3:getMapData():getRoomStructAndLocalCoordinate(arg_19_1)

	var_0_3:getMapData():updateRoleSightTiled(arg_19_2, var_19_1)
	self.m_floorComp:updateRoleCoordinate(arg_19_1, arg_19_2)
	self.m_floorComp:updateCurComp()
	var_19_0:removeTiledFormChangeDic(arg_19_2)

	if not self._moveRoleMap[arg_19_2]:isSelf() then
		return
	end

	local var_19_2 = var_19_0:getTiledStruct(var_19_1)

	if var_19_2 then
		local var_19_3 = var_19_2:getCfg().id

		for iter_19_0, iter_19_1 in ipairs(self._moveRoleMap[arg_19_2]:getMoveRouteInfo().event or {}) do
			if iter_19_1.grid_id == var_19_3 then
				self.m_floorComp:getRoleComp(g.core.model.User:getId()):playTrapEffect(handler(self, function(arg_20_0)
					arg_20_0:_onShowTrapPop(var_19_2:getEventInfo())
				end))
			end
		end
	end
end

function TeamBattleMapComp:_changeMoveCoordinateAndUpdatePosArr(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = cc.p(TeamBattleMapCommon.coordToCompPos(arg_21_2))
	local var_21_1 = cc.p(TeamBattleMapCommon.coordToCompPos(arg_21_1))
	local var_21_2 = cc.pMul(cc.pSub(var_21_1, var_21_0), 1 / var_0_7)
	local var_21_3 = cc.pAdd(var_21_0, var_21_2)
	local var_21_4 = {}

	for iter_21_0 = 1, var_0_7 - 2 do
		var_21_3 = cc.pAdd(var_21_3, var_21_2)
		var_21_4[#var_21_4 + 1] = var_21_3
	end

	var_21_4[#var_21_4 + 1] = var_21_1
	self._moveArrMap[arg_21_3] = var_21_4

	if var_21_1.x > var_21_0.x then
		self.m_floorComp:updateRoleDir(MapConst.DIRECTION.RIGHT, arg_21_3)
	else
		self.m_floorComp:updateRoleDir(MapConst.DIRECTION.LEFT, arg_21_3)
	end
end

function TeamBattleMapComp:onRoleMoveFinish(arg_22_1, arg_22_2)
	if arg_22_2 then
		var_0_3:getMapData():updateRoleSightTiled(arg_22_1:getPlayerId())
	end

	local var_22_0 = arg_22_1:getPlayerId()

	arg_22_1:clearRouteList()
	self.m_floorComp:onRoleStopRun(var_22_0)

	if arg_22_1:isSelf() then
		self._tiledWorld:setDragClickEnable(true)

		if self._waitTriggerEventInfo then
			self:_onTriggerEvent()
		else
			self:_onMoveFinish(nil, nil, var_22_0)
		end
	else
		self.m_floorComp:updateCurComp()
	end

	self._moveRoleMap[var_22_0] = nil
end

function TeamBattleMapComp:_onMoveFinish(arg_23_1, arg_23_2, arg_23_3)
	return
end

function TeamBattleMapComp:getFloorComp()
	return self.m_floorComp
end

function TeamBattleMapComp:receiveCompEvent(arg_25_1, arg_25_2)
	if arg_25_1 == "clickMonster" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			self:_showChallengePop(arg_25_2.value)
		end

		return true
	elseif arg_25_1 == "clickMoveTiled" then
		if arg_25_2.value:getState() == TeamBattleConst.MAP.TILED_STATE_IN_SIGHT then
			self:_onMoveTo(arg_25_2.routePath)
		elseif arg_25_2.value:getState() == TeamBattleConst.MAP.TILED_STATE_CAN_UNLOCK then
			self:_unlockCell(arg_25_2.value, arg_25_2.routePath)
		end

		return true
	elseif arg_25_1 == "clickMoveShop" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			self:_showShopPop(arg_25_2.value)
		end

		return true
	elseif arg_25_1 == "clickBuff" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			self:_showBuffPop(arg_25_2.value)
		end

		return true
	elseif arg_25_1 == "clickGame" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		elseif arg_25_2.value:getEventInfo():getState() == TeamBattleConst.EVENT_STATE.NONE then
			self:_doClickGame(arg_25_2.value)
		else
			g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.game.TeamBattleTickGamePop").new(arg_25_2.value:getEventInfo():getNetInfo())))
		end

		return true
	elseif arg_25_1 == "clickBoss" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			self:_showChallengePop(arg_25_2.value)
		end
	elseif arg_25_1 == "clickMine" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			local var_25_0 = arg_25_2.value

			if false then
				g.core.network.GameNetProxy:send_C2S_TeamBattle_Mine({
					grid_id = var_25_0:getEventInfo():getEventInfo().grid
				})
			else
				g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.pop.TeamBattleMinePop").new(var_25_0:getEventInfo()), {
					touchDisappear = true
				})
			end
		end
	elseif arg_25_1 == "clickMoveTelPort" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			g.core.network.GameNetProxy:send_C2S_TeamBattle_EnterRoom({
				tp = 1,
				value = arg_25_2.value:getCfg().id
			})
		end
	elseif arg_25_1 == "clickEmptyTiled" then
		self:_onMoveTo(arg_25_2.routePath)
	elseif arg_25_1 == "clickRecover" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.pop.TeamBattleHealPop").new(arg_25_2.value:getEventInfo()), {
				touchDisappear = true
			})
		end

		return true
	elseif arg_25_1 == "clickRevival" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = TeamBattleConst.EVENT_SOURCE_TYPE.LOCAL
			}

			table.remove(arg_25_2.routePath, #arg_25_2.routePath)
			self:_onMoveTo(arg_25_2.routePath)
		else
			self:_showRevivePop(arg_25_2.value)
		end

		return true
	end
end

function TeamBattleMapComp:_doClickGame(arg_26_1)
	g.core.network.GameNetProxy:send_C2S_TeamBattle_SelectGame({
		grid_id = arg_26_1:getCfg().id
	})
end

function TeamBattleMapComp:_onS2CTeamBattleSelectGame(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	self:updateCurMap()
	self:_showBuffEffect(function()
		g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.game.TeamBattleTickGamePop").new(var_0_3:getMapData():getTiledStruct(arg_27_4.grid_id):getEventInfo():getNetInfo())))
	end)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_HuangjinGame)
end

function TeamBattleMapComp:_onS2CTeamBattleSelectBuff(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	self:_showBuffEffect()
end

function TeamBattleMapComp:_onS2CTeamBattleNotifyMine(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	local var_30_0 = g.core.config.team_battle_room_info.get(arg_30_4.grid_id)
	local var_30_1 = g.core.config.team_battle_map_info.get(var_30_0.room_id, var_0_3:getActivityId())
	local var_30_2 = self.m_floorComp:getFloorChildComp((cc.p(TeamBattleMapCommon.getGlobalCoordinateByRoomPosAndRoomCoordinate(var_30_1.room_x, var_30_1.room_y, cc.p(var_30_0.x, var_30_0.y)))))

	if var_30_2 then
		var_30_2:playMineEff()
	end
end

function TeamBattleMapComp:_onS2CTeamBattleMine(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self:newScheduleOnce(function()
		g.core.module.ModuleManager:awardSummary(arg_31_4.awards)
	end, 1)
end

function TeamBattleMapComp:_onMoveTo(arg_33_1)
	arg_33_1 = arg_33_1 or {}

	local var_33_0 = arg_33_1[#arg_33_1]
	local var_33_1 = self.m_floorComp:getRoleCompCoordinate(g.core.model.User:getId())

	if arg_33_1[#arg_33_1].x == var_33_1.x and var_33_0.y == var_33_1.y then
		g.core.module.ModuleManager:tip(g.core.lang:get(427145))

		return
	end

	local var_33_2 = {}
	local var_33_3 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		local var_33_4, var_33_5 = var_0_3:getMapData():getRoomStructAndLocalCoordinate(iter_33_1)
		local var_33_6 = var_33_4:getTiledStruct(var_33_5)

		var_33_3[iter_33_0] = var_33_5

		if var_33_6 then
			var_33_2[#var_33_2 + 1] = var_33_6:getCfg().id
		end
	end

	g.core.network.GameNetProxy:send_C2S_TeamBattle_Move({
		path_pos = var_33_3,
		path_grid_ids = var_33_2
	})
end

function TeamBattleMapComp:_showChallengePop(arg_34_1)
	local var_34_0 = arg_34_1:getEventInfo()
	local var_34_1 = var_34_0:getEventType()

	if var_34_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS1 or var_34_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS2 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.pop.TeamBattleLimitBossPop").new(var_34_0), {
			touchDisappear = true
		})
	else
		local var_34_2 = {}

		if var_34_1 == TeamBattleConst.EVENT_TYPE.GUARD then
			local var_34_3 = var_34_0:getEventInfo().monsterInfo

			var_34_2.roomId = var_34_3.roomId
			var_34_2.monsterId = var_34_3.monsterId
		else
			var_34_2.event = var_34_0:getEventInfo()
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.pop.TeamBattleChallengePop").new(var_34_0), {
			touchDisappear = true
		})
	end
end

function TeamBattleMapComp:_showBuffPop(arg_35_1)
	print("TeamBattleBuffSelectPop----------------->_showBuffPop")
	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.bag.TeamBattleBuffSelectPop").new(arg_35_1:getEventInfo()), {
		ignoreTouch = true
	})
end

function TeamBattleMapComp:_showShopPop(arg_36_1)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.shop.TeamBattleShopPop").new(arg_36_1:getEventInfo())))
end

function TeamBattleMapComp:_showRevivePop(arg_37_1)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.pop.TeamBattleRevivePop").new(arg_37_1:getEventInfo())))
end

function TeamBattleMapComp:_onTriggerTask()
	self:dispatchCompEvent("taskStateChange")

	local var_38_0 = var_0_3:getTaskData():getCurTaskInfo()

	if not var_38_0 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
		id = tonumber(var_38_0.cfg.story),
		callback = handler(self, function(arg_39_0)
			arg_39_0:_onShowTaskPop()
		end)
	})
end

function TeamBattleMapComp:_onShowTrapPop(arg_40_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.pop.TeamBattleTrapPop").new({
		buffId = arg_40_1:getEventInfo().value
	}), {
		touchDisappear = true
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Trap)
end

function TeamBattleMapComp:_onTriggerEvent()
	local var_41_0 = self._waitTriggerEventInfo.event:getEventInfo()
	local var_41_1 = g.core.config.team_battle_room_info.get(var_41_0.grid)
	local var_41_2, var_41_3 = TeamBattleMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_0_3:getMapData():getRoomStructByRoomId(var_41_0.room), cc.p(var_41_1.x, var_41_1.y))

	handler(self, function(arg_42_0)
		arg_42_0.m_floorComp:onSingleClick(var_41_2, var_41_3, {})
		arg_42_0:_onMoveFinish()
	end)()

	self._waitTriggerEventInfo = nil
end

function TeamBattleMapComp:isRoleMoving()
	return next(var_0_3:getMapData():getPlayerStruct():getMoveRouteInfo())
end

function TeamBattleMapComp:_showUnlockCellTip(arg_44_1)
	local var_44_0 = g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_EXPLORATION_MAP_UNLOCK_CELL_TIP)

	local function var_44_1()
		arg_44_1()
		g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_EXPLORATION_MAP_UNLOCK_CELL_TIP, var_44_0)
	end

	if var_44_0 then
		var_44_1()

		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = "",
		desc = g.core.lang:get(420687, {
			num = g.core.config.exploration_parameter_info.get(TeamBattleConst.PARAMETER_ACTION_COST_ID).parameter
		}),
		tip = {
			txt = g.core.lang:get(408110)
		},
		onCheck = function(arg_46_0)
			var_44_0 = arg_46_0
		end,
		onConfirm = var_44_1
	}), {
		touchDisappear = true
	})
end

function TeamBattleMapComp:_onS2CTeamBattleMove()
	self:_onRoleStartMove(var_0_3:getMapData():getPlayerStruct())
end

function TeamBattleMapComp:_onS2CTeamBattleNotifyMove(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = var_0_3:getMapData():getPlayerStruct(arg_48_4.user_id)

	if var_48_0:isSelf() then
		return
	end

	if self.m_floorComp:getRoleComp(arg_48_4.user_id):isVisible() then
		self:_onRoleStartMove(var_48_0)
	else
		var_48_0:clearRouteList()
		self.m_floorComp:updateRoleCoordinate(var_0_3:getMapData():getRoleCoordinate(arg_48_4.user_id), arg_48_4.user_id)
	end
end

function TeamBattleMapComp:_onRoleStartMove(arg_49_1)
	local var_49_0 = arg_49_1:getPlayerId()

	self._moveRoleMap[var_49_0] = arg_49_1

	local var_49_1 = var_0_3:getMapData()
	local var_49_2 = arg_49_1:getMoveRouteInfo().pathList

	if var_49_2[1].x ~= var_49_2[#var_49_2].x or var_49_2[1].y ~= var_49_2[#var_49_2].y then
		local var_49_3 = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.VISIBLE_LENGTH).parameter
		local var_49_5 = {}

		for iter_49_0, iter_49_1 in ipairs(var_49_2) do
			local var_49_6, var_49_7 = var_49_1:getPosVisibleArea(iter_49_1, cc.size(var_49_3, var_49_3), nil)

			if next(var_49_6) then
				var_49_5[iter_49_1.x .. "_" .. iter_49_1.y] = var_49_6
			end
		end

		var_49_1:setTempArea(var_49_5)

		if next(var_49_5) then
			local var_49_9 = var_0_3:getMapData():getRoomStructByRoomId(arg_49_1:getRoomId()):getVisibleArea()

			for iter_49_2, iter_49_3 in pairs(var_49_5) do
				for iter_49_4, iter_49_5 in pairs(iter_49_3) do
					var_49_9[iter_49_4] = iter_49_5.pos
				end
			end

			g.core.network.GameNetProxy:send_C2S_TeamBattle_SetVisibleArea({
				visible_area = var_0_3:getMapData():getVisibleAreaStr(var_49_9)
			})
		end

		if #var_49_2 > 999999 then
			self:_onRoleJumpTo(var_49_2[#var_49_2], arg_49_1)

			if arg_49_1:isSelf() then
				self._tiledWorld:moveCell2SC(var_49_2[#var_49_2])
				self._tiledWorld:setDragClickEnable(false)
			end

			self:onRoleMoveFinish(arg_49_1, true)
		else
			table.remove(var_49_2, 1)
			self:_changeMoveCoordinateAndUpdatePosArr(var_49_2[1], var_49_2[1], var_49_0)
			self.m_floorComp:onRoleStartRun(var_49_0)

			if arg_49_1:isSelf() then
				self._tiledWorld:moveCell2SC(var_49_2[1])
				self._tiledWorld:setDragClickEnable(false)
			end
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_FLOOR_MOVE)
	end

	if arg_49_1:isSelf() then
		self.m_floorComp:updateCurComp()
	end
end

function TeamBattleMapComp:_onRoleJumpTo(arg_50_1, arg_50_2)
	self.m_floorComp:onRoleJumpToCoordinate(arg_50_1, (arg_50_2:getPlayerId()))

	if arg_50_2:isSelf() then
		self._tiledWorld:moveCell2SC(arg_50_1)
		self._tiledWorld:setDragClickEnable(false)
	end

	self:onRoleMoveFinish(arg_50_2, true)
end

function TeamBattleMapComp:updateCurMap()
	self.m_floorComp:updateCurComp()
	self.m_floorComp:updateRole()
end

function TeamBattleMapComp:_showBuffEffect(arg_52_1)
	self.m_floorComp:getRoleComp(g.core.model.User:getId()):playBuffEffect(arg_52_1)
end

function TeamBattleMapComp:onPlayerTelportToRoom()
	local var_53_0 = g.core.model.User:getId()

	self._moveRoleMap[var_53_0] = nil

	var_0_3:getMapData():getPlayerStruct():clearRouteList()
	self.m_floorComp:onRoleStopRun(var_53_0)
	self._tiledWorld:setDragClickEnable(true)
	self._tiledWorld:moveCell2SC((var_0_3:getMapData():getRoleCoordinate()))
	self.m_floorComp:getRoleComp(var_53_0):playRoleTelportEffect()
end

return TeamBattleMapComp
