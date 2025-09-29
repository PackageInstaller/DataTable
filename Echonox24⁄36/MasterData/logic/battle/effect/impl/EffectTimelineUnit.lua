-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/impl/EffectTimelineUnit.lua

module("logic.battle.effect.impl.EffectTimelineUnit", package.seeall)

local EffectTimelineUnit = class("EffectTimelineUnit", EffectUnitBase)

function EffectTimelineUnit:_initComponents()
	self:_addComponent("main", EffectCompTimelineMain)
	self:_addComponent("loader", EffectCompLoader)
	self:_addComponent("transform", EffectCompTransform)
	self:_addComponent("lifeTime", EffectCompLifeTime)
	self:_addComponent("bindings", EffectCompTimelineBinding)
	self:_addComponent("listener", EffectCompTimelineListener)
	self:_addComponent("audio", EffectCompAudio)
end

return EffectTimelineUnit
