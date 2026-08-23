local var_0_0 = g.core.const.ConstMgr.GveConst
local KsMath = require("app.core.utils.KsMath")
local GvgMapGround = require("app.view.module.gvg.view.gvgMap.GvgMapGround")
local GvgMapTouch = require("app.view.module.gvg.view.gvgMap.GvgMapTouch")
local GvgMapWorld = class("GvgMapWorld", function()
	return cc.Node:create()
end)

function GvgMapWorld:ctor(arg_2_1, arg_2_2)
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

function GvgMapWorld:onEnter()
	self:scheduleUpdate(handler(self, self.tickUpdate))
end

function GvgMapWorld:onExit()
	self:unscheduleUpdate()
end

function GvgMapWorld:onCleanup()
	self:disableNodeEvents()
end

function GvgMapWorld:tickUpdate(arg_6_1)
	self:_doTickUpdate(arg_6_1)
end

function GvgMapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
	self._vislGround = self:_doCreateGround()

	self:addChild(self._vislGround)
	self:_initMoveRange()
	self:_doInitTouchMatch()
	self:onNodeEvent()
end

function GvgMapWorld:startObserver(arg_8_1)
	arg_8_1:startListen(self)
end

function GvgMapWorld:stopObserver(arg_9_1)
	arg_9_1:startListen(nil)
end

function GvgMapWorld:getMapGround()
	return self._vislGround
end

function GvgMapWorld:getMapStage()
	return self._fatherStage
end

function GvgMapWorld:getMapId()
	return self._worldId
end

function GvgMapWorld:setOrgCoord(arg_13_1)
	self._orgCoord = arg_13_1
end

function GvgMapWorld:getOrgCoord()
	return self._orgCoord
end

function GvgMapWorld:moveWorld(arg_15_1)
	local var_15_0, var_15_1 = self:getPosition()
	local var_15_2, var_15_3 = KsMath.rangeIn(var_15_0 + arg_15_1.x, self._minMoveX, self._maxMoveX)
	local var_15_4, var_15_5 = KsMath.rangeIn(var_15_1 + arg_15_1.y, self:_resetMoveRangeY(var_15_2))

	self:setPosition(var_15_2, var_15_4)
	self:getMapStage():updateFloorCompPos(var_15_2, -var_15_4)

	return var_15_3, var_15_5
end

function GvgMapWorld:movePA2PB(arg_16_1, arg_16_2)
	return self:moveWorld((cc.p(arg_16_2.x - arg_16_1.x, arg_16_2.y - arg_16_1.y)))
end

function GvgMapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function GvgMapWorld:movePA2SC(arg_18_1)
	self:movePA2PB(arg_18_1, (self:convertScreenCenter()))
	self:getMapStage():updatePlayerIcon()
end

function GvgMapWorld:moveCell2SC(arg_19_1)
	local var_19_0, var_19_1 = self:getMapGround():coordToPixel(arg_19_1.x, arg_19_1.y)

	self:movePA2SC(cc.p(var_19_0, var_19_1))
	self:getMapStage():updatePlayerIcon()
end

function GvgMapWorld:_doCreateGround()
	return GvgMapGround.new(self)
end

function GvgMapWorld:_doInitTouchMatch()
	self._mapTouch = GvgMapTouch.new(self)
end

function GvgMapWorld:_doTickUpdate(arg_22_1)
	self:_checkFollowing(arg_22_1)
	self:_autoInertiaUpdate(arg_22_1)
end

function GvgMapWorld:doDragWorld(arg_23_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_23_1)
end

function GvgMapWorld:_initMoveRange()
	local var_24_0 = self:getMapGround()
	local var_24_1 = var_24_0:getMapHeight()
	local var_24_2 = self:getMapGround():getFixOffY()

	self._minMoveX = -var_24_0
	self._maxMoveX = self:getMapGround():getMapWidth() / 2 - display.width / 2
	self._minMoveY = -(-var_24_2 + var_24_1 / 2) - (var_24_1 / 2 - display.height / 2)
	self._maxMoveY = -(-var_24_2 + var_24_1 / 2) + (var_24_1 / 2 - display.height / 2)
end

function GvgMapWorld:_resetMoveRangeY(arg_25_1)
	return self._minMoveY, self._maxMoveY
end

function GvgMapWorld:onCoverTouchBegan(arg_26_1, arg_26_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_26_1)
end

function GvgMapWorld:onCoverTouchMoved(arg_27_1, arg_27_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_27_1)
	end
end

function GvgMapWorld:onCoverTouchEnded(arg_28_1, arg_28_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_28_1)
	end
end

function GvgMapWorld:onCoverClicked(arg_29_1, arg_29_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_29_1)
	end
end

function GvgMapWorld:onCoverRightClicked(arg_30_1, arg_30_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_30_1)
	end
end

function GvgMapWorld:onCoverMiddleClicked(arg_31_1, arg_31_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_31_1)
	end
end

function GvgMapWorld:onSingleClick(arg_32_1)
	local var_32_0 = self:convertToNodeSpace(arg_32_1)
	local var_32_1, var_32_2 = self:getMapGround():pixelToCoord(var_32_0.x, var_32_0.y)

	if self:getMapGround():checkCoordInvalid(var_32_1, var_32_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304513))

		return
	end

	if not nil then
		-- block empty
	end
end

function GvgMapWorld:setFollowCenter(arg_33_1)
	self._followCenter = arg_33_1
end

function GvgMapWorld:startInertiaWorld(arg_34_1, arg_34_2)
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

function GvgMapWorld:mapMoveEnd()
	return
end

function GvgMapWorld:_checkFollowing(arg_36_1)
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

function GvgMapWorld:_autoInertiaUpdate(arg_37_1)
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

function GvgMapWorld:getTargetPosTiledId(arg_38_1)
	if self._vislGround then
		return self._vislGround:getTargetPosTiledId(arg_38_1)
	end

	return 0
end

function GvgMapWorld:checkAndLoadParts(arg_39_1)
	self:getMapGround():checkAndLoadParts(arg_39_1)
end

return GvgMapWorld
