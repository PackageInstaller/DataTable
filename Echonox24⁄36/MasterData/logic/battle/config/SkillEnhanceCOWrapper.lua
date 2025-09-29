-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/SkillEnhanceCOWrapper.lua

module("logic.battle.config.SkillEnhanceCOWrapper", package.seeall)

local SkillEnhanceCOWrapper = class("SkillEnhanceCOWrapper")

function SkillEnhanceCOWrapper:ctor(skillEnhanceCO)
	if not skillEnhanceCO then
		return
	end

	self._skillEnhanceCO = skillEnhanceCO
	self._enhanceKeyToValueList = {}

	self:_parseConfig()

	local description = self:_buildSkillEnhanceDescription()

	self._coloredDescription = ActiveSkillCOUtil.replaceDescriptionSpecialColor(description)
	self._colourlessDescription = ActiveSkillCOUtil.removeDescriptionSpecialColor(description)
end

function SkillEnhanceCOWrapper:getSkillEnhanceCO()
	return self._skillEnhanceCO
end

function SkillEnhanceCOWrapper:getCode()
	return self._skillEnhanceCO.code
end

function SkillEnhanceCOWrapper:getName()
	return self._skillEnhanceCO.name
end

function SkillEnhanceCOWrapper:getOriginDesc()
	return self._skillEnhanceCO.modDesc
end

function SkillEnhanceCOWrapper:getDescription(isColored)
	return isColored and self._coloredDescription or self._colourlessDescription
end

function SkillEnhanceCOWrapper:isAddEnhance()
	if not self._skillEnhanceCO then
		return false
	end

	return self._skillEnhanceCO.upgradeType == 2
end

function SkillEnhanceCOWrapper:getAllEnhanceParams(status)
	return self._enhanceKeyToValueList and self._enhanceKeyToValueList[status] or {}
end

function SkillEnhanceCOWrapper:_parseConfig()
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._skillEnhanceCO.skillCode)

	self._enhanceKeyToValueList[BattleEnum.SkillStatus.Normal] = {}

	self:_parseStatusConfig(BattleEnum.SkillStatus.Normal, self._skillEnhanceCO.normalConfig)

	if skillCOWrapper:hasStrenthening() then
		self._enhanceKeyToValueList[BattleEnum.SkillStatus.Strenthening] = {}

		self:_parseStatusConfig(BattleEnum.SkillStatus.Strenthening, self._skillEnhanceCO.godlikeConfig)
	end
end

function SkillEnhanceCOWrapper:_parseStatusConfig(status, enhanceConfig)
	if self:isAddEnhance() then
		local addEffect = enhanceConfig.addEffect

		self._enhanceKeyToValueList[status].addEffect = addEffect
	else
		local modList = enhanceConfig.modList

		for i, mod in ipairs(modList) do
			local effects = string.split(mod.effectStr, "#")

			for _, effect in ipairs(effects) do
				local strTemp = string.split(effect, ":")
				local modifyKey = string.format("%s_%s", mod.type, strTemp[1])

				self._enhanceKeyToValueList[status][modifyKey] = checknumber(strTemp[2])
			end
		end
	end
end

function SkillEnhanceCOWrapper:_buildSkillEnhanceDescription()
	local function replaceDescFunction(descPatternResult)
		local floatValue
		local percentCount = ActiveSkillCOUtil.calculatePercentCount(descPatternResult)
		local matchContent = ActiveSkillCOUtil.getContentFromDescPatternResult(descPatternResult, percentCount)
		local status = BattleEnum.SkillStatus.Normal

		if string.find(matchContent, "godlike") then
			status = BattleEnum.SkillStatus.Strenthening
			matchContent = string.sub(matchContent, 8, -1)
		end

		if string.find(matchContent, "add") then
			floatValue = self:_getAddEffectValueByKey(matchContent, status)
		else
			floatValue = self._enhanceKeyToValueList[status][matchContent]
		end

		if not floatValue then
			printError("技能描述解析失败:", descPatternResult)

			floatValue = 0
		end

		return string.format("$%s$", ActiveSkillCOUtil.formatValueByPercentCount(floatValue, percentCount))
	end

	local skillEnhanceCO = self:getSkillEnhanceCO()
	local description = skillEnhanceCO.modDesc

	description = string.gsub(description, ActiveSkillCOUtil.REGEX_DESC, replaceDescFunction)
	description = ActiveSkillCOUtil.buildBuffAndTagDesc(description)

	return description
end

function SkillEnhanceCOWrapper:getDescriptionHighLightTag(tagIds)
	local len = tagIds and #tagIds or 0

	if len == 0 then
		return self:getDescription()
	end

	local function replaceDescFunction(descPatternResult)
		local floatValue
		local percentCount = ActiveSkillCOUtil.calculatePercentCount(descPatternResult)
		local matchContent = ActiveSkillCOUtil.getContentFromDescPatternResult(descPatternResult, percentCount)
		local status = string.find(matchContent, "godlike") and BattleEnum.SkillStatus.Strenthening or BattleEnum.SkillStatus.Normal

		if string.find(matchContent, "add") then
			floatValue = self:_getAddEffectValueByKey(matchContent, status)
		else
			floatValue = self._enhanceKeyToValueList[status][matchContent]
		end

		if not floatValue then
			printError("技能描述解析失败:", descPatternResult)

			floatValue = 0
		end

		return string.format("$%s$", ActiveSkillCOUtil.formatValueByPercentCount(floatValue, percentCount))
	end

	local skillEnhanceCO = self:getSkillEnhanceCO()
	local description = skillEnhanceCO.modDesc

	description = string.gsub(description, ActiveSkillCOUtil.REGEX_DESC, replaceDescFunction)
	description = ActiveSkillCOUtil.buildBuffAndTagDesc(description, nil, nil, tagIds)

	return description
end

function SkillEnhanceCOWrapper:_getAddEffectValueByKey(keyStr, status)
	local addEffect = status == BattleEnum.SkillStatus.Strenthening and self._skillEnhanceCO.godlikeConfig.addEffect or self._skillEnhanceCO.normalConfig.addEffect
	local strList = string.split(keyStr, "_")
	local actionOrConditionIndex = checkint(string.split(strList[2], "-")[2])
	local paramList = {}

	for i = 3, #strList do
		local strs = string.split(strList[i], "-")

		table.insert(paramList, strs[1])

		if #strs > 1 then
			table.insert(paramList, checkint(strs[2]))
		end
	end

	if string.find(strList[2], "action") then
		local temp = addEffect.actionList[actionOrConditionIndex]

		for i, v in ipairs(paramList) do
			temp = temp[v]
		end

		return temp
	elseif string.find(strList[2], "condition") then
		local temp = addEffect.conditionList[actionOrConditionIndex]

		for i, v in ipairs(paramList) do
			temp = temp[v]
		end

		return temp
	else
		printError("问题配置keyStr", keyStr, strList[2])
	end
end

return SkillEnhanceCOWrapper
