-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/CharacterUtil.lua

module("logic.common.util.CharacterUtil", package.seeall)

local CharacterUtil = {}

CharacterUtil._filterViewOptRecord = {}

function CharacterUtil.AdjustSortByGuide(srcList, heroId)
	local index = 1

	for _, v in ipairs(srcList) do
		if heroId == v:getId() then
			index = _

			break
		end
	end

	local tempHero = srcList[index]

	table.remove(srcList, index)
	table.insert(srcList, 1, tempHero)

	return srcList
end

function CharacterUtil.SortAndFitler(moduleType, srcList)
	if not CharacterUtil._filterViewOptRecord[moduleType] then
		local sortFunc = CharacterUtil.getSortFunc(moduleType, CommEnum.HeroSortFieldType.Default, false)

		table.sort(srcList, sortFunc)

		return srcList
	end

	local tmpList = CharacterUtil._filterList(moduleType, srcList)
	local sortType = CharacterUtil._filterViewOptRecord[moduleType].sortType or CommEnum.HeroSortFieldType.Default
	local srotFunc = CharacterUtil.getSortFunc(moduleType, sortType, CharacterUtil._filterViewOptRecord[moduleType].isUpSort)

	table.sort(tmpList, srotFunc)

	return tmpList
end

function CharacterUtil._filterList(moduleType, srcList)
	local campTb = CharacterUtil._filterViewOptRecord[moduleType].camp or {
		0
	}
	local qualityTb = CharacterUtil._filterViewOptRecord[moduleType].quality or {
		0
	}
	local careerTb = CharacterUtil._filterViewOptRecord[moduleType].career or {
		0
	}
	local colorTb = CharacterUtil._filterViewOptRecord[moduleType].color or {
		0
	}
	local tagTb = CharacterUtil._filterViewOptRecord[moduleType].tag or {
		0
	}

	if campTb[1] == 0 and qualityTb[1] == 0 and careerTb[1] == 0 and colorTb[1] == 0 and tagTb[1] == 0 then
		return srcList
	end

	local function _isMatch(_table, _val)
		if not _table then
			return true
		end

		if _table[1] == 0 then
			return true
		end

		if table.indexof(_table, _val) then
			return true
		end

		return false
	end

	local function _isMatchTag(_table, tags)
		if not _table then
			return true
		end

		if _table[1] == 0 then
			return true
		end

		local _match = false

		for _, tag in ipairs(tags or {}) do
			if table.indexof(_table, tag) then
				_match = true
			end
		end

		return _match
	end

	local tmpList = {}

	for _, v in ipairs(srcList) do
		if _isMatchTag(tagTb, v:getTags()) and _isMatch(campTb, v:getCamp()) and _isMatch(qualityTb, v:getQuality()) and _isMatch(careerTb, v:getCareer()) and _isMatch(colorTb, v:getColorType()) then
			table.insert(tmpList, v)
		end
	end

	return tmpList
end

function CharacterUtil.saveFilterViewOpt(moduleType, record)
	if not CharacterUtil._filterViewOptRecord[moduleType] then
		CharacterUtil._filterViewOptRecord[moduleType] = false
	end

	CharacterUtil._filterViewOptRecord[moduleType] = record
end

function CharacterUtil.getFilterViewOpt(moduleType)
	return CharacterUtil._filterViewOptRecord[moduleType]
end

function CharacterUtil.clearFilterRecord(moduleType)
	CharacterUtil._filterViewOptRecord[moduleType] = false
end

function CharacterUtil._herotSort(item1, item2)
	local config = HeroSortRuleConfig.instance:getHeroDepotRule()
	local defaultSort = config[CharacterUtil._sort_type]

	if not defaultSort then
		printError("can not get sort define for _sortType = " .. CharacterUtil._sort_type)

		return false
	end

	return CharacterUtil.sort(item1, item2, defaultSort)
end

function CharacterUtil._teamSort(item1, item2)
	local config = HeroSortRuleConfig.instance:getTeamRule()
	local defaultSort = config[CharacterUtil._sort_type]

	if not defaultSort then
		printError("can not get sort define for _sortType = " .. CharacterUtil._sort_type)

		return false
	end

	return CharacterUtil.sort(item1, item2, defaultSort)
end

function CharacterUtil._displaySort(item1, item2)
	local config = HeroSortRuleConfig.instance:getDisplayRule()
	local defaultSort = config[CharacterUtil._sort_type]

	if not defaultSort then
		printError("can not get sort define for _sortType = " .. CharacterUtil._sort_type)

		return false
	end

	return CharacterUtil.sort(item1, item2, defaultSort)
end

