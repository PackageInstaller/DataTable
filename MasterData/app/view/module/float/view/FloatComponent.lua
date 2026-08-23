local FloatComponent = class("FloatComponent")

function FloatComponent:bindComp(arg_1_1)
	self.onIdle = FloatComponent.onIdle
	self.onFocus = FloatComponent.onFocus
	self.onClick = FloatComponent.onClick
	self.onReset = FloatComponent.onReset
	self._clickFunc = arg_1_1.click
	self._idleFunc = arg_1_1.idle
	self._focusFunc = arg_1_1.focus
	self._resetFunc = arg_1_1.reset
	self._initPos = self:getPosition()
end

function FloatComponent:onIdle(arg_2_1, arg_2_2)
	local var_2_0 = self:getPosition()
	local var_2_1 = self:getSize()

	if arg_2_1 == "left" then
		var_2_0.x = 20
		var_2_0.y = math.max(var_2_0.y, var_2_1.height / 2 + 100)
		var_2_0.y = math.min(var_2_0.y, arg_2_2.height - var_2_1.height - 50)
	elseif arg_2_1 == "right" then
		var_2_0.x = arg_2_2.width - var_2_1.width - 20
		var_2_0.y = math.max(var_2_0.y, var_2_1.height / 2 + 100)
		var_2_0.y = math.min(var_2_0.y, arg_2_2.height - var_2_1.height - 50)
	elseif arg_2_1 == "top" then
		var_2_0.y = 20
	end

	self:setPosition(var_2_0)

	self._hideSchedule = g.core.common.Scheduler:newScheduleOnce(function()
		if arg_2_1 == "left" then
			var_2_0.x = -var_2_1.width / 2
		elseif arg_2_1 == "right" then
			var_2_0.x = arg_2_2.width - var_2_1.width / 2
		elseif arg_2_1 == "top" then
			var_2_0.y = -var_2_1.height / 2
		end

		self:setPosition(var_2_0)
	end, 5)

	if self._idleFunc then
		self._idleFunc(arg_2_1)
	end
end

function FloatComponent:onFocus()
	if self._hideSchedule then
		g.core.common.Scheduler:cancelSchedule(self._hideSchedule)

		self._hideSchedule = nil
	end

	self:setOpacity(255)

	if self._focusFunc then
		self._focusFunc()
	end
end

function FloatComponent:onClick()
	self._clickFunc()
end

function FloatComponent:onReset()
	self:setPosition(self._initPos)
	self:setVisible(false)

	if self._resetFunc then
		self._resetFunc()
	end
end

return FloatComponent
