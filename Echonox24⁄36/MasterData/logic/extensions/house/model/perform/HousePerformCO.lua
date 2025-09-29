-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/perform/HousePerformCO.lua

module("logic.extensions.house.model.perform.HousePerformCO", package.seeall)

local M = class("HousePerformCO")
local PerformEffectType = HouseEnum.PerformEffectType
local PerformCtrlType = HouseEnum.PerformCtrlType
local RoomType = HouseEnum.RoomType
local BehaviorStatus = HouseEnum.BehaviorStatus
local vec3Temp1 = Vector3.New()
local vec3Temp2 = Vector3.New()
local kDelimiterJH = "#"
local kDelimiterFH = ";"
local kDelimiterAND = "&"
local kDelimiterOR = "|"
local kDelimiterZKH = "("
local kDelimiterYKH = ")"

function M:ctor(cfg)
	self._cfg = cfg
	self._statusConditData = nil
	self._performQueue = nil
	self._dictText = nil
	self._effectType = nil
	self._performType = nil
	self._hasActionType = false
	self._heroIdStr = ""
	self._canBreak = false
	self._breakType = 0
	self._breakParams = nil
	self._breakPerformQueue = nil
	self._dictBreakText = nil
	self._isDefault = false

	self:_formatData()
end

function M:getId()
	return self._cfg.id
end

function M:getHeroIds()
	local ids = string.split(self._heroIdStr, kDelimiterJH)
	local id1 = checknumber(ids[1])
	local id2 = checknumber(ids[2])

	return id1, id2
end

function M:getWeight()
	local weights = HouseConfig.instance:getHousePerformWeight()

	return weights[self._cfg.weight] or 1
end

function M:interruptAI()
	if self._hasActionType then
		return true
	end

	return self._cfg.interrupt == 1
end

function M:getEffectType()
	return self._effectType
end

function M:getPerformType()
	return self._performType
end

function M:setDefault(isDefault)
	self._isDefault = isDefault
end

function M:isDefault()
	return self._isDefault
end

function M:getText(key)
	local text = self._dictText[key]

	if string.nilorempty(text) then
		printWarn(string.format("文本%s为空，表演id：%s", key, self._cfg.id))

		return ""
	end

	return text
end

function M:getBreakText(key)
	local text = self._dictBreakText[key]

	if string.nilorempty(text) then
		printWarn(string.format("打断表演文本%s为空，表演id：%s", key, self._cfg.id))

		return ""
	end

	return text
end

function M:getPerformQueueClone()
	return clone(self._performQueue)
end

function M:getBreakPerformQueueClone()
	return clone(self._breakPerformQueue)
end

function M:canBreak()
	return self._canBreak
end

function M:isBreakConditionMatch(unit)
	if self._canBreak and self._breakType == 1 then
		return self:_isMainPlayerBreak(unit)
	end

	return false
end

function M:_isMainPlayerBreak(unit)
	local distance = tonumber(self._breakParams[1])
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.getMainPlayer then
		local mainPlayer = curScene:getMainPlayer()

		if mainPlayer then
			local mainPosX, mainPosY, mainPosZ = mainPlayer.navMesh:getNavMeshGoPos()

			vec3Temp1:Set(mainPosX, mainPosY, 0)

			local unitPosX, unitPosY, unitPosZ = unit.navMesh:getNavMeshGoPos()

			vec3Temp2:Set(unitPosX, unitPosY, 0)

			return distance >= Vector3.Distance(vec3Temp1, vec3Temp2)
		end
	end

	return false
end

function M:isHeroIdsMatch(idStr)
	if self._effectType == PerformEffectType.Custom then
		local id1, id2 = self:getHeroIds()
		local ids = string.split(idStr, kDelimiterJH)
		local targetId1 = checknumber(ids[1])
		local targetId2 = checknumber(ids[2])

		if self._performType == PerformCtrlType.Single then
			return id1 == targetId1
		else
			return id1 == targetId1 and id2 == targetId2
		end
	end

	return true
end

function M:isStatusMatch(unit)
	if string.nilorempty(self._cfg.statusCondition) then
		return true
	end

	local conditions = self._statusConditData.conditions
	local resultStr = self._statusConditData.resultStr

	for _, condition in ipairs(conditions) do
		local isMatch = self:_judgeUnitStatus(unit, condition.arr)
		local subStr = string.gsub(condition.str, "%-", "%%%-")

		subStr = string.gsub(subStr, "%+", "%%%+")
		resultStr = string.gsub(resultStr, subStr, tostring(isMatch))
	end

	local func = loadstring("return " .. resultStr)

	return func()
end

function M:_judgeUnitStatus(unit, statusArray)
	local funcMap = {
		self._judgeMoodStatus,
		self._judgeRoomStatus,
		self._judgeBehaviorStatus,
		self._judgeBuffStatus
	}
	local statusType = tonumber(statusArray[1])
	local func = funcMap[statusType]

	return func(unit, statusArray)
end

function M._judgeMoodStatus(unit, statusArray)
	local targetMoodType = tonumber(statusArray[2])
	local unitMood = ContainmentUtil.getHeroRoomMood(unit.heroId)
	local moodType = HouseWorkerModel.instance:getMoodInterval(unitMood)

	return moodType == targetMoodType
end