function CharacterUtil.sort(item1, item2, sort_vars)
	if not item1:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item1:getId())

		return false
	end

	if not item2:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item2:getId())

		return false
	end

	local result = false

	for i, v in pairs(sort_vars) do
		local ret = false

		if i == 1 then
			if CharacterUtil._is_ascending then
				ret = CharacterUtil._doCompareCommonStateAscending(item1, item2, v)
			else
				ret = CharacterUtil._doCompareCommonDescending(item1, item2, v)
			end
		else
			ret = CharacterUtil._doCompareCommonDescending(item1, item2, v)
		end

		if ret ~= -1 then
			result = ret

			break
		end
	end

	return result
end

function CharacterUtil.sortAscending(item1, item2, sort_vars)
	if not item1:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item1:getId())

		return false
	end

	if not item2:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item2:getId())

		return false
	end

	local result = false

	for i, v in ipairs(sort_vars) do
		local ret = CharacterUtil._doCompareCommonStateAscending(item1, item2, v)

		if ret ~= -1 then
			result = ret

			break
		end
	end

	return result
end

function CharacterUtil.sortDescending(item1, item2, sort_vars)
	if not item1:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item1:getId())

		return false
	end

	if not item2:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item2:getId())

		return false
	end

	local result = false

	for i, v in ipairs(sort_vars) do
		local ret = CharacterUtil._doCompareCommonDescending(item1, item2, v)

		if ret ~= -1 then
			result = ret

			break
		end
	end

	return result
end

function CharacterUtil.getHeroAttr(hero_data, var_name)
	local value = CharacterUtil._getHeroCompareValue(hero_data, var_name)
	local name = lang(CommEnum.SortType2LangKey[var_name])

	return name, value
end

function CharacterUtil._getHeroCompareValue(hero_data, var_name)
	if not hero_data then
		printError("_getHeroCompareValue hero_data should not be null !")

		return nil
	end

	if var_name == CommEnum.HeroSortFieldType.Id then
		return hero_data:getId()
	end

	if var_name == CommEnum.HeroSortFieldType.Level then
		return hero_data:getLevel()
	end

	if var_name == CommEnum.HeroSortFieldType.Authority then
		return hero_data:getPowerLv()
	end

	if var_name == CommEnum.HeroSortFieldType.Quality then
		return hero_data:getQuality()
	end

	if var_name == CommEnum.HeroSortFieldType.Breakthrough then
		return hero_data:getBreakLv()
	end

	if var_name == CommEnum.HeroSortFieldType.Tacit then
		return hero_data:getTacitExp()
	end

	if var_name == CommEnum.HeroSortFieldType.MaxHp then
		return hero_data:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	end

	if var_name == CommEnum.HeroSortFieldType.Atk then
		return hero_data:getAttribute(BattleExtension_pb.Attribute.ATK_PHY)
	end

	if var_name == CommEnum.HeroSortFieldType.Def then
		return hero_data:getAttribute(BattleExtension_pb.Attribute.DEF_PHY)
	end

	if var_name == CommEnum.HeroSortFieldType.MagicAtk then
		return hero_data:getAttribute(BattleExtension_pb.Attribute.ATK_MAG)
	end

	if var_name == CommEnum.HeroSortFieldType.MagicDef then
		return hero_data:getAttribute(BattleExtension_pb.Attribute.DEF_MAG)
	end

	if var_name == CommEnum.HeroSortFieldType.Sanity then
		return hero_data:getInitialSan()
	end

	if var_name == CommEnum.HeroSortFieldType.Career then
		return hero_data:getCareer()
	end

	if var_name == CommEnum.HeroSortFieldType.State then
		return hero_data:getStatus()
	end

	return nil
end

function CharacterUtil._doCompareCommonStateAscending(item1, item2, var_name)
	local value1 = CharacterUtil._getHeroCompareValue(item1, var_name)
	local value2 = CharacterUtil._getHeroCompareValue(item2, var_name)

	if not value1 or not value2 then
		return false
	end

	if value1 == value2 then
		return -1
	end

	return value1 < value2
end

function CharacterUtil._doCompareCommonDescending(item1, item2, var_name)
	local value1 = CharacterUtil._getHeroCompareValue(item1, var_name)
	local value2 = CharacterUtil._getHeroCompareValue(item2, var_name)

	if not value1 or not value2 then
		return false
	end

	if value1 == value2 then
		return -1
	end

	return value2 < value1
end

function CharacterUtil.getSortFunc(moduleType, sortType, isUpSort)
	CharacterUtil._sort_type = sortType
	CharacterUtil._is_ascending = isUpSort

	if moduleType == CommEnum.HeroFilter.Team then
		return CharacterUtil._teamSort
	elseif moduleType == CommEnum.HeroFilter.HeroDepot then
		return CharacterUtil._herotSort
	elseif moduleType == CommEnum.HeroFilter.Battle then
		return CharacterUtil._teamSort
	elseif moduleType == CommEnum.HeroFilter.Roguelike then
		return CharacterUtil._teamSort
	elseif moduleType == CommEnum.HeroFilter.Display then
		return CharacterUtil._displaySort
	else
		printError("Undefined enterType:", moduleType)
	end
