local var_0_0 = g.core.const.ConstMgr.GveConst
local KsMath = require("app.core.utils.KsMath")
local GveMapGround = require("app.view.module.gve.view.gveMap.GveMapGround")
local GveMapTouch = require("app.view.module.gve.view.gveMap.GveMapTouch")
local GveMapWorld = class("GveMapWorld", function()
	return cc.Node:create()
end)

function GveMapWorld:ctor(arg_2_1, arg_2_2)
	self._fatherStage = arg_2_1
	self._vislGround = nil
	self._worldId = arg_2_2
	self._minMoveX = 0
	self._maxMoveX = 0
	self._minMoveY = 0
	self._maxMoveY = 0
	self._lastPosSC = cc.p(-1000, -1000)
	self._mapTouch = nil
	self._orgCoord = nil
	self._followCenter = nil

	self:initWorld()
end

function GveMapWorld:onEnter()
	self:scheduleUpdate(handler(self, self.tickUpdate))
end

function GveMapWorld:onExit()
	self:unscheduleUpdate()
end

function GveMapWorld:onCleanup()
	self:disableNodeEvents()
end

function GveMapWorld:tickUpdate(arg_6_1)
	self:_doTickUpdate(arg_6_1)
end

function GveMapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
	self._vislGround = self:_doCreateGround()

	self:addChild(self._vislGround)
	self:_initMoveRange()
	self:_doInitTouchMatch()
	self:onNodeEvent()
end

function GveMapWorld:startObserver(arg_8_1)
	arg_8_1:startListen(self)
end

function GveMapWorld:stopObserver(arg_9_1)
	arg_9_1:startListen(nil)
end

function GveMapWorld:getMapGround()
	return self._vislGround
end

function GveMapWorld:getMapStage()
	return self._fatherStage
end

function GveMapWorld:getMapId()
	return self._worldId
end

function GveMapWorld:setOrgCoord(arg_13_1)
	self._orgCoord = arg_13_1
end

function GveMapWorld:getOrgCoord()
	return self._orgCoord
end

function GveMapWorld:moveWorld(arg_15_1)
	local var_15_0, var_15_1 = self:getPosition()
	local var_15_2, var_15_3 = KsMath.rangeIn(var_15_0 + arg_15_1.x, self._minMoveX, self._maxMoveX)
	local var_15_4, var_15_5 = KsMath.rangeIn(var_15_1 + arg_15_1.y, self:_resetMoveRangeY(var_15_2))

	self:setPosition(var_15_2, var_15_4)
	self:getMapStage():updateFloorCompPos(var_15_2, -var_15_4)
	self:getMapStage():updatePlayerIcon()
	self:getMapStage():updateMiniMap()

	return var_15_3, var_15_5
end

function GveMapWorld:movePA2PB(arg_16_1, arg_16_2)
	return self:moveWorld((cc.p(arg_16_2.x - arg_16_1.x, arg_16_2.y - arg_16_1.y)))
end

function GveMapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function GveMapWorld:movePA2SC(arg_18_1)
	self:movePA2PB(arg_18_1, (self:convertScreenCenter()))
	self:getMapStage():updatePlayerIcon()
end

function GveMapWorld:moveCell2SC(arg_19_1)
	local var_19_0, var_19_1 = self:getMapGround():coordToPixel(arg_19_1.x, arg_19_1.y)

	self:movePA2SC(cc.p(var_19_0, var_19_1))
	self:getMapStage():updatePlayerIcon()
end

function GveMapWorld:_doCreateGround()
	return GveMapGround.new(self)
end

function GveMapWorld:_doInitTouchMatch()
	self._mapTouch = GveMapTouch.new(self)
end

function GveMapWorld:_doTickUpdate(arg_22_1)
	self:_checkFollowing(arg_22_1)
	self:_autoInertiaUpdate(arg_22_1)
end

function GveMapWorld:doDragWorld(arg_23_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_23_1)
end

