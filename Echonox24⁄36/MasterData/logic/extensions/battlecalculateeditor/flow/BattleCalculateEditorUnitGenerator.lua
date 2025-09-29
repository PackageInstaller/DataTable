-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/flow/BattleCalculateEditorUnitGenerator.lua

module("logic.extensions.battlecalculateeditor.flow.BattleCalculateEditorUnitGenerator", package.seeall)

local BattleCalculateEditorUnitGenerator = {}
local kGGG = getglobal("_G")

function BattleCalculateEditorUnitGenerator.createUnit(entityInfo)
	local unit = BattleUnit:createInstance(entityInfo.entityCode)

	BattleCalculateEditorUnitGenerator.setUnitInfo(unit, entityInfo)
	BattleCalculateEditorUnitGenerator.addUnitToScene(unit)

	local bornDirection = MeshModelDirection[entityInfo.direction]

	unit.meshModelMover:playIdle(true)
	unit.meshModel:jumpToTime(math.random())
	unit.meshModel:lookAtDirVec3(bornDirection)
	unit:setTimeScale(BattleTime.timeScale)

	return unit
end

function BattleCalculateEditorUnitGenerator.setUnitInfo(unit, entityInfo)
	unit.property:setEntityId(entityInfo.entityId)
	unit.property:setEntityType(entityInfo.entityType)
	unit.property:setLevel(entityInfo.level)
	unit.property:setUserId(entityInfo.userId)
	unit.property:setCampId(entityInfo.campId)
	unit.property:setBattleCamp(entityInfo.battleCamp)

	if entityInfo.modelId and entityInfo.modelId > 0 then
		unit.property:setModelCode(entityInfo.modelId)
	end

	if unit.property:isNpc() then
		unit.property:setFlagMask(BattleUnitFlagMask.MaskNpc)
	else
		unit.property:setFlagMask(BattleUnitFlagMask.MaskNormal)
	end

	local modelId = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not entityInfo.lowModelOnly then
		unit.meshModel:loadCacheModel(modelCO)
	end

	unit.meshModel:setBody(ModelCOUtil.getLowModelUrl(modelCO))
	unit.mover:setSpeed(7)

	local materialUrl = BattleUnitUtil.getAddMaterialUrl(unit)

	if materialUrl then
		unit.material:setOriginalMaterial(materialUrl, false)
	end

	local vertices = modelCO.vertices

	unit.transform:setVertexArray(vertices)
	unit:setupEditorDisplayName()

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

	local className = string.format("BattleUnitCompSpecialHandler_%s", modelId)
	local handlerClass = kGGG[className]

	if handlerClass then
		unit:addComponentAndInit("specialHandler", handlerClass)
	end
end

function BattleCalculateEditorUnitGenerator.addUnitToRoot(unit, goRoot)
	goutil.addChildToParent(unit:getGameObject(), goRoot)
end

function BattleCalculateEditorUnitGenerator.addUnitToScene(unit)
	BattleGameObjectRootUtil.addToUnitsRoot(unit:getGameObject())
end

return BattleCalculateEditorUnitGenerator
