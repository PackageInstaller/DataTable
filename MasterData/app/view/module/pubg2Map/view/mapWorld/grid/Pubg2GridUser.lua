local BattleConst = require("app.view.battle.const.BattleConst")
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_2 = g.core.const.ConstMgr.PubgConst.fsm
local FsmSystem = require("app.view.module.pubg2Map.fsm.FsmSystem")
local Pubg2GridUser = class("Pubg2GridUser", require("app.fairyGUI.pubg.UI_Pubg2GridUser"))

function Pubg2GridUser:ctor(arg_1_1)
	self._oid = 0
	self._uid = 0
	self._isMe = false
	self._isMoving = false
	self._fsm = nil
	self._serverPos = cc.p(0, 0)
	self._moveTime = 0
	self.isDead = false
	self._knight = nil
	self._resID = 210005

	self:initFsm()
	self:updateShowKnight()
end

function Pubg2GridUser:isMe()
	return self._isMe
end

function Pubg2GridUser:setServerPos(arg_3_1, arg_3_2)
	self._serverPos = cc.p(arg_3_1, arg_3_2)
end

function Pubg2GridUser:setCompPos(arg_4_1)
	self:setPosition(arg_4_1)
	self.m_pos:setText(self._oid)
end

function Pubg2GridUser:setOId(arg_5_1)
	self._oid = arg_5_1

	self.m_pos:setText(self._oid)
end

function Pubg2GridUser:setUId(arg_6_1)
	self._uid = arg_6_1
	self._isMe = arg_6_1 == g.core.model.User:getId()
end

function Pubg2GridUser:updateShowKnight()
	if self._knight and self._knight:getResId() ~= self._resID then
		self._knight:dispose()

		self._knight = nil
	end

	if not self._knight then
		self._knight = BattleKnight.new({
			isLoop = true,
			resId = self._resID,
			path = g.core.common.Path:getMapKnightPath() .. self._resID .. "/" .. self._resID,
			anim = BattleConst.SPINE_ACTION_TYPE.IDLE
		})

		self.m_showKnight:addNode(self._knight)
	end
end

function Pubg2GridUser:inIdle()
	if not self._knight then
		return
	end

	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IDLE, true)
end

function Pubg2GridUser:inMoving()
	if not self._knight then
		return
	end

	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.RUN, true)
end

function Pubg2GridUser:inDeath()
	if not self._knight then
		return
	end

	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.DEAD, false)
end

function Pubg2GridUser:inAttack()
	if not self._knight then
		return
	end

	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.ATTACK, false)
end

function Pubg2GridUser:setDirection(arg_12_1)
	if not self._knight then
		return
	end

	if arg_12_1.x > 0 then
		self._knight:setScaleX(1)
	elseif arg_12_1.x < 0 then
		self._knight:setScaleX(-1)
	end
end

function Pubg2GridUser:initFsm()
	self._fsm = FsmSystem.new(self)

	local var_13_0 = require("app.view.module.pubg2Map.fsmState.FsmStateIdle").new()

	self._fsm:addState(var_13_0)
	var_13_0:addTran(var_0_2.Tran.moving, var_0_2.Tran.moving)
	var_13_0:addTran(var_0_2.Tran.attack, var_0_2.Tran.attack)
	var_13_0:addTran(var_0_2.Tran.death, var_0_2.Tran.death)

	local var_13_1 = require("app.view.module.pubg2Map.fsmState.FsmStateMoving").new()

	self._fsm:addState(var_13_1)
	var_13_1:addTran(var_0_2.Tran.idle, var_0_2.Tran.idle)
	var_13_1:addTran(var_0_2.Tran.attack, var_0_2.Tran.attack)
	var_13_1:addTran(var_0_2.Tran.death, var_0_2.Tran.death)

	local var_13_2 = require("app.view.module.pubg2Map.fsmState.FsmStateAttack").new()

	self._fsm:addState(var_13_2)
	var_13_2:addTran(var_0_2.Tran.idle, var_0_2.Tran.idle)
	var_13_2:addTran(var_0_2.Tran.moving, var_0_2.Tran.moving)
	var_13_2:addTran(var_0_2.Tran.death, var_0_2.Tran.death)

	local var_13_3 = require("app.view.module.pubg2Map.fsmState.FsmStateDead").new()

	self._fsm:addState(var_13_3)
	var_13_3:addTran(var_0_2.Tran.idle, var_0_2.Tran.idle)
end

function Pubg2GridUser:tickUpdate(arg_14_1)
	self._fsm:doUpdate(arg_14_1)
end

function Pubg2GridUser:setMovePosTo(arg_15_1)
	if not arg_15_1 then
		return
	end

	self._moveTime = arg_15_1.time
	self._serverPos = cc.p(arg_15_1.x, arg_15_1.y)
end

function Pubg2GridUser:getMoveData()
	return self._moveTime, self._serverPos
end

function Pubg2GridUser:setMoving(arg_17_1)
	self._isMoving = arg_17_1
end

function Pubg2GridUser:isMoving()
	return self._isMoving
end

return Pubg2GridUser