function GveMapWorld:_initMoveRange()
	local var_24_0 = self:getMapGround()
	local var_24_1 = var_24_0:getMapHeight()
	local var_24_2 = self:getMapGround():getHalfTileH()

	self._minMoveX = -var_24_0
	self._maxMoveX = self:getMapGround():getMapWidth() / 2 - display.width / 2 - display.height
	self._minMoveY = var_24_1 / 2 - var_24_2 - self._maxMoveX / 2
	self._maxMoveY = var_24_1 / 2 - var_24_2 + self._maxMoveX / 2
end

function GveMapWorld:_resetMoveRangeY(arg_25_1)
	local var_25_0 = math.abs(arg_25_1)

	return self._minMoveY + var_25_0 / 2, self._maxMoveY - var_25_0 / 2
end

function GveMapWorld:onCoverTouchBegan(arg_26_1, arg_26_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_26_1)
end

function GveMapWorld:onCoverTouchMoved(arg_27_1, arg_27_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_27_1)
	end
end

function GveMapWorld:onCoverTouchEnded(arg_28_1, arg_28_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_28_1)
	end
end

function GveMapWorld:onCoverClicked(arg_29_1, arg_29_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_29_1)
	end
end

function GveMapWorld:onCoverRightClicked(arg_30_1, arg_30_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_30_1)
	end
end

function GveMapWorld:onCoverMiddleClicked(arg_31_1, arg_31_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_31_1)
	end
end

function GveMapWorld:onSingleClick(arg_32_1)
	local var_32_0 = self:convertToNodeSpace(arg_32_1)
	local var_32_1, var_32_2 = self:getMapGround():pixelToCoord(var_32_0.x, var_32_0.y)

	self._fatherStage:setTargetPosTiledId(cc.p(var_32_1, var_32_2))

	if self:getMapGround():checkCoordInvalid(var_32_1, var_32_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304513))

		return
	end

	local var_32_3, var_32_4 = self._fatherStage:checkIsMonsterPoint(var_32_1, var_32_2)

	if not var_32_3 then
		self._fatherStage:onSingleClick(var_32_1, var_32_2)
	end
end

function GveMapWorld:setFollowCenter(arg_33_1)
	self._followCenter = arg_33_1
end

function GveMapWorld:startInertiaWorld(arg_34_1, arg_34_2)
	if var_0_0.MAP_DRAG_INERTIA_CLOSE then
		self:mapMoveEnd()

		return
	end

	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_34_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_34_2 * var_0_0.MAP_DRAG_SENSITIVE
end

function GveMapWorld:mapMoveEnd()
	self._fatherStage:onMapMoveEnd()
end

function GveMapWorld:_checkFollowing(arg_36_1)
	if self._followCenter == nil then
		return
	end

	local var_36_0 = self:convertScreenCenter()
	local var_36_1 = KsMath.calculateDistance(self._followCenter, var_36_0)

	if var_36_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_36_2, var_36_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_36_0, var_0_0.MAP_MOVE_SPEED * (var_36_1 / 200) * arg_36_1)))

	if var_36_2 or var_36_3 then
		self._followCenter = nil
	end
end

function GveMapWorld:_autoInertiaUpdate(arg_37_1)
	if var_0_0.MAP_DRAG_INERTIA_CLOSE then
		return
	end

	if self._autoInertiaDir == nil then
		return
	end

	local var_37_0, var_37_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - var_0_0.MAP_DRAG_ACCELERATE

	if var_37_0 or var_37_1 or self._autoInertiaDist <= 0 then
		if self._mapInMove then
			self._mapInMove = false

			self:mapMoveEnd()
		end

		self._autoInertiaDir = nil
	end

	self._mapInMove = true
end

function GveMapWorld:getTargetPosTiledId(arg_38_1)
	if self._vislGround then
		return self._vislGround:getTargetPosTiledId(arg_38_1)
	end

	return 0
end

function GveMapWorld:checkAndLoadParts(arg_39_1)
	self:getMapGround():checkAndLoadParts(arg_39_1)
end

return GveMapWorld
