-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleStatusHint.lua

module("logic.battle.uibubble.impl.BubbleStatusHint", package.seeall)

local BubbleSignHint = class("BubbleSignHint", BubbleBase)
local kAttackSign2Name = {
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DOUBLE] = "doubleHit",
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE] = "pursuitHit",
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER] = "priorityHit",
	[BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER] = "longHit"
}

function BubbleSignHint:_getBubbleResourcePath()
	return BattleResourceName.UIBubbleStatusHint
end

function BubbleSignHint:buildUI()
	self._playerDirector = goutil.addComponentOnce(self.mainGO, ComponentType.PlayableDirector)
	self._goList = {}

	for attackSign, animationName in pairs(kAttackSign2Name) do
		self._goList[attackSign] = goutil.findChild(self.mainGO, animationName)
	end
end

function BubbleSignHint:destroyUI()
	self._playerDirector = nil
	self._goList = nil
end

function BubbleSignHint:resetUI()
	self._playerDirector:Stop()
end

function BubbleSignHint:setBubbleContent(attackSign)
	for k, go in pairs(self._goList) do
		goutil.setActive(go, k == attackSign)
	end

	self._playerDirector.initialTime = 0

	self._playerDirector:Evaluate()
	self._playerDirector:SetPlaySpeed(BattleTime.timeScale)
end

return BubbleSignHint
