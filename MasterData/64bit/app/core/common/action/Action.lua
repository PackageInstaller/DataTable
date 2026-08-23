local Bezier = require("app.core.common.action.Bezier")
local var_0_1 = math.min
local var_0_2 = math.max
local var_0_3 = math.pow
local CCFAction = class("CCFAction")

function CCFAction:isDone()
	return true
end

function CCFAction:isRunning()
	return self._isRunning
end

function CCFAction:retain()
	return
end

function CCFAction:release()
	return
end

function CCFAction:startWithTarget(arg_5_1)
	assert(arg_5_1, "Target could not be nil !")

	self._target = arg_5_1
	self._isRunning = true
end

function CCFAction:step(arg_6_1)
	return
end

function CCFAction:stepNext()
	self:step(1)

	return self:isDone()
end

function CCFAction:stop()
	self._isRunning = false
end

function CCFAction:_update(arg_9_1)
	return
end

local CCFActionInterval = class("CCFActionInterval", CCFAction)

function CCFActionInterval:ctor(arg_10_1)
	CCFActionInterval.super.ctor(self)
	assert(arg_10_1 and arg_10_1 > 0, "Totalframe could not be nil or negative !")

	self._totalFrame = arg_10_1
end

function CCFActionInterval:startWithTarget(arg_11_1)
	CCFActionInterval.super.startWithTarget(self, arg_11_1)

	self._curFrame = 0
end

function CCFActionInterval:getElapsed()
	return self._curFrame
end

function CCFActionInterval:getTotalFrame()
	return self._totalFrame
end

function CCFActionInterval:getDuration()
	return self._totalFrame * cc.Director:getInstance():getAnimationInterval()
end

function CCFActionInterval:step(arg_15_1)
	arg_15_1 = assert(tonumber(arg_15_1), "The dt must be integer !")

	for iter_15_0 = 1, math.floor(arg_15_1) do
		self._curFrame = self._curFrame + 1

		if self:isDone() then
			self._isRunning = false

			return
		end

		self._isRunning = true

		self:_update(var_0_1(var_0_2(0, self._curFrame / self._totalFrame), 1))
	end
end

function CCFActionInterval:isDone()
	return self._curFrame > self._totalFrame
end

function CCFActionInterval:stop()
	CCFActionInterval.super.stop(self)

	self._curFrame = 0
end

local CCFMoveTo = class("CCFMoveTo", CCFActionInterval)

function CCFMoveTo:ctor(arg_18_1, arg_18_2, arg_18_3)
	CCFMoveTo.super.ctor(self, arg_18_1)

	self._destination = arg_18_2
	self._params = arg_18_3

	if arg_18_3 and type(arg_18_3) == "table" then
		self._bezier = Bezier.new(unpack(self._params))
	else
		self._params = nil
	end
end

function CCFMoveTo:startWithTarget(arg_19_1)
	CCFMoveTo.super.startWithTarget(self, arg_19_1)

	self._original = cc.p(arg_19_1:getPosition())

	if type(self._original.x) == "table" then
		self._original = self._original.x
	end

	self._delta = cc.pSub(self._destination, self._original)
end

function CCFMoveTo:_update(arg_20_1)
	CCFMoveTo.super._update(self, arg_20_1)

	local var_20_1 = cc.pAdd(self._original, cc.pMul(self._delta, (self._params and self._bezier or nil) and self._bezier:getYAtX(arg_20_1)))

	self._target:setPosition(var_20_1.x, var_20_1.y)
end

local CCFMoveBy = class("CCFMoveBy", CCFMoveTo)

function CCFMoveBy:startWithTarget(arg_21_1)
	CCFMoveBy.super.startWithTarget(self, arg_21_1)

	self._delta = self._destination
	self._destination = cc.pAdd(self._original, self._delta)
end

function CCFMoveBy:reverse()
	return CCFMoveBy.new(self._totalFrame, cc.pMul(self._delta, -1))
end

local CCFRotateTo = class("CCFRotateTo", CCFActionInterval)

function CCFRotateTo:ctor(arg_23_1, arg_23_2)
	CCFRotateTo.super.ctor(self, arg_23_1)

	self._destination = arg_23_2
