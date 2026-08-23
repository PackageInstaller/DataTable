local ReadyingAtkTransition = class("ReadyingAtkTransition", require("app.core.fsm.KSComTransition"))

function ReadyingAtkTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._checkHasTarget = arg_1_1.checkHasTarget

	local var_1_0 = self._entity:getAttr():getAttackMinRange()

	self._minDistance2 = var_1_0 * var_1_0
end

function ReadyingAtkTransition:_doCheckTransition(arg_2_1, arg_2_2)
	local var_2_0 = self._entity:getAttr():getAttackMaxRange()
	local var_2_1 = self._entity.fightTarget

	if self._entity.fightTarget and (self._entity:isBoss() and not var_2_1:needRecover() or var_2_1:canVictim()) and var_2_1:isSameMapType(self._entity) then
		local var_2_2 = self._entity:getDis2(var_2_1)

		if var_2_2 > self._minDistance2 and var_2_2 < var_2_0 * var_2_0 then
			return self._checkHasTarget
		else
			return not self._checkHasTarget
		end
	else
		return not self._checkHasTarget
	end
end

return ReadyingAtkTransition
