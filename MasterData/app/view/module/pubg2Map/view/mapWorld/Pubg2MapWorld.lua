local var_0_0
local var_0_1 = g.core.const.ConstMgr.PubgConst
local KsMath = require("app.core.utils.KsMath")
local var_0_3 = math.floor
local Pubg2MapGround = require("app.view.module.pubg2Map.view.mapWorld.Pubg2MapGround")
local Pubg2MapTouch = require("app.view.module.pubg2Map.view.mapWorld.Pubg2MapTouch")
local Pubg2MapWorld = class("Pubg2MapWorld", function()
	return cc.Node:create()
end)

function Pubg2MapWorld:ctor(arg_2_1, arg_2_2)
	var_0_0 = g.core.model.User.pubgData:getMapData()
	self._fatherStage = arg_2_1
	self._visualGround = nil
	self._worldId = arg_2_2
	self._minMoveX = 0
	self._maxMoveX = 0
	self._minMoveY = 0
	self._maxMoveY = 0
	self._mapTouch = nil
	self._orgCoord = nil
	self._autoInertiaDir = nil
	self._followCenter = nil
	self._mapInMove = false
	self._autoInertiaDist = 0

	self:initWorld()
end

function Pubg2MapWorld:onCleanup()
	self:disableNodeEvents()
end

function Pubg2MapWorld:tickUpdate(arg_4_1)
	self:_checkFollowing(arg_4_1)
	self:_autoInertiaUpdate(arg_4_1)
end

function Pubg2MapWorld:onSingleClick(arg_5_1)
	local var_5_0 = self:convertToNodeSpace(arg_5_1)
	local var_5_1, var_5_2 = self:getMapGround():pixelToCoord(var_5_0.x, var_5_0.y)

	if self:getMapGround():checkCoordInvalid(var_5_1, var_5_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304513))

		return
	end
end

function Pubg2MapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
	self._visualGround = Pubg2MapGround.new(self)

	self:addChild(self._visualGround)
	self:_initMoveRange()

	self._mapTouch = Pubg2MapTouch.new(self)

	self:onNodeEvent()
end

function Pubg2MapWorld:startObserver(arg_7_1)
	arg_7_1:startListen(self)
end

function Pubg2MapWorld:stopObserver(arg_8_1)
	arg_8_1:startListen(nil)
end

function Pubg2MapWorld:getMapGround()
	return self._visualGround
end

function Pubg2MapWorld:getMapStage()
	return self._fatherStage
end

function Pubg2MapWorld:getMapId()
	return self._worldId
end

function Pubg2MapWorld:setOrgCoord(arg_12_1)
	self._orgCoord = arg_12_1
end

function Pubg2MapWorld:getOrgCoord()
	return self._orgCoord
end

function Pubg2MapWorld:moveWorld(arg_14_1)
	local var_14_0, var_14_1 = self:getPosition()
	local var_14_2, var_14_3 = KsMath.rangeIn(var_14_0 + arg_14_1.x, self._minMoveX, self._maxMoveX)
	local var_14_4, var_14_5 = KsMath.rangeIn(var_14_1 + arg_14_1.y, self:_resetMoveRangeY(var_14_2))
	local var_14_6 = var_0_3(var_14_2 + 0.5)
	local var_14_7 = var_0_3(var_14_4 + 0.5)

	self:setPosition(var_14_6, var_14_7)
	self:getMapStage():updateFloorCompPos(var_14_6, -var_14_7)
	self:getMapStage():updatePlayerIcon()

	return var_14_3, var_14_5
end

function Pubg2MapWorld:movePA2PB(arg_15_1, arg_15_2)
	return self:moveWorld((cc.p(arg_15_2.x - arg_15_1.x, arg_15_2.y - arg_15_1.y)))
end

function Pubg2MapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function Pubg2MapWorld:movePA2SC(arg_17_1)
	self:movePA2PB(arg_17_1, (self:convertScreenCenter()))
	self:getMapStage():updatePlayerIcon()
end

function Pubg2MapWorld:doDragWorld(arg_18_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_18_1)
end

function Pubg2MapWorld:_initMoveRange()
	local var_19_0 = self:getMapGround():getMapHeight()
	local var_19_1 = self:getMapGround()
	local var_19_2 = var_19_1:getHalfTileH()

	self._minMoveX = -var_19_1
	self._maxMoveX = self:getMapGround():getMapWidth() / 2 - display.width / 2 - display.height
	self._minMoveY = var_19_0 / 2 - var_19_2 - self._maxMoveX / 2
	self._maxMoveY = var_19_0 / 2 - var_19_2 + self._maxMoveX / 2
end

function Pubg2MapWorld:_resetMoveRangeY(arg_20_1)
	local var_20_0 = math.abs(arg_20_1)

	return self._minMoveY + var_20_0 / 2, self._maxMoveY - var_20_0 / 2
end

function Pubg2MapWorld:onCoverTouchBegan(arg_21_1, arg_21_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_21_1)
end

function Pubg2MapWorld:onCoverTouchMoved(arg_22_1, arg_22_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_22_1)
	end
end

function Pubg2MapWorld:onCoverTouchEnded(arg_23_1, arg_23_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_23_1)
	end
end

function Pubg2MapWorld:onCoverClicked(arg_24_1, arg_24_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_24_1)
	end
end

function Pubg2MapWorld:onCoverRightClicked(arg_25_1, arg_25_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_25_1)
	end
end

function Pubg2MapWorld:onCoverMiddleClicked(arg_26_1, arg_26_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_26_1)
	end
end

function Pubg2MapWorld:setFollowCenter(arg_27_1)
	self._followCenter = arg_27_1
end

function Pubg2MapWorld:startInertiaWorld(arg_28_1, arg_28_2)
	if var_0_1.map.MAP_DRAG_INERTIA_CLOSE then
		self:mapMoveEnd()

		return
	end

	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_28_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_28_2 * var_0_1.map.MAP_DRAG_SENSITIVE
end

function Pubg2MapWorld:mapMoveEnd()
	self._fatherStage:onMapMoveEnd()
end

function Pubg2MapWorld:_checkFollowing(arg_30_1)
	if self._followCenter == nil then
		return
	end

	local var_30_0 = self:convertScreenCenter()
	local var_30_1 = KsMath.calculateDistance(self._followCenter, var_30_0)

	if var_30_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_30_2, var_30_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_30_0, var_0_1.map.MAP_MOVE_SPEED * (var_30_1 / 200) * arg_30_1)))

	if var_30_2 or var_30_3 then
		self._followCenter = nil
	end
end

function Pubg2MapWorld:_autoInertiaUpdate(arg_31_1)
	if var_0_1.map.MAP_DRAG_INERTIA_CLOSE then
		return
	end

	if self._autoInertiaDir == nil then
		return
	end

	local var_31_0, var_31_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - var_0_1.map.MAP_DRAG_ACCELERATE

	if var_31_0 or var_31_1 or self._autoInertiaDist <= 0 then
		if self._mapInMove then
			self._mapInMove = false

			self:mapMoveEnd()
		end

		self._autoInertiaDir = nil
	end

	self._mapInMove = true
end

return Pubg2MapWorld
