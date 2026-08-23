local OutpostPassiveTiming = require("app.view.module.outpost.simulationWorld.fight.OutpostPassiveTiming")
local OutpostEntityFactory = require("app.view.module.outpost.simulationWorld.OutpostEntityFactory")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local var_0_4 = g.core.const.ConstMgr.outpostConst
local RoleActiveSkillState = class("RoleActiveSkillState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleActiveSkillState:onCreate()
	self._stUUID = var_0_4.FsmState.ActiveSkill
end

function RoleActiveSkillState:onInitState()
	self._attacker = self._ownerFSM._ownerObj
	self._world = self._attacker.world
	self._victim = nil
end

function RoleActiveSkillState:doBeforeEntering()
	self._victim = self._attacker.fightTarget

	if not self._victim or self._victim:isDead() then
		self:setFinish(true)

		return
	end

	self:setFinish(false)

	self._skillInfo = self._attacker.activeSkill

	self._attacker:useActiveSkillCd()

	self._fightResult = self._world.fightSystem:createFightResult(self._attacker, self._skillInfo, self._victim)

	if self._fightResult.playInfo.trajectory_type == var_0_4.TrajectoryType.None then
		self._hasBullet = false
	elseif self._fightResult.playInfo.trajectory_type == var_0_4.TrajectoryType.Bullet then
		self._hasBullet = true
	end

	self._applyEffCd = var_0_4.WorldParam.AttackChangeMinCd

	self._attacker:executePassive(OutpostPassiveTiming.TimingType.StartAttack, {
		victim = self._victim
	})
	var_0_3:dispatchWorldEvent(OutpostEvent.RoleAtk, {
		attacker = self._attacker,
		victim = self._victim,
		fightResult = self._fightResult
	})
end

function RoleActiveSkillState:onTickUpdate(arg_4_1)
	self._applyEffCd = self._applyEffCd - arg_4_1

	if self._applyEffCd <= 0 then
		self._applyEffCd = 999

		if not self._hasBullet then
			self._fightResult:applySkill()
			var_0_3:dispatchWorldEvent(OutpostEvent.RoleUpdateFightEffect, self._fightResult)
		else
			var_0_3:dispatchWorldEvent(OutpostEvent.EntityAdd, (OutpostEntityFactory.createBullet(self._world, self._fightResult)))
		end

		self:setFinish(true)
	end
end

function RoleActiveSkillState:doBeforeLeaving()
	if not self._hasBullet then
		self._fightResult:dispose()
	end

	self._fightResult = nil
	self._victim = nil
end

return RoleActiveSkillState
