local KsMath = require("app.core.utils.KsMath")
local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleMapGround = require("app.view.module.teamBattle.view.map.TeamBattleMapGround")
local TeamBattleMapTouch = require("app.view.module.teamBattle.view.map.TeamBattleMapTouch")
local TeamBattleEntityFactory = require("app.view.module.teamBattle.view.map.entity.TeamBattleEntityFactory")
local TeamBattleMapCommon = require("app.view.module.teamBattle.common.TeamBattleMapCommon")
local TeamBattleMapWorld = class("TeamBattleMapWorld", function()
	return cc.Node:create()
end)

function TeamBattleMapWorld:ctor(arg_2_1)
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
	self._worldDragClickEnable = true

	self:onNodeEvent()
end

function TeamBattleMapWorld:setWorldId(arg_3_1)
	self._worldId = arg_3_1

	if not self._vislGround then
		self._orgCoord = cc.p(0, 0)

		self:_doCreateGround()
		self:_initMoveRange()
		self:_doInitTouchMatch()
	end
end

function TeamBattleMapWorld:_doCreateGround()
	self._vislGround = TeamBattleMapGround.new(self)

	self:addChild(self._vislGround)

	return self._vislGround
end

function TeamBattleMapWorld:_doInitTouchMatch()
	self._mapTouch = TeamBattleMapTouch.new(self)
end

function TeamBattleMapWorld:_doTickUpdate(arg_6_1)
	self:getMapStage():updateMoveRole()
	self:_checkFollowing(arg_6_1)
	self:_autoInertiaUpdate(arg_6_1)
end

function TeamBattleMapWorld:doDragWorld(arg_7_1)
	if self._followCenter or not self._worldDragClickEnable then
		return
	end

	self:moveWorld(arg_7_1)
end

function TeamBattleMapWorld:doCreateFactory()
	return TeamBattleEntityFactory
end

function TeamBattleMapWorld:_initMoveRange()
	local var_9_0 = self:getMapGround():getMapHeight()
	local var_9_1 = self:getMapGround()
	local var_9_2 = var_9_1:getHalfTileH()

	self._minMoveX = -var_9_1
	self._maxMoveX = self:getMapGround():getMapWidth()
	self._minMoveY = var_9_0 / 2 - var_9_2 - self._maxMoveX / 2
	self._maxMoveY = var_9_0 / 2 - var_9_2 + self._maxMoveX / 2
end

function TeamBattleMapWorld:_resetMoveRangeY(arg_10_1)
	local var_10_0 = math.abs(arg_10_1)

	return self._minMoveY + var_10_0 / 2, self._maxMoveY - var_10_0 / 2
end

function TeamBattleMapWorld:_checkFollowing(arg_11_1)
	if self._followCenter == nil then
		return
	end

	local var_11_0 = self:convertScreenCenter()
	local var_11_1 = KsMath.calculateDistance(self._followCenter, var_11_0)

	if var_11_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_11_2, var_11_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_11_0, TeamBattleConst.MAP_MOVE_SPEED * (var_11_1 / 200) * arg_11_1)))

	if var_11_2 or var_11_3 then
		self._followCenter = nil
	end
end

function TeamBattleMapWorld:_autoInertiaUpdate(arg_12_1)
	if TeamBattleConst.MAP_DRAG_INERTIA_CLOSE then
		return
	end

	if self._autoInertiaDir == nil then
		return
	end

	local var_12_0, var_12_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - TeamBattleConst.MAP_DRAG_ACCELERATE

	if var_12_0 or var_12_1 or self._autoInertiaDist <= 0 then
		if self._mapInMove then
			self._mapInMove = false

			self:mapMoveEnd()
		end

		self._autoInertiaDir = nil
	end

	self._mapInMove = true
end

function TeamBattleMapWorld:checkAndLoadParts(arg_13_1)
	self:getMapGround():checkAndLoadParts(arg_13_1)
end

function TeamBattleMapWorld:onCoverTouchBegan(arg_14_1, arg_14_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_14_1)
end

function TeamBattleMapWorld:onCoverTouchMoved(arg_15_1, arg_15_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_15_1)
	end
end

function TeamBattleMapWorld:onCoverTouchEnded(arg_16_1, arg_16_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_16_1)
	end
end

function TeamBattleMapWorld:onCoverClicked(arg_17_1, arg_17_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_17_1)
	end
end

function TeamBattleMapWorld:onCoverRightClicked(arg_18_1, arg_18_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_18_1)
	end
end

function TeamBattleMapWorld:onCoverMiddleClicked(arg_19_1, arg_19_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_19_1)
	end
end

function TeamBattleMapWorld:onEnter()
	self:scheduleUpdate(handler(self, self.tickUpdate))
