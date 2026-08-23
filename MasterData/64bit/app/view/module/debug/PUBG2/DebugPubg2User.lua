local BattleConst = require("app.view.battle.const.BattleConst")
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_2 = g.core.const.ConstMgr.PubgConst.fsm
local FsmSystem = require("app.view.module.pubg2Map.fsm.FsmSystem")
local DebugPubg2User = class("DebugPubg2User", require("app.fairyGUI.debug.UI_DebugPubg2User"))

function DebugPubg2User:ctor()
	self._id = 0
	self._fsm = nil
	self._serverPos = cc.p(0, 0)
	self._moveTime = 0
	self.isDead = false
	self._knight = nil
	self._resID = 210005

	self:initKnight()
end

function DebugPubg2User:setId(arg_2_1)
	self._id = arg_2_1
end

function DebugPubg2User:initKnight()
	if not self._knight then
		self._knight = BattleKnight.new({
			isLoop = true,
			resId = self._resID,
			path = g.core.common.Path:getMapKnightPath() .. self._resID .. "/" .. self._resID,
			anim = BattleConst.SPINE_ACTION_TYPE.IDLE
		})

		self.m_knightSpine:addNode(self._knight)
	end
end

function DebugPubg2User:inIdle()
	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IDLE, true)
end

function DebugPubg2User:inMoving()
	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.RUN, true)
end

function DebugPubg2User:inDeath()
	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.DEAD, false)
end

function DebugPubg2User:inAttack()
	self._knight:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.ATTACK, false)
end

function DebugPubg2User:setDirection(arg_8_1)
	if arg_8_1.x > 0 then
		self._knight:setScaleX(1)
	elseif arg_8_1.x < 0 then
		self._knight:setScaleX(-1)
	end
end

function DebugPubg2User:initFsm()
	self._fsm = FsmSystem.new(self)

	local var_9_0 = require("app.view.module.debug.PUBG2.fsm.FsmStateIdle").new()

	self._fsm:addState(var_9_0)
	var_9_0:addTran(var_0_2.Tran.moving, var_0_2.Tran.moving)
	var_9_0:addTran(var_0_2.Tran.attack, var_0_2.Tran.attack)
	var_9_0:addTran(var_0_2.Tran.death, var_0_2.Tran.death)

	local var_9_1 = require("app.view.module.debug.PUBG2.fsm.FsmStateMoving").new()

	self._fsm:addState(var_9_1)
	var_9_1:addTran(var_0_2.Tran.idle, var_0_2.Tran.idle)
	var_9_1:addTran(var_0_2.Tran.attack, var_0_2.Tran.attack)
	var_9_1:addTran(var_0_2.Tran.death, var_0_2.Tran.death)

	local var_9_2 = require("app.view.module.debug.PUBG2.fsm.FsmStateAttack").new()

	self._fsm:addState(var_9_2)
	var_9_2:addTran(var_0_2.Tran.idle, var_0_2.Tran.idle)
	var_9_2:addTran(var_0_2.Tran.moving, var_0_2.Tran.moving)
	var_9_2:addTran(var_0_2.Tran.death, var_0_2.Tran.death)

	local var_9_3 = require("app.view.module.debug.PUBG2.fsm.FsmStateDead").new()

	self._fsm:addState(var_9_3)
	var_9_3:addTran(var_0_2.Tran.idle, var_0_2.Tran.idle)
end

function DebugPubg2User:tickUpdate(arg_10_1)
	if self._fsm then
		self._fsm:doUpdate(arg_10_1)
	end
end

function DebugPubg2User:setMovePosTo(arg_11_1)
	if not arg_11_1 then
		return
	end

	self._moveTime = arg_11_1.time
	self._serverPos = cc.p(arg_11_1.x, arg_11_1.y)
end

function DebugPubg2User:getMoveData()
	return self._moveTime, self._serverPos
end

return DebugPubg2User
