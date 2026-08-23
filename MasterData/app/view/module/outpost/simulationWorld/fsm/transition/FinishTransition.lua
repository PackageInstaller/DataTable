local var_0_0 = g.core.const.ConstMgr.outpostConst
local FinishTransition = class("FinishTransition", require("app.core.fsm.KSComTransition"))

function FinishTransition:initTransition(arg_1_1)
	self._transitionUID = var_0_0.FsmTran.Finish
end

function FinishTransition:_doCheckTransition(arg_2_1, arg_2_2)
	return arg_2_2:isFinish()
end

return FinishTransition
