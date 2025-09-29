-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/unitmgr/BattleUnitGenerator.lua

module("logic.battle.battleflow.component.unitmgr.BattleUnitGenerator", package.seeall)

local BattleUnitGenerator = {}
local kGGG = getglobal("_G")

function BattleUnitGenerator.createUnit(entityInfo)
	if entityInfo.entityType == BattleEnum.EntityType.Intangible then
		local unit = BattleUnitGenerator.createIntangible(entityInfo)

		return unit
	end

	if entityInfo.entityType == BattleEnum.EntityType.HaloTerrain then
		local unit = BattleUnitGenerator.createAdditionalTerrain(entityInfo.entityCode)

		BattleUnitGenerator.setAdditionalTerrainInfo(unit, entityInfo)
		BattleUnitGenerator.setUnitToUnionIndex(unit, entityInfo.bornUnionIndex)

		return unit
	end

	local unit = BattleUnit:createInstance(entityInfo.entityCode)

	BattleUnitGenerator.setUnitInfo(unit, entityInfo)
	BattleUnitGenerator.addUnitToScene(unit)
	unit.meshModelMover:playIdle(true)
	unit.meshModel:jumpToTime(math.random())
	unit:setTimeScale(BattleTime.timeScale)

	return unit
end

function BattleUnitGenerator.setUnitInfo(unit, entityInfo)
	local entityCO = BattleConfigUtil.getEntityConfig(entityInfo.entityCode, entityInfo.entityType)

	unit.property:setEntityId(entityInfo.entityId)
	unit.property:setEntityType(entityInfo.entityType)
	unit.property:setLevel(entityInfo.level)
	unit.property:setUserId(entityInfo.userId)
	unit.property:setCampId(entityInfo.campId)
	unit.property:setBattleCamp(entityInfo.battleCamp)
	unit.property:setEntityCode(entityInfo.entityCode)
	unit.property:setViewEntityCode(entityInfo.viewEntityCode)
	unit.property:setBodyEffect(entityInfo.bodyEffect)

	if entityInfo.modelId and entityInfo.modelId > 0 then
		unit.property:setModelCode(entityInfo.modelId)
	end

	if unit.property:isNpc() then
		unit.property:setFlagMask(BattleUnitFlagMask.MaskNpc)
	elseif unit.property:isSkipStep() then
		unit.property:setFlagMask(BattleUnitFlagMask.MaskAttackable)
	else
		unit.property:setFlagMask(BattleUnitFlagMask.MaskNormal)
	end

	local attributes = entityInfo.attributes

	for attributeCode, attributeValue in pairs(attributes) do
		unit.property:setAttribute(attributeCode, attributeValue)
	end

	local baseAttributes = entityInfo.baseAttributes

	for attributeCode, attributeValue in pairs(baseAttributes) do
		unit.property:setBaseAttribute(attributeCode, attributeValue)
	end

	local states = entityInfo.states

	for _, stateCode in pairs(states) do
		unit.property:activeState(stateCode)
	end

	local tags = entityInfo.tags

	for _, tag in pairs(tags) do
		unit.property:addTag(tag)
	end

	unit.property:addTag(tostring(entityInfo.entityCode))

	local immuneBuffs = entityInfo.immuneBuffs

	for _, buff in pairs(immuneBuffs) do
		unit.property:addImmuneBuff(buff)
	end

	for _, skill in pairs(entityInfo.skills) do
		unit.skill:addSkillFromSkillInfo(skill)
	end

	unit.skill:addTagEnhances(entityInfo.tagEnhances)

	for _, buff in pairs(entityInfo.buffs) do
		unit.buff:addBuff(buff.id, buff.buffCode, buff.round, buff.layer)
	end

	local modelId = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not entityInfo.lowModelOnly then
		unit.meshModel:loadCacheModel(modelCO)
	end

	unit.mover:setSpeed(7)

	local materialUrl = BattleUnitUtil.getAddMaterialUrl(unit)

	if materialUrl then
		unit.material:setOriginalMaterial(materialUrl, false)
	end

	local vertices = modelCO.vertices

	unit.transform:setVertexArray(vertices)
	unit.uiProxy:rebuildUI()
	unit.sceneProxy:rebuildUI()
	unit.sign:rebuildSigns()
	unit:setupEditorDisplayName()

	local isShowUnitUI = BattleCampAdjustmentModel.instance:isShowUnitUI()

	unit.uiProxy:setVisible(isShowUnitUI)
	unit.sceneProxy:setVisible(isShowUnitUI)
	unit.meshModel:setBody(ModelCOUtil.getLowModelUrl(modelCO))

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

