local DispatchTransition = class("DispatchTransition", require("app.core.fsm.KSComTransition"))

function DispatchTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._needDispatch = arg_1_1.needDispatch
end

function DispatchTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._needDispatch then
		return self._entity:getMapType() > 1
	else
		return self._entity:getMapType() <= 1
	end
end

return DispatchTransition