end

function CharacterUtil.HouseSortAndFitler(srcList, fliterTypes, sortTyp, params, ascending)
	if srcList == nil then
		return srcList
	end

	if #srcList <= 1 then
		return srcList
	end

	srcList = CharacterUtil.HouseFitler(srcList, fliterTypes)
	srcList = CharacterUtil.HouseSort(srcList, sortTyp, params, ascending)

	return srcList
end

function CharacterUtil.HouseFitler(srcList, fliterTypes)
	local function _isHeroMatch(hero)
		local heroId = hero:getId()
		local skillList = HeroHouseFeatureModel.instance:getFeatureSkillByHeroId(heroId)

		for _, fliterTyp in ipairs(fliterTypes) do
			for _, v in ipairs(skillList) do
				if v.isUnlock then
					local skillCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseSkill, v.skillId)

					if skillCO and skillCO.fliters and #skillCO.fliters > 0 then
						for _, skillFliter in ipairs(skillCO.fliters) do
							if skillFliter == fliterTyp then
								return true
							end
						end
					end
				end
			end
		end

		return false
	end

	if fliterTypes and #fliterTypes > 0 then
		local afterFliterLst = {}

		for _, hero in ipairs(srcList or {}) do
			if _isHeroMatch(hero) then
				table.insert(afterFliterLst, hero)
			end
		end

		srcList = afterFliterLst
	end

	return srcList
end

function CharacterUtil.HouseSort(srcList, sortTyp, params, ascending)
	if srcList == nil then
		return srcList
	end

	if #srcList <= 1 then
		return srcList
	end

	local sortTypDefine = CommEnum.HeroHouseSortType
	local sortFunc
	local roomType = params and params.roomType
	local isDorm = params and params.isDorm

	if sortTyp == sortTypDefine.Default then
		srcList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.HeroDepot, srcList)
	elseif sortTyp == sortTypDefine.Mood then
		function sortFunc(a, b)
			return CharacterUtil.sortMood(a, b, roomType, ascending, isDorm)
		end
	elseif sortTyp == sortTypDefine.HouseSkill then
		function sortFunc(a, b)
			return CharacterUtil.sortHouseSkill(a, b, roomType, ascending, isDorm)
		end
	elseif sortTyp == sortTypDefine.WorkType then
		function sortFunc(a, b)
			return CharacterUtil.sortWorkType(a, b, roomType, ascending, isDorm)
		end
	end

	if sortFunc then
		table.sort(srcList, sortFunc)
	end

	return srcList
end

function CharacterUtil._sortMood(item1, item2, ascending)
	local heroFeatureMoA = HeroHouseFeatureModel.instance:getFeatureMO(item1:getId())
	local heroFeatureMoB = HeroHouseFeatureModel.instance:getFeatureMO(item2:getId())
	local moodA = heroFeatureMoA and heroFeatureMoA:getMood() or 0
	local moodB = heroFeatureMoB and heroFeatureMoB:getMood() or 0

	if moodA == moodB then
		return
	end

	if ascending then
		return moodA < moodB
	else
		return moodB < moodA
	end
end

function CharacterUtil._sortHouseSkill(item1, item2, targetRoomType, ascending)
	local skillA = 0
	local skillB = 0
	local skillListA = HeroHouseFeatureModel.instance:getFeatureSkillByHeroId(item1:getId())
	local skillListB = HeroHouseFeatureModel.instance:getFeatureSkillByHeroId(item2:getId())

	local function _skillMatch(skillList)
		for _, v in ipairs(skillList) do
			if v.isUnlock then
				local skillCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseSkill, v.skillId)

				if skillCO and skillCO.roomType and #skillCO.roomType > 0 then
					for _, type in ipairs(skillCO.roomType) do
						if type == targetRoomType then
							return true
						end
					end
				end
			end
		end

		return false
	end

	if _skillMatch(skillListA) then
		skillA = 1
	end

	if _skillMatch(skillListB) then
		skillB = 1
	end

	if skillA == skillB then
		return
	end

	if ascending then
		return skillB < skillA
	else
		return skillA < skillB
	end
end

function CharacterUtil._sortWorkType(item1, item2, ascending)
	local jobDataA = HouseWorkerModel.instance:getScheduleByHeroId(item1:getId())

	jobDataA = jobDataA and 1 or 0

	local jobDataB = HouseWorkerModel.instance:getScheduleByHeroId(item2:getId())

	jobDataB = jobDataB and 1 or 0

	if jobDataA == jobDataB then
		return
	end

	if ascending then
		return jobDataA < jobDataB
	else
		return jobDataB < jobDataA
	end
end

function CharacterUtil._sortId(item1, item2, ascending)
	if ascending then
		return item1:getId() < item2:getId()
	end

	return item1:getId() > item2:getId()
end

