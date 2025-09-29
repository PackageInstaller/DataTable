-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/battleflow/WorkFootBallBattleCalculate.lua

module("logic.extensions.football.battleflow.WorkFootBallBattleCalculate", package.seeall)

local WorkFootBallBattleCalculate = class("WorkFootBallBattleCalculate", WorkBase)

function WorkFootBallBattleCalculate:onEnter(context)
	ViewMgr.instance:close(ViewName.FootballScoreBoard)
	BattleCalculateModel.instance:setCustomResultViewClass(FootballCalculateResultView)
	self:onDone(WorkResult.Succeed)
end

function WorkFootBallBattleCalculate:onExit(isInterrupt)
	return
end

return WorkFootBallBattleCalculate
