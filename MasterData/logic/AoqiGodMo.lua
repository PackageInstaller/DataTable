-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/data/AoqiGodMo.lua

module("logic.extensions.aoqigod.data.AoqiGodMo", package.seeall)

local AoqiGodMo = class("AoqiGodMo")

function AoqiGodMo:ctor(activityId)
	self._activityId = activityId
	self._actData = AoqiGodConfig.instance:getActData(self._activityId)
	self._clgCfg = AoqiGodConfig.instance:getClgCfg(self._activityId)
	self._dailyHelperTimes = 0
	self._godDailyTimes = self._actData and self._actData.godDailyTimes
	self._godZdl = self._actData.godZdl
	self._totalHelpTimes = 0
	self._score = 0
	self._finishItems = {}
	self._helpItemPool = ObjectPool.New(20, function()
		return AoqiGodHelpItem.New(self._activityId)
	end, function(comp)
		comp:dispose()
	end, function(comp)
		comp:onReset()
	end)
	self._caller = self._helpItemPool:fetchObject()
	self._helper = self._helpItemPool:fetchObject()
	self._finishInfo = nil
	self._wallItemList = {}
	self._searchItemList = {}
	self._activityIdsByType = {}
	self._challengeIdsByCId = {}
	self._challengeIdsByAct = {}

	for _, data in ipairs(self._clgCfg) do
		local challengeId = data.challengeId

		if data.challengeType == 1 then
			local arr = string.split(data.challengeParam, "_")
			local actType, actId = checknumber(arr[1]), checknumber(arr[2])

			self._activityIdsByType[actType] = actId
			self._challengeIdsByAct[actType] = self._challengeIdsByAct[actType] or {}
			self._challengeIdsByAct[actType][actId] = challengeId
		elseif data.challengeType == 2 then
			self._challengeIdsByCId[data.challengeParam] = challengeId
		end
	end
end

function AoqiGodMo:dispose()
	self:_clearItemPool()

	self._rankResMsg = nil
	self._recordResMsg = nil
	self._finishResMsg = nil
end

function AoqiGodMo:getActivityId()
	return self._activityId
end

function AoqiGodMo:handlePM_AoqiGodInfoRes(msg)
	self._dailyHelperTimes = msg.dailyHelperTimes
	self._finishItems = {}

	for _, v in ipairs(msg.finishs) do
		self._finishItems[v.challengeId] = v
	end

	if msg:HasField("caller") then
		self._caller:updateData(msg.caller)
	else
		self._caller:onReset()
	end

	if msg:HasField("helper") then
		self._helper:updateData(msg.helper)
	else
		self._helper:onReset()
	end
end

function AoqiGodMo:handlePM_AoqiGodSeekHelpRes(msg)
	self._caller:updateData(msg.helpItem)
end

function AoqiGodMo:handlePM_AoqiGodSeekHelpWallRes(msg)
	if msg:HasField("caller") then
		self._caller:updateData(msg.caller)
	else
		self._caller:onReset()
	end

	if msg:HasField("helper") then
		self._helper:updateData(msg.helper)
	else
		self._helper:onReset()
	end

	self:_returnHelpItems(self._wallItemList)

	for _, v in ipairs(msg.walls) do
		local comp = self._helpItemPool:fetchObject()

		comp:updateData(v)
		table.insert(self._wallItemList, comp)
	end

	self._totalHelpTimes = msg.totalHelpTimes
end

function AoqiGodMo:handlePM_AoqiGodRefreshHelpWallRes(msg)
	self:_returnHelpItems(self._wallItemList)

	for _, v in ipairs(msg.walls) do
		local comp = self._helpItemPool:fetchObject()

		comp:updateData(v)
		table.insert(self._wallItemList, comp)
	end
end

function AoqiGodMo:handlePM_AoqiGodSearchSeekHelpItemRes(msg)
	self:_returnHelpItems(self._searchItemList)

	for _, v in ipairs(msg.helpItem) do
		local comp = self._helpItemPool:fetchObject()

		comp:updateData(v)
		table.insert(self._searchItemList, comp)
	end
end

function AoqiGodMo:handlePM_AoqiGodGetHelpItemInfoRes(msg)
	return
end

function AoqiGodMo:handlePM_AoqiGodAcceptHelpItemRes(msg)
	self._helper:updateData(msg.helpItem)

	for _, helpItem in ipairs(self._wallItemList) do
		if helpItem:getId() == self._helper:getId() then
			helpItem:setHelperNum(helpItem:getHelperNum() + 1)

			break
		end
	end
end

function AoqiGodMo:handlePM_AoqiGodGiveUpHelpItemRes(msg)
	for _, helpItem in ipairs(self._wallItemList) do
		if helpItem:getId() == self._helper:getId() then
			helpItem:setHelperNum(helpItem:getHelperNum() - 1)

			break
		end
	end

	self._helper:onReset()
end

function AoqiGodMo:handlePM_AoqiGodHelpRecordRes(msg)
	self._recordResMsg = msg
	self._totalHelpTimes = msg.helpTimes
	self._score = msg.totalScore
end

function AoqiGodMo:handlePM_AoqiGodRankRes(msg)
	self._rankResMsg = msg
	self._score = msg.score
