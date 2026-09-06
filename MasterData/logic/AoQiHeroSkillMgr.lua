-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/controller/battlemgr/AoQiHeroSkillMgr.lua

module("logic.extensions.aoqihero.controller.battlemgr.AoQiHeroSkillMgr", package.seeall)

local AoQiHeroSkillMgr = class("AoQiHeroSkillMgr")
local SKILLTYPE_RECT = 1
local SKILLTYPE_CROSS = 2
local SKILLTYPE_DIY = 3

function AoQiHeroSkillMgr:ctor()
	self._energy = 0
end

function AoQiHeroSkillMgr:initData(activityId)
	self._activityId = activityId
	self._energy = 0

	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(activityId)

	self._maxEnergy = activityCfg.attackMaxEnergy
end

function AoQiHeroSkillMgr:getCloneSkillMo(skillMo)
	local cloneSkillMo = AoQiHeroSkillMo.New()

	cloneSkillMo.configId = skillMo.configId
	cloneSkillMo.targetA = skillMo.targetA
	cloneSkillMo.isSuperSkill = skillMo.isSuperSkill

	cloneSkillMo:initData()

	return cloneSkillMo
end

function AoQiHeroSkillMgr:getSkillTarget(gridIdX, gridIdY, skillId)
	local targetB = {}
	local targetMap = {}

	if not gridIdX or not gridIdY then
		return targetB, {}
	end

	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(skillId)
	local paramsArray = string.split(skillCfg.attackParam, "#")
	local skillType = checknumber(paramsArray[1])

	table.remove(paramsArray, 1)

	local gridIds = self:getSkillGrid(gridIdX, gridIdY, paramsArray, skillType)

	for i, v in ipairs(gridIds) do
		local x, y = AoQiHeroBattleModel.instance:grid2XY(v)
		local info = AoQiHeroBattleModel.instance:getInfo(x, y)

		if info ~= AoQiHeroConst.MapBlockIndex and info ~= AoQiHeroConst.MapEmptyIndex then
			targetMap[info] = true
		end
	end

	for k, v in pairs(targetMap) do
		table.insert(targetB, k)
	end

	return targetB, gridIds
end

function AoQiHeroSkillMgr:getSkillGrid(gridIdX, gridIdY, params, skillType)
	if skillType == SKILLTYPE_RECT then
		return self:getRectSkillGrid(gridIdX, gridIdY, params)
	elseif skillType == SKILLTYPE_CROSS then
		return self:getCrossSkillGrid(gridIdX, gridIdY, params)
	elseif skillType == SKILLTYPE_DIY then
		return self:getDIYSkillGrid(gridIdX, gridIdY, params)
	end
end

function AoQiHeroSkillMgr:getRectSkillGrid(gridIdX, gridIdY, paramsArray)
	local mapSize = AoQiHeroBattleModel.instance:getMapSize()
	local row, col, x, y = checknumber(paramsArray[1]), checknumber(paramsArray[2]), checknumber(paramsArray[3]) - 1, checknumber(paramsArray[4]) - 1
	local gridIds = {}
	local startX, startY = gridIdX - x, gridIdY - y

	for i = 0, row - 1 do
		for j = 0, col - 1 do
			local targetX, targetY = startX + i, startY + j

			if targetX >= 1 and targetX <= mapSize.x and targetY >= 1 and targetY <= mapSize.y then
				local tatgetGridId = AoQiHeroBattleModel.instance:XY2grid(targetX, targetY)

				table.insert(gridIds, tatgetGridId)
			end
		end
	end

	return gridIds
end

