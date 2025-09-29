-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/component/stage/HouseSceneStage.lua

module("logic.extensions.house.scene.component.stage.HouseSceneStage", package.seeall)

local M = class("HouseSceneStage", SceneStageBase)
local kDelimiter = "/"
local lastVolume = "battleglobalvolume"
local RootGoNameStr = "sx-s201_spacestation_p"

function M:onInit()
	M.super.onInit(self)

	self._goHouseRoot = nil
	self._resLoader = false
	self._mainSceneName = false
	self._curSceneCO = false
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	M.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function M:load(sceneId)
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
	HouseModel.instance:setGravitySwitch(false)

	self._curSceneCO = sceneCO
end

function M:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() then
		printError("load resource failed!")
	end

	SceneLoadUtils.SetActiveScene(self._mainSceneName)
	GameObjectUtils.SetSceneActive(self._mainSceneName, true)
	self:_getHouseRoot()
	self._scene.roomMgr:createRoomsToHouse()
	self._scene.unitFactory:createAllElevatorUnit()
	self:_onAllLoaded()
end

function M:getSceneName()
	return self._mainSceneName
end

function M:unload()
	self._scene.unitFactory:removeAllElevator()
	VolumeMgr.instance:turnOff(self._curSceneCO.volumeResPath)
	HouseModel.instance:setGravitySwitch(false)

	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:_getHouseRoot()
	local goList = self:getMainSceneGoList(RootGoNameStr)

	for _, go in pairs(goList) do
		if go.name == RootGoNameStr then
			self._goHouseRoot = go
		end
	end
end

function M:getHouseRootGo()
	return self._goHouseRoot
end

function M:getMainSceneGoList(matchRegex, maxRecursionCount)
	local maxCount = maxRecursionCount or 1
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, maxCount, matchRegex, goList)

	return goList
end

return M
