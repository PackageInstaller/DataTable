-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/model/BeastRichmanModel.lua

module("logic.extensions.beastrichman.model.BeastRichmanModel", package.seeall)

local BeastRichmanModel = class("BeastRichmanModel", BaseModel)

function BeastRichmanModel:ctor()
	return
end

function BeastRichmanModel:onInit()
	self:onReset()
end

function BeastRichmanModel:onReset()
	self._infos = {}
	self._rankInfos = {}
	self._zoneMaps = {}
	self._bossFmtMo = nil
	self._breakFmtMo = nil
	self._collectInfoMap = {}
end

function BeastRichmanModel:handlePM_BeastRichManInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	self._zoneMaps[msg.activityId] = self._zoneMaps[msg.activityId] or {}

	local zoneMap = self._zoneMaps[msg.activityId]

	info.zones = info.zones or {}

	for _, zone in ipairs(info.zones) do
		zoneMap[zone.zoneId] = zone
	end

	info.boss = info.boss or {}
	info.stages = info.stages or {}
	info.supportPetIds = info.supportPetIds or {}
end

function BeastRichmanModel:handlePM_BeastRichManMoveRes(msg)
	local info = self._infos[msg.activityId]
	local zoneMap = self._zoneMaps[msg.activityId]
	local zone = zoneMap and zoneMap[msg.zoneId]

	if zone then
		zone.state = msg.state
	end

	if info then
		info.card = msg.card
	end
end

function BeastRichmanModel:handlePM_BeastRichManHandleGridRes(msg)
	local info = self._infos[msg.activityId]
	local zoneMap = self._zoneMaps[msg.activityId]
	local zone = zoneMap and zoneMap[msg.zoneId]

	if zone then
		zone.state = msg.state
	end

	if info then
		info.card = msg.card
	end
end

function BeastRichmanModel:handlePM_BeastRichManHandleEventRes(msg)
	local info = self._infos[msg.activityId]
	local zoneMap = self._zoneMaps[msg.activityId]
	local zone = zoneMap and zoneMap[msg.zoneId]

	if zone then
		zone.state = msg.state
		zone.items = zone.items or {}

		local hasItem = false

		for _, item in pairs(zone.items) do
			if item.eventId == msg.gridItem.eventId then
				item.eventParam = msg.gridItem.eventParam
				hasItem = true
			end
		end

		if not hasItem then
			table.insert(zone.items, msg.gridItem)
		end
	end

	if info then
		info.card = msg.card
	end
end

function BeastRichmanModel:handlePM_BeastRichManGainHangingRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.hanging = msg.hanging
		info.score = info.score
	end
end

function BeastRichmanModel:handlePM_BeastRichManScoreChangeRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.score = msg.score
	end
end

function BeastRichmanModel:handlePM_BeastRichManUseCardRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.card = msg.card
	end
end

function BeastRichmanModel:getInfo(activityId)
	return self._infos[activityId]
end

function BeastRichmanModel:getZoneMap(activityId)
	return self._zoneMaps[activityId]
end

function BeastRichmanModel:getCardInfo(activityId)
	local info = self:getInfo(activityId)

	return info.card
end

function BeastRichmanModel:getCurManGridId(activityId, zoneId)
	local zoneMap = self._zoneMaps[activityId]

	if zoneMap then
		local manZone = zoneMap[zoneId]

		if manZone then
			if not manZone.state then
				local state = {}

				return (math.max(checknumber(state.curGridId), 1))
			end
		end
	end

	return 1
end

function BeastRichmanModel:onSetRankInfo(activityId, rankType, rankInfoList, myRank)
	self._rankInfos[activityId] = self._rankInfos[activityId] or {}
	self._rankInfos[activityId][rankType] = {
		rankInfoList = rankInfoList,
		myRank = myRank
	}
end

function BeastRichmanModel:getRankInfo(activityId, rankType)
	return self._rankInfos[activityId] and self._rankInfos[activityId][rankType]
end

function BeastRichmanModel:getBossFmtMo()
	self._bossFmtMo = self._bossFmtMo or BeastrichmanBossFmtMo.New()

	return self._bossFmtMo
end

function BeastRichmanModel:getBreakFmtMo()
	self._breakFmtMo = self._breakFmtMo or BeastrichmanBreakFmtMo.New()

	return self._breakFmtMo
end

function BeastRichmanModel:getBossInfo(activityId, bossId)
	local info = self._infos[activityId]

	if info then
		for i, v in pairs(info.boss) do
			if v.bossId == bossId then
				return v
			end
		end
	end

	return nil
