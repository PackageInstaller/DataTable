-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/SceneMgrBase.lua

module("frameworkext.scene.SceneMgrBase", package.seeall)

local SceneMgrBase = class("SceneMgrBase")

function SceneMgrBase:ctor()
	self._curSceneType = 0
	self._curSceneId = 0
	self._lastSceneType = 0
	self._lastSceneId = 0
	self._scenes = {}
	self._root = goutil.find("SCENEROOT")
	self._isEnetering = false
	self._enterCmds = {}

	self:_extendConstDef()
	self:_createSingletonComps()
	self:_registerScenes()
end

function SceneMgrBase:_registerScene(sceneType, SceneCls)
	local container = goutil.create(SceneCls.__cname, false)

	goutil.addChildToParent(container, self._root)

	local scene = SceneCls.New(container)

	scene:setEnterFinishedHandler(self.onEnterFinished, self)

	self._scenes[sceneType] = scene
end

function SceneMgrBase:getScene(sceneType)
	return self._scenes[sceneType]
end

function SceneMgrBase:getCurSceneType()
	return self._curSceneType
end

function SceneMgrBase:getCurSceneId()
	return self._curSceneId
end

function SceneMgrBase:getCurScene()
	if self._curSceneType then
		return self._scenes[self._curSceneType]
	end

	return nil
end

function SceneMgrBase:_checkNextEnterCmd()
	if #self._enterCmds > 0 then
		local cmd = self._enterCmds[1]

		table.remove(self._enterCmds, 1)
		self:enter(cmd[1], cmd[2], cmd[3], cmd[4])
	end
end

function SceneMgrBase:exitCurScene()
	if self._curSceneType == 0 or self._curSceneId == 0 then
		return
	end

	self:_showLoading()

	self._lastSceneType = self._curSceneType
	self._lastSceneId = self._curSceneId

	local curScene = self._scenes[self._curSceneType]

	curScene:onExit()

	self._curSceneType = 0
	self._curSceneId = 0
end

function SceneMgrBase:onExitFinished()
	self:_hideLoading()
end

function SceneMgrBase:enter(sceneType, sceneId, bornX, bornZ)
	if self._isEnetering then
		local cmd = {
			sceneType,
			sceneId,
			bornX,
			bornZ
		}

		table.insert(self._enterCmds, cmd)

		return
	end

	if self._curSceneType == sceneType and self._curSceneId == sceneId then
		self:_checkNextEnterCmd()

		return
	end

	self:_showLoading()

	self._isEnetering = true

	if self._curSceneType > 0 and self._curSceneId > 0 then
		local curScene = self._scenes[self._curSceneType]

		curScene:onExit()
	end

	self._lastSceneType = self._curSceneType
	self._lastSceneId = self._curSceneId
	self._curSceneType = sceneType
	self._curSceneId = sceneId

	local scene = self._scenes[sceneType]

	scene:onEnter(sceneId, bornX, bornZ)
end

function SceneMgrBase:onEnterFinished()
	self._isEnetering = false

	self:_hideLoading()
	self:_checkNextEnterCmd()
end

function SceneMgrBase:_extendConstDef()
	return
end

function SceneMgrBase:_registerScenes()
	return
end

function SceneMgrBase:_createSingletonComps()
	return
end

function SceneMgrBase:_showLoading()
	return
end

function SceneMgrBase:_hideLoading()
	return
end

return SceneMgrBase
