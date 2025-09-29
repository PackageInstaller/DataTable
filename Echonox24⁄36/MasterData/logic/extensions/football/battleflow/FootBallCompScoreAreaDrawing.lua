-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/battleflow/FootBallCompScoreAreaDrawing.lua

module("logic.extensions.football.battleflow.FootBallCompScoreAreaDrawing", package.seeall)

local FootBallCompScoreAreaDrawing = class("FootBallCompScoreAreaDrawing", IBattleFlowComp, AbstractGlobalReusable)

function FootBallCompScoreAreaDrawing:onInit()
	self._selfGoalCollection = BattleGameObjectCollection.New(BattleResourceName.GoalBlueSign)
	self._enemyGoalCollection = BattleGameObjectCollection.New(BattleResourceName.GoalRedSign)
end

function FootBallCompScoreAreaDrawing:onStart()
	self._boardMgr = self.flow.boardMgr or false
	self._model = self.flow.model or false
	self._settingModel = self.flow.settingModel or false
end

function FootBallCompScoreAreaDrawing:onEnterDone()
	local operateTeamId = self._model:getOperateGameTeamId()
	local teamInfoMOList = self._settingModel:getTeamInfoMOList()

	for _, teamInfoMO in ipairs(teamInfoMOList) do
		if operateTeamId == teamInfoMO.teamId then
			self:_drawGoalCells(self:_getScoreAreaConfigOfTeam(teamInfoMO.teamId), self._enemyGoalCollection)
		else
			self:_drawGoalCells(self:_getScoreAreaConfigOfTeam(teamInfoMO.teamId), self._selfGoalCollection)
		end
	end
end

function FootBallCompScoreAreaDrawing:onClear()
	self._boardMgr = false
	self._model = false

	self._selfGoalCollection:clear()
	self._enemyGoalCollection:clear()
end

function FootBallCompScoreAreaDrawing:_drawGoalCells(goalCells, gameObjectCollection)
	if not goalCells then
		return
	end

	local boardMgr = self._boardMgr
	local signsRoot = BattleGameObjectRootUtil.signsRoot

	for _, goalCell in pairs(goalCells) do
		local goInst = gameObjectCollection:createInstance(signsRoot)
		local position = boardMgr:getCellPosition(BoardIndexConverter.coordinatesToUnionIndex(goalCell.x, goalCell.y))

		Astral.TransformUtil.SetLocalPos(goInst.transform, position:Get())
	end
end

function FootBallCompScoreAreaDrawing:_getScoreAreaConfigOfTeam(gameTeamId)
	local scoreAreaJsonList = FootBallConfig.instance:getConstJson(FootBallConstEnum.ScoreArea)

	for _, scoreAreaJson in ipairs(scoreAreaJsonList) do
		if scoreAreaJson.teamId == gameTeamId then
			return scoreAreaJson.area
		end
	end

	return false
end

return FootBallCompScoreAreaDrawing
