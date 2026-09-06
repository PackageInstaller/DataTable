-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFUnit.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFUnit", package.seeall)

local AQAFUnit = class("AQAFUnit")

function AQAFUnit:ctor()
	self.position = {
		x = 0,
		y = 0
	}
	self.rect = SimpleQuadTree.createRect(0, 0, 0, 0)
	self.id = 0
	self._isActive = true
	self.radius = 0
	self.buffList = {}
	self._statusMap = {}
	self.curRecordDamages = {}

	self:resetData()
end

function AQAFUnit:getTag()
	return
end

function AQAFUnit:initData(param)
	return
end

function AQAFUnit:updatePosition(x, y)
	self.position.x = checknumber(x)
	self.position.y = checknumber(y)
	self.rect.x = self.position.x - self.radius
	self.rect.y = self.position.y - self.radius
end

function AQAFUnit:setRadius(radius)
	self.radius = radius
	self.rect.w = 2 * self.radius
	self.rect.h = 2 * self.radius
end

function AQAFUnit:update()
	AQAFBuffMgr.instance:onUpdate(self)
end

function AQAFUnit:resetTir()
	table.clear(self.curRecordDamages)
end

function AQAFUnit:isActive()
	return self._isActive
end

function AQAFUnit:die()
	local isFirstDie = self:isActive()

	self._isActive = false

	if isFirstDie == true then
		AQAFBuffMgr.instance:onSelfDead(self, self)
	end
end

function AQAFUnit:addBuff(target)
	AQAFBuffMgr.instance:onAdd(self, target)
end

function AQAFUnit:removeBuff(buff)
	buff:onRemove(self)
	AQAFBuffMgr.instance:disposeBuff(buff)
	table.removebyvalue(self.buffList, buff)
end

function AQAFUnit:attack()
	self._attackCount = self._attackCount + 1

	self:onAttack()
end

function AQAFUnit:_clearLastAttack()
	return
end

function AQAFUnit:onLateUpdate()
	self:resetTir()
end

function AQAFUnit:onAttack()
	self:_clearLastAttack()
	AQAFBuffMgr.instance:onAttack(self)
end

function AQAFUnit:hit(unit)
	self._hitUnitCount = self._hitUnitCount + 1

	self:onHit(unit)
end

function AQAFUnit:onHit(unit)
	self:_clearLastHit()
	AQAFBuffMgr.instance:onHit(self, unit)
end

function AQAFUnit:beHit(unit)
	self._beUnitHitCount = self._beUnitHitCount + 1

	self:onBeHit(unit)
end

function AQAFUnit:_clearLastHit()
	return
end

function AQAFUnit:onBeHit(unit)
	self:_clearLastBeHit()
	AQAFBuffMgr.instance:onBeHit(self, unit)
end

function AQAFUnit:_clearLastBeHit()
	return
end

function AQAFUnit:critical(unit)
	self:onCrit(unit)
end

function AQAFUnit:onCrit(unit)
	self:_clearLastCritical()
	AQAFBuffMgr.instance:onCrit(self, unit)
end

function AQAFUnit:_clearLastCritical()
	return
end

function AQAFUnit:getIsCritical()
	return math.random() <= self:getCri() / 10000
end

function AQAFUnit:getCurDamRate()
	return (self._bf_DamRate + 100) / 100
end

function AQAFUnit:getAfterCalCriDam(isCri)
	if isCri then
		return Mathf.Max(self:getCurAtk() * self:getCurCriDamRate() / 10000, 0)
	else
		return Mathf.Max(self:getCurAtk(), 0)
	end
end

function AQAFUnit:getAfterCalDamage(dam)
	return Mathf.Max(dam * self:getCurDamRate(), 0)
end

function AQAFUnit:getDamageType()
	return AQAFGameEnum.AttackDamageType.Normal
end

function AQAFUnit:getCri()
	return self._CriRate + self._bf_Cri
end

function AQAFUnit:getCurCriDamRate()
	return self._CriDamRate + self._bf_CriDam
end

