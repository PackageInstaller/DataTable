-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/battleflow/FootBallBattleFlow.lua

module("logic.extensions.football.battleflow.FootBallBattleFlow", package.seeall)

local FootBallBattleFlow = class("FootBallBattleFlow", MultiPlayerBattleFlowBase)

function FootBallBattleFlow:_registerComponents()
	FootBallBattleFlow.super._registerComponents(self)
	self:_removeComponent("localLogic")
	self:_removeComponent("roundReport")
	self:_removeComponent("releaseSkillAgent")
	self:_addComponent("localLogic", FootBallCompLogic)
	self:_addComponent("roundReport", FootBallCompRoundReport)
	self:_addComponent("releaseSkillAgent", FootBallCompReleaseSkillAgent)
	self:_addComponent("scoreAreaDrawing", FootBallCompScoreAreaDrawing)
end

function FootBallBattleFlow:fillResourcePathList(resPathList)
	table.insert(resPathList, ResName.Battle_pvp_score_board)
	table.insert(resPathList, ResName.Battle_pvp_bout_view)
end

function FootBallBattleFlow:handleEnterBattleFinish()
	ViewMgr.instance:open(ViewName.FootballRoundReport)
end

function FootBallBattleFlow:handleBattleStart()
	ViewMgr.instance:open(ViewName.FootballScoreBoard)

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local units = unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if FootBallCompReleaseSkillAgent.isFootball(unit) then
			unit.property:activeState(BattleEnum.State.SKIPPED_PERFORMANCE_FOR_VICITM)
		end
	end
end

function FootBallBattleFlow:handleExitBattleFinish()
	ViewMgr.instance:close(ViewName.FootballScoreBoard)
	ViewMgr.instance:close(ViewName.FootballRoundReport)
	ViewMgr.instance:destroy(ViewName.FootballRoundReport)
	SceneFace.instance:enterRoomScene()
end

function FootBallBattleFlow:createCalculateWork()
	local sequence = FlowSequence.New()

	sequence:addChild(WorkFootBallBattleCalculate.New())
	sequence:addChild(WorkCalculate.New())

	return sequence
end

function FootBallBattleFlow:createExitBattleWork()
	return WorkBattleExitScene.New()
end

function FootBallBattleFlow:isEnableCampAdjustment()
	return true
end

function FootBallBattleFlow:getMaxRoundCount()
	return FootBallConfig.instance:getConstNum(FootBallConstEnum.MaxRound)
end

function FootBallBattleFlow:getReadyTimeLimit()
	return FootBallConfig.instance:getConstNum(FootBallConstEnum.ReadyTimeLimit)
end

function FootBallBattleFlow:fillTeamInfoMOList(teamInfoMOList)
	local teams = FootballModel.instance:getTeams()

	for _, teamNO in ipairs(teams) do
		table.insert(teamInfoMOList, BattleTeamInfoMO:createFromTeamNO(teamNO))
	end
end

function FootBallBattleFlow:getEntityCountLimitOfCamp()
	return FootBallConfig.instance:getConstNum(FootBallConstEnum.ExpectedEntityCount)
end

function FootBallBattleFlow:fillAvailableHeroMOList(availableHeroMOList)
	table.insertto(availableHeroMOList, HeroDepotModel.instance:getHeroDepotData():getHeroDataList())
end

function FootBallBattleFlow:fillBornUnionIndexListOfCamp(campId, bornUnionIndexList, bornDirectionList)
	local model = self.model
	local campInfo = model:getCampInfo(campId)
	local bornCells = self:_getBornAreaConfigOfTeam(campInfo.gameTeamId)

	for _, bornCell in ipairs(bornCells) do
		table.insert(bornDirectionList, bornCell.direction)
		table.insert(bornUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(bornCell.x, bornCell.y))
	end
end

function FootBallBattleFlow:_getBornAreaConfigOfTeam(gameTeamId)
	local bornAreaJsonList = FootBallConfig.instance:getConstJson(FootBallConstEnum.BornArea)

	for _, bornAreaJson in ipairs(bornAreaJsonList) do
		if bornAreaJson.teamId == gameTeamId then
			return bornAreaJson.area
		end
	end

	return false
end

return FootBallBattleFlow
