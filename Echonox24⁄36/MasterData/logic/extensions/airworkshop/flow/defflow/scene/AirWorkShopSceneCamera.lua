-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/scene/AirWorkShopSceneCamera.lua

module("logic.extensions.airworkshop.flow.defflow.scene.AirWorkShopSceneCamera", package.seeall)

local AirWorkShopSceneCamera = class("AirWorkShopSceneCamera", SceneComponentBase)
local kDefaultCameraCode = VirtualCameraName.BattleNormal
local kDiffEdge = 0.5 * SpaceX.CheckBoardSetting.GetSideLength()

function AirWorkShopSceneCamera:onEnterScene(sceneId, bornX, bornZ)
	local checkerBoardCO = BattleConfig.instance:getCheckerBoardCO(sceneId)

	VirtualCameraMgr.instance:resetCameraSettings()
	VirtualCameraMgr.instance:setActiveCamera(kDefaultCameraCode)
	self:_setConfiner(checkerBoardCO)

	local cameraCO = CameraConfig.instance:getCameraCO(kDefaultCameraCode)

	MainCameraMgr.instance:setCameraMaskMode(cameraCO.cameraMaskMode)

	local camera = MainCameraMgr.instance:getMainCamera()

	URPCameraUtils.SetBackgroundTypeColor(camera, nil)
end

function AirWorkShopSceneCamera:onExitScene()
	MainCameraMgr.instance:setDefaultCameraMask()
	VirtualCameraMgr.instance:clearFollowConfiner()

	local camera = MainCameraMgr.instance:getMainCamera()
end

function AirWorkShopSceneCamera:onLeaveScene()
	self:onExitScene()
end

function AirWorkShopSceneCamera:onReturnScene()
	local sceneId = self._scene:getSceneId()

	self:onEnterScene(sceneId)
end

function AirWorkShopSceneCamera:_setConfiner(checkerBoardCO)
	if string.nilorempty(checkerBoardCO.battleConfiner) then
		VirtualCameraMgr.instance:useEmptyConfiner()

		local minx, maxx, minz, maxz = self:_calculateBoundingBox(checkerBoardCO)
		local sideLength = SpaceX.CheckBoardSetting.GetSideLength()

		minx = minx * sideLength + kDiffEdge
		maxx = maxx * sideLength - kDiffEdge
		minz = minz * sideLength + kDiffEdge
		maxz = maxz * sideLength - kDiffEdge

		local polygon = VirtualCameraMgr.instance:getPolygonColliderPolygon()

		polygon:Clear()
		polygon:AddPoint(minx, minz)
		polygon:AddPoint(minx, maxz)
		polygon:AddPoint(maxx, maxz)
		polygon:AddPoint(maxx, minz)
	else
		VirtualCameraMgr.instance:setFollowConfiner(checkerBoardCO.battleConfiner)
	end
end

local INT_MAX = 4294967295

function AirWorkShopSceneCamera:_calculateBoundingBox(checkerBoardCO)
	local minx = INT_MAX
	local minz = INT_MAX
	local maxx = 0
	local maxz = 0
	local cellConfigs = checkerBoardCO.cellConfigs

	for _, cellCO in ipairs(cellConfigs) do
		if cellCO.isEnable then
			local x = cellCO.coordinates[1]
			local z = cellCO.coordinates[2]

			minx = math.min(minx, x)
			maxx = math.max(maxx, x)
			minz = math.min(minz, z)
			maxz = math.max(maxz, z)
		end
	end

	return minx, maxx + 1, minz, maxz + 1
end

return AirWorkShopSceneCamera