function AQAFUnit:beforeCauseDamage(unit)
	return
end

function AQAFUnit:onBeforeCauseDamage(unit)
	self:_clearLastBeforeCauseDamage()
	AQAFBuffMgr.instance:onBeforeCauseDamage(self, unit)
end

function AQAFUnit:afterCauseDamage(unit, damage)
	AQAFBuffMgr.instance:onAfterCauseDamage(self, unit, damage)
end

function AQAFUnit:onAfterCauseDamage(unit, damage)
	AQAFBuffMgr.instance:onAfterCauseDamage(self, unit, damage)
end

function AQAFUnit:_clearLastBeforeCauseDamage()
	return
end

function AQAFUnit:beDamage(unit, damage, damageType)
	self:onBeforeDammage(unit, damage)
	self:onTakeDammage(damage, damageType)
	self:onAfterDammage(unit, damage)
end

function AQAFUnit:getCurTakeDamRate(damageType)
	if damageType == AQAFGameEnum.AttackDamageType.Physics then
		return Mathf.Max((self._bf_TakDamRate + self._bf_TakPhysicalDamRate + self._TakPhysicalDamRate + 100) / 100, 0)
	elseif damageType == AQAFGameEnum.AttackDamageType.Magic then
		return Mathf.Max((self._bf_TakDamRate + self._bf_TakMagicDamRate + self._TakMagicDamRate + 100) / 100, 0)
	else
		return Mathf.Max((self._bf_TakDamRate + 100) / 100, 0)
	end
end

function AQAFUnit:getTypeTakDamRate(damageType)
	if damageType == AQAFGameEnum.AttackDamageType.Physics then
		return Mathf.Max((self._bf_TakPhysicalDamRate + self._TakPhysicalDamRate + 100) / 100, 0)
	elseif damageType == AQAFGameEnum.AttackDamageType.Magic then
		return Mathf.Max((self._bf_TakMagicDamRate + self._TakMagicDamRate + 100) / 100, 0)
	else
		return 0
	end
end

function AQAFUnit:getAfterCalTakeDamage(damage, damageType)
	return damage * self:getCurTakeDamRate(damageType)
end

function AQAFUnit:onBeforeDammage(unit, damage)
	self:_clearLastBeforeDammage()
	AQAFBuffMgr.instance:onBeforeDammage(self, unit, damage)
end

function AQAFUnit:_clearLastBeforeDammage()
	return
end

function AQAFUnit:onTakeDammage(damage, damageType)
	local finalTakeDam = self:getAfterCalTakeDamage(damage, damageType)

	table.insert(self.curRecordDamages, {
		dam = finalTakeDam,
		type = damageType
	})

	if finalTakeDam > self._CurShield then
		self._curHp = self._curHp + self._CurShield - finalTakeDam
		self._CurShield = 0
	else
		self._CurShield = self._CurShield - finalTakeDam
	end

	if self._curHp <= 0 then
		self:die()
	end
end

function AQAFUnit:onAfterDammage(unit, dammage)
	self:_clearLastAfterDammage()
	AQAFBuffMgr.instance:onAfterDammage(self, unit, dammage)
end

function AQAFUnit:_clearLastAfterDammage()
	return
end

function AQAFUnit:resetData()
	for k, v in pairs(self.buffList) do
		AQAFBuffMgr.instance:disposeBuff(v)

		self.buffList[k] = nil
	end

	self._curHp = 0
	self._maxHp = 0
	self._attackCount = 0
	self._hitUnitCount = 0
	self._beUnitHitCount = 0
	self._CD = 0
	self._CDTimer = 0
	self._Atk = 0
	self._Heal = 0
	self._AddShield = 0
	self._CriRate = 0
	self._CriDamRate = 10000
	self._CurShield = 0
	self._TakMagicDamRate = 0
	self._TakPhysicalDamRate = 0

	table.clear(self._statusMap)
	self:resetBuffData()
	self:resetTemBuffData()
end

