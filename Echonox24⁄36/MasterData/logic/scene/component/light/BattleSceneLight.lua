-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/light/BattleSceneLight.lua

module("logic.scene.component.light.BattleSceneLight", package.seeall)

local BattleSceneLight = class("BattleSceneLight", SceneComponentBase)

function BattleSceneLight:onInit()
	self._goMainSceneCharacterLight = false
	self._goAdditionSceneCharacterLight = false
	self._goActiveCharacterLight = false
end

function BattleSceneLight:onEnterSceneFinished(sceneId, bornX, bornZ)
	local stage = self._scene.stage

	self._goMainSceneCharacterLight = GameObjectUtils.FindChildRecursivelyBySceneName(stage:getSceneName(), 5, BattleScene.CharacterLightName)
	self._goAdditionSceneCharacterLight = GameObjectUtils.FindChildRecursivelyBySceneName(stage:getAdditionSceneName(), 5, BattleScene.CharacterLightName)

	self:activeNormalLight()
end

function BattleSceneLight:onExitScene()
	self._goMainSceneCharacterLight = false
	self._goAdditionSceneCharacterLight = false
	self._goActiveCharacterLight = false
end

function BattleSceneLight:onLeaveScene()
	self:onExitScene()
end

function BattleSceneLight:onReturnScene()
	self:onEnterSceneFinished()
end

function BattleSceneLight:activeNormalLight()
	self._goActiveCharacterLight = self._goMainSceneCharacterLight
end

function BattleSceneLight:activePerformanceLight()
	self._goActiveCharacterLight = self._goAdditionSceneCharacterLight
end

function BattleSceneLight:getCharacterLightGameObject()
	return self._goActiveCharacterLight
end

function BattleSceneLight:getAdditionLightGameObject()
	return self._goAdditionSceneCharacterLight
end

return BattleSceneLight
