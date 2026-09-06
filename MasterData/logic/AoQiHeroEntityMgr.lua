-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/controller/battlemgr/AoQiHeroEntityMgr.lua

module("logic.extensions.aoqihero.controller.battlemgr.AoQiHeroEntityMgr", package.seeall)

local AoQiHeroEntityMgr = class("AoQiHeroEntityMgr")
local tempTable = {}

function AoQiHeroEntityMgr:ctor()
	self._petMap = {}
	self.defenceTeamMo = nil
	self.attackTeamMo = nil
	self._deadRecord = {}
end

function AoQiHeroEntityMgr:initData(activityId, creepsMasterId)
	local idIndex = 1
	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(activityId)

	self._petMap = {}

	local attackTeamMo = AoQiHeroTeamMo.New()

	attackTeamMo:initData()

	attackTeamMo.teamId = AoQiHeroConst.AttackTeam

	local towerMo = AoQiHeroTowerMo.New()
	local towerEntityId = AoQiHeroConst.TowerEntityId
	local totalHp = 0
	local towerConfigId

	for i = 1, activityCfg.cardNum do
		local posInfo = AoQiHeroModel.instance:getCurPetTeam(activityId, i)

		if posInfo and checknumber(posInfo.petId) ~= 0 then
			towerConfigId = towerConfigId or posInfo.petId

			table.clear(tempTable)

			local info = tempTable

			info.id = idIndex
			info.activityId = activityId
			info.teamId = attackTeamMo.teamId
			info.configId = posInfo.petId
			info.level = posInfo.lv
			info.pos = i
			info.towerMo = towerMo

			local battlePetMo = AoQiHeroPetMo.New()

			battlePetMo:initData(info)

			self._petMap[battlePetMo.id] = battlePetMo
			totalHp = totalHp + battlePetMo.curHp
			attackTeamMo.pos[i] = battlePetMo.id
			idIndex = idIndex + 1
		end
	end

	table.clear(tempTable)

	local towerInfo = tempTable

	towerInfo.id = towerEntityId
	towerInfo.activityId = activityId
	towerInfo.teamId = attackTeamMo.teamId
	towerInfo.configId = towerConfigId
	towerInfo.hp = totalHp

	towerMo:initData(towerInfo)

	attackTeamMo.pos[towerEntityId] = towerEntityId
	self._petMap[towerEntityId] = towerMo
	self.attackTeamMo = attackTeamMo

	local defenceTeamMo = AoQiHeroTeamMo.New()

	defenceTeamMo:initData()

	defenceTeamMo.teamId = AoQiHeroConst.DefenceTeam

	local creepsCfg = AoQiHeroConfig.instance:getCreepsCfg(activityId, creepsMasterId)

	for i, v in ipairs(creepsCfg) do
		local battlePetMo = AoQiHeroEnemyMo.New()
		local attrData = FightingPowerFormula.instance:parseAttrValues(v.extproperties)
		local petCfg = AoQiHeroConfig.instance:getPetCfg(activityId, v.raceId)
		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.lv)

		table.clear(tempTable)

		local info = tempTable

		info.id = idIndex
		info.activityId = activityId
		info.teamId = defenceTeamMo.teamId
		info.pos = v.posId
		info.configId = v.raceId
		info.level = v.lv
		info.hp = checknumber(attrData[GameEnum.AttrType.Hp])
		info.attack = checknumber(attrData[GameEnum.AttrType.Attack])
		info.speed = attrData[GameEnum.AttrType.Speed] or 0
		info.criticalRate = checknumber(attrData[GameEnum.AttrType.CriticalRate])
		info.criticaDamage = 1.5
		info.normalSkillId = propertyCfg.defenseNormalSkillId
		info.utlSkillId = propertyCfg.defenseUltSkillId
		info.isEnemy = v.isEnemy

		battlePetMo:initData(info)

		defenceTeamMo.pos[i] = battlePetMo.id
		self._petMap[battlePetMo.id] = battlePetMo

		if v.buffIds then
			for i, buffId in ipairs(v.buffIds) do
				local buffCfg = AoQiHeroConfig.instance:getSkillAffixCfg(buffId)
				local buffMo = AoQiHeroBuffMgr.instance:createBuffMo(buffCfg)

				AoQiHeroBuffMgr.instance:addBuff(battlePetMo.id, buffMo)
			end
		end

		idIndex = idIndex + 1
	end

	self.defenceTeamMo = defenceTeamMo
	self._deadCount = 0

	self:_refreshAttackTeamHp()
end

