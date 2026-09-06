-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/controller/BeastRichmanController.lua

module("logic.extensions.beastrichman.controller.BeastRichmanController", package.seeall)

local BeastRichmanController = class("BeastRichmanController", BaseController)

function BeastRichmanController:ctor()
	return
end

function BeastRichmanController:onInit()
	self:onReset()
end

function BeastRichmanController:onReset()
	self._scoreList = {}
	self._needAutoPop = true
	self._changeSetIdList = {}
	self._skipDiceAnim = false
end

function BeastRichmanController:getCurScore()
	return self._scoreList
end

function BeastRichmanController:setCurScore(score)
	table.insert(self._scoreList, score)
end

function BeastRichmanController:getNeedAutoPop()
	return self._needAutoPop
end

function BeastRichmanController:setNeedAutoPop(needAutoPop)
	self._needAutoPop = needAutoPop
end

function BeastRichmanController:sendPM_BeastRichManInfoReq(activityId)
	BeastRichmanAgent.instance:sendPM_BeastRichManInfoReq(activityId)
end

function BeastRichmanController:handlePM_BeastRichManInfoRes(msg)
	BeastRichmanModel.instance:handlePM_BeastRichManInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BeastRichManInfoRes)
end

function BeastRichmanController:sendPM_BeastRichManMoveReq(activityId, zoneId, diceType, param)
	BeastRichmanAgent.instance:sendPM_BeastRichManMoveReq(activityId, zoneId, diceType, param)
end

function BeastRichmanController:handlePM_BeastRichManMoveRes(msg)
	BeastRichmanModel.instance:handlePM_BeastRichManMoveRes(msg)

	if msg.changeSetId then
		self:setCurChangeSetId(msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.BeastRichManMoveRes, msg)
end

function BeastRichmanController:sendPM_BeastRichManHandleGridReq(activityId, zoneId, gridId, param)
	BeastRichmanAgent.instance:sendPM_BeastRichManHandleGridReq(activityId, zoneId, gridId, param)
end

function BeastRichmanController:handlePM_BeastRichManHandleGridRes(msg)
	BeastRichmanModel.instance:handlePM_BeastRichManHandleGridRes(msg)

	if not msg.moveGridLoad then
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManHandleGridRes)
		self:_autoShowGainGridPrize(msg)
	end
end

function BeastRichmanController:sendPM_BeastRichManGainHangingReq(activityId)
	BeastRichmanAgent.instance:sendPM_BeastRichManGainHangingReq(activityId)
end

function BeastRichmanController:handlePM_BeastRichManGainHangingRes(msg)
	BeastRichmanModel.instance:handlePM_BeastRichManGainHangingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BeastRichManGainHangingRes, msg.addScore)
end

function BeastRichmanController:_autoShowGainGridPrize(msg)
	local activityId = msg.activityId
	local zoneId = msg.zoneId
	local gridId = msg.gridId
	local gridCfg = BeastRichmanConfig.instance:getGridCfg(activityId, zoneId, gridId)
	local gridType = gridCfg.gridType

	if gridType == BeastRichManEnum.CellType.StorySelect or gridType == BeastRichManEnum.CellType.StoryPlay then
		local storyId = checknumber(gridCfg.gridParam)
		local param = msg.param
		local storyCfg = BeastRichmanConfig.instance:getStoryCfgById(activityId, storyId)
		local selectionId = 1

		if storyCfg.type == BeastRichManEnum.StoryType.Select then
			selectionId = checknumber(param)
		end

		if selectionId <= 0 then
			FloatWordMgr.instance:show("您已放弃本次选择")
		else
			local selectionCfg = BeastRichmanConfig.instance:getGridStoryCfgsBySelectionId(activityId, storyId, selectionId)

			FloatWordMgr.instance:show(string.format("恭喜您获得%s收益", selectionCfg.score))
		end
	end
end

function BeastRichmanController:sendPM_BeastRichManHandleEventReq(activityId, zoneId, gridId, param)
	BeastRichmanAgent.instance:sendPM_BeastRichManHandleEventReq(activityId, zoneId, gridId, param)
end

function BeastRichmanController:handlePM_BeastRichManHandleEventRes(msg)
	BeastRichmanModel.instance:handlePM_BeastRichManHandleEventRes(msg)

	local resultParam = msg.resultParam
	local eventType = BeastRichmanConfig.instance:getEventTypeByGridId(msg.activityId, msg.zoneId, msg.gridId)

	if eventType == BeastRichManEnum.EventType.Wheel then
		BeastRichmanController.instance:setCurChangeSetId(msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.BeastRichManHandleEventRes, resultParam)
