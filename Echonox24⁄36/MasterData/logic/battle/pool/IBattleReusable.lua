-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/pool/IBattleReusable.lua

module("logic.battle.pool.IBattleReusable", package.seeall)

local IBattleReusable = class("IBattleReusable", IReusable)

function IBattleReusable:createInstance(...)
	return BattleReusablePoolMgr.instance:fetchReusableObject(self, ...)
end

function IBattleReusable:returnSelf()
	BattleReusablePoolMgr.instance:returnReusableObject(self)
end

function IBattleReusable:getCapacity()
	return
end

return IBattleReusable
