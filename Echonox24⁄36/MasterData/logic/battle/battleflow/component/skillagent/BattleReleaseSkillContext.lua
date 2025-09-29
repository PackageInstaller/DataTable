-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/skillagent/BattleReleaseSkillContext.lua

module("logic.battle.battleflow.component.skillagent.BattleReleaseSkillContext", package.seeall)

local BattleReleaseSkillContext = class("BattleReleaseSkillContext", AbstractGlobalReusable)

function BattleReleaseSkillContext:ctor()
	self.entityId = false
	self.originUnionIndex = false
	self.stopUnionIndex = false
	self.selectedSkillId = false
	self.targetUnionIndex = false
	self.transportUnionIndex = false
	self.isStrenthening = false
	self.lookAtDirection = Coordinates:createInstance()
end

function BattleReleaseSkillContext:reset()
	self.entityId = false
	self.originUnionIndex = false
	self.stopUnionIndex = false
	self.selectedSkillId = false
	self.targetUnionIndex = false
	self.transportUnionIndex = false
	self.isStrenthening = false
	self.lookAtDirection = Coordinates:createInstance()
end

function BattleReleaseSkillContext:destroy()
	self:reset()
end

function BattleReleaseSkillContext:copyFrom(fromContext)
	self.entityId = fromContext.entityId
	self.originUnionIndex = fromContext.originUnionIndex
	self.stopUnionIndex = fromContext.stopUnionIndex
	self.selectedSkillId = fromContext.selectedSkillId
	self.targetUnionIndex = fromContext.targetUnionIndex
	self.transportUnionIndex = fromContext.transportUnionIndex
	self.isStrenthening = fromContext.isStrenthening

	local x, z = fromContext.lookAtDirection:getXZ()

	self:setLookAtDirection(x, 0, z)
end

function BattleReleaseSkillContext:setLookAtDirection(x, y, z)
	self.lookAtDirection:setXZ(x, z)
end

return BattleReleaseSkillContext
