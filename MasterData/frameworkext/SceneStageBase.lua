-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/stage/SceneStageBase.lua

module("frameworkext.scene.stage.SceneStageBase", package.seeall)

local SceneStageBase = class("SceneStageBase", SceneComponentBase)

function SceneStageBase:ctor(scene)
	SceneStageBase.super.ctor(self, scene)
end

function SceneStageBase:onEnterScene(sceneId)
	self:load(sceneId)
end

function SceneStageBase:onExitScene()
	self:unload()
end

function SceneStageBase:_onAllLoaded()
	self._scene:onEnterFinished()
end

function SceneStageBase:load(sceneId)
	return
end

function SceneStageBase:unload()
	return
end

return SceneStageBase