function CharacterUtil._sortEduState(item1, item2)
	local eduState1 = HeroHouseFeatureModel.instance:getHeroThoughtEduState(item1:getId())
	local eduState2 = HeroHouseFeatureModel.instance:getHeroThoughtEduState(item2:getId())

	if eduState1 ~= eduState2 then
		return eduState1 < eduState2
	end
end

function CharacterUtil._sortLivingRoom(item1, item2)
	local zoneMo1 = LivingFacilitiesZoneController.instance:findZoneByHeroId(item1:getId())
	local zoneMo2 = LivingFacilitiesZoneController.instance:findZoneByHeroId(item2:getId())

	if not zoneMo1 and zoneMo2 then
		return true
	end

	if not zoneMo2 and zoneMo1 then
		return false
	end
end

function CharacterUtil.sortMood(item1, item2, targetRoomType, ascending, isDorm)
	local result = CharacterUtil._sortEduState(item1, item2)

	if result == nil and isDorm then
		result = CharacterUtil._sortLivingRoom(item1, item2)
	end

	if result == nil then
		result = CharacterUtil._sortMood(item1, item2, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortHouseSkill(item1, item2, targetRoomType, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortWorkType(item1, item2, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortId(item1, item2, ascending)
	end

	return result
end

function CharacterUtil.sortHouseSkill(item1, item2, targetRoomType, ascending, isDorm)
	local result = CharacterUtil._sortEduState(item1, item2)

	if result == nil and isDorm then
		result = CharacterUtil._sortLivingRoom(item1, item2)
	end

	if result == nil then
		result = CharacterUtil._sortHouseSkill(item1, item2, targetRoomType, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortMood(item1, item2, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortWorkType(item1, item2, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortId(item1, item2, ascending)
	end

	return result
end

function CharacterUtil.sortWorkType(item1, item2, targetRoomType, ascending, isDorm)
	local result = CharacterUtil._sortEduState(item1, item2)

	if result == nil and isDorm then
		result = CharacterUtil._sortLivingRoom(item1, item2)
	end

	if result == nil then
		result = CharacterUtil._sortWorkType(item1, item2, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortMood(item1, item2, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortHouseSkill(item1, item2, targetRoomType, ascending)
	end

	if result == nil then
		result = CharacterUtil._sortId(item1, item2, ascending)
	end

	return result
end

function CharacterUtil.getPreviewHeroData(characterCode)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(characterCode)
	local quality = characterCO.quality
	local fightRatioCO = CharacterConfig.instance:getFightRatioCo(characterCO.fightingCapacity)
	local maxPowerLevel = CharacterExpConfig.instance:getMaxPowerLevelByQuality(quality)
	local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(maxPowerLevel, quality)
	local attrEnhancePercent = HeroBreakConfig.instance:getBreakAttGrowEnhance(characterCode, HeroBreakConfig.instance:getMaxBreakLevel())

	attrEnhancePercent = attrEnhancePercent + 1

	local attrRawList = HeroPowerConfig.instance:getHeroAdditionAttr(characterCode)
	local skillActiveCount = HeroPowerConfig.instance:getCharacterSkillActiveCount(characterCode)
	local keyList = {}

	for i, attrRaw in ipairs(attrRawList) do
		keyList[attrRaw.attr.key] = keyList[attrRaw.attr.key] or 0
		keyList[attrRaw.attr.key] = keyList[attrRaw.attr.key] + attrRaw.attr.value
	end

	local skillList = {}

	for i, normalSkill in ipairs(characterCO.normalSkills) do
		table.insert(skillList, {
			value = 1,
			key = normalSkill
		})
	end

	local function getBaseValue(b, s)
		return b + s * (maxLevel - 1) * attrEnhancePercent
	end

	local maxHpBase = getBaseValue(characterCO.b_maxHp, characterCO.s_maxHp)
	local atkPhyBase = getBaseValue(characterCO.b_meleeAtk, characterCO.s_meleeAtk)
	local defPhyBase = getBaseValue(characterCO.b_meleeDef, characterCO.s_meleeDef)
	local atkMagBase = getBaseValue(characterCO.b_magicAtk, characterCO.s_magicAtk)
	local defMagBase = getBaseValue(characterCO.b_magicDef, characterCO.s_magicDef)
	local inspirationBase = BattleTestFormula.characterConfigFormula.inspiration(characterCO, maxLevel)

	local function getAttr(key)
		local attrCo = AttributeDefineConfig.instance:getAttributePartByProgramming(key)

		return attrCo and keyList[tostring(attrCo.code)] or 0
	end

	local maxHpBaseAdd = getAttr("PART_MAX_HP_BASE")
	local atkPhyBaseAdd = getAttr("PART_ATK_PHY_BASE")
	local defPhyBaseAdd = getAttr("PART_DEF_PHY_BASE")
	local atkMagBaseAdd = getAttr("PART_ATK_MAG_BASE")
	local defMagBaseAdd = getAttr("PART_DEF_MAG_BASE")
	local maxHpMult = getAttr("PART_MAX_HP_MULTIPLICATION")
	local atkPhyMult = getAttr("PART_ATK_PHY_MULTIPLICATION")
	local defPhyMult = getAttr("PART_DEF_PHY_MULTIPLICATION")
	local atkMagMult = getAttr("PART_ATK_MAG_MULTIPLICATION")
	local defMagMult = getAttr("PART_DEF_MAG_MULTIPLICATION")
	local maxHpAdd = getAttr("PART_MAX_HP_ADDITION")
	local atkPhyAdd = getAttr("PART_ATK_PHY_ADDITION")
	local defPhyAdd = getAttr("PART_DEF_PHY_ADDITION")
	local atkMagAdd = getAttr("PART_ATK_MAG_ADDITION")
	local defMagAdd = getAttr("PART_DEF_MAG_ADDITION")
	local maxHp = (maxHpBase + maxHpBaseAdd) * (1 + maxHpMult) + maxHpAdd
	local atkPhy = (atkPhyBase + atkPhyBaseAdd) * (1 + atkPhyMult) + atkPhyAdd
	local defPhy = (defPhyBase + defPhyBaseAdd) * (1 + defPhyMult) + defPhyAdd
	local atkMag = (atkMagBase + atkMagBaseAdd) * (1 + atkMagMult) + atkMagAdd
	local defMag = (defMagBase + defMagBaseAdd) * (1 + defMagMult) + defMagAdd
	local attrFight = fightRatioCO.attrBase + (maxHp * fightRatioCO.hp + atkPhy * fightRatioCO.atkPhy + defPhy * fightRatioCO.defPhy + atkMag * fightRatioCO.atkMag + defMag * fightRatioCO.defMag) * (1 + inspirationBase * fightRatioCO.inspire)
	local skillFight = 1 + skillActiveCount * fightRatioCO.normalSkill + 5 * fightRatioCO.talentSkill
	local fightValue = attrFight * skillFight
	local qua6 = characterCO.qua6
	local hero = {
		lvExp = 0,
		wakeup = true,
		id = characterCode,
		level = maxLevel,
		powerLv = maxPowerLevel,
		breakLv = HeroBreakConfig.instance:getMaxBreakLevel(),
		attrParts = {},
		attrs = {
			{
				attr = BattleExtension_pb.Attribute.MAX_HP,
				value = math.floor(maxHp)
			},
			{
				attr = BattleExtension_pb.Attribute.ATK_PHY,
				value = math.floor(atkPhy)
			},
			{
				attr = BattleExtension_pb.Attribute.DEF_PHY,
				value = math.floor(defPhy)
			},
			{
				attr = BattleExtension_pb.Attribute.ATK_MAG,
				value = math.floor(atkMag)
			},
			{
				attr = BattleExtension_pb.Attribute.DEF_MAG,
				value = math.floor(defMag)
			},
			{
				attr = BattleExtension_pb.Attribute.INSPIRATION,
				value = math.floor(inspirationBase)
			},
			{
				attr = BattleExtension_pb.Attribute.FIGHTING_CAPACITY,
				value = math.floor(fightValue)
			}
		},
		tacitExp = TacitConfig.instance:getMaxExp(),
		skills = skillList,
		qua6 = qua6
	}
	local heroData = CharacterData.New(hero)

	return heroData
end

function CharacterUtil.openCharacterPreviewView(characterCode)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_TO_CHARACTER_PREVIEW)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_enter, nil, nil, nil)
	CharacterPreviewModel.instance:setCurHeroId(characterCode)

	local heroData = CharacterUtil.getPreviewHeroData(characterCode)

	CharacterPreviewModel.instance:setHeroData(heroData)
	CharacterPreviewModel.instance:setShowType(CharacterPreviewModel.PreviewType.MaxLevel)

	local sceneId = SceneFace.SceneType2Id[SceneType.CharacterPreview]

	SceneFace.instance:temporarilyChangeScene(SceneType.CharacterPreview, sceneId, true)
end

function CharacterUtil.openCharacterDetailView(characterCode)
	local param = {}

	param.heroId = characterCode
	param.characterDetailType = CommEnum.CharacterDetailType.Oneself

	ViewMgr.instance:open(ViewName.CharacterDetailPreview, param)
end

function CharacterUtil.openOthersCharacterDetailView(userId, characterCode)
	local param = {}

	param.userId = userId
	param.heroId = characterCode
	param.characterDetailType = CommEnum.CharacterDetailType.OtherUser

	ViewMgr.instance:open(ViewName.CharacterDetailPreview, param)
end

function CharacterUtil.openRankCharacterDetailView(rankId, userId, characterCode)
	local param = {}

	param.rankId = rankId
	param.userId = userId
	param.heroId = characterCode
	param.characterDetailType = CommEnum.CharacterDetailType.Rank

	ViewMgr.instance:open(ViewName.CharacterDetailPreview, param)
end

function CharacterUtil.openCharacterSkillPreview(characterCode)
	local heroData = HeroDepotModel.instance:getHeroInfoByID(characterCode)

	CharacterPreviewModel.instance:setCurHeroId(characterCode)
	CharacterPreviewModel.instance:setHeroData(heroData)
	CharacterPreviewModel.instance:setShowType(CharacterPreviewModel.PreviewType.SkillDetail)
	ViewMgr.instance:open(ViewName.Character3DPreview)
end

function CharacterUtil.openCharacterLookoverView(herodata, index, list)
	HeroDepotModel.instance:setViewPageMo({
		hero = herodata,
		index = index,
		list = {
			herodata
		}
	})
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_enter, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterLookoverViewPresentor)
end

function CharacterUtil.getAllCharacter()
	local tempData = BaseListModel.New()

	tempData:clear()

	local dataList = CharacterConfig.instance:getCharacterDataList()

	for k, data in pairs(dataList) do
		if data.isOnline == 1 then
			local herodata = CharacterUtil.getPreviewHeroData(data.id)

			tempData:addMo(herodata)
		end
	end

	return tempData
end

function CharacterUtil.hasHeroCanUpgradeInLst(heroIds)
	local heroId = false

	if heroIds and #heroIds > 0 then
		local goldNum = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.LzbCode)
		local totalItemExp = CharacterUtil._getUpgradeItemExp()

		if goldNum <= 0 or totalItemExp <= 0 then
			return heroId
		end

		for _, _heroId in ipairs(heroIds) do
			if CharacterUtil._isHeroCanUpgrade(_heroId, goldNum, totalItemExp, false) then
				heroId = _heroId

				break
			end
		end
	end

	return heroId
end

function CharacterUtil.getHeroLevelCodeInLstForFailTips(heroIds)
	local hasNotReachMax = false
	local tempList = BattleTableUtil.getTempList()
	local minLevel = 999

	if heroIds and #heroIds > 0 then
		for _, _heroId in ipairs(heroIds) do
			local mo = HeroDepotModel.instance:getHeroInfoByID(_heroId)

			if mo then
				if not mo:getIsMaxLevel() then
					hasNotReachMax = true
				end

				if minLevel > mo:getLevel() then
					table.clear(tempList)
					table.insert(tempList, _heroId)

					minLevel = mo:getLevel()
				elseif mo:getLevel() == minLevel then
					table.insert(tempList, _heroId)
				end
			end
		end
	end

	local heroCode = BattleCalculateMgr.instance:findFirstHeroCodeByDefaultRules(tempList)

	BattleTableUtil.releaseTempList(tempList)

	return hasNotReachMax, heroCode
end

function CharacterUtil.getHeroEchoCodeInLstForFailTips(heroIds)
	local hasNotCarryEcho = false
	local tempList = BattleTableUtil.getTempList()

	if heroIds and #heroIds > 0 then
		for _, _heroId in ipairs(heroIds) do
			local mo = HeroDepotModel.instance:getHeroInfoByID(_heroId)
			local echoData = mo:getHeroEchoItemData()
			local hasEcho = echoData:getEchoItem() and true or false

			if not hasEcho then
				hasNotCarryEcho = true
			end

			if not hasEcho then
				table.insert(tempList, _heroId)
			end
		end
	end

	if not hasNotCarryEcho then
		table.insertto(tempList, heroIds)
	end

	local heroCode = BattleCalculateMgr.instance:findFirstHeroCodeByDefaultRules(tempList)

	BattleTableUtil.releaseTempList(tempList)

	return hasNotCarryEcho, heroCode
end

function CharacterUtil.isHeroCanUpgrade(heroId, showTips)
	local goldNum = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.LzbCode)
	local totalItemExp = CharacterUtil._getUpgradeItemExp()

	return CharacterUtil._isHeroCanUpgrade(heroId, goldNum, totalItemExp, showTips)
end

function CharacterUtil._getUpgradeItemExp()
	local totalItemExp = 0
	local expAddProfile, goldConsumeProfile = AchievementModel.instance:getHeroUpgradeAchievementSkillFactor()

	for _, itemData in ipairs(ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.PropItemType, GameEnum.PropSubTypeEnum.CardExpProp) or {}) do
		local itemExp = tonumber(itemData:getExtrInfo()) * (1 + expAddProfile)

		totalItemExp = totalItemExp + itemExp * itemData:getCount()
	end

	return totalItemExp
end

function CharacterUtil._isHeroCanUpgrade(heroId, goldNum, totalItemExp, showTips)
	local mo = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if mo then
		if not mo:getIsMaxLevel() then
			local expRemained, expCost = mo:getRemainedExpAndCostToTargetLv(mo:getLevel() + 1)

			if expRemained > 0 and expCost <= goldNum and expRemained <= totalItemExp then
				return true
			elseif showTips then
				FloatWordMgr.instance:show(lang("tip_equip_lv_item_less"))
			end
		else
			if showTips then
				if mo:getPowerLv() == HeroPowerConfig.instance:getMaxPowerLevel(mo:getId()) then
					FloatWordMgr.instance:show(lang("tip_character_level_max"))
				else
					FloatWordMgr.instance:show(lang("tip_character_level_limit_1"))
				end
			end

			return false
		end
	end

	return false
end

function CharacterUtil.isHeroCanBrealLvUp(heroId, checkSysOpen)
	checkSysOpen = checkSysOpen or true

	if checkSysOpen and not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleBreak, false) then
		return false
	end

	local function isHeroCanBreakCheckFunc(heroData)
		if not heroData then
			return false
		end

		local curLevel = heroData:getBreakLv()
		local maxLevel = #HeroBreakConfig.instance:getAllHeroBreak()

		if maxLevel <= curLevel then
			return false
		end

		local count, itemData = ItemModel.instance:getItemByHeroId(heroData:getId(), CommEnum.HeroItemSubType.HeroHeartAnchor)

		if not itemData then
			local allHeroItem = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.HeroItemType, 1)

			for _, v in pairs(allHeroItem) do
				if v.heroId == heroData:getId() then
					itemData = ItemData.New({
						count = 0,
						itemId = v.id
					})

					break
				end
			end
		end

		local heroBreakCO = HeroBreakConfig.instance:getInfo(curLevel + 1)
		local needHeartAnchor = heroBreakCO and heroBreakCO.needNum or 1
		local curNum = ItemModel.instance:getItemCountByItemId(itemData:getItemId())

		return needHeartAnchor <= curNum
	end

	if heroId then
		local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

		return isHeroCanBreakCheckFunc(heroData)
	else
		local canBreakLvUp = false
		local heroDataLst = HeroDepotModel.instance:getHeroDepotData():getHeroDataList() or {}

		for _, heroData in ipairs(heroDataLst) do
			if not canBreakLvUp and isHeroCanBreakCheckFunc(heroData) then
				canBreakLvUp = true
			end
		end

		return canBreakLvUp
	end
