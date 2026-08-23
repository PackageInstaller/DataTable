local var_0_0
local var_0_1 = g.core.const.ConstMgr.PubgConst
local KsMath = require("app.core.utils.KsMath")
local var_0_3 = math.floor
local PubgMapGround = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapGround")
local PubgMapTouch = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapTouch")
local PubgMapWorld = class("PubgMapWorld", function()
	return cc.Node:create()
end)

function PubgMapWorld:ctor(arg_2_1, arg_2_2)
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

function PubgMapWorld:onEnter()
	self:scheduleUpdate(handler(self, self.tickUpdate))
end

function PubgMapWorld:onExit()
	self:unscheduleUpdate()
end

function PubgMapWorld:onCleanup()
	self:disableNodeEvents()
end

function PubgMapWorld:tickUpdate(arg_6_1)
	local var_6_0 = var_0_0:tickUpdate(arg_6_1) or {}

	self:_checkFollowing(arg_6_1)
	self:_autoInertiaUpdate(arg_6_1)

	if var_6_0.isMove then
		self:getMapStage():userMove()
	end

	if var_6_0.isMoveEnd then
		self:getMapStage():checkGetBuff()
	end

	if var_6_0.removeHide or var_6_0.removeFightValue or var_6_0.removeMustWin then
		self:getMapStage():getFloorComp():refreshGridByUser()
	end

	if var_6_0.removeFightValue then
		self:getMapStage():removeBuffFightValue()
	end

	self:getMapStage():refreshAttackUsers(var_6_0.attackUserList or {})
	self:getMapStage():refreshInvincibleUsers(var_6_0.invincibleChangeList or {})
end

