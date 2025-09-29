-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/impl/AirLevelBattleFlow.lua

module("logic.battle.battleflow.impl.AirLevelBattleFlow", package.seeall)

local M = class("AirLevelBattleFlow", LevelBattleFlowBase)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_removeComponent("starConditionNotify")
	self:_addComponent("buildingMgr", BattleBuildingMgr)
	self:_addComponent("messageMgr", BattleMessageMgr)
end

function M:handleEnterBattle()
	return
end

function M:handleExitBattleFinish()
	local battleType = self.model:getBattleType()
	local airLevelId = AirWorkMapModel.instance:getEnterBattleLevelId()
	local levelMo = AirWorkMapModel.instance:getLevelMOById(airLevelId)
	local isOnline = levelMo ~= nil and levelMo:getOnlineStatus() or false

	if battleType and airLevelId and not isOnline and battleType == BattleExtension_pb.BattleType.TEST_AIR and airLevelId then
		AirWorkShopDefMgr.instance:enter(airLevelId)

		return
	end

	self:_backScene()

	if battleType and isOnline and battleType == BattleExtension_pb.BattleType.TEST_AIR and GuideModel.instance:isGuideFinish(40023) then
		ViewMgr.instance:open(ViewName.AirWorkShopManagerView)
	end
end

function M:handleBeforeInitCommands()
	local extraWinCondition = self._mapMO:getCondition()

	if extraWinCondition and extraWinCondition.id ~= 0 then
		local desc = AirWorkShopDefSceneUtil.getExtraWinConditionDesc(extraWinCondition)

		if desc then
			self.winCondition:addExtraWinConditionDesc(desc)
		end
	end

	local messageAndHighlandBuildings = BattleTableUtil.getTempList()

	self._mapMO:getBattlePreloadMOList(messageAndHighlandBuildings)

	for i, buildMO in ipairs(messageAndHighlandBuildings) do
		self.buildingMgr:createUnit(buildMO)
	end

	BattleTableUtil.releaseTempList(messageAndHighlandBuildings)
	self.model:setShowUndoResult(false)
end

function M:buildBattleFieldInfo(battleInfoNO)
	self._airSceneId = battleInfoNO.map.sceneId

	AirWorkMapModel.instance:setEnterBattleLevelId(battleInfoNO.mapId)

	local airSceneCO = AirWorkShopConfig.instance:getSceneCO(self._airSceneId)

	self._battleLevelCode = airSceneCO.levelId
	self._mapMO = AirWorkMapMO.New()

	self._mapMO:initByAgent(battleInfoNO.map)

	return BattleNOConverter:convert(battleInfoNO)
end

function M:getMapMO()
	return self._mapMO
end

function M:getLevelName()
	local id = self._mapMO:getSceneId()
	local sceneCO = AirWorkShopConfig.instance:getSceneCO(id)
	local levelCode = sceneCO.levelId
	local levelCO = BattleConfig.instance:getBattleLevelCO(levelCode)

	return levelCO.levelName
end

function M:createCalculateWork()
	local airWorkCalculate = AirWorkCalculate.New()

	return airWorkCalculate
end

function M:createBeforeStartBattleWork()
	return false
end

function M:isSupportRestart()
	local battleType = self.model:getBattleType()

	return battleType == BattleExtension_pb.BattleType.TEST_AIR
end

function M:userRequestRestart(restartType)
	local battleType = self.model:getBattleType()
	local airLevelId = AirWorkMapModel.instance:getEnterBattleLevelId()

	if battleType == BattleExtension_pb.BattleType.RODEO_AIR then
		if AirWorkShopUtil.getInRodeoCalculateTime(nil, true) then
			return
		end

		if AirWorkShopUtil.getCanRodeoSettle() then
			FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))

			return
		end
	end

	self:restart(restartType)
end

function M:sendRestartRequest()
	local battleType = self.model:getBattleType()
	local airLevelId = AirWorkMapModel.instance:getEnterBattleLevelId()

	if battleType == BattleExtension_pb.BattleType.TEST_AIR then
		AirWorkShopDefAgent.instance:sendTestAirMapRequest(airLevelId)
	end
end

function M:_backScene()
	local backSceneInfo = SceneFace.instance:getCurrBackInfo()
	local backSceneTyp = backSceneInfo and backSceneInfo.sceneType or SceneType.Room

	if backSceneTyp == SceneType.Room then
		local mainSceneLoading
		local notOpenMainUI = true
		local isBackScene = true

		SceneFace.instance:enterRoomScene(mainSceneLoading, notOpenMainUI, isBackScene)
	else
		backSceneInfo = TableUtil.deepCopy(backSceneInfo)

		SceneFace.instance:clearEnterSceneInfo()
		SceneFace.instance:enterScene(backSceneInfo, true)
	end
end

function M:fillBornUnionIndexListOfCamp(campId, bornUnionIndexList, bornDirectionList)
	local bornMOList = self._mapMO:getBorns()

	for i, v in ipairs(bornMOList) do
		local bornCellMO = v:getBornCell()

		table.insert(bornDirectionList, bornCellMO.direction or 1)
		table.insert(bornUnionIndexList, v:getUnionIndex())
	end
end

function M:fillKillEntityCodeListOfCamp(killEntityCodeList)
	local extraWin = self._mapMO:getCondition()

	if extraWin and extraWin.id == 2 then
		table.insert(killEntityCodeList, extraWin.params[1])
	end

	if enableLog then
		printInfo("killEntityCodeList", BattleTableUtil.arrayToString(killEntityCodeList))
	end
end

function M:isSupportUndo()
	return false
end

return M
