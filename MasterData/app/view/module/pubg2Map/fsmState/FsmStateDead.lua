local var_0_0 = g.core.const.ConstMgr.PubgConst.fsm
local FsmStateDead = class("FsmStateDead", require("app.view.module.pubg2Map.fsm.FsmState"))

function FsmStateDead:ctor()
	FsmStateDead.super.ctor(self)

	self._stateId = var_0_0.State.dead
end

function FsmStateDead:doBeforeEnter()
	self.owner:inDeath()
end

function FsmStateDead:doReason(arg_3_1, arg_3_2)
	if not self.owner.isDead then
		self.fsm:performTran(var_0_0.Tran.idle)

		return
	end
end

return FsmStateDead
