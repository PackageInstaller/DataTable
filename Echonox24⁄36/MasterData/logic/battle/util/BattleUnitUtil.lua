-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleUnitUtil.lua

module("logic.battle.util.BattleUnitUtil", package.seeall)

local BattleUnitUtil = {}
local kForecastStatusChangeBlackList = {
	BattleEnum.State.SNIPING,
	BattleEnum.State.SILENT,
	BattleEnum.State.CANNOT_NORMAL_ATTACK
}

function BattleUnitUtil.isLowSanity(unit)
	return unit.property:getSanity() == BattleConst.MIN_SANITY
end

function BattleUnitUtil.isCharacter(unit)
	return unit.property:getEntityType() == BattleEnum.EntityType.Hero
end

function BattleUnitUtil.isMonster(unit)
	return unit.property:getEntityType() == BattleEnum.EntityType.Monster
end

function BattleUnitUtil.isSummon(unit)
	return unit.property:getEntityType() == BattleEnum.EntityType.Summon
end

function BattleUnitUtil.isMonsterOrSummon(unit)
	return BattleUnitUtil.isMonster(unit) or BattleUnitUtil.isSummon(unit)
end

function BattleUnitUtil.isAlive(unit)
	return unit and not unit.property:isStateActive(BattleEnum.State.DEAD)
end

function BattleUnitUtil.checkSelectUnit(unit)
	if not BattleUnitUtil.isAlive(unit) then
		return false
	end

	if not unit.property:isFlagEnable(BattleUnitFlagMask.FlagOperatable) then
		return false
	end

	return true
end

function BattleUnitUtil.getUnitCenterPos(unit)
	local size = unit.meshModel and unit.meshModel:getBodySize() or false
	local x, z = unit.mover:getPos()

	if unit.transform:isComposite() then
		local dx, dz = BattleUnitUtil.getXZCenter(unit)

		x = x + dx
		z = z + dz
	end

	local boardMgr = BattleMgr.instance:getBoardMgr()
	local y = boardMgr:calculateWorldYOffset(x, z)

	if size then
		return x, y + size.y * 0.5, z
	else
		return x, y + 0.5, z
	end
end

function BattleUnitUtil.getUnitCenterPosOnCheckBoard(unit)
	local size = unit.meshModel and unit.meshModel:getBodySize() or false
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local x, y, z = boardMgr:getCellPositionXYZ(unionIndex)

	if unit.transform:isComposite() then
		local dx, dz = BattleUnitUtil.getXZCenter(unit)

		x = x + dx
		z = z + dz
	end

	y = boardMgr:calculateWorldYOffset(x, z)

	if size then
		return x, y + size.y * 0.5, z
	else
		return x, y + 0.5, z
	end
end

function BattleUnitUtil.getUnitInForecast(unit)
	return unit.property:getForecastUnit() and unit.property:getForecastUnit() or unit
end

function BattleUnitUtil.isUnitNotMoved(unit)
	local unitOp = BattleMgr.instance:getUnitOperator()
	local unionIndex = unitOp:getOriginUnionIndex()

	if not unionIndex then
		return false
	end

	local x1, z1 = BoardIndexConverter.unionIndexToCoordinates(unitOp:getOriginUnionIndex())
	local x2, z2 = unit.transform:getCoordinates()

	return x1 == x2 and z1 == z2
end

function BattleUnitUtil.isInForecastBlackList(state)
	for i, v in ipairs(kForecastStatusChangeBlackList) do
		if state == v then
			return true
		end
	end

	return false
end

function BattleUnitUtil.getUnitCellCenterPos(unit)
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local x, z = unit.transform:getCoordinates()
	local x1, y1, z1 = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(x, z))
	local rectangle = unit.transform:getRectangle()

	if rectangle then
		local deltaX = rectangle:getMaxx() - rectangle:getMinx()
		local deltaZ = rectangle:getMaxz() - rectangle:getMinz()
		local x2, y2, z2 = boardMgr:getCellPositionXYZ(BoardIndexConverter.coordinatesToUnionIndex(x + deltaX, z + deltaZ))

		return (x1 + x2) / 2, (y1 + y2) / 2, (z1 + z2) / 2
	else
		return x1, y1, z1
	end
