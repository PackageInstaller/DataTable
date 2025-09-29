-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/ActiveSkillConfig.lua

module("logic.battle.config.ActiveSkillConfig", package.seeall)

local ActiveSkillConfig = class("ActiveSkillConfig", BaseConfig)
local kEmptyList = {}
local skill

function ActiveSkillConfig:onInit()
	self._cfgEffectOccasion = false
	self._cfgEffectAction = false
	self._cfgEffectCondition = false
	self._skill2EnhanceTable = {}
	self._skillCOWrapperTable = {}
	self._skillEnhanceCOWrapperTable = {}

	self:_transLang()

	self._cfgSkillEnhance = {}

	self:_buildSkill2EnhanceTable()
end

function ActiveSkillConfig:_transLang()
	self._cfgSkill = require("logic.config.skilleditor.t_export_skill")
	self._cfgSkillTag = require("logic.config.skilleditor.t_export_skill_tag")
	self._langCfgSkill = require("logic.config.t_lang_skill")

	self:_lang(self._cfgSkill.configData)

	self._langCfgSkill = false

	self:_buildTag()
end

function ActiveSkillConfig:_buildTag()
	self._tagDescKey2TagId = {}

	for k, v in pairs(self._cfgSkillTag.configData) do
		self._tagDescKey2TagId[v.skillDescKey] = v.id
	end

	self._tagKey2IconName = {
		Poise = "bqtb20006",
		Chase = "bqtb30001",
		Rush = "bqtb20005",
		IsolatedForce = "bqtb20003",
		ArcLight = "bqtb30004",
		LowHp = "bqtb20001",
		BoreSpine = "bqtb30005",
		Bomb = "bqtb30003",
		Suppress = "bqtb20007",
		MoonRing = "bqtb30002",
		Assist = "bqtb30006",
		Frenzied = "bqtb20008",
		Sanity = "bqtb20009",
		Snipe = "bqtb30007",
		Synergy = "bqtb20004"
	}
	self._tagKey2BigIconName = {
		Poise = "20006",
		Chase = "30001",
		Rush = "20005",
		IsolatedForce = "20003",
		ArcLight = "30004",
		LowHp = "20001",
		BoreSpine = "30005",
		Bomb = "30003",
		Suppress = "20007",
		MoonRing = "30002",
		Assist = "30006",
		Frenzied = "20008",
		Sanity = "20009",
		Snipe = "30007",
		Synergy = "20004"
	}
end

function ActiveSkillConfig:_lang(configTable)
	for k, v in pairs(configTable) do
		if TypeUtil.isString(v) then
			if string.find(v, "skill_lang_") then
				configTable[k] = self._langCfgSkill[v].zh
			end
		elseif TypeUtil.isTable(v) then
			self:_lang(v)
		end
	end
end

function ActiveSkillConfig:getNames()
	return {
		ConfigName.SkillEffectOccasion,
		ConfigName.SkillEffectAction,
		ConfigName.SkillEffectCondition
	}
end

function ActiveSkillConfig:handleConfig(name, content)
	if name == ConfigName.SkillEffectOccasion then
		self._cfgEffectOccasion = content
	elseif name == ConfigName.SkillEffectAction then
		self._cfgEffectAction = content
	elseif name == ConfigName.SkillEffectCondition then
		self._cfgEffectCondition = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function ActiveSkillConfig:handleEditor(name, content)
	return
end

function ActiveSkillConfig:getActiveSkillCO(code, noLog)
	local skillCO = self._cfgSkill[code]

	if code > 0 and not skillCO and not noLog and BattleLog.enableError then
		BattleLog.error(string.format("ActiveSkillConfig::cannot find skill config for code[%s]", code))
	end

	return skillCO
end

