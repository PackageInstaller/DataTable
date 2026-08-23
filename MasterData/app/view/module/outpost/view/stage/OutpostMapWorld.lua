local var_0_0 = g.core.const.ConstMgr.outpostConst
local KsMath = require("app.core.utils.KsMath")
local OutpostMapGround = require("app.view.module.outpost.view.stage.OutpostMapGround")
local OutpostMapTouch = require("app.view.module.outpost.view.stage.OutpostMapTouch")
local OutpostMapWorld = class("OutpostMapWorld", function()
	return cc.Node:create()
end)

function OutpostMapWorld:ctor(arg_2_1, arg_2_2)
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

function OutpostMapWorld:onEnter()
	self:scheduleUpdate(handler(self, self.tickUpdate))
end

function OutpostMapWorld:onExit()
	self:unscheduleUpdate()
end

function OutpostMapWorld:onCleanup()
	self:disableNodeEvents()
end

function OutpostMapWorld:tickUpdate(arg_6_1)
	self:_doTickUpdate(arg_6_1)
end

function OutpostMapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
	self._vislGround = self:_doCreateGround()

	self:addChild(self._vislGround)
	self:_initMoveRange()
	self:_doInitTouchMatch()
	self:onNodeEvent()
end

function OutpostMapWorld:getMapGround()
	return self._vislGround
end

function OutpostMapWorld:getMapStage()
	return self._fatherStage
end

function OutpostMapWorld:getMapId()
	return self._worldId
end

function OutpostMapWorld:setOrgCoord(arg_11_1)
	self._orgCoord = arg_11_1
end

function OutpostMapWorld:getOrgCoord()
	return self._orgCoord
end

function OutpostMapWorld:moveWorld(arg_13_1)
	local var_13_0, var_13_1 = self:getPosition()
	local var_13_2, var_13_3 = KsMath.rangeIn(var_13_0 + arg_13_1.x, self._minMoveX, self._maxMoveX)
	local var_13_4, var_13_5 = KsMath.rangeIn(var_13_1 + arg_13_1.y, self:_resetMoveRangeY(var_13_2))

	self:setPosition(var_13_2, var_13_4)
	self:getMapStage():updateFloorCompPos(var_13_2, -var_13_4)
	self:getMapStage():updateViewEntityRender()

	return var_13_3, var_13_5
end

function OutpostMapWorld:movePA2PB(arg_14_1, arg_14_2)
	return self:moveWorld((cc.p(arg_14_2.x - arg_14_1.x, arg_14_2.y - arg_14_1.y)))
end

function OutpostMapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function OutpostMapWorld:movePA2SC(arg_16_1)
	self:movePA2PB(arg_16_1, (self:convertScreenCenter()))
end

function OutpostMapWorld:moveCell2SC(arg_17_1)
	local var_17_0, var_17_1 = self:getMapGround():coordToPixel(arg_17_1.x, arg_17_1.y)

	self:movePA2SC(cc.p(var_17_0, var_17_1))
end

function OutpostMapWorld:_doCreateGround()
	return OutpostMapGround.new(self)
end

function OutpostMapWorld:_doInitTouchMatch()
	self._mapTouch = OutpostMapTouch.new(self)
end

function OutpostMapWorld:_doTickUpdate(arg_20_1)
	self:_checkFollowing(arg_20_1)
	self:_autoInertiaUpdate(arg_20_1)
end

function OutpostMapWorld:doDragWorld(arg_21_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_21_1)
end

function OutpostMapWorld:_initMoveRange()
	local var_22_0 = self:getMapGround():getMapHeight()
	local var_22_1 = self:getMapGround()
	local var_22_2 = var_22_1:getHalfTileH()

	self._minMoveX = -var_22_1
	self._maxMoveX = self:getMapGround():getMapWidth() / 2 - display.width / 2 - display.height
	self._minMoveY = var_22_0 / 2 - var_22_2 - self._maxMoveX / 2
	self._maxMoveY = var_22_0 / 2 - var_22_2 + self._maxMoveX / 2
end

function OutpostMapWorld:_resetMoveRangeY(arg_23_1)
	local var_23_0 = math.abs(arg_23_1)

	return self._minMoveY + var_23_0 / 2, self._maxMoveY - var_23_0 / 2
end

function OutpostMapWorld:onCoverTouchBegan(arg_24_1, arg_24_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_24_1)
end

function OutpostMapWorld:onCoverTouchMoved(arg_25_1, arg_25_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_25_1)
	end
end

function OutpostMapWorld:onCoverTouchEnded(arg_26_1, arg_26_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_26_1)
	end
end

function OutpostMapWorld:onCoverClicked(arg_27_1, arg_27_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_27_1)
	end
end

function OutpostMapWorld:onCoverRightClicked(arg_28_1, arg_28_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_28_1)
	end
end

function OutpostMapWorld:onCoverMiddleClicked(arg_29_1, arg_29_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_29_1)
	end
end

function OutpostMapWorld:onSingleClick(arg_30_1)
	local var_30_0 = self:convertToNodeSpace(arg_30_1)
	local var_30_1, var_30_2 = self:getMapGround():pixelToCoord(var_30_0.x, var_30_0.y)

	if self:getMapGround():checkCoordInvalid(var_30_1, var_30_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304513))

		return
	end
end

function OutpostMapWorld:setFollowCenter(arg_31_1)
	self._followCenter = arg_31_1
end

function OutpostMapWorld:startInertiaWorld(arg_32_1, arg_32_2)
	if var_0_0.MAP_DRAG_INERTIA_CLOSE then
		self:mapMoveEnd()

		return
	end

	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_32_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_32_2 * var_0_0.MAP_DRAG_SENSITIVE
end

function OutpostMapWorld:mapMoveEnd()
	self._fatherStage:onMapMoveEnd()
end

function OutpostMapWorld:_checkFollowing(arg_34_1)
	if self._followCenter == nil then
		return
	end

	local var_34_0 = self:convertScreenCenter()
	local var_34_1 = KsMath.calculateDistance(self._followCenter, var_34_0)

	if var_34_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_34_2, var_34_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_34_0, var_0_0.MAP_MOVE_SPEED * (var_34_1 / 200) * arg_34_1)))

	if var_34_2 or var_34_3 then
		self._followCenter = nil
	end
end

function OutpostMapWorld:_autoInertiaUpdate(arg_35_1)
	if var_0_0.MAP_DRAG_INERTIA_CLOSE then
		return
	end

	if self._autoInertiaDir == nil then
		return
	end

	local var_35_0, var_35_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - var_0_0.MAP_DRAG_ACCELERATE

	if var_35_0 or var_35_1 or self._autoInertiaDist <= 0 then
		if self._mapInMove then
			self._mapInMove = false

			self:mapMoveEnd()
		end

		self._autoInertiaDir = nil
	end

	self._mapInMove = true
end

return OutpostMapWorld