end

function BeastRichmanController:handlePM_BeastRichManScoreChangeRes(msg)
	BeastRichmanModel.instance:handlePM_BeastRichManScoreChangeRes(msg)

	if msg.changeValue > 0 then
		BeastRichmanController.instance:setCurScore(msg.changeValue)
	end

	GlobalDispatcher:dispatch(GlobalNotify.BeastRichManScoreChangeRes)
end

function BeastRichmanController:getCurChangeSetId()
	return table.remove(self._changeSetIdList)
end

function BeastRichmanController:setCurChangeSetId(changeSetId)
	table.insert(self._changeSetIdList, changeSetId)
end

function BeastRichmanController:isPathCell(cellType)
	return cellType >= BeastRichManEnum.CellType.Benefit
end

function BeastRichmanController:curPathCellHasFinish(activityId, zoneId)
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)

	if zoneMap then
		local zone = zoneMap[zoneId]
		local state = zone and zone.state
		local grid = state and state.grid

		if grid then
			if not grid.finish then
				return false
			end
		end
	end

	return false
end

function BeastRichmanController:curEventHasFinish(activityId, zoneId)
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)

	if zoneMap then
		local zone = zoneMap[zoneId]
		local event = zone and zone.state.event

		if event then
			if not event.finish then
				return false
			end
		end
	end

	return false
end

function BeastRichmanController:curGridParam(activityId, zoneId)
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)

	if zoneMap then
		local zone = zoneMap[zoneId]
		local state = zone.state

		if state then
			if not state.grid then
				local grid = {}

				return grid and grid.param
			end
		end
	end
end

function BeastRichmanController:curGridCfgParam(activityId, zoneId, gridId)
	local gridCfg = BeastRichmanConfig.instance:getGridCfgById(activityId, zoneId, gridId)

	return gridCfg and gridCfg.gridParam
end

function BeastRichmanController:getCurEvent(activityId, zoneId)
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)

	if zoneMap then
		local zone = zoneMap[zoneId]
		local state = zone.state

		if state then
			if not state.event then
				return {}
			end
		end
	end
end

function BeastRichmanController:getMapDataList()
	return
end

function BeastRichmanController:getWheelHasFinish(activityId, zoneId, gridId, wheelId)
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)
	local zone = zoneMap and zoneMap[zoneId]
	local items = zone and zone.items
	local wheelCfgs = BeastRichmanConfig.instance:getLotteryCfgsById(activityId, wheelId)

	if items then
		for i, v in pairs(items) do
			if v.gridId == gridId then
				local dataTb = GameUtil.jsonToTable(v.eventParam)
				local round = dataTb.round
				local lotteryCfg = BeastRichmanConfig.instance:getLotteryCfgsById(activityId, wheelId)
				local roundNum = #lotteryCfg

				if roundNum <= round then
					do
						local prizeCfgs = BeastRichmanConfig.instance:getLotteryPrizeCfgsByRound(activityId, wheelId, round)
						local totalPrizeNum = #prizeCfgs

						if not dataTb.getPrizes then
							local getPrizes = {}
							local curGetPrizeNum = #getPrizes

							return totalPrizeNum <= curGetPrizeNum
						end
					end

					break
				end

				do return false end

				break
			end
		end
	end

	return false
end

function BeastRichmanController:getWheelCurRound(activityId, zoneId, eventId, wheelId)
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)
	local zone = zoneMap and zoneMap[zoneId]
	local items = zone and zone.items

	if items then
		for i, v in pairs(items) do
			if v.eventId == eventId then
				local dataTb = GameUtil.jsonToTable(v.eventParam)

				return checknumber(dataTb.round)
			end
		end
	end

	return 1
end

function BeastRichmanController:getWheelCurPrizeHasGain(activityId, zoneId, gridId, wheelId, curRound, prizeId)
	local poolInfoMap = self:getWheelPoolInfoMap(activityId, zoneId)

	if poolInfoMap and poolInfoMap[wheelId] then
		local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)
		local zone = zoneMap and zoneMap[zoneId]
		local items = zone and zone.items

		if items then
			for i, v in pairs(items) do
				if v.gridId == gridId then
					local dataTb = GameUtil.jsonToTable(v.eventParam)
					local round = dataTb.round
					local lotteryCfg = BeastRichmanConfig.instance:getLotteryCfgsById(activityId, wheelId)

					if round == curRound then
						local prizeCfgs = BeastRichmanConfig.instance:getLotteryPrizeCfgsByRound(activityId, wheelId, round)

						if not dataTb.prizes then
							return table.indexof(dataTb.prizes, prizeId)
						end
					else
						return curRound < round
					end
				end
			end
		end
	end

	return false
