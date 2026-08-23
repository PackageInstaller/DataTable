local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local MapConst = require("app.core.ksmap.MapConst")
local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local var_0_3 = g.core.model.User.explorationData
local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local ExplorationMapWorld = require("app.view.module.exploration.view.map.ExplorationMapWorld")
local ExplorationMapComp = class("ExplorationMapComp", require("app.fairyGUI.exploration.UI_ExplorationMapComp"))
local var_0_7 = 8

function ExplorationMapComp:ctor()
	self._roomList = {}
	self._playerPos = nil
	self._tiledWorld = nil
	self._movePosArr = {}
	self._moveCoordinate = nil
	self._moveFinishTimer = nil
	self._doNextTime = nil
	self._stage = nil
	self._waitTriggerEventInfo = nil

	self:_initTiledWorld()
	self:addListen(self.m_floorComp)
end

function ExplorationMapComp:_initTiledWorld()
	self._tiledWorld = ExplorationMapWorld.new(self)

	self._tiledWorld:startObserver(self.m_touchComp)
	self.m_mapRootNode:addNode(self._tiledWorld)
	self._tiledWorld:setWorldId(var_0_3:getMapData():getCurMapId())
end

function ExplorationMapComp:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_GETBOSSBATTLETEAM, handler(self, self._onS2CExplorationMove), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_MOVE, handler(self, self._onS2CExplorationMove), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_UNLOCKCELL, handler(self, self._onS2CExplorationUnlockCell), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EXPLORATION_TASK_CHANGE, handler(self, self._onTriggerTask), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_SKIP_NOTIFY_REFRESH, handler(self, self.onBattleNotifyRefresh), self)
end

function ExplorationMapComp:onLoad()
	self:_addCustomListener()
	self._tiledWorld:moveLastCenter()

	for iter_4_0, iter_4_1 in pairs((var_0_3:getMapData():getWaitBuffTab())) do
		self:_showBuffPop(iter_4_1)

		break
	end

	self.m_floorComp:updateCurComp()

	if var_0_3:getMapData():isBattleWin() then
		var_0_3:getMapData():resetBattleWin()
	end

	local var_4_0 = var_0_3:getMapData():getEventByType(ExplorationConst.EVENT_TYPE.TIP_TASK)

	if var_4_0 then
		g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
			unique_id = var_4_0.unique_id
		})
	end
end

function ExplorationMapComp:onBattleNotifyRefresh()
	self.m_floorComp:updateCurComp()
end

function ExplorationMapComp:onUnload()
	return
end

function ExplorationMapComp:getMapWorld()
	return self._tiledWorld
end

function ExplorationMapComp:moveToPoint(arg_8_1, arg_8_2)
	self._tiledWorld:moveCell2SC({
		x = arg_8_1,
		y = arg_8_2
	})
	self:onMapMoveEnd()
end

function ExplorationMapComp:getScreenCenterPoint()
	local var_9_0 = self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	})
	local var_9_1, var_9_2 = self:getMapWorld():getMapGround():pixelToCoord(var_9_0.x, var_9_0.y)

	return {
		x = var_9_1,
		y = var_9_2
	}
end

function ExplorationMapComp:getCenterPos()
	return
end

function ExplorationMapComp:checkIsMonsterPoint(arg_11_1, arg_11_2)
	if self._stage then
		local var_11_0, var_11_1 = self._stage:checkIsMonsterPoint(arg_11_1, arg_11_2)

		return var_11_0, var_11_1
	end

	return false
end

function ExplorationMapComp:updateFloorCompPos(arg_12_1, arg_12_2)
	self.m_floorComp:setPosition(arg_12_1, arg_12_2)
	self.m_floorComp:updateCurPos(arg_12_1, arg_12_2)
	self._tiledWorld:checkAndLoadParts(self:getCenterPos())
end

function ExplorationMapComp:updateTipIcon()
	if self._stage then
		return self._stage:updateTipIcon()
	end
