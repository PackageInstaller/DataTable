-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/impl/EffectBezierBullet.lua

module("logic.battle.effect.impl.EffectBezierBullet", package.seeall)

local EffectBezierBullet = class("EffectBezierBullet", EffectUnitBase)

function EffectBezierBullet:_initComponents()
	self:_addComponent("loader", EffectCompLoader)
	self:_addComponent("transform", EffectCompTransform)
	self:_addComponent("mover", EffectCompBezierCurveMover)
	self:_addComponent("audio", EffectCompAudio)
end

return EffectBezierBullet
