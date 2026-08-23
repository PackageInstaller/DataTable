local var_0_0 = g.core.const.ConstMgr.outpostConst
local InExchangeTransition = class("InExchangeTransition", require("app.core.fsm.KSComTransition"))

function InExchangeTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isIn = arg_1_1.isIn == true
end

function InExchangeTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._entity.inBuilding then
		return self._entity.inBuilding:getBuildType() == var_0_0.BuildType.Exchange == self._isIn
	else
		return self._isIn == false
	end
end

return InExchangeTransition
