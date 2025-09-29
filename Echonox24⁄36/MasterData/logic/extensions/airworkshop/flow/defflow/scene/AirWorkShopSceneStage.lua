-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/scene/AirWorkShopSceneStage.lua

module("logic.extensions.airworkshop.flow.defflow.scene.AirWorkShopSceneStage", package.seeall)

local M = class("AirWorkShopSceneStage", SceneStageBase)

function M:onInit()
	self._resLoader = MultiResLoader.New()
	self._activeSceneName = false
	self._goMainSceneBaseHeightMap = false
end

function M:onLeaveScene(isDeepClean)
	if isDeepClean then
		self:onExitScene()
		SpaceX.HeightMapProxy.SetActiveHeightMapProxy(nil)
	else
		SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, false)
	end
end

function M:onReturnScene(isDeepClean)
	if isDeepClean then
		local sceneId = self._scene:getSceneId()

		self:onEnterScene(sceneId)
	else
		SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, true)
	end
end

function M:onReturnSceneFinished(isDeepClean)
	if isDeepClean then
		SpaceX.HeightMapProxy.SetActiveHeightMapProxy(self:getBaseHeightMapGameObject())
	end
end

function M:load(sceneId)
	local checkerBoardCO = BattleConfig.instance:getCheckerBoardCO(sceneId)

	self._mainSceneName = checkerBoardCO.sceneResName
	self._additionSceneName = checkerBoardCO.battleSceneResName
	self._activeSceneName = false

	local resLoader = self._resLoader

	resLoader:addResPath(GameUrl.getSceneUrl(checkerBoardCO.sceneResPath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
end

function M:getSceneName()
	return self._mainSceneName
end

function M:getAdditionSceneName()
	return self._additionSceneName
end

function M:_onAllResourceLoaded()
	self._isSceneResExist = true

	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.ADDITIONAL, true, BattleConst.DefaultStateKey)
	self:_parseSpecialSceneObjects()
	self:_onAllLoaded()
	self:activeMainScene()
end

function M:unload()
	self._isSceneResExist = false

	self._resLoader:clear()
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.ADDITIONAL, false, BattleConst.DefaultStateKey)
end

function M:isSceneResExist()
	return self._isSceneResExist
end

function M:isActiveMainScene()
	return self._activeSceneName == self._mainSceneName
end

function M:activeMainScene()
	if BattleTestUtil.isHideScene() then
		self:_debugHideScene()

		return
	end

	self._activeSceneName = self._mainSceneName

	SceneLoadUtils.SetActiveScene(self._mainSceneName)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, true)
end

function M:getBaseHeightMapGameObject()
	return self._goMainSceneBaseHeightMap
end

function M:_parseSpecialSceneObjects()
	self._goMainSceneBaseHeightMap = GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 5, BattleScene.BaseHeightMapProxyName)

	local goWorldStreamer = GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 5, BattleScene.WorldStreamerName)

	if goWorldStreamer then
		local cameraFollow = VirtualCameraMgr.instance:internal_getCameraFollow()

		self._worldStreamer = goutil.addComponentOnce(goWorldStreamer, ComponentType.WorldStreamer)
		self._worldStreamer.loadWaitFrames = 0
		self._worldStreamer.maxParallelLoading = 10

		self._worldStreamer:SetSplitLoadedCallback(self._onCellLoaded, self)
		self._worldStreamer:SetSplitUnloadCallback(self._onCellUnloaded, self)
		self._worldStreamer:ManualLoadLayer(BattleScene.HighImportanceLayerName)

		self._worldStreamer.Player = cameraFollow:internal_getTargetTransform()
		self._layerCullingSys = goutil.addComponentOnce(goWorldStreamer, ComponentType.LayerCullingSystem)
		self._layerCullingSys.MainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	end
end

function M:_onCellLoaded(goCell)
	SpaceX.SceneObjectCollection.OnChildrenAdded(self._mainSceneName, goCell)
end

function M:_onCellUnloaded()
	SpaceX.SceneObjectCollection.OnChildrenUnloaded(self._mainSceneName, goCell)
end

function M:_debugHideScene()
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 1, ".*[^SceneLighting].*", goList)
	GameObjectUtils.FindChildRecursivelyBySceneName(self._additionSceneName, 1, ".*", goList)

	for _, go in ipairs(goList) do
		goutil.setActive(go, false)
	end
end

return M
