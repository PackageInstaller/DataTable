local OutpostPassiveTiming = require("app.view.module.outpost.simulationWorld.fight.OutpostPassiveTiming")
local OutpostEntityFactory = require("app.view.module.outpost.simulationWorld.OutpostEntityFactory")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local var_0_4 = g.core.const.ConstMgr.outpostConst
local RoleNormalSkillState = class("RoleNormalSkillState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function RoleNormalSkillState:onCreate()
	self._stUUID = var_0_4.FsmState.NormalSkill
end

function RoleNormalSkillState:onInitState()
	self._attacker = self._ownerFSM._ownerObj
	self._world = self._attacker.world
	self._victim = nil
	self._hasBullet = false
end

function RoleNormalSkillState:doBeforeEntering()
	self._victim = self._attacker.fightTarget

	if not self._victim or self._victim:isDead() then
		self:setFinish(true)

		return
	end

	self:setFinish(false)

	self._skillInfo = self._attacker.normalSkill

	self._attacker:useNormalSkillCd()

	self._fightResult = self._world.fightSystem:createFightResult(self._attacker, self._skillInfo, self._victim)

	local var_3_0 = self._attacker:getProfession()

	if var_3_0 == var_0_4.Profession.Warrior then
		self._hasBullet = false
		self._applyEffCd = self._attacker.normalSkillCd * var_0_4.WorldParam.AtkEffectCdRate
	elseif var_3_0 == var_0_4.Profession.Hunter or var_3_0 == var_0_4.Profession.Mage then
		self._hasBullet = true
		self._applyEffCd = self._attacker.normalSkillCd * var_0_4.WorldParam.AtkBulletCdRate
	end

	if self._applyEffCd > var_0_4.WorldParam.AttackChangeMinCd then
		self._applyEffCd = var_0_4.WorldParam.AttackChangeMinCd
	end

	self._attacker:executePassive(OutpostPassiveTiming.TimingType.StartAttack, {
		victim = self._victim
	})
	var_0_3:dispatchWorldEvent(OutpostEvent.RoleAtk, {
		attacker = self._attacker,
		victim = self._victim,
		fightResult = self._fightResult
	})
end

function RoleNormalSkillState:onTickUpdate(arg_4_1)
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

function RoleNormalSkillState:doBeforeLeaving()
	if not self._hasBullet then
		self._fightResult:dispose()
	end

	self._fightResult = nil
	self._victim = nil
end

return RoleNormalSkillState