function AQAFUnit:resetBuffData()
	self._bf_AtkRate = 0
	self._bf_Cri = 0
	self._bf_CriDam = 0
	self._bf_CDRate = 0
	self._bf_DamRate = 0
	self._bf_TakDamRate = 0
	self._bf_TakMagicDamRate = 0
	self._bf_TakPhysicalDamRate = 0
	self._bf_HealAddRate = 0
	self._bf_ShieldRate = 0
	self._bf_AddMaxHpRate = 0
end

function AQAFUnit:resetTemBuffData()
	self._bf_Tem_TakDamRate = 0
end

function AQAFUnit:changeDamage(rate)
	self._bf_Tem_TakDamRate = self._bf_Tem_TakDamRate + checknumber(rate)
end

function AQAFUnit:updateAttr(attrType, value)
	local addValue = checknumber(value)

	if attrType == "atk" then
		self._bf_AtkRate = self._bf_AtkRate + addValue
	elseif attrType == "cri" then
		self._bf_Cri = self._bf_Cri + addValue
	elseif attrType == "criDam" then
		self._bf_CriDam = self._bf_CriDam + addValue
	elseif attrType == "CD" then
		self._bf_CDRate = self._bf_CDRate + addValue
	elseif attrType == "damRate" then
		self._bf_DamRate = self._bf_DamRate + addValue
	elseif attrType == "heal" then
		self._bf_HealAddRate = self._bf_HealAddRate + addValue
	elseif attrType == "shield" then
		self._bf_ShieldRate = self._bf_ShieldRate + addValue
	elseif attrType == "takeDamRate" then
		self._bf_TakDamRate = self._bf_TakDamRate + addValue
	elseif attrType == "addMaxHp" then
		self._bf_AddMaxHpRate = self._bf_AddMaxHpRate + addValue
	elseif attrType == "takeMagicDamRate" then
		self._bf_TakMagicDamRate = self._bf_TakMagicDamRate + addValue
	elseif attrType == "takePhysicalDamRate" then
		self._bf_TakPhysicalDamRate = self._bf_TakPhysicalDamRate + addValue
	end
end

function AQAFUnit:getCurCD()
	return self._CD * (100 - self._bf_CDRate) / 100
end

function AQAFUnit:getCurAtk()
	return self._Atk * (100 + self._bf_AtkRate) / 100
end

function AQAFUnit:getCurHp()
	return Mathf.Max(self._curHp, 0)
end

function AQAFUnit:getCurMaxHP()
	return self._maxHp * (100 + self._bf_AddMaxHpRate) / 100
end

function AQAFUnit:getCurShield()
	return self._CurShield
end

function AQAFUnit:addShield(addValue)
	self._CurShield = self._CurShield + checknumber(addValue)
	self._CurShield = Mathf.Max(self._CurShield, 0)
end

function AQAFUnit:heal(addValue)
	self._curHp = self._curHp + checknumber(addValue)
	self._curHp = Mathf.Min(self._curHp, self:getCurMaxHP())
end

function AQAFUnit:changeHP(value)
	self._curHp = checknumber(value)

	if self._curHp <= 0 then
		self:die()
	end
end

function AQAFUnit:addNewStatus(statusName)
	self._statusMap[statusName] = checknumber(self._statusMap[statusName]) + 1

	GlobalDispatcher:dispatch(GlobalNotify.AQAFUnitStatusChange, self.id)
end

function AQAFUnit:removeStatus(statusName)
	self._statusMap[statusName] = checknumber(self._statusMap[statusName]) - 1

	if checknumber(self._statusMap[statusName]) <= 0 then
		self._statusMap[statusName] = nil

		GlobalDispatcher:dispatch(GlobalNotify.AQAFUnitStatusChange, self.id)
	end
end

function AQAFUnit:checkHasStatus(statusName)
	return checknumber(self._statusMap[statusName]) > 0
end

function AQAFUnit:isFrozend()
	return self._isFrozend
end

function AQAFUnit:changeFrozend(isFrozend)
	if isFrozend then
		self.isTriFrozen = true
	end

	self._isFrozend = isFrozend
end

return AQAFUnit
