-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompTimelineBinding.lua

module("logic.battle.effect.comp.EffectCompTimelineBinding", package.seeall)

local EffectCompTimelineBinding = class("EffectCompTimelineBinding", IEffectComp)

function EffectCompTimelineBinding:onInit()
	self._loader = self.unit.loader
	self._bindingTable = {}
	self._directorProxy = false
end

function EffectCompTimelineBinding:onReuse()
	return
end

function EffectCompTimelineBinding:onReset()
	self._directorProxy = false

	BattleTableUtil.clearTable(self._bindingTable)
end

function EffectCompTimelineBinding:onDestroy()
	self:onReset()
end

function EffectCompTimelineBinding:setGenericBinding(key, value)
	if self._directorProxy then
		self._directorProxy:SetGenericBinding(key, value)
	else
		self._bindingTable[key] = value
	end
end

function EffectCompTimelineBinding:clearGenericBinding(key)
	if self._directorProxy then
		self._directorProxy:ClearGenericBinding(key)
	else
		self._bindingTable[key] = nil
	end
end

function EffectCompTimelineBinding:onResourceLoaded()
	local goTimeline = self._loader:getInst()

	self._directorProxy = Timeline.PlayableDirectorProxy.Get(goTimeline)

	for k, v in pairs(self._bindingTable) do
		self._directorProxy:SetGenericBinding(k, v)
	end
end

function EffectCompTimelineBinding:getTotalHitCountAndWeight()
	local goTimeline = self._loader:getInst()
	local directorSetter = goTimeline:GetComponent(ComponentType.PlayableDirector)

	if directorSetter then
		return PlayableDirectorUtil.GetTotalAttackPointCountAndWeight(directorSetter, 0, 0)
	end

	return 0, 0
end

return EffectCompTimelineBinding
