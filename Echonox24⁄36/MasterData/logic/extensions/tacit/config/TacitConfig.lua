-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tacit/config/TacitConfig.lua

module("logic.extensions.tacit.config.TacitConfig", package.seeall)

local M = class("TacitConfig", BaseConfig)

function M:onInit()
	self._cfgTacitArray = false
	self._cfgTacitLevel = false
	self._cfgTacitStage = false
	self._cfgTacitTask = false
end

function M:getNames()
	return {
		ConfigName.TacitArray,
		ConfigName.TacitLevel,
		ConfigName.TacitStage,
		ConfigName.TacitTask
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.TacitArray then
		self._cfgTacitArray = content
	elseif name == ConfigName.TacitLevel then
		self._cfgTacitLevel = content
	elseif name == ConfigName.TacitStage then
		self._cfgTacitStage = content
	elseif name == ConfigName.TacitTask then
		self._cfgTacitTask = content
	end
end

function M:getTacitCfg()
	return self._cfgTacitArray
end

function M:getTacitCO(code)
	return self._cfgTacitArray[code]
end

function M:getTacitStageCO(code)
	if self._cfgTacitStage[code] then
		return self._cfgTacitStage[code]
	end

	printError(string.format("could not found %s in [t_%s]", code, ConfigName.TacitStage))

	return nil
end

function M:getTacitMaxLevel()
	return TableUtil.getLen(self._cfgTacitLevel.dataList) - 1
end

function M:getCurLevelByExp(exp)
	for i = 0, self:getTacitMaxLevel() do
		if self._cfgTacitLevel and type(exp) == "number" and type(self._cfgTacitLevel[i].exp) == "number" and exp >= self._cfgTacitLevel[i].exp then
			if i == self:getTacitMaxLevel() then
				return i
			else
				local nextLevel = i + 1

				if self._cfgTacitLevel[nextLevel] and exp < self._cfgTacitLevel[nextLevel].exp then
					return i
				end
			end
		end
	end

	return 0
end

function M:getMaxExp()
	local maxLevel = self:getTacitMaxLevel()

	if self._cfgTacitLevel then
		return self._cfgTacitLevel[maxLevel].exp
	end

	return 0
end

function M:getUpgradeLevelExp(level)
	local maxLevel = self:getTacitMaxLevel()

	if level < maxLevel then
		return self._cfgTacitLevel[level + 1] and self._cfgTacitLevel[level + 1].exp or 0
	end

	return self._cfgTacitLevel[level] and self._cfgTacitLevel[level].exp or 0
end

function M:getCurMinExp(level)
	return self._cfgTacitLevel[level] and self._cfgTacitLevel[level].exp or 0
end

function M:getTacitTaskCO(code)
	return self._cfgTacitTask[code]
end

function M:getTalentSkillWakeUpCostItem(heroId)
	local cfg = self:getTacitCO(heroId)

	if not cfg then
		printError(string.format("无法在[t_%s]找到id[%s]的配置", ConfigName.TacitArray, heroId))

		cfg = self:getTacitCO(2000012)
	end

	local t = {}

	for s in string.gmatch(cfg.wakeupCost, "%d+") do
		table.insert(t, tonumber(s))
	end

	local itemId = t[1]
	local itemCount = t[2]

	return itemId, itemCount
end

M.instance = M.New()

return M