end

function BattleUnitUtil.isUnitStrengthening(unit)
	local unitOperator = BattleMgr.instance:getUnitOperator()

	if unitOperator and unitOperator:isInStrengthenStatus() then
		local focusUnit = unitOperator:getFocusUnit()

		if focusUnit and focusUnit.property:getEntityId() == unit.property:getEntityId() then
			return true
		end
	end

	return false
end

function BattleUnitUtil.getFadeUnitList(attackInfo, resultList)
	local fadeUnitList = BattleTableUtil.getTempList()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local allUnit = unitMgr:getAllUnits()

	for i, unit in pairs(allUnit) do
		if unit:getUnitType() == BattleEnum.UnitType.Person then
			fadeUnitList[unit.property:getEntityId()] = unit
		end
	end

	local attacker = attackInfo:getAttacker()

	fadeUnitList[attacker.property:getEntityId()] = nil

	local victims = attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		fadeUnitList[victim.property:getEntityId()] = nil
	end

	local refUnits = attackInfo:getRefUnits()

	for _, refUnit in ipairs(refUnits) do
		fadeUnitList[refUnit.property:getEntityId()] = nil
	end

	BattleTableUtil.insertfrommap(resultList, fadeUnitList)
	BattleTableUtil.releaseTempList(fadeUnitList)
end

function BattleUnitUtil.getBattleFocusPos(unit)
	local x, y, z = BattleUnitUtil.getUnitCellCenterPos(unit)

	if unit.transform:isComposite() then
		local rotation = BattleMgr.instance:getModel():getCameraRotation()
		local centerHeight = unit.meshModel:getOriginalBodySizeY() * 0.5
		local dx = centerHeight * math.sin(rotation * math.pi / 180)
		local dz = centerHeight * math.cos(rotation * math.pi / 180)

		x = x + dx
		z = z + dz
	end

	local vec3 = BattleMathUtil.tempVec3

	vec3:Set(x, y, z)

	return vec3
end

function BattleUnitUtil.getUnitDiffFocusPos(unit)
	local rotation = BattleMgr.instance:getModel():getCameraRotation()
	local x, y, z = BattleUnitUtil.getUnitCellCenterPos(unit)
	local centerHeight = unit.meshModel:getBodySize().y
	local dx = centerHeight * math.sin(rotation * math.pi / 180)
	local dz = centerHeight * math.cos(rotation * math.pi / 180)

	return x + dx, y, z + dz
end

function BattleUnitUtil.isSameOfOperateCamp(entityId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	return unit and BattleCampRelationUtil.isSameOfOperateCamp(unit)
end

function BattleUnitUtil.isSanityVisibleBySystemOpen(unit)
	if not BattleCampRelationUtil.isSameOfOperateCamp(unit) then
		return true
	end

	return SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightSanStrengthen, false)
end

function BattleUnitUtil.getAddMaterialUrl(unit)
	local res

	if unit.property:getMonsterType() == BattleEnum.MonsterType.ELITE then
		res = BattleResourceName.EliteMonsterMaterial
	end

	local entityCode = unit.property:getEntityCode()
	local entityType = unit.property:getEntityType()
	local bodyEffect = unit.property:getBodyEffect()

	if BattleUnitUtil.isMonsterOrSummon(unit) then
		local monsterCO = BattleConfigUtil.getEntityConfig(entityCode, entityType)

		if monsterCO and monsterCO.bodyEffect ~= "" then
			bodyEffect = monsterCO.bodyEffect
		end
	end

	if bodyEffect and not string.nilorempty(bodyEffect) then
		res = string.format("materials/other/character/%s.mat", bodyEffect)
	end

	return res
end

function BattleUnitUtil.isDisableMove(unit)
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:isForbiddenMove() or unit.property:isStateActive(BattleEnum.State.CANNOT_MOVE)
end

function BattleUnitUtil.isForbiddenSkill(skillMO)
	local settingModel = BattleMgr.instance:getSettingModel()

	if settingModel:isSkillForbiddenByType(skillMO:getCategory()) then
		return true, BattleEnum.ForbidAction.SkillByType
	end

	if settingModel:isSkillForbiddenByPurpose(skillMO:getPurpose()) then
		return true, BattleEnum.ForbidAction.SkillByPurpose
	end

	return false