end

function CharacterUtil.isHeroHasTacitTaskCanReceive(heroId, checkSysOpen)
	checkSysOpen = checkSysOpen or true

	if checkSysOpen and not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit, false) then
		return false
	end

	local match = false
	local redPointLstFromServer = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.TacitTask) or {}

	if heroId then
		for _, idStr in ipairs(redPointLstFromServer) do
			if not match and tonumber(idStr) == heroId then
				match = true
			end
		end
	else
		match = #redPointLstFromServer > 0
	end

	return match
end

function CharacterUtil.isHeroCanSublimed(heroId)
	if not heroId or heroId <= 0 then
		return false
	end

	local cfg = TacitConfig.instance:getTacitCO(heroId)

	if not cfg then
		return false
	end

	if cfg.isOnLine <= 0 then
		return false
	end

	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroData then
		return false
	end

	if heroData:getAwakeTalent() then
		return false
	end

	local carryItemUnlock = true

	for i = CharacterInfoEnum.UnlockTyp.CarryItem1, CharacterInfoEnum.UnlockTyp.CarryItem4 do
		if not CharacterInformationModel.instance:getUnlockPastInfo(heroId, i) then
			carryItemUnlock = false
		end
	end

	if not carryItemUnlock then
		return false
	end

	local itemId, itemCount = TacitConfig.instance:getTalentSkillWakeUpCostItem(heroId)

	if itemId and itemId > 0 then
		local curCount = ItemModel.instance:getItemCountByItemId(itemId)

		if curCount < itemCount then
			return false
		end
	end

	return true
