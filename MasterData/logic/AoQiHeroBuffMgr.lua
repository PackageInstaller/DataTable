-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/controller/battlemgr/AoQiHeroBuffMgr.lua

module("logic.extensions.aoqihero.controller.battlemgr.AoQiHeroBuffMgr", package.seeall)

local AoQiHeroBuffMgr = class("AoQiHeroBuffMgr")

function AoQiHeroBuffMgr:ctor()
	self._buffMap = {}
	self._buffIndex = 1
	self._buffPool = {}
	self._buffTimeMap = {}
end

function AoQiHeroBuffMgr:initData(activityId)
	self._buffMap = {}
	self._buffTimeMap = {}
	self._buffPool = {}
	self._activityId = activityId
	self._buffIndex = 1
end

function AoQiHeroBuffMgr:getBuff(buffId)
	return self._buffMap[buffId]
end

function AoQiHeroBuffMgr:getPetBuffMos(petId)
	local petMo = AoQiHeroEntityMgr.instance:getPet(petId)
	local list = {}

	for i, v in ipairs(petMo.buffList) do
		local buffMo = self:getBuff(v)

		table.insert(list, buffMo)
	end

	return list
end

function AoQiHeroBuffMgr:addBuff(petId, buffMo, agent)
	local petMo = AoQiHeroEntityMgr.instance:getPet(petId)

	buffMo:initDataOnAdd(petId, agent, self._buffIndex)

	self._buffMap[self._buffIndex] = buffMo
	self._buffTimeMap[buffMo.buffCfg.activeTime] = self._buffTimeMap[buffMo.buffCfg.activeTime] or {}
	self._buffTimeMap[buffMo.buffCfg.activeTime][self._buffIndex] = buffMo.buffId

	buffMo:onAddBuffBefore()
	petMo:addBuff(self._buffIndex)
	buffMo:onAddBuff()

	self._buffIndex = self._buffIndex + 1
end

function AoQiHeroBuffMgr:createBuffMo(buffCfg)
	local buffMo

	local function resetFunc()
		return
	end

	local function disposeFunc()
		return
	end

	self._buffPool[buffCfg.buffClazz] = self._buffPool[buffCfg.buffClazz] or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	if self._buffPool[buffCfg.buffClazz] then
		buffMo = self._buffPool[buffCfg.buffClazz]:fetchObject()
	end

	if not buffMo then
		if buffCfg.buffClazz == AoQiHeroConst.BuffPropertyChange then
			buffMo = AoQiHeroPropertyBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffAttackRate then
			buffMo = AoQiHeroAttackRateBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffDefendRate then
			buffMo = AoQiHeroDefendRateBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffHpChange then
			buffMo = AoQiHeroHpChangeBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffHpChangeAtk then
			buffMo = AoQiHeroHpChangeAtkBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffEnergyChange then
			buffMo = AoQiHeroEnergyChangeBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffDazed then
			buffMo = AoQiHeroDazedBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffSettled then
			buffMo = AoQiHeroSettledBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffDisarmed then
			buffMo = AoQiHeroDisarmedBuffMo.New()
		elseif buffCfg.buffClazz == AoQiHeroConst.BuffSilence then
			buffMo = AoQiHeroSilenceBuffMo.New()
		end
	end

	if buffMo then
		buffMo:initDataByCfg(buffCfg)
	end

	return buffMo
end

function AoQiHeroBuffMgr:activeBuff(activeTime, targetA, targetB)
	local reportMos = {}
	local buffAddList = {}
	local clearBuffList = {}

	if self._buffTimeMap[activeTime] then
		local buffBuffMap = self._buffTimeMap[activeTime]

		for k, buffId in pairs(buffBuffMap) do
			local buffMo = self:getBuff(buffId)

			if buffMo then
				if AoQiHeroEntityMgr.instance:isPetSurvival(buffMo.targetId) then
					buffMo:onActive(targetA, targetB, reportMos, buffAddList)

					if buffMo.tier <= 0 then
						table.insert(clearBuffList, buffMo.buffId)
					end
				end
			else
				buffBuffMap[k] = nil
			end
		end
	end

	for i, buffId in ipairs(clearBuffList) do
		self:clearBuff(buffId, reportMos)
	end

	for i, buffId in ipairs(buffAddList) do
		local buffCfg = AoQiHeroConfig.instance:getSkillAffixCfg(buffId)
		local targetList = self:getAddBuffTarget(targetA, targetB, buffCfg.buffType)

		for j, v in ipairs(targetList) do
			local buffMo = self:createBuffMo(buffCfg)

			self:addBuff(v, buffMo, targetA)
		end
	end

	return reportMos
end

function AoQiHeroBuffMgr:clearBuff(buffId, reportMos)
	local buffMo = self._buffMap[buffId]

	if buffMo.isChangeHp == true then
		local petMo = AoQiHeroEntityMgr.instance:getPet(buffMo.targetId)
		local beforeCurHp = petMo.curHp
		local beforeMaxHp = petMo:getMaxHp()

		buffMo:onRemoveBefore()
		buffMo:onRemoveBuffOnPet()
		buffMo:onRemoveBuff()

		local changeHp = petMo.curHp - beforeCurHp

		if changeHp ~= 0 then
			local reportMo = reportMos[buffMo.targetId]

			if not reportMo then
				reportMo = AoQiHeroRoundMgr.instance:getNewReportMo()
				reportMo.petId = buffMo.targetId
				reportMos[reportMo.petId] = reportMo
			end

			local buffInfo = {
				buffId = buffId,
				changeHp = petMo.curHp - beforeCurHp,
				afterChangeHp = petMo.curHp,
				changeMaxHp = petMo:getMaxHp() - beforeMaxHp,
				afterChangeMaxHp = petMo:getMaxHp()
			}

			table.insert(reportMo.effectHpBuffIds, buffInfo)
		end
	else
		buffMo:onRemoveBefore()
		buffMo:onRemoveBuffOnPet()
		buffMo:onRemoveBuff()
	end

	self._buffPool[buffMo.buffType]:returnObject(buffMo)

	self._buffMap[buffMo.buffId] = nil

	for i, v in pairs(self._buffTimeMap) do
		self._buffTimeMap[i][buffMo.buffId] = nil
	end