function AoQiHeroEntityMgr:initEnemyData(activityId, creepsMasterId)
	local idIndex = 1

	for i, v in pairs(self.defenceTeamMo.pos) do
		self._petMap[v] = nil
	end

	for i, v in pairs(self.attackTeamMo.pos) do
		idIndex = idIndex + 1
	end

	self.defenceTeamMo:initData()

	self.defenceTeamMo.teamId = AoQiHeroConst.DefenceTeam

	local creepsCfg = AoQiHeroConfig.instance:getCreepsCfg(activityId, creepsMasterId)

	for i, v in ipairs(creepsCfg) do
		local battlePetMo = AoQiHeroEnemyMo.New()
		local attrData = FightingPowerFormula.instance:parseAttrValues(v.extproperties)
		local petCfg = AoQiHeroConfig.instance:getPetCfg(activityId, v.raceId)
		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.lv)

		table.clear(tempTable)

		local info = tempTable

		info.id = idIndex
		info.teamId = self.defenceTeamMo.teamId
		info.pos = v.posId
		info.activityId = activityId
		info.configId = v.raceId
		info.level = v.lv
		info.hp = checknumber(attrData[GameEnum.AttrType.Hp])
		info.attack = checknumber(attrData[GameEnum.AttrType.Attack])
		info.speed = attrData[GameEnum.AttrType.Speed] or 0
		info.criticalRate = checknumber(attrData[GameEnum.AttrType.CriticalRate])
		info.criticaDamage = 1.5
		info.normalSkillId = propertyCfg.defenseNormalSkillId
		info.utlSkillId = propertyCfg.defenseUltSkillId
		info.isEnemy = v.isEnemy

		battlePetMo:initData(info)

		self.defenceTeamMo.pos[i] = battlePetMo.id
		self._petMap[battlePetMo.id] = battlePetMo

		if v.buffIds then
			for i, buffId in ipairs(v.buffIds) do
				local buffCfg = AoQiHeroConfig.instance:getSkillAffixCfg(buffId)
				local buffMo = AoQiHeroBuffMgr.instance:createBuffMo(buffCfg)

				AoQiHeroBuffMgr.instance:addBuff(battlePetMo.id, buffMo)
			end
		end

		idIndex = idIndex + 1
	end

	self._deadCount = 0

	self:_refreshAttackTeamHp()
end

function AoQiHeroEntityMgr:initPvPData(activityId)
	local idIndex = 1
	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(activityId)

	self._petMap = {}

	local attackTeamMo = AoQiHeroTeamMo.New()

	attackTeamMo:initData()

	attackTeamMo.teamId = AoQiHeroConst.AttackTeam

	local towerMo = AoQiHeroEntityMo.New()
	local towerEntityId = AoQiHeroConst.TowerEntityId
	local totalHp = 0
	local towerConfigId

	for i = 1, activityCfg.cardNum do
		local posInfo = AoQiHeroModel.instance:getCurPetTeam(activityId, i)

		if posInfo and checknumber(posInfo.petId) ~= 0 then
			towerConfigId = towerConfigId or posInfo.petId

			table.clear(tempTable)

			local info = tempTable

			info.id = idIndex
			info.activityId = activityId
			info.teamId = attackTeamMo.teamId
			info.configId = posInfo.petId
			info.level = posInfo.lv
			info.pos = i
			info.towerMo = towerMo

			local battlePetMo = AoQiHeroPetMo.New()

			battlePetMo:initData(info)

			attackTeamMo.pos[i] = battlePetMo.id
			self._petMap[battlePetMo.id] = battlePetMo
			totalHp = totalHp + battlePetMo.curHp
			idIndex = idIndex + 1
		end
	end

	table.clear(tempTable)

	local towerInfo = tempTable

	towerInfo.id = towerEntityId
	towerInfo.activityId = activityId
	towerInfo.teamId = attackTeamMo.teamId
	towerInfo.configId = towerConfigId
	towerInfo.hp = totalHp

	towerMo:initData(towerInfo)

	attackTeamMo.pos[towerEntityId] = towerEntityId
	self._petMap[towerEntityId] = towerMo
	self.attackTeamMo = attackTeamMo

	local opponentInfo = AoQiHeroModel.instance:getPvPOpInfo()
	local defenceTeamMo = AoQiHeroTeamMo.New()

	defenceTeamMo:initData()

	defenceTeamMo.teamId = AoQiHeroConst.DefenceTeam

	local creepsCfg = AoQiHeroConfig.instance:getCreepsCfg(activityId, opponentInfo.opDefCreepsMasterId)
	local enemyIndex = 1

	for i, v in ipairs(creepsCfg) do
		if v.isEnemy == false then
			local attrData = FightingPowerFormula.instance:parseAttrValues(v.extproperties)
			local petCfg = AoQiHeroConfig.instance:getPetCfg(activityId, v.raceId)
			local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.lv)

			table.clear(tempTable)

			local info = tempTable

			info.id = idIndex
			info.activityId = activityId
			info.teamId = defenceTeamMo.teamId
			info.pos = v.posId
			info.configId = v.raceId
			info.level = v.lv
			info.hp = checknumber(attrData[GameEnum.AttrType.Hp])
			info.attack = checknumber(attrData[GameEnum.AttrType.Attack])
			info.speed = attrData[GameEnum.AttrType.Speed] or 0
			info.criticalRate = checknumber(attrData[GameEnum.AttrType.CriticalRate])
			info.criticaDamage = 1.5
			info.normalSkillId = propertyCfg.defenseNormalSkillId
			info.utlSkillId = propertyCfg.defenseUltSkillId
			info.isEnemy = v.isEnemy

			local battlePetMo = AoQiHeroEnemyMo.New()

			battlePetMo:initData(info)

			defenceTeamMo.pos[enemyIndex] = battlePetMo.id
			self._petMap[battlePetMo.id] = battlePetMo

			if v.buffIds then
				for i, buffId in ipairs(v.buffIds) do
					local buffCfg = AoQiHeroConfig.instance:getSkillAffixCfg(buffId)
					local buffMo = AoQiHeroBuffMgr.instance:createBuffMo(buffCfg)

					AoQiHeroBuffMgr.instance:addBuff(battlePetMo.id, buffMo)
				end
			end

			idIndex = idIndex + 1
			enemyIndex = enemyIndex + 1
		end
	end

	for i, v in ipairs(opponentInfo.opDefItems) do
		local petCfg = AoQiHeroConfig.instance:getPetCfg(activityId, v.raceId)
		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.level)

		table.clear(tempTable)

		local info = tempTable

		info.id = idIndex
		info.activityId = activityId
		info.teamId = defenceTeamMo.teamId
		info.pos = v.posId
		info.configId = v.raceId
		info.level = v.level
		info.hp = propertyCfg.defHp
		info.attack = propertyCfg.defAtk
		info.speed = propertyCfg.defSpeed or 0
		info.criticalRate = propertyCfg.defCriticalRate
		info.criticaDamage = propertyCfg.defCriticalDamageRate
		info.normalSkillId = propertyCfg.defenseNormalSkillId
		info.utlSkillId = propertyCfg.defenseUltSkillId
		info.isEnemy = true

		local battlePetMo = AoQiHeroEnemyMo.New()

		battlePetMo:initData(info)

		defenceTeamMo.pos[enemyIndex] = battlePetMo.id
		self._petMap[battlePetMo.id] = battlePetMo
		idIndex = idIndex + 1
		enemyIndex = enemyIndex + 1
	end

	self.defenceTeamMo = defenceTeamMo
	self._deadCount = 0

	self:_refreshAttackTeamHp()