end

function CharacterUtil.isHeroNewItem(heroId, checkSysOpen)
	checkSysOpen = checkSysOpen or true

	if checkSysOpen and not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleDepotUI, false) then
		return false
	end

	local heroItemMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.HeroType) or {}

	if heroId then
		for _, v in pairs(heroItemMoList) do
			if v:getItemId() == heroId then
				return v:getRedPointIsNew()
			end
		end
	else
		local hasNew = false

		for _, v in pairs(heroItemMoList) do
			if not hasNew and v:getRedPointIsNew() then
				hasNew = true
			end
		end

		return hasNew
	end
end

function CharacterUtil.getXinMaoMount(heroGo)
	if goutil.isNil(heroGo) then
		return nil
	end

	local bindGo
	local storyCache = StoryBoneCache.Get(heroGo)

	if storyCache and storyCache.xinMaoGo then
		bindGo = storyCache.xinMaoGo
	end

	if not bindGo then
		local lst = heroGo.transform:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

		if lst and lst.Length > 1 then
			for i = 0, lst.Length - 1 do
				if not bindGo then
					local _go = lst[i]

					if string.match(_go.name, "xinmao") then
						bindGo = _go.gameObject
					end
				end
			end
		end
	end

	return bindGo
end

function CharacterUtil.getFaceBindGo(heroGo)
	if goutil.isNil(heroGo) then
		return nil
	end

	local bindGo
	local storyCache = StoryBoneCache.Get(heroGo)

	if storyCache and storyCache.blushGo then
		bindGo = storyCache.blushGo
	end

	if not bindGo then
		local lst = heroGo.transform:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

		if lst and lst.Length > 1 then
			for i = 0, lst.Length - 1 do
				if not bindGo then
					local _go = lst[i]

					if _go.name == "face" then
						bindGo = _go.gameObject
					end
				end
			end
		end
	end

	return bindGo
