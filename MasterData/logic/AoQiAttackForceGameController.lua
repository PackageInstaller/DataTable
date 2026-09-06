-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/AoQiAttackForceGameController.lua

module("logic.extensions.aoqiattackforce.minigame.AoQiAttackForceGameController", package.seeall)

local AoQiAttackForceGameController = class("AoQiAttackForceGameController")

function AoQiAttackForceGameController:ctor()
	self._simpleQT = SimpleQuadTree.New(-900, -460, 1800, 920, 4)
	self._foundCol = {}
	self._randNumList = {}

	for i = 1, 100 do
		table.insert(self._randNumList, 1)
	end

	self._curTargetList = {}
	self._bulletCreateList = {}
end

function AoQiAttackForceGameController:resetGameData()
	self._curActiveMonsters = {}
	self._curActiveMonsterBullets = {}
	self._curActivePlayerBullets = {}
	self._bornMonsterParams = {}
	self._curWeaponsList = {}
	self._curWeaponMap = {}
	self._bornCDTimer = 0
	self._updateTargetTimer = 0

	self:setTimeScale(1)

	self._bulletCreateList = {}
	self._curExistMonsterNum = 0
end

function AoQiAttackForceGameController:setTimeScale(timeScale)
	self.curTimeScale = checknumber(timeScale)
end

function AoQiAttackForceGameController:getTimeScale()
	return self.curTimeScale
end

function AoQiAttackForceGameController:getCurDeltaTime()
	return UnityEngine.Time.deltaTime * self.curTimeScale
end

function AoQiAttackForceGameController:initGameData()
	self.playerUnit = AQAFPlayer.New()
	self.playerUnit.id = AoQiAttackForceModel.instance:newOwnId()

	self.playerUnit:initData()
	GlobalDispatcher:dispatch(GlobalNotify.AQAFGameCreateUnit, self.playerUnit)
	self:resetGameData()

	self._bornMonsterParams = AoQiAttackForceModel.instance:getCurMonsterCfgs()

	local equipDatas = AoQiAttackForceModel.instance:getCurEquipsInGame()

	for _, equipData in ipairs(equipDatas) do
		if equipData.cfg.equipmentType ~= AQAFGameEnum.WeaponType.Purse then
			self:createWeapon(equipData)
		end
	end

	self:addWeaponBuffs()
end

function AoQiAttackForceGameController:onUpdate()
	self._bornCDTimer = self._bornCDTimer - self:getCurDeltaTime()

	if #self._bornMonsterParams > 0 and self._bornCDTimer < 0 and self._curExistMonsterNum < 20 then
		self:bornMonster()
	end

	self:checkCollision()

	self._updateTargetTimer = self._updateTargetTimer - self:getCurDeltaTime()

	if self._updateTargetTimer < 0 then
		self:_updateTarget()
	end

	self.playerUnit:update()

	for _, monster in pairs(self._curActiveMonsters) do
		monster:update()
	end

	for _, bullet in pairs(self._curActiveMonsterBullets) do
		bullet:update()
	end

	for _, bullet in pairs(self._curActivePlayerBullets) do
		bullet:update()
	end

	for _, weapon in ipairs(self._curWeaponsList) do
		weapon:update()
	end

	self:checkAllUnit()
end

function AoQiAttackForceGameController:onLateUpdate()
	self.playerUnit:onLateUpdate()

	for _, monster in pairs(self._curActiveMonsters) do
		monster:onLateUpdate()
	end

	for _, bullet in pairs(self._curActiveMonsterBullets) do
		bullet:onLateUpdate()
	end

	for _, bullet in pairs(self._curActivePlayerBullets) do
		bullet:onLateUpdate()
	end

	for _, weapon in ipairs(self._curWeaponsList) do
		weapon:onLateUpdate()
	end
end