end

function BeastRichmanController:getWheelCurPoolHasComplete(activityId, zoneId, gridId, wheelId)
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)
	local zone = zoneMap and zoneMap[zoneId]
	local items = zone and zone.items
	local lotteryCfgs = BeastRichmanConfig.instance:getLotteryCfgsById(activityId, wheelId)
	local lotteryRoundNum = #lotteryCfgs

	if items then
		for i, v in pairs(items) do
			if v.gridId == gridId then
				local dataTb = GameUtil.jsonToTable(v.eventParam)
				local round = dataTb.round

				if lotteryRoundNum <= round then
					local prizeCfgs = BeastRichmanConfig.instance:getLotteryPrizeCfgsByRound(activityId, wheelId, round)
					local totalPrizeNum = #prizeCfgs

					if not dataTb.getPrizes then
						local getPrizes = {}
						local curGetPrizeNum = #getPrizes

						return totalPrizeNum <= curGetPrizeNum
					end
				else
					return false
				end
			end
		end
	end

	return false
end

function BeastRichmanController:getWheelPoolInfoMap(activityId, zoneId)
	local poolInfoMap = {}
	local zoneMap = BeastRichmanModel.instance:getZoneMap(activityId)
	local zone = zoneMap and zoneMap[zoneId]
	local items = zone and zone.items

	if items then
		for i, gridItem in pairs(items) do
			local eventId = gridItem.eventId
			local eventCfg = BeastRichmanConfig.instance:getEventCfgById(activityId, eventId)
			local eventType = eventCfg.eventType
			local dataTb = GameUtil.jsonToTable(gridItem.eventParam)

			if eventType == BeastRichManEnum.EventType.Wheel then
				local gridId = BeastRichmanConfig.instance:getGridIdByEventId(activityId, zoneId, eventId)
				local gridCfg = BeastRichmanConfig.instance:getGridCfgById(activityId, zoneId, gridId)
				local eventId = gridCfg.eventId
				local eventCfg = BeastRichmanConfig.instance:getEventCfgById(activityId, eventId)
				local eventParam = eventCfg.eventParam
				local wheelId = checknumber(eventParam)

				poolInfoMap[wheelId] = poolInfoMap[wheelId] or {}

				local poolInfoList = poolInfoMap[wheelId]

				if wheelId > 0 then
					local prizes = dataTb.prizes

					if prizes then
						for _, prize in pairs(prizes) do
							table.insert(poolInfoList, prize)
						end
					end
				end
			end
		end
	end

	return poolInfoMap
end

function BeastRichmanController:getWheelPoolList(activityId, zoneId)
	local eventPoolList = {}
	local gridCfgs = BeastRichmanConfig.instance:getGridCfgs(activityId, zoneId)
	local wheelPoolMap = {}

	if gridCfgs then
		for i, cfg in ipairs(gridCfgs) do
			local eventId = cfg.eventId

			if eventId > 0 then
				local eventType = BeastRichmanConfig.instance:getEventTypeByGridId(activityId, zoneId, cfg.gridId)

				if eventType == BeastRichManEnum.EventType.Wheel then
					local eventCfg = BeastRichmanConfig.instance:getEventCfgById(activityId, eventId)
					local wheelPoolId = checknumber(eventCfg.eventParam)
					local wheel = wheelPoolMap[wheelPoolId]

					if wheel == nil and wheelPoolId > 0 then
						wheelPoolMap[wheelPoolId] = wheelPoolId

						table.insert(eventPoolList, {
							wheelPoolId = wheelPoolId,
							gridId = cfg.gridId
						})
					end
				end
			end
		end
	end

	return eventPoolList
end

