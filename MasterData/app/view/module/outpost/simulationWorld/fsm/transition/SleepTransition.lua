local SleepTransition = class("SleepTransition", require("app.core.fsm.KSComTransition"))

function SleepTransition:initTransition(arg_1_1)
	self._entity = arg_1_1.entity
	self._isSleep = arg_1_1.isSleep
end

function SleepTransition:_doCheckTransition(arg_2_1, arg_2_2)
	if self._isSleep then
		return self._entity:isInSleep()
	else
		return not self._entity:isInSleep()
	end
end

return SleepTransition
