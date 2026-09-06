-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/model/BoneDragonDungeonModel.lua

module("logic.extensions.bonedragondungeon.model.BoneDragonDungeonModel", package.seeall)

local BoneDragonDungeonModel = class("BoneDragonDungeonModel", BaseModel)

function BoneDragonDungeonModel:ctor()
	return
end

function BoneDragonDungeonModel:onInit()
	BoneDragonDungeonModel.super.onInit(self)
	self:onReset()
end

function BoneDragonDungeonModel:onReset()
	BoneDragonDungeonModel.super.onReset(self)

	self._info = {}
	self._progressPrizeMap = {}
	self._rolePos = {}
	self._gameEventFinishMap = {}
	self._buyPetPosMap = {}
	self._railStateMap = {}
	self._switchStateMap = {}
	self._fmtMo = nil
	self._gameInfo = nil
	self._playingStageId = nil
end

function BoneDragonDungeonModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data
	self._progressPrizeMap[data.activityId] = {}

	if data.gainPrizeIds then
		for i, v in ipairs(data.gainPrizeIds) do
			self._progressPrizeMap[data.activityId][v] = true
		end
	end
end

function BoneDragonDungeonModel:savePrize(msg)
	if self._progressPrizeMap[msg.activityId] then
		for i, v in ipairs(msg.prizeIds) do
			self._progressPrizeMap[msg.activityId][v] = true
		end
	end
end

function BoneDragonDungeonModel:isGainProgressPrize(activityId, prizeId)
	if self._progressPrizeMap[activityId] then
		return self._progressPrizeMap[activityId][prizeId]
	end
end

function BoneDragonDungeonModel:getGameTime(activityId)
	if self._info[activityId] then
		return self._info[activityId].todayGameTimes
	end

	return 0
end

function BoneDragonDungeonModel:getCurStageId(activityId)
	if self._info[activityId] then
		return self._info[activityId].curStageId
	end

	return 0
end

function BoneDragonDungeonModel:getCurStagePass(activityId)
	if self._info[activityId] then
		return self._info[activityId].curStagePassed
	end

	return false
end

function BoneDragonDungeonModel:getFmtMo()
	self._fmtMo = self._fmtMo or BoneDragonDungeonClgFmtMo.New()

	return self._fmtMo
end

function BoneDragonDungeonModel:saveGameInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._gameInfo = data

	table.clear(self._rolePos)

	for i, v in ipairs(data.mapInfo.rolePos) do
		self._rolePos[v.roleId] = v
	end

	table.clear(self._gameEventFinishMap)

	if data.mapInfo.finishEventIds then
		for i, v in ipairs(data.mapInfo.finishEventIds) do
			self._gameEventFinishMap[v] = true
		end
	end

	table.clear(self._buyPetPosMap)

	if data.buyPetPosIds then
		for i, v in ipairs(data.buyPetPosIds) do
			self._buyPetPosMap[v] = true
		end
	end

	if self._info[data.activityId] then
		if data.todayGameTimes then
			self._info[data.activityId].todayGameTimes = data.todayGameTimes
		end

		self._info[data.activityId].curStageId = msg.stageId
		self._info[data.activityId].curStagePassed = false
	end

	self._playingStageId = msg.stageId
end

function BoneDragonDungeonModel:saveResetMap(msg)
	local data = GameUtil.pbToTable(msg)

	self._gameInfo.mapInfo = data.mapInfo

	table.clear(self._rolePos)

	for i, v in ipairs(data.mapInfo.rolePos) do
		self._rolePos[v.roleId] = v
	end

	table.clear(self._gameEventFinishMap)

	if data.mapInfo.finishEventIds then
		for i, v in ipairs(data.mapInfo.finishEventIds) do
			self._gameEventFinishMap[v] = true
		end
	end

	self._playingStageId = msg.stageId
end

function BoneDragonDungeonModel:getGameInfo()
	return self._gameInfo
end

function BoneDragonDungeonModel:getBelieverCount()
	return self._gameInfo.believerCount
end

function BoneDragonDungeonModel:clearGameInfo()
	self._gameInfo = nil

	table.clear(self._rolePos)
	table.clear(self._gameEventFinishMap)
end

function BoneDragonDungeonModel:getRolePos()
	return self._rolePos
end

function BoneDragonDungeonModel:isEventFinish(eventId)
	return self._gameEventFinishMap[eventId]
end