end

function AoqiGodMo:handlePM_AoqiGodChallengeRankRes(msg)
	self._petRankResMsg = msg
end

function AoqiGodMo:handlePM_NotifyAoqiGodChallengeFinishRes(msg)
	self._finishResMsg = msg
	self._finishInfo = {}
	self._finishInfo.msg = msg
	self._finishInfo.helpItem = TableUtil.deepcopy(self._helper)

	if msg.success then
		self._dailyHelperTimes = self._dailyHelperTimes + 1
	end
end

function AoqiGodMo:getCaller()
	return self._caller
end

function AoqiGodMo:getHelper()
	return self._helper
end

function AoqiGodMo:getWallItemList()
	return self._wallItemList
end

function AoqiGodMo:getSearchItemList()
	return self._searchItemList
end

function AoqiGodMo:isEnoughZdl()
	local my = RoleModel.instance:getMaxPower()

	return my >= self._godZdl
end

function AoqiGodMo:getZdlLimit()
	return self._godZdl
end

function AoqiGodMo:getTotalHelpTimes()
	return self._totalHelpTimes
end

function AoqiGodMo:getTotalScore()
	return self._score
end

function AoqiGodMo:getDailyHelperTimes()
	return self._dailyHelperTimes
end

function AoqiGodMo:getGodDailyTimes()
	return self._godDailyTimes
end

function AoqiGodMo:getFinishItem(challengeId)
	return self._finishItems[challengeId]
end

function AoqiGodMo:getFinishItems()
	return self._finishItems
end

function AoqiGodMo:getLeftCountOfCallerPublic()
	local cur = self:getFinishCount()

	if not self._caller:isEmpty() then
		cur = cur + 1
	end

	local max = self:getMaxFinishCount()

	return Mathf.Max(0, max - cur)
end

function AoqiGodMo:getLeftCountOfCallerPublicInWeek()
	local cur = self:getFinishCountInWeek()

	if not self._caller:isEmpty() then
		cur = cur + 1
	end

	local max = self:getMaxFinishCountInWeek()

	return Mathf.Max(0, max - cur)
end

function AoqiGodMo:getLeftCountOfCaller()
	local cur = self:getFinishCount()
	local max = self:getMaxFinishCount()

	return max - cur
end

function AoqiGodMo:getLeftCountOfCallerInWeek()
	local cur = self:getFinishCountInWeek()
	local max = self:getMaxFinishCountInWeek()

	return Mathf.Max(max - cur, 0)
end

function AoqiGodMo:getMaxFinishCount()
	return self._actData.totalTimes
end

function AoqiGodMo:getMaxFinishCountInWeek()
	return self._actData.weeklySeekHelpTimes
end

function AoqiGodMo:getFinishCount()
	local count = 0

	for _, v in pairs(self._finishItems) do
		count = count + 1
	end

	return count
end

function AoqiGodMo:getFinishCountInWeek()
	local list = self:getFinishItemsInWeek()

	return #list
end

function AoqiGodMo:getFinishItemsInWeek()
	local startTime, endTime = GameUtil.getStartAndEndInWeek(ServerTime.now())
	local sMillis, eMillis = startTime * 1000, endTime * 1000
	local list = {}

	for _, v in pairs(self._finishItems) do
		if sMillis <= checknumber(v.startTimeMillis) and eMillis >= checknumber(v.finishTimeMillis) then
			table.insert(list, v)
		end
	end

	return list
end

function AoqiGodMo:popFinishResMsg()
	self._finishInfo = nil

	return self._finishInfo
end

function AoqiGodMo:getFinishResMsg()
	return self._finishResMsg
end

function AoqiGodMo:clearFinishResMsg()
	self._finishResMsg = nil
end

function AoqiGodMo:getChallengeIdsByAct(actType, actId)
	return (self._challengeIdsByAct[actType] or nil) and (self._challengeIdsByAct[actType][actId] or 0)
end

function AoqiGodMo:getChallengeIdsByCId(cId)
	return self._challengeIdsByCId[cId] or 0
end

function AoqiGodMo:getActivityIdByType(actType)
	return self._activityIdsByType[actType] or 0
end

function AoqiGodMo:getRankResMsg()
	return self._rankResMsg
end

function AoqiGodMo:getPetRankResMsg()
	return self._petRankResMsg
end

function AoqiGodMo:getRecordResMsg()
	return self._recordResMsg
end

function AoqiGodMo:_returnHelpItems(objList)
	if objList then
		for k, v in pairs(objList) do
			self._helpItemPool:returnObject(v)

			objList[k] = nil
		end
	end
end

function AoqiGodMo:_clearItemPool()
	self:_returnHelpItems(self._wallItemList)
	self:_returnHelpItems(self._searchItemList)
	self._helpItemPool:returnObject(self._caller)
	self._helpItemPool:returnObject(self._helper)
	self._helpItemPool:clear()

	self._helpItemPool = nil
end

function AoqiGodMo:createHelpItem(data)
	if self._helpItemPool then
		local obj = self._helpItemPool:fetchObject()

		obj:updateData(data)

		return obj
	end
end

return AoqiGodMo
