-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/config/BadgeConfig.lua

module("logic.extensions.badge.config.BadgeConfig", package.seeall)

local BadgeConfig = class("BadgeConfig", BaseConfig)

function BadgeConfig:onInit()
	BadgeConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function BadgeConfig:getNames()
	return {
		"badge_define",
		"badge_type",
		"badge_common",
		"badge_icon_group",
		"badge_level_plan_item",
		"badge_sorce"
	}
end

function BadgeConfig:handleConfig(name, content)
	if name == "badge_define" then
		for i, v in ipairs(content.dataList) do
			content[v.id].active = content[v.id].active == 1
		end

		self._define = content
	elseif name == "badge_type" then
		self._type = content
	elseif name == "badge_common" then
		self._common = content
	elseif name == "badge_icon_group" then
		self._iconGroup = content
	elseif name == "badge_level_plan_item" then
		self._levelPlan = content
	elseif name == "badge_sorce" then
		self._badge_sorce = content
	end
end

function BadgeConfig:getDefineById(id)
	return self._define[id]
end

function BadgeConfig:getDefine()
	return self._define.dataList
end

function BadgeConfig:getTypeById(id)
	return self._type[id]
end

function BadgeConfig:getType()
	return self._type
end

function BadgeConfig:getCommonValue(key)
	return self._common[key].value
end

function BadgeConfig:getIconGroup(iconGroupId)
	return self._iconGroup[iconGroupId]
end

function BadgeConfig:getLevelPlan(planId)
	return self._levelPlan[planId]
end

function BadgeConfig:getLevelCfg(planId, level)
	if self._levelPlan[planId] then
		return self._levelPlan[planId][level]
	end

	return nil
end

function BadgeConfig:getSourceCfg(id)
	return self._badge_sorce[id]
end

BadgeConfig.instance = BadgeConfig.New()

return BadgeConfig