end

function ExplorationMapComp:setStage(arg_14_1)
	self._stage = arg_14_1
end

function ExplorationMapComp:onMapMoveEnd()
	local var_15_0 = self:getScreenCenterPoint()
end

function ExplorationMapComp:getTargetPosTiledId(arg_16_1)
	return self._tiledWorld:getTargetPosTiledId(arg_16_1)
end

function ExplorationMapComp:_checkClickKnight(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = false
	local var_17_1 = var_0_3:getMapData():getTiledInfo(cc.p(arg_17_1 + 1, arg_17_2 + 1))

	if var_17_1 and var_17_1.type == "build" and var_17_1.value:getTiledMonster() ~= nil then
		local var_17_2 = self._tiledWorld:getMapGround():getHalfTileW()

		var_17_0 = arg_17_3.x > -var_17_2 / 2 and arg_17_3.x < var_17_2 / 2 and arg_17_3.y > -self._tiledWorld:getMapGround():getHalfTileH() / 2 and arg_17_3.y < 0
	end

	return var_17_0
end

function ExplorationMapComp:onSingleClick(arg_18_1, arg_18_2, arg_18_3)
	if self._moveCoordinate then
		return
	end

	if self:_checkClickKnight(arg_18_1, arg_18_2, arg_18_3) then
		arg_18_1 = arg_18_1 + 1
		arg_18_2 = arg_18_2 + 1
	end

	local var_18_0 = var_0_3:getMapData():getTiledInfo(cc.p(arg_18_1, arg_18_2))

	if not var_18_0 or var_18_0.type == "barrier" then
		g.core.module.ModuleManager:tip(g.core.lang:get(420688))

		return
	end

	self.m_floorComp:onSingleClick(arg_18_1, arg_18_2, (var_0_3:getMapData():getRouteArray(self.m_floorComp:getMainRoleCompCoordinate(), (cc.p(arg_18_1, arg_18_2)))))
end

function ExplorationMapComp:updateMainRolePos(arg_19_1)
	if self._moveCoordinate.x ~= arg_19_1.x or self._moveCoordinate.y ~= arg_19_1.y then
		self:_changeMoveCoordinateAndUpdatePosArr(arg_19_1)
	end

	local var_19_1 = self.m_floorComp:getMainRolePos()
	local var_19_2 = table.remove(self._movePosArr, 1)

	self.m_floorComp:updateMainRoleCompPos(var_19_2)

	local var_19_3 = cc.pSub(var_19_2, var_19_1)

	var_19_3.x = -var_19_3.x

	self._tiledWorld:moveWorld(var_19_3)

	if #self._movePosArr == 0 then
		self._tiledWorld:onOneRouteFinish()
	end
end

function ExplorationMapComp:_changeMoveCoordinateAndUpdatePosArr(arg_20_1, arg_20_2)
	arg_20_2 = arg_20_2 or self._moveCoordinate

	local var_20_0 = cc.p(ExplorationMapCommon.coordToCompPos(arg_20_2))
	local var_20_1 = cc.p(ExplorationMapCommon.coordToCompPos(arg_20_1))
	local var_20_2 = cc.pMul(cc.pSub(var_20_1, var_20_0), 1 / var_0_7)
	local var_20_3 = cc.pAdd(var_20_0, var_20_2)

	self._movePosArr = {}

	for iter_20_0 = 1, var_0_7 - 2 do
		var_20_3 = cc.pAdd(var_20_3, var_20_2)
		self._movePosArr[#self._movePosArr + 1] = var_20_3
	end

	self._movePosArr[#self._movePosArr + 1] = var_20_1
	self._moveCoordinate = arg_20_1

	if var_20_1.x > var_20_0.x then
		self.m_floorComp:updateMainRoleDir(MapConst.DIRECTION.RIGHT)
	else
		self.m_floorComp:updateMainRoleDir(MapConst.DIRECTION.LEFT)
	end
end

function ExplorationMapComp:onMainRoleMoveFinish()
	self.m_floorComp:mainRoleStopRun()

	if self._waitTriggerEventInfo then
		self:_onTriggerEvent()
	else
		self:_onMoveFinish()
	end
end

function ExplorationMapComp:_onMoveFinish(arg_22_1, arg_22_2)
	if self._moveFinishTimer then
		self:cancelSchedule(self._moveFinishTimer)
	end

	if arg_22_1 then
		self._moveFinishTimer = self:newScheduleOnce(handler(self, function(arg_23_0)
			if arg_22_2.x == arg_23_0._moveCoordinate.x and arg_22_2.y == arg_23_0._moveCoordinate.y then
				arg_23_0._moveCoordinate = nil
				arg_23_0._moveFinishTimer = nil
			end
		end), 0.2)
	else
		self._moveCoordinate = nil
	end
end

function ExplorationMapComp:getFloorComp()
	return self.m_floorComp
end

function ExplorationMapComp:receiveCompEvent(arg_25_1, arg_25_2)
	if arg_25_1 == "clickMonster" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = ExplorationConst.EVENT_SOURCE_TYPE.LOCAL
			}

			self:_onMoveToTiledByCoordinate(arg_25_2.routePath[#arg_25_2.routePath - 1])
		else
			self:_showChallengePop(arg_25_2.value)
		end

		return true
	elseif arg_25_1 == "clickMoveTiled" then
		if arg_25_2.value:getState() == ExplorationConst.MAP.TILED_STATE_UNLOCK then
			self:_onMoveToTiled(arg_25_2.value)
		elseif arg_25_2.value:getState() == ExplorationConst.MAP.TILED_STATE_CAN_UNLOCK then
			self:_unlockCell(arg_25_2.value, arg_25_2.routePath)
		end

		return true
	elseif arg_25_1 == "clickMoveShop" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = ExplorationConst.EVENT_SOURCE_TYPE.LOCAL
			}

			self:_onMoveToTiledByCoordinate(arg_25_2.routePath[#arg_25_2.routePath - 1])
		else
			self:_showShopPop(arg_25_2.value)
		end

		return true
	elseif arg_25_1 == "clickBuff" then
		if arg_25_2.routePath and #arg_25_2.routePath > 1 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = ExplorationConst.EVENT_SOURCE_TYPE.LOCAL
			}

			self:_onMoveToTiledByCoordinate(arg_25_2.routePath[#arg_25_2.routePath])
		else
			self:_showBuffPop(arg_25_2.value)
		end

		return true
	elseif arg_25_1 == "clickGame" then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.game.ExplorationTickGamePop").new(arg_25_2.value:getOriginInfo())))

		return true
	elseif arg_25_1 == "clickMirror" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = ExplorationConst.EVENT_SOURCE_TYPE.LOCAL
			}

			self:_onMoveToTiledByCoordinate(arg_25_2.routePath[#arg_25_2.routePath - 1])
		elseif not arg_25_2.value:getEventInfo().unique_id then
			self:_showChallengePop(arg_25_2.value)
		else
			self:_showMirrorRewardPop(arg_25_2.value)
		end

		return true
	elseif arg_25_1 == "triggerTask" then
		if arg_25_2.routePath and #arg_25_2.routePath > 2 then
			self._waitTriggerEventInfo = {
				event = arg_25_2.value:getEventInfo(),
				from = ExplorationConst.EVENT_SOURCE_TYPE.LOCAL
			}

			self:_onMoveToTiledByCoordinate(arg_25_2.routePath[#arg_25_2.routePath - 1])
		else
			g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
				unique_id = arg_25_2.value:getEventInfo().unique_id
			})
		end

		return true
	end
end

function ExplorationMapComp:_onMoveToTiledByCoordinate(arg_26_1)
	local var_26_0, var_26_1 = var_0_3:getMapData():getRoomStructAndLocalCoordinate(arg_26_1)

	self:_onMoveToTiled((var_26_0:getTiledStruct(var_26_1)))
end

function ExplorationMapComp:_onMoveToTiled(arg_27_1)
	local var_27_0 = arg_27_1:getCoordinate()

	g.core.network.GameNetProxy:send_C2S_Exploration_Move({
		room_id = arg_27_1:getBelongRoom(),
		x = var_27_0.x,
		y = var_27_0.y
	})
end

function ExplorationMapComp:_showChallengePop(arg_28_1)
	local var_28_0 = arg_28_1:getEventInfo()

	if var_28_0.type == ExplorationConst.EVENT_TYPE.ULTIMATUM then
		local var_28_1 = arg_28_1:getTiledMonster()

		g.core.module.ModuleManager:pushPopup(require("app.view.module.exploration.view.formation.ExplorationFormationChallengeBossPop").new({
			bossId = var_28_1.monsterId,
			battleTeam = var_28_1.battleTeam
		}), {
			touchDisappear = true
		})
	else
		local var_28_2 = {}

		if var_28_0.type == ExplorationConst.EVENT_TYPE.GUARD then
			local var_28_3 = arg_28_1:getTiledMonster()

			var_28_2.roomId = var_28_3.roomId
			var_28_2.direction = var_28_3.direction - 1
			var_28_2.monsterId = var_28_3.monsterId
			var_28_2.deBuffInfo = var_28_3.deBuffInfo
		else
			local var_28_4 = arg_28_1:getTiledMonster()

			var_28_2.event = var_28_0
			var_28_2.deBuffInfo = var_28_4.deBuffInfo
			var_28_2.diffTip = var_28_4.diffTip
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.exploration.view.formation.ExplorationFormationChallengePop").new(var_28_2), {
			touchDisappear = true
		})
	end
end

function ExplorationMapComp:_showBuffPop(arg_29_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.exploration.view.buff.ExplorationBuffSelectPop").new(arg_29_1), {
		ignoreTouch = true
	})
end

function ExplorationMapComp:_showShopPop(arg_30_1)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.shop.ExplorationShopPop").new(arg_30_1)))
end

function ExplorationMapComp:_showMirrorRewardPop(arg_31_1)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.map.ExplorationMapMirrorPop").new(arg_31_1)))
end

function ExplorationMapComp:_onTriggerTask()
	self:dispatchCompEvent("taskStateChange")

	local var_32_0 = var_0_3:getTaskData():getCurTaskInfo()

	if not var_32_0 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
		id = tonumber(var_32_0.cfg.story),
		callback = handler(self, function(arg_33_0)
			arg_33_0:_onShowTaskPop()
		end)
	})
end

function ExplorationMapComp:_onShowTaskPop()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.task.ExplorationTaskPop").new((var_0_3:getTaskData():getCurTaskInfo()))))
end

function ExplorationMapComp:_onTriggerEvent()
	local var_35_0, var_35_1 = ExplorationMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_0_3:getMapData():getRoomStructByRoomId(self._waitTriggerEventInfo.event.room_id), cc.p(self._waitTriggerEventInfo.event.x, self._waitTriggerEventInfo.event.y))

	handler(self, function(arg_36_0)
		arg_36_0.m_floorComp:onSingleClick(var_35_0, var_35_1, {})

		if arg_36_0._moveCoordinate then
			arg_36_0:_onMoveFinish(true, (cc.p(arg_36_0._moveCoordinate.x, arg_36_0._moveCoordinate.y)))
		end
	end)()

	self._waitTriggerEventInfo = nil
end

function ExplorationMapComp:_unlockCell(arg_37_1, arg_37_2)
	local var_37_0 = var_0_3:getMapData():getActionPoint()
	local var_37_1 = arg_37_1:getBelongRoom()
	local var_37_2 = arg_37_1:getCoordinate()

	local function var_37_3()
		g.core.network.GameNetProxy:send_C2S_Exploration_UnlockCell({
			room_id = var_37_1,
			x = var_37_2.x,
			y = var_37_2.y
		})
	end

	if arg_37_2 and #arg_37_2 > 1 then
		self:_showUnlockCellTip((handler(self, function(arg_39_0)
			if var_37_0 < 1 then
				g.core.module.ModuleManager:tip(g.core.lang:get(420677))

				return
			end

			if #arg_37_2 > 2 then
				arg_39_0._waitTriggerEventInfo = {
					event = arg_37_1:getEventInfo(),
					from = ExplorationConst.EVENT_SOURCE_TYPE.LOCAL
				}

				arg_39_0:_onMoveToTiledByCoordinate(arg_37_2[#arg_37_2 - 1])
			elseif #arg_37_2 > 1 then
				var_37_3()
			end
		end)))
	else
		var_37_3()
	end
end

function ExplorationMapComp:isRoleMoving()
	return self._moveCoordinate ~= nil
end

function ExplorationMapComp:_showUnlockCellTip(arg_41_1)
	local var_41_0 = g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_EXPLORATION_MAP_UNLOCK_CELL_TIP)

	local function var_41_1()
		arg_41_1()
		g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_EXPLORATION_MAP_UNLOCK_CELL_TIP, var_41_0)
	end

	if var_41_0 then
		var_41_1()

		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = "",
		desc = g.core.lang:get(420687, {
			num = g.core.config.exploration_parameter_info.get(ExplorationConst.PARAMETER_ACTION_COST_ID).parameter
		}),
		tip = {
			txt = g.core.lang:get(408110)
		},
		onCheck = function(arg_43_0)
			var_41_0 = arg_43_0
		end,
		onConfirm = var_41_1
	}), {
		touchDisappear = true
	})
