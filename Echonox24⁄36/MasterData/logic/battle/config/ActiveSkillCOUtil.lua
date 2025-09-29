-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/ActiveSkillCOUtil.lua

module("logic.battle.config.ActiveSkillCOUtil", package.seeall)

local ActiveSkillCOUtil = {}

ActiveSkillCOUtil.FIELD_RELEASE_DISTANCE = "releaseDistance"
ActiveSkillCOUtil.ACTION_NAMES = {
	"effectAction1",
	"effectAction2",
	"effectAction3",
	"effectAction4"
}
ActiveSkillCOUtil.CONDITION_NAMES = {
	"effectCondition1",
	"effectCondition2",
	"effectCondition3",
	"effectCondition4"
}
ActiveSkillCOUtil.MODIFIABLE_FIELDS_NAMES = {
	"releaseDistance",
	"sanityConsume"
}
ActiveSkillCOUtil.DELIMITER01 = "#"
ActiveSkillCOUtil.DELIMITER02 = ","
ActiveSkillCOUtil.DELIMITER03 = "-"
ActiveSkillCOUtil.REGEX_DESC = "%b<>"
ActiveSkillCOUtil.PATTERN_MODIFIED_POSSIBLE = "#FFFFFF"
ActiveSkillCOUtil.PATTERN_DESC_COLOR = "#FFFFFF"
ActiveSkillCOUtil.HIGHT_LIGHT_TAG_COLOR = "#326089CB"

local kPercent = "%"
local kDescBuffAndTagRegex = "%b[]"
local kDescModifiedPossibleColorRegex = "%b$$"
local kPatternPercent = "%s%%"

function ActiveSkillCOUtil.getActionName(effectIndex, actionIndex)
	return string.format("effect-%d_action-%d", effectIndex, actionIndex)
end

function ActiveSkillCOUtil.getConditionName(effectIndex, actionIndex)
	return string.format("effect-%d_action-%d", effectIndex, actionIndex)
end

function ActiveSkillCOUtil.getCategoryLabel(skillCOWrapper, status)
	status = status or BattleEnum.SkillStatus.Normal

	return lang(CommEnum.SkillKindDisName[skillCOWrapper:getDisplayCategory(status)])
end

function ActiveSkillCOUtil.getRangeLabel(skillCOWrapper, isActiveSkill, status)
	status = status or BattleEnum.SkillStatus.Normal

	if not isActiveSkill then
		return lang("tip_unkonw")
	end

	local shape = skillCOWrapper:getSkillRangeShape()

	if BattleEnum.Shape[shape.type] == BattleEnum.Shape.Rhombus or BattleEnum.Shape[shape.type] == BattleEnum.Shape.Circle or BattleEnum.Shape[shape.type] == BattleEnum.Shape.Sector then
		if shape.range > 0 then
			if BattleEnum.Shape[shape.type] == BattleEnum.Shape.Rhombus then
				return string.format(lang("tip_rhombus"), shape.range)
			elseif BattleEnum.Shape[shape.type] == BattleEnum.Shape.Sector then
				return string.format(lang("tip_sector"), shape.range)
			else
				return string.format(lang("tip_circle"), shape.range)
			end
		else
			return lang("tip_monomer")
		end
	elseif BattleEnum.Shape[shape.type] == BattleEnum.Shape.Rectangle then
		return string.format("%dx%d矩形", shape.width, shape.height)
	end
end

function ActiveSkillCOUtil.getReleaseDistanceLabel(skillCOWrapper, releaseDistance, status)
	local selectableTarget = skillCOWrapper:getSelectableTarget(status)

	if selectableTarget == BattleEnum.SkillSelectableTarget.SELF then
		return lang("tip_oneself")
	end

	if releaseDistance <= 0 then
		return lang("tip_oneself")
	end

	return string.format(lang("tip_grid"), releaseDistance)
end

function ActiveSkillCOUtil.getSkillBg(skillCO)
	return 1001
end

function ActiveSkillCOUtil.getSkillIcon(skillCO)
	return skillCO.icon
end

function ActiveSkillCOUtil.isPassive(skillCOWrapper, status)
	if ActiveSkillCOUtil.isTalent(skillCOWrapper, status) then
		return false
	end

	return skillCOWrapper:getDisplayCategory(status) == CommEnum.SkillDisplayCategory.Passive
end

function ActiveSkillCOUtil.isPassiveByPurpose(skillCOWrapper, status)
	local effectType = skillCOWrapper:getSkillEffectType(status)

	return effectType == BattleEnum.SkillPurpose.PASSIVE or effectType == BattleEnum.SkillPurpose.HALOPASSIVE
end

function ActiveSkillCOUtil.isTalent(skillCOWrapper, status)
	return skillCOWrapper:getSkillType(status) == BattleEnum.SkillCategory.TALENT
end