function PubgMapWorld:onSingleClick(arg_7_1)
	local var_7_0 = self:convertToNodeSpace(arg_7_1)
	local var_7_1, var_7_2 = self:getMapGround():pixelToCoord(var_7_0.x, var_7_0.y)

	if self:getMapGround():checkCoordInvalid(var_7_1, var_7_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304513))

		return
	end

	if not var_0_0:checkInMapTime() then
		return
	end

	local var_7_3 = var_0_0:getMyUser()

	if var_7_3:isDead() then
		return
	end

	local var_7_4, var_7_5 = var_7_3:getPos()
	local var_7_6 = var_7_3:getMovingPos()

	if var_7_6 then
		var_7_4 = var_7_6.x
		var_7_5 = var_7_6.y
	end

	local var_7_7 = var_0_0:getAirDropByPos(var_7_1, var_7_2)
	local var_7_8 = var_0_0:getBuffByPos(var_7_1, var_7_2)

	if var_7_4 == var_7_1 and var_7_5 == var_7_2 then
		if var_7_7 and not var_0_0:isSendGet(var_7_7:getOnlyKey()) then
			g.core.network.GameNetProxy:send_C2S_Pubg_PickAirdrop({
				id = var_7_7:getUid()
			})
			var_7_3:setTargetOnlyId("")
			var_0_0:addSendGet(var_7_7:getOnlyKey())
		end

		if var_7_8 and not var_0_0:isSendGet(var_7_8:getOnlyKey()) then
			g.core.network.GameNetProxy:send_C2S_Pubg_PickBuff({
				id = var_7_8:getUid()
			})
			var_7_3:setTargetOnlyId("")
			var_0_0:addSendGet(var_7_8:getOnlyKey())
		end

		return
	end

	local var_7_9 = var_7_3:getRouteFinal()
	local var_7_10

	if var_7_8 and not var_0_0:isSendGet(var_7_8:getOnlyKey()) then
		if (var_7_1 - var_7_4) * (var_7_1 - var_7_4) + (var_7_2 - var_7_5) * (var_7_2 - var_7_5) <= 2 then
			g.core.network.GameNetProxy:send_C2S_Pubg_PickBuff({
				id = var_7_8:getUid()
			})
			var_7_3:setTargetOnlyId("")
			var_0_0:addSendGet(var_7_8:getOnlyKey())

			return
		else
			local var_7_11 = var_0_0:getRouteArray(cc.p(var_7_4, var_7_5), cc.p(var_7_1, var_7_2))

			if var_7_11 then
				table.remove(var_7_11, #var_7_11)

				if var_7_9.x ~= var_7_11[#var_7_11].x or var_7_9.y ~= var_7_11[#var_7_11].y then
					var_7_10 = var_7_11

					var_7_3:setTargetOnlyId(var_7_8:getOnlyKey())

					if not var_7_10 then
						g.core.module.ModuleManager:tip(g.core.lang:get(304512))
					end
				end
			end
		end
	elseif var_7_7 and not var_0_0:isSendGet(var_7_7:getOnlyKey()) then
		if (var_7_1 - var_7_4) * (var_7_1 - var_7_4) + (var_7_2 - var_7_5) * (var_7_2 - var_7_5) <= 2 then
			g.core.network.GameNetProxy:send_C2S_Pubg_PickAirdrop({
				id = var_7_7:getUid()
			})
			var_7_3:setTargetOnlyId("")
			var_0_0:addSendGet(var_7_7:getOnlyKey())

			return
		else
			local var_7_12 = var_0_0:getRouteArray(cc.p(var_7_4, var_7_5), cc.p(var_7_1, var_7_2))

			if var_7_12 then
				table.remove(var_7_12, #var_7_12)

				if var_7_9.x ~= var_7_12[#var_7_12].x or var_7_9.y ~= var_7_12[#var_7_12].y then
					var_7_10 = var_7_12

					var_7_3:setTargetOnlyId(var_7_7:getOnlyKey())

					if not var_7_10 then
						g.core.module.ModuleManager:tip(g.core.lang:get(304512))
					end
				end
			end
		end
	elseif var_7_9.x ~= var_7_1 or var_7_9.y ~= var_7_2 then
		var_7_10 = var_0_0:getRouteArray(cc.p(var_7_4, var_7_5), cc.p(var_7_1, var_7_2))

		if not var_7_10 then
			g.core.module.ModuleManager:tip(g.core.lang:get(304512))
		end
	end

	if var_7_10 then
		table.remove(var_7_10, 1)
		var_0_0:getMyUser():setMoveRoute(var_7_10)
	end
end

function PubgMapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
	self._visualGround = self:_doCreateGround()

	self:addChild(self._visualGround)
	self:_initMoveRange()
	self:_doInitTouchMatch()
	self:onNodeEvent()
end

function PubgMapWorld:startObserver(arg_9_1)
	arg_9_1:startListen(self)
end

function PubgMapWorld:stopObserver(arg_10_1)
	arg_10_1:startListen(nil)
end

function PubgMapWorld:getMapGround()
	return self._visualGround
end

function PubgMapWorld:getMapStage()
	return self._fatherStage
end

function PubgMapWorld:getMapId()
	return self._worldId
end

function PubgMapWorld:setOrgCoord(arg_14_1)
	self._orgCoord = arg_14_1
end

function PubgMapWorld:getOrgCoord()
	return self._orgCoord
end

function PubgMapWorld:moveWorld(arg_16_1)
	local var_16_0, var_16_1 = self:getPosition()
	local var_16_2, var_16_3 = KsMath.rangeIn(var_16_0 + arg_16_1.x, self._minMoveX, self._maxMoveX)
	local var_16_4, var_16_5 = KsMath.rangeIn(var_16_1 + arg_16_1.y, self:_resetMoveRangeY(var_16_2))
	local var_16_6 = var_0_3(var_16_2 + 0.5)
	local var_16_7 = var_0_3(var_16_4 + 0.5)

	self:setPosition(var_16_6, var_16_7)
	self:getMapStage():updateFloorCompPos(var_16_6, -var_16_7)
	self:getMapStage():updatePlayerIcon()

	return var_16_3, var_16_5
end

function PubgMapWorld:movePA2PB(arg_17_1, arg_17_2)
	return self:moveWorld((cc.p(arg_17_2.x - arg_17_1.x, arg_17_2.y - arg_17_1.y)))
end

function PubgMapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function PubgMapWorld:movePA2SC(arg_19_1)
	self:movePA2PB(arg_19_1, (self:convertScreenCenter()))
	self:getMapStage():updatePlayerIcon()
end

function PubgMapWorld:moveCell2SC(arg_20_1)
	local var_20_0, var_20_1 = self:getMapGround():coordToPixel(arg_20_1.x, arg_20_1.y)

	self:movePA2SC(cc.p(var_20_0, var_20_1))
	self:getMapStage():updatePlayerIcon()
end

function PubgMapWorld:_doCreateGround()
	return PubgMapGround.new(self)
end

function PubgMapWorld:_doInitTouchMatch()
	self._mapTouch = PubgMapTouch.new(self)
end

function PubgMapWorld:doDragWorld(arg_23_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_23_1)
end

function PubgMapWorld:_initMoveRange()
	local var_24_0 = self:getMapGround():getMapHeight()
	local var_24_1 = self:getMapGround()
	local var_24_2 = var_24_1:getHalfTileH()

	self._minMoveX = -var_24_1
	self._maxMoveX = self:getMapGround():getMapWidth() / 2 - display.width / 2 - display.height
	self._minMoveY = var_24_0 / 2 - var_24_2 - self._maxMoveX / 2
	self._maxMoveY = var_24_0 / 2 - var_24_2 + self._maxMoveX / 2
end

function PubgMapWorld:_resetMoveRangeY(arg_25_1)
	local var_25_0 = math.abs(arg_25_1)

	return self._minMoveY + var_25_0 / 2, self._maxMoveY - var_25_0 / 2
end

function PubgMapWorld:onCoverTouchBegan(arg_26_1, arg_26_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_26_1)
end

function PubgMapWorld:onCoverTouchMoved(arg_27_1, arg_27_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_27_1)
	end
end

function PubgMapWorld:onCoverTouchEnded(arg_28_1, arg_28_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_28_1)
	end
end

function PubgMapWorld:onCoverClicked(arg_29_1, arg_29_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_29_1)
	end
end

function PubgMapWorld:onCoverRightClicked(arg_30_1, arg_30_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_30_1)
	end
end

function PubgMapWorld:onCoverMiddleClicked(arg_31_1, arg_31_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_31_1)
	end
end

function PubgMapWorld:setFollowCenter(arg_32_1)
	self._followCenter = arg_32_1
end

function PubgMapWorld:startInertiaWorld(arg_33_1, arg_33_2)
	if var_0_1.map.MAP_DRAG_INERTIA_CLOSE then
		self:mapMoveEnd()

		return
	end

	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_33_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_33_2 * var_0_1.map.MAP_DRAG_SENSITIVE
end

function PubgMapWorld:mapMoveEnd()
	self._fatherStage:onMapMoveEnd()
end

function PubgMapWorld:_checkFollowing(arg_35_1)
	if self._followCenter == nil then
		return
	end

	local var_35_0 = self:convertScreenCenter()
	local var_35_1 = KsMath.calculateDistance(self._followCenter, var_35_0)

	if var_35_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_35_2, var_35_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_35_0, var_0_1.map.MAP_MOVE_SPEED * (var_35_1 / 200) * arg_35_1)))

	if var_35_2 or var_35_3 then
		self._followCenter = nil
	end
end

function PubgMapWorld:_autoInertiaUpdate(arg_36_1)
	if var_0_1.map.MAP_DRAG_INERTIA_CLOSE then
		return
	end

	if self._autoInertiaDir == nil then
		return
	end

	local var_36_0, var_36_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - var_0_1.map.MAP_DRAG_ACCELERATE

	if var_36_0 or var_36_1 or self._autoInertiaDist <= 0 then
		if self._mapInMove then
			self._mapInMove = false

			self:mapMoveEnd()
		end

		self._autoInertiaDir = nil
	end

	self._mapInMove = true
end

return PubgMapWorld
