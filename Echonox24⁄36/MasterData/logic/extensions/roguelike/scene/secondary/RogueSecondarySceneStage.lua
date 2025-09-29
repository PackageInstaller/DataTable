-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/secondary/RogueSecondarySceneStage.lua

module("logic.extensions.roguelike.scene.secondary.RogueSecondarySceneStage", package.seeall)

local M = class("RogueSecondarySceneStage", SceneStageBase)

function M:onInit()
	self._resLoader = false
	self._sceneName = false
end

function M:load(sceneId)
	local resLoader = self._resLoader

	if not resLoader then
		self._resLoader = MultiResLoader.New()
		resLoader = self._resLoader
	end

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._sceneName = SceneCOUtil.getSceneName(sceneCO)

	resLoader:addResPath(GameUrl.getSceneUrl(sceneCO.resPath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
end

function M:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	SceneUtil.removeArtTestSceneGameObject(self._sceneName)
	VirtualCameraMgr.instance:setActiveCamera(VirtualCameraName.Rogue)
	VirtualCameraMgr.instance:setFollowConfiner("confiner_roguelike")
	SceneLoadUtils.SetActiveScene(self._sceneName)
	self:_onAllLoaded()
	settimer(0.2, self._delayAction, self, false)
end

function M:_delayAction()
	MainCameraMgr.instance:setCameraVisible(true)
end

function M:unload()
	if self._resLoader then
		self._resLoader:clear()
	end

	removetimer(self._delayAction, self)
end

return M