end

function ExplorationMapComp:triggerTaskByNet()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.map.ExplorationMapTipPop").new(g.core.lang:get(420696), (handler(self, self._onTriggerTask)))))
end

function ExplorationMapComp:_onS2CExplorationUnlockCell(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_4.event then
		self._moveCoordinate = cc.p(0, 0)
		self._waitTriggerEventInfo = {
			event = arg_45_4.event,
			from = ExplorationConst.EVENT_SOURCE_TYPE.SERVER
		}

		local var_45_0, var_45_1 = ExplorationMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_0_3:getMapData():getRoomStructByRoomId(arg_45_4.event.room_id), cc.p(arg_45_4.event.x, arg_45_4.event.y))

		self.m_floorComp:playEventEffect(var_45_0, var_45_1, handler(self, self._onS2CExplorationMove))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_LAND_MOVE)
	else
		self:_onS2CExplorationMove()
	end
end

function ExplorationMapComp:_onS2CExplorationMove()
	local var_46_0 = var_0_3:getMapData()
	local var_46_1 = self.m_floorComp:getMainRoleCompCoordinate()
	local var_46_2 = var_46_0:getMainRoleCoordinate()

	if var_46_1.x ~= var_46_2.x or var_46_1.y ~= var_46_2.y then
		local var_46_3 = var_46_0:getRouteArray(var_46_1, var_46_2) or {}

		if #var_46_3 > 11 then
			self._tiledWorld:moveCell2SC(var_46_2)
			self.m_floorComp:mainRoleJumpToCoordinate(var_46_2)
			self:onMainRoleMoveFinish()
		else
			table.remove(var_46_3, 1)
			self._tiledWorld:moveCell2SC(var_46_1)
			self:_changeMoveCoordinateAndUpdatePosArr(var_46_3[1], var_46_1)
			self._tiledWorld:updateMainRoleRoutePath(var_46_3)
			self.m_floorComp:mainRoleStartRun()
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_FLOOR_MOVE)
	else
		self._moveCoordinate = var_46_2

		self:onMainRoleMoveFinish()
	end

	self.m_floorComp:updateCurComp()
end

return ExplorationMapComp