function AoQiHeroSkillMgr:getCrossSkillGrid(gridIdX, gridIdY, paramsArray)
	local mapSize = AoQiHeroBattleModel.instance:getMapSize()
	local width, length, crossLength = checknumber(paramsArray[1]), checknumber(paramsArray[2]), checknumber(paramsArray[3])
	local gridIds = {}

	if crossLength == 0 then
		crossLength = length
	end

	if length < 2 * width + 1 then
		length = 2 * width + 1
	end

	local startX, startY = gridIdX - width, gridIdY - length + 1

	for i = 0, 2 * width do
		for j = 0, 2 * length - 2 do
			local targetX, targetY = startX + i, startY + j

			if targetX >= 1 and targetX <= mapSize.x and targetY >= 1 and targetY <= mapSize.y then
				local tatgetGridId = AoQiHeroBattleModel.instance:XY2grid(targetX, targetY)

				table.insert(gridIds, tatgetGridId)
			end
		end
	end

	if length <= width + 1 then
		do return gridIds end

		startY = gridIdY - width
	end

	startX = gridIdX - crossLength + 1

	for i = 0, crossLength - width - 2 do
		for j = 0, 2 * width do
			local targetX, targetY = startX + i, startY + j

			if targetX >= 1 and targetX <= mapSize.x and targetY >= 1 and targetY <= mapSize.y then
				local tatgetGridId = AoQiHeroBattleModel.instance:XY2grid(targetX, targetY)

				table.insert(gridIds, tatgetGridId)
			end
		end
	end

	startY = gridIdY - width
	startX = gridIdX + width + 1

	for i = 0, crossLength - width - 2 do
		for j = 0, 2 * width do
			local targetX, targetY = startX + i, startY + j

			if targetX >= 1 and targetX <= mapSize.x and targetY >= 1 and targetY <= mapSize.y then
				local tatgetGridId = AoQiHeroBattleModel.instance:XY2grid(targetX, targetY)

				table.insert(gridIds, tatgetGridId)
			end
		end
	end

	return gridIds
end

function AoQiHeroSkillMgr:getDIYSkillGrid(gridIdX, gridIdY, paramsArray)
	local mapSize = AoQiHeroBattleModel.instance:getMapSize()
	local count = math.floor(#paramsArray / 2)
	local gridIds = {}

	for i = 0, count - 1 do
		local offsetX, offsetY = checknumber(paramsArray[i * 2 + 1]), checknumber(paramsArray[i * 2 + 2])
		local targetX, targetY = gridIdX + offsetX, gridIdY + offsetY

		if targetX >= 1 and targetX <= mapSize.x and targetY >= 1 and targetY <= mapSize.y then
			local tatgetGridId = AoQiHeroBattleModel.instance:XY2grid(targetX, targetY)

			table.insert(gridIds, tatgetGridId)
		end
	end

	return gridIds
end

function AoQiHeroSkillMgr:getEnergy()
	return self.energy
end

function AoQiHeroSkillMgr:useAllPetEmptyMotion()
	local hasMotion = false
	local myTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)

	for i, v in ipairs(myTeamMo.pos) do
		local petMo = AoQiHeroEntityMgr.instance:getPet(v)

		if petMo.isActive == false then
			AoQiHeroRoundMgr.instance:addRound(nil, AoQiHeroConst.AttackTeam, nil, v)

			hasMotion = true
		end
	end

	return hasMotion
end

function AoQiHeroSkillMgr:usePetSkill(petId, gridIdX, gridIdY, isSuper)
	local mapSize = AoQiHeroBattleModel.instance:getMapSize()

	if gridIdX <= 0 or gridIdX > mapSize.x or gridIdY <= 0 or gridIdY > mapSize.y then
		return {}
	end

	if isSuper == true and (self._energy < self._maxEnergy or AoQiHeroBuffMgr.instance:checkBuffType(petId, AoQiHeroConst.BuffSilence)) then
		return {}
	end

	if AoQiHeroBuffMgr.instance:checkBuffType(petId, AoQiHeroConst.BuffDisarmed) or AoQiHeroBuffMgr.instance:checkBuffType(petId, AoQiHeroConst.BuffDazed) then
		return {}
	end

	local petMo = AoQiHeroEntityMgr.instance:getPet(petId)
	local skillId = isSuper and petMo:getUltSkill() or petMo:getNormalSkill()
	local targetIds, _ = AoQiHeroSkillMgr.instance:getSkillTarget(gridIdX, gridIdY, skillId)
	local isCanUse = false

	if #targetIds > 0 then
		local skillMo = AoQiHeroSkillMo.New()

		skillMo.targetA = petId
		skillMo.targetB = targetIds
		skillMo.configId = skillId

		skillMo:initData()

		skillMo.isSuper = isSuper or false
		skillMo.targetPos = AoQiHeroBattleModel.instance:XY2grid(gridIdX, gridIdY)

		AoQiHeroRoundMgr.instance:addRound(skillMo, AoQiHeroConst.AttackTeam, nil, petId)

		isCanUse = true
	end

	if isSuper == true then
		-- block empty
	end

	return isCanUse
end