end

function BattleUnitUtil.isComposite(unit)
	return unit.transform:isComposite()
end

function BattleUnitUtil.getXZCenter(unit)
	if not unit.transform:isComposite() then
		return 0, 0
	end

	local sideLength = SpaceX.CheckBoardSetting.GetSideLength()
	local rectangle = unit.transform:getRectangle()
	local centerX, centerZ = rectangle:getCenterXZ()

	return centerX * sideLength, centerZ * sideLength
end

function BattleUnitUtil.getUnionIndex(unit)
	return BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
end

function BattleUnitUtil.play3dAudio(unit, audioRes)
	BattleAudioUtil.playSEByName(audioRes, unit.mainGO)
end

function BattleUnitUtil.createHeroEntityInfo(heroId)
	local battleModel = BattleMgr.instance:getModel()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroMO then
		local settingModel = BattleMgr.instance:getSettingModel()
		local trialList = settingModel:getTrialHeroList()

		for _, item in ipairs(trialList) do
			if item:getId() == heroId then
				heroMO = item

				break
			end
		end
	end

	local entityInfo = BattleEntityInfo:createInstance()

	entityInfo.lowModelOnly = true
	entityInfo.entityCode = heroId
	entityInfo.entityType = BattleEnum.EntityType.Hero
	entityInfo.campId = battleModel:getOperateCampId()

	local attributeCodes = BattleExtension_pb.Attribute

	for _, attributeCode in pairs(attributeCodes) do
		entityInfo:addAttribute(attributeCode, heroMO:getAttribute(attributeCode))
	end

	entityInfo:addAttribute(BattleExtension_pb.Attribute.CURRENT_HP, heroMO:getAttribute(BattleExtension_pb.Attribute.MAX_HP))

	return entityInfo
end

function BattleUnitUtil.createHeroEntityInfoWithoutAttr(modelId)
	local battleModel = BattleMgr.instance:getModel()
	local entityInfo = BattleEntityInfo:createInstance()

	entityInfo.lowModelOnly = true
	entityInfo.modelId = modelId
	entityInfo.entityType = BattleEnum.EntityType.Hero
	entityInfo.campId = battleModel:getOperateCampId()

	return entityInfo
end

function BattleUnitUtil.updateUnitInfo(unit, heroData)
	unit.property:setLevel(heroData:getLevel())

	local attributes = heroData:getAttrs()

	for _, attrbute in ipairs(attributes) do
		unit.property:setBaseAttribute(attrbute.attr, BattleMathUtil.removePrecision(attrbute.value))
		unit.property:setAttribute(attrbute.attr, BattleMathUtil.removePrecision(attrbute.value))
	end
end

function BattleUnitUtil.getUnitsRange(unitA, unitB)
	local minRange = 999
	local x1, z1 = unitA.transform:getCoordinates()
	local rectangle = unitA.transform:getRectangle()

	if rectangle then
		for dx = rectangle:getMinx(), rectangle:getMaxx() do
			for dz = rectangle:getMinz(), rectangle:getMaxz() do
				minRange = math.min(minRange, BattleUnitUtil.getPoint2UnitRange(x1 + dx, z1 + dz, unitB))
			end
		end
	else
		minRange = math.min(minRange, BattleUnitUtil.getPoint2UnitRange(x1, z1, unitB))
	end

	return minRange
end

function BattleUnitUtil.getPoint2UnitRange(x, z, unit)
	local minRange = 999
	local x1, z1 = unit.transform:getCoordinates()
	local rectangle = unit.transform:getRectangle()

	if rectangle then
		for dx = rectangle:getMinx(), rectangle:getMaxx() do
			for dz = rectangle:getMinz(), rectangle:getMaxz() do
				minRange = math.min(minRange, math.abs(x1 + dx - x) + math.abs(z1 + dz - z))
			end
		end
	else
		minRange = math.min(minRange, math.abs(x1 - x) + math.abs(z1 - z))
	end

	return minRange
