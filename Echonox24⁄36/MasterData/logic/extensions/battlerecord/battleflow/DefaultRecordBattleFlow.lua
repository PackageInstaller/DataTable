-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/battleflow/DefaultRecordBattleFlow.lua

module("logic.extensions.battlerecord.battleflow.DefaultRecordBattleFlow", package.seeall)

local DefaultRecordBattleFlow = class("DefaultRecordBattleFlow", CoreBattleFlow)

function DefaultRecordBattleFlow:_registerComponents()
	DefaultRecordBattleFlow.super._registerComponents(self)
	self:_removeComponent("netEventMgr")
	self:_addComponent("netEventMgr", BattleCompRecordNetEventMgr)
end

function DefaultRecordBattleFlow:buildBattleFieldInfo(battleInfoNO)
	return BattleNOConverter:convert(battleInfoNO)
end

function DefaultRecordBattleFlow:handleEnterBattle()
	BattleRecordUtil.enterSetup()
end

function DefaultRecordBattleFlow:handleExitBattleFinish()
	BattleRecordUtil.exitSetup()
end

function DefaultRecordBattleFlow:handleBattleStart()
	self.netEventMgr:processNextEvent()
end

function DefaultRecordBattleFlow:createCalculateWork()
	return false
end

function DefaultRecordBattleFlow:createExitBattleWork()
	return WorkExitScene.New()
end

function DefaultRecordBattleFlow:isEnableCampAdjustment()
	return false
end

return DefaultRecordBattleFlow