function AoQiHeroSkillMgr:useEnemySkill(entityId)
	local targetIds = {
		AoQiHeroConst.TowerEntityId
	}
	local enemyMo = AoQiHeroEntityMgr.instance:getPet(entityId)
	local isSuper = enemyMo:isCanUseSuper() == true and enemyMo:getEnergy() > 0

	if AoQiHeroBuffMgr.instance:checkBuffType(entityId, AoQiHeroConst.BuffSilence) then
		isSuper = false
	end

	local skillId = isSuper and enemyMo:getUltSkill() or enemyMo:getNormalSkill()
	local skillMo = AoQiHeroSkillMo.New()

	skillMo.targetA = entityId
	skillMo.targetB = targetIds
	skillMo.configId = skillId

	skillMo:initData()

	skillMo.isSuper = isSuper

	AoQiHeroRoundMgr.instance:addRound(skillMo, AoQiHeroConst.DefenceTeam, nil, entityId)

	return targetIds
end

function AoQiHeroSkillMgr:doEnemyAction(entityId)
	local enemyMo = AoQiHeroEntityMgr.instance:getPet(entityId)

	if not enemyMo then
		return false
	end

	if AoQiHeroBuffMgr.instance:checkBuffType(entityId, AoQiHeroConst.BuffDazed) then
		return false
	end

	local x, y = AoQiHeroBattleModel.instance:grid2XY(enemyMo.pos)
	local isSuper = enemyMo:isCanUseSuper() == true and enemyMo:getEnergy() > 0
	local skillId = (AoQiHeroBuffMgr.instance:checkBuffType(entityId, AoQiHeroConst.BuffSilence) or nil) and false and enemyMo:getUltSkill() or enemyMo:getNormalSkill()
	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(skillId)
	local range = checknumber(skillCfg.attackParam)

	if range < y then
		if AoQiHeroBuffMgr.instance:checkBuffType(entityId, AoQiHeroConst.BuffSettled) then
			return false
		end

		local width, length = enemyMo.sizeX, enemyMo.sizeY
		local speed = enemyMo.speed

		if speed == 0 then
			return false
		end

		if width == 1 and length == 1 then
			local points = AoQiHeroBattleModel.instance:findPathForSingle(enemyMo.pos, speed, range)

			if points and #points > 0 then
				local moveInfo = {}

				moveInfo.path = points
				moveInfo.step = #points
				moveInfo.target = enemyMo.id

				AoQiHeroRoundMgr.instance:addRound(nil, AoQiHeroConst.DefenceTeam, moveInfo, enemyMo.id)
			else
				return false
			end
		else
			local points = AoQiHeroBattleModel.instance:findPathForSize(enemyMo.pos, width, speed, range)

			if points and #points > 0 then
				local moveInfo = {}

				moveInfo.path = points
				moveInfo.step = #points
				moveInfo.target = enemyMo.id

				AoQiHeroRoundMgr.instance:addRound(nil, AoQiHeroConst.DefenceTeam, moveInfo, enemyMo.id)
			else
				return false
			end
		end
	else
		if AoQiHeroBuffMgr.instance:checkBuffType(entityId, AoQiHeroConst.BuffDisarmed) then
			return false
		end

		self:useEnemySkill(enemyMo.id)
	end

	return true
end

function AoQiHeroSkillMgr:calculateEnemyAction()
	local teamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)
	local entityId

	for i, v in ipairs(teamMo.pos) do
		local entityMo = AoQiHeroEntityMgr.instance:getPet(v)

		if not entityMo.isActive then
			entityId = v

			break
		end
	end

	local hasAction = self:doEnemyAction(entityId)

	if not hasAction and entityId then
		if AoQiHeroEntityMgr.instance:isPetSurvival(entityId) then
			AoQiHeroRoundMgr.instance:addRound(nil, AoQiHeroConst.DefenceTeam, nil, entityId)
		else
			local entityMo = AoQiHeroEntityMgr.instance:getPet(entityId)

			entityMo.isActive = true
		end
	end
end

function AoQiHeroSkillMgr:changeMyTeamEnergy(num)
	self._energy = self._energy + num
	self._energy = math.min(self._energy, self._maxEnergy)
	self._energy = math.max(self._energy, 0)
end

function AoQiHeroSkillMgr:getMyTeamEnergy()
	return self._energy
end

function AoQiHeroSkillMgr:getMaxEnergy()
	return self._maxEnergy
end

AoQiHeroSkillMgr.instance = AoQiHeroSkillMgr.New()

return AoQiHeroSkillMgr
