-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/DungeonStarConditionChecker.lua

module("logic.extensions.battle.viewsetting.DungeonStarConditionChecker", package.seeall)

local DungeonStarConditionChecker = {}

DungeonStarConditionChecker.Result = {
	UNFINISHED = 1,
	FAILED = 3,
	FINISHED = 2,
	NONE = 0
}

local kCheckerHandlerTable = {}

function DungeonStarConditionChecker.checkNotifyCondition(dungeonStarCode)
	local result, current, total = DungeonStarConditionChecker.checkCondition(dungeonStarCode)

	if result == DungeonStarConditionChecker.Result.FINISHED then
		local isAbsolutelyFinished = not current or not total

		if not isAbsolutelyFinished then
			return DungeonStarConditionChecker.Result.UNFINISHED
		end
	end

	return result
end

function DungeonStarConditionChecker.checkCondition(dungeonStarCode)
	local dungeonStarCO = DungeonConfig.instance:getDungeonStarByCode(dungeonStarCode)
	local handler = kCheckerHandlerTable[dungeonStarCO.type]

	if handler then
		return handler(dungeonStarCO)
	else
		return DungeonStarConditionChecker.Result.UNFINISHED, 0, 1
	end
end

kCheckerHandlerTable[1] = function(dungeonStarCO)
	local limitDeadCount = checkint(dungeonStarCO.parameter)
	local infoCollector = BattleMgr.instance:getInfoCollector()
	local currentDeadCount = infoCollector:getSelfTotalDeadCount()

	if currentDeadCount <= limitDeadCount then
		return DungeonStarConditionChecker.Result.FINISHED, currentDeadCount, limitDeadCount
	end

	return DungeonStarConditionChecker.Result.FAILED
end
kCheckerHandlerTable[2] = function(dungeonStarCO)
	local limitRound = checkint(dungeonStarCO.parameter)
	local model = BattleMgr.instance:getModel()
	local currentRound = model:getCurrentRound()

	if currentRound <= limitRound then
		return DungeonStarConditionChecker.Result.FINISHED, currentRound, limitRound
	end

	return DungeonStarConditionChecker.Result.FAILED
end
kCheckerHandlerTable[3] = function(dungeonStarCO)
	local infoCollector = BattleMgr.instance:getInfoCollector()

	if infoCollector:hasAnyWeakPointBroken() then
		return DungeonStarConditionChecker.Result.FINISHED
	end

	return DungeonStarConditionChecker.Result.UNFINISHED, 0, 1
end
kCheckerHandlerTable[4] = function(dungeonStarCO)
	local params = string.split(dungeonStarCO.parameter, "#")
	local requireCount = checkint(params[1])
	local requireCampCode = checkint(params[2])
	local model = BattleMgr.instance:getModel()
	local operateCampId = model:getOperateCampId()
	local battleFieldInfo = model:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos
	local currentCount = 0

	for _, entityInfo in pairs(entityInfos) do
		if operateCampId == entityInfo.campId then
			local entityCO = BattleConfigUtil.getEntityConfig(entityInfo.entityCode, entityInfo.entityType)

			if entityCO.camp == requireCampCode then
				currentCount = currentCount + 1
			end
		end
	end

	if model:getPhase() == BattleEnum.Phase.READY then
		if requireCount <= currentCount then
			return DungeonStarConditionChecker.Result.FINISHED, currentCount, requireCount
		end

		return DungeonStarConditionChecker.Result.UNFINISHED, currentCount, requireCount
	end

	if requireCount <= currentCount then
		return DungeonStarConditionChecker.Result.FINISHED
	end

	return DungeonStarConditionChecker.Result.FAILED
