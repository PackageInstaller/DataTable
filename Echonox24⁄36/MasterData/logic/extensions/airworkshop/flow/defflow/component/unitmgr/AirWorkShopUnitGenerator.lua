-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/unitmgr/AirWorkShopUnitGenerator.lua

module("logic.extensions.airworkshop.flow.defflow.component.unitmgr.AirWorkShopUnitGenerator", package.seeall)

local AirWorkShopUnitGenerator = {}
local kGGG = getglobal("_G")

function AirWorkShopUnitGenerator.createHeroUnit(heroMO)
	local unit = AirWorkShopHeroUnit:createInstance()

	unit.property:setUnitMO(heroMO)
	AirWorkShopUnitGenerator.setHeroUnitInfo(unit, heroMO)
	AirWorkShopUnitGenerator.addUnitToScene(unit)

	local bornIndex = heroMO:getUnionIndex()
	local bornDirection = MeshModelDirection[1]

	unit.meshModelMover:playIdle(true)
	unit.meshModel:jumpToTime(math.random())
	unit.meshModel:lookAtDirVec3(bornDirection)

	return unit
end

function AirWorkShopUnitGenerator.setHeroUnitInfo(unit, heroMO)
	local entityCO = BattleConfigUtil.getEntityConfig(heroMO:getId())

	unit.property:setEntityId(heroMO:getEntityId())
	unit.property:setEntityCode(heroMO:getId())

	unit.go.name = heroMO:getId()

	local modelId = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	unit.meshModel:loadCacheModel(modelCO)
	unit.meshModel:setBody(ModelCOUtil.getLowModelUrl(modelCO))
	unit.mover:setSpeed(7)

	local vertices = modelCO.vertices

	unit.transform:setVertexArray(vertices)
	unit.uiProxy:rebuildUI()

	local isShowUnitUI = AirWorkShopDefSceneModel.instance:isShowUnitUI()
	local goAvatar = unit.mountRoot:getAvatarRoot()
	local transAvatar = goAvatar.transform
	local transBar = unit.mountRoot:getBarRoot().transform
	local positionOffsets = ModelCOUtil.getPositionOffsets(modelCO)

	if positionOffsets then
		Astral.TransformUtil.SetLocalPos(transAvatar, positionOffsets[1], BattleConst.YOffsetAvatar, positionOffsets[2])
		Astral.TransformUtil.SetLocalPos(transBar, positionOffsets[1], BattleConst.YOffsetAvatar, positionOffsets[2])
	else
		Astral.TransformUtil.SetLocalPos(transAvatar, 0, BattleConst.YOffsetAvatar, 0)
		Astral.TransformUtil.SetLocalPos(transBar, 0, BattleConst.YOffsetAvatar, 0)
	end
end

function AirWorkShopUnitGenerator.createBuildingUnit(highlandMO)
	local unit = AirWorkShopBuildingUnit:createInstance()

	unit.property:setUnitMO(highlandMO)
	AirWorkShopUnitGenerator.setHighlandUnitInfo(unit, highlandMO)
	AirWorkShopUnitGenerator.addUnitToScene(unit)

	return unit
end

function AirWorkShopUnitGenerator.setHighlandUnitInfo(unit, highlandMO)
	unit.property:setEntityId(highlandMO:getEntityId())
	unit.property:setEntityCode(highlandMO:getId())

	unit.go.name = highlandMO:getId()

	local entityCO = AirWorkShopConfig.instance:getBuildingCO(highlandMO:getId())

	unit.meshModel:setBody(AirWorkShopDefSceneUtil.getBuildingPath(entityCO))
	unit.transform:setShape(entityCO.shape)

	if AirWorkShopDefMgr.instance:isInDefFlow() then
		unit.uiProxy:rebuildUI()
	end

	local goAvatar = unit.mountRoot:getAvatarRoot()
	local transAvatar = goAvatar.transform
	local transBar = unit.mountRoot:getBarRoot().transform
	local dx, dz = unit.transform:getCenterOffSet()

	Astral.TransformUtil.SetLocalPos(transAvatar, dx, BattleConst.YOffsetAvatar, dz)
	Astral.TransformUtil.SetLocalPos(transBar, dx, BattleConst.YOffsetAvatar, dz)
end

function AirWorkShopUnitGenerator.createBornPos(bornMO)
	local unit = AirWorkShopBornUnit:createInstance()

	unit.property:setUnitMO(bornMO)

	unit.go.name = unit.property:getName()

	unit.meshModel:setBody(ResName.AirWorkShop_air_workshop_def_born_pos)
	AirWorkShopUnitGenerator.addUnitToScene(unit)

	if AirWorkShopDefMgr.instance:isInDefFlow() then
		unit.uiProxy:rebuildUI()
	end

	return unit
end

function AirWorkShopUnitGenerator.createLeavePos(unitMO)
	local unit = AirWorkLeaveUnit:createInstance()

	unit.property:setUnitMO(unitMO)

	unit.go.name = unit.property:getName()

	unit.meshModel:setBody(GameUrl.getTerrainModelUrl("terrains_102_zanshi"))
	AirWorkShopUnitGenerator.addUnitToScene(unit)

	if AirWorkShopDefMgr.instance:isInDefFlow() then
		unit.uiProxy:rebuildUI()
	end

	return unit
end

function AirWorkShopUnitGenerator.setModelQuality(unit, isHigh)
	local modelId = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	unit.meshModel:setBody(isHigh and ModelCOUtil.getHighModelUrl(modelCO) or ModelCOUtil.getLowModelUrl(modelCO))
end

function AirWorkShopUnitGenerator.addUnitToScene(unit)
	BattleGameObjectRootUtil.addToUnitsRoot(unit:getGameObject())
end

function AirWorkShopUnitGenerator.addUnitToRoot(unit, goRoot)
	goutil.addChildToParent(unit:getGameObject(), goRoot)
end

function AirWorkShopUnitGenerator.removeUnit(unit)
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local boardModel = AirWorkShopDefMgr.instance:getBoardModel()

	if unit.transform then
		boardModel:removeUnit(unit)
	end

	unitMgr:removeUnit(unit)
end

function AirWorkShopUnitGenerator.destroyUnit(unit)
	printWarn("viking", unit.property:getName())
	unit:returnSelf()
end

return AirWorkShopUnitGenerator