end

function BeastRichmanModel:getStageInfo(activityId, bossId)
	local info = self._infos[activityId]

	if info then
		for i, v in pairs(info.stages) do
			if v.bossId == bossId then
				return v
			end
		end
	end

	return nil
end

function BeastRichmanModel:getStageBossInfos(activityId)
	local info = self._infos[activityId]

	if info then
		return info.stages
	end

	return nil
end

function BeastRichmanModel:onFightBeastFinishRes(msg)
	if msg.isWin then
		local activityId = msg.activityId
		local info = self._infos[activityId]

		if info then
			if BeastRichManEnum.BossType.Break == msg.bossType then
				local isHit = false

				for i, v in pairs(info.stages) do
					if v.bossId == msg.bossId then
						v.stageId = msg.stageId
						isHit = true

						break
					end
				end

				if not isHit then
					table.insert(info.stages, {
						bossId = msg.bossId,
						stageId = msg.stageId
					})
				end
			else
				local isHit = false

				for i, v in pairs(info.boss) do
					if v.bossId == msg.bossId then
						v.historyDamage = math.max(checknumber(v.historyDamage), msg.damage)
						isHit = true

						break
					end
				end

				if not isHit then
					table.insert(info.boss, {
						bossId = msg.bossId,
						historyDamage = msg.damage
					})
				end
			end
		end
	end
end

function BeastRichmanModel:onUseCardRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.card = msg.card
	end
end

function BeastRichmanModel:onGainDailyPrizeRes(activityId)
	local info = self._infos[activityId]

	if info then
		info.gainedDailyPrize = true
	end
end

function BeastRichmanModel:getCardNum(activityId, cardId)
	local info = self._infos[activityId]
	local card = info and info.card

	if card then
		local cardIdNNum = card.cardIdNNum

		if cardIdNNum then
			for i, v in ipairs(cardIdNNum) do
				if v.left == cardId then
					return v.right
				end
			end
		end
	end

	return 0
end

function BeastRichmanModel:getScore(activityId)
	local info = self._infos[activityId]

	return checknumber(info.score)
end

function BeastRichmanModel:handleGetPrizeInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._collectInfoMap[activityId] = info
end

function BeastRichmanModel:getCollectInfo(activityId)
	return self._collectInfoMap[activityId]
end

function BeastRichmanModel:handleGetCollectPrize(msg)
	local newInfo = GameUtil.pbToTable(msg)
	local activityId = newInfo.activityId
	local info = self._collectInfoMap[activityId]

	if info then
		if not info.gainedPrizeIds then
			table.insert(info.gainedPrizeIds, newInfo.prizeId)

			info.gainedPrizeIds = info.gainedPrizeIds
		end
	end
end

function BeastRichmanModel:getEventParamByEventId(activityId, zoneId, eventId)
	local zoneMap = self._zoneMaps[activityId]
	local zone = zoneMap and zoneMap[zoneId]

	if zone and zone.items then
		for i, v in pairs(zone.items) do
			if v.eventId == eventId then
				return v.eventParam
			end
		end
	end
end

function BeastRichmanModel:getBookShopAddDataList(activityId, zoneId)
	local addDataList = {}
	local zoneMap = self._zoneMaps[activityId]
	local zone = zoneMap and zoneMap[zoneId]

	if zone and zone.items then
		for i, v in pairs(zone.items) do
			if v.eventId > 0 then
				local eventCfg = BeastRichmanConfig.instance:getEventCfgById(activityId, v.eventId)
				local buildingId = checknumber(eventCfg.eventParam)
				local buildCfg = BeastRichmanConfig.instance:getEventBuildShowCfgByLv(activityId, buildingId, 0)
				local buildType = buildCfg.buildType

				if eventCfg.eventType == BeastRichManEnum.EventType.Build and buildType == BeastRichManEnum.BuildingType.BookShop then
					local addData = {
						id = buildingId,
						level = checknumber(v.eventParam)
					}

					table.insert(addDataList, addData)
				end
			end
		end
	end

	return addDataList
end

function BeastRichmanModel:getSuppurtPetIds(activityId)
	local info = self:getInfo(activityId)

	return info.supportPetIds
end

function BeastRichmanModel:getCardParam(activityId, cardId)
	local info = self:getInfo(activityId)

	if info.card and info.card.cardBuffs then
		for i, v in ipairs(info.card.cardBuffs) do
			if v.cardId == cardId then
				return v.param
			end
		end
	end
end

BeastRichmanModel.instance = BeastRichmanModel.New()

return BeastRichmanModel