function BattleUnitGenerator.createIntangible(entityInfo)
	local entityCode = 10000000
	local unit = BattleUnit:createInstance(entityInfo.entityCode)

	unit.property:setEntityId(entityInfo.entityId)
	unit.property:setEntityType(entityInfo.entityType)
	unit.property:setLevel(entityInfo.level)
	unit.property:setUserId(entityInfo.userId)
	unit.property:setCampId(entityInfo.campId)
	unit.property:setBattleCamp(entityInfo.battleCamp)
	unit.property:setEntityCode(entityCode)
	unit.property:setFlagMask(BattleUnitFlagMask.MaskIntangible)
	unit:setProxyVisible(false, entityCode)
	unit:setupEditorDisplayName()

	for _, skill in pairs(entityInfo.skills) do
		unit.skill:addSkillFromSkillInfo(skill)
	end

	BattleUnitGenerator.addUnitToScene(unit)

	return unit
end

function BattleUnitGenerator.setUnitToUnionIndex(unit, bornUnionIndex)
	local boardMgr = BattleMgr.instance:getBoardMgr()

	boardMgr:setUnitToUnionIndex(unit, bornUnionIndex)
end

function BattleUnitGenerator.setModelQuality(unit, isHigh)
	local modelId = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	unit.meshModel:setBody(isHigh and ModelCOUtil.getHighModelUrl(modelCO) or ModelCOUtil.getLowModelUrl(modelCO))
end

function BattleUnitGenerator.createAdditionalTerrain(terrainCode)
	local terrainCO = BattleConfigUtil.getEntityConfig(terrainCode)

	if string.nilorempty(terrainCO.resPath) then
		return false
	end

	local unit = BattleAdditionalTerrainUnit:createInstance(terrainCode)

	unit.rectangle:setGroupType(terrainCO.isGroupTerrain)
	unit.terrainModel:setBody(GameUrl.getTerrainModelUrl(terrainCO.resPath))
	BattleUnitGenerator.addUnitToScene(unit)

	return unit
end

function BattleUnitGenerator.setAdditionalTerrainInfo(unit, entityInfo)
	unit.property:setEntityId(entityInfo.entityId)
	unit.property:setEntityType(entityInfo.entityType)
	unit.property:setLevel(entityInfo.level)
	unit.property:setUserId(entityInfo.userId)
	unit.property:setCampId(entityInfo.campId)
	unit.property:setBattleCamp(entityInfo.battleCamp)
	unit.property:setEntityCode(entityInfo.entityCode)
	unit.property:setFlagMask(BattleUnitFlagMask.MaskTerrain)
	unit:setupEditorDisplayName()

	for _, skill in pairs(entityInfo.skills) do
		unit.skill:addSkillFromSkillInfo(skill)
	end
end

function BattleUnitGenerator.addUnitToScene(unit)
	BattleGameObjectRootUtil.addToUnitsRoot(unit:getGameObject())
end

function BattleUnitGenerator.addUnitToRoot(unit, goRoot)
	goutil.addChildToParent(unit:getGameObject(), goRoot)
end

function BattleUnitGenerator.removeUnit(unit)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardModel = BattleMgr.instance:getBoardModel()

	unit.property:activeState(BattleEnum.State.DEAD)
	unitMgr:addDeadUnit(unit)

	if unit.transform then
		boardModel:removeUnit(unit)
	end

	unitMgr:removeUnit(unit)
	unit.dieHandler:setLogicRemoved()
end

function BattleUnitGenerator.destroyUnit(unit, isSilent)
	if OOPUtil.isInstanceOf(unit, BattleAdditionalTerrainUnit) then
		local additionalTerrainMgr = BattleMgr.instance:getAdditionalTerrainMgr()

		additionalTerrainMgr:removeDeadUnit(unit)
		unit:returnSelf()
	else
		local unitMgr = BattleMgr.instance:getUnitMgr()

		unitMgr:removeDeadUnit(unit, isSilent)
		unit:returnSelf()

		if not isSilent and unitMgr:isDeadPerformanceEmpty() then
			BattleDispatcher:dispatchEvent(BattleEventType.OnBattleDeadAnimDone)
		end
	end
end

return BattleUnitGenerator