end

function TeamBattleMapWorld:onExit()
	self:unscheduleUpdate()
end

function TeamBattleMapWorld:onCleanup()
	self:disableNodeEvents()
end

function TeamBattleMapWorld:tickUpdate(arg_23_1)
	self:_doTickUpdate(arg_23_1)
end

function TeamBattleMapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
end

function TeamBattleMapWorld:startObserver(arg_25_1)
	arg_25_1:startListen(self)
end

function TeamBattleMapWorld:stopObserver(arg_26_1)
	arg_26_1:startListen(nil)
end

function TeamBattleMapWorld:moveLastCenter()
	local var_27_0 = g.core.model.User.teamBattleData:getMapData()
	local var_27_1 = var_27_0:getMapCenterPos()

	if not var_27_1 then
		var_27_1 = cc.p(TeamBattleMapCommon.getWorldPosByGlobalCoordinate((var_27_0:getRoleCoordinate())))
		var_27_1.x = -var_27_1.x
		var_27_1.y = -var_27_1.y
	end

	self:moveWorld((cc.pSub(var_27_1, (cc.p(self:getPosition())))))
end

function TeamBattleMapWorld:getMapGround()
	return self._vislGround
end

function TeamBattleMapWorld:getMapStage()
	return self._fatherStage
end

function TeamBattleMapWorld:getMapId()
	return self._worldId
end

function TeamBattleMapWorld:setOrgCoord(arg_31_1)
	self._orgCoord = arg_31_1
end

function TeamBattleMapWorld:getOrgCoord()
	return self._orgCoord
end

function TeamBattleMapWorld:moveWorld(arg_33_1)
	local var_33_0, var_33_1 = self:getPosition()
	local var_33_2, var_33_3 = KsMath.rangeIn(var_33_0 + arg_33_1.x, self._minMoveX, self._maxMoveX)
	local var_33_4, var_33_5 = KsMath.rangeIn(var_33_1 + arg_33_1.y, self._minMoveY, self._maxMoveY)

	self:setPosition(var_33_2, var_33_4)
	self:getMapStage():updateFloorCompPos(var_33_2, -var_33_4)
	self:getMapStage():updateTipIcon()
	g.core.model.User.teamBattleData:getMapData():saveMapCenterPos(cc.p(var_33_2, var_33_4))

	return var_33_3, var_33_5
end

function TeamBattleMapWorld:setDragClickEnable(arg_34_1)
	self._worldDragClickEnable = arg_34_1
end

function TeamBattleMapWorld:movePA2PB(arg_35_1, arg_35_2)
	return self:moveWorld((cc.p(arg_35_2.x - arg_35_1.x, arg_35_2.y - arg_35_1.y)))
end

function TeamBattleMapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function TeamBattleMapWorld:movePA2SC(arg_37_1)
	self:movePA2PB(arg_37_1, (self:convertScreenCenter()))
	self:getMapStage():updateTipIcon()
end

function TeamBattleMapWorld:moveCell2SC(arg_38_1)
	local var_38_0, var_38_1 = self:getMapGround():coordToPixel(arg_38_1.x, arg_38_1.y)

	self:movePA2SC(cc.p(var_38_0, var_38_1))
	self:getMapStage():updateTipIcon()
end

function TeamBattleMapWorld:onSingleClick(arg_39_1)
	if not self._worldDragClickEnable then
		return
	end

	local var_39_0 = self:convertToNodeSpace(arg_39_1)
	local var_39_1, var_39_2 = self:getMapGround():pixelToCoord(var_39_0.x, var_39_0.y)

	self._fatherStage:onSingleClick(var_39_1, var_39_2, (cc.pSub(var_39_0, (cc.p(self:getMapGround():coordToPixel(var_39_1, var_39_2))))))
end

function TeamBattleMapWorld:setFollowCenter(arg_40_1)
	self._followCenter = arg_40_1
end

function TeamBattleMapWorld:startInertiaWorld(arg_41_1, arg_41_2)
	if TeamBattleConst.MAP_DRAG_INERTIA_CLOSE then
		self:mapMoveEnd()

		return
	end

	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_41_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_41_2 * TeamBattleConst.MAP_DRAG_SENSITIVE
end

function TeamBattleMapWorld:mapMoveEnd()
	self._fatherStage:onMapMoveEnd()
end

function TeamBattleMapWorld:setCurRoom(arg_43_1, arg_43_2)
	local var_43_0 = self._vislGround:getRoomRange(arg_43_1, arg_43_2)

	self._minMoveX = var_43_0.minX
	self._maxMoveX = var_43_0.maxX
	self._minMoveY = var_43_0.minY
	self._maxMoveY = var_43_0.maxY
end

return TeamBattleMapWorld
