-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFMonster.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFMonster", package.seeall)

local AQAFMonster = class("AQAFMonster", AQAFUnit)

function AQAFMonster:ctor()
	AQAFMonster.super.ctor(self)

	self._atkType = AQAFGameEnum.MonsterAttackType.None
	self._curMoveDir = Vector2.New(0, 0)
	self._rangeAttack = 0
	self._curHp = 0
	self._maxHp = 0
	self._CD = 0
	self._CDTimer = 0
	self._isBoss = false
	self._bulletId = 0
	self.moveSpeed = 0
	self.speedChange = 0
	self.speedIntensityTime = 0
	self.modelCfg = nil
	self._CurShield = 0
	self.bulletBuffIds = {}
end

function AQAFMonster:getTag()
	return AQAFGameEnum.UnitTag.Monster
end

function AQAFMonster:initData(params)
	self:resetData()

	self._params = params
	self._atkType = params.atkType
	self._maxHp = params.MaxHp
	self._Atk = params.Atk
	self._TakMagicDamRate = params.magicDamRate
	self._TakPhysicalDamRate = params.phyDamRate
	self._CurShield = params.shield
	self._CD = params.CD
	self._CDTimer = 0
	self._isBoss = params.isBoss
	self.moveSpeed = params.moveSpeed
	self._bulletId = params.bulletId
	self._rangeAttack = params.atkRange
	self.modelCfg = AoQiAttackForceConfig.instance:getModelCfg(params.modelId)

	if self._isBoss then
		self:setRadius(self.modelCfg.radius * 2)
	else
		self:setRadius(self.modelCfg.radius)
	end

	self._target = AoQiAttackForceGameController.instance:getPlayerUnit()

	self:initMoveDir()

	if AoQiAttackForceModel.instance:getIsEndlessState() then
		local hardCoefficient = AoQiAttackForceModel.instance:getHardCoefficient()
		local cfg = AoQiAttackForceModel.instance:getCurClgCfg()
		local addBuffId = cfg.addMonsterBuff
		local buffCfg = AoQiAttackForceConfig.instance:getBuffCfg(addBuffId)
		local buffType = buffCfg.createType

		for i = 1, hardCoefficient do
			local buff = AQAFBuffMgr.instance:addBuffToUnit(self, buffType, buffCfg)

			self.addBuff(self, self)
		end
	end

	if checknumber(params.bornBuffId) > 0 then
		local buffCfg = AoQiAttackForceConfig.instance:getBuffCfg(params.bornBuffId)
		local buffType = buffCfg.createType
		local buff = AQAFBuffMgr.instance:addBuffToUnit(self, buffType, buffCfg)

		self.addBuff(self, self)
	end

	self._curHp = self:getCurMaxHP()
end

function AQAFMonster:isActive()
	return self._isActive
end

function AQAFMonster:initMoveDir()
	self._curMoveDir:Set(self._target.position.x - self.position.x, self._target.position.y - self.position.y)

	self._curMoveDir = Vector2.Normalize(self._curMoveDir)
end

function AQAFMonster:resetTir()
	AQAFMonster.super.resetTir(self)

	self.isMove = false
	self.isTriHit = false
	self.isTriAtk = false
	self.isTriFrozen = false
end

function AQAFMonster:update()
	AQAFMonster.super.update(self)

	if self:isFrozend() then
		return
	end

	if self._curHp <= 0 then
		self:die()
	end

	if not self:isActive() then
		return
	end

	self._CDTimer = self._CDTimer - AoQiAttackForceGameController.instance:getCurDeltaTime()

	if self:checkMove() then
		self:move()
	elseif self:checkAttack() then
		self:attack()
	end
end

function AQAFMonster:changeKnockback(dir, time)
	local oldDir = checknumber(self.speedChange) * checknumber(self.speedIntensityTime)

	self.speedChange = (oldDir + dir) / checknumber(time)
	self.speedIntensityTime = checknumber(time)
end

function AQAFMonster:checkMove()
	return not AoQiAttackForceGameController.instance:checkInRangeBetween(self._target, self, self._rangeAttack) or self.moveSpeed + self.speedChange < 0
end

function AQAFMonster:move()
	local step = (self.moveSpeed + self.speedChange) * AoQiAttackForceGameController.instance:getCurDeltaTime()
	local stepX = self._curMoveDir.x * step
	local stepY = self._curMoveDir.y * step

	self:updatePosition(self.position.x + stepX, self.position.y + stepY)

	self.isMove = true

	if self.speedIntensityTime > 0 or Mathf.Abs(self.speedChange) > 0 then
		self.speedIntensityTime = self.speedIntensityTime - AoQiAttackForceGameController.instance:getCurDeltaTime()

		if self.speedIntensityTime <= 0 then
			self.speedChange = 0
			self.speedIntensityTime = 0
		end
	end
end

function AQAFMonster:checkAttack()
	return self._CDTimer < 0
end

function AQAFMonster:attack()
	AQAFMonster.super.attack(self)

	self._CDTimer = self._CD

	if self._atkType == AQAFGameEnum.MonsterAttackType.Ranged then
		local params = {
			CriRate = self:getCri(),
			CriDamRate = self:getCurCriDamRate(),
			Atk = self:getCurAtk(),
			bulletId = self._bulletId,
			position = self.position,
			owner = self,
			dirX = self._target.position.x - self.position.x,
			dirY = self._target.position.y - self.position.y
		}

		AoQiAttackForceGameController.instance:createBullet(params, false)
	elseif self._atkType == AQAFGameEnum.MonsterAttackType.Melee then
		AoQiAttackForceGameController.instance:doHit(self, self._target)
	end

	self.isTriAtk = true
end

function AQAFMonster:isBoss()
	return self._isBoss
end

function AQAFMonster:onTakeDammage(damage, damageType)
	AQAFMonster.super.onTakeDammage(self, damage, damageType)

	self.isTriHit = true

	if self._curHp <= 0 then
		AoQiAttackForceModel.instance:updateKillScore(self:isBoss())
	end
end

function AQAFMonster:getParams()
	return self._params
end

return AQAFMonster
