local var_0_0 = 100000000

local function var_0_1()
	var_0_0 = var_0_0 + 1

	return var_0_0
end

local KSComTransition = class("KSComTransition")

function KSComTransition:ctor(arg_2_1)
	self:initTransition(arg_2_1)

	if not self._transitionUID then
		if arg_2_1 then
			self._transitionUID = arg_2_1.tid or var_0_1()
		end
	end
end

function KSComTransition:checkTransitionOK(arg_3_1, arg_3_2)
	return self:_doCheckTransition(arg_3_1, arg_3_2)
end

function KSComTransition:getUniqueID()
	return self._transitionUID
end

function KSComTransition:initTransition(arg_5_1)
	return
end

function KSComTransition:_doCheckTransition(arg_6_1, arg_6_2)
	return false
end

return KSComTransition