end

function CCFRotateTo:startWithTarget(arg_24_1)
	CCFRotateTo.super.startWithTarget(self, arg_24_1)

	self._original = arg_24_1:getRotation()
	self._delta = self._destination - self._original
end

function CCFRotateTo:_update(arg_25_1)
	CCFRotateTo.super._update(self, arg_25_1)
	self._target:setRotation(self._original + self._delta * arg_25_1)
end

local CCFRotateBy = class("CCFRotateBy", CCFRotateTo)

function CCFRotateBy:startWithTarget(arg_26_1)
	CCFRotateBy.super.startWithTarget(self, arg_26_1)

	self._delta = self._destination
	self._destination = self._original + self._delta
end

function CCFRotateBy:reverse()
	return CCFRotateBy.new(self._totalFrame, self._delta * -1)
end

local CCFScaleTo = class("CCFScaleTo", CCFActionInterval)

function CCFScaleTo:ctor(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	CCFScaleTo.super.ctor(self, arg_28_1)

	self._destination = arg_28_2
	self._destination1 = arg_28_3
	self._params = arg_28_4

	if arg_28_4 and type(arg_28_4) == "table" then
		self._bezier = Bezier.new(unpack(self._params))
	else
		self._params = nil
	end
end

function CCFScaleTo:startWithTarget(arg_29_1)
	CCFScaleTo.super.startWithTarget(self, arg_29_1)

	if self._destination1 then
		self._original = arg_29_1:getScaleX()
		self._original1 = arg_29_1:getScaleY()
		self._delta = self._destination - self._original
		self._delta1 = self._destination1 - self._original1
	else
		self._original = arg_29_1:getScale()
		self._delta = self._destination - self._original
	end
end

function CCFScaleTo:_update(arg_30_1)
	CCFScaleTo.super._update(self, arg_30_1)

	local var_30_0 = arg_30_1

	if self._params and self._bezier then
		var_30_0 = self._bezier:getYAtX(arg_30_1)
	end

	if self._destination1 then
		self._target:setScaleX(self._original + self._delta * var_30_0)
		self._target:setScaleY(self._original1 + self._delta1 * var_30_0)
	else
		self._target:setScale(self._original + self._delta * var_30_0)
	end
end

local CCFScaleBy = class("CCFScaleBy", CCFScaleTo)

function CCFScaleBy:startWithTarget(arg_31_1)
	CCFScaleBy.super.startWithTarget(self, arg_31_1)

	self._delta = self._destination
	self._delta1 = self._destination1
	self._destination = self._original + self._delta

	if self._destination1 then
		self._destination1 = self._original1 + self._delta1
	end
end

function CCFScaleBy:reverse()
	return CCFScaleBy.new(self._totalFrame, self._delta * -1, self._delta1 and self._delta1 * -1)
end

local CCFSkewTo = class("CCFSkewTo", CCFActionInterval)

function CCFSkewTo:ctor(arg_33_1, arg_33_2, arg_33_3)
	CCFSkewTo.super.ctor(self, arg_33_1)

	self._skewX = arg_33_2
	self._skewY = arg_33_3
end

function CCFSkewTo:startWithTarget(arg_34_1)
	CCFSkewTo.super.startWithTarget(self, arg_34_1)

	self._originalSkewX = arg_34_1:getSkewX()
	self._originalSkewX = self._originalSkewX > 0 and math.fmod(self._originalSkewX, 180) or math.fmod(self._originalSkewX, -180)
	self._skewDeltaX = self._skewX - self._originalSkewX

	if self._skewDeltaX > 180 then
		self._skewDeltaX = self._skewDeltaX - 360
	end

	if self._skewDeltaX < -180 then
		self._skewDeltaX = self._skewDeltaX + 360
	end

	self._originalSkewY = arg_34_1:getSkewY()
	self._originalSkewY = self._originalSkewY > 0 and math.fmod(self._originalSkewY, 360) or math.fmod(self._originalSkewY, -360)
	self._skewDeltaY = self._skewY - self._originalSkewY

	if self._skewDeltaY > 180 then
		self._skewDeltaY = self._skewDeltaY - 360
	end

	if self._skewDeltaY < -180 then
		self._skewDeltaY = self._skewDeltaY + 360
	end
end

function CCFSkewTo:_update(arg_35_1)
	CCFSkewTo.super._update(self, arg_35_1)
	self._target:setSkewX(self._originalSkewX + self._skewDeltaX * arg_35_1)
	self._target:setSkewY(self._originalSkewY + self._skewDeltaY * arg_35_1)
end

local CCFFadeTo = class("CCFFadeTo", CCFActionInterval)

function CCFFadeTo:ctor(arg_36_1, arg_36_2, arg_36_3)
	CCFFadeTo.super.ctor(self, arg_36_1)

	self._destination = arg_36_2
	self._params = arg_36_3

	if arg_36_3 and type(arg_36_3) == "table" then
		self._bezier = Bezier.new(unpack(self._params))
	else
		self._params = nil
	end
end

function CCFFadeTo:startWithTarget(arg_37_1)
	CCFFadeTo.super.startWithTarget(self, arg_37_1)

	self._original = arg_37_1:getOpacity()
	self._delta = self._destination - self._original
end

function CCFFadeTo:_update(arg_38_1)
	CCFFadeTo.super._update(self, arg_38_1)

	if not tolua.isnull(self._target) then
		self._target:setOpacity(self._original + self._delta * ((self._params and self._bezier or nil) and self._bezier:getYAtX(arg_38_1)))
	end
end

local CCFColorTo = class("CCFColorTo", CCFActionInterval)

function CCFColorTo:ctor(arg_39_1, arg_39_2)
	CCFColorTo.super.ctor(self, arg_39_1)

	self._destination = arg_39_2
end

function CCFColorTo:startWithTarget(arg_40_1)
	CCFColorTo.super.startWithTarget(self, arg_40_1)

	self._original = arg_40_1:getColor()
	self._delta = cc.c3b(self._destination.r - self._original.r, self._destination.g - self._original.g, self._destination.b - self._original.b)
end

function CCFColorTo:_update(arg_41_1)
	CCFColorTo.super._update(self, arg_41_1)
	self._target:setColor(cc.c3b(self._original.r + self._delta.r * arg_41_1, self._original.g + self._delta.g * arg_41_1, self._original.b + self._delta.b * arg_41_1))
end

local CCFColorOffsetTo = class("CCFColorOffsetTo", CCFActionInterval)

function CCFColorOffsetTo:ctor(arg_42_1, arg_42_2)
	CCFColorOffsetTo.super.ctor(self, arg_42_1)

	self._destination = arg_42_2
end

function CCFColorOffsetTo:startWithTarget(arg_43_1)
	CCFColorOffsetTo.super.startWithTarget(self, arg_43_1)

	self._original = arg_43_1:getColorOffset()
	self._delta = cc.c4f(self._destination.r - self._original.r, self._destination.g - self._original.g, self._destination.b - self._original.b, self._destination.a - self._original.a)
end

function CCFColorOffsetTo:_update(arg_44_1)
	CCFColorOffsetTo.super._update(self, arg_44_1)
	self._target:setColorOffset(cc.c4f(self._original.r + self._delta.r * arg_44_1, self._original.g + self._delta.g * arg_44_1, self._original.b + self._delta.b * arg_44_1, self._original.a + self._delta.a * arg_44_1))
end

local CCFSpawn = class("CCFSpawn", CCFActionInterval)

function CCFSpawn:ctor(arg_45_1)
	local var_45_0 = 1

	for iter_45_0 = 1, #arg_45_1 do
		if arg_45_1[iter_45_0] and var_45_0 < arg_45_1[iter_45_0]:getTotalFrame() then
			var_45_0 = arg_45_1[iter_45_0]:getTotalFrame()
		end
	end

	self._actions = arg_45_1

	CCFSpawn.super.ctor(self, var_45_0)
end

function CCFSpawn:startWithTarget(arg_46_1)
	CCFSpawn.super.startWithTarget(self, arg_46_1)

	for iter_46_0 = 1, #self._actions do
		if self._actions[iter_46_0] then
			self._actions[iter_46_0]:startWithTarget(arg_46_1)
		end
	end
end

function CCFSpawn:_update(arg_47_1)
	CCFSpawn.super._update(self, arg_47_1)

	for iter_47_0 = 1, #self._actions do
		if self._actions[iter_47_0] and not self._actions[iter_47_0]:isDone() then
			self._actions[iter_47_0]:_update(arg_47_1 * self:getTotalFrame() / self._actions[iter_47_0]:getTotalFrame())
		end
	end
end

function CCFSpawn:reverse()
	local var_48_0 = {}

	for iter_48_0 = 1, #self._actions do
		if self._actions[iter_48_0].reverse then
			var_48_0[#var_48_0 + 1] = self._actions[iter_48_0]:reverse()
		end
	end

	return CCFSpawn.new(var_48_0)
end

local CCFShake = class("CCFShake", CCFActionInterval)

function CCFShake:ctor(arg_49_1, arg_49_2, arg_49_3)
	self._strengthX = arg_49_2
	self._strengthY = arg_49_3

	CCFShake.super.ctor(self, arg_49_1)
end

local function var_0_18(arg_50_0, arg_50_1)
	return math.random(0, 1) * (arg_50_1 - arg_50_0) + arg_50_0
end

function CCFShake:startWithTarget(arg_51_1)
	CCFShake.super.startWithTarget(self, arg_51_1)

	self._originalX, self._originalY = arg_51_1:getPosition()
end

function CCFShake:_update(arg_52_1)
	CCFShake.super._update(self, arg_52_1)
	self._target:setPosition(cc.pAdd(cc.p(self._originalX, self._originalY), cc.p(var_0_18(-self._strengthX, self._strengthX) * arg_52_1, var_0_18(-self._strengthY, self._strengthY) * arg_52_1)))
end

function CCFShake:stop()
	CCFShake.super.stop(self)

	if self._target then
		self._target:setPosition(cc.p(self._originalX, self._originalY))
	end
end

local CCFShake1 = class("CCFShake1", CCFActionInterval)

function CCFShake1:ctor(arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	self._strengthX = arg_54_2
	self._strengthY = arg_54_3
	self._periodFrames = arg_54_4 or 4
	self._stepX = self._strengthX * 4 / arg_54_4
	self._stepY = self._strengthY * 4 / arg_54_4
	self._flag = {
		1,
		1
	}

	CCFShake1.super.ctor(self, arg_54_1)
end

function CCFShake1:getShakeDel(arg_55_1, arg_55_2, arg_55_3, arg_55_4, arg_55_5)
	local var_55_0 = 0

	if self._flag[arg_55_5] >= 0 then
		var_55_0 = arg_55_1 + arg_55_3

		if arg_55_1 + arg_55_3 >= arg_55_4 + arg_55_2 then
			var_55_0 = arg_55_4 + arg_55_2
			self._flag[arg_55_5] = -1
		end
	elseif self._flag[arg_55_5] < 0 then
		var_55_0 = arg_55_1 - arg_55_3

		if arg_55_1 - arg_55_3 <= arg_55_4 - arg_55_2 then
			var_55_0 = arg_55_4 - arg_55_2
			self._flag[arg_55_5] = 1
		end
	end

	return var_55_0
end

function CCFShake1:startWithTarget(arg_56_1)
	CCFShake1.super.startWithTarget(self, arg_56_1)

	self._originalX, self._originalY = arg_56_1:getPosition()
end

function CCFShake1:_update(arg_57_1)
	CCFShake1.super._update(self, arg_57_1)

	local var_57_0, var_57_1 = self._target:getPosition()

	self._target:setPosition(cc.p(self:getShakeDel(var_57_0, self._strengthX, self._stepX, self._originalX, 1), (self:getShakeDel(var_57_1, self._strengthY, self._stepY, self._originalY, 2))))
end

function CCFShake1:stop()
	CCFShake1.super.stop(self)

	if self._target then
		self._target:setPosition(cc.p(self._originalX, self._originalY))
	end
end

local CCFScale = class("CCFScale", CCFActionInterval)

function CCFScale:ctor(arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	self._strengthX = arg_59_2
	self._strengthY = arg_59_3
	self._periodFrames = arg_59_4 or 4
	self._stepX = self._strengthX * 4 / arg_59_4
	self._stepY = self._strengthY * 4 / arg_59_4
	self._flag = {
		1,
		1
	}

	CCFScale.super.ctor(self, arg_59_1)
end

function CCFScale:getScaleDel(arg_60_1, arg_60_2, arg_60_3, arg_60_4, arg_60_5)
	local var_60_0 = 0

	if self._flag[arg_60_5] >= 0 then
		var_60_0 = arg_60_1 + arg_60_3

		if arg_60_1 + arg_60_3 >= arg_60_4 + arg_60_2 then
			var_60_0 = arg_60_4 + arg_60_2
			self._flag[arg_60_5] = -1
		end
	elseif self._flag[arg_60_5] < 0 then
		var_60_0 = arg_60_1 - arg_60_3

		if arg_60_1 - arg_60_3 <= arg_60_4 - arg_60_2 then
			var_60_0 = arg_60_4 - arg_60_2
			self._flag[arg_60_5] = 1
		end
	end

	return var_60_0
end

function CCFScale:startWithTarget(arg_61_1)
	CCFScale.super.startWithTarget(self, arg_61_1)

	self._originalX = arg_61_1:getScaleX()
	self._originalY = arg_61_1:getScaleY()
end

function CCFScale:_update(arg_62_1)
	CCFScale.super._update(self, arg_62_1)
	self._target:setScaleX((self:getScaleDel(self._target:getScaleX(), self._strengthX, self._stepX, self._originalX, 1)))
	self._target:setScaleY((self:getScaleDel(self._target:getScaleY(), self._strengthY, self._stepY, self._originalY, 2)))
end

function CCFScale:stop()
	CCFScale.super.stop(self)

	if self._target then
		self._target:setScaleX(self._originalX)
		self._target:setScaleY(self._originalY)
	end
end

local CCFFocusOn = class("CCFFocusOn", CCFActionInterval)

function CCFFocusOn:ctor(arg_64_1, arg_64_2)
	CCFFocusOn.super.ctor(self, arg_64_1)

	self._focusRect = arg_64_2
end

function CCFFocusOn:startWithTarget(arg_65_1)
	CCFFocusOn.super.startWithTarget(self, arg_65_1)

	self._originalScale = arg_65_1:getScale()

	local var_65_0 = arg_65_1:getContentSize()

	self._scaleFactor = var_0_1(var_65_0.width / self._focusRect.width, var_65_0.height / self._focusRect.height) - self._originalScale
	self._originalPosition = cc.p(arg_65_1:getPosition())
	self._original = cc.pSub(arg_65_1:convertToWorldSpace(cc.pAdd(cc.p(self._focusRect.x, self._focusRect.y), cc.p(self._focusRect.width / 2, self._focusRect.height / 2))), cc.p(display.width / 2, display.height / 2))
	self._positionMove = cc.pMul(self._original, -1)
	self._reverseRect = cc.rect(0, 0, 0, 0)

	local var_65_1 = arg_65_1:convertToWorldSpace(cc.p(self._reverseRect.x, self._reverseRect.y))

	self._reverseRect.x, self._reverseRect.y = var_65_1.x, var_65_1.y

	local var_65_2 = arg_65_1:convertToNodeSpace(cc.pSub(cc.pFromSize(cc.Director:getInstance():getWinSize()), var_65_1))

	self._reverseRect.width, self._reverseRect.height = var_65_2.x, var_65_2.y
end

function CCFFocusOn:_update(arg_66_1)
	CCFFocusOn.super._update(self, arg_66_1)
	self._target:setScale(self._originalScale + arg_66_1 * self._scaleFactor)
	self._target:setPosition(self._originalPosition)
	self._target:setPosition(cc.pAdd(cc.pSub(self._originalPosition, (cc.pSub(cc.pSub(self._target:convertToWorldSpace(cc.pAdd(cc.p(self._focusRect.x, self._focusRect.y), cc.p(self._focusRect.width / 2, self._focusRect.height / 2))), cc.p(display.width / 2, display.height / 2)), self._original))), cc.p(self._positionMove.x * arg_66_1, self._positionMove.y * arg_66_1)))
end

function CCFFocusOn:reverse()
	return CCFFocusOn.new(self._totalFrame, self._reverseRect)
end

function CCFFocusOn:stop()
	CCFFocusOn.super.stop(self)
	self._target:setPosition(self._originalPosition)
	self._target:setScale(self._originalScale)
end

local CCFDelayTime = class("CCFDelayTime", CCFActionInterval)
local CCFSequence = class("CCFSequence", CCFActionInterval)

function CCFSequence:ctor(arg_69_1)
	local var_69_0 = 0

	self._actions = {}

	for iter_69_0 = 1, #arg_69_1 do
		if arg_69_1[iter_69_0] then
			var_69_0 = var_69_0 + arg_69_1[iter_69_0]:getTotalFrame()
			self._actions[#self._actions + 1] = arg_69_1[iter_69_0]
		end
	end

	CCFSequence.super.ctor(self, var_69_0)
end

function CCFSequence:startWithTarget(arg_70_1)
	CCFSequence.super.startWithTarget(self, arg_70_1)

	self._curTotalFrame = self._actions[1]:getTotalFrame()
	self._lastFramePercent = 0
	self._index = 1
end

function CCFSequence:_update(arg_71_1)
	CCFSequence.super._update(self, arg_71_1)

	repeat
		if not self._actions[self._index]:isRunning() then
			self._actions[self._index]:startWithTarget(self._target)
		end

		local var_71_1 = self._curTotalFrame / self._totalFrame

		if self._curTotalFrame / self._totalFrame <= arg_71_1 then
			self._actions[self._index]:_update(1)

			self._index = self._index + 1
			self._lastFramePercent = var_71_1

			if not self._actions[self._index] then
				self._curTotalFrame = self._totalFrame

				return
			end

			arg_71_1 = arg_71_1 - var_71_1
			self._curTotalFrame = self._curTotalFrame + self._actions[self._index]:getTotalFrame()
		else
			self._actions[self._index]:_update(var_0_1(1, (arg_71_1 - self._lastFramePercent) / (self._actions[self._index]:getTotalFrame() / self:getTotalFrame())))
		end
	until arg_71_1 < var_71_1
end

local CCFRepeatForever = class("CCFRepeatForever", CCFActionInterval)

function CCFRepeatForever:ctor(arg_72_1)
	CCFRepeatForever.super.ctor(self, 1)

	self._innerAction = arg_72_1
end

function CCFRepeatForever:startWithTarget(arg_73_1)
	CCFRepeatForever.super.startWithTarget(self, arg_73_1)
	self._innerAction:startWithTarget(arg_73_1)
end

function CCFRepeatForever:step(arg_74_1)
	self._innerAction:step(arg_74_1)

	if self._innerAction:isDone() then
		local var_74_0 = self._innerAction:getElapsed() - self._innerAction:getTotalFrame()

		if var_74_0 > self._innerAction:getTotalFrame() then
			var_74_0 = math.fmod(var_74_0, self._innerAction:getTotalFrame())
		end

		self._innerAction:startWithTarget(self._target)
		self._innerAction:step(0)
		self._innerAction:step(var_74_0)
	end
end

function CCFRepeatForever:isDone()
	return false
end

local CCFActionInstance = class("CCFActionInstance", CCFAction)

function CCFActionInstance:ctor()
	CCFActionInstance.super.ctor(self)

	self._curFrame = 0
	self._totalFrame = 1
end

function CCFActionInstance:step(arg_77_1)
	self._curFrame = self._curFrame + arg_77_1

	if self:isDone() then
		self._isRunning = false

		return
	end

	self._isRunning = true

	self:_update(self._curFrame / self._totalFrame)
end

function CCFActionInstance:getTotalFrame()
	return self._totalFrame
end

function CCFActionInstance:isDone()
	return self._curFrame > self._totalFrame
end

local CCFRemoveSelf = class("CCFRemoveSelf", CCFActionInstance)

function CCFRemoveSelf:_update(arg_80_1)
	self._target:removeFromParent()
end

local CCFHide = class("CCFHide", CCFActionInstance)

function CCFHide:_update(arg_81_1)
	self._target:setVisible(false)
end

local CCFShow = class("CCFShow", CCFActionInstance)

function CCFShow:_update(arg_82_1)
	self._target:setVisible(true)
end

local CCFCallFunc = class("CCFCallFunc", CCFActionInstance)

function CCFCallFunc:ctor(arg_83_1, arg_83_2)
	CCFCallFunc.super.ctor(self)
	assert(arg_83_1, "Function could not be nil !")

	self._func = arg_83_1
	self._funcTarget = arg_83_2
end

function CCFCallFunc:_update(arg_84_1)
	self._func(self._funcTarget)
end

local CCFCallFuncN = class("CCFCallFuncN", CCFActionInstance)

function CCFCallFuncN:ctor(arg_85_1, arg_85_2)
	CCFCallFuncN.super.ctor(self)
	assert(arg_85_1, "Function could not be nil !")

	self._func = arg_85_1
	self._funcTarget = arg_85_2
end

function CCFCallFuncN:_update(arg_86_1)
	self._func(self._funcTarget, self._target)
end

local CCFJumpBy = class("CCFJumpBy", CCFActionInterval)

function CCFJumpBy:ctor(arg_87_1, arg_87_2, arg_87_3, arg_87_4)
	CCFJumpBy.super.ctor(self, arg_87_1)

	self._delta = arg_87_2
	self._height = arg_87_3
	self._jumps = arg_87_4
end

function CCFJumpBy:startWithTarget(arg_88_1)
	CCFJumpBy.super.startWithTarget(self, arg_88_1)

	self._startPosition = cc.p(arg_88_1:getPosition())
	self._previousPos = self._startPosition
end

function CCFJumpBy:_update(arg_89_1)
	CCFJumpBy.super._update(self, arg_89_1)

	local var_89_0 = math.fmod(arg_89_1 * self._jumps, 1)

	self._startPosition = cc.pAdd(cc.pSub(cc.p(self._target:getPosition()), self._previousPos), self._startPosition)

	local var_89_1 = cc.pAdd(self._startPosition, cc.p(self._delta.x * arg_89_1, self._height * 4 * var_89_0 * (1 - var_89_0) + self._delta.y * arg_89_1))

	self._target:setPosition(var_89_1)

	self._previousPos = var_89_1
end

local CCFJumpTo = class("CCFJumpTo", CCFJumpBy)

function CCFJumpTo:startWithTarget(arg_90_1)
	CCFJumpTo.super.startWithTarget(self, arg_90_1)

	self._delta = cc.pSub(self._delta, cc.p(arg_90_1:getPosition()))
end

local function var_0_33(arg_91_0, arg_91_1, arg_91_2, arg_91_3, arg_91_4)
	return var_0_3(1 - arg_91_4, 3) * arg_91_0 + 3 * arg_91_4 * var_0_3(1 - arg_91_4, 2) * arg_91_1 + 3 * var_0_3(arg_91_4, 2) * (1 - arg_91_4) * arg_91_2 + var_0_3(arg_91_4, 3) * arg_91_3
end

local CCFBezierBy = class("CCFBezierBy", CCFActionInterval)

function CCFBezierBy:ctor(arg_92_1, arg_92_2)
	CCFBezierBy.super.ctor(self, arg_92_1)

	self._destination = arg_92_2
end

function CCFBezierBy:startWithTarget(arg_93_1)
	CCFBezierBy.super.startWithTarget(self, arg_93_1)

	self._original = cc.p(arg_93_1:getPosition())
end

function CCFBezierBy:_update(arg_94_1)
	CCFBezierBy.super._update(self, arg_94_1)
	self._target:setPosition(cc.pAdd(self._original, cc.p(var_0_33(0, self._destination[1].x, self._destination[2].x, self._destination[3].x, arg_94_1), (var_0_33(0, self._destination[1].y, self._destination[2].y, self._destination[3].y, arg_94_1)))))
end

local CCFBezierTo = class("CCFBezierTo", CCFBezierBy)

function CCFBezierTo:startWithTarget(arg_95_1)
	CCFBezierTo.super.startWithTarget(self, arg_95_1)

	self._destination[1] = cc.pSub(self._destination[1], self._original)
	self._destination[2] = cc.pSub(self._destination[2], self._original)
	self._destination[3] = cc.pSub(self._destination[3], self._original)
end

local CCFProgressTo = class("CCFProgressTo", CCFActionInterval)

function CCFProgressTo:ctor(arg_96_1, arg_96_2)
	CCFProgressTo.super.ctor(self, arg_96_1)

	self._destination = arg_96_2
end

function CCFProgressTo:startWithTarget(arg_97_1)
	CCFProgressTo.super.startWithTarget(self, arg_97_1)

	self._original = arg_97_1:getPercentage()
end

function CCFProgressTo:_update(arg_98_1)
	CCFProgressTo.super._update(self, arg_98_1)
	self._target:setPercentage(self._original + (self._destination - self._original) * arg_98_1)
end

local CCFFrequency = class("CCFFrequency", CCFActionInterval)

function CCFFrequency:ctor(arg_99_1, arg_99_2, arg_99_3)
	CCFFrequency.super.ctor(self, arg_99_1)
	assert(arg_99_3, "Function could not be nil !")

	self._func = arg_99_3
	self._funcTarget = arg_99_2
end

function CCFFrequency:_update(arg_100_1)
	CCFFrequency.super._update(self, arg_100_1)
	self._func(self._funcTarget, arg_100_1, self._totalFrame)
end

return {
	CCFActionInterval = CCFActionInterval,
	newDelay = function()
		return CCFActionInterval.new(...)
	end,
	newMoveTo = function()
		return CCFMoveTo.new(...)
	end,
	newMoveBy = function()
		return CCFMoveBy.new(...)
	end,
	newRotateTo = function()
		return CCFRotateTo.new(...)
	end,
	newRotateBy = function()
		return CCFRotateBy.new(...)
	end,
	newScaleTo = function()
		return CCFScaleTo.new(...)
	end,
	newScaleBy = function()
		return CCFScaleBy.new(...)
	end,
	newScale = function()
		return CCFScale.new(...)
	end,
	newSkewTo = function()
		return CCFSkewTo.new(...)
	end,
	newFadeTo = function()
		return CCFFadeTo.new(...)
	end,
	newDelayTime = function()
		return CCFDelayTime.new(...)
	end,
	newSequence = function()
		return CCFSequence.new(...)
	end,
	newSpawn = function()
		return CCFSpawn.new(...)
	end,
	newColorOffset = function()
		return CCFColorOffsetTo.new(...)
	end,
	newColor = function()
		return CCFColorTo.new(...)
	end,
	newShake = function()
		return CCFShake.new(...)
	end,
	newShake1 = function()
		return CCFShake1.new(...)
	end,
	newFocusOn = function()
		return CCFFocusOn.new(...)
	end,
	newRemoveSelf = function()
		return CCFRemoveSelf.new(...)
	end,
	newHide = function()
		return CCFHide.new(...)
	end,
	newShow = function()
		return CCFShow.new(...)
	end,
	newCallFuncN = function()
		return CCFCallFuncN.new(...)
	end,
	newCallFunc = function()
		return CCFCallFunc.new(...)
	end,
	newRepeatForever = function()
		return CCFRepeatForever.new(...)
	end,
	newJumpBy = function()
		return CCFJumpBy.new(...)
	end,
	newJumpTo = function()
		return CCFJumpTo.new(...)
	end,
	newBezierBy = function()
		return CCFBezierBy.new(...)
	end,
	newBezierTo = function()
		return CCFBezierTo.new(...)
	end,
	newProgressTo = function()
		return CCFProgressTo.new(...)
	end,
	newFrequency = function()
		return CCFFrequency.new(...)
	end
}
