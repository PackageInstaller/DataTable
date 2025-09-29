-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/model/BattleModel.lua

module("logic.battle.battleflow.component.model.BattleModel", package.seeall)

local BattleModel = class("BattleModel", IBattleFlowComp)

function BattleModel:onInit()
	self._mode = BattleEnum.Mode.NORMAL
	self._phase = BattleEnum.Phase.NORMAL
	self._battleFieldInfo = false
	self._campCollectionMO = BattleCampCollectionMO.New()
	self._resultMO = BattleResultMO.New()
	self._currentRound = 0
	self._leftUndoCount = 0
	self._cameraRotation = 0
	self._bossUnit = false
	self._skillId2chamberItemData = {}
	self._showUndoResult = true
	self._multiCount = 1
	self._gamePlay = BattleExtension_pb.Gameplay.GAME_NORMAL
	self._consecutiveRound = nil
	self._consecutiveRewards = nil
	self._startHeroCodes = {}
	self._isRoundStart = false
	self._battleType = false
end

function BattleModel:onClear(isRestart)
	self._mode = BattleEnum.Mode.NORMAL
	self._phase = BattleEnum.Phase.NORMAL
	self._currentRound = 0
	self._leftUndoCount = 0
	self._cameraRotation = 0

	self._campCollectionMO:clear()
	self._resultMO:clear()

	self._bossUnit = false
	self._showUndoResult = true
	self._isRoundStart = false

	if not isRestart then
		self:setConsecutiveRound(nil)
		self:setConsecutiveRewards(nil)
	end

	if self._battleFieldInfo then
		self._battleFieldInfo:returnSelf()

		self._battleFieldInfo = false
	end

	BattleTableUtil.clearTable(self._skillId2chamberItemData)
	BattleTableUtil.clearTable(self._startHeroCodes)
end

function BattleModel:setMode(mode)
	if BattleLog.enableLog then
		BattleLog.log(string.format("Battle mode changed [%s->%s]", self._mode, mode))
	end

	self._mode = mode
end

function BattleModel:getMode()
	return self._mode
end

function BattleModel:isRecord()
	return self._mode == BattleEnum.Mode.RECORD
end

function BattleModel:isReconnectMode()
	return self._mode == BattleEnum.Mode.RECONNECT
end

function BattleModel:setPhase(phase)
	if BattleLog.enableLog then
		BattleLog.log(string.format("Battle phase changed [%s->%s]", self._phase, phase))
	end

	self._phase = phase
end

function BattleModel:getPhase()
	return self._phase
end

function BattleModel:setBattleFieldInfo(battleFieldInfo)
	self._battleFieldInfo = battleFieldInfo
	self._currentRound = battleFieldInfo.round
	self._leftUndoCount = battleFieldInfo.leftUndoCount

	self._campCollectionMO:buildFromCampInfos(battleFieldInfo.campInfos)

	self._battleType = battleFieldInfo.battleType

	self:setMultiCount(battleFieldInfo.multiplied)
	self:setGamePlay(battleFieldInfo.gameplay)
end

function BattleModel:internal_undoReloadBattleFieldInfo()
	local battleFieldInfo = self._battleFieldInfo

	self:internal_setRound(battleFieldInfo.round)
	self._campCollectionMO:buildFromCampInfos(battleFieldInfo.campInfos)
end

function BattleModel:getBattleFieldInfo()
	return self._battleFieldInfo
end

function BattleModel:getBattleId()
	return self._battleFieldInfo.battleId
end

function BattleModel:getBattleType()
	return self._battleType
end

function BattleModel:isMultiPlayerMode()
	local battleType = self:getBattleType()

	return battleType == BattleExtension_pb.BattleType.PVP
end

function BattleModel:getSceneCode()
	return self._battleFieldInfo.sceneCode
end

function BattleModel:getOperateCampId()
	return self._battleFieldInfo.operateCampId
end

function BattleModel:getNpcCampId()
	return self._battleFieldInfo.npcCampId
end

function BattleModel:getOperateUserId()
	local campInfo = self:getCampInfo(self:getOperateCampId())

	return campInfo.userId
