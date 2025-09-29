-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/SkillTagUtils.lua

module("logic.battle.skill.tag.SkillTagUtils", package.seeall)

local SkillTagUtils = {}
local kMaxTagRange = 3
local kShapeValue2KeyMap = {}
local kDefaultTagHitEffect = {
	[BattleEnum.Tag.ArcLight] = 20008
}
local kDefaultShakeAmplitudes = {
	AttackPointShakeUtil.Amplitude.LIGHT,
	AttackPointShakeUtil.Amplitude.MEDIUM,
	AttackPointShakeUtil.Amplitude.HEAVY
}

local function buildShapeValue2KeyMap()
	for key, value in pairs(BattleEnum.Shape) do
		kShapeValue2KeyMap[value] = string.lower(key)
	end
end

buildShapeValue2KeyMap()

function SkillTagUtils.getShapeRange(shapeNO)
	if shapeNO:HasField("circle") then
		return shapeNO.circle.radius
	end

	if shapeNO:HasField("rhombus") then
		return shapeNO.rhombus.radius
	end

	if shapeNO:HasField("rectangle") then
		return math.max(shapeNO.rectangle.width, shapeNO.rectangle.height)
	end

	if shapeNO:HasField("point") then
		return 0
	end

	if shapeNO:HasField("line") then
		local startPoint = shapeNO.line.start
		local endPoint = shapeNO.line["end"]

		return math.max(math.abs(endPoint.z - startPoint.z), math.abs(endPoint.x - startPoint.x))
	end

	if shapeNO:HasField("multipleShape") then
		return SkillTagUtils.getShapeRange(shapeNO.multipleShape.centerShapes[1].shape)
	end

	if BattleLog.enableError then
		BattleLog.error("unhandle shapeNO")
	end

	return 1
end

function SkillTagUtils.getShapeType(shapeNO)
	if shapeNO:HasField("circle") then
		return BattleEnum.Shape.Circle
	end

	if shapeNO:HasField("rhombus") then
		return BattleEnum.Shape.Rhombus
	end

	if shapeNO:HasField("rectangle") then
		return BattleEnum.Shape.Rectangle
	end

	if shapeNO:HasField("point") then
		return BattleEnum.Shape.Point
	end

	if shapeNO:HasField("line") then
		return BattleEnum.Shape.Line
	end

	if shapeNO:HasField("multipleShape") then
		return BattleEnum.Shape.MultipleShape
	end

	if BattleLog.enableError then
		BattleLog.error("unhandle shapeNO")
	end

	return BattleEnum.Shape.Rhombus
end

function SkillTagUtils.getShapeTypeKey(shapeType)
	return kShapeValue2KeyMap[shapeType] or "unknown"
end

function SkillTagUtils.createSequenceCommand(cmdParser, resultCollection)
	local sequenceCommand = BattleSequenceCommand:createInstance()

	cmdParser:pushCmdContainer(sequenceCommand)
	cmdParser:setParam(BattleCmdParser.Param_PerformanceResultCollection, resultCollection)
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.normalList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.tagEventList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.hpChangedList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.specialPropertyModifiedList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.buffRemovedList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.entityDeadList))
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.weakPointBrokenList)
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.triggeringList))
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.afterPerformanceList)
	cmdParser:clearReusableParam(BattleCmdParser.Param_PerformanceResultCollection)
	cmdParser:popCmdContainer()

	return sequenceCommand
end

