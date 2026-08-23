local HpTransition = class("HpTransition", require("app.core.fsm.KSComTransition"))

function HpTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._checkValue = arg_1_1.checkValue
	self._isRate = arg_1_1.isRate
	self._isLower = arg_1_1.isLower
end

function HpTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._isRate then
		local var_2_0 = self._entity:getAttr():getHpRate() * 1000

		if self._isLower then
			return var_2_0 <= self._checkValue
		else
			return var_2_0 >= self._checkValue
		end
	elseif self._isLower then
		return self._entity:getAttr():getHp() <= self._checkValue
	else
		return self._entity:getAttr():getHp() >= self._checkValue
	end
end

return HpTransition
