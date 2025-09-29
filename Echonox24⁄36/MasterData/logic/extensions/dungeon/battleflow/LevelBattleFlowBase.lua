-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/LevelBattleFlowBase.lua

module("logic.extensions.dungeon.battleflow.LevelBattleFlowBase", package.seeall)

local LevelBattleFlowBase = class("LevelBattleFlowBase", CoreBattleFlow)

function LevelBattleFlowBase:handleInit()
	self._battleLevelCode = 0
end

function LevelBattleFlowBase:_registerComponents()
	LevelBattleFlowBase.super._registerComponents(self)
	self:_addComponent("winCondition", DungeonFlowCompWinCondition)
end

function LevelBattleFlowBase:buildBattleFieldInfo(battleInfoNO)
	self._battleLevelCode = battleInfoNO.levelId

	MonsterConfig.instance:loadLevelMonsterConfig(self._battleLevelCode)

	return BattleNOConverter:convert(battleInfoNO)
end

function LevelBattleFlowBase:getBattleLevelCode()
	return self._battleLevelCode
end

function LevelBattleFlowBase:createBeforeStartBattleWork()
	return WorkPlayBattlePlot.New()
end

function LevelBattleFlowBase:createCalculateWork()
	return WorkCalculate.New()
end

function LevelBattleFlowBase:createExitBattleWork()
	return WorkExitScene.New()
end

function LevelBattleFlowBase:isEnableCampAdjustment()
	return true
end

function LevelBattleFlowBase:isSupportUndo()
	return SystemOpenModel.instance:isOpen(GameEnum.SystemEnum.BattleRetract)
end

function LevelBattleFlowBase:backupCalculateModel()
	local calculateHeroIdList = BattleCalculateModel.instance:getCalculateHeroIdList()
	local dungeonBattleInfoCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self._battleLevelCode)
	local lockedHeroIdOfDepot = dungeonBattleInfoCOWrapper:getLockedHeroes(BattleEnum.DungeonLockedHeroRefreshType.DATA)

	if lockedHeroIdOfDepot then
		for _, heroId in pairs(lockedHeroIdOfDepot) do
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

			if not heroMO then
				table.removebyvalue(calculateHeroIdList, heroId)
			end
		end
	end

	local lockedHeroIdOfConfig = dungeonBattleInfoCOWrapper:getLockedHeroes(BattleEnum.DungeonLockedHeroRefreshType.CONFIG)

	if lockedHeroIdOfConfig then
		for _, heroId in pairs(lockedHeroIdOfConfig) do
			table.removebyvalue(calculateHeroIdList, heroId)
		end
	end

	for i = #calculateHeroIdList, 1, -1 do
		if not BattleConfigUtil.isCharacterCode(calculateHeroIdList[i]) then
			table.remove(calculateHeroIdList, i)
		end
	end

	if enableLog then
		printInfo("calculateHeroIdList", BattleTableUtil.arrayToString(calculateHeroIdList))
	end
end

function LevelBattleFlowBase:fillCameraWalkUnionIndexListOfCamp(campId, walkUnionIndexList)
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._battleLevelCode)
	local cameraWalkCells = dungeonCO.cameraWalkCells

	for _, walkCell in ipairs(cameraWalkCells) do
		table.insert(walkUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(walkCell.x, walkCell.y))
	end
end

function LevelBattleFlowBase:fillAvailableHeroMOList(availableHeroMOList)
	table.insertto(availableHeroMOList, HeroDepotModel.instance:getHeroDepotData():getHeroDataList())
end

function LevelBattleFlowBase:getEntityCountLimitOfCamp(campId)
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._battleLevelCode)

	return dungeonCO.maxPerson
end

function LevelBattleFlowBase:getSortPriorityCareer()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

		if dungeonMO:getType() == CommEnum.DungeonType.Material then
			local chapterMO = DungeonMaterialChapterModel.instance:getChapterMoByChapterId(dungeonMO:getChapterId())

			return chapterMO:getCareer()
		end
	end

	return -1
end

function LevelBattleFlowBase:fillBornUnionIndexListOfCamp(campId, bornUnionIndexList, bornDirectionList)
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._battleLevelCode)
	local bornCells = dungeonCO.bornPosList

	for _, bornCell in ipairs(bornCells) do
		table.insert(bornDirectionList, bornCell.direction)
		table.insert(bornUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(bornCell.x, bornCell.y))
	end
end

