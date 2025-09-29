-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/model/authority/HeroPowerNodeMo.lua

module("logic.extensions.charactersystem.model.authority.HeroPowerNodeMo", package.seeall)

local M = class("HeroPowerNodeMo")
local json = require("cjson")
local kDefaultPowerLevel = 0
local PowerNodeEffectEnum = {
	HOUSE = 3,
	POWER_LEVEL_UP = 5,
	UNLOCK_DRAW = 6,
	ATTR_ADD = 1,
	UNLOCK_ROGUELIKE_SKILL = 7,
	SKILL_UPGRADE = 2,
	UNLOCK_TEXT = 4
}

function M:ctor()
	self._config = false
end

function M:setConfig(co)
	self._config = co
end

function M:getConfig(co)
	return self._config
end

function M:setHeroId(heroId)
	self._heroId = heroId
end

function M:getHeroId()
	return self._heroId
end

function M:setHeroData(heroData)
	self._heroData = heroData
end

function M:getHeroData()
	if not self._heroData then
		self._heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)
	end

	return self._heroData
end

function M:getIsUnlock()
	return CharacterAuthorityModel.instance:checkNodeIsUnlock(self._heroId, self._config.code)
end

function M:getAttr()
	local attrs = {}

	if not string.nilorempty(self._config.attrs) then
		local json = require("cjson")

		attrs = json.decode(self._config.attrs)
	end

	return attrs
end

function M:getPowerLevel()
	if self._powerLevel then
		return self._powerLevel
	end

	local normalNodes = HeroPowerConfig.instance:getCharacterNodeInfos(self._config.heroId)
	local extNodes = HeroPowerConfig.instance:getCharacterExtNodeInfos(self._config.heroId)

	self._powerLevel = kDefaultPowerLevel

	function isPowerLevelUp(config)
		for k, v in pairs(config.effect) do
			if v == PowerNodeEffectEnum.POWER_LEVEL_UP then
				return true
			end
		end

		return false
	end

	for k, v in pairs(normalNodes) do
		local co = HeroPowerConfig.instance:getNodeInfo(self._config.heroId, v.code)

		if v.code <= self._config.code and isPowerLevelUp(co) then
			self._powerLevel = self._powerLevel + 1
		end
	end

	for k, v in pairs(extNodes) do
		local co = HeroPowerConfig.instance:getNodeInfo(self._config.heroId, v.code)

		if v.code <= self._config.code and isPowerLevelUp(co) then
			self._powerLevel = self._powerLevel + 1
		end
	end

	return self._powerLevel
end

function M:getUnlockText()
	if self._unlockText then
		return self._unlockText
	end

	if self._config.effect then
		local hadUnlockText = false

		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.UNLOCK_TEXT then
				hadUnlockText = true

				local powerLevel = self:getPowerLevel()
				local contentConfig = CharacterUnlockContentConfig.instance:getPowerLevelUnlock(self._config.heroId, powerLevel)

				if contentConfig then
					local pastCO = PastInfoConfig.instance:getInfo(contentConfig.pastId)

					if pastCO then
						self._unlockText = {
							lang("tip_unlock_before_info"),
							pastCO.name
						}

						return self._unlockText
					end
				end
			end
		end
	end
end

function M:getSkillUnlockText()
	if self._skillUnlockText then
		return self._skillUnlockText
	end

	if self._config.effect then
		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.SKILL_UPGRADE then
				local skills = json.decode(self._config.skillEnchance)

				for k1, v1 in pairs(skills) do
					for k2, v2 in pairs(v1) do
						local skillId = tonumber(k2)
						local effectId = v2
						local config1001 = SkillEnhanceMO.New(skillId)

						config1001:addSkillEnhanceCode(effectId)
						config1001:rebuild()

						local skillCO = config1001:getSkillCO()
						local enchanceText = config1001:getDescription() or ""
						local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(effectId)

						enchanceText = skillEnhanceCOWrapper:getDescription()

						local showText = string.format("%s %s", skillCO.name, enchanceText)

						self._skillUnlockText = {
							string.format(lang("tip_skill_s"), skillCO.name),
							enchanceText
						}

						return self._skillUnlockText
					end
				end
			end
		end
	end
end

function M:getSkillId()
	if self._skillId then
		return self._skillId
	end

	if self._config.effect then
		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.SKILL_UPGRADE and not string.nilorempty(self._config.skillEnchance) then
				local skills = json.decode(self._config.skillEnchance)

				for k1, v1 in pairs(skills) do
					for k2, v2 in pairs(v1) do
						local skillId = tonumber(k2)

						self._skillId = skillId

						return skillId
					end
				end
			end
		end
	end
end

function M:getSkillEnhancedCode()
	if self._skillEnhancedCode then
		return self._skillEnhancedCode
	end

	if self._config.effect then
		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.SKILL_UPGRADE and not string.nilorempty(self._config.skillEnchance) then
				local skills = json.decode(self._config.skillEnchance)

				for k1, v1 in pairs(skills) do
					for k2, v2 in pairs(v1) do
						local effectId = tonumber(v2)

						self._skillEnhancedCode = effectId

						return effectId
					end
				end
			end
		end
	end
end

function M:getAddSkillId()
	local addSkillId = self._config.skillId

	return addSkillId
end

function M:getSkillEnhancedCodeBySkillId(pointSkillId)
	if self._config.effect then
		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.SKILL_UPGRADE then
				local skills = json.decode(self._config.skillEnchance)

				for k1, v1 in pairs(skills) do
					for k2, v2 in pairs(v1) do
						if pointSkillId and pointSkillId == tonumber(k2) then
							local effectId = tonumber(v2)

							return effectId
						else
							local effectId = tonumber(v2)

							return effectId
						end
					end
				end
			end
		end
	end
