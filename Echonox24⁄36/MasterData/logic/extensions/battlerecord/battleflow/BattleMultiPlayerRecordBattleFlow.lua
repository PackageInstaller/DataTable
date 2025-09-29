-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/battleflow/BattleMultiPlayerRecordBattleFlow.lua

module("logic.extensions.battlerecord.battleflow.BattleMultiPlayerRecordBattleFlow", package.seeall)

local BattleMultiPlayerRecordBattleFlow = class("BattleMultiPlayerRecordBattleFlow", MultiPlayerBattleFlowBase)

function BattleMultiPlayerRecordBattleFlow:_registerComponents()
	BattleMultiPlayerRecordBattleFlow.super._registerComponents(self)
	self:_removeComponent("netEventMgr")
	self:_addComponent("netEventMgr", BattleCompRecordNetEventMgr)
end

function BattleMultiPlayerRecordBattleFlow:handleEnterBattle()
	BattleRecordUtil.enterSetup()
end

function BattleMultiPlayerRecordBattleFlow:handleExitBattleFinish()
	BattleRecordUtil.exitSetup()
end

function BattleMultiPlayerRecordBattleFlow:handleBattleStart()
	self.netEventMgr:processNextEvent()
end

function BattleMultiPlayerRecordBattleFlow:createCalculateWork()
	return false
end

function BattleMultiPlayerRecordBattleFlow:createExitBattleWork()
	return WorkExitScene.New()
end

function BattleMultiPlayerRecordBattleFlow:isEnableCampAdjustment()
	return false
end

return BattleMultiPlayerRecordBattleFlow
