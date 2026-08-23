local CheckNumTransition = class("CheckNumTransition", require("app.core.fsm.KSComTransition"))

function CheckNumTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._checkName = arg_1_1.checkName
	self._checkValue = arg_1_1.checkValue
	self._isLower = arg_1_1.isLower
end

function CheckNumTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._isLower then
		return self._entity[self._checkName] <= self._checkValue
	else
		return self._entity[self._checkName] >= self._checkValue
	end
end

return CheckNumTransition