function AoQiAttackForceGameController:checkCollision()
	for _, bullet in pairs(self._curActiveMonsterBullets) do
		if self:checkIsCollisonBetween(self.playerUnit, bullet) and bullet:checkCanHit(self.playerUnit) then
			self:doHit(bullet, self.playerUnit)
		end
	end

	self._simpleQT:clear()

	for _, bullet in pairs(self._curActivePlayerBullets) do
		self._simpleQT:insert(bullet)
	end

	for _, monster in pairs(self._curActiveMonsters) do
		if monster.radius > 0 then
			table.clear(self._foundCol)

			self._foundCol = self._simpleQT:query(monster.rect, self._foundCol)

			for i, bullet in ipairs(self._foundCol) do
				if (self:checkIsCollisonBetween(monster, bullet) or GameUtil.isLineSegmentIntersectingCircle(bullet.lastPos, bullet.position, monster.position, monster.radius)) and bullet:checkCanHit(monster) then
					self:doHit(bullet, monster)
				end
			end
		end
	end
end

function AoQiAttackForceGameController:checkIsCollisonBetween(unitA, unitB)
	if unitA and unitB then
		local disX = unitA.position.x - unitB.position.x
		local disY = unitA.position.y - unitB.position.y
		local range = unitA.radius + unitB.radius

		return range * range >= disX * disX + disY * disY
	end
end

function AoQiAttackForceGameController:checkAllUnit()
	self._curExistMonsterNum = 0

	for id, monster in pairs(self._curActiveMonsters) do
		if not monster:isActive() then
			GlobalDispatcher:dispatch(GlobalNotify.AQAFGameRemoveUnit, monster)

			self._curActiveMonsters[id] = nil
		else
			self._curExistMonsterNum = self._curExistMonsterNum + 1
		end
	end

	for id, bullet in pairs(self._curActivePlayerBullets) do
		if not bullet:isActive() then
			GlobalDispatcher:dispatch(GlobalNotify.AQAFGameRemoveUnit, bullet)

			self._curActivePlayerBullets[id] = nil

			table.insert(self._bulletCreateList, bullet)
		end
	end

	for id, bullet in pairs(self._curActiveMonsterBullets) do
		if not bullet:isActive() then
			GlobalDispatcher:dispatch(GlobalNotify.AQAFGameRemoveUnit, bullet)

			self._curActiveMonsterBullets[id] = nil

			table.insert(self._bulletCreateList, bullet)
		end
	end
end

