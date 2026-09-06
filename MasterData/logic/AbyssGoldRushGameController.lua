-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/controller/AbyssGoldRushGameController.lua

module("logic.extensions.abyssgoldrush.controller.AbyssGoldRushGameController", package.seeall)

local AbyssGoldRushGameController = class("AbyssGoldRushGameController", BaseController)

function AbyssGoldRushGameController:ctor()
	return
end

function AbyssGoldRushGameController:onInit()
	self:onReset()
end

function AbyssGoldRushGameController:onReset()
	return
end

function AbyssGoldRushGameController:tryRestartGame(msg)
	local gameInfo = msg.gameInfo
	local activityId = msg.activityId

	AbyssGoldRushGameModel.instance:saveGameInfo(msg.gameInfo, true)
	AbyssGoldRushGameModel.instance:onStartGame(activityId, msg)

	local stepId = gameInfo.baseInfo.curStepId
	local targetStepId = self:getNextStepId(activityId)
	local targetStepCfg = AbyssGoldRushConfig.instance:getStepCfg(activityId, targetStepId)

	if stepId == 0 then
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(activityId, 1)
	elseif stepId == 1 then
		UIStateManager.instance:push(ViewName.AbyssGoldRushPetSelectView, activityId)
	elseif not targetStepCfg then
		UIStateManager.instance:push(ViewName.AbyssGoldRushExitView, activityId)
	elseif targetStepCfg.handleType == "battle" then
		self:openMissionView(activityId)
	elseif targetStepCfg.handleType == "holyStripeDrop" or targetStepCfg.handleType == "openPetBox" or targetStepCfg.handleType == "petSelect" then
		UIStateManager.instance:push(ViewName.AbyssGoldRushGainPrizeView, activityId)
	elseif targetStepCfg.handleType == "nextRound" then
		UIStateManager.instance:push(ViewName.AbyssGoldRushRoundEndView, activityId)
	end
end

function AbyssGoldRushGameController:runGameAfterBattle()
	return
end

function AbyssGoldRushGameController:handlePM_AbyssGoldRushPushStepRes(msg)
	AbyssGoldRushGameModel.instance:saveGameInfo(msg.gameInfo)

	if msg.targetStepId == 1 then
		UIStateManager.instance:push(ViewName.AbyssGoldRushPetSelectView, msg.activityId)
	end

	if self._pushHandler then
		GameUtil.callBack(self._pushHandler)

		self._pushHandler = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushPushStepRes, msg)
end

function AbyssGoldRushGameController:handlePM_AbyssGoldRushNotifyFightRes(msg)
	AbyssGoldRushGameModel.instance:saveGameInfo(msg.gameInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushNotifyFightRes, msg)

	self._isAfterBattle = true
end

function AbyssGoldRushGameController:jumpViewAfterBattle(activityId)
	local targetStepId = self:getNextStepId(activityId)
	local targetStepCfg = AbyssGoldRushConfig.instance:getStepCfg(activityId, targetStepId)

	if not targetStepCfg then
		UIStateManager.instance:push(ViewName.AbyssGoldRushExitView, activityId)
	elseif targetStepCfg.handleType == "holyStripeDrop" then
		UIStateManager.instance:push(ViewName.AbyssGoldRushGainPrizeView, activityId)
	elseif targetStepCfg.handleType == "nextRound" then
		UIStateManager.instance:push(ViewName.AbyssGoldRushRoundEndView, activityId)
	end

	self._isAfterBattle = false
end

function AbyssGoldRushGameController:isAfterBattle()
	return self._isAfterBattle
end

