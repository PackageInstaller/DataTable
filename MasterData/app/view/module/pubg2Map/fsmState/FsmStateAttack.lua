local var_0_0 = g.core.const.ConstMgr.PubgConst.fsm
local FsmStateAttack = class("FsmStateAttack", require("app.view.module.pubg2Map.fsm.FsmState"))

function FsmStateAttack:ctor(arg_1_1)
	FsmStateAttack.super.ctor(self)

	self._stateId = var_0_0.State.attack
	self._isAttacking = false
end

function FsmStateAttack:doBeforeEnter()
	self.owner:inAttack()
end

function FsmStateAttack:doReason(arg_3_1, arg_3_2)
	if self._isAttacking then
		return
	end

	if self.owner.isDead then
		self.fsm:performTran(var_0_0.Tran.death)

		return
	end
end

function FsmStateAttack:doAct(arg_4_1, arg_4_2)
	return
end

return FsmStateAttack
