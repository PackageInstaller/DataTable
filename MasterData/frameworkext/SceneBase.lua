-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/SceneBase.lua

module("frameworkext.scene.SceneBase", package.seeall)

local SceneBase = class("SceneBase")

function SceneBase:ctor(container)
	self._container = container
	self._enterFinishedHandler = nil
	self._enterFinishedObj = nil
	self._curSceneId = 0
	self._curBornX = 0
	self._curBornZ = 0
	self._isExiting = false
	self._compList = {}

	self:_initComponents()

	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i].onInit then
			self._compList[i]:onInit()
		end
	end
end

function SceneBase:getSceneId()
	return self._curSceneId
end

function SceneBase:getBornX()
	return self._curBornX
end

function SceneBase:getBornZ()
	return self._curBornZ
end

function SceneBase:getContainer()
	return self._container
end

function SceneBase:setEnterFinishedHandler(enterFinishedHandler, enterFinishedObj)
	self._enterFinishedHandler = enterFinishedHandler
	self._enterFinishedObj = enterFinishedObj
end

function SceneBase:_addComponent(compName, compClass)
	local compInst

	if compClass.instance then
		compInst = compClass.instance
		self[compName] = compClass.instance
	else
		compInst = compClass.New(self)
		self[compName] = compInst
	end

	table.insert(self._compList, compInst)
end

function SceneBase:onEnterFinished()
	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i].onEnterSceneFinished then
			self._compList[i]:onEnterSceneFinished(self._curSceneId, self._curBornX, self._curBornZ)
		end
	end

	if self._enterFinishedHandler then
		self._enterFinishedHandler(self._enterFinishedObj)
	end
end

function SceneBase:onEnter(sceneId, bornX, bornZ)
	self._curSceneId = sceneId
	self._curBornX = bornX
	self._curBornZ = bornZ

	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i].onEnterScene then
			self._compList[i]:onEnterScene(sceneId, bornX, bornZ)
		end
	end
end

function SceneBase:onExit()
	self._isExiting = true

	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i].onExitScene then
			self._compList[i]:onExitScene()
		end
	end

	self._isExiting = false
end

function SceneBase:isExiting()
	return self._isExiting
end

function SceneBase:_initComponents()
	return
end

return SceneBase