end

function M:getPowerLevelUpNum()
	if self._powerLvUpNum then
		return self._powerLvUpNum
	end

	if self._config.effect then
		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.POWER_LEVEL_UP then
				local powerLevel = self:getPowerLevel()
				local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(powerLevel, self:getHeroData():getQuality())
				local nextLevel = maxLevel - 10

				if powerLevel < 5 then
					nextLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(powerLevel, self:getHeroData():getQuality())
				else
					nextLevel = maxLevel
				end

				self._powerLvUpNum = nextLevel

				return nextLevel
			end
		end
	end
end

function M:getPowerLevelUpText()
	if self._powerLevelUpText then
		return self._powerLevelUpText
	end

	if self._config.effect then
		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.POWER_LEVEL_UP then
				local powerLevel = self:getPowerLevel()
				local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(powerLevel, self:getHeroData():getQuality())
				local nextLevel = maxLevel - 10

				if powerLevel < 5 then
					nextLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(powerLevel, self:getHeroData():getQuality())
				else
					nextLevel = maxLevel
				end

				local text = maxLevel <= nextLevel and string.format(lang("tip_level_max_up"), nextLevel) or string.format("%s", nextLevel)

				self._powerLevelUpText = {
					lang("tip_affinity_up"),
					text
				}

				return self._powerLevelUpText
			end
		end
	end
end

function M:getRunGroupSkillText()
	if self._runGroupSkillText then
		return self._runGroupSkillText
	end

	if self._config.effect then
		for k, v in pairs(self._config.effect) do
			if v == PowerNodeEffectEnum.UNLOCK_ROGUELIKE_SKILL then
				local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(self._config.heroId)
				local skillIds = {}
				local hadSkill = skillIds and #skillIds > 0
				local skillDesc = ""

				for k1, v1 in pairs(skillIds) do
					local effectCo = RoguelikeConfig.instance:getEffectById(v1)

					if effectCo then
						skillDesc = skillDesc .. effectCo.description .. " "
					end
				end

				if hadSkill then
					self._runGroupSkillText = {
						lang("梦境特性追加"),
						skillDesc
					}

					return self._runGroupSkillText
				end
			end
		end
	end
end

function M:getNodeDetailTextLst()
	if self._nodeDetailTextLst then
		return self._nodeDetailTextLst
	end

	local lst = {}
	local powerLvUpNum = self:getPowerLevelUpNum()

	if powerLvUpNum then
		table.insert(lst, {
			name = lang("tip_level_max_up_to"),
			val = string.format("Lv%s", powerLvUpNum)
		})
	end

	local attr = self:getAttr()

	for k, v in pairs(attr) do
		local attrCo = AttributeDefineConfig.instance:getAttributePartDefineCO(tonumber(v.key))
		local showName = attrCo.name or ""
		local showValue = attrCo.isFloat == 1 and string.format("%d%%", v.value * 100) or v.value

		table.insert(lst, {
			name = showName,
			val = string.format("+%s", showValue)
		})
	end

	self._nodeDetailTextLst = lst

	return self._nodeDetailTextLst
end

function M:getNodeDetailSkillLst()
	if self._nodeDetailSkillLst then
		return self._nodeDetailSkillLst
	end

	local lst = {}

	if self:getAddSkillId() > 0 then
		local skillEnhanceMO = SkillEnhanceMO.getSharedMO(self:getAddSkillId())

		skillEnhanceMO:rebuild()

		local skillCO = skillEnhanceMO:getSkillCO()

		table.insert(lst, {
			name = skillCO.name,
			desc = skillEnhanceMO:getDescription(),
			icon = ActiveSkillCOUtil.getSkillIcon(skillCO)
		})
		SkillEnhanceMO.releaseSharedMO(skillEnhanceMO)
	end

	local markSkillUpgrade = self._config.effect and #self._config.effect > 0 and table.indexof(self._config.effect, PowerNodeEffectEnum.SKILL_UPGRADE)

	markSkillUpgrade = true

	if markSkillUpgrade and not string.nilorempty(self._config.skillEnchance) then
		local skills = json.decode(self._config.skillEnchance)

		for k1, v1 in pairs(skills) do
			for k2, v2 in pairs(v1) do
				local skillId = tonumber(k2)
				local effectId = v2
				local config1001 = SkillEnhanceMO.New(skillId)

				config1001:addSkillEnhanceCode(effectId)
				config1001:rebuild()

				local skillCO = config1001:getSkillCO()
				local enchanceText = config1001:getDescription() or ""
				local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(effectId)

				enchanceText = skillEnhanceCOWrapper:getDescription()

				table.insert(lst, {
					name = skillCO.name,
					desc = enchanceText,
					icon = ActiveSkillCOUtil.getSkillIcon(skillCO)
				})
			end
		end
	end

	self._nodeDetailSkillLst = lst

	return self._nodeDetailSkillLst
end

function M:getNodeUnlockCostEnough()
	local cost = self:getConfig().cost
	local itemEnough = true
	local lzbEnough = true

	if cost then
		for i = 1, #cost do
			local curNum = ItemModel.instance:getItemCountByItemId(cost[i].id)

			if curNum < cost[i].num then
				if cost[i].id == GameEnum.CurrencyCodeEnum.LzbCode then
					lzbEnough = false
				else
					itemEnough = false
				end
			end
		end
	end

	return itemEnough and lzbEnough
end

function M:isUnlockSkill()
	return (self:getAddSkillId() or 0) > 0
end

function M:isEnhanceSkill()
	return (self:getSkillEnhancedCode() or 0) > 0
end

return M