function SkillTagUtils.getTagResourceUrl(heroId, modelCode, tagId, shapeType, shapeRange)
	local scale = 1
	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)
	local tagPerformanceCO = BattleConfig.instance:getTagPerformanceCO(modelCode, tagCO.typeName)

	if not tagPerformanceCO then
		return
	end

	if not CharacterAuthorityModel.instance:isTagUnlock(heroId, tagCO.typeName) then
		return
	end

	local urlList = BattleTableUtil.getTempList()

	table.insert(urlList, tagPerformanceCO.resPath)

	if tagPerformanceCO.hasDifferentShape then
		table.insert(urlList, SkillTagUtils.getShapeTypeKey(shapeType))
	end

	if tagPerformanceCO.hasRange then
		if shapeRange > kMaxTagRange then
			scale = shapeRange / kMaxTagRange
			shapeRange = kMaxTagRange
		end

		table.insert(urlList, shapeRange)
	end

	local url = table.concat(urlList, "_")

	BattleTableUtil.releaseTempList(urlList)

	return GameUrl.get3dEffectSceneCommonUrl(url), scale
end

function SkillTagUtils.getChaseTagPerformanceTimeline(heroId, modelCode)
	if not CharacterAuthorityModel.instance:isTagUnlock(heroId, BattleConst.Chase) then
		return
	end

	local tagPerformanceCO = BattleConfig.instance:getTagPerformanceCO(modelCode, BattleConst.Chase)

	return tagPerformanceCO and tagPerformanceCO.resPath or false
end

function SkillTagUtils.getStageTypeAndCount(heroId, modelCode)
	if not CharacterAuthorityModel.instance:isTagUnlock(heroId, BattleConst.Chase) then
		return 0, 0
	end

	local tagPerformanceCO = BattleConfig.instance:getTagPerformanceCO(modelCode, BattleConst.Chase)

	if not tagPerformanceCO then
		return 0, 0
	end

	return tagPerformanceCO.stageType, tagPerformanceCO.stageCount
end

function SkillTagUtils.getLineRotation(shapeNO)
	local startPoint = shapeNO.line.start
	local endPoint = shapeNO.line["end"]

	if startPoint.x == endPoint.x then
		return startPoint.z <= endPoint.z and 90 or 270
	end

	local rotation = math.atan((endPoint.z - startPoint.z) / (endPoint.x - startPoint.x))

	if startPoint.x < endPoint.x then
		rotation = rotation + 180
	end

	return rotation
end

function SkillTagUtils.getSpecialDamageEffect(entityId, tagId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		return 0
	end

	local entityCode = unit.property:getEntityCode()
	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)
	local typeName = tagCO.typeName

	if CharacterAuthorityModel.instance:isTagUnlock(entityCode, typeName) then
		local modelCode = unit.property:getModelCode()
		local tagPerformanceCO = BattleConfig.instance:getTagPerformanceCO(modelCode, typeName)
		local configHitPointEffectCode = tagPerformanceCO and tagPerformanceCO.hitPointEffectCode or 0

		if configHitPointEffectCode > 0 then
			return configHitPointEffectCode
		end
	end

	local tagEnum = BattleEnum.Tag[typeName]

	return kDefaultTagHitEffect[tagEnum] or 0
end

function SkillTagUtils.shake(entityId, tagId, range)
	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)
	local typeName = tagCO.typeName
	local tagEnum = BattleEnum.Tag[typeName]

	if tagEnum == BattleEnum.Tag.Assist then
		return
	end

	local amplitudeIndex = Mathf.Clamp(range, 1, #kDefaultShakeAmplitudes)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		AttackPointShakeUtil.shake(kDefaultShakeAmplitudes[amplitudeIndex])

		return
	end

	local entityCode = unit.property:getEntityCode()

	if not CharacterAuthorityModel.instance:isTagUnlock(entityCode, typeName) then
		AttackPointShakeUtil.shake(kDefaultShakeAmplitudes[amplitudeIndex])

		return
	end

	local modelCode = unit.property:getModelCode()
	local tagPerformanceCO = BattleConfig.instance:getTagPerformanceCO(modelCode, typeName)

	if not tagPerformanceCO then
		AttackPointShakeUtil.shake(kDefaultShakeAmplitudes[amplitudeIndex])

		return
	end

	local amplitudes = tagPerformanceCO.amplitudes or kDefaultShakeAmplitudes

	AttackPointShakeUtil.shake(amplitudes[amplitudeIndex])
end

return SkillTagUtils