function ActiveSkillCOUtil.isNormal(skillCOWrapper, status)
	return skillCOWrapper:getSkillType(status) == BattleEnum.SkillCategory.NORMAL
end

function ActiveSkillCOUtil.isSpecial(skillCOWrapper, status)
	return skillCOWrapper:getSkillType(status) == BattleEnum.SkillCategory.SPECIAL
end

function ActiveSkillCOUtil.isTrump(skillCOWrapper, status)
	return skillCOWrapper:getSkillType(status) == BattleEnum.SkillCategory.TRUMP
end

function ActiveSkillCOUtil.isCarry(skillCOWrapper, status)
	local skillType = skillCOWrapper:getSkillType(status)

	return skillType == BattleEnum.SkillCategory.ECHO or skillType == BattleEnum.SkillCategory.DEPUTY or skillType == BattleEnum.SkillCategory.EQUIPMENT
end

function ActiveSkillCOUtil.isActiveSkill(skillCOWrapper, status)
	local skillEffectType = skillCOWrapper:getSkillEffectType(status)

	return skillEffectType == BattleEnum.SkillPurpose.DAMAGE or skillEffectType == BattleEnum.SkillPurpose.CURE or skillEffectType == BattleEnum.SkillPurpose.TRANSPORT or skillEffectType == BattleEnum.SkillPurpose.SUMMON or skillEffectType == BattleEnum.SkillPurpose.MULTI_ROUND_AOE or skillEffectType == BattleEnum.SkillPurpose.MARK
end

function ActiveSkillCOUtil.isCloseCombat(skillCOWrapper, status)
	local releaseDistance = skillCOWrapper:getReleaseDistance(status)

	return releaseDistance <= 1
end

function ActiveSkillCOUtil.isReleaseTypeSniping(skillCOWrapper, status)
	local releaseSkillType = skillCOWrapper and skillCOWrapper:getReleaseSkillType(status) or false

	return releaseSkillType == BattleEnum.SkillReleaseType.SNIPING
end

function ActiveSkillCOUtil.isSkillPurposeMultiRoundAOE(skillCOWrapper, status)
	local skillEffectType = skillCOWrapper and skillCOWrapper:getSkillEffectType(status) or false

	return skillEffectType == BattleEnum.SkillPurpose.MULTI_ROUND_AOE
end

function ActiveSkillCOUtil.containsAddEnhance(enhanceCodes)
	if not enhanceCodes then
		return false
	end

	for _, enhanceCode in ipairs(enhanceCodes) do
		local enhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

		if enhanceCOWrapper:isAddEnhance() then
			return true
		end
	end

	return false
end

function ActiveSkillCOUtil.replaceDescriptionSpecialColor(description, buffColorStr, modifiedColorStr, isIgnoreColor)
	local function kReplaceDescFunction(descPatternResult)
		if string.nilorempty(buffColorStr) then
			buffColorStr = ActiveSkillCOUtil.PATTERN_DESC_COLOR
		end

		local matchContent = string.sub(descPatternResult, 2, -2)

		if isIgnoreColor then
			return matchContent
		end

		return string.format("<color=%s>%s</color>", ActiveSkillCOUtil.PATTERN_DESC_COLOR, matchContent)
	end

	description = string.gsub(description, kDescBuffAndTagRegex, kReplaceDescFunction)

	local function kReplaceModifiedescFunction(descPatternResult)
		if string.nilorempty(modifiedColorStr) then
			modifiedColorStr = ActiveSkillCOUtil.PATTERN_MODIFIED_POSSIBLE
		end

		local matchContent = string.sub(descPatternResult, 2, -2)

		if isIgnoreColor then
			return matchContent
		end

		return string.format("<color=%s>%s</color>", ActiveSkillCOUtil.PATTERN_MODIFIED_POSSIBLE, matchContent)
	end

	description = string.gsub(description, kDescModifiedPossibleColorRegex, kReplaceModifiedescFunction)

	return description
end

function ActiveSkillCOUtil.removeDescriptionSpecialColor(description)
	local function kReplaceDescFunction(descPatternResult)
		local matchContent = string.sub(descPatternResult, 2, -2)

		return matchContent
	end

	description = string.gsub(description, kDescBuffAndTagRegex, kReplaceDescFunction)

	local function kReplaceModifiedescFunction(descPatternResult)
		local matchContent = string.sub(descPatternResult, 2, -2)

		return matchContent
	end

	description = string.gsub(description, kDescModifiedPossibleColorRegex, kReplaceModifiedescFunction)

	return description
end

