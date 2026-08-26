-- chunkname: @framework/gamescene/BaseSceneComp.lua

module("framework.gamescene.BaseSceneComp", package.seeall)

local BaseSceneComp = class("BaseSceneComp")

function BaseSceneComp:ctor(scene)
	self._sceneObj = scene
	self.isOnStarted = nil

	LuaEventSystem.addEventMechanism(self)
end

function BaseSceneComp:getCurScene()
	return self._sceneObj
end

function BaseSceneComp:onInit()
	return
end

function BaseSceneComp:onSceneStart(sceneId, levelId)
	return
end

function BaseSceneComp:onScenePrepared(sceneId, levelId)
	return
end

function BaseSceneComp:onSceneClose()
	return
end

return BaseSceneComp
