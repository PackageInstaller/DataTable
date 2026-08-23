local HasBossTransition = class("HasBossTransition", require("app.core.fsm.KSComTransition"))

function HasBossTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._map = self._entity.world:getVirtualMap()
	self._hasBoss = arg_1_1.hasBoss
end

function HasBossTransition:_doCheckTransition(arg_2_1, arg_2_2)
	local var_2_0 = self._map:hasBoss()

	if self._hasBoss then
		return var_2_0 and not self._entity.inBuilding
	else
		return not var_2_0 or self._entity.inBuilding
	end
end

return HasBossTransition
