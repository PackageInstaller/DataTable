-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/config/PlayerConfig.lua

module("logic.extensions.player.config.PlayerConfig", package.seeall)

local M = class("PlayerConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.PlayerLevel,
		ConfigName.PlayerCardAttributeTemplate,
		ConfigName.PlayerCreatePlot,
		ConfigName.PlayerCardAttributeMainline
	}
end

function M:getAttributeOfMainline()
	local dataList = self._dict[ConfigName.PlayerCardAttributeMainline].dataList

	return dataList
end

function M:getCreatePlot()
	local dataList = self._dict[ConfigName.PlayerCreatePlot].dataList

	return dataList
end

function M:getCreateInfoByAnswer(choice1, choice2)
	local dataList = self._dict[ConfigName.PlayerCardAttributeTemplate].dataList

	for i, v in ipairs(dataList) do
		local answers = v.answers

		if choice1 == answers[1] and choice2 == answers[2] then
			return v
		end
	end

	return dataList[1]
end

function M:getCreateInfo(id)
	local dataList = self._dict[ConfigName.PlayerCardAttributeTemplate].dataList

	for i, v in ipairs(dataList) do
		if id == v.id then
			return v
		end
	end

	return dataList[1]
end

function M:getAttrTemplateById(id)
	local attrList = self._dict[ConfigName.PlayerCardAttributeTemplate]

	return attrList and attrList[id]
end

function M:getMaxLevelInfo()
	local infoList = self._dict[ConfigName.PlayerLevel]
	local len = #infoList

	return infoList and infoList[len] or false
end

function M:getInfoByLevel(level)
	local infoList = self._dict[ConfigName.PlayerLevel]

	return infoList and infoList[level]
end

function M:getExpByLevel(level)
	local infoList = self._dict[ConfigName.PlayerLevel]

	if infoList and infoList[level] and infoList[level].exp then
		return infoList[level].exp
	end

	printError("无法找到角色升级配置", level)

	return 1
end

function M:calcLevelProgress(level, exp)
	local upgradeExp = self:getExpByLevel(level)

	return exp / upgradeExp
end

function M:getIncreaseExp(characterParam)
	if characterParam.newLevel == characterParam.oldLevel then
		return math.max(characterParam.newExp - characterParam.oldExp, 0)
	elseif characterParam.newLevel > characterParam.oldLevel then
		local levelTotalExp = 0

		for i = characterParam.oldLevel, characterParam.newLevel - 1 do
			levelTotalExp = levelTotalExp + self:getExpByLevel(i)
		end

		levelTotalExp = levelTotalExp - characterParam.oldExp
		levelTotalExp = levelTotalExp + characterParam.newExp

		return levelTotalExp
	else
		return 0
	end
end

M.instance = M.New()

return M
