-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompVolume.lua

module("logic.battle.effect.comp.EffectCompVolume", package.seeall)

local EffectCompVolume = class("EffectCompVolume", IEffectComp)

function EffectCompVolume:onInit()
	return
end

function EffectCompVolume:onReuse()
	return
end

function EffectCompVolume:onReset()
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(false, RendererFeatureName.ADDITIONAL)
end

function EffectCompVolume:onDestroy()
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(false, RendererFeatureName.ADDITIONAL)
end

function EffectCompVolume:onResourceLoaded()
	local goInst = self.unit.loader:getInst()
	local effectVolume = goutil.findChildComponent(goInst, "effectvolume", ComponentType.Volume)

	if not effectVolume then
		return
	end

	effectVolume:doRadialBlur_RadialCenter(0.7, 0.5)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(true, RendererFeatureName.ADDITIONAL)
end

return EffectCompVolume