end

function AoQiHeroBuffMgr:removeBuffOnPet(buffId, petId)
	local petMo = AoQiHeroEntityMgr.instance:getPet(petId)

	petMo:removeBuff(buffId)
end

function AoQiHeroBuffMgr:getAddBuffTarget(targetA, targetB, targetDesc)
	local targetATeamType, targetBTeamType = AoQiHeroEntityMgr.instance:getSelfTeamAndEnemyTeam(targetA)
	local params = string.split(targetDesc, "-")
	local targetList = {}

	if params[1] == AoQiHeroConst.TargetTeamMy then
		local teamMo = AoQiHeroEntityMgr.instance:getTeamMo(targetATeamType)

		if params[2] == AoQiHeroConst.TargetRangeSingle then
			table.insert(targetList, targetA)
		elseif params[2] == AoQiHeroConst.TargetRangeAll then
			for j, v in ipairs(teamMo.pos) do
				if AoQiHeroEntityMgr.instance:isPetSurvival(v) then
					table.insert(targetList, v)
				end
			end
		elseif params[2] == AoQiHeroConst.TargetPos then
			local pos = checknumber(params[3])

			if teamMo.teamId == AoQiHeroConst.AttackTeam then
				for j, v in ipairs(teamMo.pos) do
					local petMo = AoQiHeroEntityMgr.instance:getPet(v)

					if AoQiHeroEntityMgr.instance:isPetSurvival(v) and petMo.pos == pos then
						table.insert(targetList, v)
					end
				end
			end
		elseif params[2] == AoQiHeroConst.TargetType then
			local type = checknumber(params[3])

			for j, v in pairs(teamMo.pos) do
				local entityMo = AoQiHeroEntityMgr.instance:getPet(v)
				local petCfg = AoQiHeroConfig.instance:getPetCfg(entityMo.activityId, entityMo.configId)

				if AoQiHeroEntityMgr.instance:isPetSurvival(v) and petCfg.elementId == type then
					table.insert(targetList, v)
				end
			end
		end
	elseif params[1] == AoQiHeroConst.TargetTeamEnemy then
		local teamMo = AoQiHeroEntityMgr.instance:getTeamMo(targetBTeamType)

		if params[2] == AoQiHeroConst.TargetRangeSingle then
			targetList = targetB or {}
		elseif params[2] == AoQiHeroConst.TargetRangeAll then
			for j, v in ipairs(teamMo.pos) do
				if AoQiHeroEntityMgr.instance:isPetSurvival(v) then
					table.insert(targetList, v)
				end
			end
		elseif params[2] == AoQiHeroConst.TargetPos then
			local pos = checknumber(params[3])

			if teamMo.teamId == AoQiHeroConst.AttackTeam then
				for j, v in ipairs(teamMo.pos) do
					local petMo = AoQiHeroEntityMgr.instance:getPet(v)

					if AoQiHeroEntityMgr.instance:isPetSurvival(v) and petMo.pos == pos then
						table.insert(targetList, v)
					end
				end
			end
		elseif params[2] == AoQiHeroConst.TargetType then
			local type = checknumber(params[3])

			for j, v in pairs(teamMo.pos) do
				local entityMo = AoQiHeroEntityMgr.instance:getPet(v)
				local petCfg = AoQiHeroConfig.instance:getPetCfg(entityMo.activityId, entityMo.configId)

				if AoQiHeroEntityMgr.instance:isPetSurvival(v) and petCfg.elementId == type then
					table.insert(targetList, v)
				end
			end
		end
	end

	return targetList
end

function AoQiHeroBuffMgr:changeAllBuffTime(time)
	local reduceTime = time or 1
	local clearBuffList = {}

	for i, buffMo in pairs(self._buffMap) do
		if AoQiHeroEntityMgr.instance:isPetSurvival(buffMo.targetId) then
			buffMo.time = math.max(buffMo.time - reduceTime, 0)

			if buffMo.time <= 0 then
				table.insert(clearBuffList, buffMo.buffId)
			end
		end
	end

	local changeReportMos = {}

	for i, buffId in ipairs(clearBuffList) do
		self:clearBuff(buffId, changeReportMos)
	end

	return changeReportMos
end

function AoQiHeroBuffMgr:checkBuffType(entityId, buffType)
	local entityMo = AoQiHeroEntityMgr.instance:getPet(entityId)

	for i, v in ipairs(entityMo.buffList) do
		local buffMo = self._buffMap[v]

		if buffMo and buffMo.buffType == buffType then
			return true
		end
	end

	return false
end

function AoQiHeroBuffMgr:resetAllBuff()
	for k, v in pairs(self._buffMap) do
		self:clearBuff(k)
	end
end

AoQiHeroBuffMgr.instance = AoQiHeroBuffMgr.New()

return AoQiHeroBuffMgr
