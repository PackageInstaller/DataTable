-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/config/AchievementConfig.lua

module("logic.extensions.playerinfo.config.AchievementConfig", package.seeall)

local M = class("AchievementConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.AchievementLabel,
		ConfigName.Achievement,
		ConfigName.AchievementSkillLevel
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.AchievementLabel then
		self._achevevmentLableCfgs = content
	end

	if name == ConfigName.Achievement then
		self._achievementCfgs = content
	end

	if name == ConfigName.AchievementSkillLevel then
		self._achievementSkillLevelCfgs = content
	end
end

function M:getAllAchievementLabelCfgs()
	return self._achevevmentLableCfgs.dataList
end

function M:getAchievementLabelCO(id)
	local co = self._achevevmentLableCfgs.dataList[id]

	if co then
		return co
	end

	printError("can not find Achievement skill config id-->", id)
end

function M:getAllAchievementCfgs()
	return self._achievementCfgs.dataList
end

function M:getAchievementSkillLevelCfgs()
	return self._achievementSkillLevelCfgs.dataList
end

M.instance = M.New()

return M
