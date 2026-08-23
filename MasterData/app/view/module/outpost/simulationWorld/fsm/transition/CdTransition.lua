local CdTransition = class("CdTransition", require("app.core.fsm.KSComTransition"))

function CdTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._cdName = arg_1_1.cdName
end

function CdTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._entity[self._cdName] then
		return self._entity[self._cdName] <= 0
	else
		return false
	end
end

return CdTransition
