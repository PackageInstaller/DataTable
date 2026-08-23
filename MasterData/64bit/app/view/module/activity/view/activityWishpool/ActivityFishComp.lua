local var_0_1 = 100
local var_0_2 = {
	NORMAL = 3,
	BACKING = 2,
	OUTED = 1,
	OUTING = 0
}

local function var_0_3(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = cc.p(0, 0)

	var_1_0.x = (1 - arg_1_4) * (1 - arg_1_4) * (1 - arg_1_4) * arg_1_0.x + 3 * arg_1_4 * ((1 - arg_1_4) * (1 - arg_1_4)) * arg_1_1.x + 3 * (arg_1_4 * arg_1_4) * (1 - arg_1_4) * arg_1_2.x + arg_1_4 * arg_1_4 * arg_1_4 * arg_1_3.x
	var_1_0.y = (1 - arg_1_4) * (1 - arg_1_4) * (1 - arg_1_4) * arg_1_0.y + 3 * arg_1_4 * ((1 - arg_1_4) * (1 - arg_1_4)) * arg_1_1.y + 3 * (arg_1_4 * arg_1_4) * (1 - arg_1_4) * arg_1_2.y + arg_1_4 * arg_1_4 * arg_1_4 * arg_1_3.y

	return var_1_0
end

local function var_0_4(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = cc.p(0, 0)

	var_2_0.x = 3 * ((1 - arg_2_4) * (1 - arg_2_4)) * (arg_2_1.x - arg_2_0.x) + 6 * (1 - arg_2_4) * arg_2_4 * (arg_2_2.x - arg_2_1.x) + 3 * (arg_2_4 * arg_2_4) * (arg_2_3.x - arg_2_2.x)
	var_2_0.y = 3 * ((1 - arg_2_4) * (1 - arg_2_4)) * (arg_2_1.y - arg_2_0.y) + 6 * (1 - arg_2_4) * arg_2_4 * (arg_2_2.y - arg_2_1.y) + 3 * (arg_2_4 * arg_2_4) * (arg_2_3.y - arg_2_2.y)

	return math.deg((math.atan2(var_2_0.y, var_2_0.x)))
end

local var_0_5 = 25
local var_0_6 = 10
local var_0_7 = {
	cc.p(51, 309),
	cc.p(544, 223),
	cc.p(910, -410)
}
local var_0_8 = {
	cc.p(-var_0_7[1].x, var_0_7[1].y),
	cc.p(-var_0_7[2].x, var_0_7[2].y),
	cc.p(-var_0_7[3].x, var_0_7[3].y)
}
local ActivityFishComp = class("ActivityFishComp", require("app.fairyGUI.activity.UI_ActivityFishComp"))

ActivityFishComp.FishPath = {}

function ActivityFishComp:ctor()
	self._angel = math.random(0, 360)
	self._fishCfg = nil
	self._isBeGet = false
	self._beGetPos = nil
	self._timeScale = 1
	self._speed = var_0_6
	self._fishOutState = var_0_2.NORMAL
	self._cocosObj = self:displayObject()
	self._calcRate = cc.Director:getInstance():getFrameRate() > 45 and 101 or 51
	self._isVictim = false
	self._lastPos = {}

	self:setRotation(self._angel)
end

function ActivityFishComp:setReverse(arg_4_1)
	self._reverse = arg_4_1

	self._fishSpine:setReverse(self._reverse)
end

function ActivityFishComp:setFishStyle(arg_5_1)
	self._fishCfg = g.core.config.wishpool_drop_info.get(arg_5_1)

	local var_5_0 = "wishpool_fish_black"

	if self._fishCfg.fish_appear == 1 then
		var_5_0 = "wishpool_fish_gold"
	elseif self._fishCfg.fish_appear == 2 then
		var_5_0 = "wishpool_fish_red"
	end

	self._fishSpine = self.m_fishHolder:addEffectSpine({
		isLoop = true,
		anim = "idle",
		name = var_5_0
	})

	self:setFishScale(math.random(self._fishCfg.fish_scale_min, self._fishCfg.fish_scale_max) / 1000)
end

function ActivityFishComp:onLoad()
	self._initPos = cc.p(self._cocosObj:getPosition())
end

function ActivityFishComp:setFishScale(arg_7_1)
	self._fishSpine:setScale(arg_7_1 or 1)

	self._scale = arg_7_1
end

function ActivityFishComp:fishIdle()
	self._inTurn = false

	self._fishSpine:setAnimation(0, "idle", true)
	self._fishSpine:addSpineEventListener(handler(self, self._onEventFish))
	self:_onUpdateIdle(1)
end

function ActivityFishComp:setFishNormal()
	self._fishOutState = var_0_2.NORMAL
end

function ActivityFishComp:fishTurn()
	self._inTurn = true

	self._fishSpine:setAnimation(0, "swerve", false)

	self._actionTime = 0

	self._fishSpine:addSpineEventListener(handler(self, self._onTurnFinish))

	self._startTurnPos = nil
	self._angel = self:getRotation()

	self:_onUpdateTurn(1)
end

function ActivityFishComp:_onUpdateTurn(arg_11_1)
	if self._fishOutState == var_0_2.OUTED then
		self:fishIdle()

		return
	end

	if self._inTurn then
		self._fishSpine:setTimeScale(1)

		self._actionTime = self._actionTime + arg_11_1 / self._calcRate
		self._startTurnPos = self._startTurnPos or cc.p(self:getPosition())

		if self._actionTime > 1 then
			self._actionTime = 1
		end

		local var_11_0 = self._actionTime
		local var_11_1 = var_0_7

		if self._reverse then
			var_11_1 = var_0_8
		end

		local var_11_2
		local var_11_3
		local var_11_4 = self._scale .. "_" .. tostring(self._reverse) .. var_11_0

		if ActivityFishComp.FishPath[var_11_4] then
			var_11_2 = ActivityFishComp.FishPath[var_11_4].pos
			var_11_3 = ActivityFishComp.FishPath[var_11_4].angle
		else
			var_11_2 = var_0_3(cc.p(0, 0), cc.pMul(var_11_1[1], self._scale), cc.pMul(var_11_1[2], self._scale), cc.pMul(var_11_1[3], self._scale), var_11_0)
			var_11_3 = var_0_4(cc.p(0, 0), cc.pMul(var_11_1[1], self._scale), cc.pMul(var_11_1[2], self._scale), cc.pMul(var_11_1[3], self._scale), var_11_0)
			ActivityFishComp.FishPath[var_11_4] = {
				pos = var_11_2,
				angle = var_11_3
			}
		end

		if self._actionTime == 1 then
			self._angel = self:getRotation()
			self._lastAngle = nil
			self._speed = var_0_5

			self:fishIdle()

			return
		end

		local var_11_5 = self:getLastDirWithPos(-self._angel, var_11_2)

		self:setPosition(cc.pAdd(self._startTurnPos, cc.p(var_11_5.x, -var_11_5.y)))
		self:setRotation(90 - var_11_3 + self._angel)
	end
end

function ActivityFishComp:setFishVictim()
	self._isVictim = true
	self._fishOutState = var_0_2.OUTING
end

function ActivityFishComp:fishReborn()
	self._isVictim = false
	self._isBeGet = false
	self._stop = false

	self:fishIdle()
end

function ActivityFishComp:fishSpeedFast()
	self._fishSpeedFast = true
	self._speed = 40
end

function ActivityFishComp:fishSpeedNormal()
	self._fishSpeedFast = false

	if self._isVictim then
		self._speed = var_0_6
	end
end

function ActivityFishComp:_onUpdateIdle(arg_16_1)
	if self._fishOutState == var_0_2.OUTED then
		return
	end

	if self._fishOutState == var_0_2.NORMAL and not self:checkInRunRange() and not self:isInTurn() then
		self._needPlayTurn = true
	end

	local var_16_0 = cc.p(self:getPosition())
	local var_16_1 = self._speed * self._scale

	if self._fishOutState == var_0_2.OUTING then
		var_16_1 = 40 * self._scale
	elseif self._isBeGet then
		var_16_1 = 20 * self._scale
	end

	self._fishSpine:setTimeScale((var_16_1 / (var_0_6 * self._scale) - 1) / 2 + 1)

	local var_16_2 = cc.pAdd(var_16_0, (cc.pMul(self:getLastDirWithPos(180 + self._angel), var_16_1)))

	self:setPosition(var_16_2)

	if not self._fishSpeedFast then
		if self._speed > var_0_6 then
			self._speed = math.max(self._speed - 1, var_0_6)
		elseif self._speed < var_0_6 then
			self._speed = math.min(self._speed + 1, var_0_6)
		end
	end

	if self._isBeGet then
		local var_16_3 = cc.pGetDistance(var_16_2, self._beGetPos)

		if var_16_3 < var_0_1 * self._scale or var_16_3 > 5000 then
			self:dispatchCompEvent("EVENT_FISH_BE_GET")
		end
	else
		self:checkAndSetFishOutState()
		self:checkAndSetFishInState()
	end
end

function ActivityFishComp:_onTurnRunFinish()
	self:displayObject():stopAllActions()
end

function ActivityFishComp:checkInRunRange()
	local var_18_0 = cc.p(self:getPosition())
	local var_18_1 = self:getParent():getSize()

	if var_18_0.x < 0 or var_18_0.y < 0 or var_18_0.x > var_18_1.width or var_18_0.y > var_18_1.height then
		return false
	end

	return true
end

function ActivityFishComp:checkAndSetFishOutState()
	if self._fishOutState ~= var_0_2.OUTING then
		return
	end

	local var_19_0 = cc.p(self:getPosition())
	local var_19_1 = self:getParent():getSize()

	if var_19_0.x < -400 or var_19_0.y < -400 or var_19_0.x > var_19_1.width + 400 or var_19_0.y > var_19_1.height + 400 then
		self._fishOutState = var_0_2.OUTED
		self._timeScale = 1

		self:dispatchCompEvent("FISH_OUT_FINISH")
	end
end

function ActivityFishComp:setMoveStop()
	self._stop = true
end

function ActivityFishComp:isStop()
	return self._stop
end

function ActivityFishComp:fishMoveToPos(arg_22_1, arg_22_2)
	self._isBeGet = true
	self._beGetPos = arg_22_1
	arg_22_1.y = arg_22_1.y + 15

	local var_22_0 = cc.p(self:getPosition())

	self:setPosition(cc.pAdd(arg_22_1, cc.p(1000 * (math.random(1, 2) > 1 and 1 or -1), (math.random(1, 2) > 1 and 1 or -1) * math.random(300, 1000))))

	self._fishOutState = var_0_2.BACKING
	self._angel = math.deg(cc.pToAngleSelf((cc.pSub(arg_22_1, (cc.p(self:getPosition())))))) + 90

	self:setRotation(self._angel)
	self:fishIdle()
end

function ActivityFishComp:checkFishMoveDisAndFix()
	if not self._beGetPos then
		return
	end

	local var_23_0 = cc.pGetDistance(self._beGetPos, cc.p(self:getPosition()))

	if self._oldDis and var_23_0 > self._oldDis then
		self:fishMoveToPos(self._beGetPos, true)

		self._oldDis = nil

		return
	end

	self._oldDis = var_23_0
end

function ActivityFishComp:checkAndSetFishInState()
	if self._fishOutState ~= var_0_2.BACKING then
		return
	end

	local var_24_0 = cc.p(self:getPosition())
	local var_24_1 = self:getParent():getSize()

	if var_24_0.x > 200 and var_24_0.x < var_24_1.width - 200 and var_24_0.y > 200 and var_24_0.y < var_24_1.height - 200 then
		self._fishOutState = var_0_2.NORMAL
	end
end

function ActivityFishComp:isInTurn()
	return self._inTurn
end

function ActivityFishComp:_onEventFish(arg_26_1)
	if arg_26_1.type == "complete" and not self:checkInRunRange() and self._fishOutState == var_0_2.NORMAL then
		self:fishTurn()
	end
end

function ActivityFishComp:_onTurnFinish(arg_27_1)
	if arg_27_1.type == "complete" and self._needPlayTurn then
		self._needPlayTurn = false

		self:newScheduleOnce(handler(self, self.fishTurn), 0)
	end
end

function ActivityFishComp:checkIsMyType(arg_28_1)
	if arg_28_1 == self._fishCfg.id then
		return true
	end

	return false
end

function ActivityFishComp:getDropId()
	return self._fishCfg.id
end

function ActivityFishComp:fishOut()
	self._fishOutState = var_0_2.OUTING
end

function ActivityFishComp:fishIn()
	self._fishOutState = var_0_2.BACKING
	self._angel = (self._angel + 180) % 360

	self:setRotation(self._angel)
	self:fishIdle()
end

function ActivityFishComp:getLastDirWithPos(arg_32_1, arg_32_2)
	return (cc.pRotateByAngle(arg_32_2 or cc.p(0, 1), cc.p(0, 0), (math.rad(arg_32_1))))
end

function ActivityFishComp:doRun(arg_33_1)
	if self._stop then
		return
	end

	if self._inTurn then
		self:_onUpdateTurn(arg_33_1)
	else
		self:_onUpdateIdle(arg_33_1)
	end
end

return ActivityFishComp
