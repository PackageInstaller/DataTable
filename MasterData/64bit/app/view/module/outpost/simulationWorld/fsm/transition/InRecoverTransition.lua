local var_0_0 = g.core.const.ConstMgr.outpostConst
local InRecoverTransition = class("InRecoverTransition", require("app.core.fsm.KSComTransition"))

function InRecoverTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isIn = arg_1_1.isIn == true
end

function InRecoverTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._entity.inBuilding then
		local var_2_0 = self._entity.inBuilding:getBuildType()

		return (var_2_0 == var_0_0.BuildType.Hospital or var_2_0 == var_0_0.BuildType.Restaurant or var_2_0 == var_0_0.BuildType.Hotel or var_2_0 == var_0_0.BuildType.Tavern) == self._isIn
	else
		return self._isIn == false
	end
end

return InRecoverTransition