end
kCheckerHandlerTable[5] = function(dungeonStarCO)
	local entityCodeList = {}
	local params = string.split(dungeonStarCO.parameter, "#")

	for i, param in ipairs(params) do
		table.insert(entityCodeList, checkint(param))
	end

	for i, entityCode in ipairs(entityCodeList) do
		local isAlive = false
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local units = unitMgr:getAllUnits()

		for _, unit in pairs(units) do
			if BattleCampRelationUtil.isSameOrFriendOfOperateCamp(unit) and unit.property:getEntityCode() == entityCode then
				isAlive = true
			end
		end

		if not isAlive then
			return DungeonStarConditionChecker.Result.FAILED
		end
	end

	return DungeonStarConditionChecker.Result.FINISHED
end
kCheckerHandlerTable[6] = function(dungeonStarCO)
	local entityCode = checkint(dungeonStarCO.parameter)
	local infoCollector = BattleMgr.instance:getInfoCollector()
	local deadCount = infoCollector:getEnemyDeadCountOfEntityCode(entityCode)
	local totalCount = infoCollector:getTotalCountOfEntityCode(entityCode)

	if totalCount <= 0 then
		if BattleLog.enableError then
			BattleLog.error("DungeonStarConditionChecker::cannot find entity in current battle", entityCode)
		end

		return DungeonStarConditionChecker.Result.UNFINISHED, deadCount, 1
	end

	if enableLog then
		printInfo("kCheckerHandlerTable6", entityCode, deadCount, totalCount)
	end

	if totalCount <= deadCount then
		return DungeonStarConditionChecker.Result.FINISHED
	end

	return DungeonStarConditionChecker.Result.UNFINISHED, deadCount, totalCount
end
kCheckerHandlerTable[7] = function(dungeonStarCO)
	local params = string.split(dungeonStarCO.parameter, "#")
	local requireCount = checkint(params[1])
	local requireCareer = checkint(params[2])
	local model = BattleMgr.instance:getModel()
	local operateCampId = model:getOperateCampId()
	local battleFieldInfo = model:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos
	local currentCount = 0

	for _, entityInfo in pairs(entityInfos) do
		if operateCampId == entityInfo.campId then
			local entityCO = BattleConfigUtil.getEntityConfig(entityInfo.entityCode, entityInfo.entityType)

			if entityCO.career == requireCareer then
				currentCount = currentCount + 1
			end
		end
	end

	if model:getPhase() == BattleEnum.Phase.READY then
		if requireCount <= currentCount then
			return DungeonStarConditionChecker.Result.FINISHED, currentCount, requireCount
		end

		return DungeonStarConditionChecker.Result.FAILED, currentCount, requireCount
	end

	if requireCount <= currentCount then
		return DungeonStarConditionChecker.Result.FINISHED
	end

	return DungeonStarConditionChecker.Result.FAILED
end
kCheckerHandlerTable[8] = function(dungeonStarCO)
	local limitDeadCount = checkint(dungeonStarCO.parameter)
	local infoCollector = BattleMgr.instance:getInfoCollector()
	local currentDeadCount = infoCollector:getSelfTotalDeadCount()

	if currentDeadCount <= limitDeadCount then
		return DungeonStarConditionChecker.Result.FINISHED
	end

	return DungeonStarConditionChecker.Result.FAILED
end
kCheckerHandlerTable[9] = function(dungeonStarCO)
	local limitCarrer = checkint(dungeonStarCO.parameter)
	local model = BattleMgr.instance:getModel()
	local operateCampId = model:getOperateCampId()
	local battleFieldInfo = model:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos

	for _, entityInfo in pairs(entityInfos) do
		if operateCampId == entityInfo.campId then
			local entityCO = BattleConfigUtil.getEntityConfig(entityInfo.entityCode, entityInfo.entityType)

			if entityCO.career == limitCarrer then
				return DungeonStarConditionChecker.Result.FAILED
			end
		end
	end

	return DungeonStarConditionChecker.Result.FINISHED
end
kCheckerHandlerTable[10] = function(dungeonStarCO)
	local count = checkint(dungeonStarCO.parameter)
	local infoCollector = BattleMgr.instance:getInfoCollector()
	local deadCount = infoCollector:getEnemyTotalDeadCount()

	if count <= deadCount then
		return DungeonStarConditionChecker.Result.FINISHED
	end

	return DungeonStarConditionChecker.Result.UNFINISHED, deadCount, count