end

function BattleModel:getOperateGameTeamId()
	local campInfo = self:getCampInfo(self:getOperateCampId())

	return campInfo.gameTeamId
end

function BattleModel:getOperateCampStageId()
	local operateCampId = self:getOperateCampId()

	return self._campCollectionMO:getCampStageId(operateCampId)
end

function BattleModel:getResultMO()
	return self._resultMO
end

function BattleModel:isWin()
	return self._resultMO:isWinnerCampId(self:getOperateCampId())
end

function BattleModel:getCampInfo(campId)
	return self._battleFieldInfo:getCampInfo(campId)
end

function BattleModel:getCampInfoByUserId(userId)
	return self._battleFieldInfo:getCampInfoByUserId(userId)
end

function BattleModel:getCampRelation(aCampId, bCampId)
	return self._campCollectionMO:getRelationType(aCampId, bCampId)
end

function BattleModel:getCampRelationByUnit(aUnit, bUnit)
	if not aUnit or not bUnit then
		return BattleEnum.CampRelation.NORMAL
	end

	local aCampId = aUnit.property:getCampId()
	local bCampId = bUnit.property:getCampId()

	return self:getCampRelation(aCampId, bCampId)
end

function BattleModel:getCurrentRound()
	return self._currentRound
end

function BattleModel:getMaxRound()
	return self.flow:getMaxRoundCount()
end

function BattleModel:getRemainUndoCount()
	if enableDebug and self._leftUndoCount < 0 then
		return 999
	end

	return self._leftUndoCount
end

function BattleModel:getHeroesInBattle()
	return self._battleFieldInfo.heroesInBattle
end

function BattleModel:internal_increaseUndoCount()
	if enableDebug and self._leftUndoCount < 0 then
		return
	end

	self._leftUndoCount = self._leftUndoCount - 1

	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleUndoCountUpdate, self:getRemainUndoCount())
end

function BattleModel:internal_setLeftUndoCount(leftUndoCount)
	self._leftUndoCount = leftUndoCount

	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleUndoCountUpdate, self:getRemainUndoCount())
end

function BattleModel:internal_setRound(round)
	self._currentRound = round

	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleRoundUpdate, self._currentRound, self.flow:getMaxRoundCount())
end

function BattleModel:getIfCanAutoBattle()
	local settingModel = BattleMgr.instance:getSettingModel()

	return not settingModel:isForbiddenAutoPlay()
end

function BattleModel:getBgmResName()
	local checkerBoardCO = BattleConfig.instance:getCheckerBoardCO(self:getSceneCode())

	return checkerBoardCO.bgmResName
end

function BattleModel:getBattleMusicResName()
	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()

	if OOPUtil.isInstanceOf(activeBattleFlow, LevelBattleFlowBase) then
		local levelCode = activeBattleFlow:getBattleLevelCode()
		local levelCO = BattleConfig.instance:getBattleLevelCO(levelCode)

		return levelCO.battleMusicName
	end
end

function BattleModel:recordCameraRotation(rotation)
	self._cameraRotation = rotation
end

function BattleModel:getCameraRotation()
	return self._cameraRotation
end

function BattleModel:setBossViewUnit(unit)
	self._bossUnit = unit
end

function BattleModel:getBossViewUnit()
	return self._bossUnit
end

function BattleModel:setSkillId2SecretChamberItemData(skillId, itemData)
	self._skillId2chamberItemData[skillId] = itemData
end

function BattleModel:getSecretChamberItemData(skillId)
	return self._skillId2chamberItemData[skillId]
end

function BattleModel:showUndoResult()
	return self._showUndoResult
end

function BattleModel:setShowUndoResult(result)
	self._showUndoResult = result
end

function BattleModel:getAiMode()
	return self._battleFieldInfo and self._battleFieldInfo.aiMode or BattleExtension_pb.AiMode.NONE
end

function BattleModel:setAiMode(aiMode)
	self._battleFieldInfo.aiMode = aiMode

	BattleDispatcher:dispatchEvent(BattleEventType.OnAiModeChange, aiMode)
end