function AbyssGoldRushGameController:getNextStepId(activityId)
	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()
	local battleResult = 0

	if gameInfo.baseInfo.battleResults then
		battleResult = gameInfo.baseInfo.battleResults[#gameInfo.baseInfo.battleResults]
	end

	local stepCfgs = AbyssGoldRushConfig.instance:getStepCfgs(activityId)
	local targetStepId = 0

	for i = gameInfo.baseInfo.curStepId + 1, #stepCfgs do
		local checkStepCfg = stepCfgs[i]

		if checknumber(checkStepCfg.stepType) == 0 or checkStepCfg.stepType == 1 and (battleResult == 1 or battleResult == 0) or checkStepCfg.stepType == 2 and battleResult == -1 then
			targetStepId = i

			break
		end
	end

	return targetStepId
end

function AbyssGoldRushGameController:_setPushHandler(handler)
	self._pushHandler = handler
end

function AbyssGoldRushGameController:_getPushHandler()
	return self._pushHandler
end

function AbyssGoldRushGameController:openMissionView(activityId)
	AbyssGoldRushGameController.instance:tryWearRecommondHolyStripe()

	local fmtMo = AbyssGoldRushModel.instance:getFmtMo()

	fmtMo:initParams(activityId)
	fmtMo:hideAllEnemyPets()
	CustomFmtController.instance:showMissionView(fmtMo)
end

function AbyssGoldRushGameController:selectPet(activityId, targetStepId, creepIds)
	local extParam = {}

	extParam.selectCreepsIds = {}

	for i, v in ipairs(creepIds) do
		table.insert(extParam.selectCreepsIds, v)
	end

	local jsonExtPram = GameUtil.jsonToString(extParam)

	AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(activityId, targetStepId, jsonExtPram)
end

function AbyssGoldRushGameController:calcAddScoreAndResult(activityId)
	local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(activityId)
	local totalScore = 0
	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()
	local finalResultWin = false

	for i, v in ipairs(gameInfo.baseInfo.battleResults) do
		if v == -1 then
			finalResultWin = false
			totalScore = totalScore + actCfg.loseAddScore
		elseif v == 0 then
			finalResultWin = true
			totalScore = totalScore + actCfg.tieAddScore
		elseif v == 1 then
			finalResultWin = true
			totalScore = totalScore + actCfg.winAddScore
		end
	end

	local winStreak = AbyssGoldRushModel.instance:getWinStreak(activityId)

	if finalResultWin == true then
		winStreak = winStreak + 1

		local finalBattleRound = #gameInfo.baseInfo.battleResults
		local roundCfg = AbyssGoldRushConfig.instance:getRoundCfg(activityId, finalBattleRound)

		totalScore = totalScore + roundCfg.winRunScore
	else
		winStreak = 0
	end

	local streakCfgs = AbyssGoldRushConfig.instance:getStreakCfgs(activityId)
	local streakScore = 0

	for i, v in ipairs(streakCfgs) do
		if winStreak >= v.streak then
			streakScore = v.addScore
		end
	end

	totalScore = totalScore + streakScore

	return totalScore
end

function AbyssGoldRushGameController:getWearRecommondHolyStripeIds()
	local curPresetId = AbyssGoldRushGameModel.instance:getUsePresetId()
	local presetMap = AbyssGoldRushGameModel.instance:getPresetMap()
	local usedHolyStripeMap = {}
	local curPresetHolyStripeMap = {}

	for presetId, presetInfos in pairs(presetMap) do
		for i, presetInfo in ipairs(presetInfos or {}) do
			local id = checknumber(presetInfo.id)

			if id > 0 then
				if presetId == curPresetId then
					curPresetHolyStripeMap[id] = true
				else
					usedHolyStripeMap[id] = true
				end
			end
		end
	end

	local recommendInfos = {}
	local holyStripeInfo = AbyssGoldRushGameModel.instance:getHolyStripeInfo()

	for id, info in pairs(holyStripeInfo or {}) do
		id = checknumber(id)

		if id > 0 and not usedHolyStripeMap[id] then
			local goldRushHolyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(info.defineId)

			if goldRushHolyStripeCfg then
				::label_16_0::

				local holyStripeCfg = HolyStripeConfig.instance:getHolyStripeCfg(goldRushHolyStripeCfg.holyStripeTarget)

				if holyStripeCfg then
					table.insert(recommendInfos, {
						id = id,
						defineId = info.defineId,
						quality = checknumber(holyStripeCfg.quality),
						isInCurPreset = curPresetHolyStripeMap[id] == true
					})
				end
			end
		end
	end

	table.sort(recommendInfos, function(a, b)
		if a.quality ~= b.quality then
			return a.quality > b.quality
		end

		if a.isInCurPreset ~= b.isInCurPreset then
			return a.isInCurPreset == true
		end

		return a.id < b.id
	end)

	local recommondIds = {}

	for i, info in ipairs(recommendInfos) do
		if i > 5 then
			break
		end

		table.insert(recommondIds, {
			defineId = info.defineId,
			id = info.id
		})
	end

	return recommondIds
end

function AbyssGoldRushGameController:tryWearRecommondHolyStripe()
	local isAutoWear = AbyssGoldRushGameModel.instance:isAutoWearHolyStripe()

	if not isAutoWear then
		return
	end

	local curPresetId = AbyssGoldRushGameModel.instance:getUsePresetId()
	local recommondIds = self:getWearRecommondHolyStripeIds()

	AbyssGoldRushGameModel.instance:savePresetIds(curPresetId, recommondIds)
end

AbyssGoldRushGameController.instance = AbyssGoldRushGameController.New()

return AbyssGoldRushGameController