end
kCheckerHandlerTable[11] = function(dungeonStarCO)
	local limitCount = checkint(dungeonStarCO.parameter)
	local model = BattleMgr.instance:getModel()
	local operateCampId = model:getOperateCampId()
	local battleFieldInfo = model:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos
	local count = 0

	for _, entityInfo in pairs(entityInfos) do
		if operateCampId == entityInfo.campId then
			count = count + 1
		end
	end

	if limitCount < count then
		return DungeonStarConditionChecker.Result.FAILED
	else
		return DungeonStarConditionChecker.Result.FINISHED
	end
end
kCheckerHandlerTable[12] = function(dungeonStarCO)
	local params = string.split(dungeonStarCO.parameter, "#")
	local entityCode = checkint(params[1])
	local attrId = checkint(params[2])
	local value = tonumber(params[3])
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnitByEntityCode(entityCode)

	if unit then
		local isFinished = false
		local attrCO = AttributeDefineConfig.instance:getAttributeCO(attrId)

		if attrCO.programming == "CURRENT_HP_RATE" then
			local curValue = unit.property:getHp() / unit.property:getMaxHp()

			if value <= curValue then
				isFinished = true
			end
		elseif attrCO.programming == "LOST_HP_RATE" then
			local curValue = unit.property:getHp() / unit.property:getMaxHp()

			if value <= 1 - curValue then
				isFinished = true
			end
		elseif value <= unit.property:getAttribute(BattleExtension_pb.Attribute[attrCO.programming]) then
			isFinished = true
		end

		if isFinished then
			return DungeonStarConditionChecker.Result.FINISHED
		else
			return DungeonStarConditionChecker.Result.FAILED
		end
	else
		return DungeonStarConditionChecker.Result.FAILED
	end
end
kCheckerHandlerTable[13] = function(dungeonStarCO)
	local params = string.split(dungeonStarCO.parameter, "#")
	local entityCode = checkint(params[1])
	local attrId = checkint(params[2])
	local value = tonumber(params[3])
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnitByEntityCode(entityCode)

	if unit then
		local isFinished = false
		local attrCO = AttributeDefineConfig.instance:getAttributeCO(attrId)

		if attrCO.programming == "CURRENT_HP_RATE" then
			local curValue = unit.property:getHp() / unit.property:getMaxHp()

			if curValue <= value then
				isFinished = true
			end
		elseif attrCO.programming == "LOST_HP_RATE" then
			local curValue = unit.property:getHp() / unit.property:getMaxHp()

			if value >= 1 - curValue then
				isFinished = true
			end
		elseif value >= unit.property:getAttribute(BattleExtension_pb.Attribute[attrCO.programming]) then
			isFinished = true
		end

		if isFinished then
			return DungeonStarConditionChecker.Result.FINISHED
		else
			return DungeonStarConditionChecker.Result.FAILED
		end
	else
		return DungeonStarConditionChecker.Result.FAILED
	end
end
kCheckerHandlerTable[14] = function(dungeonStarCO)
	local limitCount = checkint(dungeonStarCO.parameter)
	local infoCollector = BattleMgr.instance:getInfoCollector()
	local curCount = infoCollector:getEnemyTotalArriveEvacuationCount()

	if curCount <= limitCount then
		return DungeonStarConditionChecker.Result.FINISHED
	else
		return DungeonStarConditionChecker.Result.FAILED
	end
end
kCheckerHandlerTable[15] = function(dungeonStarCO)
	local limitCount = checkint(dungeonStarCO.parameter)
	local infoCollector = BattleMgr.instance:getInfoCollector()
	local curCount = infoCollector:getSameOrFriendTotalArriveEvacuationCount()

	if limitCount <= curCount then
		return DungeonStarConditionChecker.Result.FINISHED
	else
		return DungeonStarConditionChecker.Result.UNFINISHED, curCount, limitCount
	end
end

return DungeonStarConditionChecker
