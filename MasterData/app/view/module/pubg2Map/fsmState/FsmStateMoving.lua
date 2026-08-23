local var_0_0 = g.core.const.ConstMgr.PubgConst.fsm
local FsmStateMoving = class("FsmStateMoving", require("app.view.module.pubg2Map.fsm.FsmState"))

function FsmStateMoving:ctor()
	FsmStateMoving.super.ctor(self)

	self._stateId = var_0_0.State.moving
	self._startPos = nil
	self._startTime = 0
	self._curPos = nil
	self._distance2 = 0
	self._endTime = 0
end

function FsmStateMoving:doBeforeEnter()
	self._delayTime = 60

	self.owner:inMoving()
end

function FsmStateMoving:doReason(arg_3_1, arg_3_2)
	if self.owner.isDead then
		self.fsm:performTran(var_0_0.Tran.death)

		return
	end

	if self.owner:isMe() and self.owner:isMoving() then
		return
	end

	if self._endTime == 0 then
		if self._distance2 < var_0_0.test.moveDistance then
			self._endTime = var_0_0.Time.curT + self._delayTime
		end
	elseif self._distance2 >= var_0_0.test.moveDistance then
		self._endTime = 0
	elseif var_0_0.Time.curT >= self._endTime then
		self.fsm:performTran(var_0_0.Tran.idle)
	end
end

function FsmStateMoving:doAct(arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = self.owner:getMoveData()
	local var_4_2 = self.owner:getPosition()

	self._curPos = var_4_2
	self._distance2 = cc.pDistanceSQ(var_4_1, var_4_2)

	if self._distance2 > display.width * display.height then
		self.owner:setCompPos(cc.p(var_4_1.x, var_4_1.y))

		return
	elseif self._distance2 <= 0 then
		return
	end

	local var_4_3 = math.sqrt(self._distance2)
	local var_4_4 = var_0_0.Time.deltaT * var_0_0.test.moveSpeed * 0.001
	local var_4_5 = cc.pSub(var_4_1, var_4_2)

	if var_4_3 <= var_0_0.Time.deltaT * var_0_0.test.moveSpeed * 0.001 then
		var_4_4 = var_4_3
	else
		self.owner:setDirection(var_4_5)
	end

	self.owner:setCompPos((cc.p(var_4_2.x + var_4_5.x * var_4_4 / var_4_3, var_4_2.y + var_4_5.y * var_4_4 / var_4_3)))
end

return FsmStateMoving
