local PressComp = class("PressComp")

function PressComp:bindComp()
	local var_1_0 = clone(PressComp)

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_0 ~= "ctor" and iter_1_0 ~= "onUnload" then
			self[iter_1_0] = iter_1_1
		end
	end

	var_1_0.ctor(self)
end

function PressComp:ctor()
	self._pressHandles = {}
	self._pressMoveHandles = {}
	self._clickHandler = nil
	self._touchDisableHandler = nil
	self._schedule = nil
	self._pressContinueEnable = true
	self._pressTime = 1
	self._pressInterval = 0.5
	self._statue = "None"
	self._touchPos = nil
	self._isIgnoreMove = false
	self._isTouch = false

	self:setTouchable(true)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onPressTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onPressTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onPressTouchEnd))
end

function PressComp:addPressListener(arg_3_1, arg_3_2)
	table.insert(self._pressHandles, arg_3_1)

	if arg_3_2 then
		self:addPressMoveHandle(arg_3_1)
	end
end

function PressComp:setClickListener(arg_4_1)
	self._clickHandler = arg_4_1
end

function PressComp:setTouchDisableListener(arg_5_1)
	self._touchDisableHandler = arg_5_1
end

function PressComp:setPressTime(arg_6_1)
	self._pressTime = arg_6_1
end

function PressComp:setPressContinueTypeEnable(arg_7_1)
	self._pressContinueEnable = arg_7_1
end

function PressComp:setPressInterval(arg_8_1)
	self._pressInterval = arg_8_1
end

function PressComp:addPressMoveHandle(arg_9_1)
	table.insert(self._pressMoveHandles, arg_9_1)
end

function PressComp:setIgnoreMove(arg_10_1)
	self._isIgnoreMove = arg_10_1
end

function PressComp:_resetPress()
	self._statue = "None"
	self._touchPos = nil
	self._touchLocalPos = nil
	self._schedule = nil
	self._isTouch = false
end

function PressComp:_changeStatueAndDoPress(arg_12_1, arg_12_2)
	if self._touchDisableHandler and self._touchDisableHandler() and self._statue == "Press" then
		if self._additionalTouchEnd then
			self:_additionalTouchEnd(self._touchPos, self._touchLocalPos)
		end

		self._isTouch = false

		self:clearSchedule()

		return
	end

	if self._statue ~= "Press" then
		self._statue = "Press"

		self:clearSchedule()

		if self._pressContinueEnable then
			self._schedule = self:newSchedule(handler(self, self._changeStatueAndDoPress), self._pressInterval)
		end
	end

	for iter_12_0, iter_12_1 in ipairs(self._pressHandles) do
		iter_12_1(self._touchPos, self._touchLocalPos, arg_12_2)
	end
end

function PressComp:_onPressTouchBegin(arg_13_1)
	local var_13_0 = arg_13_1:getInput()

	if not var_13_0:getTouch() then
		return
	end

	self._touchPos = var_13_0:getPosition()

	if self._touchDisableHandler and self._touchDisableHandler() then
		return
	end

	self._statue = "Click"
	self._schedule = self:newSchedule(handler(self, self._changeStatueAndDoPress), self._pressTime)
	self._touchLocalPos = var_13_0:getTouch():getLocation()

	if self._additionalTouchBegin then
		self:_additionalTouchBegin(self._touchPos, self._touchLocalPos)
	end

	self._isTouch = true

	arg_13_1:captureTouch()
end

function PressComp:_onPressTouchMove(arg_14_1)
	local var_14_0 = arg_14_1:getInput()

	self._touchPos = var_14_0:getPosition()
	self._touchLocalPos = var_14_0:getTouch():getLocation()

	if self._statue == "Press" then
		self:_onPressMove()
	end

	if self._isIgnoreMove and math.abs(self._touchPos.x - self._touchPos.x) > 5 and math.abs(self._touchPos.y - self._touchPos.y) > 5 then
		self._isTouch = false

		self:clearSchedule()
	end
end

function PressComp:_onPressMove()
	for iter_15_0, iter_15_1 in ipairs(self._pressMoveHandles) do
		iter_15_1(self._touchPos, self._touchLocalPos)
	end
end

function PressComp:_onPressTouchEnd(arg_16_1)
	local var_16_0 = arg_16_1:getInput()

	self:clearSchedule()

	if self._statue == "Click" and self._isTouch and self._clickHandler then
		self._clickHandler(arg_16_1)
	end

	if self._additionalTouchEnd and self._isTouch then
		self:_additionalTouchEnd(var_16_0:getPosition(), (var_16_0:getTouch():getLocation()))
	end

	self:_resetPress()
end

function PressComp:clearSchedule()
	if self._schedule ~= nil then
		self:cancelSchedule(self._schedule)
	end

	self._schedule = nil
end

return PressComp
