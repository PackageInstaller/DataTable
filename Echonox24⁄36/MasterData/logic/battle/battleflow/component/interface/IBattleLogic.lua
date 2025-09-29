-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/interface/IBattleLogic.lua

module("logic.battle.battleflow.component.interface.IBattleLogic", package.seeall)

local IBattleLogic = class("IBattleLogic")

function IBattleLogic:handleRoundStarted(roundId)
	return
end

function IBattleLogic:handleStageStarted(stageId)
	return
end

function IBattleLogic:handleStageEnded(stageId)
	return
end

function IBattleLogic:handlePlayerStarted(campId)
	return
end

function IBattleLogic:handlePlayerEnded(campId)
	return
end

function IBattleLogic:checkBattleEnded()
	return
end

function IBattleLogic:isActiveCampId(campId)
	return
end

return IBattleLogic