function ActiveSkillConfig:getActiveSkillCOWrapper(code)
	if not code or code <= 0 then
		return false
	end

	local skillCOWrapper = self._skillCOWrapperTable[code]

	if not skillCOWrapper then
		local skillCO = self:getActiveSkillCO(code)

		skillCOWrapper = ActiveSkillCOWrapper.New(skillCO)
		self._skillCOWrapperTable[code] = skillCOWrapper
	end

	return skillCOWrapper
end

function ActiveSkillConfig:getSkillEffectOccasionCO(code)
	local skillEffectOccasionCO = self._cfgEffectOccasion[code]

	if code > 0 and not skillEffectOccasionCO and BattleLog.enableError then
		BattleLog.error(string.format("ActiveSkillConfig::cannot find skill effect occasion config for code[%s]", code))
	end

	return skillEffectOccasionCO
end

function ActiveSkillConfig:getSkillEffectActionCO(code)
	local skillEffectActionCO = self._cfgEffectAction[code]

	if code > 0 and not skillEffectActionCO and BattleLog.enableError then
		BattleLog.error(string.format("ActiveSkillConfig::cannot find skill effect action config for code[%s]", code))
	end

	return skillEffectActionCO
end

function ActiveSkillConfig:getSkillEffectConditionCO(code)
	local skillEffectConditionCO = self._cfgEffectCondition[code]

	if code > 0 and not skillEffectConditionCO and BattleLog.enableError then
		BattleLog.error(string.format("ActiveSkillConfig::cannot find skill effect condition config for code[%s]", code))
	end

	return skillEffectConditionCO
end

function ActiveSkillConfig:getSkillEnhanceCO(code)
	local skillEnhance = self._cfgSkillEnhance[code]

	if code > 0 and not skillEnhance and BattleLog.enableError then
		BattleLog.error(string.format("ActiveSkillConfig::cannot find skill enhance config for code[%s]", code))
	end

	return skillEnhance
end

function ActiveSkillConfig:getSkillEnhanceCOWrapper(code)
	local skillEnhanceCOWrapper = self._skillEnhanceCOWrapperTable[code]

	if not skillEnhanceCOWrapper then
		local skillEnhaceCO = self:getSkillEnhanceCO(code)

		skillEnhanceCOWrapper = SkillEnhanceCOWrapper.New(skillEnhaceCO)
		self._skillEnhanceCOWrapperTable[code] = skillEnhanceCOWrapper
	end

	return skillEnhanceCOWrapper
end

function ActiveSkillConfig:getEnhanceCodesOfSkill(skillCode)
	local resultList = self._skill2EnhanceTable[skillCode]

	return resultList or kEmptyList
end

function ActiveSkillConfig:getSkillTagCO(tagCode)
	return self._cfgSkillTag[tagCode]
end

function ActiveSkillConfig:getSkillTagCOList()
	return self._cfgSkillTag.configData
end

function ActiveSkillConfig:getSkillTagIdByDescKey(key)
	return self._tagDescKey2TagId[key]
end

function ActiveSkillConfig:getTagIconName(tagTypeName)
	return self._tagKey2IconName[tagTypeName]
end

function ActiveSkillConfig:getTagBigIconName(tagTypeName)
	return self._tagKey2BigIconName[tagTypeName]
end

function ActiveSkillConfig:_buildSkill2EnhanceTable()
	local dataList = self._cfgSkill.configData

	for _, skillCO in ipairs(dataList) do
		local enhanceCOList = skillCO.enhance

		for i, enhanceCO in ipairs(enhanceCOList) do
			self._cfgSkillEnhance[enhanceCO.code] = enhanceCO

			local enhanceCodeList = self._skill2EnhanceTable[enhanceCO.skillCode]

			if not enhanceCodeList then
				enhanceCodeList = {}
				self._skill2EnhanceTable[enhanceCO.skillCode] = enhanceCodeList
			end

			table.insert(enhanceCodeList, enhanceCO.code)
		end
	end
end

ActiveSkillConfig.instance = ActiveSkillConfig.New()

return ActiveSkillConfig
