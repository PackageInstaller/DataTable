-- chunkname: @framework/gamescene/BaseScene.lua

module("framework.gamescene.BaseScene", package.seeall)

local BaseScene = class("BaseScene")

function BaseScene:ctor(go)
	self._gameObj = go
	self._onPreparedCb = nil
	self._onPreparedCbObj = nil
	self._onPreparedOneCb = nil
	self._onPreparedOneCbObj = nil
	self._curSceneId = 0
	self._curLevelId = 0
	self._isClosing = false
	self._allComps = {}

	self:_createAllComps()

	for _, comp in ipairs(self._allComps) do
		if comp.onInit then
			comp:onInit()
		end
	end
end

function BaseScene:getSceneContainerGO()
	return self._gameObj
end

function BaseScene:getCurLevelId()
	return self._curLevelId
end

function BaseScene:setCurLevelId(levelId)
	self._curLevelId = levelId
end

function BaseScene:setOnPreparedCb(callback, cbObj)
	self._onPreparedCb = callback
	self._onPreparedCbObj = cbObj
end

function BaseScene:setOnPreparedOneCb(callback, cbObj)
	self._onPreparedOneCb = callback
	self._onPreparedOneCbObj = cbObj
end

function BaseScene:onStart(sceneId, levelId)
	self._curSceneId = sceneId
	self._curLevelId = levelId

	for _, comp in ipairs(self._allComps) do
		if comp.onSceneStart and not comp.isOnStarted then
			comp:onSceneStart(sceneId, levelId)
		end
	end
end

function BaseScene:onPrepared()
	for _, comp in ipairs(self._allComps) do
		if comp.onScenePrepared then
			comp:onScenePrepared(self._curSceneId, self._curLevelId)
		end
	end

	if not self._onPreparedCb then
		return
	end

	callWithCatch(self._onPreparedCb, self._onPreparedCbObj)
end

function BaseScene:onDirectorLoadedOne()
	if not self._onPreparedOneCb then
		return
	end

	callWithCatch(self._onPreparedOneCb, self._onPreparedOneCbObj)
end

function BaseScene:onClose()
	self._isClosing = true

	for _, comp in ipairs(self._allComps) do
		if comp.onSceneClose then
			comp:onSceneClose()
		end
	end

	self._isClosing = false
end

function BaseScene:isClosing()
	return self._isClosing
end

function BaseScene:_addComp(compName, compDefine)
	local compObj = compDefine.New(self)

	self[compName] = compObj

	table.insert(self._allComps, compObj)
end

function BaseScene:_createAllComps()
	return
end

return BaseScene
