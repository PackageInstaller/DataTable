local var_0_0 = g.core.model.User.outpostData
local VitCheckTransition = class("VitCheckTransition", require("app.core.fsm.KSComTransition"))

function VitCheckTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._map = self._entity.world:getVirtualMap()
	self._hasVit = arg_1_1.hasVit
end

function VitCheckTransition:_doCheckTransition(arg_2_1, arg_2_2)
	local var_2_0 = self._map:hasBoss()

	if self._hasVit then
		return var_0_0:getOwnVit() > 0 or var_2_0
	else
		return var_0_0:getOwnVit() <= 0 and not var_2_0
	end
end

return VitCheckTransition