end

function AoQiHeroEntityMgr:getAllPet()
	return self._petMap
end

function AoQiHeroEntityMgr:getPet(petId)
	return self._petMap[petId]
end

function AoQiHeroEntityMgr:getTeamMo(teamType)
	if teamType == AoQiHeroConst.AttackTeam then
		return self.attackTeamMo
	elseif teamType == AoQiHeroConst.DefenceTeam then
		return self.defenceTeamMo
	end
end

function AoQiHeroEntityMgr:isPetSurvival(petId)
	if self._petMap[petId] then
		return self._petMap[petId].curHp > 0
	else
		return false
	end
end

function AoQiHeroEntityMgr:getSelfTeamAndEnemyTeam(petId)
	local targetAPetMo = self:getPet(petId)

	if targetAPetMo then
		if not targetAPetMo.teamId then
			local targetATeamType = AoQiHeroConst.AttackTeam

			return targetATeamType, (targetATeamType ~= AoQiHeroConst.AttackTeam or nil) and AoQiHeroConst.AttackTeam
		end
	end
end

function AoQiHeroEntityMgr:deadCheck()
	local deadList = {}
	local isDead = false

	for i, v in pairs(self._petMap) do
		if not self:isPetSurvival(v.id) and not self._deadRecord[v.id] then
			isDead = true

			table.insert(deadList, v.id)
		end
	end

	return isDead, deadList
end

function AoQiHeroEntityMgr:setDeadRoot()
	table.clear(self._deadRecord)

	for i, v in pairs(self._petMap) do
		if not self:isPetSurvival(v.id) then
			self._deadRecord[v.id] = true
		end
	end
end

function AoQiHeroEntityMgr:getDeadRoot()
	return self._deadRecord
end

function AoQiHeroEntityMgr:resetAllActive()
	for k, v in pairs(self._petMap) do
		v.isActive = false
	end
end

function AoQiHeroEntityMgr:activeAllEntityByTeamType(teamType)
	for k, v in pairs(self._petMap) do
		if v.teamId == teamType then
			v.isActive = true
		end
	end
end

function AoQiHeroEntityMgr:checkPetActiveAndMotion()
	for i, v in ipairs(self.attackTeamMo.pos) do
		local petMo = self._petMap[v]

		if not petMo.isActive and not AoQiHeroBuffMgr.instance:checkBuffType(v, AoQiHeroConst.BuffDazed) and not AoQiHeroBuffMgr.instance:checkBuffType(v, AoQiHeroConst.BuffSettled) then
			return true
		end
	end

	return false
end

function AoQiHeroEntityMgr:_refreshAttackTeamHp()
	local towerMo = self._petMap[AoQiHeroConst.TowerEntityId]

	for i, v in ipairs(self.attackTeamMo.pos) do
		local petMo = self._petMap[v]

		petMo.curHp = towerMo.curHp
	end
end

AoQiHeroEntityMgr.instance = AoQiHeroEntityMgr.New()

return AoQiHeroEntityMgr