function ActiveSkillCOUtil.buildBuffAndTagDesc(description, buffDic, tagDic, highLightTagIds, noUnderLine)
	local function kReplaceDescFunction(descPatternResult)
		local matchContent = string.sub(descPatternResult, 2, -2)

		if string.find(matchContent, "tag") then
			local tag = string.gsub(matchContent, "tag_", "")
			local tagId = tonumber(tag)

			tagId = tagId or ActiveSkillConfig.instance:getSkillTagIdByDescKey(tag)

			local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

			if not tagCO then
				if enableErrorLog then
					printError("该技能描述找不到对应tag:", description)
				end

				return
			end

			if tagCO then
				if tagDic then
					tagDic[tagId] = true
				end

				local icon = ActiveSkillConfig.instance:getTagIconName(tagCO.typeName)

				if noUnderLine then
					return string.format("<sprite name=\"%s\">[%s]", icon, tagCO.name)
				else
					return string.format("<sprite name=\"%s\">[<u>%s</u>]", icon, tagCO.name)
				end
			end
		elseif string.find(matchContent, "buff") then
			local buff = string.gsub(matchContent, "buff_", "")
			local buffId = tonumber(buff)

			buffId = buffId or BuffConfig.instance:getBuffIdByKey(buff)

			if not buffId then
				if enableErrorLog then
					printError("该技能描述找不到对应buff:", description)
				end

				return
			end

			local buffCO = BuffConfig.instance:getBuffCO(buffId)

			if buffCO then
				if buffDic then
					buffDic[buffId] = true
				end

				if noUnderLine then
					return string.format("<sprite name=\"%s\">[%s]", buffCO.descIcon, buffCO.name)
				else
					return string.format("<sprite name=\"%s\">[<u>%s</u>]", buffCO.descIcon, buffCO.name)
				end
			end
		end
	end

	description = string.gsub(description, kDescBuffAndTagRegex, kReplaceDescFunction)

	return description
end

function ActiveSkillCOUtil.getContentFromDescPatternResult(descPatternResult, percentCount)
	percentCount = percentCount + 2

	return string.sub(descPatternResult, 2, -percentCount)
end

function ActiveSkillCOUtil.formatValueByPercentCount(value, percentCount)
	if percentCount > 1 then
		return string.format(kPatternPercent, value * 100)
	end

	if percentCount > 0 then
		return value * 100
	end

	return value
end

function ActiveSkillCOUtil.calculatePercentCount(descPatternResult)
	local count = 0

	for i = -3, -2 do
		if string.sub(descPatternResult, i, i) == kPercent then
			count = count + 1
		end
	end

	return count
end

function ActiveSkillCOUtil.getKeyAndIndexOfMatchContent(matchContent)
	local arrContent = string.split(matchContent, ActiveSkillCOUtil.DELIMITER03)

	return arrContent[1], arrContent[2] and checkint(arrContent[2]) or 1
end

function ActiveSkillCOUtil.getWeakPointMaxHpPrecent(skillCode, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)
	local weakPointAction = skillCOWrapper:getWeakPointParams(status)

	if weakPointAction then
		local weakPointPercent = weakPointAction.weakBlood

		return weakPointPercent
	end

	return 0
end

function ActiveSkillCOUtil.getWeakPointLinkedTag(skillCode, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)
	local weakPointAction = skillCOWrapper:getEntityLinkedWeakPointParams(status)

	return weakPointAction and weakPointAction.tag
end

function ActiveSkillCOUtil.getMultiAOEShape(skillCode, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)
	local multiAOEAction = skillCOWrapper:getMultiAOEParams(status)

	if multiAOEAction then
		return multiAOEAction.shape
	end

	return false
end

function ActiveSkillCOUtil.isModifiableField(effectKey)
	for _, name in pairs(ActiveSkillCOUtil.MODIFIABLE_FIELDS_NAMES) do
		if name == effectKey then
			return true
		end
	end

	return false
end

function ActiveSkillCOUtil.getTalentBaseId(heroId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)

	return characterCO.battleTalent[1] or 0
end

function ActiveSkillCOUtil.getTalentUnawakeId(heroId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)
	local battleTalent = characterCO.battleTalent

	return battleTalent[2] or battleTalent[1] or 0
end

function ActiveSkillCOUtil.getTalentAwakeId(heroId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)
	local battleTalent = characterCO.battleTalent

	return battleTalent[3] or battleTalent[2] or battleTalent[1] or 0
end

function ActiveSkillCOUtil.getSkillSignInfo(skillId, status)
	local spriteName
	local isSign = true
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if ActiveSkillCOUtil.isPassive(skillCOWrapper, status) then
		spriteName = "zd_label_0001"
	elseif ActiveSkillCOUtil.isSpecial(skillCOWrapper, status) then
		spriteName = "zd_label_0002"
	elseif ActiveSkillCOUtil.isTrump(skillCOWrapper, status) then
		spriteName = "zd_label_0003"
	else
		isSign = false
	end

	local result = {
		spriteName = spriteName,
		isSign = isSign
	}

	return result
end

return ActiveSkillCOUtil
