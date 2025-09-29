-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/SkillPerformanceVolumeMgr.lua

module("logic.battle.skill.SkillPerformanceVolumeMgr", package.seeall)

local SkillPerformanceVolumeMgr = class("SkillPerformanceVolumeMgr")
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kEnterHorizontalDragBlurSettings = {
	dragX = 0.153,
	blurIteration = 8,
	maskLerp = 0.15,
	dragY = 0.052,
	blurSize = 1.24,
	dragIteration = 9,
	dragSize = 0.328
}
local kExitHorizontalDragBlurSettings = {
	dragX = 0,
	blurIteration = 8,
	maskLerp = 0,
	dragY = 0,
	blurSize = 2,
	dragIteration = 7,
	dragSize = 0.26094
}

function SkillPerformanceVolumeMgr:ctor()
	self._goVolume = false
	self._volume = false
end

function SkillPerformanceVolumeMgr:init()
	self:_turnOnFeatures()

	local resMgr = BattleMgr.instance:getResourceMgr()

	self._goVolume = resMgr:getInst(BattleResourceName.PerformanceVolume)
	self._volume = goutil.addComponentOnce(self._goVolume, ComponentType.Volume)

	goutil.addChildToParent(self._goVolume, kSceneRoot)
	self:turnOffBlur()
end

function SkillPerformanceVolumeMgr:clear()
	self:_turnOffFeatures()

	if self._goVolume then
		goutil.destroy(self._goVolume)

		self._goVolume = false
		self._volume = false
	end
end

function SkillPerformanceVolumeMgr:_turnOnFeatures()
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.ADDITIONAL, true, BattleConst.DefaultStateKey)
end

function SkillPerformanceVolumeMgr:_turnOffFeatures()
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.ADDITIONAL, false, BattleConst.DefaultStateKey)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.GLITCH_MASK, false, BattleConst.DefaultStateKey)
end

function SkillPerformanceVolumeMgr:turnOnBlur()
	SpaceX.OptimizerMgr.Instance:SetVolumeForceUpdate(true)
	goutil.setActive(self._goVolume, true)
end

function SkillPerformanceVolumeMgr:turnOffBlur()
	if not self._goVolume then
		return
	end

	SpaceX.OptimizerMgr.Instance:SetVolumeForceUpdate(false)
	goutil.setActive(self._goVolume, false)
end

function SkillPerformanceVolumeMgr:doEnterBlurIn(duration)
	self:_blurIn(kEnterHorizontalDragBlurSettings, duration, DG.Tweening.Ease.Linear)
end

function SkillPerformanceVolumeMgr:doEnterBlurOut(duration)
	self:_blurOut(kEnterHorizontalDragBlurSettings, duration, DG.Tweening.Ease.Linear)
end

function SkillPerformanceVolumeMgr:doExitBlurIn(duration)
	self:_blurIn(kExitHorizontalDragBlurSettings, duration, DG.Tweening.Ease.Linear)
end

function SkillPerformanceVolumeMgr:doExitBlurOut(duration)
	self:_blurOut(kExitHorizontalDragBlurSettings, duration, DG.Tweening.Ease.Linear)
end

function SkillPerformanceVolumeMgr:_blurIn(settings, duration, ease)
	self._volume:Kill(true)
	self._volume:doRadialBlur_RadialRadius(0, 2, duration):SetEase(ease)
end

function SkillPerformanceVolumeMgr:_blurOut(settings, duration, ease)
	self._volume:Kill(true)
	self._volume:doRadialBlur_RadialRadius(2, 0, duration):SetEase(ease)
end

SkillPerformanceVolumeMgr.instance = SkillPerformanceVolumeMgr.New()

return SkillPerformanceVolumeMgr