end

function BattleUnitUtil.getPerformSkillId(unit, skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if ActiveSkillCOUtil.isTalent(skillCOWrapper, false) then
		local entityCode = unit.property:getEntityCode()
		local isCharacter = ItemUtil.isCharacterById(entityCode)

		if isCharacter then
			local entityCO = CharacterConfig.instance:getCfgInfoByID(entityCode)

			if #entityCO.battleTalent >= 3 then
				local awakeStatus = TacitModel.instance:isAwakeTalentSkill(entityCode, true)

				return entityCO.battleTalent[awakeStatus]
			end
		end
	end

	return skillId
end

function BattleUnitUtil.isShowWeakPointFrozen(unit)
	return unit.property:isShowWeakPoint() or BattleMapEnum.WeakPointBreakEffect[unit.property:getModelCode()]
end

function BattleUnitUtil.canPlayAnimation(unit, animation)
	if not BattleUnitUtil.isAlive(unit) and animation ~= unit.meshModelMover:getMappedAnimation(UnitAnimState.Death) then
		return false
	end

	return true
end

function BattleUnitUtil.getChaseStageTypeAndCount(entityId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		return 0, 0
	end

	local heroId = unit.property:getEntityCode()
	local modelCode = unit.property:getModelCode()

	return SkillTagUtils.getStageTypeAndCount(heroId, modelCode)
end

function BattleUnitUtil.setUnitSelected(unit, selected)
	if unit and not unit:isDestroyed() then
		unit.uiProxy:setSelected(selected)
	end
end

function BattleUnitUtil.formatWeakPointValue(wPercent)
	local value = math.ceil(wPercent * 100)

	if value < 100 and value > 99 then
		value = 99
	end

	if value > 0 and value < 1 then
		value = 1
	end

	return value
end

function BattleUnitUtil.createHeroData(monsterCO, quality)
	local hero = {
		level = monsterCO.level,
		heroCfgInfo = {
			modelId = monsterCO.modelId,
			quality = quality,
			career = monsterCO.career,
			colorType = monsterCO.colorType,
			camp = monsterCO.camp,
			move = monsterCO.mobility,
			initialSan = monsterCO.sanity,
			normalSkills = {
				monsterCO.normalSkill,
				monsterCO.specialSkill,
				monsterCO.trumpSkill
			},
			battleTalent = {
				monsterCO.giftSkill
			}
		},
		heroInfoCfg = {
			name = monsterCO.name
		},
		attrParts = {},
		attrs = {
			{
				attr = BattleExtension_pb.Attribute.MAX_HP,
				value = math.floor(monsterCO.maxHp)
			},
			{
				attr = BattleExtension_pb.Attribute.ATK_PHY,
				value = math.floor(monsterCO.meleeAtk)
			},
			{
				attr = BattleExtension_pb.Attribute.DEF_PHY,
				value = math.floor(monsterCO.meleeDef)
			},
			{
				attr = BattleExtension_pb.Attribute.ATK_MAG,
				value = math.floor(monsterCO.magicAtk)
			},
			{
				attr = BattleExtension_pb.Attribute.DEF_MAG,
				value = math.floor(monsterCO.magicDef)
			},
			{
				attr = BattleExtension_pb.Attribute.INSPIRATION,
				value = math.floor(monsterCO.inspire)
			},
			{
				attr = BattleExtension_pb.Attribute.MOVE,
				value = math.floor(monsterCO.mobility)
			}
		},
		skills = {}
	}
	local skills = {
		monsterCO.normalSkill,
		monsterCO.specialSkill,
		monsterCO.trumpSkill,
		monsterCO.giftSkill
	}

	for _, item in ipairs(skills) do
		if item ~= 0 then
			table.insert(hero.skills, {
				value = 0,
				key = item
			})
		end
	end

	for _, item in ipairs(monsterCO.extraSkills) do
		if item ~= 0 then
			table.insert(hero.skills, {
				value = 0,
				key = item
			})
		end
	end

	local heroData = CharacterData.New(hero)

	heroData.attributeGrade = monsterCO.attributeGrade

	return heroData
end

return BattleUnitUtil
