-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/stage/RoomSceneStage.lua

module("logic.extensions.mainui.scene.stage.RoomSceneStage", package.seeall)

local M = class("RoomSceneStage", SceneStageBase)
local lastVolume = "battleglobalvolume"
local RootGoNameStr = "sx-s001_mainscene"

function M:onInit()
	M.super.onInit(self)

	self._goHouseRoot = nil
	self._resLoader = false
	self._mainSceneName = false
	self._curSceneCO = false
	self._loadFinish = false
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	M.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function M:onExitScene()
	M.super.onExitScene(self)

	self._goHouseRoot = nil
	self._goSceneLight = nil
	self._sceneEnviromentAnimation = nil
end

function M:onLeaveScene(needUnloadRes)
	if not needUnloadRes then
		GameObjectUtils.SetSceneActive(self._mainSceneName, false)

		return
	end

	self._goHouseRoot = nil
	self._goSceneLight = nil
	self._sceneEnviromentAnimation = nil

	self:onExitScene()
end

function M:onReturnScene(needUnloadRes)
	if not needUnloadRes then
		SceneLoadUtils.SetActiveScene(self._mainSceneName)
		GameObjectUtils.SetSceneActive(self._mainSceneName, true)

		return
	end

	self:load(self._scene:getSceneId())
end

function M:onSetupSceneOptimization()
	SceneUtil.setupSceneOptimization(self._mainSceneName)
end

function M:load(sceneId)
	self._loadFinish = false

	local resLoader = self._resLoader

	if not resLoader then
		self._resLoader = MultiResLoader.New()
		resLoader = self._resLoader
	end

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._mainSceneName = SceneCOUtil.getSceneName(sceneCO)

	resLoader:addResPath(GameUrl.getSceneUrl(sceneCO.resPath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
	VolumeMgr.instance:turnOff(lastVolume)
	VolumeMgr.instance:turnOn(sceneCO.volumeResPath)

	self._curSceneCO = sceneCO
end

function M:_onAllResourceLoaded()
	self._loadFinish = true

	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() then
		printError("load resource failed!")
	end

	SceneLoadUtils.SetActiveScene(self._mainSceneName)
	GameObjectUtils.SetSceneActive(self._mainSceneName, true)
	self:onSetupSceneOptimization()
	self:_getHouseRoot()
	self:_onAllLoaded()
end

function M:getSceneName()
	return self._mainSceneName
end

function M:getIsLoadFinish()
	return self._loadFinish
end

function M:unload()
	VolumeMgr.instance:turnOff(self._curSceneCO.volumeResPath)

	if self._resLoader then
		self._resLoader:clear()
	end

	self._sceneEnviromentAnimation = nil
	self._loadFinish = false
end

function M:_getHouseRoot()
	local goList = self:getMainSceneGoList(RootGoNameStr)

	for _, go in pairs(goList) do
		if go.name == RootGoNameStr then
			self._goHouseRoot = go
		end
	end

	goList = self:getMainSceneGoList("SceneLighting")

	for _, go in pairs(goList) do
		if go.name == "SceneLighting" then
			self._goSceneLight = go
		end
	end
end

function M:getHouseRootGo()
	if not self._goHouseRoot then
		self:_getHouseRoot()
	end

	return self._goHouseRoot
end

function M:getMainSceneGoList(matchRegex, maxRecursionCount)
	local maxCount = maxRecursionCount or 1
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, maxCount, matchRegex, goList)

	return goList
end

function M:getMainSceneGo(matchRegex, maxRecursionCount)
	if not self:getHouseRootGo() then
		return nil
	end

	local go

	if string.match(matchRegex, "/") then
		go = goutil.findChild(self:getHouseRootGo(), matchRegex)
		go = go and go.gameObject

		return go
	end

	local root = goutil.findChild(self:getHouseRootGo(), "interaction")
	local rootTr = root.transform

	for i = 0, rootTr.childCount - 1 do
		if not go then
			local r1 = rootTr:GetChild(i)

			if r1.gameObject.name == matchRegex then
				go = r1.gameObject
			elseif r1.transform.childCount > 0 then
				local tmpGo = self:_findChild(r1, matchRegex)

				go = tmpGo and tmpGo or go
			end
		end
	end

	return go
end

function M:_findChild(tmpRoot, matchName)
	local go
	local tr = tmpRoot.transform
	local childCount = tr.childCount

	if childCount > 0 then
		for i = 0, childCount - 1 do
			if not go then
				local tmp = tr:GetChild(i)

				if tmp.gameObject.name == matchName then
					go = tmp.gameObject
				end
			end
		end
	end

	return go
end

function M:getInteractPointGo(point)
	local name = string.format("interact_p_%s", point)

	return self:getMainSceneGo(name, 4)
end

function M:getSceneLight()
	if not self._goSceneLight then
		self:_getHouseRoot()
	end

	return self._goSceneLight
end

function M:getSceneEnviromentAnimation()
	if not self._sceneEnviromentAnimation then
		self._sceneEnviromentAnimation = goutil.findChildComponent(self:getHouseRootGo(), "Main scene enviroment wrapper", ComponentType.Animation)
	end

	return self._sceneEnviromentAnimation
end

return M