function BattleModel:isProxyMode()
	return self:getAiMode() == BattleExtension_pb.AiMode.USER_RECORD
end

function BattleModel:setMultiCount(count)
	self._multiCount = count
end

function BattleModel:getMultiCount()
	return self._multiCount
end

function BattleModel:getGamePlay()
	return self._gamePlay
end

function BattleModel:isGamePlayConsecutive()
	return self:getGamePlay() == BattleEnum.GamePlayType.CONSECUTIVE
end

function BattleModel:setGamePlay(gamePlay)
	self._gamePlay = gamePlay

	if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		DungeonAgent.instance:sendGetConsecutiveInfoRequest()
	else
		self:setConsecutiveRound(nil)
		self:setConsecutiveRewards(nil)
	end
end

function BattleModel:getConsecutiveRound()
	return self._consecutiveRound
end

function BattleModel:setConsecutiveRound(round)
	self._consecutiveRound = round
end

function BattleModel:setConsecutiveRewards(rewards)
	self._consecutiveRewards = rewards
end

function BattleModel:getConsecutiveRewards()
	return self._consecutiveRewards or {}
end

function BattleModel:getConsecutiveRewardsItemDataList(addItemDataList)
	local function _pileUpRewards(endingDungeonRewardNO, _itemsId2Lst)
		local itemNO = endingDungeonRewardNO.reward
		local itemId = itemNO.itemId
		local rewardTag = endingDungeonRewardNO.rewardTag or 0
		local _isPileUp = false

		if _itemsId2Lst[itemId] and ItemUtil.canStacked(itemId) then
			for _, _item in ipairs(_itemsId2Lst[itemId]) do
				if not _isPileUp and _item:getRewardTag() == rewardTag then
					_item:setCount(_item:getCount() + itemNO.count)

					_isPileUp = true
				end
			end
		end

		if not _isPileUp then
			if not _itemsId2Lst[itemId] then
				_itemsId2Lst[itemId] = {}
			end

			local item = ItemUtil.createItemData(itemNO)

			item:setRewardTag(rewardTag)
			table.insert(_itemsId2Lst[itemId], item)
		end
	end

	local tempItemsMap = {}

	for _, _ConsecutiveRewardNO in ipairs(self:getConsecutiveRewards() or {}) do
		local time = _ConsecutiveRewardNO.times

		for _, _EndingDungeonRewardNO in ipairs(_ConsecutiveRewardNO.rewards or {}) do
			_pileUpRewards(_EndingDungeonRewardNO, tempItemsMap)
		end
	end

	if addItemDataList and #addItemDataList > 0 then
		for _, _itemData in pairs(addItemDataList or {}) do
			local _itemId = _itemData:getItemId()
			local _isPileUp = false

			if tempItemsMap[_itemId] and ItemUtil.canStacked(_itemId) then
				for _, _item in ipairs(tempItemsMap[_itemId]) do
					if not _isPileUp and _item:getRewardTag() == _itemData:getRewardTag() then
						_item:setCount(_item:getCount() + _itemData:getCount())

						_isPileUp = true
					end
				end
			end

			if not _isPileUp then
				if not tempItemsMap[_itemId] then
					tempItemsMap[_itemId] = {}
				end

				table.insert(tempItemsMap[_itemId], _itemData)
			end
		end
	end

	local returnList = {}

	for _itemId, _itemLst in pairs(tempItemsMap) do
		for _, _itemData in ipairs(_itemLst) do
			table.insert(returnList, _itemData)
		end
	end

	if #returnList > 0 then
		table.sort(returnList, ItemUtil.commonSortFunc)
	end

	return returnList
end

function BattleModel:addStartHero(hero)
	table.insert(self._startHeroCodes, hero)
end

function BattleModel:clearStartHeroes()
	table.clear(self._startHeroCodes)
end

function BattleModel:getStartHeroes()
	return self._startHeroCodes
end

function BattleModel:isRoundStart()
	return self._isRoundStart
end

function BattleModel:setRoundStartStatus(status)
	self._isRoundStart = status
end

function BattleModel:getSceneType()
	return SceneType.Battle
end

return BattleModel
