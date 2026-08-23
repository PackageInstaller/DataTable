local KsMath = require("app.core.utils.KsMath")
local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationMapGround = require("app.view.module.exploration.view.map.ExplorationMapGround")
local ExplorationMapTouch = require("app.view.module.exploration.view.map.ExplorationMapTouch")
local ExplorationEntityFactory = require("app.view.module.exploration.view.map.entity.ExplorationEntityFactory")
local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local ExplorationMapWorld = class("ExplorationMapWorld", function()
	return cc.Node:create()
end)

function ExplorationMapWorld:ctor(arg_2_1)
	self._fatherStage = arg_2_1
	self._vislGround = nil
	self._worldId = -1
	self._minMoveX = 0
	self._maxMoveX = 0
	self._minMoveY = 0
	self._maxMoveY = 0
	self._entityFieldDict = {}
	self._lastPosSC = cc.p(-1000, -1000)
	self._mapTouch = nil
	self._orgCoord = nil
	self._followCenter = nil

	self:onNodeEvent()
end

function ExplorationMapWorld:setWorldId(arg_3_1)
	self._worldId = arg_3_1

	if not self._vislGround then
		self._orgCoord = cc.p(0, 0)

		self:_doCreateGround()
		self:_initMoveRange()
		self:_doInitTouchMatch()
	end
end

function ExplorationMapWorld:_doCreateGround()
	self._vislGround = ExplorationMapGround.new(self)

	self:addChild(self._vislGround)

	return self._vislGround
end

function ExplorationMapWorld:_doInitTouchMatch()
	self._mapTouch = ExplorationMapTouch.new(self)
end

function ExplorationMapWorld:_doTickUpdate(arg_6_1)
	if self._worldRoutePath then
		if #self._worldRoutePath > 0 then
			self:getMapStage():updateMainRolePos(self._worldRoutePath[1])
		else
			self:getMapStage():onMainRoleMoveFinish()

			self._worldRoutePath = nil
		end
	end

	self:_checkFollowing(arg_6_1)
	self:_autoInertiaUpdate(arg_6_1)
end

function ExplorationMapWorld:doDragWorld(arg_7_1)
	if self._followCenter or self._worldRoutePath then
		return
	end

	self:moveWorld(arg_7_1)
end

function ExplorationMapWorld:doCreateFactory()
	return ExplorationEntityFactory
end

function ExplorationMapWorld:_initMoveRange()
	local var_9_0 = self:getMapGround()
	local var_9_1 = var_9_0:getMapHeight()
	local var_9_2 = self:getMapGround():getHalfTileH()

	self._minMoveX = -var_9_0
	self._maxMoveX = self:getMapGround():getMapWidth()
	self._minMoveY = var_9_1 / 2 - var_9_2 - self._maxMoveX / 2
	self._maxMoveY = var_9_1 / 2 - var_9_2 + self._maxMoveX / 2
end

function ExplorationMapWorld:_resetMoveRangeY(arg_10_1)
	local var_10_0 = math.abs(arg_10_1)

	return self._minMoveY + var_10_0 / 2, self._maxMoveY - var_10_0 / 2
end

function ExplorationMapWorld:_checkFollowing(arg_11_1)
	if self._followCenter == nil then
		return
	end

	local var_11_0 = self:convertScreenCenter()
	local var_11_1 = KsMath.calculateDistance(self._followCenter, var_11_0)

	if var_11_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_11_2, var_11_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_11_0, ExplorationConst.MAP_MOVE_SPEED * (var_11_1 / 200) * arg_11_1)))

	if var_11_2 or var_11_3 then
		self._followCenter = nil
	end
end

function ExplorationMapWorld:_autoInertiaUpdate(arg_12_1)
	if ExplorationConst.MAP_DRAG_INERTIA_CLOSE then
		return
	end

	if self._autoInertiaDir == nil then
		return
	end

	local var_12_0, var_12_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - ExplorationConst.MAP_DRAG_ACCELERATE

	if var_12_0 or var_12_1 or self._autoInertiaDist <= 0 then
		if self._mapInMove then
			self._mapInMove = false

			self:mapMoveEnd()
		end

		self._autoInertiaDir = nil
	end

	self._mapInMove = true
end

function ExplorationMapWorld:getTargetPosTiledId(arg_13_1)
	if self._vislGround then
		return self._vislGround:getTargetPosTiledId(arg_13_1)
	end

	return 0
end

function ExplorationMapWorld:checkAndLoadParts(arg_14_1)
	self:getMapGround():checkAndLoadParts(arg_14_1)
end

function ExplorationMapWorld:onCoverTouchBegan(arg_15_1, arg_15_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_15_1)
end

function ExplorationMapWorld:onCoverTouchMoved(arg_16_1, arg_16_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_16_1)
	end
end

function ExplorationMapWorld:onCoverTouchEnded(arg_17_1, arg_17_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_17_1)
	end
