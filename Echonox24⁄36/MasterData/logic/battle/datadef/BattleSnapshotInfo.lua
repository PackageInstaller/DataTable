-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/BattleSnapshotInfo.lua

module("logic.battle.datadef.BattleSnapshotInfo", package.seeall)

local BattleSnapshotInfo = class("BattleSnapshotInfo", AbstractGlobalReusable)

function BattleSnapshotInfo:ctor()
	self:reset()
	self:reuse()
end

function BattleSnapshotInfo:reset()
	self._battleId = false
	self._isWin = false
end

function BattleSnapshotInfo:destroy()
	self:reset()
end

function BattleSnapshotInfo:reuse()
	local model = BattleMgr.instance:getModel()
	local battleFieldInfo = model:getBattleFieldInfo()

	self._battleId = battleFieldInfo.battleId
	self._isWin = model:isWin()
end

function BattleSnapshotInfo:getBattleId()
	return self._battleId
end

function BattleSnapshotInfo:isWin()
	return self._isWin
end

return BattleSnapshotInfo
