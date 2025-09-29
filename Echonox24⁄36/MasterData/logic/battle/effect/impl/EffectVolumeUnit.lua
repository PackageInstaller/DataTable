-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/impl/EffectVolumeUnit.lua

module("logic.battle.effect.impl.EffectVolumeUnit", package.seeall)

local EffectVolumeUnit = class("EffectVolumeUnit", EffectUnitBase)

function EffectVolumeUnit:_initComponents()
	self:_addComponent("main", EffectCompMain)
	self:_addComponent("loader", EffectCompLoader)
	self:_addComponent("transform", EffectCompTransform)
	self:_addComponent("volume", EffectCompVolume)
	self:_addComponent("lifeTime", EffectCompLifeTime)
	self:_addComponent("audio", EffectCompAudio)
end

return EffectVolumeUnit
