-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/SceneComponentBase.lua

module("frameworkext.scene.SceneComponentBase", package.seeall)

local SceneComponentBase = class("SceneComponentBase")

function SceneComponentBase:ctor(scene)
	self._scene = scene

	NotifyDispatcher.extend(self)
end

function SceneComponentBase:onInit()
	return
end

function SceneComponentBase:onEnterScene(sceneId, bornX, bornZ)
	return
end

function SceneComponentBase:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneComponentBase:onExitScene()
	return
end

return SceneComponentBase
