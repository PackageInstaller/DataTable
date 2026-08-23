local var_0_0 = g.core.const.ConstMgr.PubgConst.fsm
local FsmStateIdle = class("FsmStateIdle", require("app.view.module.pubg2Map.fsm.FsmState"))

function FsmStateIdle:ctor()
	FsmStateIdle.super.ctor(self)

	self._stateId = var_0_0.State.idle
end

function FsmStateIdle:doBeforeEnter()
	self.owner:inIdle()
end

function FsmStateIdle:doReason(arg_3_1, arg_3_2)
	if self.owner.isDead then
		self.fsm:performTran(var_0_0.Tran.death)

		return
	end

	if self.owner:isMe() and self.owner:isMoving() then
		self.fsm:performTran(var_0_0.Tran.moving)

		return
	end

	local var_3_0, var_3_1 = self.owner:getMoveData()

	if cc.pDistanceSQ(var_3_1, (self.owner:getPosition())) >= var_0_0.test.moveDistance then
		self.fsm:performTran(var_0_0.Tran.moving)

		return
	end
end

function FsmStateIdle:doAct(arg_4_1, arg_4_2)
	return
end

return FsmStateIdle
