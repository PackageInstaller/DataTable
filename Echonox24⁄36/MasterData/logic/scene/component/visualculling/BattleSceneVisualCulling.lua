-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/visualculling/BattleSceneVisualCulling.lua

module("logic.scene.component.visualculling.BattleSceneVisualCulling", package.seeall)

local BattleSceneVisualCulling = class("BattleSceneVisualCulling", SceneComponentBase)
local kTypeCameraBlockObject = typeof(SpaceX.CameraBlockObject)

function BattleSceneVisualCulling:onInit()
	self._blockChecker = false
	self._visualUnitList = false
	self._isEnableCulling = false
end

function BattleSceneVisualCulling:onEnterScene()
	self._isEnableCulling = false

	self:_setEvent(true)
	self:_turnOnFrustum()
end

function BattleSceneVisualCulling:onExitScene()
	self:_setEvent(false)
	self:_turnOffFrustum()

	for i, unit in ipairs(self._visualUnitList) do
		unit:clear()
	end

	BattleTableUtil.clearTable(self._visualUnitList)
end

function BattleSceneVisualCulling:onLeaveScene()
	self:onExitScene()
end

function BattleSceneVisualCulling:onReturnScene()
	self:onEnterScene()
end

function BattleSceneVisualCulling:onReturnSceneFinished()
	self:_reloadObject()
end

function BattleSceneVisualCulling:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleEnterFinish, self._reloadObject, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEnableCullingChanged, self._onEnableCullingChanged, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleEnterFinish, self._reloadObject, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEnableCullingChanged, self._onEnableCullingChanged, self)
	end
end

function BattleSceneVisualCulling:_onEnableCullingChanged(evt, enable)
	self._isEnableCulling = enable

	self:_onCameraUpdate()
end

function BattleSceneVisualCulling:_reloadObject()
	self:_reloadVisualObjects()
	self:_onCameraUpdate()
end

function BattleSceneVisualCulling:_turnOnFrustum()
	if not self._blockChecker then
		local goBlockChecker = goutil.create("BattleBlockChecker", false)

		BattleGameObjectRootUtil.addToSignsRoot(goBlockChecker)

		self._blockChecker = SpaceX.CameraBlockChecker.Get(goBlockChecker)

		self._blockChecker:SetCameraUpdateListener(self._onCameraUpdate, self)
		self._blockChecker:SetCamera(MainCameraMgr.instance:getMainCamera())

		self._visualUnitList = {}
	end

	goutil.setActive(self._blockChecker.gameObject, true)
end

function BattleSceneVisualCulling:_turnOffFrustum()
	goutil.setActive(self._blockChecker.gameObject, false)
end

function BattleSceneVisualCulling:_onCameraUpdate()
	if not self:_checkTargetScene() then
		return
	end

	local position = VirtualCameraMgr.instance:getFollowPosition()

	self._blockChecker:SetTargetPosition(position:Get())
	self:_checkVisualObjects()
end

function BattleSceneVisualCulling:_checkVisualObjects()
	local blockChecker = self._blockChecker

	for i, unit in ipairs(self._visualUnitList) do
		local blockObject = unit:getBlockObject()
		local enable = blockChecker:IsBlockCamera(blockObject)

		unit:setTransparencyEnable(self._isEnableCulling and enable)
	end
end

function BattleSceneVisualCulling:_reloadVisualObjects()
	local resultObjects = BattleTableUtil.getTempList()
	local sceneName = self._scene.stage:getSceneName()

	GameObjectUtils.FindChildRecursivelyBySceneName(sceneName, 5, BattleScene.DynamicVisualObjectsName, resultObjects)

	local componentList = BattleTableUtil.getTempList()

	for _, rootObject in ipairs(resultObjects) do
		GameObjectUtils.CollectSpecificComponentChildren(rootObject, kTypeCameraBlockObject, componentList)

		for _, component in ipairs(componentList) do
			local unit = BattleSceneVisualUnit.New(component.gameObject)

			table.insert(self._visualUnitList, unit)
		end

		table.clear(componentList)
	end

	BattleTableUtil.releaseTempList(componentList)
	BattleTableUtil.releaseTempList(resultObjects)
end

function BattleSceneVisualCulling:_checkTargetScene()
	return self._scene.stage:isActiveMainScene()
end

return BattleSceneVisualCulling