function AoQiAttackForceGameController:getNewMonsterParam()
	return table.remove(self._bornMonsterParams, #self._bornMonsterParams)
end

function AoQiAttackForceGameController:bornMonster()
	local param = self:getNewMonsterParam()

	self:createMonster(param)

	if #self._bornMonsterParams == 0 and AoQiAttackForceModel.instance:getIsEndlessState() then
		self._bornMonsterParams = AoQiAttackForceModel.instance:getCurMonsterCfgs()

		AoQiAttackForceModel.instance:strengthenMonster()
	end

	self._bornCDTimer = param.bornTimer
end

function AoQiAttackForceGameController:createMonster(params, notDispatch)
	local monster = AQAFMonster.New()

	monster.id = AoQiAttackForceModel.instance:newOwnId()

	monster:initData(params)

	self._curActiveMonsters[monster.id] = monster

	monster:updatePosition(900, math.random(-300, 300))
	monster:initMoveDir()

	if not notDispatch then
		GlobalDispatcher:dispatch(GlobalNotify.AQAFGameCreateUnit, monster)
	end

	return monster
end

function AoQiAttackForceGameController:createBullet(params, isPlayer)
	local bullet = #self._bulletCreateList > 0 and table.remove(self._bulletCreateList) or AQAFBullet.New()

	bullet.id = AoQiAttackForceModel.instance:newOwnId()

	bullet:initData(params)

	if isPlayer then
		self._curActivePlayerBullets[bullet.id] = bullet
	else
		self._curActiveMonsterBullets[bullet.id] = bullet
	end

	GlobalDispatcher:dispatch(GlobalNotify.AQAFGameCreateUnit, bullet)

	return bullet
end

function AoQiAttackForceGameController:createWeapon(params)
	local weapon = AQAFWeapon.New()

	weapon.id = AoQiAttackForceModel.instance:newOwnId()

	weapon:initData(params)
	table.insert(self._curWeaponsList, weapon)

	self._curWeaponMap[params.id] = weapon

	GlobalDispatcher:dispatch(GlobalNotify.AQAFGameCreateUnit, weapon)

	return weapon
end

function AoQiAttackForceGameController:addWeaponBuffs()
	local buffs = AoQiAttackForceModel.instance:getCurGainBuffs()

	for _, buffId in ipairs(buffs) do
		local buffCfg = AoQiAttackForceConfig.instance:getBuffCfgInGameCfg(buffId)
		local limitId = buffCfg.equipIdlimit
		local fightBuffCfg = AoQiAttackForceConfig.instance:getBuffCfg(buffCfg.addBuffId)
		local buffType = fightBuffCfg.createType

		if buffCfg.target == "equip" then
			for _, weapon in ipairs(self._curWeaponsList) do
				if weapon.params.defineId == limitId then
					local buff = AQAFBuffMgr.instance:addBuffToUnit(weapon, buffType, fightBuffCfg)

					weapon.addBuff(weapon, weapon)
				end
			end
		elseif buffCfg.target == "player" then
			for _, weapon in ipairs(self._curWeaponsList) do
				if weapon.params.defineId == limitId then
					local buff = AQAFBuffMgr.instance:addBuffToUnit(self.playerUnit, buffType, fightBuffCfg)

					self.playerUnit:addBuff(weapon)
				end
			end
		elseif buffCfg.target == "bullet" then
			for _, weapon in ipairs(self._curWeaponsList) do
				if weapon.params.defineId == limitId then
					weapon:addBulletBuffId(buffCfg.addBuffId)
				end
			end
		elseif buffCfg.target == "link" then
			for _, weapon in ipairs(self._curWeaponsList) do
				if weapon.params.defineId == limitId then
					local linkMap = weapon.params:getCurLinkMap() or {}

					for eqDataId, _ in pairs(linkMap) do
						local addWeapon = self._curWeaponMap[eqDataId]

						if addWeapon then
							local buff = AQAFBuffMgr.instance:addBuffToUnit(addWeapon, buffType, fightBuffCfg)

							addWeapon.addBuff(addWeapon, addWeapon)
						end
					end
				end
			end
		elseif buffCfg.target == "link2" then
			for _, weapon in ipairs(self._curWeaponsList) do
				if weapon.params.defineId == limitId then
					local linkMap = weapon.params:getCurLinkMap() or {}

					for eqDataId, _ in pairs(linkMap) do
						local addWeapon = self._curWeaponMap[eqDataId]

						if addWeapon and addWeapon:getEquipType() == AQAFGameEnum.WeaponType.Physics then
							local buff = AQAFBuffMgr.instance:addBuffToUnit(addWeapon, buffType, fightBuffCfg)

							addWeapon.addBuff(addWeapon, addWeapon)
						end
					end
				end
			end
		elseif buffCfg.target == "link3" then
			for _, weapon in ipairs(self._curWeaponsList) do
				if weapon.params.defineId == limitId then
					local linkMap = weapon.params:getCurLinkMap() or {}

					for eqDataId, _ in pairs(linkMap) do
						local addWeapon = self._curWeaponMap[eqDataId]

						if addWeapon and addWeapon:getEquipType() == AQAFGameEnum.WeaponType.Magic then
							local buff = AQAFBuffMgr.instance:addBuffToUnit(addWeapon, buffType, fightBuffCfg)

							addWeapon.addBuff(addWeapon, addWeapon)
						end
					end
				end
			end
		elseif buffCfg.target == "link4" then
			for _, weapon in ipairs(self._curWeaponsList) do
				if weapon.params.defineId == limitId then
					local linkMap = weapon.params:getCurLinkMap()

					for eqDataId, _ in pairs(linkMap) do
						local addWeapon = self._curWeaponMap[eqDataId]

						if addWeapon and addWeapon:getEquipType() == AQAFGameEnum.WeaponType.Defense then
							local buff = AQAFBuffMgr.instance:addBuffToUnit(addWeapon, buffType, fightBuffCfg)

							addWeapon.addBuff(addWeapon, addWeapon)
						end
					end
				end
			end
		end
	end
end

function AoQiAttackForceGameController:getWeaponList()
	return self._curWeaponsList
end

function AoQiAttackForceGameController:getGameResult()
	local isFinish = false
	local isWin = false

	if #self._bornMonsterParams <= 0 and table.nums(self._curActiveMonsters) <= 0 then
		isWin = true
		isFinish = true
	end

	return (not self.playerUnit:isActive() or nil) and true, isWin
end

function AoQiAttackForceGameController:getPlayerUnit()
	return self.playerUnit
end

function AoQiAttackForceGameController:checkInRangeBetween(unitA, unitB, range)
	if unitA and unitB then
		local disX = unitA.position.x - unitB.position.x

		return range >= Mathf.Abs(disX)
	end

	return false
end

function AoQiAttackForceGameController:doHit(hitUnit, beHitUnit)
	beHitUnit:beHit(hitUnit)
	hitUnit:hit(beHitUnit)
	hitUnit:beforeCauseDamage(beHitUnit)

	local damage = 0

	if hitUnit:getIsCritical() then
		hitUnit:critical(beHitUnit)

		damage = hitUnit:getAfterCalDamage(hitUnit:getAfterCalCriDam(true))
	else
		damage = hitUnit:getAfterCalDamage(hitUnit:getAfterCalCriDam(false))
	end

	local damageType = hitUnit:getDamageType()

	beHitUnit:beDamage(hitUnit, damage, damageType)
	hitUnit:afterCauseDamage(beHitUnit, damage)
end

function AoQiAttackForceGameController:doDamage(damUnit, beDamUnit, dam)
	damUnit:beforeCauseDamage(beDamUnit)

	local damage = damUnit:getAfterCalDamage(dam)
	local damageType = damUnit:getDamageType()

	beDamUnit.beDamage(beDamUnit, beDamUnit, damage, damageType)
	damUnit:afterCauseDamage(beDamUnit, damage)
end

function AoQiAttackForceGameController:_updateTarget()
	self._updateTargetTimer = 1
	self._targetList = {}

	for _, monster in pairs(self._curActiveMonsters) do
		table.insert(self._targetList, monster)
	end

	if #self._targetList > 0 then
		table.sort(self._targetList, function(a, b)
			return a.position.x < b.position.x
		end)
	end
end

function AoQiAttackForceGameController:getMonsterTarget(range, targetType)
	self._targetList = self._targetList or {}

	local untiPlayerX = self.playerUnit.position.x
	local lastMonster = self._targetList[1]

	if not lastMonster or range < Mathf.Abs(untiPlayerX - lastMonster.position.x) then
		return
	end

	if targetType == AQAFGameEnum.WeaponTargetType.Last then
		return lastMonster
	elseif targetType == AQAFGameEnum.WeaponTargetType.Random then
		local randomID = 1

		for i = 2, 10 do
			local monster = self._targetList[i]

			if monster and range > Mathf.Abs(untiPlayerX - monster.position.x) then
				randomID = i
			end
		end

		return self._targetList[Mathf.Random(1, randomID)]
	end
end

function AoQiAttackForceGameController:getMonsterTargetWithNum(range, targetType, num)
	self._targetList = self._targetList or {}

	local untiPlayerX = self.playerUnit.position.x

	table.clear(self._curTargetList)

	if targetType == AQAFGameEnum.WeaponTargetType.Last then
		for i, v in ipairs(self._targetList) do
			if v:isActive() and range > Mathf.Abs(untiPlayerX - v.position.x) then
				table.insert(self._curTargetList, v)
			end
		end
	elseif targetType == AQAFGameEnum.WeaponTargetType.Random then
		GameUtil.permuteArray(self._randNumList)

		for i, v in ipairs(self._randNumList) do
			local monster = self._targetList[v]

			if monster and monster:isActive() and range > Mathf.Abs(untiPlayerX - monster.position.x) then
				table.insert(self._curTargetList, monster)

				if #self._curTargetList == num then
					return self._curTargetList
				end
			end
		end
	end

	return self._curTargetList
end

AoQiAttackForceGameController.instance = AoQiAttackForceGameController.New()

return AoQiAttackForceGameController
