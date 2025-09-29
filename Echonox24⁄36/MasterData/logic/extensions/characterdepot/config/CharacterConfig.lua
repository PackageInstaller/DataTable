-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/config/CharacterConfig.lua

module("logic.extensions.characterdepot.config.CharacterConfig", package.seeall)

local M = class("CharacterConfig", BaseConfig)
local kEmptyTable = {}

function M:onInit()
	self._cfgFightCapacityInfo = false
	self._cfgRunGroupMonsterInfo = false
	self._cfgSummon = false
end

function M:getNames()
	return {
		ConfigName.FightCapacity,
		ConfigName.CutRunGroupMonster,
		ConfigName.Summon
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.FightCapacity then
		self._cfgFightCapacityInfo = content
	elseif name == ConfigName.CutRunGroupMonster then
		self._cfgRunGroupMonsterInfo = content
	elseif name == ConfigName.Summon then
		self._cfgSummon = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getCharacterItemInfo(code)
	local info = BackpackConfig.instance:getCharacterConfig()

	return info[code]
end

function M:getCharacterDataList()
	return BackpackConfig.instance:getCharacterConfig().dataList
end

function M:getAllOnCharacterNum()
	local list = self:getAllOnlineCharacterConfig()

	if list then
		return #list
	end

	return 0
end

function M:getCharacterTags(code, onlyMain)
	if not self._characterTags then
		self._characterTags = {}
	end

	if not self._characterMainTags then
		self._characterMainTags = {}
	end

	if not self._characterTags[code] then
		self._characterMainTags[code] = {}

		local tags = {}
		local cfg = self:getCharacterItemInfo(code)

		if cfg then
			TableUtil.addRange(tags, cfg.tagMain or {})
			TableUtil.addRange(tags, cfg.tagSec or {})
			TableUtil.addRange(self._characterMainTags[code], cfg.tagMain or {})
		end

		self._characterTags[code] = tags
	end

	if onlyMain then
		return self._characterMainTags[code]
	end

	return self._characterTags[code]
end

function M:getCfgInfoByID(code, onlyForJudge)
	local dataCO = self:getCharacterItemInfo(code)

	if code > 0 and not dataCO and not onlyForJudge and enableErrorLog then
		printError(string.format("CharacterConfig::cannot find hero config for id[%s]", code))
	end

	return dataCO
end

function M:getAllOnlineCharacterConfig()
	local list = {}
	local characterCOList = self:getCharacterDataList()

	for k, v in pairs(characterCOList) do
		if v.isOnline == 1 then
			table.insert(list, v)
		end
	end

	return list
end

function M:getFragmentCfgByHeroId(heroId)
	local cfgList = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.HeroItemType)

	for _, cfg in ipairs(cfgList) do
		if cfg.heroId == heroId and cfg.subType == 2 then
			return cfg
		end
	end

	printWarn("没有该角色的碎片物品配置，角色id:", heroId)
end

function M:getFightRatioCo(code)
	if self._cfgFightCapacityInfo[code] then
		return self._cfgFightCapacityInfo[code]
	end

	printWarn("没有该角色使用的战力系数方案配置，方案code:", code)
end

function M:getRunGroupMonsterCo(code)
	if self._cfgRunGroupMonsterInfo[code] then
		return self._cfgRunGroupMonsterInfo[code]
	end

	printWarn("没有怪物配置，code:", code)
end

function M:getSummonMonsterCO(code)
	if self._cfgSummon[code] then
		return self._cfgSummon[code]
	end

	printWarn("没有召唤物配置，code:", code)
end

M.instance = M.New()

return M
