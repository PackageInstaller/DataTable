-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFBullet.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFBullet", package.seeall)

local AQAFBullet = class("AQAFBullet", AQAFUnit)

function AQAFBullet:ctor()
	AQAFBullet.super.ctor(self)

	self.owner = nil
	self.rotationZ = 0
	self.moveSpeed = 10
	self._bulletCfg = nil
	self._isRotateSelf = false
	self._curMoveDir = Vector2.New(0, 0)
	self._markIdMap = nil
	self._curFlightMode = ""
	self.lastPos = {}
	self._markIdMap = {}
end

function AQAFBullet:getTag()
	return AQAFGameEnum.UnitTag.Bullet
end

function AQAFBullet:resetData()
	AQAFBullet.super.resetData(self)

	self._curFlightMode = ""

	table.clear(self.lastPos)
	table.clear(self._markIdMap)
end

function AQAFBullet:initData(params)
	self:resetData()

	self._isActive = true

	local cfgId = params.bulletId

	self.bulletId = cfgId
	self._CriRate = params.CriRate
	self._Atk = params.Atk
	self._CriDamRate = params.CriDamRate
	self._bulletCfg = AoQiAttackForceConfig.instance:getBulletCfg(cfgId)
	self._hitCount = self._bulletCfg.hitCount

	self:setRadius(self._bulletCfg.radius)
	table.clear(self._markIdMap)

	local hasHitIds = params.hasHitIds

	if hasHitIds then
		for _, id in ipairs(hasHitIds) do
			self._markIdMap[id] = true
		end
	end

	self._isRotateSelf = self._bulletCfg.isRotate
	self.moveSpeed = self._bulletCfg.Speed
	self.owner = params.owner
	self.damage = params.damage

	self:updatePosition(params.position.x, params.position.y)

	self.lastPos.x = params.position.x
	self.lastPos.y = params.position.y
	self._bornX, self._bornY = params.position.x, params.position.y
	self._curMaxDistance = 0
	self._maxDistanceLimit = self._bulletCfg.maxDistance
	self._isForward = true

	self._curMoveDir:Set(params.dirX, params.dirY)
	self._curMoveDir:SetNormalize()

	local newRz = Mathf.Acos(self._curMoveDir.x) * Mathf.Rad2Deg

	if self.owner:getTag() == AQAFGameEnum.UnitTag.Weapon then
		if self._curMoveDir.y > 0 then
			self:undateRotation(newRz)
		else
			self:undateRotation(-newRz)
		end
	elseif self.owner:getTag() == AQAFGameEnum.UnitTag.Monster then
		if self._curMoveDir.y > 0 then
			self:undateRotation(-newRz)
		else
			self:undateRotation(newRz)
		end
	end

	local buffIds = params.bulletBuffIds

	if buffIds then
		for _, buffId in ipairs(buffIds) do
			local buffCfg = AoQiAttackForceConfig.instance:getBuffCfg(buffId)
			local buffType = buffCfg.createType
			local buff = AQAFBuffMgr.instance:addBuffToUnit(self, buffType, buffCfg)

			self:addBuff(self.owner)
		end
	end
end

function AQAFBullet:resetTir()
	self.isTriHit = false
	self.isMove = false
	self.isRotate = false
end

function AQAFBullet:update()
	AQAFBullet.super.update(self)

	if not self._isActive then
		return
	end

	self:move()
	self:rotateSelf()
end

function AQAFBullet:move()
	local step = self.moveSpeed * AoQiAttackForceGameController.instance:getCurDeltaTime()
	local stepX = self._curMoveDir.x * step
	local stepY = self._curMoveDir.y * step

	self:updatePosition(self.position.x + stepX, self.position.y + stepY)
	self:doChangeFlightMode()

	if self.position.x > 1000 or self.position.x < -800 then
		self._isActive = false
	end
end

function AQAFBullet:rotateSelf()
	if self._isRotateSelf then
		self:undateRotation(self.rotationZ - 30)
	end
end

function AQAFBullet:updatePosition(x, y)
	self.lastPos.x = self.position.x
	self.lastPos.y = self.position.y

	AQAFBullet.super.updatePosition(self, x, y)

	self.isMove = true
end

function AQAFBullet:undateRotation(z)
	self.rotationZ = checknumber(z)
	self.isRotate = true
end

function AQAFBullet:hit(targetUnit)
	AQAFBullet.super.hit(self, targetUnit)
	self.owner:hit(targetUnit)

	self.isTriHit = true

	if not self._markIdMap[targetUnit.id] then
		self._markIdMap[targetUnit.id] = true

		if self._hitUnitCount >= self:getCurHitCount() then
			self._isActive = false
		end
	end
end

function AQAFBullet:checkCanHit(targetUnit)
	return self._markIdMap[targetUnit.id] == nil and self._isActive
end

function AQAFBullet:critical(unit)
	AQAFBullet.super.critical(self, unit)
	self.owner:critical(unit)
end

function AQAFBullet:beforeCauseDamage(unit)
	AQAFBullet.super.beforeCauseDamage(self, unit)
	self.owner:beforeCauseDamage(unit)
end

function AQAFBullet:afterCauseDamage(unit, damage)
	AQAFBullet.super.beforeCauseDamage(self, unit, damage)
	self.owner:afterCauseDamage(unit, damage)
end

function AQAFBullet:changeFlightMode(mode, addParam)
	self._curFlightMode = mode

	if self._curFlightMode == "boomerang" then
		-- block empty
	end
end

function AQAFBullet:doChangeFlightMode()
	if self._curFlightMode == "boomerang" and self._isForward then
		local disX = self.position.x - self._bornX
		local disY = self.position.y - self._bornY
		local dis = math.sqrt(disX * disX + disY * disY)

		self._curMaxDistance = math.max(dis, self._curMaxDistance)

		if self._curMaxDistance > self._maxDistanceLimit then
			self._isForward = false

			table.clear(self._markIdMap)

			self._curMoveDir.x = -self._curMoveDir.x
			self._curMoveDir.y = -self._curMoveDir.y
		end
	end
end

function AQAFBullet:updateAttr(attrType, value)
	AQAFBullet.super.updateAttr(self, attrType, value)

	self._bf_hitCount = self._bf_hitCount + checknumber(value)
end

function AQAFBullet:getCurHitCount()
	return self._hitCount + self._bf_hitCount
end

function AQAFBullet:resetBuffData()
	AQAFBullet.super.resetBuffData(self)

	self._bf_hitCount = 0
end

function AQAFBullet:getCurDamRate()
	if self.owner then
		return self.owner:getCurDamRate()
	else
		return 1
	end
end

function AQAFBullet:getDamageType()
	if self.owner then
		return self.owner:getDamageType()
	else
		return AQAFGameEnum.AttackDamageType.Normal
	end
end

return AQAFBullet
