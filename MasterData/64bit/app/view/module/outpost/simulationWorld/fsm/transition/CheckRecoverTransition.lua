local CheckRecoverTransition = class("CheckRecoverTransition", require("app.core.fsm.KSComTransition"))

function CheckRecoverTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._map = self._entity.world:getVirtualMap()
	self._isNeed = arg_1_1.isNeed
	self._checkBossState = arg_1_1.checkBossState
end

function CheckRecoverTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._isNeed then
		if self._entity.inBuilding then
			return true
		end

		if self._checkBossState and self._map:hasBoss() and self._entity:needRecoverInBoss() then
			return true
		end

		return self._entity:needRecover()
	else
		if self._checkBossState and self._map:hasBoss() then
			if self._entity:needRecoverInBoss() then
				return false
			end
		elseif self._entity:needRecover() then
			return false
		end

		return self._entity.inBuilding == nil
	end
end

return CheckRecoverTransition
