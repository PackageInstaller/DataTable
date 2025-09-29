-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/flow/flowcomp/HouseSceneNavigationMgr.lua

module("logic.extensions.house.scene.flow.flowcomp.HouseSceneNavigationMgr", package.seeall)

local M = class("HouseSceneNavigationMgr", ISceneFlowComp)
local kRootPathStr = "otherResources/sx-s201_t-sceneheight/%s"
local kPoints = {
	{
		funcName = "setLeftBorderPos",
		goName = "point_border_left"
	},
	{
		funcName = "setRightBorderPos",
		goName = "point_border_right"
	},
	{
		funcName = "setLeftSuitPos",
		goName = "point_suit_left"
	},
	{
		funcName = "setRightSuitPos",
		goName = "point_suit_right"
	},
	{
		funcName = "setCreateGoodsPos",
		goName = "point_goods_create"
	},
	{
		funcName = "setReturnGoodsPos",
		goName = "point_goods_return"
	}
}

function M:onSceneLoadDone()
	local curScene = SceneMgr.instance:getCurScene()
	local houseRootGo = curScene.stage:getHouseRootGo()
	local isHouseScene = SceneMgr.instance:getCurSceneType() == SceneType.House

	HouseNavigationModel.instance:clearNavigationMOs()

	local pointGO = goutil.create("dataPoint", false)
	local COs = HouseConfig.instance:getConfigList(ConfigName.HouseZone)

	for _, CO in ipairs(COs) do
		if not string.nilorempty(CO.navGoName) then
			local navMO = HouseNavigationMO.New(CO)
			local surfaceGO = self:_setData(houseRootGo, navMO, pointGO)

			HouseNavigationModel.instance:addNavigationMO(navMO)

			local roomUnit = curScene.roomMgr:getUnitById(navMO:getZoneId())

			if roomUnit then
				roomUnit.model:setNavigationData(navMO)
				roomUnit.roomNavMesh:setSurfaceGO(surfaceGO)
			end
		end
	end

	self:_findAllLink(houseRootGo)
	goutil.destroy(pointGO)
end

function M:_setData(houseRootGo, navMO, pointGO)
	if goutil.isNil(houseRootGo) then
		return
	end

	local navmeshSurfaceGo = goutil.findChild(houseRootGo, string.format(kRootPathStr, navMO:getSurfaceGoName()))

	goutil.addChildToParent(pointGO, navmeshSurfaceGo)

	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(navmeshSurfaceGo.transform, 0, 0, 0)
	local angle = MathUtil.normalizeAngle(rotaZ)

	navMO:setNavGoAngle(math.round(angle))

	local function _toWorldPos(pos)
		Astral.TransformUtil.SetLocalPos(pointGO.transform, pos.x, pos.y, pos.z)

		return Astral.TransformUtil.GetPos(pointGO.transform, 0, 0, 0)
	end

	local function _toWorkRot(rot)
		Astral.TransformUtil.SetLocalRotation(pointGO.transform, rot.x, rot.y, rot.z)

		return TransformUtils.GetEulerAngles(pointGO.transform, 0, 0, 0)
	end

	local key = navMO:getPatrolpointKey()

	if not string.nilorempty(key) then
		local arrayPatrolPoint = {}
		local points = HouseConfig.getPatrolPoints(key)

		for i, point in ipairs(points) do
			local posX, posY, posZ = _toWorldPos(point)

			table.insert(arrayPatrolPoint, Vector3.New(posX, posY, posZ))
		end

		navMO:setPatrolPoints(arrayPatrolPoint)
	end

	for _, data in ipairs(kPoints) do
		local goPoint = goutil.findChild(navmeshSurfaceGo, data.goName)

		if goPoint then
			local func = navMO[data.funcName]

			func(navMO, Vector3.New(Astral.TransformUtil.GetPos(goPoint.transform, 0, 0, 0)))
		end
	end

	local workPoints = HouseConfig.instance:getConfigByKey(ConfigName.WorkPoints, navMO:getSurfaceGoName())

	if workPoints then
		local arrayWorkPoints = {}

		for _, point in ipairs(workPoints) do
			local posX, posY, posZ = _toWorldPos(point.pos)
			local rotX, rotY, rotZ = _toWorkRot(point.rot)

			table.insert(arrayWorkPoints, {
				pos = Vector3.New(posX, posY, posZ),
				rot = Vector3.New(rotX, rotY, rotZ)
			})
		end

		navMO:setWorkPoints(arrayWorkPoints)
	end

	return navmeshSurfaceGo
end

function M:_findAllLink(houseRootGo)
	if goutil.isNil(houseRootGo) then
		return
	end

	local linkRootGO = goutil.findChild(houseRootGo, string.format(kRootPathStr, "link_root"))
	local childList = Astral.GameObjectUtil.GetChildren(linkRootGO)

	for i = 0, childList.Length - 1 do
		local linkGO = childList[i]
		local link = linkGO:GetComponent(ComponentType.NavMeshLink)
		local idArray = string.split(linkGO.name, "_")
		local leftZoneId = checknumber(idArray[1])
		local rightZoneId = checknumber(idArray[2])

		if leftZoneId > 0 and rightZoneId > 0 then
			local leftMO = HouseNavigationModel.instance:getMOByZoneId(leftZoneId)

			leftMO:setRightLink(link)

			local rightMO = HouseNavigationModel.instance:getMOByZoneId(rightZoneId)

			rightMO:setLeftLink(link)
		end
	end
end

function M:onExitDone()
	HouseNavigationModel.instance:clearNavigationMOs()
end

return M
