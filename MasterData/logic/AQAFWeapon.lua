-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFWeapon.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFWeapon", package.seeall)

local AQAFWeapon = class("AQAFWeapon", AQAFUnit)

function AQAFWeapon:ctor()
	AQAFWeapon.super.ctor(self)

	self.bulletBuffIds = {}

	self:resetStarBuffData()
end

function AQAFWeapon:getTag()
	return AQAFGameEnum.UnitTag.Weapon
end

function AQAFWeapon:initData(params)
	self:resetData()

	self.params = params

	local cfg = params.cfg

	self.cfg = cfg
	self.curStarLv = params.curStarLv

	local lvCfg = params.lvCfg

	self._CD = lvCfg.CD
	self._Atk = lvCfg.Atk
	self._Heal = lvCfg.Heal
	self._AddShield = lvCfg.AddShield
	self._CriRate = lvCfg.Cri
	self._CriDamRate = lvCfg.CriDam + 10000
	self._addMaxHP = lvCfg.MaxHP
	self._targetType = cfg.targetType
	self._equipType = cfg.equipmentType
	self._bf_star_CDRate = cfg.CDRate
	self._atkRange = cfg.AtkRange
	self._targetType = cfg.targetType
	self._bulletId = cfg.bulletId
	self._AtkRange = cfg.AtkRange
	self._bf_star_AtkRate = cfg.AtkAddRate
	self._bf_star_CDRate = cfg.CDRate
	self._bf_star_healAddRate = cfg.healAddRate
	self._bf_Star_shieldRate = cfg.addShieldRate
	self._bf_Star_AddMaxHpRate = cfg.MaxHPRate
	self.owner = AoQiAttackForceGameController.instance:getPlayerUnit()
	self._bulletCount = 1
end

function AQAFWeapon:updateBulletCount(num)
	self._bulletCount = self._bulletCount + checknumber(num)
end

function AQAFWeapon:update()
	self._CDTimer = self._CDTimer - AoQiAttackForceGameController.instance:getCurDeltaTime()

	if not self:checkCD() then
		if self._equipType == AQAFGameEnum.WeaponType.Physics or self._equipType == AQAFGameEnum.WeaponType.Magic then
			self:attack()
		elseif self._equipType == AQAFGameEnum.WeaponType.Defense then
			self:defense()
		end
	end
end

function AQAFWeapon:checkCD()
	return self._CDTimer > 0
end

local params = {}

function AQAFWeapon:attack()
	AQAFWeapon.super.attack(self)

	self._CDTimer = self:getCurCD()

	local target = AoQiAttackForceGameController.instance:getMonsterTarget(self._AtkRange, self._targetType)

	if target then
		self.owner:attack()

		local dirX = target.position.x - self.owner.position.x
		local dirY = target.position.y - self.owner.position.y + math.random(-1 * target.radius, 1 * target.radius)
		local addMulti = 0
		local addDist = target.radius + 10

		for i = 1, self._bulletCount do
			if i == 1 then
				addMulti = 0
			elseif i % 2 == 1 then
				addMulti = -Mathf.Ceil(i / 2)
			elseif i % 2 == 0 then
				addMulti = Mathf.Ceil(i / 2)
			end

			params.CriRate = self:getCri()
			params.CriDamRate = self:getCurCriDamRate()
			params.Atk = self:getCurAtk()
			params.bulletId = self._bulletId
			params.position = self.owner.position
			params.owner = self
			params.dirX = dirX
			params.dirY = dirY + addMulti * addDist
			params.bulletBuffIds = self.bulletBuffIds

			AoQiAttackForceGameController.instance:createBullet(params, true)
		end
	end
end

function AQAFWeapon:defense()
	self._CDTimer = self:getCurCD()

	self.owner:heal(self:getCurHeal())
	self.owner:addShield(self:getCurAddShield())
end

function AQAFWeapon:getCDPercentage()
	return 1 - self._CDTimer / self:getCurCD()
end

function AQAFWeapon:critical(unit)
	AQAFWeapon.super.critical(self, unit)
	self.owner:critical(unit)
end

function AQAFWeapon:hit(unit)
	AQAFWeapon.super.hit(self, unit)
	self.owner:hit(unit)
end

function AQAFWeapon:addBulletBuffId(buffId)
	self.bulletBuffIds = self.bulletBuffIds or {}

	table.insert(self.bulletBuffIds, buffId)
end

function AQAFWeapon:resetStarBuffData()
	self._bf_star_AtkRate = 0
	self._bf_star_CDRate = 0
	self._bf_star_healAddRate = 0
	self._bf_Star_shieldRate = 0
	self._bf_Star_MaxHpRate = 0
end

function AQAFWeapon:getCurAtk()
	return self._Atk * (100 + self._bf_AtkRate + self._bf_star_AtkRate) / 100
end

function AQAFWeapon:getCurCD()
	return self._CD * (100 - self._bf_CDRate - self._bf_star_CDRate) / 100
end

function AQAFWeapon:getCurHeal()
	return self._Heal * (self._bf_star_healAddRate + self._bf_HealAddRate + 100) / 100
end

function AQAFWeapon:getCurAddShield()
	return self._AddShield * (self._bf_Star_shieldRate + self._bf_ShieldRate + 100) / 100
end

function AQAFWeapon:getEquipType()
	return self._equipType
end

function AQAFWeapon:getDamageType()
	if self._equipType == AQAFGameEnum.WeaponType.Physics then
		return AQAFGameEnum.AttackDamageType.Physics
	elseif self._equipType == AQAFGameEnum.WeaponType.Magic then
		return AQAFGameEnum.AttackDamageType.Magic
	else
		return AQAFGameEnum.AttackDamageType.Normal
	end
end

function AQAFWeapon:getCurAddHp()
	return self._addMaxHP * (self._bf_Star_MaxHpRate + self._bf_AddMaxHpRate + 100) / 100
end

return AQAFWeapon
