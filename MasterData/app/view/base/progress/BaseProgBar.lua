local BaseProgBar = class("BaseProgBar", require("app.fairyGUI.base_new.UI_BaseProgBar"))

function BaseProgBar:ctor()
	self._curValue = 0
	self._maxValue = 0
end

function BaseProgBar:setPercent(arg_2_1)
	if type(arg_2_1) ~= "table" then
		arg_2_1 = {}
	end

	if arg_2_1.cur then
		self._curValue = arg_2_1.cur

		if arg_2_1.tween then
			self:tweenValue(self._curValue, arg_2_1.dur or 0.4)
		else
			self:setValue(self._curValue)
		end
	end

	if arg_2_1.max then
		self._maxValue = arg_2_1.max

		self:setMax(self._maxValue)
	end
end

function BaseProgBar:getCurPercent()
	return (self:getValue())
end

return BaseProgBar
