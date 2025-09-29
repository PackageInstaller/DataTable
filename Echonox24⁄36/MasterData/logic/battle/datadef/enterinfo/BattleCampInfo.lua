-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/enterinfo/BattleCampInfo.lua

module("logic.battle.datadef.enterinfo.BattleCampInfo", package.seeall)

local BattleCampInfo = class("BattleCampInfo", AbstractGlobalReusable)

function BattleCampInfo:ctor()
	self.stageId = 0
	self.campId = 0
	self.userId = 0
	self.gameTeamId = 0
end

function BattleCampInfo:reset()
	return
end

function BattleCampInfo:destroy()
	self:reset()
end

return BattleCampInfo
