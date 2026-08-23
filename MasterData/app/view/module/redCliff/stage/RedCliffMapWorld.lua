local KsMath = require("app.core.utils.KsMath")
local RedCliffMapGround = import(".RedCliffMapGround")
local RedCliffMapTouch = import(".RedCliffMapTouch")
local RedCliffMapConst = require("app.view.module.redCliff.const.RedCliffMapConst")
local RedCliffMapWorld = class("RedCliffMapWorld", require("app.core.ksmap.MapWorld"))

function RedCliffMapWorld:ctor(arg_1_1, arg_1_2)
	self._worldId = arg_1_2

	RedCliffMapWorld.super.ctor(self, arg_1_1, arg_1_2)

	self._refRouteTarget = nil
	self._worldRoutePath = nil
	self._lastCoord = nil
	self._followCenter = nil
	self._isFollow = false
	self._chapterInfo = nil
	self._moveIndex = 1
	self._lastRoutePath = nil
end

function RedCliffMapWorld:_doTickUpdate(arg_2_1)
	local var_2_0 = self:getMapStage()

	if self._worldRoutePath then
		if self._moveIndex <= #self._worldRoutePath then
			var_2_0:updateMainRolePos(self._worldRoutePath[self._moveIndex])

			if self._moveIndex > 1 then
				var_2_0:updateMainRoleDirection(self._worldRoutePath[self._moveIndex - 1], self._worldRoutePath[self._moveIndex])

				if self._isFollow then
					self:setFollowCenter(var_2_0:getMainRolePos())
					self:_checkFollowing(arg_2_1)
				end
			end

			self._moveIndex = self._moveIndex + 1
		else
			var_2_0:onMainRoleMoveFinish()

			self._worldRoutePath = nil
			self._moveIndex = 1
		end
	end

	var_2_0:updateRobotCompPosition()
	self:_checkFollowing(arg_2_1)
	self:_autoInertiaUpdate(arg_2_1)
end

function RedCliffMapWorld:movePA2PB(arg_3_1, arg_3_2)
	return self:moveWorld((cc.p(arg_3_2.x - arg_3_1.x, arg_3_2.y - arg_3_1.y)))
end

function RedCliffMapWorld:getLastCoord()
	self._lastCoord = nil

	return self._lastCoord
end

function RedCliffMapWorld:onSingleClick(arg_5_1)
	if self:getMapStage():isPlaying() then
		self._worldRoutePath = nil

		return
	end

	local var_5_0 = self:convertToNodeSpace(arg_5_1)
	local var_5_1, var_5_2 = self:getMapGround():pixelToCoord(var_5_0.x, var_5_0.y)

	if self._worldRoutePath then
		if self._worldRoutePath[#self._worldRoutePath].x == var_5_1 and self._worldRoutePath[#self._worldRoutePath].y == var_5_2 then
			return
		end

		local var_5_3 = {}

		for iter_5_0 = self._moveIndex, #self._worldRoutePath do
			table.insert(var_5_3, self._worldRoutePath[iter_5_0])

			if self._worldRoutePath[iter_5_0].x == math.floor(self._worldRoutePath[iter_5_0].x) and self._worldRoutePath[iter_5_0].y == math.floor(self._worldRoutePath[iter_5_0].y) then
				self._lastCoord = self._worldRoutePath[iter_5_0]

				break
			end
		end

		self._worldRoutePath = var_5_3
		self._moveIndex = 1
	end

	self._fatherStage:onSingleClick(var_5_1, var_5_2, (cc.pSub(var_5_0, (cc.p(self:getMapGround():coordToPixel(var_5_1, var_5_2))))))
end

function RedCliffMapWorld:setFollowCenter(arg_6_1)
	self._followCenter = arg_6_1
end

function RedCliffMapWorld:setIsFollow(arg_7_1)
	self._isFollow = arg_7_1
end

function RedCliffMapWorld:startInertiaWorld(arg_8_1, arg_8_2)
	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_8_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_8_2
end

function RedCliffMapWorld:_doCreateGround()
	return RedCliffMapGround.new(self)
end

function RedCliffMapWorld:_doCreateTouch()
	return nil
end

function RedCliffMapWorld:_doInitTouchMatch()
	self._mapTouch = RedCliffMapTouch.new(self)
end

function RedCliffMapWorld:doDragWorld(arg_12_1)
	if self._isFollow then
		self:setIsFollow(false)

		self._followCenter = nil
	end

	self:moveWorld(arg_12_1)
end

function RedCliffMapWorld:moveWorld(arg_13_1)
	local var_13_0, var_13_1 = self:getPosition()
	local var_13_2, var_13_3 = KsMath.rangeIn(var_13_0 + arg_13_1.x, self._minMoveX, self._maxMoveX)
	local var_13_4, var_13_5 = KsMath.rangeIn(var_13_1 + arg_13_1.y, self:_resetMoveRangeY(var_13_2))

	self:setPosition(var_13_2, var_13_4)
	self:getMapStage():updateFloorCompPos(var_13_2, -var_13_4)

	return var_13_3, var_13_5
end

function RedCliffMapWorld:updateMainRoleRoutePath(arg_14_1)
	if self._worldRoutePath then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			self._worldRoutePath[#self._worldRoutePath + 1] = iter_14_1
		end
	else
		self._worldRoutePath = arg_14_1
	end
end

function RedCliffMapWorld:_initMoveRange()
	local var_15_0 = self:getMapGround():getMapHeight()
	local var_15_1 = self:getMapGround()
	local var_15_2 = var_15_1:getHalfTileH()

	self._minMoveX = -var_15_1
	self._maxMoveX = self:getMapGround():getMapWidth() / 2 - display.width + 150
	self._minMoveY = var_15_0 / 2 - var_15_2 - self._maxMoveX / 2
	self._maxMoveY = var_15_0 / 2 - var_15_2 + self._maxMoveX / 2
end

function RedCliffMapWorld:_checkFollowing(arg_16_1)
	if self._followCenter == nil then
		return
	end

	local var_16_0 = self:convertScreenCenter()
	local var_16_1 = KsMath.calculateDistance(self._followCenter, var_16_0)

	if var_16_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_16_2, var_16_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_16_0, 500 * (var_16_1 / 200) * arg_16_1)))

	if var_16_2 or var_16_3 then
		self._followCenter = nil
	end
end

function RedCliffMapWorld:_autoInertiaUpdate(arg_17_1)
	if self._autoInertiaDir == nil then
		return
	end

	local var_17_0, var_17_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist

	if var_17_0 or var_17_1 or self._autoInertiaDist <= 0 then
		self._autoInertiaDir = nil
	end
end

return RedCliffMapWorld