function LevelBattleFlowBase:fillLockedCharacterCodeListOfCamp(campId, lockedCharacterCodeList)
	local dungeonBattleInfoCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self._battleLevelCode)

	BattleTableUtil.insertto(lockedCharacterCodeList, dungeonBattleInfoCOWrapper:getLockedHeroes(BattleEnum.DungeonLockedHeroRefreshType.DATA))
	BattleTableUtil.insertto(lockedCharacterCodeList, dungeonBattleInfoCOWrapper:getLockedHeroes(BattleEnum.DungeonLockedHeroRefreshType.CONFIG))

	if enableLog then
		printInfo("lockedCharacterCodeList", BattleTableUtil.arrayToString(lockedCharacterCodeList))
	end
end

function LevelBattleFlowBase:fillAssistantCharacterCodeListOfCamp(campId, assistantCharacterCodeList)
	local battleFiledInfo = self.model:getBattleFieldInfo()
	local entityInfos = battleFiledInfo.entityInfos

	for _, entityInfo in pairs(entityInfos) do
		if entityInfo.entityType == BattleEnum.EntityType.Monster then
			local entityCO = MonsterConfig.instance:getMonsterCO(entityInfo.entityCode)

			if entityCO.battleCamp == BattleEnum.MonsterCampType.ASSISTANT then
				table.insert(assistantCharacterCodeList, entityInfo.entityCode)
			end
		end
	end

	if enableLog then
		printInfo("assistantCharacterCodeList", BattleTableUtil.arrayToString(assistantCharacterCodeList))
	end
end

function LevelBattleFlowBase:fillKillEntityCodeListOfCamp(killEntityCodeList)
	local winCondition = self.winCondition
	local tags = winCondition:getAdditionalWinConditionTags()
	local dungeonCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self._battleLevelCode)

	dungeonCOWrapper:fillKillEntityCodes(killEntityCodeList, tags)

	if enableLog then
		printInfo("killEntityCodeList", BattleTableUtil.arrayToString(killEntityCodeList))
	end
end

function LevelBattleFlowBase:fillProtectEntityCodeListOfCamp(protectEntityCodeList)
	local winCondition = self.winCondition
	local tags = winCondition:getAdditionalLoseConditionTags()

	BattleTableUtil.clearTable(protectEntityCodeList)

	local dungeonCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self._battleLevelCode)

	dungeonCOWrapper:fillProtectEntityCodes(protectEntityCodeList, tags)

	if enableLog then
		printInfo("protectEntityCodeList", BattleTableUtil.arrayToString(protectEntityCodeList))
	end
end

function LevelBattleFlowBase:getMaxRoundCount()
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._battleLevelCode)

	return dungeonCO.maxRound
end

function LevelBattleFlowBase:getMaxRoundCount()
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._battleLevelCode)

	return dungeonCO.maxRound
end

function LevelBattleFlowBase:fillForbiddenSkillTypeList(forbiddenSkillTypeList)
	local levelCO = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self:getBattleLevelCode()):getDungeonBattleInfoCO()

	for i, skilType in ipairs(levelCO.forbidAction.useSpecifyTypeSkill) do
		forbiddenSkillTypeList[skilType] = true
	end
end

function LevelBattleFlowBase:fillForbiddenSkillPurposeList(forbiddenSkillPurposeList)
	local levelCO = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self:getBattleLevelCode()):getDungeonBattleInfoCO()

	for i, skilType in ipairs(levelCO.forbidAction.useSpecifyPurposeSkill) do
		forbiddenSkillPurposeList[skilType] = true
	end
end

function LevelBattleFlowBase:getForbiddenMoveStatus()
	local levelCO = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self:getBattleLevelCode()):getDungeonBattleInfoCO()

	return levelCO.forbidAction.move
end

function LevelBattleFlowBase:getForbiddenAutoStatus()
	local levelCO = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self:getBattleLevelCode()):getDungeonBattleInfoCO()

	return levelCO.forbidAction.auto
end

function LevelBattleFlowBase:getForbiddenSkillStrengthenStatus()
	local levelCO = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(self:getBattleLevelCode()):getDungeonBattleInfoCO()

	return levelCO.forbidAction.strengthenSkill
end

function LevelBattleFlowBase:fillTrialCharacterCodeList(trialHeroList)
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._battleLevelCode)

	for _, trialHero in ipairs(dungeonCO.trialHeroes or {}) do
		local entityCO = MonsterConfig.instance:getMonsterCO(trialHero.configId)
		local characterCO = CharacterConfig.instance:getCharacterItemInfo(trialHero.heroId)
		local heroData = BattleUnitUtil.createHeroData(entityCO, characterCO.quality)

		heroData._id = trialHero.configId
		heroData.heroId = trialHero.heroId
		heroData.isTrial = true

		table.insert(trialHeroList, heroData)
	end
end

return LevelBattleFlowBase