end

function ExplorationMapWorld:onCoverClicked(arg_18_1, arg_18_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_18_1)
	end
end

function ExplorationMapWorld:onCoverRightClicked(arg_19_1, arg_19_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_19_1)
	end
end

function ExplorationMapWorld:onCoverMiddleClicked(arg_20_1, arg_20_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_20_1)
	end
end

function ExplorationMapWorld:onEnter()
	self:scheduleUpdate(handler(self, self.tickUpdate))
end

function ExplorationMapWorld:onExit()
	self:unscheduleUpdate()
end

function ExplorationMapWorld:onCleanup()
	self:disableNodeEvents()
end

function ExplorationMapWorld:tickUpdate(arg_24_1)
	self:_doTickUpdate(arg_24_1)
end

function ExplorationMapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
end

function ExplorationMapWorld:startObserver(arg_26_1)
	arg_26_1:startListen(self)
end

function ExplorationMapWorld:stopObserver(arg_27_1)
	arg_27_1:startListen(nil)
end

function ExplorationMapWorld:moveLastCenter()
	local var_28_0 = g.core.model.User.explorationData:getMapData()
	local var_28_1 = var_28_0:getMapCenterPos()

	if not var_28_1 then
		var_28_1 = cc.p(ExplorationMapCommon.getWorldPosByGlobalCoordinate((var_28_0:getMainRoleCoordinate())))
		var_28_1.x = -var_28_1.x
		var_28_1.y = -var_28_1.y
	end

	self:moveWorld((cc.pSub(var_28_1, (cc.p(self:getPosition())))))
end

function ExplorationMapWorld:getMapGround()
	return self._vislGround
end

function ExplorationMapWorld:getMapStage()
	return self._fatherStage
end

function ExplorationMapWorld:getMapId()
	return self._worldId
end

function ExplorationMapWorld:setOrgCoord(arg_32_1)
	self._orgCoord = arg_32_1
end

function ExplorationMapWorld:getOrgCoord()
	return self._orgCoord
end

function ExplorationMapWorld:moveWorld(arg_34_1)
	local var_34_0, var_34_1 = self:getPosition()
	local var_34_2, var_34_3 = KsMath.rangeIn(var_34_0 + arg_34_1.x, self._minMoveX, self._maxMoveX)
	local var_34_4, var_34_5 = KsMath.rangeIn(var_34_1 + arg_34_1.y, self:_resetMoveRangeY(var_34_2))

	self:setPosition(var_34_2, var_34_4)
	self:getMapStage():updateFloorCompPos(var_34_2, -var_34_4)
	self:getMapStage():updateTipIcon()
	g.core.model.User.explorationData:getMapData():saveMapCenterPos(cc.p(var_34_2, var_34_4))

	return var_34_3, var_34_5
end

function ExplorationMapWorld:updateMainRoleRoutePath(arg_35_1)
	self._worldRoutePath = arg_35_1
end

function ExplorationMapWorld:onOneRouteFinish()
	table.remove(self._worldRoutePath, 1)
end

function ExplorationMapWorld:movePA2PB(arg_37_1, arg_37_2)
	return self:moveWorld((cc.p(arg_37_2.x - arg_37_1.x, arg_37_2.y - arg_37_1.y)))
end

function ExplorationMapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function ExplorationMapWorld:movePA2SC(arg_39_1)
	self:movePA2PB(arg_39_1, (self:convertScreenCenter()))
	self:getMapStage():updateTipIcon()
end

function ExplorationMapWorld:moveCell2SC(arg_40_1)
	local var_40_0, var_40_1 = self:getMapGround():coordToPixel(arg_40_1.x, arg_40_1.y)

	self:movePA2SC(cc.p(var_40_0, var_40_1))
	self:getMapStage():updateTipIcon()
end

function ExplorationMapWorld:onSingleClick(arg_41_1)
	if self._worldRoutePath then
		return
	end

	local var_41_0 = self:convertToNodeSpace(arg_41_1)
	local var_41_1, var_41_2 = self:getMapGround():pixelToCoord(var_41_0.x, var_41_0.y)

	self._fatherStage:onSingleClick(var_41_1, var_41_2, (cc.pSub(var_41_0, (cc.p(self:getMapGround():coordToPixel(var_41_1, var_41_2))))))
end

function ExplorationMapWorld:setFollowCenter(arg_42_1)
	self._followCenter = arg_42_1
end

function ExplorationMapWorld:startInertiaWorld(arg_43_1, arg_43_2)
	if ExplorationConst.MAP_DRAG_INERTIA_CLOSE then
		self:mapMoveEnd()

		return
	end

	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_43_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_43_2 * ExplorationConst.MAP_DRAG_SENSITIVE
end

function ExplorationMapWorld:mapMoveEnd()
	self._fatherStage:onMapMoveEnd()
end

return ExplorationMapWorld
