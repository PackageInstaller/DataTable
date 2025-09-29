-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/operator/BattleSkillAssist.lua

module("logic.battle.battleflow.component.operator.BattleSkillAssist", package.seeall)

local BattleSkillAssist = {}

function BattleSkillAssist.isDamage(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.DAMAGE
end

function BattleSkillAssist:isCure(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.CURE
end

function BattleSkillAssist.isMark(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.MARK
end

function BattleSkillAssist.isTransportSkill(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.TRANSPORT
end

function BattleSkillAssist.hasUnitRelatedTransport(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:hasUnitRelatedTransport(status)
end

function BattleSkillAssist.isAoeSkill(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	local shape = skillCOWrapper:getSkillRangeShape(status)
	local shapeType = BattleEnum.Shape[shape.type]

	if shapeType == BattleEnum.Shape.Rectangle or shapeType == BattleEnum.Shape.Line then
		return true
	else
		return shape.range > 0
	end
end

function BattleSkillAssist.getModelShapeAoeSkillModelId(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	if ActiveSkillCOUtil.isSkillPurposeMultiRoundAOE(skillCOWrapper, status) then
		local multiAOEAction = skillCOWrapper:getMultiAOEParams(status)

		if multiAOEAction and BattleEnum.Shape[multiAOEAction.shape.type] == BattleEnum.Shape.ModelRectangle then
			return multiAOEAction.shape.modelId
		end
	end

	return false
end

function BattleSkillAssist.isSelfTargetSkill(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.SELF
end

function BattleSkillAssist.isFriendTargetSkill(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.MEMBER
end

function BattleSkillAssist.isPositionTargetSkill(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	return skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.POSITION
end

function BattleSkillAssist.calculateUnitRect(unitA, unitB)
	local unionIndexList = BattleTableUtil.getTempList()

	BattleSkillAssist.getUnitRectPoints(unitA, unionIndexList)
	BattleSkillAssist.getUnitRectPoints(unitB, unionIndexList)

	local minx, maxx, minz, maxz = BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN, BattleMathUtil.INT_MAX, BattleMathUtil.INT_MIN

	for _, unionIndex in ipairs(unionIndexList) do
		local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

		minx = math.min(minx, x)
		maxx = math.max(maxx, x)
		minz = math.min(minz, z)
		maxz = math.max(maxz, z)
	end

	BattleTableUtil.releaseTempList(unionIndexList)

	return minx, maxx, minz, maxz
end

function BattleSkillAssist.getUnitRectPoints(unit, outList)
	local unitx, unitz = unit.transform:getCoordinates()

	table.insert(outList, BoardIndexConverter.coordinatesToUnionIndex(unitx, unitz))

	if unit.transform:isComposite() then
		local rectangle = unit.transform:getRectangle()

		table.insert(outList, BoardIndexConverter.coordinatesToUnionIndex(unitx + rectangle:getMaxx(), unitz + rectangle:getMinz()))
		table.insert(outList, BoardIndexConverter.coordinatesToUnionIndex(unitx + rectangle:getMinx(), unitz + rectangle:getMaxz()))
		table.insert(outList, BoardIndexConverter.coordinatesToUnionIndex(unitx + rectangle:getMaxx(), unitz + rectangle:getMaxz()))
	end
end

function BattleSkillAssist.validateSkillTarget(unit, targetUnionIndex, skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	local selectableTarget = skillCOWrapper:getSelectableTarget(unit.skill:getSkillStatus())

	return BattleSkillAssist.validateSkillTargetWithTarget(selectableTarget, unit, targetUnionIndex)
end

function BattleSkillAssist.validateSkillTargetWithTarget(selectableTarget, unit, targetUnionIndex)
	if selectableTarget == BattleEnum.SkillSelectableTarget.POSITION then
		return true
	end

	local model = BattleMgr.instance:getModel()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local targetUnit = unitMgr:getUnitOnUnionIndex(targetUnionIndex)

	if not targetUnit or not targetUnit.property:isFlagEnable(BattleUnitFlagMask.FlagAttackable) then
		return false
	end

	if targetUnit.property:isStateActive(BattleEnum.State.INVINCIBLE) then
		return false
	end

	local relationType = model:getCampRelationByUnit(unit, targetUnit)

	if selectableTarget == BattleEnum.SkillSelectableTarget.SELF then
		return unit == targetUnit
	elseif selectableTarget == BattleEnum.SkillSelectableTarget.MEMBER then
		return unit ~= targetUnit and BattleCampRelationUtil.isSameOrFriendRelation(relationType)
	elseif selectableTarget == BattleEnum.SkillSelectableTarget.MEMBER_STEPPED then
		local isMember = unit ~= targetUnit and BattleCampRelationUtil.isSameOrFriendRelation(relationType)

		return isMember and targetUnit.property:isStateActive(BattleEnum.State.STEPPED) and not targetUnit.property:isStateActive(BattleEnum.State.SNIPING)
	elseif selectableTarget == BattleEnum.SkillSelectableTarget.ENEMY then
		return relationType == BattleEnum.CampRelation.ENEMY
	else
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleSkillAssist::unhandle selectableTarget[%s]", selectableTarget))
		end

		return false
	end
end

function BattleSkillAssist.judgeAttackableCellColorIndex(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return BattleEnum.CellColor.CURABLE
	end

	local aoeType = skillCOWrapper:getAoeType(status)

	if aoeType == BattleEnum.AOEType.BUFF then
		return BattleEnum.CellColor.CURABLE
	end

	if aoeType == BattleEnum.AOEType.DEBUFF then
		return BattleEnum.CellColor.ATTACKABLE
	end

	if skillCOWrapper and skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.ENEMY then
		return BattleEnum.CellColor.ATTACKABLE
	end

	if skillCOWrapper and skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.POSITION then
		local displayCategory = skillCOWrapper:getDisplayCategory(status)

		if displayCategory == BattleEnum.SkillDisplayCategory.ATK_PHY or displayCategory == BattleEnum.SkillDisplayCategory.ATK_MAG then
			return BattleEnum.CellColor.ATTACKABLE
		end
	end

	return BattleEnum.CellColor.CURABLE
end

function BattleSkillAssist.judgeWalkableCellColorIndex(skillId, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return BattleEnum.CellColor.STOPABLE
	end

	if skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.SELF then
		return BattleEnum.CellColor.STOPABLE
	end

	if skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.CURE then
		return BattleEnum.CellColor.CURABLE
	end

	return BattleEnum.CellColor.STOPABLE
end

function BattleSkillAssist.judgeAttackableCellSign(skillId, status)
	return BattleSkillAssist.judgeAttackableCellColorIndex(skillId, status) == BattleEnum.CellColor.CURABLE
end

function BattleSkillAssist.checkTwoUnitsInDistance(unitA, unitB, maxDistance)
	local ax, az = unitA.transform:getCoordinates()
	local bx, bz = unitB.transform:getCoordinates()
	local distance = math.abs(ax - bx) + math.abs(az - bz)

	return distance <= maxDistance
end

function BattleSkillAssist.calculateRepelCellIndex(attacker, victim, distance)
	local ax, az = attacker.transform:getCoordinates()
	local vx, vz = victim.transform:getCoordinates()

	if distance <= 0 then
		return BoardIndexConverter.coordinatesToUnionIndex(vx, vz)
	end

	local boardModel = BattleMgr.instance:getBoardModel()
	local boardMO = boardModel:getActiveBoardMO()

	if math.abs(ax - vx) >= math.abs(az - vz) then
		if vx < ax then
			local tox = math.max(0, vx - distance)

			return BattleSkillAssist._getValidUnionIndexOfX(victim, vx, vz, tox)
		else
			local maxx = boardMO:getWidth() - 1
			local tox = math.min(maxx, vx + distance)

			return BattleSkillAssist._getValidUnionIndexOfX(victim, vx, vz, tox)
		end
	elseif vz < az then
		local toz = math.max(0, vz - distance)

		return BattleSkillAssist._getValidUnionIndexOfZ(victim, vx, vz, toz)
	else
		local maxz = boardMO:getHeight() - 1
		local toz = math.min(maxz, vz + distance)

		return BattleSkillAssist._getValidUnionIndexOfZ(victim, vx, vz, toz)
	end
end

function BattleSkillAssist._getValidUnionIndexOfX(unit, fromx, fromz, tox)
	local deltax = tox < fromx and -1 or 1
	local boardModel = BattleMgr.instance:getBoardModel()

	for x = fromx, tox - deltax, deltax do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + deltax, fromz)

		if not boardModel:isUnitCanSetToUnionIndex(unit, unionIndex) then
			return BoardIndexConverter.coordinatesToUnionIndex(x, fromz)
		end
	end

	return BoardIndexConverter.coordinatesToUnionIndex(tox, fromz)
end

function BattleSkillAssist._getValidUnionIndexOfZ(unit, fromx, fromz, toz)
	local deltaz = toz < fromz and -1 or 1
	local boardModel = BattleMgr.instance:getBoardModel()

	for z = fromz, toz - deltaz, deltaz do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(fromx, z + deltaz)

		if not boardModel:isUnitCanSetToUnionIndex(unit, unionIndex) then
			return BoardIndexConverter.coordinatesToUnionIndex(fromx, z)
		end
	end

	return BoardIndexConverter.coordinatesToUnionIndex(fromx, toz)
end

local function local_isCoordinatesInShape(shape, range, fromx, fromz, tox, toz)
	if shape == BattleEnum.Shape.Rhombus then
		return range >= math.abs(fromx - tox) + math.abs(fromz - toz)
	elseif shape == BattleEnum.Shape.Circle then
		return range >= math.abs(fromx - tox) and range >= math.abs(fromz - toz)
	else
		if BattleLog.enableError then
			BattleLog.error(string.format("unhandle shape %s", shape))
		end

		return false
	end
end

local function local_isTargetUnitInShape(shape, range, fromx, fromz, toUnit, toUnionIndex)
	if not toUnit.transform:isComposite() then
		local tox, toz = BoardIndexConverter.unionIndexToCoordinates(toUnionIndex)

		return local_isCoordinatesInShape(shape, range, fromx, fromz, tox, toz)
	end

	local tox, toz = BoardIndexConverter.unionIndexToCoordinates(toUnionIndex)
	local vertices = toUnit.transform:getVertices()

	for _, vertex in pairs(vertices) do
		local vx, vz = vertex:getXZ()

		if local_isCoordinatesInShape(shape, range, fromx, fromz, tox + vx, toz + vz) then
			return true
		end
	end

	return false
end

local function local_testUnitInShapeRange(fromUnit, fromUnionIndex, toUnit, toUnionIndex, shape, range)
	local fromx, fromz = BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex)

	if not fromUnit.transform:isComposite() then
		return local_isTargetUnitInShape(shape, range, fromx, fromz, toUnit, toUnionIndex)
	end

	local vertices = fromUnit.transform:getVertices()

	for _, vertex in pairs(vertices) do
		local vx, vz = vertex:getXZ()

		if local_isTargetUnitInShape(shape, range, fromx + vx, fromz + vz, toUnit, toUnionIndex) then
			return true
		end
	end

	return false
end

function BattleSkillAssist.isUnitInShapeRange(fromUnit, toUnit, shape, range)
	local fromUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(fromUnit.transform:getCoordinates())
	local toUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(toUnit.transform:getCoordinates())

	return local_testUnitInShapeRange(fromUnit, fromUnionIndex, toUnit, toUnionIndex, shape, range)
end

function BattleSkillAssist.testUnitInShapeRange(fromUnit, fromUnionIndex, toUnit, toUnionIndex, shape, range)
	fromUnionIndex = fromUnionIndex or BoardIndexConverter.coordinatesToUnionIndex(fromUnit.transform:getCoordinates())
	toUnionIndex = toUnionIndex or BoardIndexConverter.coordinatesToUnionIndex(toUnit.transform:getCoordinates())

	return local_testUnitInShapeRange(fromUnit, fromUnionIndex, toUnit, toUnionIndex, shape, range)
end

function BattleSkillAssist.get3dEffectSkillUrl(name, attacker, victim, skillId, isStrengthen)
	local isNormal = true

	if victim then
		local attackerModelCO = ModelConfig.instance:getModelConfig(attacker.property:getModelCode())
		local victimModelCO = ModelConfig.instance:getModelConfig(victim.property:getModelCode())

		if victimModelCO.skillNotReverse == 1 and attackerModelCO.specialResForBoss == 1 then
			isNormal = false
		end
	end

	if not isNormal then
		if string.find(name, UnitAnimState.AimPrepare) then
			isNormal = true
		end

		if BattleSkillAssist:isCure(skillId, isStrengthen) then
			isNormal = true
		end

		local isSoloPerformance = SkillPerformanceCOUtil.isSoloPerformance(skillId, isStrengthen)

		if isSoloPerformance then
			isNormal = true
		end
	end

	if isNormal then
		local url = string.format("effect3d/prefab/skill/%s/%s_p.prefab", name, name)

		return EffectUtil.getQualifiedUrl(url)
	else
		local url = string.format("effect3d/prefab/skill/%s/%s_boss_p.prefab", name, name)

		return EffectUtil.getQualifiedUrl(url)
	end
end

function BattleSkillAssist.getNormal3dEffectSkillUrl(name)
	local url = string.format("effect3d/prefab/skill/%s/%s_p.prefab", name, name)

	return EffectUtil.getQualifiedUrl(url)
end

function BattleSkillAssist.getNormal3dEffectSkillUrlWithDirectory(directory, timelineName)
	local url = string.format("effect3d/prefab/skill/%s/%s_p.prefab", directory, timelineName)

	return EffectUtil.getQualifiedUrl(url)
end

function BattleSkillAssist.getSceneCommon3dEffectUrl(name)
	local url = GameUrl.get3dEffectSceneCommonUrl(name)

	return EffectUtil.getQualifiedUrl(url)
end

function BattleSkillAssist.generateSnipeSkillShape(unit, skillMO)
	local shapeType = BattleEnum.Shape.Rhombus
	local range = skillMO:getReleaseDistance()
	local tagEnhances = unit.skill:getSkillTagEnhances()

	if tagEnhances.Snipe_lockRange then
		range = BattleSkillAssist.parseTagEnhanceContext(range, tagEnhances.Snipe_lockRange, unit)
	end

	local fakeShapeConfig = BattleTableUtil.getTempList()

	if tagEnhances.Snipe_line then
		local isCrossLine = BattleSkillAssist.parseTagEnhanceContext(isCrossLine, tagEnhances.Snipe_line)

		if isCrossLine then
			shapeType = BattleEnum.Shape.CrossLine
			fakeShapeConfig.width = 1
			fakeShapeConfig.height = range * 2 + 1
		end
	else
		fakeShapeConfig.range = range
	end

	local shape = BattleShapeUtil.createShape(shapeType, fakeShapeConfig)

	BattleTableUtil.releaseTempList(fakeShapeConfig)

	return shape
end

function BattleSkillAssist.isStepAgainAfterReleaseSniping(unit)
	local tagEnhances = unit.skill:getSkillTagEnhances()
	local stepAgain = true

	if tagEnhances.Snipe_stepAgain then
		stepAgain = BattleSkillAssist.parseTagEnhanceContext(stepAgain, tagEnhances.Snipe_stepAgain)
	end

	return stepAgain
end

function BattleSkillAssist.parseTagEnhanceContext(baseValue, contexts, unit)
	local value = baseValue

	for k, TagEnhanceContextNO in pairs(contexts) do
		local modifier = 0

		if TagEnhanceContextNO.pType == "Number" then
			modifier = tonumber(TagEnhanceContextNO.param)
		elseif TagEnhanceContextNO.pType == "Boolean" then
			modifier = TagEnhanceContextNO.param == "YES" and true or false
		elseif TagEnhanceContextNO.pType == "Buff" then
			local splits = string.split(TagEnhanceContextNO.param, ",")
			local buffCode = tonumber(splits[1])
			local layerPerBuff = tonumber(splits[2])
			local addValue = tonumber(splits[3])
			local buffMOList = BattleTableUtil.getTempList()

			unit.buff:findBuffMOByCode(buffCode, buffMOList)

			if #buffMOList > 0 then
				if buffMOList[1]:isLayerBuff() then
					modifier = math.floor(buffMOList[1]:getLayer() / layerPerBuff) * addValue
				else
					modifier = math.floor(#buffMOList / layerPerBuff) * addValue
				end
			end

			BattleTableUtil.releaseTempList(buffMOList)
		else
			modifier = TagEnhanceContextNO.param
		end

		if TagEnhanceContextNO.cmd == BattleExtension_pb.TagEnhanceCmd.REPLACE then
			value = modifier
		elseif TagEnhanceContextNO.cmd == BattleExtension_pb.TagEnhanceCmd.ADD then
			value = value + modifier
		end
	end

	return value
end

function BattleSkillAssist.isSkillShapeSame(unit, skillIdA, skillIdB)
	local shapeA = unit.skill:generateSkillReleaseShape(skillIdA)
	local shapeB = unit.skill:generateSkillReleaseShape(skillIdB)
	local isSame = shapeA:equals(shapeB)

	shapeA:returnSelf()
	shapeB:returnSelf()

	return isSame
end

function BattleSkillAssist:isBuffSourceSkill(unit, skillId)
	local skillMO = unit.skill:getActiveSkillById(skillId)

	return skillMO:getSourceType() == BattleExtension_pb.SkillSourceType.BUFF
end

function BattleSkillAssist.isCellSelectedAoe(skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	if skillCOWrapper:getSelectableTarget() == BattleEnum.SkillSelectableTarget.POSITION then
		return skillCOWrapper:getAoeShape() and true or false
	end

	return false
end

function BattleSkillAssist.isCellSelectedSkill(skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not skillCOWrapper then
		return false
	end

	if skillCOWrapper:getSelectableTarget() == BattleEnum.SkillSelectableTarget.POSITION then
		return true
	end
end

function BattleSkillAssist.generateAoeShape(unit, skillId)
	local skillMO = unit.skill:getActiveSkillById(skillId)

	return skillMO:generateAoeShape()
end

function BattleSkillAssist.parseAnimState(animState, attackInfo)
	if animState == "judgeByShape" then
		local attacker = attackInfo:getAttacker()
		local skillId = attackInfo:getSkillId()
		local isStrengthen = attackInfo:isStrengthening()
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
		local shapes = skillCOWrapper:getShapeByTagShape()
		local unitMgr = BattleMgr.instance:getUnitMgr()

		for i, shapeTag in ipairs(shapes) do
			local isSatisfied = true

			for i, condition in ipairs(shapeTag.conditions) do
				if unitMgr:getUnitByTag(condition.tag) then
					if not condition.isAlive then
						isSatisfied = false

						break
					end
				elseif condition.isAlive then
					isSatisfied = false

					break
				end
			end

			if isSatisfied then
				return shapeTag.timelineRes
			end
		end
	end

	return animState
end

return BattleSkillAssist