function BeastRichmanController:getPrizeScore(activityId, zoneId, gridId, score)
	local gridCfg = BeastRichmanConfig.instance:getGridCfgById(activityId, zoneId, gridId)
	local gameId = checknumber(gridCfg.gridParam)
	local curScore = 0

	if gameId > 0 then
		local gamePrizeCfgs = BeastRichmanConfig.instance:getGridGamePrizeCfgsById(activityId, gameId)
		local values = table.values(gamePrizeCfgs)

		table.sort(values, function(a, b)
			return a.score < b.score
		end)

		if score > values[#values].score then
			curScore = values[#values].prize
		else
			for i = 1, #values - 1 do
				local nextCfg = values[i + 1]

				if score >= values[i].score and score < nextCfg.score then
					curScore = values[i].prize
				end
			end
		end
	end

	return curScore
end

function BeastRichmanController:getHangingTotalPrize(activityId, zoneId)
	local cycle = BeastRichmanConfig.instance:getBossCycle(activityId)
	local info = BeastRichmanModel.instance:getInfo(activityId)
	local hangingInfo = info.hanging
	local lastSettleTimeMillis = checknumber(hangingInfo.lastSettleTimeMillis)
	local lastSettleTime = math.ceil(lastSettleTimeMillis / 1000)
	local curTime = ServerTime.now()
	local diffTime = curTime - lastSettleTime
	local cycleTime = cycle
	local totalPrize = 0
	local totalPrePrize = self:getBossEachHangingPrize(activityId, zoneId)

	totalPrize = totalPrePrize * ((cycleTime > 0 or nil) and math.floor(diffTime / cycleTime)) + hangingInfo.extAccumulate

	local actCfg = BeastRichmanConfig.instance:getActCfg(activityId)

	totalPrize = math.min(actCfg.storageLimit, totalPrize)

	return totalPrize
end

function BeastRichmanController:getBossEachHangingPrize(activityId, zoneId)
	local info = BeastRichmanModel.instance:getInfo(activityId)
	local bossInfos = info.boss
	local stageBossInfos = info.stages
	local totalPrePrize = 0

	if bossInfos then
		for i, v in pairs(bossInfos) do
			local bossId = v.bossId
			local historyDamage = checknumber(v.historyDamage)

			totalPrePrize = totalPrePrize + ((historyDamage > 0 or nil) and BeastRichmanConfig.instance:getBossDamageHangingPrizeByDamage(activityId, bossId, historyDamage))
		end
	end

	if stageBossInfos then
		for i, v in ipairs(stageBossInfos) do
			local bossId = v.bossId
			local stageId = v.stageId
			local bossPrize = BeastRichmanConfig.instance:getStageBossHangingPrizeByStageId(activityId, bossId, stageId)

			totalPrePrize = totalPrePrize + bossPrize
		end
	end

	return totalPrePrize
end

function BeastRichmanController:getIsSkipDiceAnim()
	return self._skipDiceAnim
end

function BeastRichmanController:setIsSkipDiceAnim(skipDiceAnim)
	self._skipDiceAnim = skipDiceAnim
end

function BeastRichmanController:curGridHasShop(activityId, zoneId, gridId)
	local gridCfg = BeastRichmanConfig.instance:getGridCfgById(activityId, zoneId, gridId)
	local eventId = gridCfg.eventId
	local eventCfg = BeastRichmanConfig.instance:getEventCfgById(activityId, eventId)
	local eventType = eventCfg.eventType

	return eventType == BeastRichManEnum.EventType.Shop
end

function BeastRichmanController:tryPopCurScore(activityId)
	local curScoreList = self:getCurScore()
	local actCfg = BeastRichmanConfig.instance:getActCfg(activityId) or {}
	local scoreMatStr = actCfg.scoreMatStr
	local type, id, num = MaterialMgr.getMatParams(scoreMatStr)
	local totalScore = 0

	for i, score in ipairs(curScoreList) do
		totalScore = totalScore + score
		curScoreList[i] = nil
	end

	if totalScore > 0 then
		local list = {}

		if type == MatType.Item_Fake then
			local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, id, totalScore)

			table.insert(list, mo)
		end

		local obj = {}

		obj.items = list
		obj.ci = 0

		MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
		MaterialController.instance:checkAndOpenDisplay()
	end
end

function BeastRichmanController:isUsingStopCard(activityId)
	local info = BeastRichmanModel.instance:getInfo(activityId)

	if info then
		if not info.card then
			local cardInfo = {}

			if cardInfo then
				if not cardInfo.cardBuffs then
					local cardBuffs = {}

					if cardBuffs then
						for i, v in pairs(cardBuffs) do
							if v.cardId == BeastRichManEnum.CardType.Stop then
								return true
							end
						end
					end

					return false
				end
			end
		end
	end
end

BeastRichmanController.instance = BeastRichmanController.New()

return BeastRichmanController
