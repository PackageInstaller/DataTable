-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/hero/HeroHouseFeatureModel.lua

module("logic.extensions.house.model.hero.HeroHouseFeatureModel", package.seeall)

local M = class("HeroHouseFeatureModel", BaseModel)

function M:ctor()
	self._dictHeroFeature = {}
end

function M:onInit()
	table.clear(self._dictHeroFeature)
end

function M:onLateInit()
	return
end

function M:onReset()
	table.clear(self._dictHeroFeature)
end

function M:updateHeroFeatureByAgent(NO)
	local heroId = NO.heroId
	local mo = self._dictHeroFeature[heroId]

	if not mo then
		mo = HeroHouseFeatureMO.New(heroId)
		self._dictHeroFeature[heroId] = mo
	end

	mo:updateByAgent(NO)
end

function M:getFeatureMO(heroId)
	return self._dictHeroFeature[heroId]
end

function M:getFeatureSkillByHeroId(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	return self:getFeatureSkillByHeroMo(heroMO)
end

function M:getFeatureSkillByHeroMo(heroMO)
	local skillList = {}
	local defaultIds = heroMO:getDefaultHouseSkillIds()

	for _, skillId in ipairs(defaultIds) do
		table.insert(skillList, {
			isUnlock = true,
			skillId = skillId
		})
	end

	local nodes = HeroPowerConfig.instance:getCharacterAllNodeInfos(heroId)

	for _, nodeCO in ipairs(nodes) do
		local skills = nodeCO.houseSkill

		if skills and #skills > 0 then
			for _, skill in ipairs(skills) do
				local unlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(nodeCO.heroId, nodeCO.code)

				table.insert(skillList, {
					skillId = skill,
					isUnlock = unlock,
					nodeCO = nodeCO
				})
			end
		end
	end

	return skillList
end

function M:getHeroThoughtEduState(heroId)
	local state = HouseMainEnum.HeroThoughtEduState
	local heroFeatureMo = self:getFeatureMO(heroId)
	local formula = heroFeatureMo:getThoughtEduFormula()

	if formula > 0 then
		local cfgThoughtEdu = HouseConfig.instance:getConfigByKey(ConfigName.HouseThoughtEdu, formula)

		if cfgThoughtEdu then
			if cfgThoughtEdu.canEdu > 0 then
				return heroFeatureMo:getIsThoughtEdu() and state.CanWork or state.CanEdu
			else
				return state.RefuseWork
			end
		else
			printError(string.format("hero[%s],无法从[t_%s]找到[%s]的配置", heroId, ConfigName.HouseThoughtEdu, formula))

			return state.RefuseWork
		end
	else
		return state.CanWork
	end
end

M.instance = M.New()

return M
