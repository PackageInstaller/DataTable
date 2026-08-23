local function var_0_2(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = cc.p(0, 0)

	var_1_0.x = (1 - arg_1_4) * (1 - arg_1_4) * (1 - arg_1_4) * arg_1_0.x + 3 * arg_1_4 * ((1 - arg_1_4) * (1 - arg_1_4)) * arg_1_1.x + 3 * (arg_1_4 * arg_1_4) * (1 - arg_1_4) * arg_1_2.x + arg_1_4 * arg_1_4 * arg_1_4 * arg_1_3.x
	var_1_0.y = (1 - arg_1_4) * (1 - arg_1_4) * (1 - arg_1_4) * arg_1_0.y + 3 * arg_1_4 * ((1 - arg_1_4) * (1 - arg_1_4)) * arg_1_1.y + 3 * (arg_1_4 * arg_1_4) * (1 - arg_1_4) * arg_1_2.y + arg_1_4 * arg_1_4 * arg_1_4 * arg_1_3.y

	return var_1_0
end

local function var_0_3(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = cc.p(0, 0)

	var_2_0.x = 3 * ((1 - arg_2_4) * (1 - arg_2_4)) * (arg_2_1.x - arg_2_0.x) + 6 * (1 - arg_2_4) * arg_2_4 * (arg_2_2.x - arg_2_1.x) + 3 * (arg_2_4 * arg_2_4) * (arg_2_3.x - arg_2_2.x)
	var_2_0.y = 3 * ((1 - arg_2_4) * (1 - arg_2_4)) * (arg_2_1.y - arg_2_0.y) + 6 * (1 - arg_2_4) * arg_2_4 * (arg_2_2.y - arg_2_1.y) + 3 * (arg_2_4 * arg_2_4) * (arg_2_3.y - arg_2_2.y)

	return math.deg((math.atan2(var_2_0.y, var_2_0.x)))
end

local var_0_4 = 25
local var_0_5 = 10
local var_0_6 = {
	cc.p(51, 309),
	cc.p(544, 223),
	cc.p(910, -410)
}
local var_0_7 = {
	cc.p(-var_0_6[1].x, var_0_6[1].y),
	cc.p(-var_0_6[2].x, var_0_6[2].y),
	cc.p(-var_0_6[3].x, var_0_6[3].y)
}
local DebugFishComp2 = class("DebugFishComp2", require("app.fairyGUI.debug.UI_DebugFishComp2"))

function DebugFishComp2:ctor()
	self._angel = math.random(0, 360)
	self._fishSpine = self.m_fishHolder:addEffectSpine({
		anim = "idle",
		name = "fish",
		isLoop = true
	})
	self._speed = var_0_5
	self._cocosObj = self:displayObject()
	self._lastPos = {}

	self:setRotation(self._angel)
end

function DebugFishComp2:setReverse(arg_4_1)
	self._reverse = arg_4_1

	self._fishSpine:setReverse(self._reverse)
end

function DebugFishComp2:onLoad()
	self._initPos = cc.p(self._cocosObj:getPosition())
end

function DebugFishComp2:setFishScale(arg_6_1)
	self._fishSpine:setScale(arg_6_1 or 1)

	self._scale = arg_6_1
end

function DebugFishComp2:fishIdle()
	self._inTurn = false

	self._fishSpine:setAnimation(0, "idle", true)
	self._fishSpine:addSpineEventListener(handler(self, self._onEventFish))
	self:_onUpdateIdle(1)
end

function DebugFishComp2:fishTurn()
	self._waitTurn = false
	self._inTurn = true

	self._fishSpine:setAnimation(0, "swerve", false)

	self._actionTime = 0

	self._fishSpine:addSpineEventListener()

	self._startTurnPos = nil
	self._angel = self:getRotation()

	self:_onUpdateTurn(1)
end

function DebugFishComp2:_onUpdateTurn(arg_9_1)
	if self._inTurn then
		self._actionTime = self._actionTime + arg_9_1 / 51
		self._startTurnPos = self._startTurnPos or cc.p(self:getPosition())

		if self._actionTime > 1 then
			self._actionTime = 1
		end

		local var_9_0 = self._actionTime
		local var_9_1 = var_0_6

		if self._reverse then
			var_9_1 = var_0_7
		end

		local var_9_2 = var_0_2(cc.p(0, 0), cc.pMul(var_9_1[1], self._scale), cc.pMul(var_9_1[2], self._scale), cc.pMul(var_9_1[3], self._scale), var_9_0)

		if self._actionTime == 1 then
			self._angel = self:getRotation()
			self._lastAngle = nil
			self._speed = var_0_4

			self:fishIdle()

			return
		end

		local var_9_3 = self:getLastDirWithPos(-self._angel, var_9_2)

		self:setPosition(cc.pAdd(self._startTurnPos, cc.p(var_9_3.x, -var_9_3.y)))
		self:setRotation(90 - var_0_3(cc.p(0, 0), cc.pMul(var_9_1[1], self._scale), cc.pMul(var_9_1[2], self._scale), cc.pMul(var_9_1[3], self._scale), var_9_0) + self._angel)
	end
end

function DebugFishComp2:_onUpdateIdle(arg_10_1, arg_10_2)
	if not self:checkInRunRange() and not self:isInTurn() and not self._waitTurn then
		self._needPlayTurn = true
	end

	if not arg_10_2 then
		self:setPosition(cc.pAdd(cc.p(self:getPosition()), cc.pMul(self:getLastDirWithPos(180 + self._angel), self._speed * self._scale)))

		if self._speed > var_0_5 then
			self._speed = math.max(self._speed - 1, var_0_5)
		elseif self._speed < var_0_5 then
			self._speed = math.min(self._speed + 1, var_0_5)
		end
	end
end

function DebugFishComp2:_onTurnRunFinish()
	self:displayObject():stopAllActions()
end

function DebugFishComp2:checkInRunRange()
	local var_12_0 = cc.p(self:getPosition())
	local var_12_1 = self:getParent():getSize()

	if var_12_0.x < 0 or var_12_0.y < 0 or var_12_0.x > var_12_1.width or var_12_0.y > var_12_1.height then
		return false
	end

	return true
end

function DebugFishComp2:isInTurn()
	return self._inTurn
end

function DebugFishComp2:_onEventFish(arg_14_1)
	if arg_14_1.type == "complete" and self._needPlayTurn then
		self._needPlayTurn = false
		self._waitTurn = true

		self:newScheduleOnce(handler(self, self.fishTurn), 0)
	end
end

function DebugFishComp2:getLastDirWithPos(arg_15_1, arg_15_2)
	return (cc.pRotateByAngle(arg_15_2 or cc.p(0, 1), cc.p(0, 0), (math.rad(arg_15_1))))
end

function DebugFishComp2:getMirrorDir(arg_16_1, arg_16_2)
	local var_16_0 = {
		x = arg_16_1.x - arg_16_2.x,
		y = arg_16_1.y - arg_16_2.y
	}
	local var_16_1 = math.sqrt(var_16_0.x * var_16_0.x + var_16_0.y * var_16_0.y)
	local var_16_2 = {}

	var_16_2.x = -var_16_0.x / var_16_1 * var_16_1
	var_16_2.y = -var_16_0.x / var_16_1 * var_16_1

	return {
		x = arg_16_2.x + var_16_2.x,
		y = arg_16_2.y + var_16_2.y
	}
end

function DebugFishComp2:doRun(arg_17_1)
	if self._inTurn then
		self:_onUpdateTurn(arg_17_1)
	else
		self:_onUpdateIdle(arg_17_1)
	end
end

return DebugFishComp2
