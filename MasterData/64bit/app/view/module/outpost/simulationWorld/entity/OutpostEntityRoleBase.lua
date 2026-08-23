local OutpostPassiveTiming = require("app.view.module.outpost.simulationWorld.fight.OutpostPassiveTiming")
local var_0_1 = g.core.config.outpost_passive_info
local OutpostPassiveTrigger = require("app.view.module.outpost.simulationWorld.fight.OutpostPassiveTrigger")
local OutpostFightBuffRule = require("app.view.module.outpost.simulationWorld.fight.OutpostFightBuffRule")
local var_0_4 = table.insert
local var_0_5 = table.remove
local OutpostAttrEntry = require("app.view.module.outpost.simulationWorld.fight.OutpostAttrEntry")
local OutpostEntityRoleBase = class("OutpostEntityRoleBase", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBase"))

function OutpostEntityRoleBase:ctor()
	OutpostEntityRoleBase.super.ctor(self)

	self._attr = OutpostAttrEntry.new()
	self._buffTypeDict = {}
	self._buffEffectTypeDict = {}
	self._passiveDict = {}
	self.normalSkill = nil
	self.activeSkill = nil
	self.normalSkillCd = 0
	self.activeSkillCd = 0
	self.movePos = nil
	self.moveTarget = nil
	self.fightTarget = nil
	self.cmdFinish = true
	self.cmdBuild = nil
	self.cmdEquipPos = nil
	self._uid = 0
	self._eyeRange = 0
	self._rootFsm = nil
end

function OutpostEntityRoleBase:useNormalSkillCd()
	return
end

function OutpostEntityRoleBase:useActiveSkillCd()
	self.activeSkillCd = (self.activeSkill.skill_CD - self:doBuff(OutpostFightBuffRule.BuffType.Buff2, {
		subMs = 0
	}).subMs) * 0.001

	self:onUseActiveSkill()
end

function OutpostEntityRoleBase:onUseActiveSkill()
	return
end

function OutpostEntityRoleBase:setFightTarget(arg_5_1)
	if self:isDead() then
		self.fightTarget = nil

		return
	end

	if self.fightTarget and self.fightTarget:canVictim() then
		return
	end

	if arg_5_1 and not self:isEnemy(arg_5_1) then
		return
	end

	self.fightTarget = arg_5_1
end

function OutpostEntityRoleBase:canVictim()
	return not self:isDead()
end

function OutpostEntityRoleBase:isSameMapType(arg_7_1)
	return self:getMapType() == arg_7_1:getMapType() or self:isBoss() or arg_7_1:isBoss()
end

function OutpostEntityRoleBase:getAttr()
	return self._attr
end

function OutpostEntityRoleBase:hurt(arg_9_1, arg_9_2)
	if self:isDead() then
		return
	end

	self._attr:hurt(arg_9_1)

	if self:isDead() then
		self:setFightTarget(nil)
	end

	self:onHurt(arg_9_1, arg_9_2)
end

function OutpostEntityRoleBase:onHurt(arg_10_1, arg_10_2)
	return
end

function OutpostEntityRoleBase:recover(arg_11_1, arg_11_2)
	self._attr:recover(arg_11_1)
	self:onRecover(arg_11_1, arg_11_2)
end

function OutpostEntityRoleBase:onRecover(arg_12_1, arg_12_2)
	return
end

function OutpostEntityRoleBase:addBuff(arg_13_1)
	local var_13_0 = arg_13_1.buffType

	if not self._buffTypeDict[arg_13_1.buffType] then
		self._buffTypeDict[var_13_0] = {}
	end

	if not self._buffEffectTypeDict[arg_13_1.buffEffectType] then
		self._buffEffectTypeDict[arg_13_1.buffEffectType] = arg_13_1

		var_0_4(self._buffTypeDict[var_13_0], arg_13_1.buffEffectType)
		arg_13_1:setAttackRole()
	else
		self._buffEffectTypeDict[arg_13_1.buffEffectType]:addSameBuff(arg_13_1)
	end

	if var_13_0 == OutpostFightBuffRule.BuffType.Buff1 then
		self:doAttrBuff()
	end
end

function OutpostEntityRoleBase:removeBuff(arg_14_1)
	if self._buffEffectTypeDict[arg_14_1.buffEffectType] then
		self._buffEffectTypeDict[arg_14_1.buffEffectType] = nil

		for iter_14_0, iter_14_1 in ipairs(self._buffTypeDict[arg_14_1.buffType]) do
			if iter_14_1 == arg_14_1.buffEffectType then
				var_0_5(self._buffTypeDict[arg_14_1.buffType], iter_14_0)

				break
			end
		end
	end

	if arg_14_1.buffType == OutpostFightBuffRule.BuffType.Buff1 then
		self:doAttrBuff()
	end
end

function OutpostEntityRoleBase:doAttrBuff()
	self._attr:resetAllCurAttr()
	self:doBuff(OutpostFightBuffRule.BuffType.Buff1)
	self._attr:applyAttr()
end

function OutpostEntityRoleBase:doBuff(arg_16_1, arg_16_2, arg_16_3)
	for iter_16_0, iter_16_1 in ipairs(self._buffTypeDict[arg_16_1] or {}) do
		local var_16_1, var_16_2 = self._buffEffectTypeDict[iter_16_1]:executeBuff(arg_16_2, arg_16_3)
	end

	return arg_16_2
end

function OutpostEntityRoleBase:isDead()
	if self:isClear() then
		return true
	end

	return self._attr:getHp() <= 0
end

function OutpostEntityRoleBase:setMovePos(arg_18_1)
	self.movePos = arg_18_1
	self.moveTarget = nil
end

function OutpostEntityRoleBase:setMoveTarget(arg_19_1)
	self.movePos = nil
	self.moveTarget = arg_19_1
end

function OutpostEntityRoleBase:getProfession()
	return
end

function OutpostEntityRoleBase:getElemental()
	return
end

function OutpostEntityRoleBase:getMapType()
	return
end

function OutpostEntityRoleBase:getAdvanceId()
	return
end

function OutpostEntityRoleBase:isInSleep()
	return false
end

function OutpostEntityRoleBase:getUid()
	return self._uid
end

function OutpostEntityRoleBase:getMoveSpeed()
	return self._attr:getMoveSpeed()
end

function OutpostEntityRoleBase:clearCmdState()
	self.cmdFinish = true
	self.cmdBuild = nil
end

function OutpostEntityRoleBase:clearIdleCmdState()
	if not self.cmdBuild then
		self.cmdFinish = true
	end
end

function OutpostEntityRoleBase:setEntityCmdStart(arg_29_1, arg_29_2)
	self.cmdFinish = false
	self.cmdBuild = arg_29_1
	self.cmdEquipPos = arg_29_2
end

function OutpostEntityRoleBase:addPassive(arg_30_1)
	local var_30_0 = self.world.fightSystem.pool:getObj(OutpostPassiveTrigger, {
		passiveInfo = var_0_1.get(arg_30_1),
		fightSystem = self.world.fightSystem,
		victim = self
	})

	self._passiveDict[var_30_0.timingType] = self._passiveDict[var_30_0.timingType] or {}

	var_0_4(self._passiveDict[var_30_0.timingType], var_30_0)

	if var_30_0.timingType == OutpostPassiveTiming.TimingType.Default then
		var_30_0:execute()
	end
end

function OutpostEntityRoleBase:executePassive(arg_31_1, arg_31_2)
	for iter_31_0, iter_31_1 in ipairs(self._passiveDict[arg_31_1] or {}) do
		iter_31_1:execute(arg_31_2)
	end
end

function OutpostEntityRoleBase:setEyeRange(arg_32_1)
	self._eyeRange = arg_32_1
end

function OutpostEntityRoleBase:getEyeRange()
	return self._eyeRange
end

function OutpostEntityRoleBase:onDestroy()
	OutpostEntityRoleBase.super.onDestroy(self)

	for iter_34_0, iter_34_1 in pairs(self._buffEffectTypeDict) do
		iter_34_1.victim = nil

		iter_34_1:dispose()
	end

	self._buffEffectTypeDict = {}
	self._buffTypeDict = {}
	self.movePos = nil
	self.moveTarget = nil
	self.fightTarget = nil
	self.cmdFinish = true
	self.cmdBuild = nil
	self.cmdEquipPos = nil
end

function OutpostEntityRoleBase:needRecover()
	return false
end

function OutpostEntityRoleBase:needRecoverInBoss()
	return false
end

function OutpostEntityRoleBase:getFsm()
	return self._rootFsm
end

function OutpostEntityRoleBase:cleanupFSM()
	return
end

return OutpostEntityRoleBase