end

function CharacterUtil.getXinMaoLightGo(xinmaoGo)
	local lightGo

	if not xinmaoGo or goutil.isNil(xinmaoGo) then
		return lightGo
	end

	local lst = xinmaoGo.transform:GetComponentsInChildren(typeof(UnityEngine.Light), true)

	if lst and lst.Length >= 1 then
		local _go = lst[0]
		local parentGo = _go.transform.parent.gameObject

		if parentGo.activeSelf then
			lightGo = parentGo
		end
	end

	return lightGo
end

function CharacterUtil.modelId2HeroIdSkinId(modelId)
	local heroId, skinId

	if not modelId or modelId <= 0 then
		return heroId, skinId
	end

	if not heroId then
		for _, _cfg in pairs(CharacterConfig.instance:getCharacterDataList() or {}) do
			if _cfg.heroId > 2000000 and _cfg.modelId == modelId then
				heroId = _cfg.heroId
				skinId = 0
			end
		end
	end

	if not heroId then
		for _, _cfg in pairs(BackpackConfig.instance:getConfig(ConfigName.ItemHeroSkin) or {}) do
			if _cfg.heroId > 2000000 and _cfg.module == modelId then
				if not heroId then
					heroId = _cfg.heroId
					skinId = _cfg.id
				elseif Astral.OSDef.isEditor then
					printWarn(string.format("model[%s]已被hero[%s]skin[%s]定义,skin[%s]将不会覆盖该值", modelId, heroId, skinId, _cfg.id))
				end
			end
		end
	end

	return heroId, skinId
