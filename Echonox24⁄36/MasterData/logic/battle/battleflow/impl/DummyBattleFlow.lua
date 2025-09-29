-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/impl/DummyBattleFlow.lua

module("logic.battle.battleflow.impl.DummyBattleFlow", package.seeall)

local DummyBattleFlow = class("DummyBattleFlow", CoreBattleFlow)

function DummyBattleFlow:buildBattleFieldInfo(battleInfoNO)
	return BattleNOConverter:convert(battleInfoNO)
end

function DummyBattleFlow:handleEnterBattle()
	SceneFace.instance:exitScene()
	ViewMgr.instance:close(ViewName.MainUIView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
	ViewMgr.instance:close(ViewName.HackToolView, false, WindowType.WindowCloseReasonType.QuickCloseType)
	BattleCampAdjustmentModel.instance:setDebug(true)

	BattleTestUtil.isTest = true
end

function DummyBattleFlow:handleExitBattleFinish()
	SceneFace.instance:enterRoomScene(true, true)
	ViewMgr.instance:open(ViewName.MainUIView)
	ViewMgr.instance:open(ViewName.HackToolView)
end

function DummyBattleFlow:backupCalculateModel()
	local calculateHeroIdList = BattleCalculateModel.instance:getCalculateHeroIdList()

	BattleTableUtil.clearTable(calculateHeroIdList)
end

function DummyBattleFlow:createExitBattleWork()
	return WorkBattleExitScene.New()
end

function DummyBattleFlow:isEnableCampAdjustment()
	return true
end

function DummyBattleFlow:isSupportRestart()
	return true
end

function DummyBattleFlow:getEntityCountLimitOfCamp(campId)
	return 0
end

function DummyBattleFlow:fillAvailableHeroMOList(availableHeroMOList)
	return
end

function DummyBattleFlow:fillBornUnionIndexListOfCamp(campId, bornUnionIndexList, bornDirectionList)
	local unitMgr = self.unitMgr
	local boardMO = self.boardModel:getActiveBoardMO()

	for _, cellMO in boardMO:ipairs() do
		if cellMO:isEnable() then
			local cellIndex = BoardIndexConverter.coordinatesToUnionIndex(cellMO:getCoordinates())

			table.insert(bornDirectionList, 1)
			table.insert(bornUnionIndexList, cellIndex)
		end
	end
end

function DummyBattleFlow:getMaxRoundCount()
	return 9999
end

function DummyBattleFlow:isSupportUndo()
	return true
end

function DummyBattleFlow:sendRestartRequest()
	HackToolAgent.instance:sendGmRequest(BattleTestUtil.LastTestRequestData)
end

function DummyBattleFlow:userRequestRestart(restartType)
	self:restart(restartType)
end

return DummyBattleFlow