function M._judgeRoomStatus(unit, statusArray)
	local roomTypeNumber = tonumber(statusArray[2])
	local targetRoomType = math.floor(roomTypeNumber / 100)
	local targetSubRoomType = math.fmod(roomTypeNumber, 100)
	local roomId = unit.navMesh:getCurZoneId()
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.roomMgr then
		local roomUnit = curScene.roomMgr:getUnitById(roomId)

		if roomUnit then
			local unitRoomType = roomUnit.model:getRoomType()

			if unitRoomType == targetRoomType then
				if targetRoomType == RoomType.Living then
					return roomUnit.model:getLivingType() == targetSubRoomType
				else
					return true
				end
			end
		end
	end

	return false
end

function M._judgeBehaviorStatus(unit, statusArray)
	local behaviorStatusMap = {
		BehaviorStatus.Base,
		BehaviorStatus.Work,
		BehaviorStatus.Eat,
		BehaviorStatus.Sleep,
		BehaviorStatus.Shelter
	}
	local targetBehaviorStatus = behaviorStatusMap[tonumber(statusArray[2])]

	return unit.model:judgeBehaviorStatus(targetBehaviorStatus)
end

function M._judgeBuffStatus(unit, statusArray)
	return false
end

function M:_formatData()
	self:_initBreakCondition()
	self:_initPerformType()
	self:_initStatusCondition()
	self:_initPerformData()
	self:_initTextList()
end

function M:_initPerformType()
	self._heroIdStr = self._cfg.heroIds

	local ids = string.split(self._heroIdStr, kDelimiterJH)
	local id1 = checknumber(ids[1])
	local id2 = checknumber(ids[2])

	if id1 > 0 and id2 > 0 then
		self._heroIdStr = id2 < id1 and string.format("%s%s%s", id2, kDelimiterJH, id1) or string.format("%s%s%s", id1, kDelimiterJH, id2)
	end

	self._performType = self._cfg.peopleNum == 1 and PerformCtrlType.Single or PerformCtrlType.Double
	self._effectType = PerformEffectType.Custom

	if self._performType == PerformCtrlType.Single and id1 == 0 then
		self._effectType = PerformEffectType.Universal
	end

	if self._performType == PerformCtrlType.Double and id2 == 0 then
		self._effectType = PerformEffectType.Universal
	end
end

function M:_initStatusCondition()
	self._statusConditData = {}

	local sourceStr = self._cfg.statusCondition

	if string.nilorempty(sourceStr) then
		return
	end

	local conditions = {}
	local deliArray = {}

	HousePerformUtil.addDelimiterPosToArray(sourceStr, kDelimiterAND, deliArray)
	HousePerformUtil.addDelimiterPosToArray(sourceStr, kDelimiterOR, deliArray)
	HousePerformUtil.addDelimiterPosToArray(sourceStr, kDelimiterZKH, deliArray)
	HousePerformUtil.addDelimiterPosToArray(sourceStr, kDelimiterYKH, deliArray)
	table.insert(deliArray, 1, 0)
	table.insert(deliArray, string.len(sourceStr) + 1)

	for i = 1, #deliArray - 1 do
		local left = deliArray[i] + 1
		local right = deliArray[i + 1] - 1

		if left <= right then
			local conditionStr = string.sub(sourceStr, left, right)
			local condition = {}

			condition.str = conditionStr
			condition.arr = string.split(conditionStr, kDelimiterFH)

			table.insert(conditions, condition)
		end
	end

	self._statusConditData.conditions = conditions

	local resultStr = sourceStr

	resultStr = string.gsub(resultStr, kDelimiterAND, " and ")
	resultStr = string.gsub(resultStr, kDelimiterOR, " or ")
	self._statusConditData.resultStr = resultStr
end

function M:_initPerformData()
	self._performQueue = self:_createPerformQueue(self._cfg.performList)

	if self._canBreak then
		self._breakPerformQueue = self:_createPerformQueue(self._cfg.breakPerformList)
	end
end

function M:_createPerformQueue(performList)
	local performQueue = Queue.create()

	if not string.nilorempty(performList) then
		local performStrList = string.split(performList, kDelimiterOR)

		for _, performStr in ipairs(performStrList) do
			local performs = {}
			local dataStrList = string.split(performStr, kDelimiterAND)

			for _, dataStr in ipairs(dataStrList) do
				local performData = {}

				performData.str = dataStr
				performData.arr = string.split(dataStr, kDelimiterFH)

				local type = tonumber(performData.arr[1])

				if type == 3 then
					self._hasActionType = true
				end

				table.insert(performs, performData)
			end

			performQueue:enqueue(performs)
		end
	end

	return performQueue
end

function M:_initTextList()
	self._dictText = self:_createTextList(self._cfg.textList)

	if self._canBreak then
		self._dictBreakText = self:_createTextList(self._cfg.breakTextList)
	end
end

function M:_createTextList(textCfg)
	local dictText = {}
	local strList = string.split(textCfg, kDelimiterAND)

	for idx, text in ipairs(strList) do
		local key = string.format("text%s", idx)

		dictText[key] = text
	end

	return dictText
end

function M:_initBreakCondition()
	local breakCondiStrList = string.split(self._cfg.breakConditions, kDelimiterOR)

	self._canBreak = tonumber(breakCondiStrList[1]) == 1

	if self._canBreak then
		local breakStrList = string.split(breakCondiStrList[2], kDelimiterFH)

		self._breakType = tonumber(breakStrList[1])
		self._breakParams = string.split(breakStrList[2], kDelimiterJH)
	end
end

return M