end

function CharacterUtil.getModelId(heroId, skinId)
	local modelId

	if skinId and skinId > 0 then
		local skinCo = HeroSkinConfig.instance:getInfo(skinId)

		if skinCo then
			modelId = skinCo.module
		end
	end

	if not modelId then
		local entityCO = BattleConfigUtil.getEntityConfig(heroId)

		if entityCO then
			modelId = entityCO.modelId
		else
			printError(string.format("无法找到[%s]的配置", heroId))
		end
	end

	return modelId
end

function CharacterUtil.getDepotHeroModelId(heroId)
	heroId = tonumber(heroId)

	local modelId
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroData then
		modelId = heroData:getModelId()
	else
		modelId = CharacterUtil.getModelId(heroId, 0)
	end

	return modelId
end

function CharacterUtil.getDepotHeroSkinId(heroId)
	heroId = tonumber(heroId)

	local skinId
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroData then
		skinId = heroData:getSkinId()
	end

	return skinId
end

function CharacterUtil.isHeroModelOptimizing(heroId)
	if not heroId or heroId <= 0 then
		return false
	end

	local cfg = CharacterConfig.instance:getCfgInfoByID(heroId)

	if cfg and cfg.modelOptimizing > 0 then
		return true
	end

	return false
end

function CharacterUtil.isFilterSelected(moduleType)
	local record = CharacterUtil._filterViewOptRecord[moduleType] or {}
	local campTb = record.camp or {
		0
	}
	local qualityTb = record.quality or {
		0
	}
	local careerTb = record.career or {
		0
	}
	local colorTb = record.color or {
		0
	}
	local tagTb = record.tag or {
		0
	}

	if campTb[1] == 0 and qualityTb[1] == 0 and careerTb[1] == 0 and colorTb[1] == 0 and tagTb[1] == 0 then
		return false
	end

	return true
end

function CharacterUtil.isTabTypeSelected(moduleType, tabType)
	local isSelected = false
	local record = CharacterUtil._filterViewOptRecord[moduleType] or {}
	local campTb = record.camp or {
		0
	}
	local qualityTb = record.quality or {
		0
	}
	local careerTb = record.career or {
		0
	}
	local colorTb = record.color or {
		0
	}
	local tagTb = record.tag or {
		0
	}

	if tabType == HeroFilterEnum.TabType.CareerAndColor then
		isSelected = careerTb[1] ~= 0 or colorTb[1] ~= 0
	elseif tabType == HeroFilterEnum.TabType.Quality then
		isSelected = qualityTb[1] ~= 0
	elseif tabType == HeroFilterEnum.TabType.Tag then
		isSelected = tagTb[1] ~= 0
	end

	return isSelected
end

return CharacterUtil
