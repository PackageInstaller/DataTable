-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/camera/BattleSceneCamera.lua

module("logic.scene.component.camera.BattleSceneCamera", package.seeall)

local BattleSceneCamera = class("BattleSceneCamera", SceneComponentBase)
local kDefaultCameraCode = VirtualCameraName.BattleNormal
local kDiffEdge = 0.5 * SpaceX.CheckBoardSetting.GetSideLength()

function BattleSceneCamera:onEnterScene(sceneId, bornX, bornZ)
	local checkerBoardCO = BattleConfig.instance:getCheckerBoardCO(sceneId)

	VirtualCameraMgr.instance:resetCameraSettings()
	VirtualCameraMgr.instance:setActiveCamera(kDefaultCameraCode)
	self:_setConfiner(checkerBoardCO)

	local cameraCO = CameraConfig.instance:getCameraCO(kDefaultCameraCode)

	MainCameraMgr.instance:setCameraMaskMode(cameraCO.cameraMaskMode)

	local camera = MainCameraMgr.instance:getMainCamera()

	URPCameraUtils.SetBackgroundTypeColor(camera, nil)
end

function BattleSceneCamera:onExitScene()
	MainCameraMgr.instance:setDefaultCameraMask()
	VirtualCameraMgr.instance:clearFollowConfiner()
end

function BattleSceneCamera:onLeaveScene()
	MainCameraMgr.instance:setDefaultCameraMask()
	VirtualCameraMgr.instance:clearFollowConfiner()
end

function BattleSceneCamera:onReturnScene()
	self:onEnterScene(self._scene:getSceneId())
end

function BattleSceneCamera:_setConfiner(checkerBoardCO)
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

function BattleSceneCamera:_calculateBoundingBox(checkerBoardCO)
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

return BattleSceneCamera