function BoneDragonDungeonModel:initRailState(activityId, stageId)
	self._railStateMap = {}

	local stageCfg = BoneDragonDungeonConfig.instance:getStageCfg(activityId, stageId)
	local eventCfgs = BoneDragonDungeonConfig.instance:getEventCfgs(stageCfg.eventPlanId)

	for i, v in ipairs(eventCfgs) do
		if v.eventType == "rail" then
			self._railStateMap[v.eventId] = v.eventParam == "open"
		end
	end
end

function BoneDragonDungeonModel:isRailOpen(eventId)
	if self._railStateMap[eventId] ~= nil then
		return self._railStateMap[eventId]
	else
		return true
	end
end

function BoneDragonDungeonModel:switchRailState(eventId)
	if self._railStateMap[eventId] ~= nil then
		self._railStateMap[eventId] = not self._railStateMap[eventId]
	end
end

function BoneDragonDungeonModel:getRailStateMap()
	return self._railStateMap
end

function BoneDragonDungeonModel:initSwitchState(activityId, stageId)
	self._switchStateMap = {}

	local stageCfg = BoneDragonDungeonConfig.instance:getStageCfg(activityId, stageId)
	local eventCfgs = BoneDragonDungeonConfig.instance:getEventCfgs(stageCfg.eventPlanId)

	for i, v in ipairs(eventCfgs) do
		if v.eventType == "switchCtrl" then
			local railEventIds = string.split(v.eventParam, ",")
			local checkRailEventCfg = BoneDragonDungeonConfig.instance:getEventCfg(stageCfg.eventPlanId, checknumber(railEventIds[1]))

			self._switchStateMap[v.eventId] = checkRailEventCfg.eventParam == "open"
		end
	end
end

function BoneDragonDungeonModel:isSwitchOpen(eventId)
	if self._switchStateMap[eventId] ~= nil then
		return self._switchStateMap[eventId]
	else
		return true
	end
end

function BoneDragonDungeonModel:switchSwitchState(eventId)
	if self._switchStateMap[eventId] ~= nil then
		self._switchStateMap[eventId] = not self._switchStateMap[eventId]
	end
end

function BoneDragonDungeonModel:getSwitchStateMap()
	return self._switchStateMap
end

function BoneDragonDungeonModel:saveMoveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	for i, v in ipairs(data.rolePos) do
		self._rolePos[v.roleId] = v
	end

	if data.mapInfo then
		table.clear(self._rolePos)

		for i, v in ipairs(data.mapInfo.rolePos) do
			self._rolePos[v.roleId] = v
		end

		table.clear(self._gameEventFinishMap)

		if data.mapInfo.finishEventIds then
			for i, v in ipairs(data.mapInfo.finishEventIds) do
				self._gameEventFinishMap[v] = true
			end
		end
	end

	if data.todayGameTimes and self._info[data.activityId] then
		self._info[data.activityId].todayGameTimes = data.todayGameTimes
	end

	if data.finishStage == true and self._info[data.activityId] then
		if data.nextStageId then
			self._info[data.activityId].curStageId = data.nextStageId
			self._info[data.activityId].curStagePassed = false
			self._playingStageId = data.nextStageId
		else
			self._info[data.activityId].curStageId = data.stageId
			self._info[data.activityId].curStagePassed = true
		end
	end
end

function BoneDragonDungeonModel:saveBuyPet(msg)
	self._buyPetPosMap[msg.petPosId] = true
end

function BoneDragonDungeonModel:isPetBuy(shopPosId)
	return self._buyPetPosMap[shopPosId] or false
end

function BoneDragonDungeonModel:getBuyPets()
	local result = {}

	for k, v in pairs(self._buyPetPosMap) do
		table.insert(result, k)
	end

	return result
end

function BoneDragonDungeonModel:saveHandlerEvent(msg)
	self._gameEventFinishMap[msg.eventId] = true

	if checknumber(msg.believerCount) ~= 0 then
		self._gameInfo.believerCount = msg.believerCount
	end
end

function BoneDragonDungeonModel:saveBattleEvent(msg)
	self._gameEventFinishMap[msg.eventId] = true
end

function BoneDragonDungeonModel:savePlayingStageId(stageId)
	self._playingStageId = stageId
end

function BoneDragonDungeonModel:getPlayingStageId()
	return self._playingStageId
end

BoneDragonDungeonModel.instance = BoneDragonDungeonModel.New()

return BoneDragonDungeonModel
